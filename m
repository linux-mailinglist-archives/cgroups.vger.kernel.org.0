Return-Path: <cgroups+bounces-4387-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC11959269
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 03:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1E11C222A1
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 01:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6A213667E;
	Wed, 21 Aug 2024 01:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FSVq0EaR"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A81180C0A;
	Wed, 21 Aug 2024 01:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724205265; cv=none; b=Jl/5pFks9mPdIlZqVMnhWIHfAJJg14XOtRlQ9V9JcRx3MKUE3wLds1Hs4RmtbLQvD/Uno/X9g/F3edXIyBcURHw9z3gAOzg7ElVEK41aVIJnfJFCgqVXR2BFSCYjF8ToqdnpupbxB6NW7dSwdNW+wLycHfpXyYyJkSmqdB4dBJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724205265; c=relaxed/simple;
	bh=soGBSjGBet41UW9jBviY3Irco4m+EvVAhbzBKwB1jW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=faUcU2vaQE3lbGcdt+EmF7Y0TU++CbyRmnBxi3rbhjmR/Kufdv+yvkkeuOhcOFyXLSTvx3+mz7xvknsoQfeKiGp1450d6wJfb9y1Vl+7IszLRrmnval3aniIYOREXYl1u+vtQOYpFZuZBY8FG+ylxZEjie6tfxr4BRd2xsDb6pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FSVq0EaR; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724205263; x=1755741263;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=soGBSjGBet41UW9jBviY3Irco4m+EvVAhbzBKwB1jW4=;
  b=FSVq0EaR9mPH2BColaA5Bho542QLZuln/J220BMPPFGWuueAxCux8r5t
   vZ4yyK1AfaENkh/wGhOcDT/CPqzG3Er70OdqU/TFP6d418h3+zUvAUgxJ
   IYThhg1rNP6YZa7QGdHr+gMaWxGQazlEarGesy753gt1BynVLTPuJr9vT
   mTtVst33DrIU8hKo6R5/lJ7T15Vy5oTReaUELzkhfxdEePNEeQfE4GHll
   i6jHq1I6lq6P42A1TvNgCDbsb+yqE9Z1IIiicD90wfrZPVVeFBqNYbpvD
   2jzLEkPJFw8uMGgD7C4pEedScme/eMZdkGkrAe2DFh2fBJ856S09xBf6l
   w==;
X-CSE-ConnectionGUID: XEebCLLAQ2KDT0jDLtnbeQ==
X-CSE-MsgGUID: o/ZlaSQkQqmZwNua1AqACQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33107865"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="33107865"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 18:54:18 -0700
X-CSE-ConnectionGUID: SAk+q+jWRWWwVODyfXVgKQ==
X-CSE-MsgGUID: AuyxizvMQZmX7fopBni+pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="61078589"
Received: from b4969164b36c.jf.intel.com ([10.165.59.5])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 18:54:16 -0700
From: Haitao Huang <haitao.huang@linux.intel.com>
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
Subject: [PATCH v16 04/16] cgroup/misc: Add SGX EPC resource type
Date: Tue, 20 Aug 2024 18:53:52 -0700
Message-ID: <20240821015404.6038-5-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240821015404.6038-1-haitao.huang@linux.intel.com>
References: <20240821015404.6038-1-haitao.huang@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristen Carlson Accardi <kristen@linux.intel.com>

Add SGX EPC memory, MISC_CG_RES_SGX_EPC, to be a valid resource type
for the misc controller.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
---
V12:
- Remove CONFIG_CGROUP_SGX_EPC (Jarkko)

V6:
- Split the original patch into this and the preceding one (Kai)
---
 include/linux/misc_cgroup.h | 4 ++++
 kernel/cgroup/misc.c        | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index 75c711333ad4..b4119869b0d1 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -17,6 +17,10 @@ enum misc_res_type {
 	MISC_CG_RES_SEV,
 	/** @MISC_CG_RES_SEV_ES: AMD SEV-ES ASIDs resource */
 	MISC_CG_RES_SEV_ES,
+#endif
+#ifdef CONFIG_X86_SGX
+	/** @MISC_CG_RES_SGX_EPC: SGX EPC memory resource */
+	MISC_CG_RES_SGX_EPC,
 #endif
 	/** @MISC_CG_RES_TYPES: count of enum misc_res_type constants */
 	MISC_CG_RES_TYPES
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index 6cf1f0899f4e..300af1ee20fc 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -24,6 +24,10 @@ static const char *const misc_res_name[] = {
 	/* AMD SEV-ES ASIDs resource */
 	"sev_es",
 #endif
+#ifdef CONFIG_X86_SGX
+	/* Intel SGX EPC memory bytes */
+	"sgx_epc",
+#endif
 };
 
 /* Root misc cgroup */
-- 
2.43.0


