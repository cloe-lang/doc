const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const path = require("path");
require("webpack");

module.exports = {
  mode: "production",
  entry: "./index.ts",
  output: {
    filename: "index.js",
    path: path.resolve(__dirname, "tmp/webpack"),
  },
  resolve: {
    extensions: [".ts", ".js"],
  },
  module: {
    rules: [
      {
        test: /\.ts$/,
        loader: "ts-loader",
        options: {
          configFile: require.resolve("./tsconfig.webpack.json"),
        },
      },
      {
        test: /\.scss$/,
        use: [MiniCssExtractPlugin.loader, "css-loader", "sass-loader"],
      },
    ],
  },
  plugins: [new MiniCssExtractPlugin()],
  optimization: {
    minimize: true,
  },
};
