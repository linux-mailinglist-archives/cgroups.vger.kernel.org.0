Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCC5E42EE0
	for <lists+cgroups@lfdr.de>; Wed, 12 Jun 2019 20:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfFLSio (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jun 2019 14:38:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45690 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbfFLSim (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jun 2019 14:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ySP7Rfm9vrPZVi9yG2V7YPPuHG8L4YJY7F6xTxyIBXY=; b=c3zn2kqhuZzFJp3lcjd/ue6Dqn
        XHuyKho1f9h4HZc+YGxomgSi6Blus0kwDPutRAA3g92ZCkX1PUmNBZbcvA5yGazgawtRgwJzcy57J
        OsysAPX89j4SoFIKONx/gM9h/7TfzrS2IXXmq9fB1S6LAP2KwEbB0Ku5VLSmsXKJSRBLu+oXaSq3V
        WnCJ8hGK4MauwONjr8ohP29jZwc22Y4kJ33sltPMvs10C2F2YVQtvaD5cyb2CxOO3d3Dj0b8Vwub9
        QLXplnUu8aZbKmRe38KeHVFfD24/qLulvUlwPWKLBdXXePBQzCDVj07cQFwraHosKnXTXNrQ3zcf3
        5k/0OV2w==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb88s-0006YT-Nc; Wed, 12 Jun 2019 18:38:39 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hb88q-0002BP-8T; Wed, 12 Jun 2019 15:38:36 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: [PATCH v1 18/31] docs: accounting: convert to ReST
Date:   Wed, 12 Jun 2019 15:38:21 -0300
Message-Id: <c9b13fed529144ae419678db1e386d5853709c9c.1560364494.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560364493.git.mchehab+samsung@kernel.org>
References: <cover.1560364493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Rename the accounting documentation files to ReST, add an
index for them and adjust in order to produce a nice html
output via the Sphinx build system.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../{cgroupstats.txt => cgroupstats.rst}      | 14 ++--
 ...ay-accounting.txt => delay-accounting.rst} | 61 ++++++++------
 Documentation/accounting/index.rst            | 14 ++++
 Documentation/accounting/{psi.txt => psi.rst} | 40 +++++-----
 ...kstats-struct.txt => taskstats-struct.rst} | 79 ++++++++++++-------
 .../{taskstats.txt => taskstats.rst}          | 15 ++--
 Documentation/admin-guide/cgroup-v2.rst       |  6 +-
 init/Kconfig                                  |  2 +-
 8 files changed, 139 insertions(+), 92 deletions(-)
 rename Documentation/accounting/{cgroupstats.txt => cgroupstats.rst} (77%)
 rename Documentation/accounting/{delay-accounting.txt => delay-accounting.rst} (77%)
 create mode 100644 Documentation/accounting/index.rst
 rename Documentation/accounting/{psi.txt => psi.rst} (91%)
 rename Documentation/accounting/{taskstats-struct.txt => taskstats-struct.rst} (78%)
 rename Documentation/accounting/{taskstats.txt => taskstats.rst} (95%)

diff --git a/Documentation/accounting/cgroupstats.txt b/Documentation/accounting/cgroupstats.rst
similarity index 77%
rename from Documentation/accounting/cgroupstats.txt
rename to Documentation/accounting/cgroupstats.rst
index d16a9849e60e..b9afc48f4ea2 100644
--- a/Documentation/accounting/cgroupstats.txt
+++ b/Documentation/accounting/cgroupstats.rst
@@ -1,3 +1,7 @@
+==================
+Control Groupstats
+==================
+
 Control Groupstats is inspired by the discussion at
 http://lkml.org/lkml/2007/4/11/187 and implements per cgroup statistics as
 suggested by Andrew Morton in http://lkml.org/lkml/2007/4/11/263.
@@ -19,9 +23,9 @@ about tasks blocked on I/O. If CONFIG_TASK_DELAY_ACCT is disabled, this
 information will not be available.
 
 To extract cgroup statistics a utility very similar to getdelays.c
-has been developed, the sample output of the utility is shown below
+has been developed, the sample output of the utility is shown below::
 
