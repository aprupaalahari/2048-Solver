function start()
% Load a menu to start off the game with specific colors (green, blue, red). 
% The interface consists of three buttons organized vertically on the
% figure window. 

% Initialize the figure/gui window and center
ss = [1 1 940 940].*0.75;
fig = figure('Position',ss.*.65);
movegui(fig,'center')

% Create buttons on the interface. The callback for each button
% calls the function TwentyFortyEight() and sends in an additional 
% argument, the initial color scheme of the game to be played. 

% Create a Textbox to display the title of the game
uicontrol('Style','text', 'Units','Normalized','Position',...
    [0.1 0.7 0.8 0.2],'FontName','Arial','FontSize',45, 'String','2048')
% Instructions
uicontrol('Style','text', 'Units','Normalized','Position',...
    [0.1 0.45 0.8 0.2],'FontName','Arial','FontSize',12, 'String','Choose a color scheme, then combine the numbers to get to 2048!')


% Color Scheme Data:
colorBeach = {[128 128 128], [249 249 249], [236 232 220], [220 216 205], [233 208 140], [195 204 122], [151 201 166], [147, 216, 213], [121, 234, 217], [189 221 173], [159, 173, 164], [116 128 147]};
colorWater = {[128 128 128], [249 249 249], [235 235 235], [197 198 198], [178 176 176], [155 156 155], [188 227 250], [124 205 244], [0 169 226], [0 123 186], [44 66 104], [35 35 59]};
colorPeach = {[128 128 128], [249 249 249], [254 200 154], [252 210 175], [249 220 196], [249 229 216], [249 233 226], [248 237 235], [250 225, 221], [252 213 206], [254 197 187], [255 181 167]};
% Beach Vibes Option
uicontrol('Style','Pushbutton','Units','Normalized','Position',...
    [0.1 0.4 0.8 0.1],'FontName','Arial','String','Beach', 'BackgroundColor', [233 208 140]./255,...
    'CallBack', {@TwentyFortyEight,colorBeach})
uicontrol('Style','Pushbutton','Units','Normalized','Position',...
    [0.1 0.25 0.8 0.1],'FontName','Arial','String','Water', 'BackgroundColor', [188 227 250]./255,...
    'CallBack', {@TwentyFortyEight,colorWater})
uicontrol('Style','Pushbutton','Units','Normalized','Position',...
    [0.1 0.1 0.8 0.1],'FontName','Arial','String','Peach', 'BackgroundColor', [252 213 206]./255,...
    'CallBack', {@TwentyFortyEight,colorPeach})


% Pastel Option
% uicontrol('Style','Pushbutton','Units','Normalized','Position',...
    % [0.1 0.1 0.8 0.2],'FontName','Arial','String','Pastel','BackgroundColor', [204/255, 229/255, 255/255],...
    % 'CallBack', {@TwentyFortyEight,colorPastel})



