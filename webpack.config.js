import MiniCssExtractPlugin from "mini-css-extract-plugin";
import { resolve } from "node:path";

export default {
  mode: "production",
  entry: "./index.ts",
  output: {
    filename: "index.js",
    path: resolve("tmp/webpack"),
    publicPath: "/",
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
          configFile: resolve("./tsconfig.webpack.json"),
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
