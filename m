Return-Path: <cgroups+bounces-3200-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E44890AE4B
	for <lists+cgroups@lfdr.de>; Mon, 17 Jun 2024 14:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DDED286CAD
	for <lists+cgroups@lfdr.de>; Mon, 17 Jun 2024 12:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCB7198E9C;
	Mon, 17 Jun 2024 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UgJtoYDB"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6128198A1A;
	Mon, 17 Jun 2024 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718628826; cv=none; b=aknzDP6MWJZb6rs91YG2Fi22HJOpaUJFNemFCqxccd55Hasd0FOdXqtP1i+Ax9XqSbwKduikE14j2agE6gJiZFlv7eQQ8FnGqIt6hPKXU0emNNoaMIqHbqe3FvbQeCY9L0j1nfvqaCMoANrovBQQUH53CwUT/rV/u2hxYARtC4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718628826; c=relaxed/simple;
	bh=UeFea/HG10qygsyFS2LjWowjb500HAF+aFndAKdP8YM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czUu0Mrbs/eU1+AnwdNB48zlRS9ml4ZMGavm0BQhh+bobtPbvwVPCzg9Ulv5FVjy7n9LZNyXuCdWCldq7VDN+WVTZZDlJb73t31CcguY26jByitDZUFG1lEQORSFOnBv1CbMMZAMic0E1gtLCj2B+UmFvK/K6Mrc6tIYIRqaR98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UgJtoYDB; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718628825; x=1750164825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UeFea/HG10qygsyFS2LjWowjb500HAF+aFndAKdP8YM=;
  b=UgJtoYDBxbx5Q6SKeZgXEo2AR1v/LxwKb6NN7bbUnp18I4MwF/v8djDt
   pSU90Btr8xJUNyiS/JO3iolkOd3B31k41JIJU7mymPrPihKy83KHXN67H
   prxLPLecrvzViHduZXaXyA8tRY5JCjbrM9oRM5BK2atSV8jWeFHHvedRu
   7DZmd9n17EOEJP9OO/nftIAn2zwXUVIGGvckjzXbUXVJ9aza7u6zmrbod
   197i1NsA59NBhYqT4Xn7bqHJYO5riVzoiTatXTj1LP6i1yCPYKCErBcOF
   nF6YlDPaMj+IpHi2hhG5paLe2D+1WH+wWmfiocCiuyRBWFte1qUTP2A6+
   g==;
X-CSE-ConnectionGUID: vOtoFIq3QkSsHeQnzSL3Bw==
X-CSE-MsgGUID: bFs0fBJnRdapUe8uRQv3fA==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15570917"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15570917"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 05:53:43 -0700
X-CSE-ConnectionGUID: auC5vjpKSNyWZthVyfjWsQ==
X-CSE-MsgGUID: ZwvOKRvXQZe2MoamvZkayw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="72387546"
Received: from b4969164b36c.jf.intel.com ([10.165.59.5])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 05:53:42 -0700
From: "Huang, Haitao" <haitao.huang@linux.intel.com>
To: jarkko@kernel.org,
	dave.hansen@linux.intel.com,
	kai.huang@intel.com,
	tj@kernel.org,
	mkoutny@suse.com,
	chenridong@huawei.com,
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
Subject: [PATCH v15 09/14] x86/sgx: Abstract check for global reclaimable pages
Date: Mon, 17 Jun 2024 05:53:16 -0700
Message-ID: <20240617125321.36658-10-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617125321.36658-1-haitao.huang@linux.intel.com>
References: <20240617125321.36658-1-haitao.huang@linux.intel.com>
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
sgx_can_reclaim_global(), to abstract this check. Currently it only
checks the global LRU, later will check emptiness of LRUs of all cgroups
when per-cgroup tracking is turned on.

Replace all the checks for emptiness of the global LRU,
list_empty(&sgx_global_lru.reclaimable), with calls to
sgx_can_reclaim_global().

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
---
V13:
- Rename sgx_can_reclaim() to sgx_can_reclaim_global() and
sgx_should_reclaim() to sgx_should_reclaim_global(). (Kai)

V10:
- Add comments for the new function. (Jarkko)

V7:
- Split this out from the big patch, #10 in V6. (Dave, Kai)
---
 arch/x86/kernel/cpu/sgx/main.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index d272488c53bf..2c0a36be7cdd 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -37,6 +37,14 @@ static inline struct sgx_epc_lru_list *sgx_epc_page_lru(struct sgx_epc_page *epc
 	return &sgx_global_lru;
 }
 
+/*
+ * Check if there is any reclaimable page at global level.
+ */
+static inline bool sgx_can_reclaim_global(void)
+{
+	return !list_empty(&sgx_global_lru.reclaimable);
+}
+
 static atomic_long_t sgx_nr_free_pages = ATOMIC_LONG_INIT(0);
 
 /* Nodes with one or more EPC sections. */
@@ -390,7 +398,7 @@ unsigned int sgx_reclaim_pages(struct sgx_epc_lru_list *lru)
 static bool sgx_should_reclaim_global(unsigned long watermark)
 {
 	return atomic_long_read(&sgx_nr_free_pages) < watermark &&
-	       !list_empty(&sgx_global_lru.reclaimable);
+		sgx_can_reclaim_global();
 }
 
 static void sgx_reclaim_pages_global(void)
@@ -596,7 +604,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_reclaim reclaim)
 			break;
 		}
 
-		if (list_empty(&sgx_global_lru.reclaimable)) {
+		if (!sgx_can_reclaim_global()) {
 			page = ERR_PTR(-ENOMEM);
 			break;
 		}
-- 
2.43.0


