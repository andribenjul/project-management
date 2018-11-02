<?php

namespace App\Http\Controllers;

use Session;
use Illuminate\Http\Request;
use App\Project;
use App\Task;


class ProjectController extends Controller
{

    function __construct()
    {
      $this->middleware('permission:view project');
      $this->middleware('permission:add project', ['only' => ['create','store']]);
      $this->middleware('permission:edit project', ['only' => ['edit','update']]);
      $this->middleware('permission:delete project', ['only' => ['destroy']]);
    }


    public function index()
    {
        $projects = Project::all();
        return view('project.projects')->with('projects', $projects);
    }

    public function create()
    {
        return view('project.create');
    }

    public function store(Request $request)
    {
            $project_new = new Project;
            $project_new->project_name = $request->project;
            $project_new->save();

            Session::flash('success', 'Project Created');
            return redirect()->route('project.show');
    }

    public function show($id)
    {
        //
    }

    public function edit($id)
    {
        $edit_project =  Project::find($id);
        return view('project.edit')->with('edit_project', $edit_project);
    }

    public function update(Request $request, $id)
    {
        $update_project = Project::find($id);
        $update_project->project_name = $request->name;
        $update_project->save();
        
        Session::flash('success', 'Project was sucessfully edited');
        return redirect()->route('project.show');
    }

    public function destroy($id)
    {
        $delete_project = Project::find($id);
        $delete_project->delete();

        Session::flash('success', 'Project was deleted and tasks associated with it');
        return redirect()->back();
    }

}
