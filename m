Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249D26802BD
	for <lists+cgroups@lfdr.de>; Mon, 30 Jan 2023 00:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbjA2XLE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 29 Jan 2023 18:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbjA2XLD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 29 Jan 2023 18:11:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFF01ADC1;
        Sun, 29 Jan 2023 15:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/PJ/XxDYnr0Vr0KrPaECQtmCxxakt2A8iHz8jVHmKTw=; b=GXuJxDJyrPPzjInmF/6YYKS6Nt
        722qOgTqqvydS8P/yGykQxz2h0a/AGQ3Y72HbgXpDnCEZjVEYs2FJHrS+gRtRkU3X8rpzhDNt4IGE
        1OeTeM24RirBGrsAwecK6w/DzP0gaOvgsFdiL+JeRfA4p/xrRWxQSE7K5XM2CdQjsCKdnbcELq+YQ
        zA26v+2DcjRITmrkaBXS33142WCg7UHHyZam/BgCWT6v/7bYEazYABQBwSH0zTszBTXDWf2QeGn8t
        0EvC5jn6j8Xa18ovJ6eZ/QdxETF7S03tbZ81pHY7ZXK2Ltw1eJ25sGryHoYSi1tTAQZ0zsXLwstBm
        QRdUx25g==;
Received: from [2601:1c2:d00:6a60::9526] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMGp6-0020M2-FM; Sun, 29 Jan 2023 23:10:56 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 1/9] Documentation: admin-guide: correct spelling
Date:   Sun, 29 Jan 2023 15:10:45 -0800
Message-Id: <20230129231053.20863-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230129231053.20863-1-rdunlap@infradead.org>
References: <20230129231053.20863-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Correct spelling problems for Documentation/admin-guide/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: dm-devel@redhat.com
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-mm@kvack.org
---
 Documentation/admin-guide/bcache.rst                       |    2 +-
 Documentation/admin-guide/cgroup-v1/blkio-controller.rst   |    2 +-
 Documentation/admin-guide/cgroup-v2.rst                    |   10 +++++-----
 Documentation/admin-guide/cifs/usage.rst                   |    4 ++--
 Documentation/admin-guide/device-mapper/cache-policies.rst |    2 +-
 Documentation/admin-guide/device-mapper/dm-ebs.rst         |    2 +-
 Documentation/admin-guide/device-mapper/dm-zoned.rst       |    2 +-
 Documentation/admin-guide/device-mapper/unstriped.rst      |   10 +++++-----
 Documentation/admin-guide/dynamic-debug-howto.rst          |    2 +-
 Documentation/admin-guide/gpio/gpio-sim.rst                |    2 +-
 Documentation/admin-guide/hw-vuln/mds.rst                  |    4 ++--
 Documentation/admin-guide/kernel-parameters.txt            |    8 ++++----
 Documentation/admin-guide/laptops/thinkpad-acpi.rst        |    2 +-
 Documentation/admin-guide/md.rst                           |    2 +-
 Documentation/admin-guide/media/bttv.rst                   |    2 +-
 Documentation/admin-guide/media/building.rst               |    2 +-
 Documentation/admin-guide/media/si476x.rst                 |    2 +-
 Documentation/admin-guide/media/vivid.rst                  |    2 +-
 Documentation/admin-guide/mm/hugetlbpage.rst               |    2 +-
 Documentation/admin-guide/mm/numa_memory_policy.rst        |    4 ++--
 Documentation/admin-guide/perf/hns3-pmu.rst                |    2 +-
 Documentation/admin-guide/pm/amd-pstate.rst                |    2 +-
 Documentation/admin-guide/spkguide.txt                     |    4 ++--
 Documentation/admin-guide/sysctl/vm.rst                    |    4 ++--
 Documentation/admin-guide/sysrq.rst                        |    2 +-
 25 files changed, 41 insertions(+), 41 deletions(-)

diff -- a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -624,7 +624,7 @@ and is an example of this type.
 Limits
 ------
 
