--local sqldb
set serverout on;

declare 
    var1 number(5);
begin
    var1:=100;
    if var1=100 then
        dbms_output.put_line('100�Դϴ�');
    else
        dbms_output.put_line('100 �ƴմϴ�');
    end if;
end;

declare 
    var1 number(5);
begin
    var1:=200;
    if var1=100 then
        dbms_output.put_line('100�Դϴ�');
    else
        dbms_output.put_line('100 �ƴմϴ�');
    end if;
end;


