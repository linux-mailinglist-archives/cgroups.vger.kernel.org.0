Return-Path: <cgroups+bounces-1198-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5408836E7D
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 18:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED911F2B73F
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 17:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBD160255;
	Mon, 22 Jan 2024 17:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UX2l+VDE"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C87D5FDD7;
	Mon, 22 Jan 2024 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944060; cv=none; b=H3qig9JiXCCYo/YbdPiX3EmNTuNJY66dCR2oT0szHs4WXZcqOfrD+LKO4kwSeVONYUTv9Vly6pKrLzQhULMn5DrUWCd9Mf12W3fdVu4C2DmgxLqNZb11vZ+1KFKM9GGymmBhPOMEBe5blMQdDVGUhjM5sPtLlgkE+1PjzqrdozM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944060; c=relaxed/simple;
	bh=UwXSyKYQhTkJaKoBRcjDv1ewEhvUJU2FAtNetpqHEC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X/EGcGdHHNq15vU2xDdxhClodDVq7nfT0Q4zNO+V6sh1fkvH4w+4yG3hCXbNvJkYml7oEn5M8815zOvUpjWWNO52eCvigGlXJF/vcbxlDW2avZBtKHZwqJjDqnyUHwO2FhtHaD7B+WHNfVdsGfDHvSk3nmoaMLGCeCqpifRtCOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UX2l+VDE; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705944059; x=1737480059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UwXSyKYQhTkJaKoBRcjDv1ewEhvUJU2FAtNetpqHEC0=;
  b=UX2l+VDEP+oVzQhtQJ5pkiTLvhyAUnYH9aX4XIdb4Jv4FaXdDx7UX4p9
   ghMDkRY1ZSmbZjO0gdQ4gCWs0KwVgLLgFMW47vsSi37+ZUQ1f95I3uqtI
   bNU66oPge5CArk/QcHIs8Amf+NNocKcSLry7vQ1Dn6BGj8kCyoNnD3IfP
   TlI2int6Jp1dkRjY2bb/j302yZFNo//I3+JM1zIuOOyuv52GVmGxAtN3c
   xdiQOPK0A58bidGBredlDQrqyouLImBdBVCbPOUESQHniIo6aaad+SphK
   7lPXtCgFAtbH/MrHbr1BXjMd65udfijQE32Gbl3aq9WlRKozawmPbPVDH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="1150227"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1150227"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 09:20:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1262894"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orviesa005.jf.intel.com with ESMTP; 22 Jan 2024 09:20:50 -0800
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
	yangjie@microsoft.com
Subject: [PATCH v7 13/15] x86/sgx: Turn on per-cgroup EPC reclamation
Date: Mon, 22 Jan 2024 09:20:46 -0800
Message-Id: <20240122172048.11953-14-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240122172048.11953-1-haitao.huang@linux.intel.com>
References: <20240122172048.11953-1-haitao.huang@linux.intel.com>
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
index 7b13bcf3e75d..15bf2ca5e67a 100644
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
@@ -407,7 +418,10 @@ static void sgx_reclaim_pages_global(bool indirect)
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


