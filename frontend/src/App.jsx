import { useState } from "react";
import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";
import axios from "axios";
import useSWR, { useSWRConfig } from "swr";
import TaskItem from "./components/TaskItem";
import Login from "./pages/Login";

const api = axios.create({
  baseURL: "http://localhost:3000/api/v1"
})

const fetcher = (url) => {
  return api.get(url).then(res => res.data);
}

export default function App() {
  const {data, error} = useSWR("/tasks", fetcher);

  if (error) return <div>エラーが発生しました</div>
  if (!data) return <div>Loading...</div>

  const tasks = data.tasks;

  return (
    <BrowserRouter>
      <Routes>
        <Route path="/login" element={<Login/>} />
      </Routes>
    </BrowserRouter>
    // <div className="p-8">
    //   <h1>ホーム</h1>
    //   <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
    //     {tasks.map(task => (
    //       <TaskItem key={task.id} task={task} />
    //     ))}
    //   </div>
    // </div>
  )
}