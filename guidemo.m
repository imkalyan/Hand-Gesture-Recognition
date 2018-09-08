function varargout = guidemo(varargin)

gui_Singleton = 1;

gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guidemo_OpeningFcn, ...
                   'gui_OutputFcn',  @guidemo_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function guidemo_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
% clear;

sss='0';
set(handles.timer,'String',sss);
sss='0';
set(handles.edit2,'String',sss);
sss='0';
set(handles.edit4,'String',sss);
a=ones(256,320);
axes(handles.axes1);
imshow(a);

b=ones(256,256);
%axes(handles.axes2);
%imshow(b);
axes(handles.axes3);
imshow(b);
axes(handles.axes4);
imshow(b);
axes(handles.axes5);
imshow(b);
axes(handles.axes6);
imshow(b);
guidata(hObject, handles);

% uiwait(handles.figure1);


function varargout = guidemo_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


function Start_Callback(hObject, eventdata, handles)


%sss='Capturing Background';
%set(handles.edit2,'String',sss);
%set(handles.edit4,'String',sss);

vid=videoinput('winvideo',1,'YUY2_640x480'); 
set(vid,'ReturnedColorSpace','rgb');                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
triggerconfig(vid,'manual'); 
%Capture one frame per trigger
set(vid,'FramesPerTrigger',1 );
set(vid,'TriggerRepeat', Inf);
start(vid); %start video

 BW = imread('mask.bmp');
 BW=im2bw(BW);
 [B,L,N,A] = bwboundaries(BW);
axes(handles.axes1);
% imshow(BW); hold on;
       for k=1:length(B)
         if(~sum(A(k,:)))
           boundary = B{k};
           axes(handles.axes1);
           plot(boundary(:,2), boundary(:,1), 'r','LineWidth',2);
           for l=find(A(:,k))'
             boundary = B{l};
             axes(handles.axes1);
             save boundary boundary
             plot(boundary(:,2), boundary(:,1), 'g','LineWidth',2);
           end
         end
       end
       
       
  
       
       
       % imshow(AA); hold on;

load boundary       
       
aa=1;
%Infinite while loop
load r;
load c;
%r=69:400;
%c=83:500;
while(1)
% preview(vid)
%Get Image
trigger(vid);
im=getdata(vid,1);
axes(handles.axes1);
imshow(im);
hold on


axes(handles.axes1);
plot(boundary(:,2), boundary(:,1), 'g','LineWidth',2);
aa=aa+1;
set(handles.timer,'String',num2str(aa));
disp(aa);
sss='Capturing Gesture';
set(handles.edit2,'String',sss);
if aa == 45
   break 
end


end
sss='Detecting Gesture';
set(handles.edit2,'String',sss);

stop(vid),delete(vid),clear vid; 

red=im(:,:,1);
Green=im(:,:,2);
Blue=im(:,:,3);

Out(:,:,1)=red(min(r):max(r),min(c):max(c));
Out(:,:,2)=Green(min(r):max(r),min(c):max(c));
Out(:,:,3)=Blue(min(r):max(r),min(c):max(c));
Out=uint8(Out);
imwrite(Out,'final.bmp');
%figure, 
axes(handles.axes3);
imshow(Out,[])
        a=imread('bg.bmp');

%
%Initialize the images
    img_input = Out;
 img_height = size(img_input,1);
  img_width = size(img_input,2);
  bin = zeros(img_height,img_width);
%Apply Grayworld Algorithm
 Img_gray =grayalgo(img_input);
  %Img_gray = img_input;
  figure;
  imshow(Img_gray);
  xlabel("grayworld");
%Convert from RGB to YCbCr
  imgycbcr = rgb2ycbcr(Img_gray);
  YCb = imgycbcr(:,:,2);
  YCr = imgycbcr(:,:,3);
%Detect Human Skin
  [r,c,v] = find(YCb>=77 & YCb<=127 & YCr>=133 & YCr<=173);
  numind = size(r,1);
%Mark Humain Skin Pixels
  for i=1:numind
    out(r(i),c(i),:) = [0 0 255];
    bin(r(i),c(i)) = 1;
  end
  %imshow(img_input); 
  axes(handles.axes4);
imshow(out,[]);
  figure; 
 imshow(out);
  figure; imshow(bin);



