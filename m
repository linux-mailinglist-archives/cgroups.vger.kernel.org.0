Return-Path: <cgroups+bounces-1270-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BFE8418E1
	for <lists+cgroups@lfdr.de>; Tue, 30 Jan 2024 03:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F369287A14
	for <lists+cgroups@lfdr.de>; Tue, 30 Jan 2024 02:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFA03F9EF;
	Tue, 30 Jan 2024 02:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cPIeb39w"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E62A38389;
	Tue, 30 Jan 2024 02:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706580588; cv=none; b=L3bcJwRQzT+RWTS3YpEvpE1E1Kii9O53np7DYFcGEzlJbZLnLW1rFDigP+N+Xol2nWQgOKSxo0Ct5g5j/5hWCdw02RCGivO2xYEV+Bt4SQNneOj8LEJj8Lq3sUIxbVUy5tw3a/+qWONnCmzIAZAx8Kjupjpd0W1NX3vpuAwuU0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706580588; c=relaxed/simple;
	bh=rrpRMx6KFPHw5V/aj02GXylo9fjKkcl/4Bs4p2tRtDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qvHNKDLsdcl9mfY5s984C1uia/s0YBPzCyh1dwzbRxYFM15ogVkzWy9Jn5HLjhHvYfdN6hKZv2uGuO4BGkcjXR0ykoh78TNzD46idzH1ejWipu8neuTkjGezejXNqNdLUjOZoznj9Wz6toXPpphpkoglkkCIYrvdh2bv06TYsJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cPIeb39w; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706580588; x=1738116588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rrpRMx6KFPHw5V/aj02GXylo9fjKkcl/4Bs4p2tRtDQ=;
  b=cPIeb39wO6aEJaAQPWSTbMrTb+VhcgkrI1GDDhKVStpPqH8RBmPch1yq
   8oGUiaQfdU4dxo/MEm/0CafQR0sHvcq0XHM1qgL0/GEjgRz1l7960pjZ7
   ogbpLewu0MC5jQ2XX+iKDi6YnOLaDwf5RNQ8COkAVe3Yzzlv9mOazgTeG
   CLl1bekTmu9CxDARuJrs2TYaRKXfS8aco491FH3EVGgw3iu5Jx0ZQwZmf
   yPmXbekrdrKaiK9m+98OzdeV3KvAlKgQny+d2LCoqvwRArpcoR5c37fwZ
   He2QcGGhmt87bRLmwnJU8EQGcdQYm2IBOCMoDud4ZJPy0htqHH2UpFN1c
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="16531004"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="16531004"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 18:09:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="822042351"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="822042351"
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
Subject: [PATCH v8 11/15] x86/sgx: Abstract check for global reclaimable pages
Date: Mon, 29 Jan 2024 18:09:34 -0800
Message-Id: <20240130020938.10025-12-haitao.huang@linux.intel.com>
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

To determine if any page available for reclamation at the global level,
only checking for emptiness of the global LRU is not adequate when pages
are tracked in multiple LRUs, one per cgroup. For this purpose, create a
new helper, sgx_can_reclaim(), currently only checks the global LRU,
later will check emptiness of LRUs of all cgroups when per-cgroup
tracking is turned on. Replace all the checks of the global LRU,
list_empty(&sgx_global_lru.reclaimable), with calls to
sgx_can_reclaim().

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
---
v7:
- Split this out from the big patch, #10 in V6. (Dave, Kai)
---
 arch/x86/kernel/cpu/sgx/main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 2279ae967707..6b0c26cac621 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -37,6 +37,11 @@ static inline struct sgx_epc_lru_list *sgx_lru_list(struct sgx_epc_page *epc_pag
 	return &sgx_global_lru;
 }
 
+static inline bool sgx_can_reclaim(void)
+{
+	return !list_empty(&sgx_global_lru.reclaimable);
+}
+
 static atomic_long_t sgx_nr_free_pages = ATOMIC_LONG_INIT(0);
 
 /* Nodes with one or more EPC sections. */
@@ -398,7 +403,7 @@ unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru, unsigned int *nr_to
 static bool sgx_should_reclaim(unsigned long watermark)
 {
 	return atomic_long_read(&sgx_nr_free_pages) < watermark &&
-	       !list_empty(&sgx_global_lru.reclaimable);
+		sgx_can_reclaim();
 }
 
 static void sgx_reclaim_pages_global(bool indirect)
@@ -601,7 +606,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 			break;
 		}
 
-		if (list_empty(&sgx_global_lru.reclaimable)) {
+		if (!sgx_can_reclaim()) {
 			page = ERR_PTR(-ENOMEM);
 			break;
 		}
-- 
2.25.1