-A child can only consume upto the configured amount of the resource.
+A child can only consume up to the configured amount of the resource.
 Limits can be over-committed - the sum of the limits of children can
 exceed the amount of resource available to the parent.
 
@@ -642,11 +642,11 @@ on an IO device and is an example of thi
 Protections
 -----------
 
-A cgroup is protected upto the configured amount of the resource
+A cgroup is protected up to the configured amount of the resource
 as long as the usages of all its ancestors are under their
 protected levels.  Protections can be hard guarantees or best effort
 soft boundaries.  Protections can also be over-committed in which case
-only upto the amount available to the parent is protected among
+only up to the amount available to the parent is protected among
 children.
 
 Protections are in the range [0, max] and defaults to 0, which is
@@ -1079,7 +1079,7 @@ All time durations are in microseconds.
 
 	  $MAX $PERIOD
 
-	which indicates that the group may consume upto $MAX in each
+	which indicates that the group may consume up to $MAX in each
 	$PERIOD duration.  "max" for $MAX indicates no limit.  If only
 	one number is written, $MAX is updated.
 
@@ -2289,7 +2289,7 @@ Cpuset Interface Files
 	For a valid partition root with the sibling cpu exclusivity
 	rule enabled, changes made to "cpuset.cpus" that violate the
 	exclusivity rule will invalidate the partition as well as its
-	sibiling partitions with conflicting cpuset.cpus values. So
+	sibling partitions with conflicting cpuset.cpus values. So
 	care must be taking in changing "cpuset.cpus".
 
 	A valid non-root parent partition may distribute out all its CPUs
diff -- a/Documentation/admin-guide/laptops/thinkpad-acpi.rst b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
--- a/Documentation/admin-guide/laptops/thinkpad-acpi.rst
+++ b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
@@ -1488,7 +1488,7 @@ Example of command to set keyboard langu
 Text corresponding to keyboard layout to be set in sysfs are: be(Belgian),
 cz(Czech), da(Danish), de(German), en(English), es(Spain), et(Estonian),
 fr(French), fr-ch(French(Switzerland)), hu(Hungarian), it(Italy), jp (Japan),
-nl(Dutch), nn(Norway), pl(Polish), pt(portugese), sl(Slovenian), sv(Sweden),
+nl(Dutch), nn(Norway), pl(Polish), pt(portuguese), sl(Slovenian), sv(Sweden),
 tr(Turkey)
 
 WWAN Antenna type
diff -- a/Documentation/admin-guide/md.rst b/Documentation/admin-guide/md.rst
--- a/Documentation/admin-guide/md.rst
+++ b/Documentation/admin-guide/md.rst
@@ -317,7 +317,7 @@ All md devices contain:
      suspended (not supported yet)
          All IO requests will block. The array can be reconfigured.
 
-         Writing this, if accepted, will block until array is quiessent
+         Writing this, if accepted, will block until array is quiescent
 
      readonly
          no resync can happen.  no superblocks get written.
diff -- a/Documentation/admin-guide/cgroup-v1/blkio-controller.rst b/Documentation/admin-guide/cgroup-v1/blkio-controller.rst
--- a/Documentation/admin-guide/cgroup-v1/blkio-controller.rst
+++ b/Documentation/admin-guide/cgroup-v1/blkio-controller.rst
@@ -106,7 +106,7 @@ Proportional weight policy files
           see Documentation/block/bfq-iosched.rst.
 
   blkio.bfq.weight_device
-          Specifes per cgroup per device weights, overriding the default group
+          Specifies per cgroup per device weights, overriding the default group
           weight. For more details, see Documentation/block/bfq-iosched.rst.
 
 	  Following is the format::
diff -- a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -403,7 +403,7 @@ Unit Tests for amd-pstate
 
  * We can introduce more functional or performance tests to align the result together, it will benefit power and performance scale optimization.
 
