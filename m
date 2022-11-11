Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A6562614C
	for <lists+cgroups@lfdr.de>; Fri, 11 Nov 2022 19:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbiKKSg2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Nov 2022 13:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbiKKSgB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Nov 2022 13:36:01 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164EC814C8;
        Fri, 11 Nov 2022 10:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668191760; x=1699727760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0+aBTzx8Uf2/SBfmd8GXuOUotmJgQMlSlBljHCmIA5M=;
  b=lNiOCXv78s5N/y2VerATNU0jCeWvguwD/JPkRmI3EsoH8V/NciHMdjBD
   DCbeph1GQkih3GyZi8dzK7xuo7oxDdh0HlAn+I9vteINvpTQ1SA/kERiu
   1ggiJenC6Aod8Ha5D7vFG95ju2B7j9TE1xp1BN9mnwiuqfmbX6vbR7ne2
   wI7b9QIdqGhqaUX08fcC8xEv+0PCIWX18exGOZY7xs22DXIWHQdr+k1+D
   GhTtYEPQ6Lf/RHamycs7w9Sj497yr0NuyYfKe0kIyqwqyvOPoMI3qeqzs
   uODvbMyYdNbardj5O2XLE7BhNO5aVYOmTLvjKj6d0HbdFY5KYSPrF57hy
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="292050344"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="292050344"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:35:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="640089238"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="640089238"
Received: from hermesli-mobl.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.212.218.5])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:35:54 -0800
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
Subject: [PATCH 08/26] x86/sgx: Add EPC page flags to identify type of page
Date:   Fri, 11 Nov 2022 10:35:13 -0800
Message-Id: <20221111183532.3676646-9-kristen@linux.intel.com>
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

Create new flags to help identify whether a page is an enclave page
or a va page and save the page type when the page is recorded.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/sgx/encl.c  |  6 +++---
 arch/x86/kernel/cpu/sgx/ioctl.c |  4 ++--
 arch/x86/kernel/cpu/sgx/main.c  | 21 +++++++++++----------
 arch/x86/kernel/cpu/sgx/sgx.h   |  8 +++++++-
 4 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 4683da9ef4f1..653c9ee5bf57 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -252,7 +252,7 @@ static struct sgx_encl_page *__sgx_encl_load_page(struct sgx_encl *encl,
 		epc_page = sgx_encl_eldu(&encl->secs, NULL);
 		if (IS_ERR(epc_page))
 			return ERR_CAST(epc_page);
-		sgx_record_epc_page(epc_page, 0);
+		sgx_record_epc_page(epc_page, SGX_EPC_PAGE_ENCLAVE);
 	}
 
 	epc_page = sgx_encl_eldu(entry, encl->secs.epc_page);
@@ -260,7 +260,7 @@ static struct sgx_encl_page *__sgx_encl_load_page(struct sgx_encl *encl,
 		return ERR_CAST(epc_page);
 
 	encl->secs_child_cnt++;
-	sgx_record_epc_page(entry->epc_page, SGX_EPC_PAGE_RECLAIMER_TRACKED);
+	sgx_record_epc_page(entry->epc_page, SGX_EPC_PAGE_ENCLAVE_RECLAIMABLE);
 
 	return entry;
 }
@@ -1221,7 +1221,7 @@ struct sgx_epc_page *sgx_alloc_va_page(struct sgx_encl *encl, bool reclaim)
 		sgx_encl_free_epc_page(epc_page);
 		return ERR_PTR(-EFAULT);
 	}
-	sgx_record_epc_page(epc_page, 0);
+	sgx_record_epc_page(epc_page, SGX_EPC_PAGE_VERSION_ARRAY);
 
 	return epc_page;
 }
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index aca80a3f38a1..c91cc6a01232 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -114,7 +114,7 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 	encl->attributes = secs->attributes;
 	encl->attributes_mask = SGX_ATTR_DEBUG | SGX_ATTR_MODE64BIT | SGX_ATTR_KSS;
 
-	sgx_record_epc_page(encl->secs.epc_page, 0);
+	sgx_record_epc_page(encl->secs.epc_page, SGX_EPC_PAGE_ENCLAVE);
 
 	/* Set only after completion, as encl->lock has not been taken. */
 	set_bit(SGX_ENCL_CREATED, &encl->flags);
