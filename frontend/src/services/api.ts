import axios from 'axios';
const API = axios.create({ baseURL: 'http://localhost:8080/api' });
API.interceptors.request.use((config) => {
    const token = localStorage.getItem('token');
    if (token) config.headers.Authorization = `Bearer ${token}`;
    return config;
});
export const login = (username: string, password: string) => API.post('/auth/login', { username, password });
export const register = (userData: any) => API.post('/auth/register', userData);
export const getPlants = () => API.get('/facilities');
export const getConsumptions = (facilityId: number, from: string, to: string) => API.get(`/consumptions/${facilityId}`, { params: { from, to } });
export const predict = (facilityId: number, datetime: string) => API.post('/predictions', null, { params: { facilityId, datetime } });
export const getMyPlant = () => API.get('/facilities/my');
export const getSimulationConfig = () => API.get('/admin/simulation/config');
export const updateSimulationConfig = (config: any) => API.post('/admin/simulation/config', config);
export const runSimulation = () => API.post('/admin/simulation/run');
export const getAnomalies = () => API.get('/anomalies');
export default API;
