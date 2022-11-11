Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC02626141
	for <lists+cgroups@lfdr.de>; Fri, 11 Nov 2022 19:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbiKKSgH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Nov 2022 13:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbiKKSf5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Nov 2022 13:35:57 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11CE836A8;
        Fri, 11 Nov 2022 10:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668191743; x=1699727743;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FaCcKUEIwrradxMdSEDDiScXst5sj/3Hc0SbSP7zTG4=;
  b=oD9ZN4namfYO10ahv/jbx4GWXsybj3a1b+ovASJsN3VCN23kTFkllk7k
   MCiVVyNAhGnwOvwP+G8j5/BLLz4ala+RetIwHVpb1xlRuBDrYy1iKLFqg
   DjaYHes9W0rrxXgTFZxXBantYv3/DLbX9rF23DfeZ7TSVUtMVqE4QE4ZY
   e2NWBGoP6xoK+S/hXL0d8wo/5KPN4+d9d9ypTtR/hJTGv/G18dbeXV1NW
   WmMMGLoUZ4B06F09hWN6iqdWre3qsBwEVxvKh9rR6klhIguheciVmTpcY
   nVQG8OjnjOSV+jyK9f0iyc9ODfKuJG13ZNjQ2akZywU6+EMo+b9WkUb6P
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="292050295"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="292050295"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:35:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="640089166"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="640089166"
Received: from hermesli-mobl.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.212.218.5])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:35:41 -0800
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
Subject: [PATCH 02/26] x86/sgx: Store struct sgx_encl when allocating new va pages
Date:   Fri, 11 Nov 2022 10:35:07 -0800
Message-Id: <20221111183532.3676646-3-kristen@linux.intel.com>
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

When allocating new va pages, pass the struct sgx_encl of the enclave
that is allocating the page. sgx_alloc_epc_page() will store this
value in the encl_owner field of the struct sgx_epc_page. In a later
patch, version array pages will be placed in an unreclaimable queue,
and then when the cgroup max limit is reached and there are no more
reclaimable pages and the enclave must be oom killed, all the
va pages associated with that enclave can be uncharged and freed.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/sgx/encl.c  | 5 +++--
 arch/x86/kernel/cpu/sgx/encl.h  | 2 +-
 arch/x86/kernel/cpu/sgx/ioctl.c | 2 +-
 arch/x86/kernel/cpu/sgx/sgx.h   | 2 ++
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index f40d64206ded..4eaf9d21e71b 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -1193,6 +1193,7 @@ void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr)
 
 /**
  * sgx_alloc_va_page() - Allocate a Version Array (VA) page
+ * @encl:    The enclave that this page is allocated to.
  * @reclaim: Reclaim EPC pages directly if none available. Enclave
  *           mutex should not be held if this is set.
  *
@@ -1202,12 +1203,12 @@ void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr)
  *   a VA page,
  *   -errno otherwise
  */
-struct sgx_epc_page *sgx_alloc_va_page(bool reclaim)
+struct sgx_epc_page *sgx_alloc_va_page(struct sgx_encl *encl, bool reclaim)
 {
 	struct sgx_epc_page *epc_page;
 	int ret;
 
-	epc_page = sgx_alloc_epc_page(NULL, reclaim);
+	epc_page = sgx_alloc_epc_page(encl, reclaim);
 	if (IS_ERR(epc_page))
 		return ERR_CAST(epc_page);
 
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index f94ff14c9486..831d63f80f5a 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -116,7 +116,7 @@ struct sgx_encl_page *sgx_encl_page_alloc(struct sgx_encl *encl,
 					  unsigned long offset,
 					  u64 secinfo_flags);
 void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr);
-struct sgx_epc_page *sgx_alloc_va_page(bool reclaim);
+struct sgx_epc_page *sgx_alloc_va_page(struct sgx_encl *encl, bool reclaim);
 unsigned int sgx_alloc_va_slot(struct sgx_va_page *va_page);
 void sgx_free_va_slot(struct sgx_va_page *va_page, unsigned int offset);
 bool sgx_va_page_full(struct sgx_va_page *va_page);
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index ebe79d60619f..9a1bb3c3211a 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -30,7 +30,7 @@ struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl, bool reclaim)
 		if (!va_page)
 			return ERR_PTR(-ENOMEM);
 
-		va_page->epc_page = sgx_alloc_va_page(reclaim);
+		va_page->epc_page = sgx_alloc_va_page(encl, reclaim);
 		if (IS_ERR(va_page->epc_page)) {
 			err = ERR_CAST(va_page->epc_page);
 			kfree(va_page);
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index d16a8baa28d4..efb10eacd3aa 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -39,6 +39,8 @@ struct sgx_epc_page {
 		struct sgx_encl_page *encl_owner;
 		/* Use when SGX_EPC_PAGE_KVM_GUEST set in ->flags: */
 		void __user *vepc_vaddr;
+
+		struct sgx_encl *encl;
 	};
 	struct list_head list;
 };
-- 
2.37.3

