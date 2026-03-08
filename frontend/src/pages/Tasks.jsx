import Sidebar from "../components/Sidebar";
import TaskItem from "../components/TaskItem"
import { fetcher } from "../utils/api";
import useSWR from "swr";

export default function Tasks(){
  const { data, error } = useSWR("/tasks", fetcher);

  if (error) return <div>エラーが発生しました</div>;
  if (!data) return <div>Loading...</div>;

  const tasks = data.tasks || [];

  return (
    <div className="flex min-h-screen">
      <Sidebar />

      <div className="flex-1 p-8 bg-base-100">
        <div className="mt-4">
          {tasks.map((task) => (
            <TaskItem key={task.id} task={task} />
          ))}
        </div>
      </div>
    </div>
  );
}