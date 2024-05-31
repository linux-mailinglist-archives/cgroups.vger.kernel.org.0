Return-Path: <cgroups+bounces-3052-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6263E8D6C68
	for <lists+cgroups@lfdr.de>; Sat,  1 Jun 2024 00:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85EF91C23835
	for <lists+cgroups@lfdr.de>; Fri, 31 May 2024 22:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D7F8405D;
	Fri, 31 May 2024 22:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m1/l2woj"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6278E81AB4;
	Fri, 31 May 2024 22:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717194397; cv=none; b=SqTGkBuG3mpj6fRk+8mPuADGGrX6Nh+AZWK3XUXIYjqAokJWaoWPECs+ih5WHKxnF8bBnPRA+7/HE0TQylDQhvIX1FJyUY/2fJqLQrxq+tYa3WgyloX3VJEGyzMZHz1OosmJXouhVHQs1FwYxngFSpaGqzQkrXUHI04V0vorkNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717194397; c=relaxed/simple;
	bh=sJFW0ltM0O1BHkI+u582PzoUZyLLTIZYbeD8rl/i1fI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lQMlGTSLSV22qPpJRKPcxXSqntmVzOH20f3vxq+5RrNh8SH+Z/JEGCeplujKprfquewET5tjF5W3vTlX4aWawf6Kdlwf7iRFOEhwHFLZ+Zla5zgEtW/OWDsKSzqN7RFgSzzekuSsWqF+2KsRQ4cA7m3eEkFZMBDwVHjnxNTJN10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m1/l2woj; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717194395; x=1748730395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sJFW0ltM0O1BHkI+u582PzoUZyLLTIZYbeD8rl/i1fI=;
  b=m1/l2wojdLJKpyGLuo9rJUGquiopwAMasCA2nBWa6cpoNOB9IQLqokEG
   Q2oJZt7Pk/SfdZFEyrH88aXcubaL94h6XRkdT2eQZWfpjBBJNOmQx2Edw
   B1bTNZA06/YW2ywErRlI5fkzacm8CRY+I95zxGoJ6ZKJWfSxvUCXPJq0u
   /YT12qlmJsmOQLT8W26tks9TxEcVmJe0qTwHJDSCnCA+vcwfuu4/+uvjI
   xtzd6KKtVsV1fgTB61DZmnOTGFoptVBrmV+tk392pUAC5ibgb0JdpbT+5
   IJH9TaSYeE2l5+zcu8RnNNt1OzpA66uQAN0RmM1pUJRsEgtnbubWwGpM0
   A==;
X-CSE-ConnectionGUID: 3Z7QUYBbQNWe3OM858Nb9Q==
X-CSE-MsgGUID: mZdim+z9T/i9Rm4RxLLGIQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13949758"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="13949758"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 15:26:34 -0700
X-CSE-ConnectionGUID: ZvUew+Q/Q0uea+QDMLKGEQ==
X-CSE-MsgGUID: DnZsrCtyQ4eN4+vEgCWBhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="40736924"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmviesa005.fm.intel.com with ESMTP; 31 May 2024 15:26:33 -0700
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
Subject: [PATCH v14 04/14] cgroup/misc: Add SGX EPC resource type
Date: Fri, 31 May 2024 15:26:20 -0700
Message-Id: <20240531222630.4634-5-haitao.huang@linux.intel.com>
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
index 7d852139121a..863f9147602b 100644
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
2.25.1


