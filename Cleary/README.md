# MERFISH encoding probe design walkthrough
The following tutorial will teach you how the encoding probe design works in the SCC.\
Feel free to email me if you have any questions!

Written by Emily Kim (ekim7@bu.edu)\
Updated May 12, 2025

---

__In this tutorial__

[Set up your environment](#environment-setup)\
[Create a codebook](#codebook-creation)\
[Run the pipeline](#design-probes)

__Useful links__

[Link 1](https://github.com/ZhuangLab/MERFISH_analysis/tree/master): MERFISH analysis GitHub\
[Link 2](https://docs.google.com/document/d/1-OE-psR1LC2JGczlrk9iabiPNwXq9phNtuL6nlSYiW0/edit?tab=t.0): Code breakdown by Peter Bryan\
[Link 3](https://github.com/xingjiepan/MERFISH_probe_design/tree/main): Python implementation

# Environment setup

### 0. Set up GitHub

If this is your first time using GitHub on the SCC or your local computer, you need to set up Git and GitHub connections.

[Local Git setup](https://docs.github.com/en/get-started/git-basics/set-up-git)\
[SCC GitHub setup](https://www.bu.edu/tech/support/research/system-usage/connect-scc/access-and-security/using-scc-with-github-2fa/)

### 1. Clone the directory

Clone the [original MERFISH analysis pipeline][1] directory in your working directory.

[1]: https://github.com/ZhuangLab/MERFISH_analysis

```bash
# If you're logged into the SCC
git clone git@github.com:ZhuangLab/MERFISH_analysis.git

# If you're on your local computer
git clone https://github.com/ZhuangLab/MERFISH_analysis.git
```

### 2. Get data

This tutorial will use [Example MERFISH Data 2][2] from the Zhuang lab. However, if you have your own data, feel free to use it.

[2]: https://zhuang.harvard.edu/merfish.html

### 3. Modify all local paths

*Note: All code from here on will assume you are using the SCC.*

a) Navigate to `MERFISH_analysis/startup/merfish_startup.m` and modify the following lines to reflect the below code. An example script is found under [merfish_startup.m][3].

[3]: https://github.com/ehk-kim/BUrotations/blob/main/Cleary/merfish_startup.m

```matlab
% Lines 17-18
addpath('/share/pkg.8/matlab/2024b/')
%addpath('C:\Users\Jeff.Morgan0\Dropbox\ZhuangLab\MERFISH_Public\MERFISH_analysis\startup');

% Lines 27-31
scratchPath = 'scratch/';
pythonPath = '/share/pkg.7/python2/2.7.15'; 
matlabStormPath = 'matlab-storm/';  
stormAnalysisPath= 'storm-analysis/';  
%insightExe = 'C:\Utilities\STORMAnalysis\Insight3\InsightM.exe';

% Comment out lines 38-52

% Line 56
MERFISHAnalysisPath = ['./'];

% Comment out lines 61-62
```

b) Navigate to `MERFISH_analysis/example_scripts/library_design_example.m` and modify the following lines to reflect the below code. An example script is found under [library_design_example.m][4]. If you are using a reference with Ensembl IDs, see [library_design_exampleClusterWithoutByteStream.m][5] and modify the corresponding lines.

[4]: https://github.com/ehk-kim/BUrotations/blob/main/Cleary/library_design_example.m
[5]: https://github.com/ehk-kim/BUrotations/blob/main/Cleary/library_design_exampleClusterWithoutByteStream.m

```matlab
% Line 15
basePath = './';

% Lines 20-24: replace these with your own files, using file paths if necessary
rawTranscriptomeFasta = [basePath 'transcripts.fasta']; % Reference cDNA FASTA file
fpkmPath = [basePath 'isoforms.fpkm_tracking'];         % Abundance FPKM file
ncRNAPath = [basePath 'Homo_sapiens.GRCh38.ncrna.fa'];  % Reference ncDNA FASTA file
readoutPath = [basePath 'readouts.fasta'];              % Readout file of probes you want to use
codebookPath = [basePath 'codebook.csv'];               % Codebook that indicates each RNA species of interest and their intended barcode

% Line 27: change 'libraryDesign' to whatever name you want the outputs to go to.
%          this has to be reset every time you try to run a new probe design pipeline.
%          I recommend that you change the name every time you run a new pipeline.
analysisSavePath = SetFigureSavePath([basePath 'libraryDesign'], 'makeDir', true);

%% OPTIONAL
% Line 34: you can change the name to reflect your own specifications
trRegionsPath = [analysisSavePath 'tr_GC_43_63_Tm_66_76_Len_30_30_IsoSpec_0.75_1_Spec_0.75_1'];

%% USING ENSEMBL IDS:
% Lines 98-107
if ~exist(transcriptomePath)
    % Build transcriptome using existing abundance data
    transcriptome = TranscriptomeRegexEdit(rawTranscriptomeFasta, ...
        'abundPath', fpkmPath, ...
        'verbose', true, 'headerType','ensembl');
    transcriptome.Save(transcriptomePath);
else
    % Load transcriptome if it already exists
    transcriptome = TranscriptomeRegexEdit.Load(transcriptomePath);
end

% Line 136
'transferAbund', true, 'parallel', p);

% Line 211: change the abundance to your own specifications
goodIDs = ids(abund>=1e-2)

% Lines 234-240: modify these to your own specifications
targetRegions = trDesigner.DesignTargetRegions(...
		'regionLength', 30, ...
		'GC', [43 63]/100, ...
		'Tm', [66 76], ...
		'isoSpecificity', [0.75 1], ...
		'specificity', [0.75 1], ...
        'OTTables', {'rRNA', [0, 0]});

% Line 293-294: modify these to your own specifications
numProbesPerGene = 92;
libraryName = ['L1E1'];

% Line 335: modify the number to your own specifications. 2-4 are recommended.
localReadouts = possibleReadouts(randperm(length(possibleReadouts), 3));

% Line 337: modify the lines to your own specifications. 0-0.5 are recommended.
if rand(1) > 0.5

% Line 349: modify the number to your own specifications.
%   if using 2 in line 335, remove line 349.
%   if using 4 in line 335, add localReadouts(4).Header after line 349.
localReadouts(3).Header];

% Line 355: modify the lines to your own specifications. Same modifications as line 349.
seqrcomplement(localReadouts(3).Sequence)];

% Line 368: modify the lines to your own specifications. Same modifications as line 349.
localReadouts(3).Header ' ' ...

% Line 374: modify the lines to your own specifications. Same modifications as line 349.
seqrcomplement(localReadouts(3).Sequence)];

% Lines 435-443: modify the numbers to your own specifications.
prDesigner = PrimerDesigner('numPrimersToGenerate', 1e3, ...
    'primerLength', 20, ...                  % length of primer
    'OTTables', encodingProbeOTTable, ...
    'OTTableNames', {'encoding'}, ...
    'parallel', p);
% Cut primers
prDesigner.CutPrimers('Tm', [70 72], ...     % melting temperatures
    'GC', [.5 .65], ...                      % GC content
```
c) Now that all custom lines are modified, add a few lines to ensure that the code can be run in the SCC.

```matlab
%% USING ENSEMBL IDS:
% Line 275
codebook = LoadCodebook(codebookPath);
load('/path/to/Tmaxstr_49.mat');
for x = 1:size(Tmaxstr,1)
    codebook(x).barcode = char(Tmaxstr(x));
end

% Add this section between the "Build transcriptome object" section and the "Build isoform specificity table" section.
% % ------------------------------------------------------------------------
% Configure parallel.Pool
% %-------------------------------------------------------------------------
%% Create parallel pool... speeds up the construction of the TRDesigner and the construction of libraries
if isempty(gcp('nocreate'))
    p = parpool(8);  % Insert a number here appropriate to the used computational resources
else
    p = gcp;
end

% Line 11
addpath('startup/')
merfish_startup;

addpath(genpath('matlab-storm-master'));
addpath(genpath('MERFISH_analysis-master'));

```

d) If you're using Ensembl IDs, navigate to `MERFISH_analysis/probe_construction/TRDesigner.m` and make the following changes.

```matlab
% Line 110
if (~isempty(obj.transcriptome) && ~strcmp(class(obj.transcriptome), 'Transcriptome')) && (~isempty(obj.transcriptome) && ~strcmp(class(obj.transcriptome), 'TranscriptomeRegexEdit'))
```

Navigate to `MERFISH_analysis/probe_construction/OTTable.m` and make the following changes.
```matlab
% Line 157
if (isa(targetSequences, 'Transcriptome') || isa(targetSequences, 'TranscriptomeRegexEdit'))

% Add this after line 137
case 'TranscriptomeRegexEdit'
    % Same as above
```

# Codebook creation

To design larger experiments, use `MERFISH_analysis/example_scripts/code_construction_script.m` to create a codebook. However, for a smaller experiment, use [this codebook][7] or [this one][8] as a template and create your own.

[7]: https://github.com/ehk-kim/BUrotations/blob/main/Cleary/example_files/codebook_cm1_all49.csv
[8]: https://github.com/ehk-kim/BUrotations/blob/main/Cleary/example_files/codebook_2.csv

# Design probes

Now that you have all of your edited files and your codebook, use [run_merfish_analysis.sh][6] to run everything in the SCC. Make sure that `library_design_example.m` and `run_merfish_analysis.sh` are in the `MERFISH_analysis` path and not in the other nested folders. Change the qsub options as needed.

[6]: https://github.com/ehk-kim/BUrotations/blob/main/Cleary/run_merfish_analysis.sh

```bash
cd /path/to/run_merfish_analysis.sh
qsub run_merfish_analysis.sh
```