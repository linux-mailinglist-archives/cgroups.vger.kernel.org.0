Return-Path: <cgroups+bounces-122-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D43597DBFAC
	for <lists+cgroups@lfdr.de>; Mon, 30 Oct 2023 19:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 327CAB20F5F
	for <lists+cgroups@lfdr.de>; Mon, 30 Oct 2023 18:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DFA19BCE;
	Mon, 30 Oct 2023 18:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f8cwO1yQ"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E374419BA8
	for <cgroups@vger.kernel.org>; Mon, 30 Oct 2023 18:20:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6650D3;
	Mon, 30 Oct 2023 11:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698690032; x=1730226032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5GmAti5pT59JXbFdfEtdxPlG/vuMlTMqJEpR0/hTUEE=;
  b=f8cwO1yQUlpWvuzvVvzPEi7mNi+mvTT7xdK+LENuSuXEXUB6/1VnZh3y
   lwmMqhrJ3OwCGA2K4H0C7Sa96U5n+3D9Ip+P+MU6UWIaRdUxQX4fCNZH7
   4ITMCfaXEco7uKEdBW0qWuEp7QGP/YmWdGWSdM9t9Ten5UqECXecR37vS
   WaMXJB1Q4d8Q11gKBVFSuyhA3ru/t5rtknGhpN3Nv84rZgV/pil3KteT1
   8vybgFyfYWutZ1CtpgixEGMPx3Nra0XPAps3Ij6oHMtnzM0JbzBZZz89T
   39kme88kaOxlWoGjKbGtZe9gWSNHG4UuHYrMZJv9Xv24xcvLwCzukPCUg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="367479542"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="367479542"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 11:20:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="789529504"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="789529504"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orsmga008.jf.intel.com with ESMTP; 30 Oct 2023 11:20:28 -0700
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
	yangjie@microsoft.com,
	Haitao Huang <haitao.huang@linux.intel.com>
Subject: [PATCH v6 03/12] cgroup/misc: Add SGX EPC resource type
Date: Mon, 30 Oct 2023 11:20:04 -0700
Message-Id: <20231030182013.40086-4-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231030182013.40086-1-haitao.huang@linux.intel.com>
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
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
---
V6:
- Split the original patch into this and the preceding one (Kai)
---
 include/linux/misc_cgroup.h | 4 ++++
 kernel/cgroup/misc.c        | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index 2a3b1f8dc669..368f6c5fccae 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -17,6 +17,10 @@ enum misc_res_type {
 	MISC_CG_RES_SEV,
 	/* AMD SEV-ES ASIDs resource */
 	MISC_CG_RES_SEV_ES,
+#endif
+#ifdef CONFIG_CGROUP_SGX_EPC
+	/* SGX EPC memory resource */
+	MISC_CG_RES_SGX_EPC,
 #endif
 	MISC_CG_RES_TYPES
 };
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index fa464324ccf8..a22500851fe8 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -24,6 +24,10 @@ static const char *const misc_res_name[] = {
 	/* AMD SEV-ES ASIDs resource */
 	"sev_es",
 #endif
+#ifdef CONFIG_CGROUP_SGX_EPC
+	/* Intel SGX EPC memory bytes */
+	"sgx_epc",
+#endif
 };
 
 /* Root misc cgroup */
-- 
2.25.1


