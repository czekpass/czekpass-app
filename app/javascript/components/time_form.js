const timeFormSubmission = () => {
  const timeForm = document.getElementById('time-form');
  const timeSelector = document.querySelector('[name=saving]');
  if (timeSelector) {
    timeSelector.addEventListener('change', (e) => {
      Rails.fire(timeForm, 'submit');
    });
  }
}

export { timeFormSubmission };
