Return-Path: <cgroups+bounces-2505-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 870F28A6196
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 05:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 164B21F23085
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 03:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F259659155;
	Tue, 16 Apr 2024 03:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QXNn77F/"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F493D551;
	Tue, 16 Apr 2024 03:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237622; cv=none; b=JzjI71dEESBnxeduhnbs4DHvqvd2Jb9mbetwX1GGP6NSVfyRUbZyfcPYA6yK/41bjjPxE0jy2zisLJ7XZvkt4cfxIl+1aa0HXynGT7d8Q2nN35MwECvCnorzAQwbxNAeJiyobZFxY7SuQgRnzGWQOJ0I91ig7VdbvoPb82Comkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237622; c=relaxed/simple;
	bh=KmkLMT9Md6+qKoslWuzR4HwtCtALZT7o94sNh8Svrlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hHSR3mHYEnhk9s0t43J8/0i+F6Ao8MrnyksMau6l22dPpCwbSiDWBGRbmf1lKMABspIjwzPvrL3aPcrqi5o1kFePrwC72l5O55vUG3PpQu8+hrE6u9/8q7wwjzsqX6JNBEj4SoGOffGAexwKmh1RCWZVueVQkJfEPo60iO315wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QXNn77F/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713237621; x=1744773621;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KmkLMT9Md6+qKoslWuzR4HwtCtALZT7o94sNh8Svrlg=;
  b=QXNn77F/IFTsWGJ9GUaNZ5NajYEcqLLRnWjQH7C4fc0sy4tT17khXNEN
   d4SIF5m0+Ee/qVH2GfaDDXRvpIbDifKv3VdY3af1oaw9MuOTszrrev4vc
   LLizCEaOmXZJT6ThyTemfCNk8ffYBx+9JN0ciACUPz8EC8lh7pCUQG3fO
   4NUtyLDamGi87jgpN4pLhAz6JSBUw6F7Mrg3qsymT0WNC3amFB+Ia/0Uz
   xoQJ2IU5IIKMm21CmXxvPoBr2XAV6FUu+8us0WUknQw6af69iAndixdne
   rMcomP0ceCUg4IXrIY3fMvqm/jPBdiGm53bK4xa5j+5DOPU5JdZYMlb1B
   g==;
X-CSE-ConnectionGUID: r56fulwGSCe/V5yABmWYvQ==
X-CSE-MsgGUID: V7CSIDDUQOmecd7wPoAmyA==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="34043416"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="34043416"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 20:20:19 -0700
X-CSE-ConnectionGUID: BkMFSGS5TN242T3UkAlEvw==
X-CSE-MsgGUID: mDih1a3TRXWrOhrLKQgg4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="22193659"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmviesa008.fm.intel.com with ESMTP; 15 Apr 2024 20:20:18 -0700
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
Subject: [PATCH v12 11/14] x86/sgx: Abstract check for global reclaimable pages
Date: Mon, 15 Apr 2024 20:20:08 -0700
Message-Id: <20240416032011.58578-12-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240416032011.58578-1-haitao.huang@linux.intel.com>
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
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
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
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


