/**
 * @file.
 *
 * @author J. Broeckhove - see copyright.txt
 */

#ifndef INC_BASICS_PRINTCOLL_HPP
#define INC_BASICS_PRINTCOLL_HPP

#include <iostream>

template <typename T>
void printcoll(T const& coll)
{
        typename T::const_iterator pos;
        typename T::const_iterator end(coll.end());

        for (pos = coll.begin(); pos != end; ++pos) {
                std::cout << *pos << ' ';
        }
        std::cout << std::endl;
}

#endif // INC_BASICS_PRINTCOLL_HPP
