@extends('layout')

@section('content')


<h1>LIST OF ACTIVE ORDERS</h1>

@can('add project')
  <div class="new_project">
    <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>&nbsp;Add New Order</button>
  </div>

  <!-- Modal -->
  <div id="myModal" class="modal fade" role="dialog">
    <div class="modal-dialog">

      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Enter Order Title</h4>
        </div>
        <div class="modal-body">
          <form id="project_form" action="{{ route('project.store') }}" method="POST">
              {{ csrf_field() }}

          <div class="row">
              <div class="col-md-12">
              <div class="form-group">
                <input type="text" class="form-control" id="project" name="project">
              </div>
            </div>

          </div>

          <div class="modal-footer">
            <input class="btn btn-primary" type="submit" value="Submit" >
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </div>

          </form>
        </div>

      </div>

    </div>
  </div>
  <!--  END modal  -->
@endcan


<div class="table-responsive">
<table class="table table-striped">
    <thead>
      <tr>
        <th>Order Name</th>
        <th>Order Tasks List</th>
        <th>Actions</th>
      </tr>
    </thead>

@if ( !$projects->isEmpty() )
    <tbody>
    @foreach ( $projects  as $project)
      <tr>
        <td>{{ $project->project_name }} </td>
        <td>
           <a href="{{ route('task.list', [ 'projectid' => $project->id ]) }}">List all tasks</a>
        </td>
        <td>
        @can('edit project')
          <a class="btn btn-primary" href="{{ route('project.edit', [ 'id' => $project->id ]) }}"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
        @endcan
        @can('delete project')
          <a class="btn btn-danger" href="{{ route('project.delete', [ 'id' => $project->id ]) }}" Onclick="return ConfirmDelete();"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></a>&nbsp;&nbsp;
        @endcan
        </td>

      </tr>

    @endforeach
    </tbody>
@else
    <p><em>There are no tasks assigned yet</em></p>
@endif


</table>
</div>




@stop


<script>

function ConfirmDelete()
{
  var x = confirm("Are you sure? Deleting a Order will also delete all tasks associated with this order");
  if (x)
      return true;
  else
    return false;
}




</script>
