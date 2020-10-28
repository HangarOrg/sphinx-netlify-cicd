Deploying Sphinx to Netlify
===========================

Writing documentation in `Sphinx <sphinx-doc.org/>`_ is awesome! And automatic deployments to `Netlify <https://www.netlify.com/>`_ is awesome. Wouldn't it be super awesome if you easily could do both! Fortunately, you can! Just follow the instructions below. Or, if you just want to get going:

.. code:: bash

    curl https://raw.githubusercontent.com/HangarOrg/sphinx-netlify-cicd/main/start.sh -o start.sh
    chmod +x start.sh
    ./start.sh

Enjoy!

Prep work
---------

- Make sure you have ``git`` installed.
- (Ideally) Make sure you have `poetry <https://python-poetry.org/>`_ installed
- (Ideally) Make sure you have the `netlify cli <https://docs.netlify.com/cli/get-started/>`_ installed
- (Ideally) Make sure you have the `github cli <https://cli.github.com/>`_ installed

The steps
---------

1. **Set up your repository**. Create your directory and get it ready for git. I also use the github to automatically create the repository in github, like so:

.. code:: bash

    git init
    gh repo create organization_name/repository_name        # This creates the github repo, and links the folder to the repo
    echo "_build" > .gitignore                              # This creates a .gitignore file that ignores the `_build` directory

- **Install Sphinx**. First, you're going to need to have a way to install ``sphinx`` both locally and in Netlify. Because sphinx is a python library, you need to install sphinx and its dependencies. This actually involves two steps, (1) declaring that you're going to use the Python runtime using a ``runtime.txt`` file in the root directory, and (2) identifying the dependencies that need to be installed using a ``requirements.txt`` file in the root directory. Heres' how:

.. code:: bash
    
    echo "3.7" > runtime.txt    # This declares that you're going to use python 3.7, not the default of python 2.7
    
    # These commands only work if you have poetry installed.
    poetry init
    poetry add sphinx
    poetry export -f requirements.txt -o requirements.txt

    ## These commands should be used if you *don't* have poetry installed
    # python -m venv venv
    # echo "venv/" >> .gitignore
    # source venv/bin/activate
    # pip install sphinx
    # pip freeze > requirements.txt

- **Set up Sphinx**. This is pretty simple, just run ``sphinx-quickstart`` and configure your repository.

.. code:: bash

    poetry run sphinx-quickstart
    
    ## If you are using the virtual environment and not poetry, run
    # sphinx-quickstart

- **Set up netlify**. The easiest thing to do here is to set up ``netlify`` using the netlify CLI. And that's as simple as running ``netlify init``. When you do it, you'll want to specify that you want to ``connect this directory with GitHub first``.But, the catch is that you want to make sure that you specify the right defaults for your published directory and build commands. So, either make sure to specify the correct defaults (build command ``make html``, and directory to deploy (``_build/html``) or create a ``netlify.toml`` file in your root directory, like so:

.. code:: bash

    cat <<EOF > netlify.toml
    [build]
        publish = "_build/html"
        command = "make html"
    EOF

    netlify init

- **Commit your changes and push**. Now, when you push to GitHub, you'll have a live website!

.. code:: bash

    git add .
    git commit -am "initial commit"
    git push origin main     
 
    # Note: If you get an error above because you haven't changed your default branch to `main`, you should.
    # For more information, see: https://www.hanselman.com/blog/easily-rename-your-git-default-branch-from-master-to-main

License
=======

`Attribution-ShareAlike 4.0 International (CC BY-SA 4.0) <https://creativecommons.org/licenses/by-sa/4.0/>`_