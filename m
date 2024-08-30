Return-Path: <cgroups+bounces-4634-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BFE966727
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 18:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94360B22FD1
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 16:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F2F1BC9F4;
	Fri, 30 Aug 2024 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="brjERrd4"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04DF1BB69D;
	Fri, 30 Aug 2024 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725036099; cv=none; b=sqcEFiYpcgXRqBgw4wGu+beJcP80Zku/hWZorJnieqZdR900XHKyxhJ9VdR+h+sW5dvnxNcIbnhDQ63ucy8yiN8L9t4+A5t0USCevrFqdg2Ry9w5f9h69AvnNjQxrkgY8ZbxKZ8xMJrwlRnrpabgNaQHgUrsPGzGLC91jAgjWKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725036099; c=relaxed/simple;
	bh=utO0vDU8+xd4y+Lphxyt7zUfR4oNivb7eGaN4/0AoIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5150OsoiBxRKMQ0i2NaKwdGeRlRU+ldrQPDMsSCupu3440XjVlr8KM/5es2E4ClKKh2/XDMAXNBOCVMHPOvCBgfxuVcEBuXSkHR5vasAxoTMVgO22NUtMHRU3ugQVhk9DqxJifsT9Ia/Qvmc1hHocyHOpZgqk4cI9VFIj5fcQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=brjERrd4; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725036097; x=1756572097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=utO0vDU8+xd4y+Lphxyt7zUfR4oNivb7eGaN4/0AoIk=;
  b=brjERrd47rA1m4fzG5tYe4Yj4CFNbomPyoY6RyE4Qmn+ovvK+aGoZA3C
   VJPL955dDZLVlQXxRFXcDQmTOYOEStv0MdXNaE+6e3+cKXAONWcfmwplu
   HZEJ6MVR2cdgA5f2AuLMjlzUql57Xt9y0Ysr7xxAXXTVgGX/nq7GeLFaB
   3xzjCkcVLQtZ3GklHV2yTGmZR+INfO7lcUim1kgWdrkyoJR5NzpU/LQmh
   BJZZ0VCviM8noJk5/8xJMO4kdGIJv9nnCC7d17WQ0D8HLVtCMwgcyUQDi
   NejK6euExhRNfseuSwt2uwJKJgJuifHs2RneQZ2C1peYzi1lcna6SUM81
   g==;
X-CSE-ConnectionGUID: zIgJiMt/TvWwB8Q0MQFZsg==
X-CSE-MsgGUID: s2msaEdITxO9MmIVSuEDOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="34300011"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="34300011"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:40:52 -0700
X-CSE-ConnectionGUID: uGSIMSGDTCyx8c2aIlHQkw==
X-CSE-MsgGUID: 8gEMLy4VRVqCGovAwtZBoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="101440488"
Received: from b4969164b36c.jf.intel.com ([10.165.59.5])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:40:52 -0700
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
Subject: [PATCH v17 12/16] x86/sgx: Implement direct reclamation for cgroups
Date: Fri, 30 Aug 2024 09:40:33 -0700
Message-ID: <20240830164038.39343-13-haitao.huang@linux.intel.com>
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

sgx_reclaim_direct() was introduced to preemptively reclaim some pages
as the best effort to avoid on-demand reclamation that can stall forward
progress in some situations, e.g., allocating pages to load previously
reclaimed page to perform EDMM operations on [1].

Currently when the global usage is close to the capacity,
sgx_reclaim_direct() makes one invocation to sgx_reclaim_pages_global()
but does not guarantee there are free pages available for later
allocations to succeed. In other words, the only goal here is to reduce
the chance of on-demand reclamation at allocation time. In cases of
allocation failure, the caller, the EDMM ioctl()'s, would return -EAGAIN
to user space and let the user space to decide whether to retry or not.

With EPC cgroups enabled, usage of a cgroup can also reach its limit
(usually much lower than capacity) and trigger per-cgroup reclamation.
Implement a similar strategy to reduce the chance of on-demand
per-cgroup reclamation for this use case.

Create a wrapper, sgx_cgroup_reclaim_direct(), to perform a preemptive
reclamation at cgroup level, and have sgx_reclaim_direct() call it when
EPC cgroup is enabled.

[1] https://lore.kernel.org/all/a0d8f037c4a075d56bf79f432438412985f7ff7a.1652137848.git.reinette.chatre@intel.com/T/#u

Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
V17:
- Improve comments and capitalization. (Kai)
---
 arch/x86/kernel/cpu/sgx/epc_cgroup.c | 15 +++++++++++++++
 arch/x86/kernel/cpu/sgx/epc_cgroup.h |  3 +++
 arch/x86/kernel/cpu/sgx/main.c       |  4 ++++
 3 files changed, 22 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
index 4faff943ce15..7394f78dec49 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -240,6 +240,21 @@ static bool sgx_cgroup_should_reclaim(struct sgx_cgroup *sgx_cg)
 	return (cur >= max);
 }
 
+/**
+ * sgx_cgroup_reclaim_direct() - Preemptive reclamation.
+ *
+ * Scan and attempt to reclaim %SGX_NR_TO_SCAN as best effort to make later
+ * EPC allocation quicker.
+ */
+void sgx_cgroup_reclaim_direct(void)
+{
+	struct sgx_cgroup *sgx_cg = sgx_get_current_cg();
+
+	if (sgx_cgroup_should_reclaim(sgx_cg))
+		sgx_cgroup_reclaim_pages(sgx_cg, current->mm, SGX_NR_TO_SCAN);
+	sgx_put_cg(sgx_cg);
+}
+
 /*
  * Asynchronous work flow to reclaim pages from the cgroup when the cgroup is
  * at/near its maximum capacity.
diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
index 2285dbfc9462..a530c9611332 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.h
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
@@ -35,6 +35,8 @@ static inline int __init sgx_cgroup_wq_init(void)
 
 static inline void __init sgx_cgroup_wq_deinit(void) { }
 
+static inline void sgx_cgroup_reclaim_direct(void) { }
+
 #else /* CONFIG_CGROUP_MISC */
 
 struct sgx_cgroup {
@@ -86,6 +88,7 @@ static inline void sgx_put_cg(struct sgx_cgroup *sgx_cg)
 
 int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim reclaim);
 void sgx_cgroup_uncharge(struct sgx_cgroup *sgx_cg);
+void sgx_cgroup_reclaim_direct(void);
 void __init sgx_cgroup_init(void);
 int __init sgx_cgroup_wq_init(void);
 void __init sgx_cgroup_wq_deinit(void);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index b47d627bd370..6f293115b75e 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -414,6 +414,10 @@ static void sgx_reclaim_pages_global(struct mm_struct *charge_mm)
  */
 void sgx_reclaim_direct(void)
 {
+	/* Reduce chance of per-cgroup reclamation for later allocation */
+	sgx_cgroup_reclaim_direct();
+
+	/* Reduce chance of the global reclamation for later allocation */
 	if (sgx_should_reclaim_global(SGX_NR_LOW_PAGES))
 		sgx_reclaim_pages_global(current->mm);
 }
-- 
2.43.0


