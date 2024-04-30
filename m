Return-Path: <cgroups+bounces-2735-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 937428B80DC
	for <lists+cgroups@lfdr.de>; Tue, 30 Apr 2024 21:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D701C24830
	for <lists+cgroups@lfdr.de>; Tue, 30 Apr 2024 19:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9F01C65FF;
	Tue, 30 Apr 2024 19:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b4XN2KnJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF66F1C2311;
	Tue, 30 Apr 2024 19:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714506680; cv=none; b=ivpkiY3WVYTGLPvX1TPqmJxDXGuShUxUNREpLAEVRLEtH0uUgdrg+7sNG3BOIqYMEmUM5zbPUXAU1vtFxwte6bkBrkkJSsKvztkSUrayvmwfp5BDP2mlUbGtncBV0bw1DqO/GAlweaMPhCqU3T55/GoHBfsKq7sJ37ThfEdZ2iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714506680; c=relaxed/simple;
	bh=vA6ZnbvvIxoz6BaBtRRnsHl7+KQ4VZ90cLxN0JYW3to=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tJede2GcpqCogPTsF1dWNrNRUazcZPRkPr6TW/QDvBID89p6zBKN3B1kdjcF0x3Api+lnW9BaUFqv5PoEd5hHB5RGaOhy4wlBAmczT5PJWOLQirNw341039SVR5wOuRz+i6yjXmdIWWcSgr4MeH5E+WUbnjVZSnK0uZCfwCszlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b4XN2KnJ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714506679; x=1746042679;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vA6ZnbvvIxoz6BaBtRRnsHl7+KQ4VZ90cLxN0JYW3to=;
  b=b4XN2KnJkHv3TzOxtCO/s8FA5MJg1WsUACXFiKCVF2rdVv6lDf57y6RW
   r5ukxc93mejrjhNxWmx+Q3Zyjw2uVqo76zW9vpLRT/fiMNlUj9p06uOSP
   bFQHazgetWTeW7cHH5MkR8sd38s1S7XirCjvnIhkzMf72ZatllwNnvq4T
   r2ZK8TqG2FXx2FhCEUyevFmrezhLbGpkzMJXLWFhTKLhwjCq/mf2xVsLL
   1x1DaAiD4bVQDm7KwGS5ep1d3jMGbyzxpZZ//QFaV8sS3d/XD9TlWUXt+
   62zvD5GmGJt8zWgfuFinezjQHuas6ZcOfHJqANbFr/pa3fGrDDuQxI1N5
   g==;
X-CSE-ConnectionGUID: twSQKtAkTXKk9cKBZkw6lQ==
X-CSE-MsgGUID: ciGXz50rSg6Hr5/LRdBQFw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10355653"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="10355653"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 12:51:11 -0700
X-CSE-ConnectionGUID: tJ69Im9zSv2PS3VmVAkA0g==
X-CSE-MsgGUID: mDXn3KcLRe2j9ulH+ZKQog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="31280329"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orviesa003.jf.intel.com with ESMTP; 30 Apr 2024 12:51:10 -0700
From: Haitao Huang <haitao.huang@linux.intel.com>
To: jarkko@kernel.org,
	dave.hansen@linux.intel.com,
	kai.huang@intel.com,
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
Subject: [PATCH v13 11/14] x86/sgx: Abstract check for global reclaimable pages
Date: Tue, 30 Apr 2024 12:51:05 -0700
Message-Id: <20240430195108.5676-12-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240430195108.5676-1-haitao.huang@linux.intel.com>
References: <20240430195108.5676-1-haitao.huang@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristen Carlson Accardi <kristen@linux.intel.com>

For the global reclaimer to determine if any page available for
reclamation at the global level, it currently only checks for emptiness
of the global LRU. That will be inadequate when pages are tracked in
multiple LRUs, one per cgroup. For this purpose, create a new helper,
sgx_can_reclaim_global(), to abstract this check. Currently it only
checks the global LRU, later will check emptiness of LRUs of all cgroups
when per-cgroup tracking is turned on.

Replace all the checks for emptiness of the global LRU,
list_empty(&sgx_global_lru.reclaimable), with calls to
sgx_can_reclaim_global().

Rename sgx_should_reclaim() to sgx_should_reclaim_global() as it is used
to check if a global reclamation should be performed.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
---
V13:
- Rename sgx_can_reclaim() to sgx_can_reclaim_global() and
sgx_should_reclaim() to sgx_should_reclaim_global(). (Kai)

V10:
- Add comments for the new function. (Jarkko)

V7:
- Split this out from the big patch, #10 in V6. (Dave, Kai)
---
 arch/x86/kernel/cpu/sgx/main.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index f1bd15620b83..92bd3151a589 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -36,6 +36,14 @@ static inline struct sgx_epc_lru_list *sgx_epc_page_lru(struct sgx_epc_page *epc
 	return &sgx_global_lru;
 }
 
+/*
+ * Check if there is any reclaimable page at global level.
+ */
+static inline bool sgx_can_reclaim_global(void)
+{
+	return !list_empty(&sgx_global_lru.reclaimable);
+}
+
 static atomic_long_t sgx_nr_free_pages = ATOMIC_LONG_INIT(0);
 
 /* Nodes with one or more EPC sections. */
@@ -387,10 +395,10 @@ unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru, struct mm_struct *c
 	return cnt;
 }
 
-static bool sgx_should_reclaim(unsigned long watermark)
+static bool sgx_should_reclaim_global(unsigned long watermark)
 {
 	return atomic_long_read(&sgx_nr_free_pages) < watermark &&
-	       !list_empty(&sgx_global_lru.reclaimable);
+		sgx_can_reclaim_global();
 }
 
 static void sgx_reclaim_pages_global(struct mm_struct *charge_mm)
@@ -405,7 +413,7 @@ static void sgx_reclaim_pages_global(struct mm_struct *charge_mm)
  */
 void sgx_reclaim_direct(void)
 {
-	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
+	if (sgx_should_reclaim_global(SGX_NR_LOW_PAGES))
 		sgx_reclaim_pages_global(current->mm);
 }
 
@@ -426,9 +434,9 @@ static int ksgxd(void *p)
 
 		wait_event_freezable(ksgxd_waitq,
 				     kthread_should_stop() ||
-				     sgx_should_reclaim(SGX_NR_HIGH_PAGES));
+				     sgx_should_reclaim_global(SGX_NR_HIGH_PAGES));
 
-		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
+		if (sgx_should_reclaim_global(SGX_NR_HIGH_PAGES))
 			/* Indirect reclaim, no mm to charge, so NULL: */
 			sgx_reclaim_pages_global(NULL);
 
@@ -592,7 +600,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
 			break;
 		}
 
-		if (list_empty(&sgx_global_lru.reclaimable)) {
+		if (!sgx_can_reclaim_global()) {
 			page = ERR_PTR(-ENOMEM);
 			break;
 		}
@@ -620,7 +628,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
 		sgx_put_cg(sgx_cg);
 	}
 
-	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
+	if (sgx_should_reclaim_global(SGX_NR_LOW_PAGES))
 		wake_up(&ksgxd_waitq);
 
 	return page;
-- 
2.25.1


