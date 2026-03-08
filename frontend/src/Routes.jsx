import { Routes, Route, Navigate } from "react-router-dom";
import Login from "./pages/Login";
import Tasks from "./pages/Tasks";

export const AppRoutes = () => {
  const isAuthenticated = !!localStorage.getItem("token");

  return (
    <Routes>
      <Route 
        path="/" 
        element={isAuthenticated ? <Navigate to="/tasks" replace /> : <Navigate to="/login" replace />}
      />

      <Route path="/login" element={<Login />} />

      <Route 
        path="/tasks"
        element={isAuthenticated ? <Tasks /> : <Navigate to="/login" replace />}
      />
    </Routes>
  )
}