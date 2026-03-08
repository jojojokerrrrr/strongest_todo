import TaskItem from "../components/TaskItem"
import TaskCreateModal from "../components/TaskModal";
import { fetcher } from "../utils/api";
import useSWR from "swr";

export default function Tasks(){
  const { data, error } = useSWR("/tasks", fetcher);

  if (error) return <div>エラーが発生しました</div>;
  if (!data) return <div>Loading...</div>;

  const tasks = data.tasks || [];

  return (
    <>
      <TaskCreateModal/>

      <div className="mt-4">
        {tasks.map((task) => (
          <TaskItem key={task.id} task={task} />
        ))}
      </div>
    </>
  );
}