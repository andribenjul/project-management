@extends('layout')

@section('content')

<!--   /views/task/task/tasks.blade.php   -->
<div class="row">
    <div class="col-md-6">
        <h1>ALL TASKS</h1>
    </div>

    <div class="col-md-6">

        <!-- search form (Optional) -->

      <form action="{{ route('task.search') }}" method="get" name="main_search_form" class="navbar-form">


        <div class="input-group">

            <input autocomplete="off" type="text" placeholder="Cari Tugas" class="form-control" name="task_search" id="task_search">
            <span class="input-group-btn">
            <button type="submit"  id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
                        </button>
            </span>
        </div>


        </form>

    </div>

</div>

<div class="table-responsive">
<table class="table table-striped">
    <thead>
      <tr>
        <th>No.</th>
        <th>Tanggal Dibuat</th>
        <th><a href="{{ route('task.sort', [ 'key' => 'task' ]) }}">Task Title <span class="glyphicon glyphicon-sort-by-alphabet" aria-hidden="true"></span> </a></th>
        <th>Ditujukan Ke / Order</th>
        <th><a href="{{ route('task.sort', [ 'key' => 'priority' ]) }}">Prioritas <span class="glyphicon glyphicon-sort-by-alphabet" aria-hidden="true"></span> </a></th>
        <th>Batas Akhir</th>
        <th>Terakhir Diupdate</th>
        <th><a href="{{ route('task.sort', [ 'key' => 'completed' ]) }}">Status <span class="glyphicon glyphicon-sort-by-alphabet" aria-hidden="true"></span> </a></th>
        <th>Aksi</th>
      </tr>
    </thead>

@if ( !$tasks->isEmpty() )
    <tbody>
    @php $no = 1; @endphp
    @foreach ( $tasks as $task)
      <tr>
        <td>{{ $no++ }}</td>
        <td>{{ Carbon\Carbon::parse($task->created_at)->format('d-m-Y') }}</td>
        <td>{{ $task->task_title }} </td>

        <td>

            @foreach( $users as $user)
                @if ( $user->id == $task->user_id )
                    <a href="{{ route('user.list', [ 'id' => $user->id ]) }}">{{ $user->name }}</a>
                @endif
            @endforeach
            <span class="label label-jc">{{ $task->project->project_name }}</span>

        </td>

        <td>
            @if ( $task->priority == 0 )
                <span class="label label-info">Normal</span>
            @else
                <span class="label label-danger">Mendesak</span>
            @endif
        </td>
        <td>{{ Carbon\Carbon::parse($task->duedate)->format('d-m-Y') }}</td>
        <td>{{ Carbon\Carbon::parse($task->updated_at)->format('d-m-Y') }}</td>
        <td>
            @if ( !$task->completed )
                <a href="{{ route('task.completed', ['id' => $task->id]) }}" class="btn btn-warning"> Tandai jika sudah selesai</a>
                <span class="label label-danger">{{ ( $task->duedate < Carbon\Carbon::now() )  ? "!" : "" }}</span>
            @else
                <span class="label label-success">Selesai</span>
            @endif



        </td>
        <td>

            <a href="{{ route('task.view', ['id' => $task->id]) }}" class="btn btn-primary"><span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span></a>
            @can('edit task')
              <!-- <a href="{{ route('task.edit', ['id' => $task->id]) }}" class="btn btn-primary"> edit </a>  -->
            @endcan
            @can('delete task')
              <a href="{{ route('task.delete', ['id' => $task->id]) }}" class="btn btn-danger"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></a>
            @endcan
        </td>
      </tr>

    @endforeach
    </tbody>

    {{ $tasks->links() }}


@else
    <p><em>Belum ada tugas</em></p>
@endif


</table>
</div>

@stop

@section('scripts')
<!-- TYPE AHEAD LIB -->
<script src="{{ asset('js/typeahead.min.js') }}"></script>

<script>

$(document).ready(function() {
    $('#task_search').on('keyup', function(e){
        if(e.which == 13){
            $('#main_search_form').submit();
        }
    });
    $.get("/main-search-autocomplete", function(data){
        $("#task_search").typeahead({
            "items": "all", // Number of Items
            "source": data,
            "autoSelect": false,
            displayText: function(item){
                console.log('returning item: ' + item.task_title ) ;
                return item.task_title;
            },

            updater: function(item) {
                window.location.href = '{{ route('task.search') }}?task_search=' + item.task_title.split(' ').join('+') ;
            }

        });
    },'json');
});

</script>
@stop
