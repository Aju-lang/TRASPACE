# 🚀 Cosmos Hub Setup Guide

This guide will help you set up and run the Cosmos Hub project locally.

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- **Node.js 18+** - [Download](https://nodejs.org/)
- **npm 8+** - Comes with Node.js
- **Git** - [Download](https://git-scm.com/)
- **PostgreSQL** (optional, if not using Supabase) - [Download](https://postgresql.org/)

## 🏁 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/cosmos-hub.git
cd cosmos-hub
```

### 2. Install Dependencies

```bash
# Install root dependencies
npm install

# Install all workspace dependencies
npm run install:all
```

Or install each workspace manually:

```bash
# Frontend dependencies
cd frontend && npm install && cd ..

# Backend dependencies
cd backend && npm install && cd ..

# Database dependencies
cd db && npm install && cd ..
```

### 3. Environment Setup

Create environment files:

```bash
# Copy environment template
cp db/env.example .env
```

Edit the `.env` file with your configuration:

```env
# Database (Supabase recommended)
DATABASE_URL="postgresql://postgres:[PASSWORD]@db.[PROJECT-REF].supabase.co:5432/postgres"
DIRECT_URL="postgresql://postgres:[PASSWORD]@db.[PROJECT-REF].supabase.co:5432/postgres"

# Supabase
NEXT_PUBLIC_SUPABASE_URL="https://[PROJECT-REF].supabase.co"
NEXT_PUBLIC_SUPABASE_ANON_KEY="[ANON-KEY]"

# API Keys (optional for demo)
NASA_API_KEY="DEMO_KEY"
NOAA_API_KEY=""
EPA_API_KEY=""
```

### 4. Database Setup

```bash
# Generate Prisma client
npm run db:generate

# Push database schema
npm run db:push

# Seed with sample data
npm run db:seed
```

### 5. Start Development Servers

```bash
# Start all services (recommended)
npm run dev

# Or start individually:
npm run dev:frontend  # Frontend on http://localhost:3000
npm run dev:backend   # Backend on http://localhost:3001
```

### 6. Open in Browser

- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:3001/api
- **Database Studio**: Run `npm run db:studio`

## 🔧 Detailed Setup

### Supabase Database Setup

1. **Create Supabase Project**
   - Go to [supabase.com](https://supabase.com)
   - Create new project
   - Note your project URL and anon key

2. **Configure Database**
   ```bash
   # Update .env with your Supabase credentials
   DATABASE_URL="postgresql://postgres:[PASSWORD]@db.[PROJECT-REF].supabase.co:5432/postgres"
   NEXT_PUBLIC_SUPABASE_URL="https://[PROJECT-REF].supabase.co"
   NEXT_PUBLIC_SUPABASE_ANON_KEY="[ANON-KEY]"
   ```

3. **Run Migrations**
   ```bash
   cd db
   npx prisma migrate dev --name init
   npx prisma generate
   npx prisma db seed
   ```

### API Keys Setup

#### NASA API (Optional)
1. Visit [api.nasa.gov](https://api.nasa.gov/)
2. Sign up for a free API key
3. Add to `.env`: `NASA_API_KEY="your-key-here"`

#### NOAA Space Weather (Free)
- Most NOAA SWPC endpoints are free
- No API key required for basic usage

#### EPA AirNow API (Optional)
1. Register at [airnowapi.org](https://www.airnowapi.org/)
2. Get your API key
3. Add to `.env`: `EPA_API_KEY="your-key-here"`

#### Celestrak (Free)
- TLE data is freely available
- No API key required
- Registration recommended for higher limits

### Local PostgreSQL Setup (Alternative)

If you prefer local PostgreSQL instead of Supabase:

1. **Install PostgreSQL**
   ```bash
   # macOS with Homebrew
   brew install postgresql
   brew services start postgresql
   
   # Ubuntu/Debian
   sudo apt install postgresql postgresql-contrib
   sudo systemctl start postgresql
   ```

2. **Create Database**
   ```bash
   createdb cosmos_hub_dev
   ```

3. **Update Environment**
   ```env
   DATABASE_URL="postgresql://username:password@localhost:5432/cosmos_hub_dev"
   DIRECT_URL="postgresql://username:password@localhost:5432/cosmos_hub_dev"
   ```

## 🧪 Testing

### Run Tests

```bash
# Run all tests
npm test

# Run frontend tests
cd frontend && npm test

# Run backend tests
cd backend && npm test

# Run database tests
cd db && npm test
```

### Manual Testing

1. **Space Weather Page**: http://localhost:3000/weather
2. **Satellites Page**: http://localhost:3000/satellites  
3. **Sustainability Page**: http://localhost:3000/sustain
4. **API Endpoints**:
   - GET http://localhost:3001/api/weather
   - GET http://localhost:3001/api/satellites
   - GET http://localhost:3001/api/sustainability

## 🚀 Deployment

### Vercel Deployment (Recommended)

1. **Frontend Deployment**
   ```bash
   cd frontend
   npx vercel
   # Follow the prompts
   ```

2. **Backend Deployment**
   ```bash
   cd backend
   npx vercel
   # Follow the prompts
   ```

3. **Environment Variables**
   - Add all environment variables in Vercel dashboard
   - Update frontend's `next.config.js` to point to backend URL

### Manual Deployment

1. **Build Applications**
   ```bash
   npm run build
   ```

2. **Deploy to Your Platform**
   - Upload build files to your hosting provider
   - Configure environment variables
   - Set up domain and SSL

## 📊 Monitoring

### Database Monitoring

```bash
# Check database status
npm run db:studio

# View connection status
cd db && npx prisma db execute --stdin <<< "SELECT 1;"
```

### API Health Checks

```bash
# Check all endpoints
curl http://localhost:3001/api/weather
curl http://localhost:3001/api/satellites
curl http://localhost:3001/api/sustainability
```

### Performance Monitoring

```bash
# Install Lighthouse CI
npm install -g @lhci/cli

# Run performance audit
lhci autorun --collect.url=http://localhost:3000
```

## 🛠️ Development Tools

### Recommended VS Code Extensions

- **Prisma** - Database schema management
- **Tailwind CSS IntelliSense** - CSS utility classes
- **TypeScript Importer** - Auto import management
- **ESLint** - Code linting
- **Prettier** - Code formatting

### Useful Commands

```bash
# Database management
npm run db:generate    # Generate Prisma client
npm run db:push       # Push schema changes
npm run db:migrate    # Create migration
npm run db:seed       # Seed database
npm run db:studio     # Open database GUI

# Development
npm run dev           # Start all services
npm run build         # Build all applications
npm run start         # Start production servers
npm run lint          # Run linters

# Utilities
npm run clean         # Clean build artifacts
npm run reset         # Reset database
```

## 🔍 Troubleshooting

### Common Issues

#### Database Connection Failed
```bash
# Check connection string
echo $DATABASE_URL

# Test connection
cd db && npx prisma db execute --stdin <<< "SELECT 1;"

# Reset connection
npm run db:push
```

#### Frontend Build Errors
```bash
# Clear Next.js cache
cd frontend && rm -rf .next

# Reinstall dependencies
cd frontend && rm -rf node_modules package-lock.json
cd frontend && npm install
```

#### API Endpoints Not Working
```bash
# Check backend server is running
curl http://localhost:3001/api/weather

# Check environment variables
echo $NASA_API_KEY
echo $DATABASE_URL

# Restart backend
cd backend && npm run dev
```

#### CORS Issues
- Ensure `next.config.js` in frontend has correct API proxy
- Check backend CORS configuration
- Verify URLs match between frontend and backend

### Getting Help

- **Documentation**: Check `/docs` folder
- **Issues**: Create GitHub issue
- **Discord**: Join our community
- **Email**: support@cosmoshub.com

## 🎯 Next Steps

After setup is complete:

1. **Explore the Application**
   - Visit all three main pages
   - Test API endpoints
   - Check database in Prisma Studio

2. **Customize Configuration**
   - Add your API keys
   - Configure alert preferences
   - Set up monitoring

3. **Deploy to Production**
   - Set up Vercel projects
   - Configure production environment variables
   - Set up custom domain

4. **Monitor and Maintain**
   - Set up health checks
   - Monitor API usage
   - Keep dependencies updated

## 📝 Additional Resources

- [Next.js Documentation](https://nextjs.org/docs)
- [Prisma Documentation](https://www.prisma.io/docs)
- [Supabase Documentation](https://supabase.com/docs)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)
- [NASA API Documentation](https://api.nasa.gov/)
- [NOAA Space Weather API](https://www.swpc.noaa.gov/products/solar-wind)

---

**Happy coding! 🚀** If you encounter any issues, please refer to the troubleshooting section or reach out for support.
