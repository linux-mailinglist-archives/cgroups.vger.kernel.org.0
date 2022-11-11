Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08002626144
	for <lists+cgroups@lfdr.de>; Fri, 11 Nov 2022 19:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbiKKSgQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Nov 2022 13:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbiKKSf6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Nov 2022 13:35:58 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4962F3C6E2;
        Fri, 11 Nov 2022 10:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668191752; x=1699727752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dkrbuSbW29NorxoWdbkKDSqPb7WHSXOFvxv4JgA/XCU=;
  b=JCf16JLAKNkfeR0v/GvSBTQVhZkD7p/5cudaMAWBpllKpoGyZs869bfD
   5M4fudpHjaOT8aITEoo/4ebUcSbd+6XGWVJKP31Z6sc+hoEtjtsIsWgRR
   fPtoQtXliws51NZog+kSMvAzAQ3ZKtBSVb/ekd3O8FuFx2edsHaFn5NT1
   ZTvSs8gstb5NYbjTGa5uShFWmlVVTxG40cF5HX7NA04TMxEcUiS5TUreM
   o9fbVVw3PDJlAq9h0KdBBk7pkPioOW1L7jhzwJjH6Q16d3YnsdNHzGiga
   f9NBpZHpZUhN4+VIIuPBZ5g+7HITmE2Iklg0cBYbFoar94DSi/aAFtfAS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="292050302"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="292050302"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:35:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="640089171"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="640089171"
Received: from hermesli-mobl.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.212.218.5])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:35:43 -0800
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
Subject: [PATCH 03/26] x86/sgx: Add 'struct sgx_epc_lru' to encapsulate lru list(s)
Date:   Fri, 11 Nov 2022 10:35:08 -0800
Message-Id: <20221111183532.3676646-4-kristen@linux.intel.com>
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

Introduce a data structure to wrap the existing reclaimable list
and its spinlock in a struct to minimize the code changes needed
to handle multiple LRUs as well as reclaimable and non-reclaimable
lists, both of which will be introduced and used by SGX EPC cgroups.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/sgx/sgx.h | 45 +++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index efb10eacd3aa..aac7d4feb0fa 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -91,6 +91,51 @@ static inline void *sgx_get_epc_virt_addr(struct sgx_epc_page *page)
 	return section->virt_addr + index * PAGE_SIZE;
 }
 
+struct sgx_epc_lru {
+	spinlock_t lock;
+	struct list_head reclaimable;
+	struct list_head unreclaimable;
+};
+
+static inline void sgx_lru_init(struct sgx_epc_lru *lru)
+{
+	spin_lock_init(&lru->lock);
+	INIT_LIST_HEAD(&lru->reclaimable);
+	INIT_LIST_HEAD(&lru->unreclaimable);
+}
+
+/*
+ * Must be called with queue lock acquired
+ */
+static inline void __sgx_epc_page_list_push(struct list_head *list, struct sgx_epc_page *page)
+{
+	list_add_tail(&page->list, list);
+}
+
+/*
+ * Must be called with queue lock acquired
+ */
+static inline struct sgx_epc_page * __sgx_epc_page_list_pop(struct list_head *list)
+{
+	struct sgx_epc_page *epc_page;
+
+	if (list_empty(list))
+		return NULL;
+
+	epc_page = list_first_entry(list, struct sgx_epc_page, list);
+	list_del_init(&epc_page->list);
+	return epc_page;
+}
+
+#define sgx_epc_pop_reclaimable(lru) \
+	__sgx_epc_page_list_pop(&(lru)->reclaimable)
+#define sgx_epc_push_reclaimable(lru, page) \
+	__sgx_epc_page_list_push(&(lru)->reclaimable, page)
+#define sgx_epc_pop_unreclaimable(lru) \
+	__sgx_epc_page_list_pop(&(lru)->unreclaimable)
+#define sgx_epc_push_unreclaimable(lru, page) \
+	__sgx_epc_page_list_push(&(lru)->unreclaimable, page)
+
 struct sgx_epc_page *__sgx_alloc_epc_page(void);
 void sgx_free_epc_page(struct sgx_epc_page *page);
 
-- 
2.37.3