-~/balbir/cgroupstats # ./getdelays  -C "/sys/fs/cgroup/a"
-sleeping 1, blocked 0, running 1, stopped 0, uninterruptible 0
-~/balbir/cgroupstats # ./getdelays  -C "/sys/fs/cgroup"
-sleeping 155, blocked 0, running 1, stopped 0, uninterruptible 2
+  ~/balbir/cgroupstats # ./getdelays  -C "/sys/fs/cgroup/a"
+  sleeping 1, blocked 0, running 1, stopped 0, uninterruptible 0
+  ~/balbir/cgroupstats # ./getdelays  -C "/sys/fs/cgroup"
+  sleeping 155, blocked 0, running 1, stopped 0, uninterruptible 2
diff --git a/Documentation/accounting/delay-accounting.txt b/Documentation/accounting/delay-accounting.rst
similarity index 77%
rename from Documentation/accounting/delay-accounting.txt
rename to Documentation/accounting/delay-accounting.rst
index 042ea59b5853..7cc7f5852da0 100644
--- a/Documentation/accounting/delay-accounting.txt
+++ b/Documentation/accounting/delay-accounting.rst
@@ -1,5 +1,6 @@
+================
 Delay accounting
-----------------
+================
 
 Tasks encounter delays in execution when they wait
 for some kernel resource to become available e.g. a
@@ -39,7 +40,9 @@ in detail in a separate document in this directory. Taskstats returns a
 generic data structure to userspace corresponding to per-pid and per-tgid
 statistics. The delay accounting functionality populates specific fields of
 this structure. See
+
      include/linux/taskstats.h
+
 for a description of the fields pertaining to delay accounting.
 It will generally be in the form of counters returning the cumulative
 delay seen for cpu, sync block I/O, swapin, memory reclaim etc.
@@ -61,13 +64,16 @@ also serves as an example of using the taskstats interface.
 Usage
 -----
 
-Compile the kernel with
+Compile the kernel with::
+
 	CONFIG_TASK_DELAY_ACCT=y
 	CONFIG_TASKSTATS=y
 
 Delay accounting is enabled by default at boot up.
-To disable, add
+To disable, add::
+
    nodelayacct
+
 to the kernel boot options. The rest of the instructions
 below assume this has not been done.
 
@@ -78,40 +84,43 @@ The utility also allows a given command to be
 executed and the corresponding delays to be
 seen.
 
-General format of the getdelays command
+General format of the getdelays command::
 
-getdelays [-t tgid] [-p pid] [-c cmd...]
+	getdelays [-t tgid] [-p pid] [-c cmd...]
 
 
-Get delays, since system boot, for pid 10
-# ./getdelays -p 10
-(output similar to next case)
+Get delays, since system boot, for pid 10::
 
-Get sum of delays, since system boot, for all pids with tgid 5
-# ./getdelays -t 5
+	# ./getdelays -p 10
+	(output similar to next case)
 
+Get sum of delays, since system boot, for all pids with tgid 5::
 
-CPU	count	real total	virtual total	delay total
-	7876	92005750	100000000	24001500
-IO	count	delay total
-	0	0
-SWAP	count	delay total
-	0	0
-RECLAIM	count	delay total
-	0	0
+	# ./getdelays -t 5
 
-Get delays seen in executing a given simple command
-# ./getdelays -c ls /
 
-bin   data1  data3  data5  dev  home  media  opt   root  srv        sys  usr
-boot  data2  data4  data6  etc  lib   mnt    proc  sbin  subdomain  tmp  var
+	CPU	count	real total	virtual total	delay total
+		7876	92005750	100000000	24001500
+	IO	count	delay total
+		0	0
+	SWAP	count	delay total
+		0	0
+	RECLAIM	count	delay total
+		0	0
 
+Get delays seen in executing a given simple command::
 
-CPU	count	real total	virtual total	delay total
+  # ./getdelays -c ls /
+
+  bin   data1  data3  data5  dev  home  media  opt   root  srv        sys  usr
+  boot  data2  data4  data6  etc  lib   mnt    proc  sbin  subdomain  tmp  var
+
+
+  CPU	count	real total	virtual total	delay total
 	6	4000250		4000000		0
-IO	count	delay total
+  IO	count	delay total
 	0	0
-SWAP	count	delay total
+  SWAP	count	delay total
 	0	0
-RECLAIM	count	delay total
+  RECLAIM	count	delay total
 	0	0
