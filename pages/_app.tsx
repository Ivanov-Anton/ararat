'use client'

import { AppProps } from "next/app";
import "@/styles/globals.css";

const MyApp = ({ Component, pageProps }: AppProps) => {
  return (
    <>
      <header>My Header</header>
      <Component {...pageProps} />
      <footer>My Footer</footer>
    </>
  );
};

export default MyApp;
