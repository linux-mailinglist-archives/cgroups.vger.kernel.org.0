Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B597A581948
	for <lists+cgroups@lfdr.de>; Tue, 26 Jul 2022 20:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239012AbiGZSED (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Jul 2022 14:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiGZSEC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Jul 2022 14:04:02 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F74C27CC3
        for <cgroups@vger.kernel.org>; Tue, 26 Jul 2022 11:04:02 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id b9so13899737pfp.10
        for <cgroups@vger.kernel.org>; Tue, 26 Jul 2022 11:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jhdzRZUAOMTnCV/vW7pBqgsIJIfjNF/pYz/pr69nELI=;
        b=ptd/st7Qx1CEBd6nXVmofsETHlqEG5YHpXzAHoHWMHaxaLqLQRwhFD8DrqTGh313HP
         IhmbQkRu0orlHojxKg773kXGBU90oYKT/i2R8RIWnvFI/6XWjOJwk/NLwViv8Eohzc71
         0u1CxuXzpRO+SKGj4rghNIk24TUgiK6N5EMVsSWyZucFXHEwqrREOemBmRGcO21GlJv+
         BHPELPoCCxRkiXuj0q4tx3KOjfEFuVK8aaztJ92oE13l2AqbgmCf3A+ZhaLe8cNklHQ/
         gZtTgJkayqLParwE71HzxpR93H5vfYmTwDBbX/RNcN9pr066yekhsOaOlX87QwoQCIMQ
         U+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jhdzRZUAOMTnCV/vW7pBqgsIJIfjNF/pYz/pr69nELI=;
        b=pWVY3apyPC8UcyWKZLPrfLzSbhjllhvtSC3I8WmXBdpaM1o4RmNybLhAtW5g3pIl5T
         NfRUew1SV/7e2NJMx/dMIGGi3aBHuECAsRkKU7MTcF1XqOgHZD7VBOzfVUSp2sZbvGU+
         rwh69eutRSUzK64jlBQNXHsRCUtMgaSiX9dTW83PZ2A+7m+IidP9khaZuLFJOURa5Ei2
         9GPo+9g2MxiJpovW54g/DV2iA4nuRsBc3+/yIOT7Dw7ZKUN8aKBDGwmDgk/6AHlkJ15I
         uq0fbgQ+xCYPiJ+w4A43D3l+gY4smRZcH8WvsK1VkbYU0T6hjqZR600lerFAZqfrsteF
         M3TQ==
X-Gm-Message-State: AJIora+jTnYilTGbN2Lw7O+I8FG6kBpljfk33Ck28A5hHqljCIz3N6Eg
        xoIwdGmez4ZBRTTzAR5nW7otZg==
X-Google-Smtp-Source: AGRyM1uKR6/hOW723JGGrSJD19noCDp0+vmsYlXYClvLLQpEtHJHtnV8BUou5cQTx2omdbkUrVjS2Q==
X-Received: by 2002:a05:6a00:1c54:b0:52b:a70e:8207 with SMTP id s20-20020a056a001c5400b0052ba70e8207mr18313321pfw.48.1658858641379;
        Tue, 26 Jul 2022 11:04:01 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902860400b0016be0d5483asm11848682plo.252.2022.07.26.11.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 11:04:00 -0700 (PDT)
Date:   Tue, 26 Jul 2022 18:03:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Oliver Upton <oupton@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4 3/4] KVM: x86/mmu: count KVM mmu usage in secondary
 pagetable stats.
Message-ID: <YuAsjZbnCN/PrNKw@google.com>
References: <20220429201131.3397875-1-yosryahmed@google.com>
 <20220429201131.3397875-4-yosryahmed@google.com>
 <YtsPk5+hZNMEwT0c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtsPk5+hZNMEwT0c@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 22, 2022, Mingwei Zhang wrote:
> On Fri, Apr 29, 2022, Yosry Ahmed wrote:
> > Count the pages used by KVM mmu on x86 for in secondary pagetable stats.
> > 
> > For the legacy mmu, accounting pagetable stats is combined KVM's
> > existing for mmu pages in newly introduced kvm_[un]account_mmu_page()
> > helpers.
> > 
> > For tdp mmu, introduce new tdp_[un]account_mmu_page() helpers. That
> > combines accounting pagetable stats with the tdp_mmu_pages counter
> > accounting.
> > 
> > tdp_mmu_pages counter introduced in this series [1]. This patch was
> > rebased on top of the first two patches in that series.
> > 
> > [1]https://lore.kernel.org/lkml/20220401063636.2414200-1-mizhang@google.com/
> > 
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> 
> It looks like there are two metrics for mmu in x86: one for shadow mmu
> and the other for TDP mmu. Is there any plan to merge them together?

There aren't two _separate_ metrics per se, rather that the TDP MMU (intentionally)
doesn't honor KVM_SET_NR_MMU_PAGES, nor does it play nice the the core mm shrinkers.
Thus, the TDP MMU doesn't udpate kvm_mod_used_mmu_pages(), which feeds into both of
those things.

Long term, I don't think the TDP MMU will ever honor KVM_SET_NR_MMU_PAGES.  That
particular knob predates proper integration with memcg and probably should be
deprecated.

As for supporting shrinkers in the TDP MMU, it's unclear whether or not that's truly
necessary.  And until mmu_shrink_scan() is made a _lot_ smarter, it's somewhat of a
moot point because KVM's shrinker implementation is just too naive for it to be a net
positive, e.g. it tends to zap upper level entries and wipe out large swaths of KVM's
page tables.  KVM_SET_NR_MMU_PAGES uses the same naive algorithm, so it's not any better.
