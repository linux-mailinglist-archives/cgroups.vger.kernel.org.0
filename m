Return-Path: <cgroups+bounces-2211-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EEA88F39B
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 01:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 175162A3920
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 00:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEAF383AC;
	Thu, 28 Mar 2024 00:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ea7Pzo3S"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99032C1A7;
	Thu, 28 Mar 2024 00:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711585373; cv=none; b=nWAB0rE4ZHSHTkfCAA6aLLcz+ryFXDPPvp+8TOLzF6iNgbU0E8b2C6FN658Ag6nh+5ypXhsOXmivcF2x3jp5kGIx3xUIxo1vqy7RoEM1r/ZE2Of3Q3IkkfxQkS9Rc8YwYMN6e1tWL86O3mwfOJNOssP+ks/6TlaZktzG0zsyO64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711585373; c=relaxed/simple;
	bh=D8GJmWGrqyOPL7eN3YG5swGQXwtVD67H2VeACexvADs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dD5eeJQC61hUnQX2QIKiCUrGqSm+vDRpzgVRTGvJZEjmTyNG1QhQRBZPDAtOTNu/L1z/Q0J+aadELfOFfoqUre691XwtVjZ2aJ77wo4uAMSv1A7ynii+hDBH7ndmDNY3a3n0vZXIOy/er1PwlVjb4n8eXY0NSdcYPL1TyA9/2n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ea7Pzo3S; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711585372; x=1743121372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D8GJmWGrqyOPL7eN3YG5swGQXwtVD67H2VeACexvADs=;
  b=ea7Pzo3SYnvknMg3JOBUoB5m66M1OxbWqPqx46kWLu6rlK3OHSVePaHZ
   Ftnnc5P7Wmx+2z1E1F6qMEu0lnCbtjzDpprGeS8DMurYgRpEFT5FKd45C
   JROtw7YbEeuEdIncR/GR4psW9TJKYy0UcuYb87dIKedyfhZqBSkNBwacy
   J+8hmRPlf7ozptaey7e2rRtXpflSveIcfwz1CLN6NXF2zxX7ZvTKOzbYy
   hWuXfJqqupCIqq05xzxR2tK5qsHbxVp64wt+ZWAr+baF2AfKldgeKuemL
   J7NWwQ2akVBArlQ4WPdZN8h1O4NdezXj2RbqiAXCb/+itsSk6/Jny/Q/G
   Q==;
X-CSE-ConnectionGUID: EUvgI1ikQUCW+UEH7VXcTg==
X-CSE-MsgGUID: GrMRnBPqTNG1NVki7Mtc5Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6580728"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="6580728"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 17:22:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="16411815"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orviesa009.jf.intel.com with ESMTP; 27 Mar 2024 17:22:32 -0700
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
Subject: [PATCH v10 11/14] x86/sgx: Abstract check for global reclaimable pages
Date: Wed, 27 Mar 2024 17:22:26 -0700
Message-Id: <20240328002229.30264-12-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240328002229.30264-1-haitao.huang@linux.intel.com>
References: <20240328002229.30264-1-haitao.huang@linux.intel.com>
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
V10:
- Add comments for the new function. (Jarkko)

V7:
- Split this out from the big patch, #10 in V6. (Dave, Kai)
---
 arch/x86/kernel/cpu/sgx/main.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index c94f8b49e6f2..7f92455d957d 100644
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


