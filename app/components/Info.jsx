import Link from "next/link";
import React from "react";
import Feedback from "./Feedback";

const MobileAppScreenshotURL =
  "/images/BusEase_Mockup.png";

const Info = () => {
  return (
    <div className="h-full flex flex-col justify-between  absolute top-0 left-0 w-full">
      <div
        className="mx-auto md:p-16 flex flex-col md:flex-row items-center justify-between flex-1 m-3.5 "
      >
        <section className="md:w-1/2 px-4  md:mr-8 flex flex-col items-center justify-center mb-8 md:mb-0 xs:mt-20 sm:mt-16 lg:mt-8 relative">
          <h1 className="text-5xl font-bold mb-4 text-center">
            Project Update: v1.0.8 Released!
          </h1>
          <p className="text-lg md:text-xl mb-4 text-center">
          BusEase v1.0.8 brings a digital solution for seamless bus pass applications and ticketing. Students can book tickets conveniently, making travel easier than ever before.
          </p>
          <p className="text-lg md:text-xl mb-8 text-center">
            Check out the{" "}
            <Link
              href="https://github.com/Mahavir-2003/BusEase"
              className="text-blue-500 hover:text-blue-700"
            >
              v2.0.2 Beta
            </Link>{" "}
            development on GitHub for mobile devices.
          </p>
        </section>
        <section className="flex-1 md:w-1/2 h-full flex items-center justify-center">
          <img
            src={MobileAppScreenshotURL}
            alt="Mobile App Screenshot"
            className=" h-full object-fill"
          />
        </section>
      </div>
      <Feedback />
    </div>
  );
};

export default Info;