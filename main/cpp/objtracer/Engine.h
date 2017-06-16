#ifndef INC_GOBELIJN_OBJTRACER_ENGINE_H
#define INC_GOBELIJN_OBJTRACER_ENGINE_H
/**
 * @file
 * Header for the Engine class used to demo object aggregation features.
 * @author J. Broeckhove  CoMP/UA
 */

namespace ODemo {
/**
 * Engine that provides motion.
 */
class Engine
{
public:
	/// Constructor initializes the power, is_running status set to false.
	Engine(double power);

	/// Copy constructor.
	Engine(const Engine& ori);

	/// Move constructor.
	Engine(Engine&& ori);

	/// Copy assignment.
	Engine& operator=(const Engine& rhs);

	/// Move assignment.
	Engine& operator=(Engine&& rhs);

	/// Destructor does not do a thing.
	~Engine();

	/// Starts the engine, even if it already was running.
	void start();

	/// Stops the engine, even if it was already stopped.
	void stop();

	/// Indicates whether engine is running or not.
	bool is_running() const;

	/// Returns the power of this engine.
	double get_power() const;

private:
	double m_power;
	bool m_running;
};

} // end_of_namespace_MotorcycleDemo

#endif // end-of-include-guard