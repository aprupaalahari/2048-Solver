function TwentyFortyEight(~, ~, colorCellArray)

% close existing figure windows
close all 

% Initialize the figure and assign the callback functions for key press
ss = [1 1 940 940].*0.75;
fig = figure('Position',ss);
movegui(fig,'center')
set(gcf,'color','Black');

% initialize board, values, and state
initialBoard = zeros(4, 4);
initialBoard = addTile(initialBoard);
numUndo = 0;
setappdata(fig,'board', initialBoard)
setappdata(fig,'lastBoard', initialBoard)
setappdata(fig,'numUndo', numUndo)

% display title 
uicontrol('Style','text','Units','Normalized','Position',...
    [0.01 0.55 0.4 0.4],'FontName','Arial','FontSize',60, 'String','2048','ForegroundColor', 'White', 'BackgroundColor', 'Black');
% background color
uicontrol('Style','text','Units','Normalized','Position',...
    [0.09 0.09 0.615 0.615],'FontName','Arial','FontSize',50, 'String','','BackgroundColor', [128 128 128]./255);
% message
message = uicontrol('Style','text','Units','Normalized','Position',...
    [0.5 0.775 0.4 0.06],'FontName','Arial','FontSize',12, 'String','Good Luck! Remember, you only get one Undo.','ForegroundColor', [128 128 128]./255, 'BackgroundColor', 'Black');
% score
points = uicontrol('Style','Text','Units','Normalized','Position',...
    [0.5 0.85 0.4 0.1],'FontName','Arial','FontSize',30, 'String','Score: ','ForegroundColor', [128 128 128]./255, 'BackgroundColor', 'black');

% adding text boxes to show the current board
squareLocations = {[0.1 0.55 0.145 0.145], [0.1 0.4 0.145 0.145], [0.1 0.25 0.145 0.145], [0.1 0.1 0.145 0.145],...
    [0.25 0.55 0.145 0.145], [0.25 0.4 0.145 0.145], [0.25 0.25 0.145 0.145], [0.25 0.1 0.145 0.145],...
    [0.4 0.55 0.145 0.145], [0.4 0.4 0.145 0.145], [0.4 0.25 0.145 0.145], [0.4 0.1 0.145 0.145],...
    [0.55 0.55 0.145 0.145], [0.55 0.4 0.145 0.145], [0.55 0.25 0.145 0.145], [0.55 0.1 0.145 0.145]};

