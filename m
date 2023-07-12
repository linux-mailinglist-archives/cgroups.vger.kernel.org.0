Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E59B751408
	for <lists+cgroups@lfdr.de>; Thu, 13 Jul 2023 01:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjGLXCz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jul 2023 19:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjGLXCY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jul 2023 19:02:24 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35769173C;
        Wed, 12 Jul 2023 16:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689202939; x=1720738939;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3e6QAWNAF76VcJMJbXCen6twY/3D+MIdev0F0r8XF58=;
  b=oANffFx/YGS2HrYl6AeDIxCZkLz6ksoJBoPchd3wx2flotjBff7sN+6d
   LESeEwRrbdzfSWFlBb8k7N5cFOORNp/CdluwmuBiWUa5b5d5PCWzChBdx
   jdyJWb9SGrLTG8l7DK1cYBu2hxVj5L4MO4PNDwA98HmpaPGn3AFg/0za3
   Nr6yJX1OUphVOSOiUqXungmEmTFXMqkFRCgRe7b/eMsCz7HXcrAQai2vQ
   r36H2emfNvTGoeg3UrZjsSvQVQ12sJYDix9OCsLqiU2uvBggiGrigUxMV
   mZi36gWRI0yAff4757UqMzoKNbBlfqPqHdOAKY4LZSzKhzq9JmeBtn5Ru
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="428774196"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="428774196"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 16:02:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="835338672"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="835338672"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jul 2023 16:02:17 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     kai.huang@intel.com, reinette.chatre@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        zhiquan1.li@intel.com, seanjc@google.com, bagasdotme@gmail.com,
        linux-doc@vger.kernel.org, zhanb@microsoft.com,
        anakrish@microsoft.com, mikko.ylinen@linux.intel.com
Subject: [PATCH v3 22/28] Docs/x86/sgx: Add description for cgroup support
Date:   Wed, 12 Jul 2023 16:01:56 -0700
Message-Id: <20230712230202.47929-23-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230712230202.47929-1-haitao.huang@linux.intel.com>
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Kristen Carlson Accardi <kristen@linux.intel.com>

Add initial documentation of how to regulate the distribution of
SGX Enclave Page Cache (EPC) memory via the Miscellaneous cgroup
controller.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/arch/x86/sgx.rst | 77 ++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/Documentation/arch/x86/sgx.rst b/Documentation/arch/x86/sgx.rst
index 2bcbffacbed5..f6ca5594dcf2 100644
--- a/Documentation/arch/x86/sgx.rst
+++ b/Documentation/arch/x86/sgx.rst
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
2.25.1

