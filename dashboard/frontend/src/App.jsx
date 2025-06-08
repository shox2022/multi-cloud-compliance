import { useState } from 'react'
import ViolationTable from './components/ViolationTable';

export default function App() {
  return (
    <div className="p-4">
      <h1 className="text-xl mb-4">Compliance Violations</h1>
      <ViolationTable />
    </div>
  );
}