% placing squares for board spots
square1 = uicontrol('Style','text','Units','Normalized','Position',squareLocations{1},'FontName','Arial','FontSize',20, 'String','','BackgroundColor', [128 128 128]./225);
square2 = uicontrol('Style','text','Units','Normalized','Position',squareLocations{2},'FontName','Arial','FontSize',20, 'String','','BackgroundColor', [128 128 128]./225);
square3 = uicontrol('Style','text','Units','Normalized','Position',squareLocations{3},'FontName','Arial','FontSize',20, 'String','','BackgroundColor', [128 128 128]./225);
square4 = uicontrol('Style','text','Units','Normalized','Position',squareLocations{4},'FontName','Arial','FontSize',20, 'String','','BackgroundColor', [128 128 128]./225);
square5 = uicontrol('Style','text','Units','Normalized','Position',squareLocations{5},'FontName','Arial','FontSize',20, 'String','','BackgroundColor', [128 128 128]./225);
square6 = uicontrol('Style','text','Units','Normalized','Position',squareLocations{6},'FontName','Arial','FontSize',20, 'String','','BackgroundColor', [128 128 128]./225);
square7 = uicontrol('Style','text','Units','Normalized','Position',squareLocations{7},'FontName','Arial','FontSize',20, 'String','','BackgroundColor', [128 128 128]./225);
square8 = uicontrol('Style','text','Units','Normalized','Position',squareLocations{8},'FontName','Arial','FontSize',20, 'String','','BackgroundColor', [128 128 128]./225);
square9 = uicontrol('Style','text','Units','Normalized','Position',squareLocations{9},'FontName','Arial','FontSize',20, 'String','','BackgroundColor', [128 128 128]./225);
square10 = uicontrol('Style','text','Units','Normalized','Position',squareLocations{10},'FontName','Arial','FontSize',20, 'String','','BackgroundColor', [128 128 128]./225);
square11 = uicontrol('Style','text','Units','Normalized','Position',squareLocations{11},'FontName','Arial','FontSize',20, 'String','','BackgroundColor', [128 128 128]./225);
square12 = uicontrol('Style','text','Units','Normalized','Position',squareLocations{12},'FontName','Arial','FontSize',20, 'String','','BackgroundColor', [128 128 128]./225);
square13 = uicontrol('Style','text','Units','Normalized','Position',squareLocations{13},'FontName','Arial','FontSize',20, 'String','','BackgroundColor', [128 128 128]./225);
square14 = uicontrol('Style','text','Units','Normalized','Position',squareLocations{14},'FontName','Arial','FontSize',20, 'String','','BackgroundColor', [128 128 128]./225);
square15 = uicontrol('Style','text','Units','Normalized','Position',squareLocations{15},'FontName','Arial','FontSize',20, 'String','','BackgroundColor', [128 128 128]./225);
square16 = uicontrol('Style','text','Units','Normalized','Position',squareLocations{16},'FontName','Arial','FontSize',20, 'String','','BackgroundColor', [128 128 128]./225);
cellArraySquares = {square1,square2,square3,square4,square5,square6,square7,square8,square9,square10,square11,square12,square13,square14,square15,square16};
set(fig, 'KeyPressFcn', {@keyboardCallback, fig});
% Pushbutton to perform single solve on the board
uicontrol('Style','Pushbutton','Units','Normalized','Position',...
    [0.75 0.4 0.2 0.075],'FontName','Arial','FontSize',8, 'String','SINGLE STEP SOLVE','BackgroundColor', 'White', ...
    'Callback', {@singleMoveClick,fig,cellArraySquares});
% Pushbutton to undo
uicontrol('Style','Pushbutton','Units','Normalized','Position',...
    [0.75 0.3 0.2 0.075],'FontName','Arial','FontSize',8, 'String','UNDO','BackgroundColor', 'White', 'Callback',...
    {@undoButtonClick,fig,cellArraySquares});
% Pushbutton to full-solve 1
uicontrol('Style','Pushbutton','Units','Normalized','Position',...
    [0.75 0.5 0.1 0.075],'FontName','Arial','FontSize',6, 'String','FULL SOLVE 1','BackgroundColor', 'White',...
    'Callback',{@fullSolveClick1,fig, cellArraySquares});
% Pushbutton to full-solve 2
uicontrol('Style','Pushbutton','Units','Normalized','Position',...
    [0.85 0.5 0.1 0.075],'FontName','Arial','FontSize',6, 'String','FULL SOLVE 2','BackgroundColor', 'White',...
    'Callback',{@fullSolveClick2,fig, cellArraySquares});
% Pushbuttons to move board manually (up, down, right, left)
uicontrol('Style','Pushbutton','Units','Normalized','Position',...
    [0.815 0.215 0.075 0.05],'FontName','Arial','FontSize',6, 'String','UP','BackgroundColor', 'White',...
    'Callback',{@upClick,fig, cellArraySquares});
uicontrol('Style','Pushbutton','Units','Normalized','Position',...
    [0.815 0.15 0.075 0.05],'FontName','Arial','FontSize',6, 'String','DOWN','BackgroundColor', 'White',...
    'Callback',{@downClick,fig, cellArraySquares});
uicontrol('Style','Pushbutton','Units','Normalized','Position',...
    [0.9 0.15 0.075 0.05],'FontName','Arial','FontSize',6, 'String','RIGHT','BackgroundColor', 'White',...
    'Callback',{@rightClick,fig, cellArraySquares});
uicontrol('Style','Pushbutton','Units','Normalized','Position',...
    [0.73 0.15 0.075 0.05],'FontName','Arial','FontSize',6, 'String','LEFT','BackgroundColor', 'White',...
    'Callback',{@leftClick,fig, cellArraySquares});

