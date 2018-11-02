<?php
namespace App\Http\Controllers;

use Session;
use Illuminate\Http\Request;
use App\Project;
use App\Task;
use App\TaskFiles;
use App\User;

use Illuminate\Support\Facades\Input;

class TaskController extends Controller
{

    function __construct()
    {
         $this->middleware('permission:view task');
         $this->middleware('permission:add task', ['only' => ['create','store']]);
         $this->middleware('permission:edit task', ['only' => ['edit','update']]);
         $this->middleware('permission:delete task', ['only' => ['destroy']]);
    }

    public function index()
    {
        $users =  User::all();
        $tasks  = Task::orderBy('created_at', 'asc')->paginate(20);

        return view('task.tasks')->with('tasks', $tasks)
                                 ->with('users', $users );
    }

    public function tasklist( $projectid )
    {
        $users =  User::all();
        $p_name = Project::find($projectid);
        $task_list = Task::where('project_id','=' , $projectid)->get();

        return view('task.list')->with('users', $users)
                                ->with('p_name', $p_name)
                                ->with('task_list', $task_list);
    }

    public function view($id)
    {
        $images_set = [];
        $files_set = [];
        $images_array = ['png','gif','jpeg','jpg'];
        $taskfiles = TaskFiles::where('task_id', $id )->get();

        if ( count($taskfiles) > 0 ) {
            foreach ( $taskfiles as $taskfile ) {
                $taskfile = explode(".", $taskfile->filename );
                if ( in_array($taskfile[1], $images_array ) )
                    $images_set[] = $taskfile[0] . '.' . $taskfile[1];
                else
                    $files_set[] = $taskfile[0] . '.' . $taskfile[1];
            }
        }

        $task_view = Task::find($id);

        $from = \Carbon\Carbon::createFromFormat('Y-m-d H:i:s', $task_view->created_at);
        $to   = \Carbon\Carbon::createFromFormat('Y-m-d H:i:s', $task_view->duedate );

        $current_date = \Carbon\Carbon::now();

        $formatted_from = $from->toRfc850String();
        $formatted_to   = $to->toRfc850String();

        $diff_in_days = $current_date->diffInDays($to);

        $is_overdue = ($current_date->gt($to) ) ? true : false ;

        $projects = Project::all();
        return view('task.view')
            ->with('task_view', $task_view)
            ->with('projects', $projects)
            ->with('taskfiles', $taskfiles)
            ->with('diff_in_days', $diff_in_days )
            ->with('is_overdue', $is_overdue)
            ->with('formatted_from', $formatted_from )
            ->with('formatted_to', $formatted_to )
            ->with('images_set', $images_set)
            ->with('files_set', $files_set);
    }

    public function sort( $key )
    {
        $users = User::all();
        switch($key) {
            case 'task':
                $tasks = Task::orderBy('task')->paginate(10);
            break;
            case 'priority':
                $tasks = Task::orderBy('priority')->paginate(10);
            break;
            case 'completed':
                $tasks = Task::orderBy('completed')->paginate(10);
            break;
        }

        return view('task.tasks')->with('users', $users)
                                ->with('tasks', $tasks);
    }

    public function create()
    {
        $projects = Project::all();
        $users = User::all();
        return view('task.create')->with('projects', $projects)
                                  ->with('users', $users);
    }

    public function store(Request $request)
    {
        $this->validate( $request, [
          'task_title' => 'required',
          'task'       => 'required',
          'project_id' => 'required|numeric',
          'photos.*'   => 'sometimes|required|mimes:png,gif,jpeg,jpg,txt,pdf,doc',  // photos is an array: photos.*
          'duedate'    => 'required'
        ]);

        $task = Task::create([
          'project_id' => $request->project_id,
          'user_id'    => $request->user,
          'task_title' => $request->task_title,
          'task'       => $request->task,
          'priority'   => $request->priority,
          'duedate'    => $request->duedate
        ]);

          if( $request->hasFile('photos') ) {
            foreach ($request->photos as $file) {
                $filename = strtr( pathinfo( time() . '_' . $file->getClientOriginalName(), PATHINFO_FILENAME) , [' ' => '', '.' => ''] ) . '.' . pathinfo($file->getClientOriginalName(), PATHINFO_EXTENSION);
                $file->move('images',$filename);

                TaskFiles::create([
                    'task_id'  => $task->id,
                    'filename' => $filename
                ]);
              }
            }

            Session::flash('success', 'Task Created');
            return redirect()->route('task.show');
        }

