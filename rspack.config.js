import { CssExtractRspackPlugin } from "@rspack/core";
import { resolve } from "node:path";

export default {
  mode: "production",
  entry: "./index.ts",
  output: {
    filename: "index.js",
    path: resolve("tmp/rspack"),
    publicPath: "/",
  },
  resolve: {
    extensions: [".ts", ".js"],
  },
  module: {
    rules: [
      {
        test: /\.ts$/,
        loader: "builtin:swc-loader",
        options: {
          jsc: {
            parser: {
              syntax: "typescript",
            },
            target: "es2022",
          },
        },
      },
      {
        test: /\.scss$/,
        use: [CssExtractRspackPlugin.loader, "css-loader", "sass-loader"],
      },
    ],
  },
  plugins: [new CssExtractRspackPlugin()],
  optimization: {
    minimize: true,
  },
};