%% DEFINING CALLBACK FUNCTIONS

function upClick(hObj,event,fig,cellArraySquares)
    playBoard = getappdata(fig,'board');
    setappdata(fig,'lastBoard',playBoard)
    GameOver = isGameOver(playBoard);
    if ~GameOver % is true
        % perform singleSolveMove
        playBoard = moveUp(playBoard);
        setappdata(fig,'board',playBoard)
        plotBoard(playBoard, cellArraySquares, colorCellArray)
    else
        set(message,'String', 'Game Over')
        pause(1)
        % Close the ball drop figure window.
        close(fig)
        % Execute the function listed in returnFnc
        TwentyFortyEightMenu()
    end
end

function downClick(hObj,event,fig,cellArraySquares)
    playBoard = getappdata(fig,'board');
    setappdata(fig,'lastBoard',playBoard)
    GameOver = isGameOver(playBoard);
    if ~GameOver % is true
        % perform singleSolveMove
        playBoard = moveDown(playBoard);
        setappdata(fig,'board',playBoard)
        plotBoard(playBoard, cellArraySquares, colorCellArray)
    else
        set(message,'String', 'Game Over')
        pause(1)
        % Close the ball drop figure window.
        close(fig)
        % Execute the function listed in returnFnc
        TwentyFortyEightMenu()
    end
end

function rightClick(hObj,event,fig,cellArraySquares)
    playBoard = getappdata(fig,'board');
    setappdata(fig,'lastBoard',playBoard)
    GameOver = isGameOver(playBoard);
    if ~GameOver % is true
        % perform singleSolveMove
        playBoard = moveRight(playBoard);
        setappdata(fig,'board',playBoard)
        plotBoard(playBoard, cellArraySquares, colorCellArray)
    else
        set(message,'String', 'Game Over')
        pause(1)
        % Close the ball drop figure window.
        close(fig)
        % Execute the function listed in returnFnc
        TwentyFortyEightMenu()
    end
end

function leftClick(hObj,event,fig,cellArraySquares)
    playBoard = getappdata(fig,'board');
    setappdata(fig,'lastBoard',playBoard)
    GameOver = isGameOver(playBoard);
    if ~GameOver % is true
        % perform singleSolveMove
        playBoard = moveLeft(playBoard);
        setappdata(fig,'board',playBoard)
        plotBoard(playBoard, cellArraySquares, colorCellArray)
    else
        set(message,'String', 'Game Over')
        pause(1)
        % Close the ball drop figure window.
        close(fig)
        % Execute the function listed in returnFnc
        TwentyFortyEightMenu()
    end
end

function undoButtonClick(hObj,event,fig,cellArraySquares)
    % can only click Undo once!
    numberUndo = getappdata(fig,'numUndo');
    if numberUndo == 0
        playBoard = getappdata(fig,'lastBoard');
        GameOver = isGameOver(playBoard);
        if ~GameOver % is true
            setappdata(fig,'board',playBoard)
            plotBoard(playBoard, cellArraySquares, colorCellArray)
        else
            set(message,'String', 'Game Over')
            pause(1)
            % Close the ball drop figure window.
            close(fig)
            % Execute the function listed in returnFnc
            TwentyFortyEightMenu()
            end
        % 'grey out' the undo button
        uicontrol('Style','Pushbutton','Units','Normalized','Position',[0.75 0.3 0.2 0.1],'FontName','Arial','FontSize',8, 'String','UNDO','BackgroundColor', [128 128 128]./255);
    end
end

function singleMoveClick(hObj,event,fig,cellArraySquares)
    playBoard = getappdata(fig,'board');
    setappdata(fig,'lastBoard',playBoard)
    GameOver = isGameOver(playBoard);
    if ~GameOver % is true
        % perform singleSolveMove
        playBoard = singleMoveSolve(playBoard);
        setappdata(fig,'board',playBoard)
        plotBoard(playBoard, cellArraySquares, colorCellArray)
    else
        set(message,'String', 'Game Over')
        pause(1)
        % Close the ball drop figure window.
        close(fig)
        % Execute the function listed in returnFnc
        TwentyFortyEightMenu()
    end
