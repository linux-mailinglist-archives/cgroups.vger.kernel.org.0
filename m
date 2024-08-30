Return-Path: <cgroups+bounces-4631-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05883966720
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 18:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352511C22499
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 16:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712991BAEF4;
	Fri, 30 Aug 2024 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J4/2Ap+O"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E161B9B29;
	Fri, 30 Aug 2024 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725036097; cv=none; b=Nn+ZR153IT/paLo5g/kEcOv5VZ3icY7IuyLwhkRMHeYwPuxx0MOiQYD6wCB8/7A2NaumtB2stfq1t24Pn3jtka+jBOUZz4mKb/58GYKDR6fzuzhZ7J9noTanRNjJaGwMEL1FajsomBO/CzDPXgWU2eEdd4praDHuKViw5qsNe00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725036097; c=relaxed/simple;
	bh=SlMrBaraTav424oIll4o22m9QSwHg8CcZxGkFfA7+FA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBG4/QD7XeY46JjakOFd0ySikkVSctJKdfRqJw60AKtg0pGZrYuBl3rHLU1pFax2oRUzE8gcbeQsVZ6HMCqKLrNirnr0sDIl9KNGg2mSCB+DHkCihK2cuikAyiBrf3cOvCCh04b/z5mITWLupiv3fSN1TwahDOZUf1ErJ9CzFzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J4/2Ap+O; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725036095; x=1756572095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SlMrBaraTav424oIll4o22m9QSwHg8CcZxGkFfA7+FA=;
  b=J4/2Ap+Occx6TCQE4yxuwVriavpMF4A0JJ/bxSpPcdoewbYuvzd7hQhQ
   Ov4xNAQBHCrHocY5aWRp6o3rf+Uc4yHrITVrm0Kzxf19qNyvQEdrQ5Lsf
   SUmJzRS/rfWkL/S0tvfSrzc6rDuOQH0y/gvM5XxjDTPWapUo92cF8A75e
   IIaPgaCebSLngNXBAPxxis2n0la86FBnOGB4fWotR5J2TeYHI8HEnH11x
   CgbwWooSDm336a0sO+JTFAt2Ek16oW/3p3xpRwMNFypPFVTZkPnKATit/
   MPM4RbRxIHo/1/2Ph5rVuFziZGlLvKzb8YgtxmiKzlHdR9ttmv2LVRMw2
   A==;
X-CSE-ConnectionGUID: NIOi3cu3RJStj87gzjudyQ==
X-CSE-MsgGUID: ajZbBjTlS7mJoNgi4CRK4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="34299970"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="34299970"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:40:52 -0700
X-CSE-ConnectionGUID: s1uh38juQHqKxClFQViwUA==
X-CSE-MsgGUID: IIGvwhomSnKdL6tcWtojeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="101440461"
Received: from b4969164b36c.jf.intel.com ([10.165.59.5])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:40:52 -0700
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
Subject: [PATCH v17 04/16] cgroup/misc: Add SGX EPC resource type
Date: Fri, 30 Aug 2024 09:40:25 -0700
Message-ID: <20240830164038.39343-5-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830164038.39343-1-haitao.huang@linux.intel.com>
References: <20240830164038.39343-1-haitao.huang@linux.intel.com>
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
index 757b534bec5f..cc7206734cde 100644
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


