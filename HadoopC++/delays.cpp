/* Adapted from http://cs.smith.edu/dftwiki/index.php/Hadoop_Tutorial_2.2_--_Running_C%2B%2B_Programs_on_Hadoop */
#include <algorithm>
#include <limits>
#include <string>
 
#include  "stdint.h"  // <--- to prevent uint64_t errors!


#ifdef VERSION_1 
#include "hadoop/Pipes.hh"
#include "hadoop/TemplateFactory.hh"
#include "hadoop/StringUtils.hh"
#else
#include "Pipes.hh"
#include "TemplateFactory.hh"
#include "StringUtils.hh"
#endif
 
using namespace std;

class DelaysMapper : public HadoopPipes::Mapper {
public:
  // constructor: does nothing
  DelaysMapper( HadoopPipes::TaskContext& context ) { }

  // map function: receives a line, outputs (delay value, "1")
  // to reducer.
  void map( HadoopPipes::MapContext& context ) {
    //--- get line of text ---
    string line = context.getInputValue();

    //--- split it into words ---
    vector< string > words =
      HadoopUtils::splitString( line, "," );

    //--- emit each word tuple (word, "1" ) ---
      context.emit( words[14], HadoopUtils::toString( 1 ) );
  }
};
 
class DelayCountReducer : public HadoopPipes::Reducer {
public:
  // constructor: does nothing
  DelayCountReducer(HadoopPipes::TaskContext& context) { }

  // reduce function
  void reduce( HadoopPipes::ReduceContext& context ) {
    int count = 0;

    //--- get all tuples with the same key, and count their numbers ---
    while ( context.nextValue() ) {
      count += HadoopUtils::toInt( context.getInputValue() );
    }

    //--- emit (word, count) ---
    context.emit(context.getInputKey(), HadoopUtils::toString( count ));
  }
};
 
int main(int argc, char *argv[]) {
  return HadoopPipes::runTask(HadoopPipes::TemplateFactory<
                              DelaysMapper,
                              DelayCountReducer >() );
}