end

function keyboardCallback(~,eventdata,fig)
    playBoard = getappdata(fig,'board');
    setappdata(fig,'lastBoard',playBoard)
    GameOver = isGameOver(playBoard);
    if ~GameOver % is true
        switch eventdata.Key
        case 'uparrow'
            playBoard = moveUp(playBoard);
            setappdata(fig,'board',playBoard)
            plotBoard(playBoard, cellArraySquares, colorCellArray)
        case 'downarrow'
            playBoard = moveDown(playBoard);
            setappdata(fig,'board',playBoard)
            plotBoard(playBoard, cellArraySquares, colorCellArray)
        case 'rightarrow'
            playBoard = moveRight(playBoard);
            setappdata(fig,'board',playBoard)
            plotBoard(playBoard, cellArraySquares, colorCellArray)
        case 'leftarrow'
            playBoard = moveLeft(playBoard);
            setappdata(fig,'board',playBoard)
            plotBoard(playBoard, cellArraySquares, colorCellArray)
            otherwise % wrong key pressed
            disp('Key not mapped')
        end
        setappdata(fig,'board',playBoard)
    else
        set(message,'String', 'Game Over')
        pause(1)
        % Close the ball drop figure window.
        close(fig)
        % Execute the function listed in returnFnc
        TwentyFortyEightMenu()
    end
end

function fullSolveClick1(hObj,event,fig,cellArraySquares)
    set(message,'String', 'Wait a Moment...')
    playBoard = getappdata(fig,'board');
    GameOver = isGameOver(playBoard);
    while ~GameOver % is true
        GameOver = isGameOver(playBoard);
        allMoves = fullSolve(playBoard);
        for ii = 1:length(allMoves)
            pause(0.1)
            bestMove = allMoves(ii);
            if bestMove == 1
                playBoard = moveUp(playBoard);
            elseif bestMove == 2
                playBoard = moveDown(playBoard);
            elseif bestMove == 3
                playBoard = moveRight(playBoard);
            elseif bestMove == 4
                playBoard = moveLeft(playBoard);
            end
            setappdata(fig,'board',playBoard)
            plotBoard(playBoard, cellArraySquares, colorCellArray)
        end
        % 'grey out' the undo button
        uicontrol('Style','Pushbutton','Units','Normalized','Position',[0.75 0.3 0.2 0.1],'FontName','Arial','FontSize',8, 'String','UNDO','BackgroundColor', 'white');
        set(message,'String', 'Game Over')
    end
    set(message,'String', 'Game Over')
    pause(0.5)
    % Close the ball drop figure window.
    close(fig)
    % Execute the function listed in returnFnc
    TwentyFortyEightMenu()
end

function fullSolveClick2(hObj,event,fig,cellArraySquares)
    set(message,'String', 'Wait a Moment...')
    playBoard = getappdata(fig,'board');
    GameOver = isGameOver(playBoard);
    while ~GameOver % is true
        GameOver = isGameOver(playBoard);
        allBestMoves = fullSolve2(playBoard);
        for ii = 1:length(allBestMoves)
            pause(0.1)
            currentMove = allBestMoves(ii);
            if currentMove == 1
                playBoard = moveUp(playBoard);
            elseif currentMove == 2
                playBoard = moveDown(playBoard);
            elseif currentMove == 3
                playBoard = moveRight(playBoard);
            elseif currentMove == 4
                playBoard = moveLeft(playBoard);
            end
            setappdata(fig,'board',playBoard)
            plotBoard(playBoard, cellArraySquares, colorCellArray)
        end
        % 'grey out' the undo button
        uicontrol('Style','Pushbutton','Units','Normalized','Position',[0.75 0.3 0.2 0.1],'FontName','Arial','FontSize',8, 'String','UNDO','BackgroundColor', 'white');
        set(message,'String', 'Game Over')
    end
    set(message,'String', 'Game Over')
    pause(0.5)
    % Close the ball drop figure window.
    close(fig)
    % Execute the function listed in returnFnc
    TwentyFortyEightMenu()