diff --git a/Documentation/accounting/index.rst b/Documentation/accounting/index.rst
new file mode 100644
index 000000000000..e1f6284b5ff3
--- /dev/null
+++ b/Documentation/accounting/index.rst
@@ -0,0 +1,14 @@
+:orphan:
+
+==========
+Accounting
+==========
+
+.. toctree::
+   :maxdepth: 1
+
+   cgroupstats
+   delay-accounting
+   psi
+   taskstats
+   taskstats-struct
diff --git a/Documentation/accounting/psi.txt b/Documentation/accounting/psi.rst
similarity index 91%
rename from Documentation/accounting/psi.txt
rename to Documentation/accounting/psi.rst
index 5cbe5659e3b7..621111ce5740 100644
--- a/Documentation/accounting/psi.txt
+++ b/Documentation/accounting/psi.rst
@@ -35,14 +35,14 @@ Pressure interface
 Pressure information for each resource is exported through the
 respective file in /proc/pressure/ -- cpu, memory, and io.
 
-The format for CPU is as such:
+The format for CPU is as such::
 
-some avg10=0.00 avg60=0.00 avg300=0.00 total=0
+	some avg10=0.00 avg60=0.00 avg300=0.00 total=0
 
-and for memory and IO:
+and for memory and IO::
 
-some avg10=0.00 avg60=0.00 avg300=0.00 total=0
-full avg10=0.00 avg60=0.00 avg300=0.00 total=0
+	some avg10=0.00 avg60=0.00 avg300=0.00 total=0
+	full avg10=0.00 avg60=0.00 avg300=0.00 total=0
 
 The "some" line indicates the share of time in which at least some
 tasks are stalled on a given resource.
@@ -77,9 +77,9 @@ To register a trigger user has to open psi interface file under
 /proc/pressure/ representing the resource to be monitored and write the
 desired threshold and time window. The open file descriptor should be
 used to wait for trigger events using select(), poll() or epoll().
-The following format is used:
+The following format is used::
 
-<some|full> <stall amount in us> <time window in us>
+	<some|full> <stall amount in us> <time window in us>
 
 For example writing "some 150000 1000000" into /proc/pressure/memory
 would add 150ms threshold for partial memory stall measured within
@@ -115,18 +115,20 @@ trigger  is closed.
 Userspace monitor usage example
 ===============================
 
-#include <errno.h>
-#include <fcntl.h>
-#include <stdio.h>
-#include <poll.h>
-#include <string.h>
-#include <unistd.h>
+::
 
-/*
- * Monitor memory partial stall with 1s tracking window size
- * and 150ms threshold.
- */
-int main() {
+  #include <errno.h>
+  #include <fcntl.h>
+  #include <stdio.h>
+  #include <poll.h>
+  #include <string.h>
+  #include <unistd.h>
+
+  /*
+   * Monitor memory partial stall with 1s tracking window size
+   * and 150ms threshold.
+   */
+  int main() {
 	const char trig[] = "some 150000 1000000";
 	struct pollfd fds;
 	int n;
@@ -165,7 +167,7 @@ int main() {
 	}
 
 	return 0;
-}
+  }
 
 Cgroup2 interface
 =================
diff --git a/Documentation/accounting/taskstats-struct.txt b/Documentation/accounting/taskstats-struct.rst
similarity index 78%
rename from Documentation/accounting/taskstats-struct.txt
rename to Documentation/accounting/taskstats-struct.rst
index e7512c061c15..ca90fd489c9a 100644
--- a/Documentation/accounting/taskstats-struct.txt
+++ b/Documentation/accounting/taskstats-struct.rst
@@ -1,5 +1,6 @@
+====================
 The struct taskstats
---------------------
+====================
 
 This document contains an explanation of the struct taskstats fields.
 
@@ -10,16 +11,24 @@ There are three different groups of fields in the struct taskstats:
     the common fields and basic accounting fields are collected for
     delivery at do_exit() of a task.
 2) Delay accounting fields
-    These fields are placed between
-    /* Delay accounting fields start */
-    and
-    /* Delay accounting fields end */
+    These fields are placed between::
+
+	/* Delay accounting fields start */
+
+    and::
+
+	/* Delay accounting fields end */
+
     Their values are collected if CONFIG_TASK_DELAY_ACCT is set.
 3) Extended accounting fields
-    These fields are placed between
-    /* Extended accounting fields start */
-    and
-    /* Extended accounting fields end */
+    These fields are placed between::
+
+	/* Extended accounting fields start */
+
+    and::
+
+	/* Extended accounting fields end */
+
     Their values are collected if CONFIG_TASK_XACCT is set.
 
 4) Per-task and per-thread context switch count statistics
