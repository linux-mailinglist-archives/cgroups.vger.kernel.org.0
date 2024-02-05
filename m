Return-Path: <cgroups+bounces-1366-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D7484A872
	for <lists+cgroups@lfdr.de>; Mon,  5 Feb 2024 23:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922A61F2BF6E
	for <lists+cgroups@lfdr.de>; Mon,  5 Feb 2024 22:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD9A14F9D6;
	Mon,  5 Feb 2024 21:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="REXqdlQ3"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE93814AD09;
	Mon,  5 Feb 2024 21:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707167213; cv=none; b=kdnFp+yCAIXHZv+aaEN7ZEDaZwy1EepSGzg/jf6I1ezXy0cxpjQeaROVpJRml14/CVMQFZbYI/X7xYGJeFQBE1rBdNW/isHD8EIC84nLzW0souYo8h5lzDY5el3P68L4M7sq/oNy/5vHnbrYvm8et8rruAF+y53LUN07Q/rkUss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707167213; c=relaxed/simple;
	bh=o1nFXrA5FX9ZZTIDA9Xh5KyH840bTq33YyyW8UGP2Gw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fUfxm1tCf6qdE3M5muPq1LBI0C9kgaoFpuvwjVUxz4lNYyyLiwCBTnshPTYk/OLduE02x4smFnk5o66wlabK8ZLzfVPQZxJGJIFOLXGQn2l7+gFJcLVauj4CSBkfnQlyGM4zPHQSe6p5hvG43UE7DqIAfwBx9sTWkAobtQlVY74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=REXqdlQ3; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707167212; x=1738703212;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o1nFXrA5FX9ZZTIDA9Xh5KyH840bTq33YyyW8UGP2Gw=;
  b=REXqdlQ3x7dMsXCacimJAXVu5Mcq10ZGshQvldcKqVrcK4VAS7DPP15P
   jzq/fWr81XKugxXD4ZP9nMEcFJIjW9HgNi2BaTChO2OSgAs+WgTojrrPO
   JXr3QNcLcmu7+91DOAOMqcTXMetOPdLqQIfHHn39FKVO9q9ocUV1JOccg
   DAvY6PPu0fmlvY/eqqFXapINfJZNoG3Lef+DV6ndl+osCzilaLY1EdpUY
   qn2DkCHk7Cq8R0wud0zOc2TAcRDFuIiY0EO2GRBGsH61xAwHDrInQ0gLS
   dpsT9xCSZaoyI1LnLQ1yD4RfGA3s1i45kdFyLMrQbOgdKN5yaPj1L9/Oq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11960474"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11960474"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 13:06:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="38245651"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orviesa001.jf.intel.com with ESMTP; 05 Feb 2024 13:06:42 -0800
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
Subject: [PATCH v9 13/15] x86/sgx: Turn on per-cgroup EPC reclamation
Date: Mon,  5 Feb 2024 13:06:36 -0800
Message-Id: <20240205210638.157741-14-haitao.huang@linux.intel.com>
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

From: Kristen Carlson Accardi <kristen@linux.intel.com>

Previous patches have implemented all infrastructure needed for
per-cgroup EPC page tracking and reclaiming. But all reclaimable EPC
pages are still tracked in the global LRU as sgx_lru_list() returns hard
coded reference to the global LRU.

Change sgx_lru_list() to return the LRU of the cgroup in which the given
EPC page is allocated.

This makes all EPC pages tracked in per-cgroup LRUs and the global
reclaimer (ksgxd) will not be able to reclaim any pages from the global
LRU. However, in cases of over-committing, i.e., sum of cgroup limits
greater than the total capacity, cgroups may never reclaim but the total
usage can still be near the capacity. Therefore global reclamation is
still needed in those cases and it should reclaim from the root cgroup.

Modify sgx_reclaim_pages_global(), to reclaim from the root EPC cgroup
when cgroup is enabled, otherwise from the global LRU.

Similarly, modify sgx_can_reclaim(), to check emptiness of LRUs of all
cgroups when EPC cgroup is enabled, otherwise only check the global LRU.

With these changes, the global reclamation and per-cgroup reclamation
both work properly with all pages tracked in per-cgroup LRUs.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
---
V7:
- Split this out from the big patch, #10 in V6. (Dave, Kai)
---
 arch/x86/kernel/cpu/sgx/main.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 6b0c26cac621..d4265a390ba9 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -34,12 +34,23 @@ static struct sgx_epc_lru_list sgx_global_lru;
 
 static inline struct sgx_epc_lru_list *sgx_lru_list(struct sgx_epc_page *epc_page)
 {
+#ifdef CONFIG_CGROUP_SGX_EPC
+	if (epc_page->epc_cg)
+		return &epc_page->epc_cg->lru;
+
+	/* This should not happen if kernel is configured correctly */
+	WARN_ON_ONCE(1);
+#endif
 	return &sgx_global_lru;
 }
 
 static inline bool sgx_can_reclaim(void)
 {
+#ifdef CONFIG_CGROUP_SGX_EPC
+	return !sgx_epc_cgroup_lru_empty(misc_cg_root());
+#else
 	return !list_empty(&sgx_global_lru.reclaimable);
+#endif
 }
 
 static atomic_long_t sgx_nr_free_pages = ATOMIC_LONG_INIT(0);
@@ -410,7 +421,10 @@ static void sgx_reclaim_pages_global(bool indirect)
 {
 	unsigned int nr_to_scan = SGX_NR_TO_SCAN;
 
-	sgx_reclaim_pages(&sgx_global_lru, &nr_to_scan, indirect);
+	if (IS_ENABLED(CONFIG_CGROUP_SGX_EPC))
+		sgx_epc_cgroup_reclaim_pages(misc_cg_root(), indirect);
+	else
+		sgx_reclaim_pages(&sgx_global_lru, &nr_to_scan, indirect);
 }
 
 /*
-- 
2.25.1


