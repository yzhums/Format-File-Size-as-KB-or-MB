pageextension 50113 CustomerListExt extends "Customer List"
{
    actions
    {
        addafter("C&ontact")
        {
            action(FormatFileSize)
            {
                Caption = 'Format File Size';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    FromFile: Text[100];
                    IStream: InStream;
                    UploadMsg: Label 'Please Choose the file.';
                begin
                    UploadIntoStream(UploadMsg, '', '', FromFile, IStream);
                    Message(FormatFileSize(IStream.Length));
                end;
            }
        }
    }

    var
        FileSizeTxt: Label '%1 %2', Comment = '%1 = File Size, %2 = Unit of measurement', Locked = true;

    local procedure FormatFileSize(SizeInBytes: Integer): Text
    var
        FileSizeConverted: Decimal;
        FileSizeUnit: Text;
    begin
        FileSizeConverted := SizeInBytes / 1024; // The smallest size we show is KB
        if FileSizeConverted < 1024 then
            FileSizeUnit := 'KB'
        else begin
            FileSizeConverted := FileSizeConverted / 1024; // The largest size we show is MB
            FileSizeUnit := 'MB'
        end;
        exit(StrSubstNo(FileSizeTxt, Round(FileSizeConverted, 0.1, '>'), FileSizeUnit));
    end;
}