-1. Test case decriptions
+1. Test case descriptions
 
     1). Basic tests
 
diff -- a/Documentation/admin-guide/spkguide.txt b/Documentation/admin-guide/spkguide.txt
--- a/Documentation/admin-guide/spkguide.txt
+++ b/Documentation/admin-guide/spkguide.txt
@@ -1105,8 +1105,8 @@ speakup load
 Alternatively, you can add the above line to your file
 ~/.bashrc or ~/.bash_profile.
 
-If your system administrator ran himself the script, all the users will be able
-to change from English to the language choosed by root and do directly
+If your system administrator himself ran the script, all the users will be able
+to change from English to the language chosen by root and do directly
 speakupconf load (or add this to the ~/.bashrc or
 ~/.bash_profile file). If there are several languages to handle, the
 administrator (or every user) will have to run the first steps until speakupconf
diff -- a/Documentation/admin-guide/device-mapper/cache-policies.rst b/Documentation/admin-guide/device-mapper/cache-policies.rst
--- a/Documentation/admin-guide/device-mapper/cache-policies.rst
+++ b/Documentation/admin-guide/device-mapper/cache-policies.rst
@@ -70,7 +70,7 @@ the entries (each hotspot block covers a
 cache block).
 
 All this means smq uses ~25bytes per cache block.  Still a lot of
-memory, but a substantial improvement nontheless.
+memory, but a substantial improvement nonetheless.
 
 Level balancing
 ^^^^^^^^^^^^^^^
diff -- a/Documentation/admin-guide/device-mapper/dm-ebs.rst b/Documentation/admin-guide/device-mapper/dm-ebs.rst
--- a/Documentation/admin-guide/device-mapper/dm-ebs.rst
+++ b/Documentation/admin-guide/device-mapper/dm-ebs.rst
@@ -31,7 +31,7 @@ Mandatory parameters:
 
 Optional parameter:
 
-    <underyling sectors>:
+    <underlying sectors>:
         Number of sectors defining the logical block size of <dev path>.
         2^N supported, e.g. 8 = emulate 8 sectors of 512 bytes = 4KiB.
         If not provided, the logical block size of <dev path> will be used.
diff -- a/Documentation/admin-guide/device-mapper/dm-zoned.rst b/Documentation/admin-guide/device-mapper/dm-zoned.rst
--- a/Documentation/admin-guide/device-mapper/dm-zoned.rst
+++ b/Documentation/admin-guide/device-mapper/dm-zoned.rst
@@ -46,7 +46,7 @@ just like conventional zones.
 The zones of the device(s) are separated into 2 types:
 
 1) Metadata zones: these are conventional zones used to store metadata.
-Metadata zones are not reported as useable capacity to the user.
+Metadata zones are not reported as usable capacity to the user.
 
 2) Data zones: all remaining zones, the vast majority of which will be
 sequential zones used exclusively to store user data. The conventional
diff -- a/Documentation/admin-guide/device-mapper/unstriped.rst b/Documentation/admin-guide/device-mapper/unstriped.rst
--- a/Documentation/admin-guide/device-mapper/unstriped.rst
+++ b/Documentation/admin-guide/device-mapper/unstriped.rst
@@ -35,7 +35,7 @@ An example of undoing an existing dm-str
 
 This small bash script will setup 4 loop devices and use the existing
 striped target to combine the 4 devices into one.  It then will use
-the unstriped target ontop of the striped device to access the
+the unstriped target on top of the striped device to access the
 individual backing loop devices.  We write data to the newly exposed
 unstriped devices and verify the data written matches the correct
 underlying device on the striped array::
@@ -110,8 +110,8 @@ to get a 92% reduction in read latency u
 Example dmsetup usage
 =====================
 
-unstriped ontop of Intel NVMe device that has 2 cores
------------------------------------------------------
+unstriped on top of Intel NVMe device that has 2 cores
+------------------------------------------------------
 
 ::
 
