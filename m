Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A489B626176
	for <lists+cgroups@lfdr.de>; Fri, 11 Nov 2022 19:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbiKKShq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Nov 2022 13:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbiKKSgv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Nov 2022 13:36:51 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814C2845D8;
        Fri, 11 Nov 2022 10:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668191787; x=1699727787;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k3YCP4QpTMOre6gSfvMdJZ1a5qHh/SBGDc5XHII2Kw0=;
  b=Olxpu5x0vcSe8HBAo5ghJOeZv8316LiznvpTaLiovqgbW0Vho7EWEPJZ
   I8N73QSBtc/ddGwU67MCMYlJXshhI9MkG6LAsw8yteYUDul6FkLIYL3UO
   ZFDjhHchM7Wnbs1ReZ+yX0lsndcTHULnlThG3+FulM1Suiez4w+RlRj2H
   +k6Dt2V+Jt2kBtFZQNixYy810aGEm7gUGItP77d0IJQ/XUW5YXZ5+4fRc
   BvDLBuMyHX88VvbWS+qwNPgedXDB0m1joaAObbgWlhHoXCwa4zuYM3aRm
   aCeh/nRBBz0RWQkAeVXH0uitOdWR071z/0vE2oUl4P7JiNSnHQdu7o0zX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="313447749"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="313447749"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:36:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="640089475"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="640089475"
Received: from hermesli-mobl.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.212.218.5])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:36:25 -0800
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     zhiquan1.li@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH 26/26] Docs/x86/sgx: Add description for cgroup support
Date:   Fri, 11 Nov 2022 10:35:31 -0800
Message-Id: <20221111183532.3676646-27-kristen@linux.intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221111183532.3676646-1-kristen@linux.intel.com>
References: <20221111183532.3676646-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Add initial documentation of how to regulate the distribution of
SGX Enclave Page Cache (EPC) memory via the Miscellaneous cgroup
controller.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 Documentation/x86/sgx.rst | 77 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
index 2bcbffacbed5..f6ca5594dcf2 100644
--- a/Documentation/x86/sgx.rst
+++ b/Documentation/x86/sgx.rst
@@ -300,3 +300,80 @@ to expected failures and handle them as follows:
    first call.  It indicates a bug in the kernel or the userspace client
    if any of the second round of ``SGX_IOC_VEPC_REMOVE_ALL`` calls has
    a return code other than 0.
+
+
+Cgroup Support
+==============
+
+The "sgx_epc" resource within the Miscellaneous cgroup controller regulates
+distribution of SGX EPC memory, which is a subset of system RAM that
+is used to provide SGX-enabled applications with protected memory,
+and is otherwise inaccessible, i.e. shows up as reserved in
+/proc/iomem and cannot be read/written outside of an SGX enclave.
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
+The SGX EPC subsystem is analogous to the memory subsytem, and
+it implements limit and protection models for EPC memory.
+
+SGX EPC Interface Files
+-----------------------
+
+For a generic description of the Miscellaneous controller interface
+files, please see Documentation/admin-guide/cgroup-v2.rst
+
+All SGX EPC memory amounts are in bytes unless explicitly stated
+otherwise.  If a value which is not PAGE_SIZE aligned is written,
+the actual value used by the controller will be rounded down to
+the closest PAGE_SIZE multiple.
+
+  misc.capacity
+        A read-only flat-keyed file shown only in the root cgroup.
+        The sgx_epc resource will show the total amount of EPC
+        memory available on the platform.
+
+  misc.current
+        A read-only flat-keyed file shown in the non-root cgroups.
+        The sgx_epc resource will show the current active EPC memory
+        usage of the cgroup and its descendants. EPC pages that are
+        swapped out to backing RAM are not included in the current count.
+
+  misc.max
+        A read-write single value file which exists on non-root
+        cgroups. The sgx_epc resource will show the EPC usage
+        hard limit. The default is "max".
+
+        If a cgroup's EPC usage reaches this limit, EPC allocations,
+        e.g. for page fault handling, will be blocked until EPC can
+        be reclaimed from the cgroup.  If EPC cannot be reclaimed in
+        a timely manner, reclaim will be forced, e.g. by ignoring LRU.
+
+  misc.events
+	A read-write flat-keyed file which exists on non-root cgroups.
+	Writes to the file reset the event counters to zero.  A value
+	change in this file generates a file modified event.
+
+	  max
+		The number of times the cgroup has triggered a reclaim
+		due to its EPC usage approaching (or exceeding) its max
+		EPC boundary.
+
+Migration
+---------
+
+Once an EPC page is charged to a cgroup (during allocation), it
+remains charged to the original cgroup until the page is released
+or reclaimed.  Migrating a process to a different cgroup doesn't
+move the EPC charges that it incurred while in the previous cgroup
+to its new cgroup.
-- 
2.37.3

