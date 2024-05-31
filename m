Return-Path: <cgroups+bounces-3056-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F9A8D6C6F
	for <lists+cgroups@lfdr.de>; Sat,  1 Jun 2024 00:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBBD11F2834B
	for <lists+cgroups@lfdr.de>; Fri, 31 May 2024 22:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF55B135A53;
	Fri, 31 May 2024 22:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J/sjouoK"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8980212FF7B;
	Fri, 31 May 2024 22:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717194400; cv=none; b=CoZizrLXb2dCC5Zv9nmrRsBsUG1WhSutR/UorLq3LJQKwB8YiEVn0cxEGrVnuEjYAuZYGQ/lr3uI9SGKYNBpE9AOpX49k1erSKSfQ24s70d7I9TewFTukk/tlPeAxlxS1vkTCrwtTikQnhX5Y0ctxeg1fHCfbeVb1zLpURDPfjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717194400; c=relaxed/simple;
	bh=JhBkkvxcxApIUu75BdrXooosSs++QdD4f2HYG2mD4Rk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lJoLjzxUjoYPgtY91Qk6NXLJ3mqzm983sDyKTRBKCR3TTtVlX9TvQMh8G3e0ohygD9ds159hrsrPnzic4kZphgaqjKWGoiOW2nGKa99XE2iwcl9b3zURMykIAyImkzyGVTNMylV1wccLvfxjjMLM6tWBfp0iQlSUrj0BDRqTAZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J/sjouoK; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717194399; x=1748730399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JhBkkvxcxApIUu75BdrXooosSs++QdD4f2HYG2mD4Rk=;
  b=J/sjouoKe6VxxKQagS1qPhT7g0h+Vw4xnr4QeNCVqLS0wtKQFu/qUmDl
   1E9liXj7tEQcxfenWSHlxtlgQLw63eZCSg8EUQwuMK5qcS0eZc4Bogx8x
   RTudQ0JY4AakXFASyrJfbC2Fy8GNalRkwV66yVy0VzD3kIzWpYLyEb4Dp
   DCeu4Pw7vyROqaHS8NrlzFxJ8F7gat2sTXEwwSjYLi3sR07JASrD5SO7m
   /U2v5BGafrIa/SfHFMuGCqjVfFgRXlsuXIoBrklGbdZ9TsXzy+Of9t7Rg
   44Ro8pcrWRFH/R8VoEYqLCuL92xQ6YoN4N3Dl69O9wjrfBUB4p7xrOhOb
   g==;
X-CSE-ConnectionGUID: fWlYl3NdT1yfgIgRsZLqrw==
X-CSE-MsgGUID: v+OUF6E6TcShaoFuZVtaug==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13949803"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="13949803"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 15:26:37 -0700
X-CSE-ConnectionGUID: DIJa8Jw2T1m+PZZ+riOgFw==
X-CSE-MsgGUID: 3fkaA2fOSMuBQUs809zKeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="40736939"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmviesa005.fm.intel.com with ESMTP; 31 May 2024 15:26:36 -0700
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
Subject: [PATCH v14 09/14] x86/sgx: Abstract check for global reclaimable pages
Date: Fri, 31 May 2024 15:26:25 -0700
Message-Id: <20240531222630.4634-10-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240531222630.4634-1-haitao.huang@linux.intel.com>
References: <20240531222630.4634-1-haitao.huang@linux.intel.com>
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
index 71e84937bc17..0a06b80e26b8 100644
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
2.25.1


