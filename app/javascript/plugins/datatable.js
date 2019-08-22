import DataTable from 'datatables.net';

const initDataTable = ($) => {
  $(document).ready(function() {
    if(document.querySelector("#dataTable")){
      $('#dataTable').DataTable();
    }
});
}

export {initDataTable}
