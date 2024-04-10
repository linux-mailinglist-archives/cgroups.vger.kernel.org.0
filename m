Return-Path: <cgroups+bounces-2429-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472F089FFC8
	for <lists+cgroups@lfdr.de>; Wed, 10 Apr 2024 20:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0364428B76F
	for <lists+cgroups@lfdr.de>; Wed, 10 Apr 2024 18:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260531836F5;
	Wed, 10 Apr 2024 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JU2tDuFS"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54747181D0B;
	Wed, 10 Apr 2024 18:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712773569; cv=none; b=t98cTzTs3K0u90srcjtBVu6Unsu5ictA01LpI3S2VwkhrgkQ89n1Do2FEeY2R31JX2KYYrHUcTQBwtms+7vONtup6zGG7TN1rkguRdWEkqv6q/uDGXgDyS7Jnb1dbc+pIKTvL+LQH3VxwvL/nfvdC0wGiwEhC5MolvGWMsjx3k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712773569; c=relaxed/simple;
	bh=Eq5476XrUY9IrNCJHZslLkKEXvCBNZbbjmxya8uo+vs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=siw4BNsVtfRVdI1piMt3/73ZgC5QLzpLE/Vz8oHEiUHXbs8Sf5I8TU3g1Mm/MoxRYnp4r5WD83y4QBWPFDHKpCOtZbXfO1GRJFNG3Jf0Gz8gPQEobugehZeKUgmhZ7/vuJoM6OAcXO3ZuRBNdcnMWqUyqS+mdUo+mHisEyVdYgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JU2tDuFS; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712773569; x=1744309569;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Eq5476XrUY9IrNCJHZslLkKEXvCBNZbbjmxya8uo+vs=;
  b=JU2tDuFS++Qh+rIGlkWRpI9kUSsuq4bEWu6yFVRlNiO5M3FHh9LfX+yg
   kvN1UBqTS2St2j4JuE8rUAwLC0iFtS18zc1mS4inhpsaXnzNui4dRRyKw
   2zXgvQ643hcte7QgH1N+XJ0QSZrZuUCPSnT1jc8/SIPzQZsALMGk07zWg
   kOyh/jGbZZdM7spY7vIygkVzHELfwg2a2mGj/0c+AKvQpaA9DriG+bAxP
   hz/GGZMwl9K8H3UgJOphHfZUFG+nmH5nhgZJWJdbAstqO2Hugcjn75vj3
   KKrQhaQr0jLOWyHiTxXQu/YwzuaGde9hL2HM7y13yRNCDZgpzaf/GflSD
   w==;
X-CSE-ConnectionGUID: YbUEM6KGQLuG1/bq4S3GHg==
X-CSE-MsgGUID: I/nmWxJaTZeGkaMx0Yz3wg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19583732"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="19583732"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 11:26:01 -0700
X-CSE-ConnectionGUID: gWs9/pzDT/GUsO+ttIfddQ==
X-CSE-MsgGUID: BQDWf4hLSLul5z75xzErvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="21232447"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orviesa008.jf.intel.com with ESMTP; 10 Apr 2024 11:26:00 -0700
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
Subject: [PATCH v11 11/14] x86/sgx: Abstract check for global reclaimable pages
Date: Wed, 10 Apr 2024 11:25:55 -0700
Message-Id: <20240410182558.41467-12-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240410182558.41467-1-haitao.huang@linux.intel.com>
References: <20240410182558.41467-1-haitao.huang@linux.intel.com>
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
sgx_can_reclaim(), to abstract this check. Currently it only checks the
global LRU, later will check emptiness of LRUs of all cgroups when
per-cgroup tracking is turned on. Replace all the checks of the global
LRU, list_empty(&sgx_global_lru.reclaimable), with calls to
sgx_can_reclaim().

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
---
V10:
- Add comments for the new function. (Jarkko)

V7:
- Split this out from the big patch, #10 in V6. (Dave, Kai)
---
 arch/x86/kernel/cpu/sgx/main.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 7f5428571c6a..11edbdb06782 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -37,6 +37,14 @@ static inline struct sgx_epc_lru_list *sgx_lru_list(struct sgx_epc_page *epc_pag
 	return &sgx_global_lru;
 }
 
+/*
+ * Check if there is any reclaimable page at global level.
+ */
+static inline bool sgx_can_reclaim(void)
+{
+	return !list_empty(&sgx_global_lru.reclaimable);
+}
+
 static atomic_long_t sgx_nr_free_pages = ATOMIC_LONG_INIT(0);
 
 /* Nodes with one or more EPC sections. */
@@ -391,7 +399,7 @@ unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru, struct mm_struct *c
 static bool sgx_should_reclaim(unsigned long watermark)
 {
 	return atomic_long_read(&sgx_nr_free_pages) < watermark &&
-	       !list_empty(&sgx_global_lru.reclaimable);
+		sgx_can_reclaim();
 }
 
 static void sgx_reclaim_pages_global(struct mm_struct *charge_mm)
@@ -593,7 +601,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
 			break;
 		}
 
-		if (list_empty(&sgx_global_lru.reclaimable)) {
+		if (!sgx_can_reclaim()) {
 			page = ERR_PTR(-ENOMEM);
 			break;
 		}
-- 
2.25.1


