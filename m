Return-Path: <cgroups+bounces-1364-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB70184A86E
	for <lists+cgroups@lfdr.de>; Mon,  5 Feb 2024 23:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B272B1C28F96
	for <lists+cgroups@lfdr.de>; Mon,  5 Feb 2024 22:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE3914D442;
	Mon,  5 Feb 2024 21:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RE/D+Thq"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BBC14A08D;
	Mon,  5 Feb 2024 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707167212; cv=none; b=OLYKlLew5QYLnJ1PSoKYIqBLO6UUvbbuAy+wHrlmRgxhGEE3FT3+lEvNhUgk3yuDoGhrOvEnQph19To9q+lYVZR6OgC1LLzBYEVVnfK7ydK/eT9njbw3a0Af/cUtd1aM/z5gYQds45whzOJ8bQryr5l2x0HBarZtcK8tgTRE2hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707167212; c=relaxed/simple;
	bh=9w5lQ2pOZdanN4uPSlw3FqAR9K1n/EpTv9COUE47BCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bSEu4SDDLV8lVgSZwa4Y/VS4hRMQkipsPnGm0E20AgFoe4sv+yNcqxHfTD2ig0L5oUSqzpLbTbRIB5+PhN5zMeYgItJT4fxqF5gj+vnOu5RPzvp4jMRRVMV5D/0hrGBhgvO7Nl4Bl/Si91vz44t1PS+Tssdgt/paOYkHC4eRR5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RE/D+Thq; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707167211; x=1738703211;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9w5lQ2pOZdanN4uPSlw3FqAR9K1n/EpTv9COUE47BCo=;
  b=RE/D+ThqsP7PQVF4DjgR7PuKRIC27Nnd9LfbNMA6X8gu88J/FlZ8mKuG
   9QEPyR/zpe4uxcm27zUtcaKA5sUhrfx6BIDiktAR0l5fxnLgnhhN+VZQI
   9HAYiV+53oe+IsVhpgQTcglv2RAl42kRBh8LXAeWsor8nk8xdk4hqGe7V
   9wGKu4DxtwJ/IhIRWuS3zWhg9qYoSgeVZjKEGRBRF21fNJ13Of7m4I+XK
   oYCPB+8VDNtU37v9uFm+LoFdcstIorm866QLs3QdOp+KmAtyDsWzWb8kZ
   Mmjf8zgzmOsgZuuBkl/iRg9YMRaAMRuZ7isMhK0nJeK+SXl1EWsUml8VZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11960477"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11960477"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 13:06:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="38245654"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orviesa001.jf.intel.com with ESMTP; 05 Feb 2024 13:06:43 -0800
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
Subject: [PATCH v9 14/15] Docs/x86/sgx: Add description for cgroup support
Date: Mon,  5 Feb 2024 13:06:37 -0800
Message-Id: <20240205210638.157741-15-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240205210638.157741-1-haitao.huang@linux.intel.com>
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
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


