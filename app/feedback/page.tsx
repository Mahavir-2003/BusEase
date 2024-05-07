"use client";
import React from "react";
import Image from "next/image";
import { Toaster, toast } from "react-hot-toast";

export default function Feedback() {
  async function handleSubmit(event: any) {
    event.preventDefault();

    const name = event.target.elements.name.value;
    const email = event.target.elements.email.value;
    const feedback = event.target.elements.feedback.value;

    try {
      const response = await fetch("https://v3-server.vercel.app/graphql/review/", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "x-api-key": "247da0f7b7f3bfcbea1b73a401cb426f",
        },
        body: JSON.stringify({
          query: `mutation CreateReview($username: String!, $email: String!, $review: String!) {
                        createReview(username: $username, email: $email, review: $review) {
                                id,
                                username,
                                email,
                                review,
                                date,
                                time,
                            }
                        }`,
          variables: {
            username: name,
            email: email,
            review: feedback,
          },
        }),
      });

      if (!response.ok) {
        throw new Error(`Network response was not ok: ${response.statusText}`);
      }

      const data = await response.json();
      console.log(data);

      toast.success("Feedback submitted successfully!");
    } catch (error) {
      toast.error("An error occurred while submitting your feedback.");
    }
  }

  return (
    <>
      <Toaster />
      <div className="flex justify-center items-center min-h-screen p-4">
        <div className="w-full max-w-2xl space-y-8 bg-slate-100 p-8 rounded-2xl shadow-lg border ">
          <div className="space-y-2">
            <div className="flex justify-center items-center p-6">
              <Image
                src="/images/busEase.png"
                alt="logo"
                width={200}
                height={200}
                className=""
              />
            </div>
            <h1 className="text-4xl font-bold text-gray-900">
              We'd love to hear from you
            </h1>
            <p className="text-gray-500 dark:text-gray-400">
              Your feedback helps us improve. Let us know what you think.
            </p>
          </div>
          <form onSubmit={handleSubmit} className="space-y-4">
            <div className="grid grid-cols-1 gap-4">
              <div className="space-y-2">
                <label className="text-sm font-medium leading-none text-gray-700">
                  Name
                </label>
                <input
                  className="flex h-10 w-full rounded-md border border-gray-300 bg-white px-3 py-2 text-sm placeholder-gray-500 focus:outline-none focus:ring-2 focus:ring-blue-500"
                  id="name"
                  placeholder="Enter your name"
                />
              </div>
              <div className="space-y-2">
                <label className="text-sm font-medium leading-none text-gray-700">
                  Email
                </label>
                <input
                  className="flex h-10 w-full rounded-md border border-gray-300 bg-white px-3 py-2 text-sm placeholder-gray-500 focus:outline-none focus:ring-2 focus:ring-blue-500"
                  id="email"
                  placeholder="Enter your email"
                  type="email"
                />
              </div>
              <div className="space-y-2">
                <label className="text-sm font-medium leading-none text-gray-700">
                  Feedback
                </label>
                <textarea
                  style={{ border: "1px solid #D1D5DB" }}
                  className="flex w-full h-20 rounded-md border border-gray-300 bg-white px-3 py-2 text-sm placeholder-gray-500 focus:outline-none focus:ring-2 focus:ring-blue-500"
                  id="feedback"
                  placeholder="Enter your feedback"
                ></textarea>
              </div>
            </div>
            <button
              type="submit"
              className="inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium transition-colors focus:outline-none focus:ring-2 focus:ring-blue-500 bg-[#9381ff] text-white hover:bg-[#7161ef] h-10 px-4 py-2"
            >
              Submit feedback
            </button>
          </form>
        </div>
      </div>
    </>
  );
}
