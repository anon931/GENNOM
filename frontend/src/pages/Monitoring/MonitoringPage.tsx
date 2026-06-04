import { useEffect, useState } from 'react';
import io from 'socket.io-client';

export default function MonitoringPage() {
  const [lastReading, setLastReading] = useState('Esperando datos...');

  useEffect(() => {
    const socket = io('http://localhost:8080/ws');
    socket.on('connect', () => console.log('WebSocket conectado'));
    socket.on('energy-data', (data) => setLastReading(JSON.stringify(data)));
    return () => { socket.disconnect(); };
  }, []);

  return (
    <div className="p-6">
      <h1>Monitoreo en Tiempo Real</h1>
      <div className="mt-4 p-4 bg-green-100 rounded">Última lectura: {lastReading}</div>
    </div>
  );
}