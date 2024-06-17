Return-Path: <cgroups+bounces-3196-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E51E90AE45
	for <lists+cgroups@lfdr.de>; Mon, 17 Jun 2024 14:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740CF284D8D
	for <lists+cgroups@lfdr.de>; Mon, 17 Jun 2024 12:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CE1198842;
	Mon, 17 Jun 2024 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZN90R1z"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0D0197A72;
	Mon, 17 Jun 2024 12:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718628823; cv=none; b=adkZejHqfHxlDcZ6WmYS/PGJzkzRVAJsjZ4opca4ui4uXXCC23XloE77eUTYGsLIKkhSfj1AfeDUkDPPNysy/dFeXXFtEz+dfi0ICo/M6OXENmaN8ML/8i8Toyz7IRVFJ3NAw1a2rhLolcIRivHTEs2pOzSI9PEZLutaRVXL+AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718628823; c=relaxed/simple;
	bh=IK+OkYzzeTLQAfU8htkvGf4F2cSRirFYOI59YilertI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLJBSHdGErjTlqHAh9eX/6Y1ubOwXs0l+2/i6CFdym59KonVAM4+p4BZx28V0yHKGC891zhlu/J1Y5RRkuDNTEPfi8jDGMDlOwctinPURfKmN+a51TiznRRUEv9xej3daFidsoLmCBfqeOvwMcPXFQnRvttj7UlBYC215KOpioo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZN90R1z; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718628823; x=1750164823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IK+OkYzzeTLQAfU8htkvGf4F2cSRirFYOI59YilertI=;
  b=HZN90R1zAMPtAfJJoJpYdJgUdgbfDuOwqB3hDMp1PoExE0OFGtnpj+CN
   xvRULnDYV3sb1OlhmngH5/B4BN9viyW/gWaCqizvkMYd6fePaKj9+Tahv
   14GRnrMXVR3dFfBKa8znZedKlQc7I0SKb7ISZmld/db+hOtdmOlg/Ddrz
   72OIEOMcP2WBnYe8qGSyLW1Q4utlcQUPBlhmVwiAL6zrw6ATTwBJ3tkQ5
   4TwvXH3JIEuzbD2v+gWvf+CLmCScCpPsPBgBlR8eheRsvw9ADh1uDXI8e
   f3jlH1QC93ugKdqf7Jra09Srj3JJXNNkApsfVEvoXhMZ5BODSGLFyI4b9
   g==;
X-CSE-ConnectionGUID: USoESMCATt6x2zmjhLNf5Q==
X-CSE-MsgGUID: tGSgqc9uR1C2lSrYfTIGqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15570864"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15570864"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 05:53:40 -0700
X-CSE-ConnectionGUID: v7QaP2MoTjm9hgRo/TcQ4A==
X-CSE-MsgGUID: 0YHsYTNZSMWWOLLmmIL2Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="72387521"
Received: from b4969164b36c.jf.intel.com ([10.165.59.5])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 05:53:39 -0700
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
Subject: [PATCH v15 04/14] cgroup/misc: Add SGX EPC resource type
Date: Mon, 17 Jun 2024 05:53:11 -0700
Message-ID: <20240617125321.36658-5-haitao.huang@linux.intel.com>
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
index 541a5611c597..440ed2bb8053 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -17,6 +17,10 @@ enum misc_res_type {
 	MISC_CG_RES_SEV,
 	/* AMD SEV-ES ASIDs resource */
 	MISC_CG_RES_SEV_ES,
+#endif
+#ifdef CONFIG_X86_SGX
+	/* SGX EPC memory resource */
+	MISC_CG_RES_SGX_EPC,
 #endif
 	MISC_CG_RES_TYPES
 };
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index eb1a1ed9f66d..51679ba9ed1a 100644
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