@@ -31,31 +40,33 @@ There are three different groups of fields in the struct taskstats:
 Future extension should add fields to the end of the taskstats struct, and
 should not change the relative position of each field within the struct.
 
+::
 
-struct taskstats {
+  struct taskstats {
+
+1) Common and basic accounting fields::
 
-1) Common and basic accounting fields:
 	/* The version number of this struct. This field is always set to
 	 * TAKSTATS_VERSION, which is defined in <linux/taskstats.h>.
 	 * Each time the struct is changed, the value should be incremented.
 	 */
 	__u16	version;
 
-  	/* The exit code of a task. */
+	/* The exit code of a task. */
 	__u32	ac_exitcode;		/* Exit status */
 
-  	/* The accounting flags of a task as defined in <linux/acct.h>
+	/* The accounting flags of a task as defined in <linux/acct.h>
 	 * Defined values are AFORK, ASU, ACOMPAT, ACORE, and AXSIG.
 	 */
 	__u8	ac_flag;		/* Record flags */
 
-  	/* The value of task_nice() of a task. */
+	/* The value of task_nice() of a task. */
 	__u8	ac_nice;		/* task_nice */
 
-  	/* The name of the command that started this task. */
+	/* The name of the command that started this task. */
 	char	ac_comm[TS_COMM_LEN];	/* Command name */
 
-  	/* The scheduling discipline as set in task->policy field. */
+	/* The scheduling discipline as set in task->policy field. */
 	__u8	ac_sched;		/* Scheduling discipline */
 
 	__u8	ac_pad[3];
@@ -64,26 +75,27 @@ struct taskstats {
 	__u32	ac_pid;			/* Process ID */
 	__u32	ac_ppid;		/* Parent process ID */
 
-  	/* The time when a task begins, in [secs] since 1970. */
+	/* The time when a task begins, in [secs] since 1970. */
 	__u32	ac_btime;		/* Begin time [sec since 1970] */
 
-  	/* The elapsed time of a task, in [usec]. */
+	/* The elapsed time of a task, in [usec]. */
 	__u64	ac_etime;		/* Elapsed time [usec] */
 
-  	/* The user CPU time of a task, in [usec]. */
+	/* The user CPU time of a task, in [usec]. */
 	__u64	ac_utime;		/* User CPU time [usec] */
 
-  	/* The system CPU time of a task, in [usec]. */
+	/* The system CPU time of a task, in [usec]. */
 	__u64	ac_stime;		/* System CPU time [usec] */
 
-  	/* The minor page fault count of a task, as set in task->min_flt. */
+	/* The minor page fault count of a task, as set in task->min_flt. */
 	__u64	ac_minflt;		/* Minor Page Fault Count */
 
 	/* The major page fault count of a task, as set in task->maj_flt. */
 	__u64	ac_majflt;		/* Major Page Fault Count */
 
 
-2) Delay accounting fields:
+2) Delay accounting fields::
+
 	/* Delay accounting fields start
 	 *
 	 * All values, until the comment "Delay accounting fields end" are
@@ -134,7 +146,8 @@ struct taskstats {
 	/* version 1 ends here */
 
 
-3) Extended accounting fields
+3) Extended accounting fields::
+
 	/* Extended accounting fields start */
 
 	/* Accumulated RSS usage in duration of a task, in MBytes-usecs.
@@ -145,15 +158,15 @@ struct taskstats {
 	 */
 	__u64	coremem;		/* accumulated RSS usage in MB-usec */
 
-  	/* Accumulated virtual memory usage in duration of a task.
+	/* Accumulated virtual memory usage in duration of a task.
 	 * Same as acct_rss_mem1 above except that we keep track of VM usage.
 	 */
 	__u64	virtmem;		/* accumulated VM usage in MB-usec */
 
-  	/* High watermark of RSS usage in duration of a task, in KBytes. */
+	/* High watermark of RSS usage in duration of a task, in KBytes. */
 	__u64	hiwater_rss;		/* High-watermark of RSS usage */
 
-  	/* High watermark of VM  usage in duration of a task, in KBytes. */
+	/* High watermark of VM  usage in duration of a task, in KBytes. */
 	__u64	hiwater_vm;		/* High-water virtual memory usage */
 
 	/* The following four fields are I/O statistics of a task. */