end

%% DEFINING ALL OTHER FUNCTIONS

function board = moveUp(board)
% input = current board
% output = updated board with up move + added tile

adjustBoard = board;
% going through columns on board
for ii = 1:size(adjustBoard, 2)
    column = adjustBoard(:, ii);
    column(column == 0) = [];
		
    for jj = 1:length(column) - 1
        % check to combine tiles if equal
        if column(jj) == column(jj+1)
			column(jj:jj+1) = [2*column(jj); 0];
        end
    end
    column(column == 0) = [];
    % displaying 0s at end of the column
    if length(column) < length(adjustBoard)
        column(end+1: length(adjustBoard))= 0;
    end
    adjustBoard(:, ii) = column;
end

if all(adjustBoard, 'all')
    % board is full, can't add another tile (game may not be over though!)
    board = adjustBoard;
elseif any(adjustBoard ~= board, 'all')
    % there is space for a tile, add one
    board = addTile(adjustBoard);
else
    board = adjustBoard;
end
end

function board = moveDown(board)
% input = current board
% output = updated board with down move + added tile

adjustBoard = flipud(board);
% going through columns on board
for ii = 1:size(adjustBoard, 2)
    column = adjustBoard(:, ii);
    column(column == 0) = [];
		
    for jj = 1:length(column) - 1
        % check to combine tiles if equal
        if column(jj) == column(jj+1)
			column(jj:jj+1) = [2*column(jj); 0];
        end
    end
    column(column == 0) = [];
    % displaying 0s at end of the column
    if length(column) < length(adjustBoard)
        column(end+1: length(adjustBoard))= 0;
    end
    adjustBoard(:, ii) = column;
end

if all(adjustBoard, 'all')
    % board is full, can't add another tile (game may not be over though!)
    board = flipud(adjustBoard);
elseif any(flipud(adjustBoard) ~= board, 'all')
    % there is space for a tile, add one
    board = addTile(flipud(adjustBoard));
else
    board = flipud(adjustBoard);
end
end

function board = moveRight(board)
% input = current board
% output = updated board with right move + added tile	

adjustBoard = rot90(board);
% going through columns on board
for ii = 1:size(adjustBoard, 2)
    column = adjustBoard(:, ii);
    column(column == 0) = [];
		
    for jj = 1:length(column) - 1
        % check to combine tiles if equal
        if column(jj) == column(jj+1)
			column(jj:jj+1) = [2*column(jj); 0];
        end
    end
    column(column == 0) = [];
    % displaying 0s at end of the column
    if length(column) < length(adjustBoard)
        column(end+1: length(adjustBoard))= 0;
    end
    adjustBoard(:, ii) = column;
end

if all(adjustBoard, 'all')
    % board is full, can't add another tile (game may not be over though!)
    board = rot90(adjustBoard, -1);
elseif any(rot90(adjustBoard, -1) ~= board, 'all')
    % there is space for a tile, add one
    board = addTile(rot90(adjustBoard, -1));
else
    board = rot90(adjustBoard, -1);

end
end

function board = moveLeft(board)
% input = current board
% output = updated board with left move + added tile

adjustBoard = rot90(board, -1);
% going through columns on board
for ii = 1:size(adjustBoard, 2)
    column = adjustBoard(:, ii);
    column(column == 0) = [];
		
    for jj = 1:length(column) - 1
        % check to combine tiles if equal
        if column(jj) == column(jj+1)
			column(jj:jj+1) = [2*column(jj); 0];
        end
    end
    column(column == 0) = [];
    % displaying 0s at end of the column
    if length(column) < length(adjustBoard)
        column(end+1: length(adjustBoard))= 0;
    end
    adjustBoard(:, ii) = column;
end

if all(adjustBoard, 'all')
    % board is full, can't add another tile (game may not be over though!)
    board = rot90(adjustBoard);
