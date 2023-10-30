Return-Path: <cgroups+bounces-132-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5B77DBFB9
	for <lists+cgroups@lfdr.de>; Mon, 30 Oct 2023 19:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09681C20B23
	for <lists+cgroups@lfdr.de>; Mon, 30 Oct 2023 18:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C243919BA8;
	Mon, 30 Oct 2023 18:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dKJ3Ocih"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5919A19BAA
	for <cgroups@vger.kernel.org>; Mon, 30 Oct 2023 18:20:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0287210B;
	Mon, 30 Oct 2023 11:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698690037; x=1730226037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zF19XFFiqPbLLTSJfpDVbR2CVLpYKiYAcawYZXkE6BY=;
  b=dKJ3OcihbkND6gY5GqP9gflXvAXxIzl8V6KEUSDbh3Pvm04SP6tdpyHi
   ft9Y3Tgdr5HPsDrz9kvWTi12q+1fJvzdGagCHiHJHarie9o19R6VXEDOJ
   vVpVC8HPpeFyBwQSvO0qB25N0B9nHTW7R59RxBaLfegI4JZ+1tq8mWG62
   +VEz5FFzQl1UAabuyZW/g3Jontb7zi3MMEV2hNASaYlOErl+dKxhtfZuk
   OmwGIN+oMG7/sz0H8FcReMnfAmJ6pUf3VDFHcBvC31s8DCqBuvnjuDw2f
   ftk958JBVY/VULcsu6IPRemuqeKtkxXaZr9yfCOJf1O8eMR5gFTgE8Lun
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="367479640"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="367479640"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 11:20:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="789529534"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="789529534"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orsmga008.jf.intel.com with ESMTP; 30 Oct 2023 11:20:30 -0700
From: Haitao Huang <haitao.huang@linux.intel.com>
To: jarkko@kernel.org,
	dave.hansen@linux.intel.com,
	tj@kernel.org,
	mkoutny@suse.com,
	linux-kernel@vger.kernel.org,
	linux-sgx@vger.kernel.org,
	x86@kernel.org,
	cgroups@vger.kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	sohil.mehta@intel.com
Cc: zhiquan1.li@intel.com,
	kristen@linux.intel.com,
	seanjc@google.com,
	zhanb@microsoft.com,
	anakrish@microsoft.com,
	mikko.ylinen@linux.intel.com,
	yangjie@microsoft.com,
	Sean Christopherson <sean.j.christopherson@intel.com>,
	Haitao Huang <haitao.huang@linux.intel.com>
Subject: [PATCH v6 11/12] Docs/x86/sgx: Add description for cgroup support
Date: Mon, 30 Oct 2023 11:20:12 -0700
Message-Id: <20231030182013.40086-12-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231030182013.40086-1-haitao.huang@linux.intel.com>
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
V6:
- Remove mentioning of VMM specific behavior on handling SIGBUS
- Remove statement of forced reclamation, add statement to specify
ENOMEM returned when no reclamation possible.
- Added statements on the non-preemptive nature for the max limit
- Dropped Reviewed-by tag because of changes

V4:
- Fix indentation (Randy)
- Change misc.events file to be read-only
- Fix a typo for 'subsystem'
- Add behavior when VMM overcommit EPC with a cgroup (Mikko)
---
 Documentation/arch/x86/sgx.rst | 74 ++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/Documentation/arch/x86/sgx.rst b/Documentation/arch/x86/sgx.rst
index d90796adc2ec..dfc8fac13ab2 100644
--- a/Documentation/arch/x86/sgx.rst
+++ b/Documentation/arch/x86/sgx.rst
@@ -300,3 +300,77 @@ to expected failures and handle them as follows:
    first call.  It indicates a bug in the kernel or the userspace client
    if any of the second round of ``SGX_IOC_VEPC_REMOVE_ALL`` calls has
    a return code other than 0.
+
+
+Cgroup Support
+==============
+
+The "sgx_epc" resource within the Miscellaneous cgroup controller regulates distribution of SGX
+EPC memory, which is a subset of system RAM that is used to provide SGX-enabled applications
+with protected memory, and is otherwise inaccessible, i.e. shows up as reserved in /proc/iomem
+and cannot be read/written outside of an SGX enclave.
+
+Although current systems implement EPC by stealing memory from RAM, for all intents and
+purposes the EPC is independent from normal system memory, e.g. must be reserved at boot from
+RAM and cannot be converted between EPC and normal memory while the system is running.  The EPC
+is managed by the SGX subsystem and is not accounted by the memory controller.  Note that this
+is true only for EPC memory itself, i.e.  normal memory allocations related to SGX and EPC
+memory, e.g. the backing memory for evicted EPC pages, are accounted, limited and protected by
+the memory controller.
+
+Much like normal system memory, EPC memory can be overcommitted via virtual memory techniques
+and pages can be swapped out of the EPC to their backing store (normal system memory allocated
+via shmem).  The SGX EPC subsystem is analogous to the memory subsystem, and it implements
+limit and protection models for EPC memory.
+
+SGX EPC Interface Files
+-----------------------
+
+For a generic description of the Miscellaneous controller interface files, please see
+Documentation/admin-guide/cgroup-v2.rst
+
+All SGX EPC memory amounts are in bytes unless explicitly stated otherwise.  If a value which
+is not PAGE_SIZE aligned is written, the actual value used by the controller will be rounded
+down to the closest PAGE_SIZE multiple.
+
+  misc.capacity
+        A read-only flat-keyed file shown only in the root cgroup.  The sgx_epc resource will
+        show the total amount of EPC memory available on the platform.
+
+  misc.current
+        A read-only flat-keyed file shown in the non-root cgroups.  The sgx_epc resource will
+        show the current active EPC memory usage of the cgroup and its descendants. EPC pages
+        that are swapped out to backing RAM are not included in the current count.
+
+  misc.max
+        A read-write single value file which exists on non-root cgroups. The sgx_epc resource
+        will show the EPC usage hard limit. The default is "max".
+
+        If a cgroup's EPC usage reaches this limit, EPC allocations, e.g. for page fault
+        handling, will be blocked until EPC can be reclaimed from the cgroup. If there are no
+        pages left that are reclaimable within the same group, the kernel returns ENOMEM.
+
+        The EPC pages allocated for a guest VM by the virtual EPC driver are not reclaimable by
+        the host kernel. In case the guest cgroup's limit is reached and no reclaimable pages
+        left in the same cgroup, the virtual EPC driver returns SIGBUS to the user space
+        process to indicate failure on new EPC allocation requests.
+
+        The misc.max limit is non-preemptive. If a user writes a limit lower than the current
+        usage to this file, the cgroup will not preemptively deallocate pages currently in use,
+        and will only start blocking the next allocation and reclaiming EPC at that time.
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
+Once an EPC page is charged to a cgroup (during allocation), it remains charged to the original
+cgroup until the page is released or reclaimed.  Migrating a process to a different cgroup
+doesn't move the EPC charges that it incurred while in the previous cgroup to its new cgroup.
-- 
2.25.1


