function fn() {
  var UUID = Java.type('java.util.UUID');
  var id = UUID.randomUUID() + '';
  return {
    id: id,
    email: 'karate-' + id.substring(0, 8) + '@example.test',
    title: 'Karate test ' + id.substring(0, 8)
  };
}
