exports.getData = async (event) => {
  const url = "https://jsonplaceholder.typicode.com/users";
  const nodeFetch = await import('node-fetch');
  const fetch = nodeFetch.default; 
  
  var response = await fetch(url)
  var data = await response.json()
  return data
}