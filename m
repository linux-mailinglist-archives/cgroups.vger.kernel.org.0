Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18175E6939
	for <lists+cgroups@lfdr.de>; Thu, 22 Sep 2022 19:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiIVRLP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Sep 2022 13:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiIVRLO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Sep 2022 13:11:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0C2EC541;
        Thu, 22 Sep 2022 10:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663866673; x=1695402673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ifb30cg6P3JKvBBa008GWBRWYGH5CsWJa5YGYBaxzPg=;
  b=iGeegM4aoNIwR7xjkvi4BBeFVBXbC+s0Po3o98gR1hhnt6qMWYM4zFPc
   SFsX1tM0B3XwRhPffvTOMCMEdIseGOaVjwG5RCY9EQpYewVLARxbPHs0e
   epcj0OviE++mhinBnE5aDIXD01w7TOOrzyXmxmKIA3Ui/GH30DaUj3auj
   KT0u+UAvuXCkfCDQYEXOiNbjFwjB5+Wc6/7nFO+sXPZjeBsAzQaXf6Y0h
   pYqTH73ETk1pu79nCWHcwAVJGJEp4bJKaDTjPUC600u2IdmxajYs7R3z3
   kEsKzvGiprIIqmX33riSiVrAY8fl9NQNBGux0mAI5/obywq3JJicunDly
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="326689825"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="326689825"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 10:11:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="762269823"
Received: from sknaidu-mobl1.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.212.165.187])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 10:11:07 -0700
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [RFC PATCH 01/20] x86/sgx: Call cond_resched() at the end of sgx_reclaim_pages()
Date:   Thu, 22 Sep 2022 10:10:38 -0700
Message-Id: <20220922171057.1236139-2-kristen@linux.intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922171057.1236139-1-kristen@linux.intel.com>
References: <20220922171057.1236139-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Move the invocation of post-reclaim cond_resched() from the callers of
sgx_reclaim_pages() into the reclaim path itself.   sgx_reclaim_pages()
is always called in a loop and is always followed by a call to
cond_resched().  This will hold true for the EPC cgroup as well, which
adds even more calls to sgx_reclaim_pages() and thus cond_resched().

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 515e2a5f25bb..4cdeb915dc86 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -367,6 +367,8 @@ static void sgx_reclaim_pages(void)
 
 		sgx_free_epc_page(epc_page);
 	}
+
+	cond_resched();
 }
 
 static bool sgx_should_reclaim(unsigned long watermark)
@@ -410,8 +412,6 @@ static int ksgxd(void *p)
 
 		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
 			sgx_reclaim_pages();
-
-		cond_resched();
 	}
 
 	return 0;
@@ -578,7 +578,6 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 		}
 
 		sgx_reclaim_pages();
-		cond_resched();
 	}
 
 	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
-- 
2.37.3

