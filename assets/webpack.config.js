const path = require("path")
const glob = require("glob")
const HardSourceWebpackPlugin = require("hard-source-webpack-plugin")
const MiniCssExtractPlugin = require("mini-css-extract-plugin")
const TerserPlugin = require("terser-webpack-plugin")
const OptimizeCSSAssetsPlugin = require("optimize-css-assets-webpack-plugin")
const CopyWebpackPlugin = require("copy-webpack-plugin")
const MomentTimezoneDataPlugin = require("moment-timezone-data-webpack-plugin")
const currentYear = new Date().getFullYear()

module.exports = (env, options) => {
  const devMode = options.mode !== "production"

  return {
    optimization: {
      minimizer: [
        new TerserPlugin({ cache: true, parallel: true, sourceMap: devMode }),
        new OptimizeCSSAssetsPlugin({}),
      ],
    },
    entry: {
      app: glob.sync("./vendor/**/*.js").concat(["./js/app.js"]),
    },
    output: {
      filename: "[name].js",
      path: path.resolve(__dirname, "../priv/static/js"),
      publicPath: "/js/",
    },
    devtool: devMode ? "eval-cheap-module-source-map" : undefined,
    module: {
      rules: [
        {
          test: /\.(j|t)sx?$/,
          exclude: /node_modules/,
          use: [
            {
              loader: "babel-loader",
            },
            {
              loader: "ts-loader",
            },
          ],
        },
        {
          test: /\.[s]?css$/,
          use: [
            MiniCssExtractPlugin.loader,
            "css-loader",
            "sass-loader",
            "postcss-loader",
          ],
        },
        {
          test: /\.(graphql|gql)$/,
          exclude: /node_modules/,
          loader: "graphql-tag/loader",
        },
        {
          test: /\.mjs$/,
          include: /node_modules/,
          type: "javascript/auto",
        },
      ],
    },

    resolve: {
      extensions: ["*", ".mjs", ".ts", ".tsx", ".js", ".gql", ".jsx"],
      alias: {
        "~": path.resolve(__dirname, "js"),
      },
    },
    plugins: [
      new MiniCssExtractPlugin({ filename: "../css/app.css" }),
      new CopyWebpackPlugin([{ from: "static/", to: "../" }]),
      new MomentTimezoneDataPlugin({
        matchZones: /^America/,
      }),

      new MomentTimezoneDataPlugin({
        startYear: currentYear - 1,
        endYear: currentYear + 1,
      }),
    ].concat(devMode ? [new HardSourceWebpackPlugin()] : []),
  }
}