elseif any(rot90(adjustBoard) ~= board, 'all')
    % there is space for a tile, add one
    board = addTile(rot90(adjustBoard));
else 
    board = rot90(adjustBoard);
end
end

function score = scorer(board)
% input = board
score = sum(board, 'all');
% deduct 8 points for every single solve move
% score = score - 8*solves;
% moved above code to 
end

function gameOver = isGameOver(board)
% function to check if game is lost
% input = current board
% ouput = logical (true = game is over/lost)
checkBoard = board;
% check if the board is full
if all(checkBoard, 'all')
    checker = 0;
    % trying all 4 moves
	tryBoard = moveUp(checkBoard);
    if tryBoard == checkBoard
        checker = checker + 1;
    end
    tryBoard = moveDown(checkBoard);
    if tryBoard == checkBoard
        checker = checker + 1;
    end
    tryBoard = moveRight(checkBoard);
    if tryBoard == checkBoard
        checker = checker + 1;
    end
    tryBoard = moveLeft(checkBoard);
    if tryBoard == checkBoard
        checker = checker + 1;
    end
    
    % check to see if all moves were impossible (all tryBoard = checkBoard)
    if checker == 4
        gameOver = true;
    else
        gameOver = false;
    end
else
	gameOver = false;
end
end

function board = addTile(board)
% input = the current board
% output = a new board with randomly added tile
adjustBoard = board;
% new number is 2 or 4 in 9:1 ratio
num = randTwoOrFour;
% creates a vector of indices of open spots
openSpots = find(~adjustBoard);
% choose a random spot from openSpots
randomSpot = openSpots(randi(length(openSpots)));
% adding a 2 or a 4 to this random spot
adjustBoard(randomSpot) = num;
board = adjustBoard;
end

function [board, bestMove] = singleMoveSolve(board)
% input = the current board
% output = move that should be used (give as a number)
% can only be called if the game is not over!
simBoard = board;
% do each move once
simBoardUp = moveUp(simBoard);
simBoardDown = moveDown(simBoard);
simBoardRight = moveRight(simBoard);
simBoardLeft = moveLeft(simBoard);
% cell array of initial moves
numTrials = 10000;
initialMoves = {simBoardUp, simBoardDown, simBoardRight, simBoardLeft};
initialMovesScores = {zeros(1, numTrials), zeros(1, numTrials), zeros(1, numTrials), zeros(1, numTrials)};
for ii = 1:length(initialMoves)
    % feed in starting array
    simBoard = initialMoves{ii};
    thisGame = true;
    for numTrial = 1:numTrials
        while thisGame
            % check if game is over
            gameOver = isGameOver(simBoard);
            if gameOver
                thisGame = false; % stops the while loop, game has finished
                % return
            end
            % picking rest of the moves randomly until simulated game ends
            simBoard = performRandomMove(simBoard);
        end
        score = scorer(simBoard);
        initialMovesScores{ii}(numTrial) = score;
    end
end

averageScoreUp = mean(initialMovesScores{1});
averageScoreDown = mean(initialMovesScores{2});
averageScoreRight = mean(initialMovesScores{3});
averageScoreLeft = mean(initialMovesScores{4});

initialMovesScores = [averageScoreUp, averageScoreDown, averageScoreRight, averageScoreLeft];
% want to output the move that gave highest score based on averaged randomized moves
% following initial move

[~, mapping] = sort(initialMovesScores); % lowest to highest
movesArray = 1:4; % order: up, down, left, right
bestMove = movesArray(mapping(end)); % chooses move with best outcome
% perform the best move
if bestMove == 1
    board = moveUp(board);
elseif bestMove == 2
    board = moveDown(board);
elseif bestMove == 3
    board = moveRight(board);
elseif bestMove == 4
    board = moveLeft(board);
end
end

function num = randTwoOrFour()
% input = N/A
% output = 2 or 4 (9:1 ratio)

randNum = randi(10);
% want 9:1 ratio of 2s and 4s 
if randNum == 1 
    num = 4;
