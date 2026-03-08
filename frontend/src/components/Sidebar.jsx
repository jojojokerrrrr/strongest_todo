import TaskCreateModal from "./TaskModal";
import Home from "./HomeButton";

export default function Sidebar() {
  return (
    <div className="w-64 bg-base-200 min-h-screen p-4 border-r">
      <h2 className="text-xl font-bold mb-4 px-4">Task App</h2>

      <div className="mb-4 px-2">
        <Home />
      </div>

      <div className="mb-4 px-2">
        <TaskCreateModal />
      </div>
    </div>
  );
}