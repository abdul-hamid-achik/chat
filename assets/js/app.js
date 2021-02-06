import "../css/app.scss";
import "phoenix_html";
import TimeAgo from "javascript-time-ago";

import en from "javascript-time-ago/locale/en";

import App from "./main.tsx";
import React from "react";
import { render } from "react-dom";
// import "react-devtools";
TimeAgo.addDefaultLocale(en);

window.onload = () => render(<App />, document.getElementById("root"));
