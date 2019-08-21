// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#858796';

// Pie Chart Example
const initChartPieRevCat = () => {
  var ctx = document.getElementById("myPieChartRevCat");
  if (ctx) {
    var myPieChartRevCat = new Chart(ctx, {
      type: 'doughnut',
      data: {
        labels: ["Education", "Health & Fitness", "Restaurant", "Accomodation", "Clothing", "Coworking Space"],
        datasets: [{
          data: [1550, 300, 1105, 550, 1300, 105],
          backgroundColor: ['#167ffc', '#1cc88a', '#36b9cc', '#4e73df', '#1cc88a', '#36b9cc'],
          hoverBackgroundColor: ['#2e59d9', '#17a673', '#2c9faf', '#2e59d9', '#17a673', '#2c9faf'],
          hoverBorderColor: "rgba(234, 236, 244, 1)",
        }],
      },
      options: {
        maintainAspectRatio: false,
        tooltips: {
          backgroundColor: "rgb(255,255,255)",
          bodyFontColor: "#858796",
          borderColor: '#dddfeb',
          borderWidth: 1,
          xPadding: 15,
          yPadding: 15,
          displayColors: false,
          caretPadding: 10,

        },
        legend: {
          display: false
        },
        cutoutPercentage: 50,
      },
    });

  }

}

export { initChartPieRevCat }
