Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CED55F0E3
	for <lists+cgroups@lfdr.de>; Wed, 29 Jun 2022 00:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiF1WKB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Jun 2022 18:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiF1WJw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Jun 2022 18:09:52 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40B8344FA
        for <cgroups@vger.kernel.org>; Tue, 28 Jun 2022 15:09:50 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31bf3674d86so32980287b3.5
        for <cgroups@vger.kernel.org>; Tue, 28 Jun 2022 15:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gnqIHh9MJ79JR8UHARjL1RMMQDUE9yqN/1O215pAM3E=;
        b=eXguEcbgPyavlFpFOa1EXxahxW4srMGJ+98b4fGFkzQpEbd3YWNtmcD67PovTdc4qA
         fXnRa14oxMCR4UzPA0Rb69W3dduRCCg0msVdImAHNCCE0uDoC3mW7NalrpLVU3hHsOy9
         koYlPCtWay2m9JrKZUWMOsdgiToa/uk85soHL8fXEJO2p2w5GSqWn2DoRSdBc4YiKjuw
         wiArVtT3yDZqnyEvlczLci1xDNiA+fCBpfkNXsG99ycgHGB7/+E389xZxGCvQYTgsHR8
         5q1viEr/xOHOxyNWdhiNTKu9+6+r+bupS/AqK5Zk2ocnv1T5fbQgq4oIep2tspVynMLG
         y+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gnqIHh9MJ79JR8UHARjL1RMMQDUE9yqN/1O215pAM3E=;
        b=NVx24u81mCj75y38GHrJXw/CfyrkyrGIsSLiAyBSNP/A5EZQ/5j81vCDWRrtejyAg3
         X4A+eCmDmMFJrfa1lC0FL4rfWHiOjkc5jTlZbZk32FJF7HPb3lN2LRjCrjpdCap3LoSk
         ESBBVAbvFPRMCWdg3Xx9au39d8QrKB9IObcQwvi69hfCZYHOoCcZIHH5KsocOmB+jz2O
         gv1Nlhk753lTl4CCone9iRCDQbKh62ExjpIsAFuPEov5oxUPmXrqlxVDvfFA6eivySsA
         5ngrZRPs6Yrou3Kjvj7ZPYvOtQaBGA9j/JRPf69Gd1bfthyTYjrGt2aacYyPHdYnO9Fu
         xDPA==
X-Gm-Message-State: AJIora/wmUtUn0T2t8jpG6yU+bODeFdAca1EMPSpZqDHrRISCTuWC9YW
        xTLAHFKeZu0kZNMi06/5icjV0IBjrIRtgmyW
X-Google-Smtp-Source: AGRyM1umi2UgIYQTv46Vc6mzeFvchYWcjhInaiO2bwyjS9I41B8ANnPYWxN9MPXv8KH+kwsaKoJa5m5b80k5y5ta
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a25:9f0a:0:b0:66c:8ecd:9d18 with SMTP
 id n10-20020a259f0a000000b0066c8ecd9d18mr18915199ybq.345.1656454190140; Tue,
 28 Jun 2022 15:09:50 -0700 (PDT)
Date:   Tue, 28 Jun 2022 22:09:38 +0000
In-Reply-To: <20220628220938.3657876-1-yosryahmed@google.com>
Message-Id: <20220628220938.3657876-5-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220628220938.3657876-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v6 4/4] KVM: arm64/mmu: count KVM s2 mmu usage in secondary
 pagetable stats
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Oliver Upton <oupton@google.com>
Cc:     Huang@google.com, Shaoqin <shaoqin.huang@intel.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>,
        Oliver Upton <oliver.upton@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Count the pages used by KVM in arm64 for stage2 mmu in memory stats
under secondary pagetable stats (e.g. "SecPageTables" in /proc/meminfo)
to give better visibility into the memory consumption of KVM mmu in a
similar way to how normal user page tables are accounted.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/mmu.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 87f1cd0df36ea..9d5a8e93d2fdc 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -92,9 +92,13 @@ static bool kvm_is_device_pfn(unsigned long pfn)
 static void *stage2_memcache_zalloc_page(void *arg)
 {
 	struct kvm_mmu_memory_cache *mc = arg;
+	void *virt;
 
 	/* Allocated with __GFP_ZERO, so no need to zero */
-	return kvm_mmu_memory_cache_alloc(mc);
+	virt = kvm_mmu_memory_cache_alloc(mc);
+	if (virt)
+		kvm_account_pgtable_pages(virt, 1);
+	return virt;
 }
 
 static void *kvm_host_zalloc_pages_exact(size_t size)
@@ -102,6 +106,21 @@ static void *kvm_host_zalloc_pages_exact(size_t size)
 	return alloc_pages_exact(size, GFP_KERNEL_ACCOUNT | __GFP_ZERO);
 }
 
+static void *kvm_s2_zalloc_pages_exact(size_t size)
+{
+	void *virt = kvm_host_zalloc_pages_exact(size);
+
+	if (virt)
+		kvm_account_pgtable_pages(virt, (size >> PAGE_SHIFT));
+	return virt;
+}
+
+static void kvm_s2_free_pages_exact(void *virt, size_t size)
+{
+	kvm_account_pgtable_pages(virt, -(size >> PAGE_SHIFT));
+	free_pages_exact(virt, size);
+}
+
 static void kvm_host_get_page(void *addr)
 {
 	get_page(virt_to_page(addr));
@@ -112,6 +131,15 @@ static void kvm_host_put_page(void *addr)
 	put_page(virt_to_page(addr));
 }
 
+static void kvm_s2_put_page(void *addr)
+{
+	struct page *p = virt_to_page(addr);
+	/* Dropping last refcount, the page will be freed */
+	if (page_count(p) == 1)
+		kvm_account_pgtable_pages(addr, -1);
+	put_page(p);
+}
+
 static int kvm_host_page_count(void *addr)
 {
 	return page_count(virt_to_page(addr));
@@ -625,10 +653,10 @@ static int get_user_mapping_size(struct kvm *kvm, u64 addr)
 
 static struct kvm_pgtable_mm_ops kvm_s2_mm_ops = {
 	.zalloc_page		= stage2_memcache_zalloc_page,
-	.zalloc_pages_exact	= kvm_host_zalloc_pages_exact,
-	.free_pages_exact	= free_pages_exact,
+	.zalloc_pages_exact	= kvm_s2_zalloc_pages_exact,
+	.free_pages_exact	= kvm_s2_free_pages_exact,
 	.get_page		= kvm_host_get_page,
-	.put_page		= kvm_host_put_page,
+	.put_page		= kvm_s2_put_page,
 	.page_count		= kvm_host_page_count,
 	.phys_to_virt		= kvm_host_va,
 	.virt_to_phys		= kvm_host_pa,
-- 
2.37.0.rc0.161.g10f37bed90-goog

