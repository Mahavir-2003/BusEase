import React from "react";
import Link from "next/link";

const Feedback = () => {
  return (
    <div className="flex py-5  flex-row w-full h-12 bg-[#9381ff] text-black justify-center items-center text-base font-light space-x-4">
      <div>
        <div className="avail-ping"></div>
      </div>
      <p className="release">
        Share your feedback on{" "}
        <span className="font-bold "> ( v1.0.8 ) </span>{" "}
        <span>
          <Link
            href="/feedback"
            className="text-[#f8f7ff] font-semibold px-2"
          >
            Feedback
          </Link>
        </span>
      </p>
    </div>
  );
};

export default Feedback;
