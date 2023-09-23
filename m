Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314D87ABD75
	for <lists+cgroups@lfdr.de>; Sat, 23 Sep 2023 05:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjIWDH6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Sep 2023 23:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjIWDHf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Sep 2023 23:07:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77DACDF;
        Fri, 22 Sep 2023 20:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695438431; x=1726974431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Oho//VRT6sgLk83ZBgqkFv56uGXmUurj2kM6E/HQC/w=;
  b=RO/1HNJeT4qnVSmRa5rjJJk7FNy1Oik86PwAYhgo0OtiiehjLjPxyAqr
   VmY7ueMLbqHSttxIm9aGfQlWXkHc/pGoc34XKn0EEBP1MZb91qK31wc6P
   LQH1Junbe41MUA/rOMEWtcZTLrVTbHrOneLkVgCcUL0Sf2DUN8xOffBiT
   gQ2+H+FH9DpIsDG+LP/EqJdS6c0mGivVf8+4PtU4S7EJJ5jDkB8aN/K/w
   0JEBaPXjlEJBb+Q6FW1z6ZRYSH+y3PeClUyBMkJMl+7VLDUKWo3ErUpsx
   TtYASngDwaJKb+58MpMkkN85B1Taxx7era1tQB1IAcdm7vSvflEAvr4JM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="447466860"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="447466860"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 20:07:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="891048587"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="891048587"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmsmga001.fm.intel.com with ESMTP; 22 Sep 2023 20:06:14 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sohil.mehta@intel.com
Cc:     zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
        zhanb@microsoft.com, anakrish@microsoft.com,
        mikko.ylinen@linux.intel.com, yangjie@microsoft.com
Subject: [PATCH v5 17/18] Docs/x86/sgx: Add description for cgroup support
Date:   Fri, 22 Sep 2023 20:06:56 -0700
Message-Id: <20230923030657.16148-18-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230923030657.16148-1-haitao.huang@linux.intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Add initial documentation of how to regulate the distribution of
SGX Enclave Page Cache (EPC) memory via the Miscellaneous cgroup
controller.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang<haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang<haitao.huang@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
V4:
- Fix indentation (Randy)
- Change misc.events file to be read-only
- Fix a typo for 'subsystem'
- Add behavior when VMM overcommit EPC with a cgroup (Mikko)
---
 Documentation/arch/x86/sgx.rst | 82 ++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/Documentation/arch/x86/sgx.rst b/Documentation/arch/x86/sgx.rst
index d90796adc2ec..65c211bd5342 100644
--- a/Documentation/arch/x86/sgx.rst
+++ b/Documentation/arch/x86/sgx.rst
@@ -300,3 +300,85 @@ to expected failures and handle them as follows:
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
+The SGX EPC subsystem is analogous to the memory subsystem, and
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
+        The EPC pages allocated for KVM guests by the virtual EPC driver
+        are not reclaimable by the host kernel SGX reclaimers. If a VMM
+        tries to start a VM within a cgroup whose EPC usage reaches this
+        limit, the virtual EPC driver will stop allocating more EPC for the
+        VM, and return SIGBUS to the VMM which would abort the VM launch.
+
+  misc.events
+        A read-only flat-keyed file which exists on non-root cgroups.
+        A value change in this file generates a file modified event.
+
+          max
+                The number of times the cgroup has triggered a reclaim
+                due to its EPC usage approaching (or exceeding) its max
+                EPC boundary.
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