else % randNum == 2, 3, 4, 5, 6, 7, 8, 9, 10
    num = 2;
end
end

function allMoves = fullSolve(board)
% input = current board
% output = array of moves to make on board to full solve
% solves the board with list of moves chosen by solver
simBoard = board;
% start off with game on
thisGame = true;
% initialize array of moves to play
allMoves = [];
while thisGame
    gameOver = isGameOver(simBoard);
    if gameOver
        thisGame = false; % stops the while loop, game has ended
    end
    % calculate best move for game (up, down, right, left)
    [~, bestMove] = singleMoveSolve(simBoard);
    % add this best move to an array of moves to play in big function
    allMoves(end+1) = bestMove;
    % implement that best move to update simBoard accordingly
    if bestMove == 1
        simBoard = moveUp(simBoard);
    elseif bestMove == 2
        simBoard = moveDown(simBoard);
    elseif bestMove == 3
        simBoard = moveRight(simBoard);
    else
        simBoard = moveLeft(simBoard);
    end
end
end

function plotBoard(board, cellArraySquares, colorCellArray)
% inputs = color scheme, board, and cell array of square objects
% output = add to plot figure

possibleNumbers = [0 2 4 8 16 32 64 128 256 512 1024 2048];

% setting the score on the figure
scored = scorer(board);
% scoreString = string(scored);
set(points,'String', ['Score: ', num2str(scored)])

for ii = 1:length(cellArraySquares)
    thisNumber = board(ii);
    % writing numbers to strings
    if thisNumber ~= 0
        thisNumberString = string(thisNumber);
    elseif thisNumber == 0
        thisNumberString = string();
    end
    % choosing colors for blocks
    if thisNumber > 2048
        color = 'yellow'; % a generic color for numbers beyond 2048
    else
        for jj = 1:length(possibleNumbers)
            if thisNumber == possibleNumbers(jj)
                color = colorCellArray{jj}./255; % appropriate color according to value
            end
        end
    end
    set(cellArraySquares{ii}, 'String', thisNumberString)
    set(cellArraySquares{ii}, 'BackgroundColor', color)
end
end
        
function simBoard = performRandomMove(simBoard)
% function that performs random moves to be used in single step solve
% input = N/A
% output = randomly moved board
randNum = randi(4);
if randNum == 1 
    simBoard = moveUp(simBoard);
elseif randNum == 2
    simBoard = moveDown(simBoard);
elseif randNum == 3 
    simBoard = moveRight(simBoard);
elseif randNum == 4
    simBoard = moveLeft(simBoard);
end
end

function allBestMoves = fullSolve2(board)
% input = current board
% output = array of moves to make on board to full solve
% solves the board with list of moves chosen by solver
% start off with game on
n = 500; % trying 500 randomized games
% initialize array of moves to play
cellArrayGames = cell(1, n); % cell array where each index is the moves made
largeNumberArray = zeros(1, n); % largest number in the simulated game
for ii = 1:n
    simBoard = board;
    thisGame = true;
    while thisGame
        gameOver = isGameOver(simBoard);
        if gameOver
            thisGame = false; 
        end
        
        move = randomMovePicker();
        cellArrayGames{n}(end+1) = move;
        if move == 1
            simBoard = moveUp(simBoard);
        elseif move == 2
            simBoard = moveDown(simBoard);
        elseif move == 3
            simBoard = moveRight(simBoard);
        elseif move == 4
            simBoard = moveLeft(simBoard);
        end
    end
    endingBoard = simBoard;
    largeNumberArray(ii) = max(endingBoard, [], 'all');
end
[~, mapping] = sort(largeNumberArray);
allBestMoves = cellArrayGames{mapping(end)};
end

function move = randomMovePicker()
% function that chooses random moves until simulated game is over for each
% single step solve
% input = N/A
% output = random choice of a move from up, down, left, right (as a number)
randNum = randi(4);
if randNum == 1 
    move = 1;
elseif randNum == 2
    move = 2;
elseif randNum == 3 
    move = 3;
elseif randNum == 4
    move = 4;
end
end
end