%
%b=rgb2gray(bin);
out=medfilt2(bin,[3 3]);
figure;
imshow(out);
xlabel("after filter");
ut=imfill(out,'holes');
figure;
imshow(ut);
C1 = imresize(ut,[256 256],'nearest');
axes(handles.axes5);
imshow(C1,[]);
%imwrite(C1,'120.bmp');
% close all;
% figure;
str='.bmp';
str1='F'
for i=1:119
    a=strcat(num2str(i),str);
    b=imread(a);
    re1=corr2(b,C1);
    
      fresultValues_r(i) = re1;
    fresultNames_r(i) = {a};
  
    result1(i)=re1
    % figure;
     %subplot(1,2,1);imshow(C1);
     %subplot(1,2,2);imshow(b);
     %xlabel(re1);
end
%disp("huio");
%disp(max(result1));

[re ma]=max(result1);
%disp('asdasds');
%disp(ma);
%disp(re);
 a=strcat(num2str(ma),str);
% disp(num2str(ma));
  fid1 = fopen('text.txt', 'a+');
 if ma > 0 && ma <= 10 || ma>50 && ma<57  
     sss='d';
     fprintf(fid1, '%s\r', sss);
     disp('d');
 elseif ma > 10 && ma <= 20 || ma > 56 && ma < 63 
     sss='v';
     fprintf(fid1, '%s\r', sss);
     disp('v');
 elseif ma > 20 && ma <= 30 || ma > 62 && ma < 70
     sss='y';
     fprintf(fid1, '%s\r', sss);
     disp('y');
  elseif ma > 69 && ma < 77 || ma > 30 && ma < 41
     sss='a';
     fprintf(fid1, '%s\r', sss);
     disp('a');
  elseif ma > 40 && ma <= 50 
      sss='s';
     fprintf(fid1, '%s\r', sss);
     disp('s');
  elseif ma > 76 && ma < 82 
     sss='f';
     fprintf(fid1, '%s\r', sss);
     disp('f');
  elseif ma > 81 && ma < 87 
     sss='x';
     fprintf(fid1, '%s\r', sss);
     disp('x');
  elseif ma > 86 && ma < 92 
     sss='q';
     fprintf(fid1, '%s\r', sss);
     disp('q');
  elseif ma > 91 && ma < 96 
     sss='l';
     fprintf(fid1, '%s\r', sss);
     disp('l');
   elseif ma > 95 && ma < 102 
     sss='w';
     fprintf(fid1, '%s\r', sss);
     disp('w');
     elseif ma > 101 && ma < 110 
     sss='u';
     fprintf(fid1, '%s\r', sss);
     disp('u');
     elseif ma > 109 && ma < 115 
     sss='b';
     fprintf(fid1, '%s\r', sss);
     disp('b');
     elseif ma > 114 && ma < 121 
     sss='i';
     fprintf(fid1, '%s\r', sss);
     disp('i');
     
 end
 fclose(fid1);
 fid3 = fopen('text.txt', 'r+');
 y='';
 while ~feof(fid3)
    tline = fgetl(fid3);
    y = strcat(y,tline);
    disp(tline)
 end


 %sss= fgets(fid1);
 sss='Output';
set(handles.edit2,'String',sss);

 set(handles.edit4,'String',y);
 fclose(fid1);
%sss='HELLO WELCOME';

b=imread(a);
axes(handles.axes6);
imshow(b);title('recognition result');
 speech(y);

    
[sortedValues_r, index_r] = sort(-fresultValues_r);     


    fid = fopen('recognition.txt', 'w+');         
for i = 1:10        % store top 10 matches...
    
    
    
    imagename = char(fresultNames_r(index_r(i)));
    fprintf(fid, '%s\r', imagename);
    
    
    
    
end
disp('maximum correlation coefficient among pictures');
disp(max(result1));
fclose(fid);
disp('exit');

function timer_Callback(hObject, eventdata, handles)

function timer_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)

function edit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in clear.
function clear_Callback(hObject, eventdata, handles)
%delete 'text.txt';

% clear;
sss='0';
set(handles.timer,'String',sss);
sss='0';
set(handles.edit2,'String',sss);
sss='0';
set(handles.edit4,'String',sss);
a=ones(480,650);
axes(handles.axes1);
imshow(a);

b=ones(256,256);
%axes(handles.axes2);
%imshow(b);
axes(handles.axes3);
imshow(b);
axes(handles.axes4);
imshow(b);
axes(handles.axes5);
imshow(b);
axes(handles.axes6);
imshow(b);



function exit_Callback(hObject, eventdata, handles)
delete 'text.txt';

close all force



function edit4_Callback(hObject, eventdata, handles)

function edit4_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
