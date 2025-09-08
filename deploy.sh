#!/bin/bash

# Cosmos Hub Deployment Script
# This script prepares and deploys the Cosmos Hub project to GitHub and Vercel

set -e  # Exit on any error

echo "🚀 Starting Cosmos Hub deployment process..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if required commands exist
check_requirements() {
    print_status "Checking requirements..."
    
    if ! command -v git &> /dev/null; then
        print_error "Git is not installed. Please install Git and try again."
        exit 1
    fi
    
    if ! command -v node &> /dev/null; then
        print_error "Node.js is not installed. Please install Node.js 18+ and try again."
        exit 1
    fi
    
    if ! command -v npm &> /dev/null; then
        print_error "npm is not installed. Please install npm and try again."
        exit 1
    fi
    
    print_success "All requirements met!"
}

# Install dependencies
install_dependencies() {
    print_status "Installing dependencies..."
    
    npm install
    
    cd frontend && npm install && cd ..
    cd backend && npm install && cd ..
    cd db && npm install && cd ..
    
    print_success "Dependencies installed!"
}

# Build the project
build_project() {
    print_status "Building the project..."
    
    # Generate Prisma client
    cd db && npx prisma generate && cd ..
    
    # Build frontend and backend
    npm run build
    
    print_success "Project built successfully!"
}

# Run tests
run_tests() {
    print_status "Running tests..."
    
    npm test
    
    print_success "All tests passed!"
}

# Initialize Git repository
init_git() {
    print_status "Initializing Git repository..."
    
    if [ ! -d ".git" ]; then
        git init
        print_success "Git repository initialized!"
    else
        print_warning "Git repository already exists."
    fi
}

# Add files and commit
commit_changes() {
    print_status "Adding files and committing changes..."
    
    # Create .gitignore if it doesn't exist
    if [ ! -f ".gitignore" ]; then
        cat > .gitignore << EOL
# Dependencies
node_modules/
.pnp
.pnp.js

# Testing
coverage/

# Next.js
.next/
out/

# Production
build/
dist/

# Environment variables
.env
.env.local
.env.development.local
.env.test.local
.env.production.local

# Logs
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Runtime data
pids
*.pid
*.seed
*.pid.lock

# Optional npm cache directory
.npm

# Optional REPL history
.node_repl_history

# Output of 'npm pack'
*.tgz

# Yarn Integrity file
.yarn-integrity

# dotenv environment variables file
.env

# parcel-bundler cache (https://parceljs.org/)
.cache
.parcel-cache

# Stores VSCode versions used for testing VSCode extensions
.vscode-test

# Temporary folders
tmp/
temp/

# OS generated files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# IDE files
.vscode/
.idea/
*.swp
*.swo

# Prisma
prisma/migrations/
EOL
        print_success ".gitignore created!"
    fi
    
    git add .
    git commit -m "feat: Initial Cosmos Hub deployment with dynamic APIs

- Added comprehensive space weather monitoring with NASA/NOAA APIs
- Implemented real-time satellite tracking with TLE data
- Created sustainability dashboard with environmental metrics
- Set up complete CI/CD pipeline with GitHub Actions
- Added comprehensive testing infrastructure
- Configured Supabase database with Prisma ORM
- Implemented responsive UI with Tailwind CSS
- Added real-time data updates and monitoring"
    
    print_success "Changes committed!"
}

# Add remote and push to GitHub
push_to_github() {
    local repo_url="https://github.com/Aju-lang/TRASPACE.git"
    
    print_status "Pushing to GitHub repository: $repo_url"
    
    # Check if remote already exists
    if git remote get-url origin &> /dev/null; then
        print_warning "Remote 'origin' already exists. Updating URL..."
        git remote set-url origin "$repo_url"
    else
        git remote add origin "$repo_url"
    fi
    
    # Push to GitHub
    git branch -M main
    git push -u origin main --force
    
    print_success "Code pushed to GitHub!"
}

# Create deployment info
create_deployment_info() {
    print_status "Creating deployment information..."
    
    cat > DEPLOYMENT.md << EOL
# 🚀 Cosmos Hub Deployment Information

## 📊 Project Overview
- **Name**: Cosmos Hub (TRASPACE)
- **Description**: Space Weather Monitoring & Sustainability Platform
- **Repository**: https://github.com/Aju-lang/TRASPACE
- **Live URL**: https://traspace.vercel.app

## 🏗️ Architecture
- **Frontend**: Next.js 14 + Tailwind CSS (Port 3000)
- **Backend**: Next.js API Routes (Port 3001)
- **Database**: Supabase PostgreSQL + Prisma ORM
- **Deployment**: Vercel (Frontend & Backend)
- **Monitoring**: GitHub Actions CI/CD

## 🔑 Environment Variables Required

### Frontend (.env.local)
\`\`\`
NEXT_PUBLIC_SUPABASE_URL=your-supabase-url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-supabase-anon-key
NEXT_PUBLIC_BACKEND_URL=https://your-backend-domain.vercel.app
\`\`\`

### Backend (.env.local)
\`\`\`
DATABASE_URL=your-supabase-database-url
DIRECT_URL=your-supabase-direct-url
NASA_API_KEY=your-nasa-api-key
EPA_AIRNOW_API_KEY=your-epa-api-key
N2YO_API_KEY=your-n2yo-api-key
\`\`\`

## 🚀 Deployment Steps

1. **Database Setup**:
   \`\`\`bash
   cd db
   npx prisma generate
   npx prisma db push
   npx prisma db seed
   \`\`\`

2. **Frontend Deployment** (Vercel):
   - Framework: Next.js
   - Root Directory: frontend
   - Build Command: npm run build
   - Output Directory: .next

3. **Backend Deployment** (Vercel):
   - Framework: Next.js
   - Root Directory: backend
   - Build Command: npm run build

## 📱 Features
- 🌦️ Real-time space weather monitoring
- 🛰️ Live satellite tracking with orbital data
- 🌱 Environmental sustainability metrics
- 📊 Interactive data visualizations
- 🔄 Automatic data updates
- 📱 Responsive mobile design
- 🔐 Secure API integrations

## 🌐 API Endpoints
- \`/api/weather\` - Space weather data
- \`/api/satellites\` - Satellite tracking
- \`/api/sustainability\` - Environmental metrics

## 📞 Support
- Repository: https://github.com/Aju-lang/TRASPACE
- Issues: https://github.com/Aju-lang/TRASPACE/issues

---
*Deployed on $(date)*
EOL
    
    print_success "Deployment information created!"
}

# Main deployment function
main() {
    print_status "🌌 Welcome to Cosmos Hub Deployment!"
    echo ""
    
    check_requirements
    install_dependencies
    build_project
    run_tests
    init_git
    commit_changes
    push_to_github
    create_deployment_info
    
    echo ""
    print_success "🎉 Deployment completed successfully!"
    echo ""
    print_status "Next steps:"
    echo "1. 🔑 Set up environment variables in Vercel"
    echo "2. 🌐 Deploy frontend to Vercel from GitHub"
    echo "3. 🔧 Deploy backend to Vercel from GitHub"
    echo "4. 🗄️ Set up Supabase database"
    echo "5. 🔗 Update API URLs in configuration"
    echo ""
    print_status "Repository: https://github.com/Aju-lang/TRASPACE"
    print_status "Live URL: https://traspace.vercel.app"
    echo ""
}

# Run the deployment
main "$@"


