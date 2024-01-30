Return-Path: <cgroups+bounces-1271-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D25D48418E5
	for <lists+cgroups@lfdr.de>; Tue, 30 Jan 2024 03:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72B6F1F25E6D
	for <lists+cgroups@lfdr.de>; Tue, 30 Jan 2024 02:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F0553E3B;
	Tue, 30 Jan 2024 02:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dmq+r2dt"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F01238DDF;
	Tue, 30 Jan 2024 02:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706580590; cv=none; b=bzx0kzNiERGP0jX/YNRu7PQL4OfX80c9AecF43s9yrKR5OrLdvSi0jFkBTSqYP8pAqraYe+cpwe3mBz00kE9/jzannvEl8sw0HpQn8OcQy84WFQxefwgGrw+5it/20yb+mgW0CW+JYnk6a20LrsJqTlhXXvErZw0V+AhW4ax9ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706580590; c=relaxed/simple;
	bh=ciLOjkP1Lyv8VF4qBFgqWsBylreTL6rvQA9H9sB86+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V7tajMpHIrNACNkTXNdQoxRhujEWY98vs/K/C61QyklS7GZR2Of155AL9fG/XHvgr2yp5dRKQ1dPXc49x+OU/zkRbV9a4EK48o4i9S0rKKbxRJpkY99BV+zAl11OcCqIlhjXgun3+a1ItzIoCKZ3oS+FBrTBqkrsRnlPOsd0phc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dmq+r2dt; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706580589; x=1738116589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ciLOjkP1Lyv8VF4qBFgqWsBylreTL6rvQA9H9sB86+8=;
  b=Dmq+r2dtdlmtoSY/gCMfrHl0uwOw9d7SrAWwAAdzxWl+cExHcDV0Xnpv
   GGOGTJdYoGatZMTAwm/zYZTLXcUWCpn/WfCCuUoD6h8CTrmGtFKz61VHG
   zal8g5WFvxG3g/xqncDwXkP53oHzEdirWewHcJ/D+7IeFAH4jH9FDpH06
   UaARg4pbxwZe5yoq2vvKw3WriTT9V1b1iyA8nTOIXey+7uORSvTQoqlf7
   41MU1LzW01j6nrTBlWBmaKBMA/ts9M7zpu73REHKtQBcA8XvXNNy6hrgU
   0jrNMd6DT//dnc4zaFS3XixlKqgs3BEN/KPvP+Kup1JDm2b/q47DILXbE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="16531013"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="16531013"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 18:09:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="822042354"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="822042354"
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
Subject: [PATCH v8 12/15] x86/sgx: Expose sgx_epc_cgroup_reclaim_pages() for global reclaimer
Date: Mon, 29 Jan 2024 18:09:35 -0800
Message-Id: <20240130020938.10025-13-haitao.huang@linux.intel.com>
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

When cgroup is enabled, all reclaimable pages will be tracked in cgroup
LRUs. The global reclaimer needs to start reclamation from the root
cgroup. Expose the top level cgroup reclamation function so the global
reclaimer can reuse it.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
---
V8:
- Remove unneeded breaks in function declarations. (Jarkko)

V7:
- Split this out from the big patch, #10 in V6. (Dave, Kai)
---
 arch/x86/kernel/cpu/sgx/epc_cgroup.c | 2 +-
 arch/x86/kernel/cpu/sgx/epc_cgroup.h | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
index 127f515ffccf..e08425b1faa5 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -88,7 +88,7 @@ bool sgx_epc_cgroup_lru_empty(struct misc_cg *root)
  * @indirect:   In ksgxd or EPC cgroup work queue context.
  * Return:	Number of pages reclaimed.
  */
-static unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root, bool indirect)
+unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root, bool indirect)
 {
 	/*
 	 * Attempting to reclaim only a few pages will often fail and is
diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
index d061cd807b45..5b3e8e1b8630 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.h
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
@@ -31,6 +31,11 @@ static inline int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg, bool
 static inline void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup *epc_cg) { }
 
 static inline void sgx_epc_cgroup_init(void) { }
+
+static inline unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root, bool indirect)
+{
+	return 0;
+}
 #else
 struct sgx_epc_cgroup {
 	struct misc_cg *cg;
@@ -69,6 +74,8 @@ static inline void sgx_put_epc_cg(struct sgx_epc_cgroup *epc_cg)
 int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg, bool reclaim);
 void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup *epc_cg);
 bool sgx_epc_cgroup_lru_empty(struct misc_cg *root);
+unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root, bool indirect);
+
 void sgx_epc_cgroup_init(void);
 
 #endif
-- 
2.25.1


