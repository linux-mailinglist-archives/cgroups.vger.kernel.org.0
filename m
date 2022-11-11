Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3D6626166
	for <lists+cgroups@lfdr.de>; Fri, 11 Nov 2022 19:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbiKKShI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Nov 2022 13:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbiKKSga (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Nov 2022 13:36:30 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F4F836A8;
        Fri, 11 Nov 2022 10:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668191782; x=1699727782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EBcLsiw30eqLl7g1ih7HHqPXoxhQ0Yyb7AgcJd3NM6M=;
  b=DcdzJGxlzqeMI/lVJgpZqqrS2R/BtbGEaER+UPPX/2sRCSlBUD7UsRBQ
   iinw8ZfNwf/pMHccT7UNwlg5FXGzc5JjIS2JvaGOiQ9/ZocAEF8cbrArC
   1uDU6p+EwBNwHuIhpW5jragpop1al97Xa+tUg/o6A1S7DxsRIYwYNnjsB
   psk0qIH9OPaj8FXtVonWN2kw1Fk++umdmg5ctHUgPPWhcyx0q3wFX3TQm
   tHjlLM7lyA9zJ+Vt3DtyzfY2W+aaBhL78/zIFq4m5u3ziAwsiRc2t2Kym
   FXOKldQlIV+Vj6/TBZwu5YVxa/l/hde1crqPRw2Ey7oyWNiXsWGYDupsf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="313447734"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="313447734"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:36:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="640089447"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="640089447"
Received: from hermesli-mobl.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.212.218.5])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:36:21 -0800
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     zhiquan1.li@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 24/26] cgroup/misc: Add SGX EPC resource type
Date:   Fri, 11 Nov 2022 10:35:29 -0800
Message-Id: <20221111183532.3676646-25-kristen@linux.intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221111183532.3676646-1-kristen@linux.intel.com>
References: <20221111183532.3676646-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Allow SGX EPC memory to be a valid resource type for the misc
controller.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 include/linux/misc_cgroup.h | 4 ++++
 kernel/cgroup/misc.c        | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index cee848205715..aeaf4acf22af 100644
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
index 642879ad136f..e73a034adca3 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -25,6 +25,10 @@ static const char *const misc_res_name[] = {
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
2.37.3

