unit CowORM.Commons;

interface

type
  TColumnType = (
    //Unknown
    ctUnknown,
    //Integers
    ctSmallInt, ctInteger, ctBigInt,
    //Floats
    ctDecimal, ctNumeric, ctFloat, ctDoublePrecision,
    //Dates and Times
    ctDate, ctTime, ctTimeStamp,
    //Strings
    ctChar, ctVarchar,
    //Blobs
    ctBlobBinary, ctBlobText);

  TJoinType = (jtNone, jtInner, jtLeft, jtRight, jtOuter);

  TQueryType = (qtSelect, qtUpdate, qtDelete, qtInsert);

  TConnectionType = (ctFB, ctMYSQL);

implementation

end.
