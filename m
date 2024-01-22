Return-Path: <cgroups+bounces-1196-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 863BF836EDD
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 19:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BB3DB309D4
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 17:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C58E5FEFD;
	Mon, 22 Jan 2024 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dI7eIKGS"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC025FDA6;
	Mon, 22 Jan 2024 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944058; cv=none; b=NBoVe67W3AJow6f9hewGjS4ziqkKuVtHsR89wAiychyi3oultFRzV5bbfj+fjeq/adW1dXOqtlLxlyB8Ufz6/qHCEPGblsXHnWI2PpWEuNuQWS6xhyGz3ehfYKUmNGZboukUPJpXukxkllbQTkfV88O1bmv11ULSkFd3tU6g4hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944058; c=relaxed/simple;
	bh=jNh+Ec0INav17U2QsXl1QxO3Tk5wsz1LnWFitqVAk5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S34ma9zvmwilvCXc/LRKnI9Fq1InJElg0+788s5if771NrMX7FvaqjLQZl06gZo8dHtJpwjlXkHtVlMErqJ+/Y/Nd1BALQ+qP8VYy5LjWePKu1MTipJOZo5l7Szfa9IuA2ATs+4AlPvsA9vWZ0xUlNHCpiXMrKDxJaxr6gkt+Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dI7eIKGS; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705944058; x=1737480058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jNh+Ec0INav17U2QsXl1QxO3Tk5wsz1LnWFitqVAk5k=;
  b=dI7eIKGSSKXQHbkVEIb+Ggdfp8QYIa9FT9CKHGBxxTd5DaDZCK5bWLIv
   CaVELQlMQQTRYU4MigWkQ9V1Y2IR7/UzHBo4Br8EW75dPiJdKhIrCc6kq
   iQ1uNSBmtVRxJsjB12kpgCP8jxZeUDERUm0E94ggbjKr0KDGaIhbwNSRj
   2NDaA0Bl4RLPcEpOeQ0+r9D5eTT3/WjYC+4tM46mUp92N1Zc9bSTftL8X
   nCTddOi2qy7aCl9+SNPwZab4anuyThiUhFSmL6NywXztksHrjRUukM/8i
   Zs38BHzQ63Bdb3gMA3MiLMOhCesUolUcy8HdhqWqdNLP1/X95BNK78sYz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="1150200"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1150200"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 09:20:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1262887"
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
Subject: [PATCH v7 11/15] x86/sgx: Abstract check for global reclaimable pages
Date: Mon, 22 Jan 2024 09:20:44 -0800
Message-Id: <20240122172048.11953-12-haitao.huang@linux.intel.com>
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
index b43d51eff5ef..7b13bcf3e75d 100644
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
@@ -395,7 +400,7 @@ unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru, unsigned int *nr_to
 static bool sgx_should_reclaim(unsigned long watermark)
 {
 	return atomic_long_read(&sgx_nr_free_pages) < watermark &&
-	       !list_empty(&sgx_global_lru.reclaimable);
+		sgx_can_reclaim();
 }
 
 static void sgx_reclaim_pages_global(bool indirect)
@@ -599,7 +604,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 			break;
 		}
 
-		if (list_empty(&sgx_global_lru.reclaimable)) {
+		if (!sgx_can_reclaim()) {
 			page = ERR_PTR(-ENOMEM);
 			break;
 		}
-- 
2.25.1


