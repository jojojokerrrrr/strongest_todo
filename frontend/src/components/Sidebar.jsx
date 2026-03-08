import TaskCreateModal from "./TaskModal";
import { useNavigate } from "react-router-dom";

export default function Sidebar() {
  const navigate = useNavigate();

  return (
    <div className="w-64 bg-base-200 min-h-screen p-4 border-r">
      <h2 className="text-xl font-bold mb-4 px-4">Task App</h2>

      <div className="mb-4 px-2">
        <button className="btn btn-primary btn-ghost w-full" onClick={() => navigate("/tasks")}>ホーム</button>
      </div>

      <div className="mb-4 px-2">
        <TaskCreateModal />
      </div>
{/* 
      <div className="mb-4 px-2">
        <button className="btn btn-primary btn-ghost w-full" onClick={() => navigate("/user_id")}>マイタスク</button>
      </div>

      <div className="mb-4 px-2">
        <button className="btn btn-primary btn-ghost w-full" onClick={() => navigate("/settings")}>設定</button>
      </div> */}
    </div>
  );
}