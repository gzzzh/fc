"use strict";

/*   公用js文件   */
function getNativeDataFunction(functionName) {
  var parm = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};
  var payload = {
    "type": "JSbridge",
    "functionName": functionName,
    "arguments": parm
  };
  return prompt(JSON.stringify(payload));
}
