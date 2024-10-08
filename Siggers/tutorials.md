# Code tutorials
The following tutorials will teach you how to navigate machine learning and general Python in the SCC.

Feel free to email me if you have any questions!

Written by Emily Kim (ekim7@bu.edu)\
Updated 10/07/2024

## Conda environments

Conda is a package and environment management system. What does that mean?

 Python packages constantly get updates, and sometimes that means that your code will work using certain versions of packages but break using other versions. Whether that's because a command got updated or because a package is no longer compatible with another doesn't matter; you need to know the versions of the packages you are using so other people can replicate your code.

 Conda can help you avoid all of these troubles!

 You can customize the packages, their versions, and so much more using Conda. To learn more, check out the [Conda documentation.](https://docs.conda.io/projects/conda/en/latest/index.html)

 To learn how to setup your own conda environment in the SCC, follow the tutorial below.

### 1. Configure your `.condarc` file

Before you do anything, you need to configure your `.condarc` file. Open up command prompt, go to your home directory, and run the following code.

```
cd ~
module load miniconda
setup_scc_condarc.sh
```
Follow the instructions in the prompt. After you've finished, you should have a `.condarc` file in your home directory!

**NOTE:** If you want to configure your `.condarc` file manually to ensure your conda environment works correctly, open `.condarc`.

```python
cd ~

# nano will create a new file if it doesn't exist
nano .condarc
```

Copy the following text into the file.

```
envs_dirs:
    - /projectnb/your_project/your_loginname/.conda/envs
    - ~/.conda/envs
pkgs_dirs:
    - /projectnb/your_project/your_loginname/.conda/pkgs
    - ~/.conda/pkgs
env_prompt: ({name})
```

### 2. Create your Conda environment

Before you do anything, make sure that you `cd` into the directory that you specified in your `.condarc` file.

```
cd /projectnb/your_project/your_loginname/
```

BU recommends that you use the `mamba` command instead of `conda` for superior speed, so that's what this tutorial will use. Mamba creates a completely empty environment, so we have to donwload a version of Python. You can use any version of Python that suits your needs, but this tutorial will use python3.

```
mamba create -y -n custom_condaenv python3
```
To install a specific version, use `python=#`. For example, to install python 3.10, use `python=3.10` in place of `python3`.

To install multiple packages, separate the names using a space. You will need to do this if you plan on using Jupyter Notebook, Jupyter lab, or Spyder.

```
mamba create -y -n custom_condaenv python3 notebook jupyterlab spyder
```
### 3. Activate your Conda environment

Now that your Conda environment and `.condarc` files are setup, you can begin working in your Conda environment by activating it.

```
conda activate custom_condaenv
```

If everything has gone well, you should see `(custom_condaenv)` at the beginning of your command prompt lines.

### 4. Install more packages

Need to install more packages, but already created your Conda environment? No worries, you can install whatever you need, whenever.

For packages released via conda channels, use `mamba install`.
```
mamba install -y -c conda-forge spyder
```

For packages released via PyPI, use `pip install`.
```
pip install torch
```

### 5. Sharing Conda environments

Conda environments are often shared as YAML configuration files.

To install from a YAML file, use the following code.
```
mamba env create -n imported_env -f imported_env.yml
```

To export your environment as a YAML file, use the following code.
```python
# if you are in your environment
mamba activate exported_env
mamba env export -f exported_env.yml

# if you are not in your environment
mamba env export -n exported_env > exported_env.yml
```
### 6. Closing a Conda environment

Once you're finished with your Conda environment, you can exit out of it by using `deactivate`.

```
conda deactivate 
```

For more Mamba commands, check out the [Mamba documentation.](https://mamba.readthedocs.io/en/latest/index.html)'

## Conda environments & interactive sessions

Using your Conda environment in an interactive session is different from using it on the command line. In this tutorial, we'll use Jupyter Notebook as an example.

### 1. Module and pre-launch

In `List of module to load`, type `miniconda`.
In `Pre-Launch Command`, type `conda activate custom_condaenv`

### 2. Resources

If you intend on using machine learning/AI via an interactive session, make sure to give your program plenty of resources. I used 4 cores and 3 gpus with 3.5 GPU compute capability, but this may be overkill. Allocate your resources as needed.

### 3. Code

Congrats! You've successfully created a new Conda environment and loaded it onto Jupyter Notebook. Get out there and code as a reward!



