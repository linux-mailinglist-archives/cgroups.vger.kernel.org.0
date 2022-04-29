Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14D151553C
	for <lists+cgroups@lfdr.de>; Fri, 29 Apr 2022 22:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380590AbiD2UPI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Apr 2022 16:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380587AbiD2UPH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Apr 2022 16:15:07 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7672A3DDDD
        for <cgroups@vger.kernel.org>; Fri, 29 Apr 2022 13:11:48 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id d127-20020a633685000000b003ab20e589a8so4215796pga.22
        for <cgroups@vger.kernel.org>; Fri, 29 Apr 2022 13:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HQRALrLqPLOKdX3/Qrvlj2304W4cY881g6B2XTfjhjE=;
        b=e1Gj1cFIx7qA9DjuG4CERdhHtwjjaMyqc0jE42K6DIa/HcAF7kLYbOh7A4zE3CfdpC
         MXLc5TLYF/85xAw4JqYk5Z+4VaQG+kEY5rcUmOxE6tic9A7AB/r3soW+wIKvxsx6s6sb
         dwf/GudGOtBTMTSquKo6sp/pI7w4IG3EJ9Ed+c2JR8p72budxuezZoM2UOclpII5lS61
         jLjhhkg61TxTY5Ps6VReS8PPdn/lF7OSnXOocjCyRcBRNrRTP7mhwtpcGmbPstkKa1Z3
         UjsKnboQEBlCrWAyY27GIJsYPsHmlwb5DzS1Loav7ERt/ViNzQEWA6OAJ7ojRdb9jzbP
         ysnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HQRALrLqPLOKdX3/Qrvlj2304W4cY881g6B2XTfjhjE=;
        b=TE+rTLvUv0ThMiYlJZBh+Bnj/PgK1LDTRqdoY/Btdl8xzIMzBi6hCTEqpP7Es7KUlb
         mPOfwr3o67QxUBFdugwPZrr59VT7trbNz+etIsXphYQTJDjPyGu0PL7C0EInZHFOkTLw
         SVXNI90dwGbypo4T3NPEh4z8Rkwim9ABRnhSS2ryLlJT8JfWlyNmWNGKj2QXYSFqCkeq
         DZFm+iM4+L4atqB99+vPNFzJQ5XEf2gXWuG4ocDG+zCqby72tJMTYZ4EFpFpsbgXpXQ5
         0TiOnV8YnPYWB1FRA3hJWNTTRFtQdWPx/qZECJymKaZ9S83vIpprMIQJt3PNVRyp1Ukc
         3BAw==
X-Gm-Message-State: AOAM532gHQlJ4z8uw6gTb/Gsk+WugfaubSYgiRlGOb0fFFOnPURB7/CA
        p71btIZ5LDPpOm/MiUJ1ekDa2D2P2Vjm3Plw
X-Google-Smtp-Source: ABdhPJyFiTvIOFIZYo+38It2ytGBtkvfsnlq74KMff/yRu6trFEODoofBTp8U5qgZN1B+vJQKJMiROSbmndcmE1m
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a62:87cd:0:b0:50d:bf61:3de9 with SMTP
 id i196-20020a6287cd000000b0050dbf613de9mr906362pfe.16.1651263107958; Fri, 29
 Apr 2022 13:11:47 -0700 (PDT)
Date:   Fri, 29 Apr 2022 20:11:29 +0000
In-Reply-To: <20220429201131.3397875-1-yosryahmed@google.com>
Message-Id: <20220429201131.3397875-3-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220429201131.3397875-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v4 2/4] KVM: mmu: add a helper to account memory used by KVM mmu.
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

Add a helper to account pages used by KVM for page tables in secondary
pagetable stats. This function will be used by subsequent patches in
different archs.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/kvm_host.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 252ee4a61b58..54cc4634053c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2221,6 +2221,15 @@ static inline void kvm_handle_signal_exit(struct kvm_vcpu *vcpu)
 }
 #endif /* CONFIG_KVM_XFER_TO_GUEST_WORK */
 
+/*
+ * If nr > 1, we assume virt is the address of the first page of a block of
+ * pages that were allocated together (i.e accounted together).
+ */
+static inline void kvm_account_pgtable_pages(void *virt, int nr)
+{
+	mod_lruvec_page_state(virt_to_page(virt), NR_SECONDARY_PAGETABLE, nr);
+}
+
 /*
  * This defines how many reserved entries we want to keep before we
  * kick the vcpu to the userspace to avoid dirty ring full.  This
-- 
2.36.0.464.gb9c8b46e94-goog

