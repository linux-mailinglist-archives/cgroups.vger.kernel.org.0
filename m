Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC907513E5
	for <lists+cgroups@lfdr.de>; Thu, 13 Jul 2023 01:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjGLXCO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jul 2023 19:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjGLXCG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jul 2023 19:02:06 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31BA18E;
        Wed, 12 Jul 2023 16:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689202925; x=1720738925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YaqmO5zwAAno/VG9svXY8o2blO0PZnu2ossyoP+/A04=;
  b=MDlDClxbT7f5pTgQZSoVCz2ncGXd+K+B4CivkTQP7LUKcRiNiPm7YG2G
   nxoDozHPrgxATZjgyZ9fq0bKEqgX41Ff02j6UTKPZ5e/ieD3GsulLB0Et
   tLkx9jq2hZU8ngPPpiOMgUVAdR74l/ASxvRAMeSWStmkOeuWBojENXV/E
   GvGsb6hBbUK+/tn0SICu1kRmh1O5i9j9o+jjqCIg+kB6FCiRy1wMjMpv9
   qHt0I7WdbY+kz2FUC51w5Pog4lJYBvYz9At7K67rCczsHC1qs5+KALSvk
   gMntWZYN0C9Hr/67kJbqlx5bLnqb6AyB4+bzEcijQCaBeJVysG4hm6UoR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="428773851"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="428773851"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 16:02:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="835338586"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="835338586"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jul 2023 16:02:04 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     kai.huang@intel.com, reinette.chatre@intel.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com
Subject: [PATCH v3 02/28] x86/sgx: Add EPC page flags to identify owner type
Date:   Wed, 12 Jul 2023 16:01:36 -0700
Message-Id: <20230712230202.47929-3-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230712230202.47929-1-haitao.huang@linux.intel.com>
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Two types of owners, 'sgx_encl' for VA pages and 'sgx_encl_page' for other,
can be stored in the union field in sgx_epc_page struct introduced in the
previous patch.

When cgroup OOM support is added in a later patch, the owning enclave of a
page will need to be identified. Retrieving the sgx_encl struct from a
sgx_epc_page will be different if the page is a VA page vs. other enclave
pages.

Add 2 flags which will identify the type of the owner and apply them
accordingly to newly allocated pages.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>

V3:
- Renamed the flags to clarify they are used to identify the type
of the owner.
---
 arch/x86/kernel/cpu/sgx/encl.c  | 4 ++++
 arch/x86/kernel/cpu/sgx/ioctl.c | 4 ++++
 arch/x86/kernel/cpu/sgx/sgx.h   | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 98e1086eab07..3bc2f95b1da2 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -252,6 +252,7 @@ static struct sgx_encl_page *__sgx_encl_load_page(struct sgx_encl *encl,
 		epc_page = sgx_encl_eldu(&encl->secs, NULL);
 		if (IS_ERR(epc_page))
 			return ERR_CAST(epc_page);
+		epc_page->flags |= SGX_EPC_OWNER_ENCL_PAGE;
 	}
 
 	epc_page = sgx_encl_eldu(entry, encl->secs.epc_page);
@@ -260,6 +261,7 @@ static struct sgx_encl_page *__sgx_encl_load_page(struct sgx_encl *encl,
 
 	encl->secs_child_cnt++;
 	sgx_mark_page_reclaimable(entry->epc_page);
+	entry->epc_page->flags |= SGX_EPC_OWNER_ENCL_PAGE;
 
 	return entry;
 }
@@ -379,6 +381,7 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
 	encl->secs_child_cnt++;
 
 	sgx_mark_page_reclaimable(encl_page->epc_page);
+	encl_page->epc_page->flags |= SGX_EPC_OWNER_ENCL_PAGE;
 
 	phys_addr = sgx_get_epc_phys_addr(epc_page);
 	/*
@@ -1235,6 +1238,7 @@ struct sgx_epc_page *sgx_alloc_va_page(struct sgx_encl *encl, bool reclaim)
 		sgx_encl_free_epc_page(epc_page);
 		return ERR_PTR(-EFAULT);
 	}
+	epc_page->flags |= SGX_EPC_OWNER_ENCL;
 
 	return epc_page;
 }
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index fa8c3f32ccf6..fe3e89cf013f 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -113,6 +113,8 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 	encl->attributes = secs->attributes;
 	encl->attributes_mask = SGX_ATTR_UNPRIV_MASK;
 
+	encl->secs.epc_page->flags |= SGX_EPC_OWNER_ENCL_PAGE;
+
 	/* Set only after completion, as encl->lock has not been taken. */
 	set_bit(SGX_ENCL_CREATED, &encl->flags);
 
@@ -323,6 +325,7 @@ static int sgx_encl_add_page(struct sgx_encl *encl, unsigned long src,
 	}
 
 	sgx_mark_page_reclaimable(encl_page->epc_page);
+	encl_page->epc_page->flags |= SGX_EPC_OWNER_ENCL_PAGE;
 	mutex_unlock(&encl->lock);
 	mmap_read_unlock(current->mm);
 	return ret;
@@ -977,6 +980,7 @@ static long sgx_enclave_modify_types(struct sgx_encl *encl,
 			mutex_lock(&encl->lock);
 
 			sgx_mark_page_reclaimable(entry->epc_page);
+			entry->epc_page->flags |= SGX_EPC_OWNER_ENCL_PAGE;
 		}
 
 		/* Change EPC type */
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index dc1cbcfcf2d4..f6e3c5810eef 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -29,6 +29,12 @@
 /* Pages on free list */
 #define SGX_EPC_PAGE_IS_FREE		BIT(1)
 
+/* flag for pages owned by a sgx_encl_page */
+#define SGX_EPC_OWNER_ENCL_PAGE		BIT(3)
+
+/* flag for pages owned by a sgx_encl struct */
+#define SGX_EPC_OWNER_ENCL		BIT(4)
+
 struct sgx_epc_page {
 	unsigned int section;
 	u16 flags;
-- 
2.25.1

