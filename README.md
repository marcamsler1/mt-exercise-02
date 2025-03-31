# MT Exercise 2: Pytorch RNN Language Models

This repo shows how to train neural language models using [Pytorch example code](https://github.com/pytorch/examples/tree/master/word_language_model). Thanks to Emma van den Bold, the original author of these scripts. 

# Requirements

- This only works on a Unix-like system, with bash.
- Python 3 must be installed on your system, i.e. the command `python3` must be available
- Make sure virtualenv is installed on your system. To install, e.g.

    `pip install virtualenv`

# Steps

Clone this repository in the desired place:

    git clone https://github.com/marcamsler1/mt-exercise-02
    cd mt-exercise-02

Create a new virtualenv that uses Python 3. Please make sure to run this command outside of any virtual Python environment:

    ./scripts/make_virtualenv.sh

**Important**: Then activate the env by executing the `source` command that is output by the shell script above.

Download and install required software:

    ./scripts/install_packages.sh

Download and preprocess data:

    ./scripts/download_data.sh

Note:
We made a small modification to download_data.sh because the wget command didn't work on our system (Windows with Git Bash).
Instead of wget, we used curl to download the dataset.
We also adjusted this file to download the text of the book "Frankenstein" from the Project Gutenberg website and preprocess it.

Train a model:

    ./scripts/train.sh

The training process can be interrupted at any time, and the best checkpoint will always be saved.

Note:
We adjusted this file so that it trains models with five different dropout rates (0, 0.3, 0.4, 0.5, 0.6). It uses the previously downloaded Frankenstein data set for training the models, which is required for exercise 2.

Generate (sample) some text from a trained model with:

    ./scripts/generate.sh

To plot the log files, run:

    python scripts/plot_data.py logs/*.txt

Additional information:

We misunderstood the part of the exercise to create tables for each of the perplexities and instead created a "table" for each of the different dropout rates. The plots are still created correctly, but the process to create the plots is different from the instructions in the assignment. The first row of the log files (one for each dropout rate) contains the train perplexities for each epoch, while the second row contains the validation perplexities. Finally, the last row starts with "Test" and contains the test perplexity.





