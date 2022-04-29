Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A1C515546
	for <lists+cgroups@lfdr.de>; Fri, 29 Apr 2022 22:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380603AbiD2UPb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Apr 2022 16:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345432AbiD2UPT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Apr 2022 16:15:19 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B2C3FBDA
        for <cgroups@vger.kernel.org>; Fri, 29 Apr 2022 13:11:51 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id s18-20020a17090aa11200b001d92f7609e8so4417085pjp.3
        for <cgroups@vger.kernel.org>; Fri, 29 Apr 2022 13:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=S3BBsZ5bvk4uzoCkIECYzRGc2TYJKfjLopd3GTSDAKA=;
        b=jyU87f8rJUN/0hbg4f3kdULDqmUiyc07Xb66s8cBmC8eSW5afxPVORIXgO/XcbFugu
         /GO6FtfJ4ZPnIibnkDPCd2vWdazZzlWxhMF1+MfgeVHE4EB8soDI4WiD7pxUHc0XysjZ
         dz0NPsguoIx0yCM0GzW+6AJFD3eMtBn5IljqCyl24S9cni2H7/qF97uyykmSQ8zzR3qj
         0ctQn1mlUvVg2EZJl93vg7f3fTcTbPn8ws29rj4RPyM04s2wTJC2/9P5OL5vwTLWBxg5
         QDDNee7lmxpZqa2y/Fn8/pPEocI38Oecy4dHL012AY61PD0PXJ/gQDtUls02A2N8uheX
         E/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S3BBsZ5bvk4uzoCkIECYzRGc2TYJKfjLopd3GTSDAKA=;
        b=n8NPGPfOPBoAR5BOuavzmmQCmHbnUJ6XqRyuR4Q81G5W5u/0gkCfiF6DiLOoK5dW7X
         nDGluSVwBSmGrT73Lb4GGKYVJICzdldzK3EH1dYesmUiKV1Epkimi5uJprqMgsprGj+o
         CXxuUd0LMs1OK16VhBULNOlmEAMGCQ8RzJsxQ2OuIXktA6xct3U5235Rl4C6Fe26aEfl
         ou8HrT/3+/HK5rIGg9Tn6lXaiLuib7v/dJgieP+0Kuueb+uzZBT/Q4NZvlRo7zXP9zr6
         PtJxiN5miMs9DTmUb3LVZAXrNT9zlbZezn2UhZ4xp2wXMPwB4iyAyMpLPZ999/QXylGg
         sXVA==
X-Gm-Message-State: AOAM533JfNqI04CtnP3x2Tcc1fPLOTYVCtskjntWj7CJTB8d1t8Z9DMk
        cjyeaApqd6vscdWGVogk4TrywRfzXT236zhK
X-Google-Smtp-Source: ABdhPJxOmVuJGvLk2Hjh+EQ9JUFzd7qmz4ZeddVRcuaWheP9plljXX7Xz37I8NLuX36SAI5J9foHUODTgkzaf7D4
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:1411:b0:4fd:e594:fac0 with
 SMTP id l17-20020a056a00141100b004fde594fac0mr831484pfu.79.1651263110818;
 Fri, 29 Apr 2022 13:11:50 -0700 (PDT)
Date:   Fri, 29 Apr 2022 20:11:31 +0000
In-Reply-To: <20220429201131.3397875-1-yosryahmed@google.com>
Message-Id: <20220429201131.3397875-5-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220429201131.3397875-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v4 4/4] KVM: arm64/mmu: count KVM s2 mmu usage in secondary
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
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Count the pages used by KVM in arm64 for stage2 mmu in secondary pagetable
stats.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 arch/arm64/kvm/mmu.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 53ae2c0640bc..fc5030307cce 100644
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
+		kvm_account_pgtable_pages(virt, +1);
+	return virt;
 }
 
 static void *kvm_host_zalloc_pages_exact(size_t size)
@@ -102,6 +106,20 @@ static void *kvm_host_zalloc_pages_exact(size_t size)
 	return alloc_pages_exact(size, GFP_KERNEL_ACCOUNT | __GFP_ZERO);
 }
 
+static void *kvm_s2_zalloc_pages_exact(size_t size)
+{
+	void *virt = kvm_host_zalloc_pages_exact(size);
+	if (virt)
+		kvm_account_pgtable_pages(virt, +(size >> PAGE_SHIFT));
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
@@ -112,6 +130,15 @@ static void kvm_host_put_page(void *addr)
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
@@ -603,10 +630,10 @@ static int get_user_mapping_size(struct kvm *kvm, u64 addr)
 
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
2.36.0.464.gb9c8b46e94-goog

