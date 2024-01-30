Return-Path: <cgroups+bounces-1272-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB548418E6
	for <lists+cgroups@lfdr.de>; Tue, 30 Jan 2024 03:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB9C288360
	for <lists+cgroups@lfdr.de>; Tue, 30 Jan 2024 02:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FE55467E;
	Tue, 30 Jan 2024 02:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gpsxD4Nd"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A553738F80;
	Tue, 30 Jan 2024 02:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706580590; cv=none; b=lw6Wsfe7bMAjFAlleYGuVkCFBN60DouKlGJ25Q0SRCGmszIeIC6DhLONyU8t7RuL4h0DAlFkjdoq5yvSPfIZPvOCe6mKlKNAuONWtMhi5FgGC9ucpU7ItGoDNtSclMUdYgvdCHi1K5739QvM6zPVs1z9xWnb9BW+JJWkHXM1494=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706580590; c=relaxed/simple;
	bh=o1nFXrA5FX9ZZTIDA9Xh5KyH840bTq33YyyW8UGP2Gw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=muPAZIZ+lozTC80PUgbLtsQ28hGO48kzEZhoSKLvDewI3utesyjw+mOKYriy8GjpvhajRqKTvtn5S5qLMTf1UQ2t21wdZT0GEGgW00kjWhqcnpZxNp7LEiz94EQXIOXA2K92iGmMDkwvhAW9NrbM/FeRzxhTiXd8Nz7H6Fce9cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gpsxD4Nd; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706580589; x=1738116589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o1nFXrA5FX9ZZTIDA9Xh5KyH840bTq33YyyW8UGP2Gw=;
  b=gpsxD4Ndik710SGw4pueUO/OPcN3wMWTJBkbE05Ph58zfAPQg+Hpmgae
   h6KeHuyXQ1O1gAosVrjnpYIFGJJIWdtu0THRTf3ZpWLn8UELIlvOnyI5j
   ZdnMoVVKJdtfr0FtunwjDxnCSPRRH5vHk7zna3/1Yihoe9oVYzIEEV3RR
   4jakUneVSZn5Eej0sb3LNsKNk4kHiMU1Fn5LfFLDHfaQBNJnrc/OoUTj8
   pbCeSqaRLpe9OJCbC7z+4i/AkYnwZDV2HpOj9Txy47CKvWgOucOHxTG9B
   +goPlNtDUH+BYvwUbHaOCaUC3nkB2qg0zOfk8QuGj2Ayf1Yw2QAWw7CYN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="16531022"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="16531022"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 18:09:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="822042357"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="822042357"
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
Subject: [PATCH v8 13/15] x86/sgx: Turn on per-cgroup EPC reclamation
Date: Mon, 29 Jan 2024 18:09:36 -0800
Message-Id: <20240130020938.10025-14-haitao.huang@linux.intel.com>
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


