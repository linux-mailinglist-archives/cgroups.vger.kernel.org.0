Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC737ABD63
	for <lists+cgroups@lfdr.de>; Sat, 23 Sep 2023 05:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjIWDHJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Sep 2023 23:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjIWDHI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Sep 2023 23:07:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4491A7;
        Fri, 22 Sep 2023 20:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695438422; x=1726974422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bl38Qf8S1sTRN04lW2YFAodcrfy1L4fMzLvJCxC13/E=;
  b=axsybe+aDrMZ0KkfyOZE9abRzGIrB+i9eofz2fJIqTumnixBlfciEw/J
   BjAHBdIdT3EsEXyMnzw1qWyWBt7rnlOO5JOFHQnivhXm3t172kkst+HRh
   /at8+1vb/bVeCYz4vux0aBYwivGQOeh7x6jlSVc8XCoBA9QR5SJKU0YAQ
   H6WSpVD4LWUhDqnzWUgx4BtFop4FR8EaepmRI82Tcjp3rdecVL2poYJ/V
   WJJEqKo+VqNp2YhWzazf2D1/lDkd0mn70MT3WyZvxzXkAafyOsU0+C0HK
   po6BgD5azrljYiJL9G7g3R/wYC+tbmCC79Vw6q+0WyfQJVqDxyGu89eHv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="447466738"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="447466738"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 20:07:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="891048527"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="891048527"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by fmsmga001.fm.intel.com with ESMTP; 22 Sep 2023 20:06:04 -0700
From:   Haitao Huang <haitao.huang@linux.intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sohil.mehta@intel.com
Cc:     zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
        zhanb@microsoft.com, anakrish@microsoft.com,
        mikko.ylinen@linux.intel.com, yangjie@microsoft.com
Subject: [PATCH v5 03/18] x86/sgx: Add sgx_epc_lru_lists to encapsulate LRU lists
Date:   Fri, 22 Sep 2023 20:06:42 -0700
Message-Id: <20230923030657.16148-4-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230923030657.16148-1-haitao.huang@linux.intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Introduce a data structure to wrap the existing reclaimable list and its
spinlock. Each cgroup later will have one instance of this structure to
track EPC pages allocated for processes associated with the same cgroup.
Just like the global SGX reclaimer (ksgxd), an EPC cgroup reclaims pages
from the reclaimable list in this structure when its usage reaches near
its limit.

Currently, ksgxd does not track the VA, SECS pages. They are considered
as 'unreclaimable' pages that are only deallocated when their respective
owning enclaves are destroyed and all associated resources released.

When an EPC cgroup can not reclaim any more reclaimable EPC pages to
reduce its usage below its limit, the cgroup must also reclaim those
unreclaimables by killing their owning enclaves. The VA and SECS pages
later are also tracked in an 'unreclaimable' list added to this structure
to support this OOM killing of enclaves.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
V4:
- Removed unneeded comments for the spinlock and the non-reclaimables.
(Kai, Jarkko)
- Revised the commit to add introduction comments for unreclaimables and
multiple LRU lists.(Kai)
- Reordered the patches: delay all changes for unreclaimables to
later, and this one becomes the first change in the SGX subsystem.

V3:
- Removed the helper functions and revised commit messages.
---
 arch/x86/kernel/cpu/sgx/sgx.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index d2dad21259a8..018414b2abe8 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -83,6 +83,20 @@ static inline void *sgx_get_epc_virt_addr(struct sgx_epc_page *page)
 	return section->virt_addr + index * PAGE_SIZE;
 }
 
+/*
+ * Tracks EPC pages reclaimable by the reclaimer (ksgxd).
+ */
+struct sgx_epc_lru_lists {
+	spinlock_t lock;
+	struct list_head reclaimable;
+};
+
+static inline void sgx_lru_init(struct sgx_epc_lru_lists *lrus)
+{
+	spin_lock_init(&lrus->lock);
+	INIT_LIST_HEAD(&lrus->reclaimable);
+}
+
 struct sgx_epc_page *__sgx_alloc_epc_page(void);
 void sgx_free_epc_page(struct sgx_epc_page *page);
 
-- 
2.25.1