@@ -325,7 +325,7 @@ static int sgx_encl_add_page(struct sgx_encl *encl, unsigned long src,
 			goto err_out;
 	}
 
-	sgx_record_epc_page(encl_page->epc_page, SGX_EPC_PAGE_RECLAIMER_TRACKED);
+	sgx_record_epc_page(encl_page->epc_page, SGX_EPC_PAGE_ENCLAVE_RECLAIMABLE);
 	mutex_unlock(&encl->lock);
 	mmap_read_unlock(current->mm);
 	return ret;
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index c76a53b63fa2..09cc83d7cb97 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -304,6 +304,9 @@ static void __sgx_reclaim_pages(void)
 
 		encl_page = epc_page->encl_owner;
 
+		if (WARN_ON_ONCE(!(epc_page->flags & SGX_EPC_PAGE_ENCLAVE)))
+			continue;
+
 		if (kref_get_unless_zero(&encl_page->encl->refcount) != 0) {
 			epc_page->flags |= SGX_EPC_PAGE_RECLAIM_IN_PROGRESS;
 			list_move_tail(&epc_page->list, &iso);
@@ -359,8 +362,7 @@ static void __sgx_reclaim_pages(void)
 		sgx_reclaimer_write(epc_page, &backing[i++]);
 
 		kref_put(&encl_page->encl->refcount, sgx_encl_release);
-		epc_page->flags &= ~(SGX_EPC_PAGE_RECLAIMER_TRACKED |
-				     SGX_EPC_PAGE_RECLAIM_IN_PROGRESS);
+		epc_page->flags &= ~SGX_EPC_PAGE_RECLAIM_FLAGS;
 
 		sgx_free_epc_page(epc_page);
 	}
@@ -501,6 +503,7 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void)
 /**
  * sgx_record_epc_page() - Add a page to the LRU tracking
  * @page:	EPC page
+ * @flags:	Reclaim flags for the page.
  *
  * Mark a page with the specified flags and add it to the appropriate
  * (un)reclaimable list.
@@ -530,18 +533,16 @@ void sgx_record_epc_page(struct sgx_epc_page *page, unsigned long flags)
 int sgx_drop_epc_page(struct sgx_epc_page *page)
 {
 	spin_lock(&sgx_global_lru.lock);
-	if (page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED) {
-		/* The page is being reclaimed. */
-		if (page->flags & SGX_EPC_PAGE_RECLAIM_IN_PROGRESS) {
-			spin_unlock(&sgx_global_lru.lock);
-			return -EBUSY;
-		}
-
-		page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
+	if ((page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED) &&
+	    (page->flags & SGX_EPC_PAGE_RECLAIM_IN_PROGRESS)) {
+		spin_unlock(&sgx_global_lru.lock);
+		return -EBUSY;
 	}
 	list_del(&page->list);
 	spin_unlock(&sgx_global_lru.lock);
 
+	page->flags &= ~SGX_EPC_PAGE_RECLAIM_FLAGS;
+
 	return 0;
 }
 
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 29c0981d6310..f3fc027f7cd0 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -32,8 +32,14 @@
 #define SGX_EPC_PAGE_KVM_GUEST		BIT(2)
 /* page flag to indicate reclaim is in progress */
 #define SGX_EPC_PAGE_RECLAIM_IN_PROGRESS BIT(3)
+#define SGX_EPC_PAGE_ENCLAVE		BIT(4)
+#define SGX_EPC_PAGE_VERSION_ARRAY	BIT(5)
+#define SGX_EPC_PAGE_ENCLAVE_RECLAIMABLE (SGX_EPC_PAGE_ENCLAVE | \
+					  SGX_EPC_PAGE_RECLAIMER_TRACKED)
 #define SGX_EPC_PAGE_RECLAIM_FLAGS	(SGX_EPC_PAGE_RECLAIMER_TRACKED | \
-					 SGX_EPC_PAGE_RECLAIM_IN_PROGRESS)
+					 SGX_EPC_PAGE_RECLAIM_IN_PROGRESS | \
+					 SGX_EPC_PAGE_ENCLAVE | \
+					 SGX_EPC_PAGE_VERSION_ARRAY)
 
 struct sgx_epc_page {
 	unsigned int section;
-- 
2.37.3

