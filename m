Return-Path: <cgroups+bounces-1268-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8788418DF
	for <lists+cgroups@lfdr.de>; Tue, 30 Jan 2024 03:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E999B2381C
	for <lists+cgroups@lfdr.de>; Tue, 30 Jan 2024 02:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F50738DE9;
	Tue, 30 Jan 2024 02:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fMM1xiKc"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DD0381C4;
	Tue, 30 Jan 2024 02:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706580588; cv=none; b=C/m0gcuoM7NNOCMq3at7TIkJIfwPnFh9GAb1mwlZc6C+tBKHnDt72XmFPEu3S7+g1B0GzNIfVgxWBgPBbd4dm6GvsKmKfVBiRAAEAlNs+q3gShQ5wj1OsmuLXCtDGWcpEytFm06+0rqEMyzam+u0SF4j6MA7/x0WTNNp3BCNJUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706580588; c=relaxed/simple;
	bh=u1DYsgZy13ZjtchvNGb7CEOtsk3gCdTnMR1cRDDMGJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ki5TK2enmXFRV0uUYCaUK1kyAFfyiPcqom6H34A5+jZUraszF4SCMUXi6XMd5Mamws6YwU+TF/RvgYicxIr5QNx0x0xEpSiArtakcRHN2mYGAa+GL/FG5I5Jl2lw+6kpLiraoQASJQ8l9LcLjWDgl6ffW9MML1cPObU05ghegd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fMM1xiKc; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706580587; x=1738116587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u1DYsgZy13ZjtchvNGb7CEOtsk3gCdTnMR1cRDDMGJI=;
  b=fMM1xiKc0rqGC7NEn4HZsKv/1i5+vPJp3lYAtcO/gk0AtMtsb3io72TT
   osaU5AaWQm6xl+A9yZqx/mVPHE5xx5W4B+eIsctdgZ8/2WehiZvbn2r77
   N6DOaZ3wbuyX9d+SXlHAa2lmBvOvtwroR0vnu83Tnl6r/IARPv382anE3
   XLGKq27oP3xQByp0y8uUYgRekI4BI4WokuW0NdTUMvj++R1WDicFeMNbG
   I6MKbIsxgYh7bjkQpBFP3ipMty+7rKbT949r7+kFqI9wCJD0IQONIgUCa
   NNdKvSxURISKy4pGCpCYNdmMnWnFITw6FNU+2wEto1GqY0eRJ3yOxnwDq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="16530995"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="16530995"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 18:09:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="822042348"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="822042348"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orsmga001.jf.intel.com with ESMTP; 29 Jan 2024 18:09:40 -0800
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
Subject: [PATCH v8 10/15] x86/sgx: Add EPC reclamation in cgroup try_charge()
Date: Mon, 29 Jan 2024 18:09:33 -0800
Message-Id: <20240130020938.10025-11-haitao.huang@linux.intel.com>
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

From: Kristen Carlson Accardi <kristen@linux.intel.com>

When the EPC usage of a cgroup is near its limit, the cgroup needs to
reclaim pages used in the same cgroup to make room for new allocations.
This is analogous to the behavior that the global reclaimer is triggered
when the global usage is close to total available EPC.

Add a Boolean parameter for sgx_epc_cgroup_try_charge() to indicate
whether synchronous reclaim is allowed or not. And trigger the
synchronous/asynchronous reclamation flow accordingly.

Note at this point, all reclaimable EPC pages are still tracked in the
global LRU and per-cgroup LRUs are empty. So no per-cgroup reclamation
is activated yet.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
---
V7:
- Split this out from the big patch, #10 in V6. (Dave, Kai)
---
 arch/x86/kernel/cpu/sgx/epc_cgroup.c | 26 ++++++++++++++++++++++++--
 arch/x86/kernel/cpu/sgx/epc_cgroup.h |  4 ++--
 arch/x86/kernel/cpu/sgx/main.c       |  2 +-
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
index cbcb7b0de3fe..127f515ffccf 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -176,13 +176,35 @@ static void sgx_epc_cgroup_reclaim_work_func(struct work_struct *work)
 /**
  * sgx_epc_cgroup_try_charge() - try to charge cgroup for a single EPC page
  * @epc_cg:	The EPC cgroup to be charged for the page.
+ * @reclaim:	Whether or not synchronous reclaim is allowed
  * Return:
  * * %0 - If successfully charged.
  * * -errno - for failures.
  */
-int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg)
+int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg, bool reclaim)
 {
-	return misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg, PAGE_SIZE);
+	for (;;) {
+		if (!misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg,
+					PAGE_SIZE))
+			break;
+
+		if (sgx_epc_cgroup_lru_empty(epc_cg->cg))
+			return -ENOMEM;
+
+		if (signal_pending(current))
+			return -ERESTARTSYS;
+
+		if (!reclaim) {
+			queue_work(sgx_epc_cg_wq, &epc_cg->reclaim_work);
+			return -EBUSY;
+		}
+
+		if (!sgx_epc_cgroup_reclaim_pages(epc_cg->cg, false))
+			/* All pages were too young to reclaim, try again a little later */
+			schedule();
+	}
+
+	return 0;
 }
 
 /**
diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
index e3c6a08f0ee8..d061cd807b45 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.h
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
@@ -23,7 +23,7 @@ static inline struct sgx_epc_cgroup *sgx_get_current_epc_cg(void)
 
 static inline void sgx_put_epc_cg(struct sgx_epc_cgroup *epc_cg) { }
 
-static inline int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg)
+static inline int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg, bool reclaim)
 {
 	return 0;
 }
@@ -66,7 +66,7 @@ static inline void sgx_put_epc_cg(struct sgx_epc_cgroup *epc_cg)
 		put_misc_cg(epc_cg->cg);
 }
 
-int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg);
+int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg, bool reclaim);
 void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup *epc_cg);
 bool sgx_epc_cgroup_lru_empty(struct misc_cg *root);
 void sgx_epc_cgroup_init(void);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 51904f191b97..2279ae967707 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -588,7 +588,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 	int ret;
 
 	epc_cg = sgx_get_current_epc_cg();
-	ret = sgx_epc_cgroup_try_charge(epc_cg);
+	ret = sgx_epc_cgroup_try_charge(epc_cg, reclaim);
 	if (ret) {
 		sgx_put_epc_cg(epc_cg);
 		return ERR_PTR(ret);
-- 
2.25.1