@@ -124,8 +124,8 @@ respectively::
   /dev/mapper/nvmset0
   /dev/mapper/nvmset1
 
-unstriped ontop of striped with 4 drives using 128K chunk size
---------------------------------------------------------------
+unstriped on top of striped with 4 drives using 128K chunk size
+---------------------------------------------------------------
 
 ::
 
diff -- a/Documentation/admin-guide/hw-vuln/mds.rst b/Documentation/admin-guide/hw-vuln/mds.rst
--- a/Documentation/admin-guide/hw-vuln/mds.rst
+++ b/Documentation/admin-guide/hw-vuln/mds.rst
@@ -64,8 +64,8 @@ architecture section: :ref:`Documentatio
 Attack scenarios
 ----------------
 
-Attacks against the MDS vulnerabilities can be mounted from malicious non
-priviledged user space applications running on hosts or guest. Malicious
+Attacks against the MDS vulnerabilities can be mounted from malicious non-
+privileged user space applications running on hosts or guest. Malicious
 guest OSes can obviously mount attacks as well.
 
 Contrary to other speculation based vulnerabilities the MDS vulnerability
diff -- a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -356,7 +356,7 @@ The lowmem_reserve_ratio is an array. Yo
 
 But, these values are not used directly. The kernel calculates # of protection
 pages for each zones from them. These are shown as array of protection pages
-in /proc/zoneinfo like followings. (This is an example of x86-64 box).
+in /proc/zoneinfo like the following. (This is an example of x86-64 box).
 Each zone has an array of protection pages like this::
 
   Node 0, zone      DMA
@@ -433,7 +433,7 @@ a 2bit error in a memory module) is dete
 that cannot be handled by the kernel. In some cases (like the page
 still having a valid copy on disk) the kernel will handle the failure
 transparently without affecting any applications. But if there is
-no other uptodate copy of the data it will kill to prevent any data
+no other up-to-date copy of the data it will kill to prevent any data
 corruptions from propagating.
 
 1: Kill all processes that have the corrupted and not reloadable page mapped
diff -- a/Documentation/admin-guide/bcache.rst b/Documentation/admin-guide/bcache.rst
--- a/Documentation/admin-guide/bcache.rst
+++ b/Documentation/admin-guide/bcache.rst
@@ -204,7 +204,7 @@ For example::
 This should present your unmodified backing device data in /dev/loop0
 
 If your cache is in writethrough mode, then you can safely discard the
-cache device without loosing data.
+cache device without losing data.
 
 
 E) Wiping a cache device
diff -- a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-guide/sysrq.rst
--- a/Documentation/admin-guide/sysrq.rst
+++ b/Documentation/admin-guide/sysrq.rst
@@ -138,7 +138,7 @@ Command	    Function
 ``v``	    Forcefully restores framebuffer console
 ``v``	    Causes ETM buffer dump [ARM-specific]
 
-``w``	    Dumps tasks that are in uninterruptable (blocked) state.
+``w``	    Dumps tasks that are in uninterruptible (blocked) state.
 
 ``x``	    Used by xmon interface on ppc/powerpc platforms.
             Show global PMU Registers on sparc64.
diff -- a/Documentation/admin-guide/cifs/usage.rst b/Documentation/admin-guide/cifs/usage.rst
--- a/Documentation/admin-guide/cifs/usage.rst
+++ b/Documentation/admin-guide/cifs/usage.rst
@@ -399,7 +399,7 @@ A partial list of the supported mount op
   sep
 		if first mount option (after the -o), overrides
 		the comma as the separator between the mount
-		parms. e.g.::
+		parameters. e.g.::
 
 			-o user=myname,password=mypassword,domain=mydom
 
@@ -765,7 +765,7 @@ cifsFYI			If set to non-zero value, addi
 			Some debugging statements are not compiled into the
 			cifs kernel unless CONFIG_CIFS_DEBUG2 is enabled in the
 			kernel configuration. cifsFYI may be set to one or
-			nore of the following flags (7 sets them all)::
+			more of the following flags (7 sets them all)::
 
 			  +-----------------------------------------------+------+
 			  | log cifs informational messages		  | 0x01 |
diff -- a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -330,7 +330,7 @@ Examples
 
   // boot-args example, with newlines and comments for readability
   Kernel command line: ...
-    // see whats going on in dyndbg=value processing
+    // see what's going on in dyndbg=value processing
     dynamic_debug.verbose=3
     // enable pr_debugs in the btrfs module (can be builtin or loadable)
     btrfs.dyndbg="+p"
diff -- a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -86,7 +86,7 @@ by increasing or decreasing the value of
 
 Note: When the feature of freeing unused vmemmap pages associated with each
 hugetlb page is enabled, we can fail to free the huge pages triggered by
-the user when ths system is under memory pressure.  Please try again later.
+the user when the system is under memory pressure.  Please try again later.
 
 Pages that are used as huge pages are reserved inside the kernel and cannot
 be used for other purposes.  Huge pages cannot be swapped out under
diff -- a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -246,7 +246,7 @@ MPOL_INTERLEAVED
 	interleaved system default policy works in this mode.
 
 MPOL_PREFERRED_MANY
-	This mode specifices that the allocation should be preferrably
+	This mode specifies that the allocation should be preferably
 	satisfied from the nodemask specified in the policy. If there is
 	a memory pressure on all nodes in the nodemask, the allocation
 	can fall back to all existing numa nodes. This is effectively
@@ -360,7 +360,7 @@ and NUMA nodes.  "Usage" here means one
 2) examination of the policy to determine the policy mode and associated node
    or node lists, if any, for page allocation.  This is considered a "hot
    path".  Note that for MPOL_BIND, the "usage" extends across the entire
-   allocation process, which may sleep during page reclaimation, because the
+   allocation process, which may sleep during page reclamation, because the
    BIND policy nodemask is used, by reference, to filter ineligible nodes.
 
 We can avoid taking an extra reference during the usages listed above as
diff -- a/Documentation/admin-guide/gpio/gpio-sim.rst b/Documentation/admin-guide/gpio/gpio-sim.rst
--- a/Documentation/admin-guide/gpio/gpio-sim.rst
+++ b/Documentation/admin-guide/gpio/gpio-sim.rst
@@ -123,7 +123,7 @@ Each simulated GPIO chip creates a separ
 directory for each exposed line
 (e.g. ``/sys/devices/platform/gpio-sim.X/gpiochipY/``). The name of each group
 is of the form: ``'sim_gpioX'`` where X is the offset of the line. Inside each
-group there are two attibutes:
+group there are two attributes:
 
     ``pull`` - allows to read and set the current simulated pull setting for
                every line, when writing the value must be one of: ``'pull-up'``,
diff -- a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -676,7 +676,7 @@
 			Sets the size of kernel per-numa memory area for
 			contiguous memory allocations. A value of 0 disables
 			per-numa CMA altogether. And If this option is not
-			specificed, the default value is 0.
+			specified, the default value is 0.
 			With per-numa CMA enabled, DMA users on node nid will
 			first try to allocate buffer from the pernuma area
 			which is located in node nid, if the allocation fails,
@@ -946,7 +946,7 @@
 			driver code when a CPU writes to (or reads from) a
 			random memory location. Note that there exists a class
 			of memory corruptions problems caused by buggy H/W or
-			F/W or by drivers badly programing DMA (basically when
+			F/W or by drivers badly programming DMA (basically when
 			memory is written at bus level and the CPU MMU is
 			bypassed) which are not detectable by
 			CONFIG_DEBUG_PAGEALLOC, hence this option will not help
@@ -1732,7 +1732,7 @@
 			boot-time allocation of gigantic hugepages is skipped.
 
 	hugetlb_free_vmemmap=
-			[KNL] Reguires CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+			[KNL] Requires CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 			enabled.
 			Control if HugeTLB Vmemmap Optimization (HVO) is enabled.
 			Allows heavy hugetlb users to free up some more
@@ -3693,7 +3693,7 @@
 			implementation; requires CONFIG_GENERIC_IDLE_POLL_SETUP
 			to be effective. This is useful on platforms where the
 			sleep(SH) or wfi(ARM,ARM64) instructions do not work
-			correctly or when doing power measurements to evalute
+			correctly or when doing power measurements to evaluate
 			the impact of the sleep instructions. This is also
 			useful when using JTAG debugger.
 
diff -- a/Documentation/admin-guide/perf/hns3-pmu.rst b/Documentation/admin-guide/perf/hns3-pmu.rst
--- a/Documentation/admin-guide/perf/hns3-pmu.rst
+++ b/Documentation/admin-guide/perf/hns3-pmu.rst
@@ -53,7 +53,7 @@ two events have same value of bits 0~15
 event pair. And the bit 16 of config indicates getting counter 0 or
 counter 1 of hardware event.
 
-After getting two values of event pair in usersapce, the formula of
+After getting two values of event pair in userspace, the formula of
 computation to calculate real performance data is:::
 
   counter 0 / counter 1
diff -- a/Documentation/admin-guide/media/bttv.rst b/Documentation/admin-guide/media/bttv.rst
--- a/Documentation/admin-guide/media/bttv.rst
+++ b/Documentation/admin-guide/media/bttv.rst
@@ -909,7 +909,7 @@ DE hat diverse Treiber fuer diese Modell
   - TVPhone98 (Bt878)
   - AVerTV und TVCapture98 w/VCR (Bt 878)
   - AVerTVStudio und TVPhone98 w/VCR (Bt878)
-  - AVerTV GO Serie (Kein SVideo Input)
+  - AVerTV GO Series (Kein SVideo Input)
   - AVerTV98 (BT-878 chip)
   - AVerTV98 mit Fernbedienung (BT-878 chip)
   - AVerTV/FM98 (BT-878 chip)
diff -- a/Documentation/admin-guide/media/building.rst b/Documentation/admin-guide/media/building.rst
--- a/Documentation/admin-guide/media/building.rst
+++ b/Documentation/admin-guide/media/building.rst
@@ -137,7 +137,7 @@ The ``LIRC user interface`` option adds
 from remote controllers.
 
 The ``Support for eBPF programs attached to lirc devices`` option allows
-the usage of special programs (called eBPF) that would allow aplications
+the usage of special programs (called eBPF) that would allow applications
 to add extra remote controller decoding functionality to the Linux Kernel.
 
 The ``Remote controller decoders`` option allows selecting the
diff -- a/Documentation/admin-guide/media/si476x.rst b/Documentation/admin-guide/media/si476x.rst
--- a/Documentation/admin-guide/media/si476x.rst
+++ b/Documentation/admin-guide/media/si476x.rst
@@ -142,7 +142,7 @@ The drivers exposes following files:
 				  indicator
   0x18		 lassi		  Signed Low side adjacent Channel
 				  Strength indicator
-  0x19		 hassi		  ditto fpr High side
+  0x19		 hassi		  ditto for High side
   0x20		 mult		  Multipath indicator
   0x21		 dev		  Frequency deviation
   0x24		 assi		  Adjacent channel SSI
diff -- a/Documentation/admin-guide/media/vivid.rst b/Documentation/admin-guide/media/vivid.rst
--- a/Documentation/admin-guide/media/vivid.rst
+++ b/Documentation/admin-guide/media/vivid.rst
@@ -580,7 +580,7 @@ Metadata Capture
 ----------------
 
 The Metadata capture generates UVC format metadata. The PTS and SCR are
-transmitted based on the values set in vivid contols.
+transmitted based on the values set in vivid controls.
 
 The Metadata device will only work for the Webcam input, it will give
 back an error for all other inputs.
