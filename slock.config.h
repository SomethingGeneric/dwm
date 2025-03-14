/* user and group to drop privileges to */
static const char *user  = "matt";
static const char *group = "matt";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "black",     /* after initialization */
	[INPUT] =  "#005577",   /* during input */
	[FAILED] = "#CC3333",   /* wrong password */
	[CAPS] = "#551A8B",     /* CapsLock on */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 0;

/* default message */
static const char * message = "Rat Rig";

/* text color */
static const char * text_color = "#ffffff";

/* text size (must be a valid size) */
static const char * font_name = "6x13";

/* allow control key to trigger fail on clear */
static const int controlkeyclear = 0;

/* time in seconds to cancel lock with mouse movement */
static const int timetocancel = 4;
