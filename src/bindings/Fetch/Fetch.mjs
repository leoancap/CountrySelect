// Generated by ReScript, PLEASE EDIT WITH CARE


function get(url) {
  return fetch(url, {
                method: "GET"
              }).then(function (prim) {
              return prim.json();
            });
}

export {
  get ,
  
}
/* No side effect */
