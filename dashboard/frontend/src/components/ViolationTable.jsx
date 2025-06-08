import { useEffect, useState } from 'react';

export default function ViolationTable() {
  const [rows, setRows] = useState([]);
  useEffect(() => {
    fetch('/api/violations')
      .then(r => r.json())
      .then(setRows);
  }, []);

  return (
    <table className="min-w-full">
      <thead>
        <tr><th>Time</th><th>Resource</th><th>Message</th></tr>
      </thead>
      <tbody>
        {rows.map((r,i) => (
          <tr key={i}>
            <td>{new Date(r.time).toLocaleString()}</td>
            <td>{r.resource}</td>
            <td>{r.message}</td>
          </tr>
        ))}
      </tbody>
    </table>
  );
}
