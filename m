Return-Path: <cgroups+bounces-4396-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C399695927B
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 03:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7D731C2284D
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 01:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B1E15381C;
	Wed, 21 Aug 2024 01:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CCU1rprO"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5811314E2C1;
	Wed, 21 Aug 2024 01:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724205271; cv=none; b=rjeDSFPwigXVRkQbBSdwJaj0h71sfCZ9nQsM80XGEtJu2USI0FSbDqu03g+2VcBU+/iiGTz2wf/4IZuUqKks1R79cqIcmUClCwYovBjmajs/E0SbujjxDyRH3Sx7cN92J9x8hV3RvhwOtRxw3nreLB23lSh2taOeBSpkQGfd0C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724205271; c=relaxed/simple;
	bh=1DVv28NUEVWH46aO+nNBAbHHesMKTDiMkJ2YXkyguPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRwYo9OuFZkDzt7Z2MKgtEwDpShPmRyyWQy61ZdF8Nu4wP5cBV123WZWETrzoFIY2L0BHWWkWkgaXBeGwl8d5gkh3TmeZucJ8omeoldV6TLyXUhQimWxGxe31BFxqF0KtVv1DkXHgiecpKvNbOzJUAkYp58A+YHPpqmZp6BJ8LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CCU1rprO; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724205269; x=1755741269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1DVv28NUEVWH46aO+nNBAbHHesMKTDiMkJ2YXkyguPQ=;
  b=CCU1rprO/RaKBcCOt9qPKiDbVuByiuOPzdPBW2MDVDShmXgis95o8Q6t
   ymwmr6oZ9e7WYSOrTDdwlWiT4eEvJPP0n5OzEVzUDbxrN7vhFHtK/8ZLH
   65QEioY2zXhtfL8CrZDXwmY6hdmHywKOTeU7EbCiJAoTbLMuRHpuVOHi1
   tTmmpGtIB3q/W3rJhAhJ7wLj79rt5tHFe0kbYGYJ+W2QAo0II7dDw60I6
   jUX6wwmqUoU5jaOeBN0KnTk/TYbfVzEotKTCp6eDnHamRmKtK/l0HHBgi
   lYnLpa0ZZOo62ZvgrwSdJFo6CWnX6nJimHJVWDM9Hk7szLUTf62OmFGDR
   w==;
X-CSE-ConnectionGUID: q49ZwWHMT22P8a5DOgzNCw==
X-CSE-MsgGUID: En59S7quQS6KYKb+ZSXyzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33107957"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="33107957"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 18:54:22 -0700
X-CSE-ConnectionGUID: synvdlMUQACv3J+80pycRQ==
X-CSE-MsgGUID: wuhT43GgR7u+T6QSrPb6aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="61078619"
Received: from b4969164b36c.jf.intel.com ([10.165.59.5])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 18:54:21 -0700
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
Subject: [PATCH v16 13/16] x86/sgx: implement direct reclamation for cgroups
Date: Tue, 20 Aug 2024 18:54:01 -0700
Message-ID: <20240821015404.6038-14-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240821015404.6038-1-haitao.huang@linux.intel.com>
References: <20240821015404.6038-1-haitao.huang@linux.intel.com>
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
---
 arch/x86/kernel/cpu/sgx/epc_cgroup.c | 15 +++++++++++++++
 arch/x86/kernel/cpu/sgx/epc_cgroup.h |  3 +++
 arch/x86/kernel/cpu/sgx/main.c       |  4 ++++
 3 files changed, 22 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
index 23a61689e0d9..b7d60b2d878d 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -252,6 +252,21 @@ void sgx_cgroup_reclaim_pages_global(struct mm_struct *charge_mm)
 	sgx_cgroup_reclaim_pages(&sgx_cg_root, charge_mm, SGX_NR_TO_SCAN);
 }
 
+/**
+ * sgx_cgroup_reclaim_direct() - Preemptive reclamation.
+ *
+ * Scan and attempt to reclaim %SGX_NR_TO_SCAN as best effort to allow caller
+ * make quick progress.
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
index c0390111e28c..cf2b946d993e 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.h
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
@@ -38,6 +38,8 @@ static inline void __init sgx_cgroup_register(void) { }
 
 static inline void sgx_cgroup_reclaim_pages_global(struct mm_struct *charge_mm) { }
 
+static inline void sgx_cgroup_reclaim_direct(void) { }
+
 #else /* CONFIG_CGROUP_MISC */
 
 struct sgx_cgroup {
@@ -90,6 +92,7 @@ static inline void sgx_put_cg(struct sgx_cgroup *sgx_cg)
 int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim reclaim);
 void sgx_cgroup_uncharge(struct sgx_cgroup *sgx_cg);
 void sgx_cgroup_reclaim_pages_global(struct mm_struct *charge_mm);
+void sgx_cgroup_reclaim_direct(void);
 int __init sgx_cgroup_init(void);
 void __init sgx_cgroup_register(void);
 void __init sgx_cgroup_deinit(void);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index d00cb012838b..9a8f91ebd21b 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -428,6 +428,10 @@ static void sgx_reclaim_pages_global(struct mm_struct *charge_mm)
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