    public function completed($id)
    {
        $task_complete = Task::find($id);
        $task_complete->completed = 1;
        $task_complete->save();
        return redirect()->back();
    }

    public function edit($id)
    {
        // $task_list = Task::where('project_id','=' , $projectid)->get();
        $task = Task::find($id)  ;
        $taskfiles = TaskFiles::where('task_id', '=', $id)->get() ;
        // dd($taskfiles) ;
        $projects = Project::all() ;
        $users = User::all() ;

        return view('task.edit')->with('task', $task)
                                ->with('projects', $projects )
                                ->with('users', $users)
                                ->with('taskfiles', $taskfiles);
    }

/*===============================================
    UPDATE TASK
===============================================*/
    public function update(Request $request, $id)
    {
        // dd( $request->all() ) ;
        $update_task = Task::find($id) ;

        $this->validate( $request, [
            'task_title' => 'required',
            'task'       => 'required',
            'project_id' => 'required|numeric',
            'photos.*'   => 'sometimes|required|mimes:png,gif,jpeg,jpg,txt,pdf,doc' // photos is an array: photos.*
        ]) ;

        $update_task->task_title = $request->task_title;
        $update_task->task       = $request->task;
        $update_task->user_id    = $request->user_id;
        $update_task->project_id = $request->project_id;
        $update_task->priority   = $request->priority;
        $update_task->completed  = $request->completed;
        $update_task->duedate    = $request->duedate;

        if( $request->hasFile('photos') ) {
            foreach ($request->photos as $file) {
                // remove whitespaces and dots in filenames : [' ' => '', '.' => '']
                $filename = strtr( pathinfo( time() . '_' . $file->getClientOriginalName(), PATHINFO_FILENAME) , [' ' => '', '.' => ''] ) . '.' . pathinfo($file->getClientOriginalName(), PATHINFO_EXTENSION);

                $file->move('images',$filename);

                // save to DB
                TaskFiles::create([
                    'task_id'  => $request->task_id,
                    'filename' => $filename  // For Regular Public Images
                ]);
            }
        }

        $update_task->save() ;

        Session::flash('success', 'Task was sucessfully edited') ;
        return redirect()->route('task.show') ;
    }

/*===============================================
    DESTROY TASK
===============================================*/
    public function destroy($id)
    {
        $delete_task = Task::find($id) ;
        $delete_task->delete() ;
        Session::flash('success', 'Task was deleted') ;
        return redirect()->back();
    }

/*===============================================
    DELETE FILE
===============================================*/
    public function deleteFile($id) {
        $delete_file = TaskFiles::find($id) ;
        // remove  file from public directory
        unlink( public_path() . '/images/' . $delete_file->filename ) ;

        // delete entry from database
        $delete_file->delete() ;
        Session::flash('success', 'File Deleted') ;
        return redirect()->back();
    }

/*===============================================
    SEARCH TASK
===============================================*/
    public function searchTask()
    {
        $users = User::all();
        $value = Input::get('task_search');
        $tasks = Task::join('users', 'user_id', '=', 'users.id')->where('task_title', 'LIKE', '%' . $value . '%')
        ->orWhere('name', 'LIKE', '%' . $value . '%')->limit(25)->get();
        return view('task.search')->with('value', $value)
                                  ->with('tasks', $tasks)
                                  ->with('users', $users) ;
    }

}
