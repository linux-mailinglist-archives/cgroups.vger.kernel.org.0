Return-Path: <cgroups+bounces-1197-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EF6836E7C
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 18:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 327E8285AD6
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 17:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E1C60243;
	Mon, 22 Jan 2024 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jXBpNgHS"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158CC5FDC3;
	Mon, 22 Jan 2024 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944059; cv=none; b=tqTEE7t92ugdJinXio+8/lbtcT+OqU8BAAPpjAJ7b7VGJcOmjniLlSLh/KQm471n7pPqPnpcLXR+bLNMb45Jugw8cZxz6yebp3EX4ElrXFH2l83u02STVT1K1/vvRXRCX2+WV7Ec1kyKc2Q3045cCOEBKpbehi79PrE/9PyMSTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944059; c=relaxed/simple;
	bh=CeTn0IQPXrB1i5pYzJRTbSDJvqgMiUE0UQY3Ef++NsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I6NmJ0HoS4agCFrIBTlSwBWqQWN0nTN/PP+dWw9LEVZD5OSjz0+tS5Ekz6Kx/qxnVHbsN98Yh8tJaZLaMXZ+EfhAbeelMC/DdO3sCMZXW4yNdgggJC5VEDzrHAYFQk6oN3WVvMgyIxTOByV+FFdRbN2f7QifdaBe1wCrFbLQ6CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jXBpNgHS; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705944059; x=1737480059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CeTn0IQPXrB1i5pYzJRTbSDJvqgMiUE0UQY3Ef++NsQ=;
  b=jXBpNgHSMAGJ6N4s3+QkJAQheqy8FmVR5ReCamgLDF9jTyO1KR5DjaX/
   HQPFUAYWG2DwGKRfXtAizUlWLB2KmdjXOTNLTWZ7+N6zGMbEdquBzCCDW
   lOKYWXCPxnXIjiN332lMBjXMuDRMBeJgc0PcIM4vzRFd242XKDSVudaW3
   2rLdinfsxc1ac7KbKMdMwwFI3FGEO+ixJeAG1GUkrHrFk7b/Sjol9XEMB
   KBCHbbzKE/F2caOocnwSl9LyIUkWPRNMPGRzLuwgQj4uPn0IFSr5fvDod
   G+5IQeByeitd65XMT9i/yhaFuE7lf9wT5bmZ8XjQn8H+hDX9AbyLStLE7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="1150210"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1150210"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 09:20:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1262891"
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
Subject: [PATCH v7 12/15] x86/sgx: Expose sgx_epc_cgroup_reclaim_pages() for global reclaimer
Date: Mon, 22 Jan 2024 09:20:45 -0800
Message-Id: <20240122172048.11953-13-haitao.huang@linux.intel.com>
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

When cgroup is enabled, all reclaimable pages will be tracked in cgroup
LRUs. The global reclaimer needs to start reclamation from the root
cgroup. Expose the top level cgroup reclamation function so the global
reclaimer can reuse it.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
---
V7:
- Split this out from the big patch, #10 in V6. (Dave, Kai)
---
 arch/x86/kernel/cpu/sgx/epc_cgroup.c | 2 +-
 arch/x86/kernel/cpu/sgx/epc_cgroup.h | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
index c28ed12ff864..fdf1417d9ade 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -88,7 +88,7 @@ bool sgx_epc_cgroup_lru_empty(struct misc_cg *root)
  * @indirect:   In ksgxd or EPC cgroup work queue context.
  * Return:	Number of pages reclaimed.
  */
-static unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root, bool indirect)
+unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root, bool indirect)
 {
 	/*
 	 * Attempting to reclaim only a few pages will often fail and is inefficient, while
diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
index 6e156de5f7ff..05a4de9f7024 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.h
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
@@ -31,6 +31,12 @@ static inline int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg, bool
 static inline void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup *epc_cg) { }
 
 static inline void sgx_epc_cgroup_init(void) { }
+
+static inline unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root,
+							bool indirect)
+{
+	return 0;
+}
 #else
 struct sgx_epc_cgroup {
 	struct misc_cg			*cg;
@@ -69,6 +75,9 @@ static inline void sgx_put_epc_cg(struct sgx_epc_cgroup *epc_cg)
 int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg, bool reclaim);
 void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup *epc_cg);
 bool sgx_epc_cgroup_lru_empty(struct misc_cg *root);
+unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root,
+					  bool indirect);
+
 void sgx_epc_cgroup_init(void);
 
 #endif
-- 
2.25.1


