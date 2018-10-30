<?php

namespace App\Http\Controllers;

use Session;
use Illuminate\Http\Request;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;
use App\Task;
use App\User;
use App\Project;

class UserController extends Controller
{

    function __construct()
    {
      $this->middleware('permission:view user');
      $this->middleware('permission:add user', ['only' => ['create','store']]);
      $this->middleware('permission:edit user', ['only' => ['edit','update']]);
      $this->middleware('permission:delete user', ['only' => ['destroy']]);
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $users = User::all() ;
        $roles = Role::all();

        return view('user.index', compact('users', 'roles'));
    }

    public function create()
    {
        $roles = Role::get();
        return view('user.create', ['roles' =>$roles]);
    }

    public function store(Request $request)
    {
        $rules = [
            'name'     => 'required',
            'email'    => 'required|email|unique:users',
            'admin'    => 'required',
            'password' => 'required',
            'role_id' => 'int'
        ] ;

        $messages = [
            'name.required'     =>  'Enter the user full name',
            'email.required'    =>  'Enter the user email',
            'password.required' =>  'Enter user password'
        ] ;

        $this->validate($request, $rules, $messages) ;


        $user = User::create([
            'name'     => $request->name,
            'email'    => $request->email,
            'admin'    => $request->admin,
            'password' => bcrypt($request->password) ,
        ]);

        $roleId = $request['role_id'];
        if (empty($roleId)===false) {
            $role_r = Role::where('id', '=', $roleId)->firstOrFail();
            $user->assignRole($role_r); //Assigning role to user
        }

        Session::flash('success', 'User Dibuat') ;
        return redirect()->route('user.index');
    }


    public function edit($id)
    {
        $user = User::find($id);
        $roles = Role::get();
        return view('user.edit', compact('user', 'roles'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $update_user = User::find($id) ;
        $update_user->name  = $request->name;
        $update_user->email = $request->email;
        if ($request->has('password') ) $update_user->password = bcrypt($request->password) ;
        $roles = $request['role_id'];

        $update_user->save();

        if (isset($roles)) {
            $update_user->roles()->sync($roles);
        }
        else {
            $update_user->roles()->detach();
        }

	    $reset_demo = User::find(5) ;
	    $reset_demo->admin = 1 ;
	    $reset_demo->name = 'Admin' ;
	    $reset_demo->email = 'admin@app.com' ;
	    $reset_demo->password = bcrypt('adminapp..') ;
	    $reset_demo->save() ;

        Session::flash('success', 'User sukses diedit') ;
        return redirect()->route('user.index') ;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $delete_user = User::find($id) ;
        if ( $delete_user->id == 5 ) {
	        Session::flash('error', 'Error, Admin tidak bisa dihapus') ;
	        return redirect()->back();
        }
        $delete_user->delete() ;
        Session::flash('success', 'User dihapus') ;
        return redirect()->back();
    }


    public function activate($id) {

        $user = User::find($id) ;
        $user->admin = 1;
        $user->save() ;
        // return "USER WITH ID: $id  is now active"  ;
        return redirect()->back() ;
    }

    public function disable($id) {

        $user = User::find($id) ;

        if ( $user->id == 5 ) {
	        Session::flash('error', 'Error, Admin tidak bisa di disable') ;
	        return redirect()->back();
        }
        $user->admin = 0;
        $user->save() ;

		Session::flash('success', 'User di disable') ;
        return redirect()->back() ;
    }

    public function userTaskList($id) {

        $username = User::find($id) ;
        $task_list = Task::where('user_id','=' , $id)->get();
        return view('user.list', compact('task_list', 'username') ) ;
    }

}
