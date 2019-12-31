%QUIC # STREAM LIMIT
-define(MAX_STREAMS, math:pow(2,62) -1).
%Macros for different streamtypes

% +------+----------------------------------+
% | Bits | Stream Type                      |
% +------+----------------------------------+
% | 0x0  | Client-Initiated, Bidirectional  |
% |      |                                  |
% | 0x1  | Server-Initiated, Bidirectional  |
% |      |                                  |
% | 0x2  | Client-Initiated, Unidirectional |
% |      |                                  |
% | 0x3  | Server-Initiated, Unidirectional |
% +------+----------------------------------+

-define(STREAM_CLIENT_INIT_BI, 16#0).
-define(STREAM_SERVER_INIT_BI, 16#1).
-define(STREAM_CLIENT_INIT_UNI, 16#2).
-define(STREAM_SERVER_INIT_UNI, 16#3).

%FRAME
-record(quic_frame,
        {id,
        offset}).

%REQUIRED OPERATIONS
-define(WRITE, write_data).
-define(END, end_stream).
-define(RESET, reset).
-define(READ, read).
-define(ABORT,abort).