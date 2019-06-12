Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCC74208F
	for <lists+cgroups@lfdr.de>; Wed, 12 Jun 2019 11:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407201AbfFLJUO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jun 2019 05:20:14 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:49861 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406714AbfFLJUO (ORCPT
        <rfc822;groupwise-cgroups@vger.kernel.org:0:0>);
        Wed, 12 Jun 2019 05:20:14 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Wed, 12 Jun 2019 11:20:11 +0200
Received: from suselix (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Wed, 12 Jun 2019 07:17:35 +0100
Date:   Wed, 12 Jun 2019 08:17:32 +0200
From:   Andreas Herrmann <aherrmann@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH] blkio-controller.txt: Remove references to CFQ
Message-ID: <20190612061732.GA3711@suselix>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

CFQ is gone. No need anymore to document its "proportional weight time
based division of disk policy".

Signed-off-by: Andreas Herrmann <aherrmann@suse.com>
---
 Documentation/cgroup-v1/blkio-controller.txt | 96 ++--------------------------
 1 file changed, 7 insertions(+), 89 deletions(-)

diff --git a/Documentation/cgroup-v1/blkio-controller.txt b/Documentation/cgroup-v1/blkio-controller.txt
index 673dc34d3f78..d1a1b7bdd03a 100644
--- a/Documentation/cgroup-v1/blkio-controller.txt
+++ b/Documentation/cgroup-v1/blkio-controller.txt
@@ -8,61 +8,13 @@ both at leaf nodes as well as at intermediate nodes in a storage hierarchy.
 Plan is to use the same cgroup based management interface for blkio controller
 and based on user options switch IO policies in the background.
 
-Currently two IO control policies are implemented. First one is proportional
-weight time based division of disk policy. It is implemented in CFQ. Hence
-this policy takes effect only on leaf nodes when CFQ is being used. The second
-one is throttling policy which can be used to specify upper IO rate limits
-on devices. This policy is implemented in generic block layer and can be
-used on leaf nodes as well as higher level logical devices like device mapper.
+One IO control policy is throttling policy which can be used to
+specify upper IO rate limits on devices. This policy is implemented in
+generic block layer and can be used on leaf nodes as well as higher
+level logical devices like device mapper.
 
 HOWTO
 =====
-Proportional Weight division of bandwidth
------------------------------------------
-You can do a very simple testing of running two dd threads in two different
-cgroups. Here is what you can do.
-
-- Enable Block IO controller
-	CONFIG_BLK_CGROUP=y
-
-- Enable group scheduling in CFQ
-	CONFIG_CFQ_GROUP_IOSCHED=y
-
-- Compile and boot into kernel and mount IO controller (blkio); see
-  cgroups.txt, Why are cgroups needed?.
-
-	mount -t tmpfs cgroup_root /sys/fs/cgroup
-	mkdir /sys/fs/cgroup/blkio
-	mount -t cgroup -o blkio none /sys/fs/cgroup/blkio
-
-- Create two cgroups
-	mkdir -p /sys/fs/cgroup/blkio/test1/ /sys/fs/cgroup/blkio/test2
-
-- Set weights of group test1 and test2
-	echo 1000 > /sys/fs/cgroup/blkio/test1/blkio.weight
-	echo 500 > /sys/fs/cgroup/blkio/test2/blkio.weight
-
-- Create two same size files (say 512MB each) on same disk (file1, file2) and
-  launch two dd threads in different cgroup to read those files.
-
-	sync
-	echo 3 > /proc/sys/vm/drop_caches
-
-	dd if=/mnt/sdb/zerofile1 of=/dev/null &
-	echo $! > /sys/fs/cgroup/blkio/test1/tasks
-	cat /sys/fs/cgroup/blkio/test1/tasks
-
-	dd if=/mnt/sdb/zerofile2 of=/dev/null &
-	echo $! > /sys/fs/cgroup/blkio/test2/tasks
-	cat /sys/fs/cgroup/blkio/test2/tasks
-
-- At macro level, first dd should finish first. To get more precise data, keep
-  on looking at (with the help of script), at blkio.disk_time and
-  blkio.disk_sectors files of both test1 and test2 groups. This will tell how
-  much disk time (in milliseconds), each group got and how many sectors each
-  group dispatched to the disk. We provide fairness in terms of disk time, so
-  ideally io.disk_time of cgroups should be in proportion to the weight.
-
 Throttling/Upper Limit policy
 -----------------------------
 - Enable Block IO controller
@@ -94,7 +46,7 @@ Throttling/Upper Limit policy
 Hierarchical Cgroups
 ====================
 
-Both CFQ and throttling implement hierarchy support; however,
+Throttling implements hierarchy support; however,
 throttling's hierarchy support is enabled iff "sane_behavior" is
 enabled from cgroup side, which currently is a development option and
 not publicly available.
@@ -107,9 +59,8 @@ If somebody created a hierarchy like as follows.
 			|
 		     test3
 
-CFQ by default and throttling with "sane_behavior" will handle the
-hierarchy correctly.  For details on CFQ hierarchy support, refer to
-Documentation/block/cfq-iosched.txt.  For throttling, all limits apply
+Throttling with "sane_behavior" will handle the
+hierarchy correctly. For throttling, all limits apply
 to the whole subtree while all statistics are local to the IOs
 directly generated by tasks in that cgroup.
 
@@ -130,10 +81,6 @@ CONFIG_DEBUG_BLK_CGROUP
 	- Debug help. Right now some additional stats file show up in cgroup
 	  if this option is enabled.
 
-CONFIG_CFQ_GROUP_IOSCHED
-	- Enables group scheduling in CFQ. Currently only 1 level of group
-	  creation is allowed.
-
 CONFIG_BLK_DEV_THROTTLING
 	- Enable block device throttling support in block layer.
 
@@ -344,32 +291,3 @@ Common files among various policies
 - blkio.reset_stats
 	- Writing an int to this file will result in resetting all the stats
 	  for that cgroup.
-
-CFQ sysfs tunable
-=================
-/sys/block/<disk>/queue/iosched/slice_idle
-------------------------------------------
-On a faster hardware CFQ can be slow, especially with sequential workload.
-This happens because CFQ idles on a single queue and single queue might not
-drive deeper request queue depths to keep the storage busy. In such scenarios
-one can try setting slice_idle=0 and that would switch CFQ to IOPS
-(IO operations per second) mode on NCQ supporting hardware.
-
-That means CFQ will not idle between cfq queues of a cfq group and hence be
-able to driver higher queue depth and achieve better throughput. That also
-means that cfq provides fairness among groups in terms of IOPS and not in
-terms of disk time.
-
-/sys/block/<disk>/queue/iosched/group_idle
-------------------------------------------
-If one disables idling on individual cfq queues and cfq service trees by
-setting slice_idle=0, group_idle kicks in. That means CFQ will still idle
-on the group in an attempt to provide fairness among groups.
-
-By default group_idle is same as slice_idle and does not do anything if
-slice_idle is enabled.
-
-One can experience an overall throughput drop if you have created multiple
-groups and put applications in that group which are not driving enough
-IO to keep disk busy. In that case set group_idle=0, and CFQ will not idle
-on individual groups and throughput should improve.
-- 
2.13.7
