package com.pivotal.pxf.accessors;

import java.io.IOException;
import java.io.InputStream;
import java.net.URI;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.mapred.FileSplit;

import com.pivotal.pxf.format.OneRow;
import com.pivotal.pxf.utilities.HdfsUtilities;
import com.pivotal.pxf.utilities.InputData;
import com.pivotal.pxf.utilities.Plugin;

/*
 * Base class for enforcing the complete access of a file in one accessor. Since we are not accessing the
 * file using the splittable API, but instead are using the "simple" stream API, it means that
 * we cannot fetch different parts (splits) of the file in different segments. Instead each file access
 * brings the complete file. And, if several segments would access the same file, then each one will return the whole
 * file and we will observe in the query result, each record appearing number_of_segments times. To avoid this
 * we will only have one segment (segment 0) working for this case - enforced with isWorkingSegment() method.
 * Naturally this is the less recommended working mode since we are not making use of segment parallelism.
 * HDFS accessors for a specific file type should inherit from this class only if the file they are reading does 
 * not support splitting: a protocol-buffer file, regular file, ...
*/
public abstract class HdfsAtomicDataAccessor extends Plugin implements IReadAccessor
{
	private Configuration conf = null; 
	protected InputStream inp = null;
	private FileSplit fileSplit = null; 

	/*
	 * C'tor
	 */ 	
	public HdfsAtomicDataAccessor(InputData input) throws Exception
	{
		// 0. Hold the configuration data
		super(input);
				
		// 1. Load Hadoop configuration defined in $HADOOP_HOME/conf/*.xml files
		conf = new Configuration();
		
		fileSplit = HdfsUtilities.parseFragmentMetadata(inputData);
	}

	/*
	 * openForRead
	 * Opens the file the file, using the non-splittable API for HADOOP HDFS file access
	 * This means that instead of using a FileInputFormat for access, we use a Java stream
	 */	
	public boolean openForRead() throws Exception
	{
		if (!isWorkingSegment())
			return false;
		
		// 1. input data stream
		FileSystem  fs = FileSystem.get(URI.create(inputData.path()), conf); // FileSystem.get actually returns an FSDataInputStream
		inp = fs.open(new Path(inputData.path()));
		return (inp != null);
	}

	/*
	 * readNextObject
	 * Fetches one record from the  file. The record is returned as a Java object.
	 */			
	public OneRow readNextObject() throws IOException
	{
		if (!isWorkingSegment())
			return null;
		
		return new OneRow(null, new Object());
	}

	/*
	 * closeForRead
	 * When user finished reading the file, it closes the access stream
	 */			
	public void closeForRead() throws Exception
	{
		if (!isWorkingSegment())
			return;
		
		if (inp != null)
			inp.close();
	}
	
	/*
	 * Making sure that only the segment that got assigned the first data
	 * fragment will read the (whole) file.
	 */
	private boolean isWorkingSegment()
	{
		return (fileSplit.getStart() == 0);
	}
	
	@Override
	public boolean isThreadSafe() {
		return HdfsUtilities.isThreadSafe(inputData);
	}
}
