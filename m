Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A135E6964
	for <lists+cgroups@lfdr.de>; Thu, 22 Sep 2022 19:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiIVROc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Sep 2022 13:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbiIVROG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Sep 2022 13:14:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24DE103FD0;
        Thu, 22 Sep 2022 10:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663866843; x=1695402843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0g8SxneYPLxLe679j97cgFtWHKoCh+6kgTZISdI3av0=;
  b=KMJulJLdwqoBaA8RaBo3oSjztV+niqBy3NSBl500Z39dbhy6NFZzAXt2
   C/GjUiZvcsrs2ZMZoj5Z+XbTk8zkUllOMyWqGg5oPeYuGPu8W2lu/PX65
   uVqowGifTtEzsTGT0LM4OB3ckWB5cmrJoHqJEAczDumyJBstM1GnVR3li
   CSYt13gdR3ml3IcZv02NKucZy15PDWRVWqD6GRQV3QQmjlvVqsH92DocN
   NPVHM0MwJnyCjCOy2jU9IjlQwpQwNVGrpZoyORqQODP8kxUef3tDP+O9h
   /M3lg+y/CeNm3HmA//WNbkNOT+G9rMEDNhPV12c5ofUcLFKiLvTDIH017
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="283421613"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="283421613"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 10:12:32 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="762270292"
Received: from sknaidu-mobl1.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.212.165.187])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 10:11:56 -0700
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-doc@vger.kernel.org
Subject: [RFC PATCH 20/20] docs, cgroup, x86/sgx: Add SGX EPC cgroup controller documentation
Date:   Thu, 22 Sep 2022 10:10:57 -0700
Message-Id: <20220922171057.1236139-21-kristen@linux.intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922171057.1236139-1-kristen@linux.intel.com>
References: <20220922171057.1236139-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Add initial documentation for the SGX EPC cgroup controller,
which regulates distribution of SGX Enclave Page Cache (EPC) memory.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 201 ++++++++++++++++++++++++
 1 file changed, 201 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index be4a77baf784..c355cb08fc18 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -71,6 +71,10 @@ v1 is available under :ref:`Documentation/admin-guide/cgroup-v1/index.rst <cgrou
        5.9-2 Migration and Ownership
      5-10. Others
        5-10-1. perf_event
+     5-11. SGX EPC
+       5-11-1. SGX EPC Interface Files
+       5-11-2. Usage Guidelines
+       5-11-3. Migration
      5-N. Non-normative information
        5-N-1. CPU controller root cgroup process behaviour
        5-N-2. IO controller root cgroup process behaviour
@@ -2440,6 +2444,203 @@ always be filtered by cgroup v2 path.  The controller can still be
 moved to a legacy hierarchy after v2 hierarchy is populated.
 
 
+SGX EPC
+-------
+
+The "sgx_epc" controller regulates distribution of SGX EPC memory,
+which is a subset of system RAM that is used to provide SGX-enabled
+applications with protected memory, and is otherwise inaccessible,
+i.e. shows up as reserved in /proc/iomem and cannot be read/written
+outside of an SGX enclave.
+
+Although current systems implement EPC by stealing memory from RAM,
+for all intents and purposes the EPC is independent from normal system
+memory, e.g. must be reserved at boot from RAM and cannot be converted
+between EPC and normal memory while the system is running.  The EPC is
+managed by the SGX subsystem and is not accounted by the memory
+controller.  Note that this is true only for EPC memory itself, i.e.
+normal memory allocations related to SGX and EPC memory, e.g. the
+backing memory for evicted EPC pages, are accounted, limited and
+protected by the memory controller.
+
+Much like normal system memory, EPC memory can be overcommitted via
+virtual memory techniques and pages can be swapped out of the EPC
+to their backing store (normal system memory allocated via shmem).
+The SGX EPC subsystem is analogous to the memory subsytem, and the
+SGX EPC controller is in turn analogous to the memory controller;
+it implements limit and protection models for EPC memory.
+
+See Documentation/x86/sgx.rst for more info on SGX and EPC.
+
+SGX EPC Interface Files
+~~~~~~~~~~~~~~~~~~~~~~~
+
+All SGX EPC memory amounts are in bytes unless explicitly stated
+otherwise.  If a value which is not PAGE_SIZE aligned is written,
+the actual value used by the controller will be rounded down to
+the closest PAGE_SIZE multiple.
+
+  sgx_epc.current
+
+	A read-only single value file which exists on all cgroups.
+
+	The total amount of EPC memory currently being used by the
+	cgroup and its descendants.
+
+  sgx_epc.low
+
+	A read-write single value file which exists on non-root
+	cgroups.  The default is "0".
+
+	Best-effort protection of EPC usage.  If the EPC usage of a
+	cgroup is below its limits, and all its ancestors are below
+	their low limits, then the cgroup's EPC won't be reclaimed
+	unless EPC cannot be reclaimed from unprotected cgroups,
+	e.g. all sibling cgroups are also below their low limit.
+
+	Setting low to a value more than the amount of EPC available
+	is discouraged.  The low limit is effectively ignored if the
+	cgroup's high or max limit is less than its low limit.
+
+  sgx_epc.high
+
+	A read-write single value file which exists on non-root
+	cgroups.  The default is "max".
+
+	EPC usage best-effort limit.  This is the main mechanism to
+	control EPC usage of a cgroup.  If a cgroup's usage goes
+	over the high boundary, EPC pages will be reclaimed from
+	the cgroup until it is back under the high limit.
+
+	Going over the high limit does not prevent allocation of
+	additional EPC pages, e.g. EPC usage will often spike above
+	the high limit during enclave creation, when a large number
+	of EPC pages are EADDed in a short period.
+
+  sgx_epc.max
+
+	A read-write single value file which exists on non-root
+	cgroups.  The default is "max".
+
+	EPC usage hard limit.  If a cgroup's EPC usage reaches this
+	limit, EPC allocations, e.g. for page fault handling, will
+	be blocked until EPC can be reclaimed from the cgroup.  If
+	EPC cannot be reclaimed in a timely manner, reclaim will be
+	forced, e.g. by ignoring LRU.
+
+	The max limit is intended to be a last line of defense; it
+	should rarely come into play on a properly configured and
+	monitored system.
+
+  sgx_epc.stats
+
+	A read-write flat-keyed file which exists on all cgroups.
+	Reads from the file display the cgroup's statistics, while
+	writes reset the underlying counters (if applicable).
+
+	The entries are ordered to be human readable, and new entries
+	can show up in the middle.  Don't rely on items remaining in a
+	fixed position; use the keys to look up specific values!
+
+	The following entries are defined.
+
+	  pages
+
+		The total number of pages currently being used by the
+		cgroup and its descendants, i.e. sgx_epc.current / 4096.
+
+	  direct
+
+		The number of pages currently being used by the cgroup
+		itself, excluding its descendants.
+
+	  indirect
+
+		The number of pages currently being used by the cgroup's
+		descendants, excluding its own pages.
+
+	  reclaimed
+
+		The number of pages that have been reclaimed from the
+		cgroup (since sgx_epc.stats was last reset).
+
+	  reclamations
+
+		The number of times this cgroup's LRU lists have been
+		scanned for reclaim, i.e. the number of times the cgroup
+		has been selected for reclaim via any code path.
+
+  sgx_epc.events
+
+	A read-write flat-keyed file which exists on non-root cgroups.
+	Writes to the file reset the event counters to zero.  A value
+	change in this file generates a file modified event.
+
+	The following entries are defined.
+
+	  low
+
+		The number of times the cgroup has been reclaimed even
+		though its usage is under the low boundary, e.g. due to
+		all sibling cgroups also being low.  This event usually
+		indicates that the low boundary is over-committed.
+
+	  high
+
+		The number of times the cgroup has triggered a reclaim
+		due to its EPC usage exceeding its high EPC boundary.
+		This event is expected for cgroups whose EPC usage is
+		capped by its high limit rather than global pressure.
+
+	  max
+
+		The number of times the cgroup has triggered a reclaim
+		due to its EPC usage  approaching (or exceeding) its max
+		EPC boundary.
+
+Usage Guidelines
+~~~~~~~~~~~~~~~~
+
+"sgx_epc.high" and "sgx_epc.low" are the main mechanisms to control
+EPC usage; using "sgx_epc.max" as anything other than a safety net
+is inadvisable, SGX application performance will suffer greatly if
+a process encounters its max limit.  Because a cgroup is allowed to
+breach its high limit, e.g. to fault in a page, performance is not
+artificially limited, whereas the max limit will effectively block
+a faulting application until the kernel can reclaim EPC memory from
+the cgroup.
+
+Exactly how "sgx_epc.high" is utilized will vary case by case, i.e.
+there is no one "correct" strategy.  Deferring to global EPC memory
+pressure, e.g. by overcommitting on the high limit, may be the most
+effective approach for a particular situation, whereas a different
+scenario might warrant a more draconian usage of the high limit.
+Regardless of the strategy used, because breach of the high limit
+does not cause processes to block or be killed, a management agent
+has ample opportunity to monitor and react as needed, e.g. it can
+raise the offending cgroup's high limit or terminate the workload.
+
+Similarly, "sgx_epc.low" can play different roles depending on the
+situation, e.g. it can be set to a relatively high value to protect
+a mission critical workload, or it may be used to reserve a minimal
+amount of EPC memory simply to ensure forward progress.  Employing
+"sgx_epc.low" in some capacity is generally recommended, especially
+when overcommitting "sgx_epc.high", as it is relatively common for
+a system to be under heavy EPC pressure; this holds true even on a
+carefully tuned system, as initializing an enclave requires all of
+the enclave's pages be brought into the EPC at some point prior to
+initialization, if only temporarily.
+
+Migration
+~~~~~~~~~~~~~~~~
+
+Once an EPC page is charged to a cgroup (during allocation), it
+remains charged to the original cgroup until the page is released
+or reclaimed.  Migrating a process to a different cgroup doesn't
+move the EPC charges that it incurred while in the previous cgroup
+to its new cgroup.
+
+
 Non-normative information
 -------------------------
 
-- 
2.37.3

