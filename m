Return-Path: <cgroups+bounces-1274-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC318418EA
	for <lists+cgroups@lfdr.de>; Tue, 30 Jan 2024 03:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1570B288CF8
	for <lists+cgroups@lfdr.de>; Tue, 30 Jan 2024 02:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E5636AE4;
	Tue, 30 Jan 2024 02:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XmuJfFn5"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C48553E22;
	Tue, 30 Jan 2024 02:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706580592; cv=none; b=iaa5fDttlwQnIwFYvxAUO+B4UaHEGXrtce3YtiS92y2INPHGmhR63kC3cXgRl3r3pDx7430ZOYPTx3UVEiQCyt9x0pzbGRIS+EPy4SV5PxS7jgXR8zp2+BXoo5wqwYE0QTE4NfajgwAczc0d1eZiy/vJW8nbFxmk3XZd4f9h9kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706580592; c=relaxed/simple;
	bh=9w5lQ2pOZdanN4uPSlw3FqAR9K1n/EpTv9COUE47BCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t+Sq7J8EJe2HowbyY1q+sVs952PxBUHo2M1AfUl//WI81avVLHBDX8c00MnHE/dBQsdQ0EBOq7XyyR3HaefUGgRCNDWKqCKeLCBbYpkTKOtZim1TfdzR6RVXeBGYanwTylEKsfNSkWRS9FSsWRL43Xn97jF9Q/5FiIj2xWu8sds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XmuJfFn5; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706580591; x=1738116591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9w5lQ2pOZdanN4uPSlw3FqAR9K1n/EpTv9COUE47BCo=;
  b=XmuJfFn5sR0gIfTeqXdJANuhrkcM5p4430vksCsV2y/J1IazHJK09rTK
   b92HkrTtd6kkhlRlbC6MqPi5arwX/umA3hwjkWsKaJi1Uj4iFcs6LP8pM
   52KolE/nldSlsjTjIvqrbE4E9lZ4pGhlrfNN2YTWh9AEDANM2RwH5myua
   EtiLv3kBE42+s1TjLKW8gWpsctQctV9Ftgp7mn+qZZEerlbXime7FW8Eg
   trLu8iTae9p09mvmrnJIVtBmipsdLPo+miKTrIWX5ek3oFuB5nRc5Auuw
   A+kyZZIlBa8FItow2duuCjr4jC3IzEsh4hS7hhT5u9hN7Rz0O9xRNCAB8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="16531031"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="16531031"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 18:09:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="822042360"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="822042360"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orsmga001.jf.intel.com with ESMTP; 29 Jan 2024 18:09:41 -0800
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
	chrisyan@microsoft.com
Subject: [PATCH v8 14/15] Docs/x86/sgx: Add description for cgroup support
Date: Mon, 29 Jan 2024 18:09:37 -0800
Message-Id: <20240130020938.10025-15-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240130020938.10025-1-haitao.huang@linux.intel.com>
References: <20240130020938.10025-1-haitao.huang@linux.intel.com>
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
V8:
- Limit text width to 80 characters to be consistent.

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
 Documentation/arch/x86/sgx.rst | 83 ++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/Documentation/arch/x86/sgx.rst b/Documentation/arch/x86/sgx.rst
index d90796adc2ec..c537e6a9aa65 100644
--- a/Documentation/arch/x86/sgx.rst
+++ b/Documentation/arch/x86/sgx.rst
@@ -300,3 +300,86 @@ to expected failures and handle them as follows:
    first call.  It indicates a bug in the kernel or the userspace client
    if any of the second round of ``SGX_IOC_VEPC_REMOVE_ALL`` calls has
    a return code other than 0.
+
+
+Cgroup Support
+==============
+
+The "sgx_epc" resource within the Miscellaneous cgroup controller regulates
+distribution of SGX EPC memory, which is a subset of system RAM that is used to
+provide SGX-enabled applications with protected memory, and is otherwise
+inaccessible, i.e. shows up as reserved in /proc/iomem and cannot be
+read/written outside of an SGX enclave.
+
+Although current systems implement EPC by stealing memory from RAM, for all
+intents and purposes the EPC is independent from normal system memory, e.g. must
+be reserved at boot from RAM and cannot be converted between EPC and normal
+memory while the system is running.  The EPC is managed by the SGX subsystem and
+is not accounted by the memory controller.  Note that this is true only for EPC
+memory itself, i.e.  normal memory allocations related to SGX and EPC memory,
+e.g. the backing memory for evicted EPC pages, are accounted, limited and
+protected by the memory controller.
+
+Much like normal system memory, EPC memory can be overcommitted via virtual
+memory techniques and pages can be swapped out of the EPC to their backing store
+(normal system memory allocated via shmem).  The SGX EPC subsystem is analogous
+to the memory subsystem, and it implements limit and protection models for EPC
+memory.
+
+SGX EPC Interface Files
+-----------------------
+
+For a generic description of the Miscellaneous controller interface files,
+please see Documentation/admin-guide/cgroup-v2.rst
+
+All SGX EPC memory amounts are in bytes unless explicitly stated otherwise. If
+a value which is not PAGE_SIZE aligned is written, the actual value used by the
+controller will be rounded down to the closest PAGE_SIZE multiple.
+
+  misc.capacity
+        A read-only flat-keyed file shown only in the root cgroup. The sgx_epc
+        resource will show the total amount of EPC memory available on the
+        platform.
+
+  misc.current
+        A read-only flat-keyed file shown in the non-root cgroups. The sgx_epc
+        resource will show the current active EPC memory usage of the cgroup and
+        its descendants. EPC pages that are swapped out to backing RAM are not
+        included in the current count.
+
+  misc.max
+        A read-write single value file which exists on non-root cgroups. The
+        sgx_epc resource will show the EPC usage hard limit. The default is
+        "max".
+
+        If a cgroup's EPC usage reaches this limit, EPC allocations, e.g., for
+        page fault handling, will be blocked until EPC can be reclaimed from the
+        cgroup. If there are no pages left that are reclaimable within the same
+        group, the kernel returns ENOMEM.
+
+        The EPC pages allocated for a guest VM by the virtual EPC driver are not
+        reclaimable by the host kernel. In case the guest cgroup's limit is
+        reached and no reclaimable pages left in the same cgroup, the virtual
+        EPC driver returns SIGBUS to the user space process to indicate failure
+        on new EPC allocation requests.
+
+        The misc.max limit is non-preemptive. If a user writes a limit lower
+        than the current usage to this file, the cgroup will not preemptively
+        deallocate pages currently in use, and will only start blocking the next
+        allocation and reclaiming EPC at that time.
+
+  misc.events
+        A read-only flat-keyed file which exists on non-root cgroups.
+        A value change in this file generates a file modified event.
+
+          max
+                The number of times the cgroup has triggered a reclaim due to
+                its EPC usage approaching (or exceeding) its max EPC boundary.
+
+Migration
+---------
+
+Once an EPC page is charged to a cgroup (during allocation), it remains charged
+to the original cgroup until the page is released or reclaimed. Migrating a
+process to a different cgroup doesn't move the EPC charges that it incurred
+while in the previous cgroup to its new cgroup.
-- 
2.25.1


