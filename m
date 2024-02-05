Return-Path: <cgroups+bounces-1361-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C0084A868
	for <lists+cgroups@lfdr.de>; Mon,  5 Feb 2024 23:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC991C28B4E
	for <lists+cgroups@lfdr.de>; Mon,  5 Feb 2024 22:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7694814A092;
	Mon,  5 Feb 2024 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AUy9qQab"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA951474D3;
	Mon,  5 Feb 2024 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707167210; cv=none; b=jYWz5QZARFakLuIihRAMJqsFkA2+gaJbkFPxTAnkNY2G1M3cC4AH6LI1UMFanUNk+jo3jNuNAx2UYnY2rrB9Nf/QViqniIdIDnSZfUnvsxbVsSnOTLqcm8QSg+aStDZ5eKq6m5zHdTOev8kdXUytgy7eT0vy3SXZshfkE1e4kZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707167210; c=relaxed/simple;
	bh=WxK5jOiLmsHbMCLwOxK9jLktiGaCw5o0cemgelWhecY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YJnqxlth70SAzlPeAkiF2VJ85yW9SFN02+V9sWei5bDxjsSvMgpOfo2SMd6lFrTJSr/mrx+uVON7P2NkKPFZy9qri/7sPDn4TOQZ+KKMamjt0+eJNSdTTUMeo2YGl6z8itdKhR4xR2SSqYFLQf74N3iF0V0HiHsBkyXCYlVnZ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AUy9qQab; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707167208; x=1738703208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WxK5jOiLmsHbMCLwOxK9jLktiGaCw5o0cemgelWhecY=;
  b=AUy9qQab7y89njuytZRv12iD5Q5G+FmsIvNn/FTWnmCVzenRlQHyBNbo
   Li4kq2cZq+Dk5DbXslQM4mISimiNHc3xVXReQks0bKieAR98E8igNHpyE
   h14l9u8Vs1KyRtgS6nOeQSmi6b0pW0IVy7TSMQZDY0Q5zxOYDRjjfRkpF
   R/Pw1mjf2WWYCvVZwOq/n7FzBE8avId9TuHGLJG3TR295C+GJTL3OeTDl
   XDPEN7bPhwy6/XJjhcrlGLiB5rxSUVSorfVbkxLvwORbJucw/9+lyUC/D
   +tWbtW6VlC5iO7VzmQGE7uu6XVxuvmD/gSj/XXNbvPQKVYeUaQwDNYQaT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11960440"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11960440"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 13:06:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="38245641"
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
Subject: [PATCH v9 10/15] x86/sgx: Add EPC reclamation in cgroup try_charge()
Date: Mon,  5 Feb 2024 13:06:33 -0800
Message-Id: <20240205210638.157741-11-haitao.huang@linux.intel.com>
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
index d399fda2b55e..abf74fdb12b4 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -184,13 +184,35 @@ static void sgx_epc_cgroup_reclaim_work_func(struct work_struct *work)
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
-	return misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg, PAGE_SIZE);
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
index e3c6a08f0ee8..d061cd807b45 100644
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
index 51904f191b97..2279ae967707 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -588,7 +588,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 	int ret;
 
 	epc_cg = sgx_get_current_epc_cg();
-	ret = sgx_epc_cgroup_try_charge(epc_cg);
+	ret = sgx_epc_cgroup_try_charge(epc_cg, reclaim);
 	if (ret) {
 		sgx_put_epc_cg(epc_cg);
 		return ERR_PTR(ret);
-- 
2.25.1


