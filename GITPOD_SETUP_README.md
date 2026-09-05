Added Gitpod setup to run hackclub/hackatime from this repository.

What I added
- .gitpod.yml -> configures a Gitpod workspace that clones hackclub/hackatime into ./hackatime and runs setup/start tasks.
- .gitpod/setup.sh -> clones upstream repo, copies .env.example, installs bundler/yarn deps.
- .gitpod/start.sh -> runs db setup, builds Vite SSR, and starts Rails on 0.0.0.0:3000 so Gitpod forwards port 3000.
- .env.example -> environment placeholders and notes for Gitpod.

How to use (from your iPhone in Safari)
1) Open this repo in Gitpod with the one-click URL:
   https://gitpod.io/#https://github.com/gDiva-blip/Sick-bae
2) Allow Gitpod to start the workspace. Wait for the init task to finish.
3) In Gitpod: open Settings → Environment Variables and add the secrets listed in .env.example (HCA_CLIENT_ID, HCA_CLIENT_SECRET, SECRET_KEY_BASE, etc.).
4) Reopen the workspace or re-run the init task if needed. Then Gitpod will run the start task which launches Rails on port 3000.
5) Use the Gitpod preview that opens automatically (it will forward port 3000). Copy that URL and add the following callback URLs in your HCA app settings:
   - https://<workspace-url>/auth/hca/callback
   - https://<workspace-url>/deletion/hca/callback

Notes & next steps
- I cannot create your HCA app or add HCA_CLIENT_SECRET for you — you must do that in https://hca.dinosaurbbq.org and paste the values into Gitpod's Environment Variables.
- If the hackatime repo changes structure or requires alternative build steps, paste any errors here and I'll update the scripts.

I created a new branch add/gitpod-setup with these files. To get this into your main branch, open a Pull Request and merge when you’re ready.
