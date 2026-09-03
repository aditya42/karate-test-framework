function fn() {
  var env = karate.env || 'qa';
  var props = karate.properties;

  var environments = {
    local: {
      apiBaseUrl: 'https://jsonplaceholder.typicode.com',
      uiBaseUrl: 'https://www.saucedemo.com'
    },
    qa: {
      apiBaseUrl: 'https://jsonplaceholder.typicode.com',
      uiBaseUrl: 'https://www.saucedemo.com'
    },
    stage: {
      apiBaseUrl: 'https://jsonplaceholder.typicode.com',
      uiBaseUrl: 'https://www.saucedemo.com'
    }
  };

  if (!environments[env]) {
    throw 'Unsupported karate.env: ' + env + '. Supported: local, qa, stage';
  }

  var selected = environments[env];
  var config = {
    env: env,
    apiBaseUrl: props['api.baseUrl'] || selected.apiBaseUrl,
    uiBaseUrl: props['ui.baseUrl'] || selected.uiBaseUrl,
    apiToken: props['api.token'] || '',
    connectTimeout: parseInt(props['connect.timeout'] || '10000'),
    readTimeout: parseInt(props['read.timeout'] || '30000')
  };

  karate.configure('connectTimeout', config.connectTimeout);
  karate.configure('readTimeout', config.readTimeout);
  karate.configure('logPrettyRequest', true);
  karate.configure('logPrettyResponse', true);

  return config;
}
