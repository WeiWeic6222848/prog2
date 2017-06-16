/**
 * @file
 * Header for TracerOutput.
 * @author J.Broeckhove  CoMP/UA
 */

#ifndef GOBELIJN_TRACER_TRACEROUTPUT_H_
#define GOBELIJN_TRACER_TRACEROUTPUT_H_

#include <g3log/g3log.hpp>
#include <iosfwd>
#include <string>

/// Macro for turning tracker output on.
#define COMP_MISC_TRACER_OUTPUT_ON UA_CoMP::Misc::TracerOutput::set_output_on()

/// Macro for turning tracker output off.
#define COMP_MISC_TRACER_OUTPUT_OFF UA_CoMP::Misc::TracerOutput::set_output_off()

/// Macro for setting tracker output severity level w.r.t google log.
#define COMP_MISC_TRACER_SEVERITY(SEVERITY) UA_CoMP::Misc::TracerOutput::set_severity(SEVERITY)

/// Macro for inserting log message into tracker output at current severity
/// level.
#define COMP_MISC_LOG_TRACER(MSG) UA_CoMP::Misc::TracerOutput::log(MSG)

/// Macro for inserting log message into tracker output at current severity
/// level.
#define COMP_MISC_LOG_TRACER_AT_SEVERITY(MSG, LOG_SEVERITY) UA_CoMP::Misc::TracerOutput::log(MSG, LOG_SEVERITY)

namespace UA_CoMP {
namespace Misc {

using std::string;

// Typedef for log severity indication
typedef LEVELS LogSeverity;

/**
 * Class used to channel output of the BlockTracker, FunctionTracker
 * and MemberTracker objects to the google log.
 * Manages the following features for the Tracker object's output:
 * \li on or off status of producing output to the log
 * \li the indentation levels when blocks get nested
 * \li the severity level for logging to the google log
 * Consequently the class consists entirely of static members.
 */
class TracerOutput
{
public:
	/// Indicate whether current making output.
	static bool is_output_on() { return g_make_output; }

	/// Return the current severity level for logging to the google log.
	static LogSeverity get_severity() { return g_severity; }

	/// Start making output (ok even output already started).
	static void set_output_on() { g_make_output = true; }

	/// Stop making output (ok even if output already stopped).
	static void set_output_off() { g_make_output = false; }

	/// Increase the indentation level.
	static void increase_indent() { g_indent++; }

	/// Decrease the indentation level.
	static void decrease_indent() { g_indent--; }

	/// Set the severity level for logging to the google log.
	static void set_severity(LogSeverity severity) { g_severity = severity; }

	/// Insert the message in the google log at given severity level.
	static void log(string const& msg, LogSeverity severity = get_severity());

private:
	TracerOutput();
	TracerOutput(TracerOutput const&);
	TracerOutput& operator=(TracerOutput const&);
	static bool g_make_output;
	static unsigned int g_indent;
	static LogSeverity g_severity;
};

} // end of namespace Misc
} // end of namespace UA_CoMP

#endif // end-of-include-guard