@@ -164,17 +177,23 @@ struct taskstats {
 
 	/* Extended accounting fields end */
 
-4) Per-task and per-thread statistics
+4) Per-task and per-thread statistics::
+
 	__u64	nvcsw;			/* Context voluntary switch counter */
 	__u64	nivcsw;			/* Context involuntary switch counter */
 
-5) Time accounting for SMT machines
+5) Time accounting for SMT machines::
+
 	__u64	ac_utimescaled;		/* utime scaled on frequency etc */
 	__u64	ac_stimescaled;		/* stime scaled on frequency etc */
 	__u64	cpu_scaled_run_real_total; /* scaled cpu_run_real_total */
 
-6) Extended delay accounting fields for memory reclaim
+6) Extended delay accounting fields for memory reclaim::
+
 	/* Delay waiting for memory reclaim */
 	__u64	freepages_count;
 	__u64	freepages_delay_total;
-}
+
+::
+
+  }
diff --git a/Documentation/accounting/taskstats.txt b/Documentation/accounting/taskstats.rst
similarity index 95%
rename from Documentation/accounting/taskstats.txt
rename to Documentation/accounting/taskstats.rst
index ff06b738bb88..2a28b7f55c10 100644
--- a/Documentation/accounting/taskstats.txt
+++ b/Documentation/accounting/taskstats.rst
@@ -1,5 +1,6 @@
+=============================
 Per-task statistics interface
------------------------------
+=============================
 
 
 Taskstats is a netlink-based interface for sending per-task and
@@ -65,7 +66,7 @@ taskstats.h file.
 
 The data exchanged between user and kernel space is a netlink message belonging
 to the NETLINK_GENERIC family and using the netlink attributes interface.
-The messages are in the format
+The messages are in the format::
 
     +----------+- - -+-------------+-------------------+
     | nlmsghdr | Pad |  genlmsghdr | taskstats payload |
@@ -167,15 +168,13 @@ extended and the number of cpus grows large.
 To avoid losing statistics, userspace should do one or more of the following:
 
 - increase the receive buffer sizes for the netlink sockets opened by
-listeners to receive exit data.
+  listeners to receive exit data.
 
 - create more listeners and reduce the number of cpus being listened to by
-each listener. In the extreme case, there could be one listener for each cpu.
-Users may also consider setting the cpu affinity of the listener to the subset
-of cpus to which it listens, especially if they are listening to just one cpu.
+  each listener. In the extreme case, there could be one listener for each cpu.
+  Users may also consider setting the cpu affinity of the listener to the subset
+  of cpus to which it listens, especially if they are listening to just one cpu.
 
 Despite these measures, if the userspace receives ENOBUFS error messages
 indicated overflow of receive buffers, it should take measures to handle the
 loss of data.
-
-----
diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 110c3d34df71..4b971a0bc99a 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1014,7 +1014,7 @@ All time durations are in microseconds.
 	A read-only nested-key file which exists on non-root cgroups.
 
 	Shows pressure stall information for CPU. See
-	Documentation/accounting/psi.txt for details.
+	Documentation/accounting/psi.rst for details.
 
 
 Memory
@@ -1361,7 +1361,7 @@ PAGE_SIZE multiple when read back.
 	A read-only nested-key file which exists on non-root cgroups.
 
 	Shows pressure stall information for memory. See
-	Documentation/accounting/psi.txt for details.
+	Documentation/accounting/psi.rst for details.
 
 
 Usage Guidelines
@@ -1504,7 +1504,7 @@ IO Interface Files
 	A read-only nested-key file which exists on non-root cgroups.
 
 	Shows pressure stall information for IO. See
-	Documentation/accounting/psi.txt for details.
+	Documentation/accounting/psi.rst for details.
 
 
 Writeback
diff --git a/init/Kconfig b/init/Kconfig
index 6db89d4155d8..1707cf0802a7 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -517,7 +517,7 @@ config PSI
 	  have cpu.pressure, memory.pressure, and io.pressure files,
 	  which aggregate pressure stalls for the grouped tasks only.
 
-	  For more details see Documentation/accounting/psi.txt.
+	  For more details see Documentation/accounting/psi.rst.
 
 	  Say N if unsure.
 
-- 
2.21.0

