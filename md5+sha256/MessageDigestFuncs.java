package ecnu.yjt;

import java.io.FileInputStream;
import java.io.InputStream;
import java.security.MessageDigest;

public class MessageDigestFuncs {
	public static String md(String method, String filename) throws Exception {
		MessageDigest m = MessageDigest.getInstance(method);
		m.reset();
		InputStream in = new FileInputStream(filename);
		int len = 0;
		byte[] buf = new byte[1024];
		while ((len = in.read(buf)) >= 0) {
			m.update(buf, 0, len);
		}
		in.close();
		byte[] res = m.digest();
		StringBuffer buffer = new StringBuffer();
		for (byte b : res) {
			buffer.append(String.format("%02X", b));
		}
		return buffer.toString();
	}

	public static String md5(String filename) throws Exception {
		return md("MD5", filename);
	}

	public static String sha256(String filename) throws Exception {
		return md("SHA-256", filename);
	}
}
