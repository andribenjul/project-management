@extends('layout')

@section('content')

<h1>Order Task List:  "{{ $p_name->project_name }}" </h1>

<table class="table table-striped">
    <thead>
      <tr>
        <th>Judul Task</th>
        <th>Nama Order</th>
        <th>Prioritas</th>
        <th>Status</th>
        <th>Aksi</th>
      </tr>
    </thead>

@if ( !$task_list->isEmpty() )
    <tbody>
    @foreach ( $task_list as $task)
      <tr>
        <td>{{ $task->task_title }} </td>
        <td>{{ $task->project->project_name }}</td>
        <td>
            @if ( $task->priority == 0 )
                <span class="label label-info">Normal</span>
            @else
                <span class="label label-danger">Mendesak</span>
            @endif
        </td>
        <td>
            @if ( !$task->completed )
                <a href="{{ route('task.completed', ['id' => $task->id]) }}" class="btn btn-warning"> Tandai jika sudah selesai</a>
            @else
                <span class="label label-success">Selesai</span>
            @endif
        </td>
        <td>
          @can('edit task')
            <!-- <a href="{{ route('task.edit', ['id' => $task->id]) }}" class="btn btn-primary"> edit </a> -->
          @endcan

            <a href="{{ route('task.view', ['id' => $task->id]) }}" class="btn btn-primary"> <span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span> </a>

          @can('delete task')
            <a href="{{ route('task.delete', ['id' => $task->id]) }}" class="btn btn-danger"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></a>
          @endcan
        </td>
      </tr>

    @endforeach
    </tbody>
@else
    <p><em>Tidak ada tugas</em></p>
@endif


</table>



<div class="btn-group">
    <a class="btn btn-default" href="{{ redirect()->getUrlGenerator()->previous() }}">Kembali</a>
</div>




@stop
