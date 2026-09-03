function fn() {
  var headers = {
    Accept: 'application/json',
    'Content-Type': 'application/json',
    'X-Test-Framework': 'karate'
  };

  if (typeof apiToken !== 'undefined' && apiToken) {
    headers.Authorization = 'Bearer ' + apiToken;
  }

  return headers;
}
