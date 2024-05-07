import React from "react";
import Link from "next/link";
import Updates from "./Updates";

const Download = () => {
  return (
    <div
      className="z-50 sticky w-full"
    >
      <div className="flex flex-row w-full h-12 bg-[#c0fd90] text-black justify-center items-center text-base font-light space-x-4">
        <div>
          <div className="avail-ping"></div>
        </div>
        <p className="release">
          Newer Version Available
          <span className="font-bold"> ( v1.0.8 ) </span>{" "}
          <span>
            <Link
              href="https://github.com/NisargPatel14/yatrazen-HIS/releases/download/v1.1/app-release.apk"
              className="text-blue-500 hover:text-blue-700 font-semibold px-2"
            >
              Download
            </Link>
          </span>
        </p>
      </div>
      <Updates />
    </div>
  );
};

export default Download;
