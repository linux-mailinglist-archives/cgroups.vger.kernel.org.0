Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A78A626154
	for <lists+cgroups@lfdr.de>; Fri, 11 Nov 2022 19:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbiKKSgd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Nov 2022 13:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbiKKSgF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Nov 2022 13:36:05 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EB832061;
        Fri, 11 Nov 2022 10:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668191765; x=1699727765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tdinHlyyGqVYquaFqgcvC9rbRf2JmMok2HdQOnKfOO0=;
  b=kQNug6BumCzHV+Fz26lBnWpC6rlBPPrsDXL0pxOp5hB0JkA4jnJRgOPi
   kz5oxfnJZlMIuJDZ7wtPO3eJQe9LOWGnrrLi3DJxcUVMnyPrMuKh19BgB
   55MrZUl7rjW065OKk+Lwcl/u0TivsHL7aNU6Em/pltOXyVl/MeMcJdB09
   z7AmC0dEZier/ZCijcxdG5Fd37LF7ddD8lBuyosgD0h49oeqEWOuY66Pa
   0tosQkA3HwIeb7Hgz4OSM8aqaNlmB2Fuwh4sXWn8AIkD3aj8sTIR4rSj5
   dpWLe8XD1HH6rPfIw/1zn8ajBdYtFjtn4ZKYVs1e7sRgoEm/sNrzGtNJ+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="292050364"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="292050364"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:36:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="640089302"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="640089302"
Received: from hermesli-mobl.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.212.218.5])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:36:03 -0800
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     zhiquan1.li@intel.com,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH 13/26] x86/sgx: Prepare for multiple LRUs
Date:   Fri, 11 Nov 2022 10:35:18 -0800
Message-Id: <20221111183532.3676646-14-kristen@linux.intel.com>
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

From: Sean Christopherson <sean.j.christopherson@intel.com>

Add sgx_can_reclaim() wrapper so that in a subsequent patch, multiple LRUs
can be used cleanly.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index c33966eafab6..b2c050fcc989 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -391,10 +391,15 @@ static int sgx_reclaim_pages(int nr_to_scan, bool ignore_age)
 	return ret;
 }
 
+static bool sgx_can_reclaim(void)
+{
+	return !list_empty(&sgx_global_lru.reclaimable);
+}
+
 static bool sgx_should_reclaim(unsigned long watermark)
 {
 	return atomic_long_read(&sgx_nr_free_pages) < watermark &&
-	       !list_empty(&sgx_global_lru.reclaimable);
+		sgx_can_reclaim();
 }
 
 /*
@@ -599,7 +604,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 			break;
 		}
 
-		if (list_empty(&sgx_global_lru.reclaimable))
+		if (!sgx_can_reclaim())
 			return ERR_PTR(-ENOMEM);
 
 		if (!reclaim) {
-- 
2.37.3

