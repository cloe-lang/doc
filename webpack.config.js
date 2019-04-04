const ExtractTextPlugin = require("extract-text-webpack-plugin");
const path = require("path");
const webpack = require("webpack");

module.exports = {
  mode: "production",
  entry: "./index.ts",
  output: {
    filename: "index.js",
    path: path.resolve(__dirname, "tmp")
  },
  resolve: {
    extensions: [".ts", ".js"]
  },
  module: {
    rules: [
      {
        test: /\.ts$/,
        loader: "ts-loader",
        options: {
          configFile: require.resolve("./tsconfig.webpack.json")
        }
      },
      {
        test: /\.css$/,
        use: ExtractTextPlugin.extract({
          use: ["css-loader"]
        })
      },
      {
        test: /\.scss$/,
        use: ExtractTextPlugin.extract({
          use: ["css-loader", "sass-loader"]
        })
      }
    ]
  },
  optimization: {
    minimize: true
  },
  plugins: [new ExtractTextPlugin("index.css")]
};
