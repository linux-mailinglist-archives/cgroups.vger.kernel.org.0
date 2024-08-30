Return-Path: <cgroups+bounces-4642-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A27966739
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 18:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBC041F257B0
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 16:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05B81BF7F6;
	Fri, 30 Aug 2024 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="akuSZ1rU"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236001BE86F;
	Fri, 30 Aug 2024 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725036107; cv=none; b=t3aiZCfiiIRXMm1RpILeIPX7a7otb2r4ddjClLIxCgh5sy/n8xTQZcqHO57K2oR86JQrdxFNiPIMTKp+PCAw2NEBqrzUWEe+BDUp+FfKtZLDVl8gAU1KeZimlUDQyV/IZjFUqP2Y/K603v7VVJcv9Im4zXvG0aG5/+yvBbrc+vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725036107; c=relaxed/simple;
	bh=1yv03DejpjIhtoLqLThgUtevm5kwrLeq6sL2gn4HWZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qk8wb01H5D5g6GnOkWPWJiw+lm2aNdIuR4S62UAsHBthR2HCfWdJqVeLM7eA1Fh16zqzWBv1OtXG7ln6uEthwpki9tesRrkRJp7KDk9qWiyYPNQTvwxrhbUpvwvuLsms0g4Z16GwdmQaEgQKWKpW0hLvUNoxK0Z5t93oWWTC4jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=akuSZ1rU; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725036105; x=1756572105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1yv03DejpjIhtoLqLThgUtevm5kwrLeq6sL2gn4HWZE=;
  b=akuSZ1rU88mg76s5NkB47/2lHriyREmCqBdELWd+KNXjvdfhYAbyOgnL
   7dEr9UNRm/Q6zpOSrem34fLSxM+K5yc6gV1D+Xgfx7l5Di7Od22M5A9Ln
   HCbXp7SGWFneHnToONc4nbwD3rdytOD3dVX0ielCbKlN6JXjaSfpOWwx3
   dvQdaZR3k2NvWcVLaLgqSsi6SeiMQXDskgHHfF0eTvvDkKOf5A9NEmduW
   106HIKoGalIgGZiAhk8xVhmi58QCMNqkqXMnZOrchcKyxbdEJkkHdMUrD
   3Nk8P5W56AFYVmJL+/aNcxyCeKnO1XFbAkmdbxJ3LN+V+V3pmCO4L/Wlr
   w==;
X-CSE-ConnectionGUID: FLXBmN/wR9OGKaWZLOUYjw==
X-CSE-MsgGUID: WzEFAseOTuSR4boLiR7DRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="34300083"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="34300083"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:40:53 -0700
X-CSE-ConnectionGUID: bIs4DxTyTRKm72XcuZt/qA==
X-CSE-MsgGUID: 6mqIKI+hQN6R5h4dIbKN1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="101440497"
Received: from b4969164b36c.jf.intel.com ([10.165.59.5])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:40:53 -0700
From: Haitao Huang <haitao.huang@linux.intel.com>
To: jarkko@kernel.org,
	dave.hansen@linux.intel.com,
	kai.huang@intel.com,
	tj@kernel.org,
	mkoutny@suse.com,
	chenridong@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-sgx@vger.kernel.org,
	x86@kernel.org,
	cgroups@vger.kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	sohil.mehta@intel.com,
	tim.c.chen@linux.intel.com
Cc: zhiquan1.li@intel.com,
	kristen@linux.intel.com,
	seanjc@google.com,
	zhanb@microsoft.com,
	anakrish@microsoft.com,
	mikko.ylinen@linux.intel.com,
	yangjie@microsoft.com,
	chrisyan@microsoft.com
Subject: [PATCH v17 15/16] Docs/x86/sgx: Add description for cgroup support
Date: Fri, 30 Aug 2024 09:40:36 -0700
Message-ID: <20240830164038.39343-16-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830164038.39343-1-haitao.huang@linux.intel.com>
References: <20240830164038.39343-1-haitao.huang@linux.intel.com>
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
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Kai Huang <kai.huang@intel.com>
Tested-by: Mikko Ylinen <mikko.ylinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
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
2.43.0


