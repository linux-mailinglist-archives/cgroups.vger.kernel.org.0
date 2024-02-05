Return-Path: <cgroups+bounces-1362-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD5384A869
	for <lists+cgroups@lfdr.de>; Mon,  5 Feb 2024 23:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7307A2910AA
	for <lists+cgroups@lfdr.de>; Mon,  5 Feb 2024 22:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CC414A0B1;
	Mon,  5 Feb 2024 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ab+2UHCQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CFE1487F0;
	Mon,  5 Feb 2024 21:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707167210; cv=none; b=RHyuFhrIQ80yOw5CcGypl+nFHzqUCqeyho3ZluxzOA2A0m7cwRnEybIfz6AKVciSSrovmAC+6t+XXtVmq49G1uFftvgmBaNVEDN9fZFX4vGMDfoO2Djld6bxZzqPloMns0iUdYhcZkU0Q1a8fiDw/3lAKebCz0aTaC7jDPx2/pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707167210; c=relaxed/simple;
	bh=rrpRMx6KFPHw5V/aj02GXylo9fjKkcl/4Bs4p2tRtDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZaS5UGG8+34G5WPzbRWYnIEQjYIr33KSsVzVIkkxcNZ4Bdy3VbUnyl3zn8BEk/IpUhGBDK4wlXV+wYUKrLK/MitjJIqLhFzT24BYt3vN1ZnhP+6l4LTFqXcQ71JTT/fybJ04nDAQd2Y7w3KXyUNpXBECJE+9mCKoc7yo/oEO3yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ab+2UHCQ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707167209; x=1738703209;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rrpRMx6KFPHw5V/aj02GXylo9fjKkcl/4Bs4p2tRtDQ=;
  b=ab+2UHCQ8QMPiOc7YS9R4jAoAmHmj8/Qq8wvnd4g11VUM6cELLJO7GOm
   D+6aX1ZUonUZ10HJWczSm0PRVWPfqBPXSQy0otpDIZpTSPOh0t2xMJckb
   tMEiXZ6vQLYeGyYXGthlrQWWdZtzo+ak/bJaV6BQNuPh6qfAePeIygmyP
   a0pnvey7YPoDTC1pU194E/3wkECGp77V+u22UG1YxvAjc4aN5OcsmaxUe
   T5abOpzFDfn6YF0UNYtLF1p+S8Hn804g0FoffGGB3+HoB73FMGzHJ/H4s
   NNlz3Sfwzdz2N2G913pi6tppj1t+Yf18SeLpoNBdZbpk0L0y8lxOSVCeo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11960457"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11960457"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 13:06:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="38245644"
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
Subject: [PATCH v9 11/15] x86/sgx: Abstract check for global reclaimable pages
Date: Mon,  5 Feb 2024 13:06:34 -0800
Message-Id: <20240205210638.157741-12-haitao.huang@linux.intel.com>
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


