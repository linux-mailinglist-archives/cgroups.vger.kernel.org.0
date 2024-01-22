Return-Path: <cgroups+bounces-1193-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2786836E73
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 18:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29BA31F2AB7B
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 17:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E265FDAC;
	Mon, 22 Jan 2024 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gKY8qBmM"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31255F87D;
	Mon, 22 Jan 2024 17:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944057; cv=none; b=pdrWVgib+8oz+9HWzOU++HPGTz3+KvSNW+k/rCQ3SF8H1UBXalAcLrhf4gInlJRA7kFRFh2ZJpbBpFf9lcXDohw9XU96JVYXiSOw/5PWXwhUS0UlzYNzn5zuN7OFmBh2/6E2U1loIImS9csiKyESdSQ3VVtNn0saIVfI/RPW9Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944057; c=relaxed/simple;
	bh=gYW68ZmOdfIbilcMvN6+gosLrI1qZCi5nCc+mCYx9TQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nQUNO7R8UayKXxwYkImqYS2SOaBJvqmq8PprTFqPNe1ueevkBbhEtOGH5o+MZxB0m/erjKWrqhWFryk+IT/GCOWLpJjvG8ByWtxjhw3rqf3ptnp7ioc2LiHyKkL6zS0VHGkLN1CBqwSYospSWlumJGxw52hkFnt+/hqEABRUF10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gKY8qBmM; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705944056; x=1737480056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gYW68ZmOdfIbilcMvN6+gosLrI1qZCi5nCc+mCYx9TQ=;
  b=gKY8qBmMzt1gDMIaq26xYSa0Jahec/YYaGKiIQ7MdztHLLt5FHc7FZaN
   vRX+1/34wZFBFevlTY6SPTQHZAamUvyd3v1LciF1kHGO0R7tZLuuYJqEY
   hPlwdJwxn4vOyXS0v4FlKkOTChGtS83J/n2QRcB60Dlv5Kex2dr9zJz8O
   v7Pp2s9LzKU5ukQM5TOCgr+qOukAND9epmhDoKnj9VHtHRQ6qt9m+cSXp
   2tNJTMAzmsXL7pleThNue+p28D0qvL5wfcv0vP1wK3iHODHw/fyHoY4UJ
   byxLRs7wIA3opeR45ix2MS9Zwi8BflMJoDCr4cBar7KvZN0b42zUtF2N5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="1150191"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1150191"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 09:20:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1262884"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orviesa005.jf.intel.com with ESMTP; 22 Jan 2024 09:20:49 -0800
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
Subject: [PATCH v7 10/15] x86/sgx: Add EPC reclamation in cgroup try_charge()
Date: Mon, 22 Jan 2024 09:20:43 -0800
Message-Id: <20240122172048.11953-11-haitao.huang@linux.intel.com>
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

When the EPC usage of a cgroup is near its limit, the cgroup needs to
reclaim pages used in the same cgroup to make room for new allocations.
This is analogous to the behavior that the global reclaimer is triggered
when the global usage is close to total available EPC.

Add a Boolean parameter for sgx_epc_cgroup_try_charge() to indicate
whether synchronous reclaim is allowed or not. And trigger the
synchronous/asynchronous reclamation flow accordingly.

Note at this point, all reclaimable EPC pages are still tracked in the
global LRU and per-cgroup LRUs are empty. So no per-cgroup reclamation
is activated yet.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
---
V7:
- Split this out from the big patch, #10 in V6. (Dave, Kai)
---
 arch/x86/kernel/cpu/sgx/epc_cgroup.c | 26 ++++++++++++++++++++++++--
 arch/x86/kernel/cpu/sgx/epc_cgroup.h |  4 ++--
 arch/x86/kernel/cpu/sgx/main.c       |  2 +-
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
index 44265f62b2a4..c28ed12ff864 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -176,16 +176,38 @@ static void sgx_epc_cgroup_reclaim_work_func(struct work_struct *work)
 /**
  * sgx_epc_cgroup_try_charge() - try to charge cgroup for a single EPC page
  * @epc_cg:	The EPC cgroup to be charged for the page.
+ * @reclaim:	Whether or not synchronous reclaim is allowed
  * Return:
  * * %0 - If successfully charged.
  * * -errno - for failures.
  */
-int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg)
+int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg, bool reclaim)
 {
 	if (!epc_cg)
 		return -EINVAL;
 
-	return  misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg, PAGE_SIZE);
+	for (;;) {
+		if (!misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg,
+					PAGE_SIZE))
+			break;
+
+		if (sgx_epc_cgroup_lru_empty(epc_cg->cg))
+			return -ENOMEM;
+
+		if (signal_pending(current))
+			return -ERESTARTSYS;
+
+		if (!reclaim) {
+			queue_work(sgx_epc_cg_wq, &epc_cg->reclaim_work);
+			return -EBUSY;
+		}
+
+		if (!sgx_epc_cgroup_reclaim_pages(epc_cg->cg, false))
+			/* All pages were too young to reclaim, try again a little later */
+			schedule();
+	}
+
+	return 0;
 }
 
 /**
diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
index 9b77b51a2839..6e156de5f7ff 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.h
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
@@ -23,7 +23,7 @@ static inline struct sgx_epc_cgroup *sgx_get_current_epc_cg(void)
 
 static inline void sgx_put_epc_cg(struct sgx_epc_cgroup *epc_cg) { }
 
-static inline int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg)
+static inline int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg, bool reclaim)
 {
 	return 0;
 }
@@ -66,7 +66,7 @@ static inline void sgx_put_epc_cg(struct sgx_epc_cgroup *epc_cg)
 		put_misc_cg(epc_cg->cg);
 }
 
-int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg);
+int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg, bool reclaim);
 void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup *epc_cg);
 bool sgx_epc_cgroup_lru_empty(struct misc_cg *root);
 void sgx_epc_cgroup_init(void);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 14314f25880d..b43d51eff5ef 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -586,7 +586,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 	int ret;
 
 	epc_cg = sgx_get_current_epc_cg();
-	ret = sgx_epc_cgroup_try_charge(epc_cg);
+	ret = sgx_epc_cgroup_try_charge(epc_cg, reclaim);
 	if (ret) {
 		sgx_put_epc_cg(epc_cg);
 		return ERR_PTR(ret);
-- 
2.25.1


