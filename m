Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBFE5A30F9
	for <lists+cgroups@lfdr.de>; Fri, 26 Aug 2022 23:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344932AbiHZV0O (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 Aug 2022 17:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344686AbiHZV0M (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 Aug 2022 17:26:12 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4244CA30
        for <cgroups@vger.kernel.org>; Fri, 26 Aug 2022 14:26:10 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e13so2277712wrm.1
        for <cgroups@vger.kernel.org>; Fri, 26 Aug 2022 14:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=6UsE1Ljxz5h0xq3FFSdwmgCBOa2/vJlV8vw/uQpbLSQ=;
        b=SWFjPL7/UKZ4cZdo+JI7Bm2LG8Zc5kFuduxCLX8+HwW0QibBTetn/y2E41mk+x5paO
         JIzNbPVmE/Ekp/CzgnD2lphM56nu+cGQgvXiZ7OsW7wiDezSmmZwBWSBekAXujhOa0V0
         A/+blidel2lSXN57C4fj+Mly1CkPB7JfH8fuOLQhwEdLJ5xIgzgdP41dV/v/Oq6fs9v0
         LJnhM8cgZlGCe5bOOQ2JX0Rjt2uG1lGNw0/ekwO8fuwTjSJ6hE1BnAi1yzYcJ9yAPRpa
         cvbehGZsoN5xor3oKmd+C683+iy9LUhdk3WtP7wGbPJfzVQ4Bu4/vzWsAhyUKcA6bwn9
         MK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=6UsE1Ljxz5h0xq3FFSdwmgCBOa2/vJlV8vw/uQpbLSQ=;
        b=lsSR2KItAOcbjVDi22pgfyty5m816D7k0JA2G72HgmPWXRjfXEhN0CqTsuprD4sg6y
         v+kdp7emsZ+q0YbBTc3uPF2MTSVINcu/pgl+tplvxJb3x/SnxJftvrYxDmfk0feSnaO/
         J+rP50EF16eejTmGdzpS8YSVPZTI2B5yEYpuObL04vLhWjIcHEKbRVd6HF38vRzbSKPZ
         pdhtwbalT820za86IGQH5VqisoD3ynJGPmKwJKp0Jk/b+FbGvLUGigDCIXuqupQfNlA5
         aK/X+p8gMIYtFWUiSV8gVHm4MRr1bOK+6TvLdUcazJpp4enrVd7ls6BJlmTR5ThmFst9
         WCrA==
X-Gm-Message-State: ACgBeo0QIqCz0jgjOswTqEVTbOsqkntGk0b3b7zER0Ck74zDtk0yassl
        hg9EiQNc8Kc+D6kGsYwVwZ6Sr0B2mm+rXHfCxqb/QA==
X-Google-Smtp-Source: AA6agR4Hp1hENOCVVKgBgmda4N9xAiLK7ePDAp+2BKobakE/3YgGIHlFS8hcVYDNGA2YUpMSmk/d68XvTzxr+wDrl7o=
X-Received: by 2002:a5d:6d0c:0:b0:225:4ff9:7e67 with SMTP id
 e12-20020a5d6d0c000000b002254ff97e67mr776077wrq.534.1661549168831; Fri, 26
 Aug 2022 14:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220823004639.2387269-1-yosryahmed@google.com>
 <20220823004639.2387269-4-yosryahmed@google.com> <Ywkq8HYyTI1eStSO@google.com>
In-Reply-To: <Ywkq8HYyTI1eStSO@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 26 Aug 2022 14:25:32 -0700
Message-ID: <CAJD7tka4w059gZOJJnZj2zodQ7CGCFzKGbKEtt9cE2XP5GF73A@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] KVM: x86/mmu: count KVM mmu usage in secondary
 pagetable stats.
To:     Sean Christopherson <seanjc@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
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
        Oliver Upton <oupton@google.com>, Huang@google.com,
        Shaoqin <shaoqin.huang@intel.com>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Aug 26, 2022 at 1:20 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Tue, Aug 23, 2022, Yosry Ahmed wrote:
> > Count the pages used by KVM mmu on x86 in memory stats under secondary
> > pagetable stats (e.g. "SecPageTables" in /proc/meminfo) to give better
> > visibility into the memory consumption of KVM mmu in a similar way to
> > how normal user page tables are accounted.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > Reviewed-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/mmu/mmu.c     | 16 ++++++++++++++--
> >  arch/x86/kvm/mmu/tdp_mmu.c | 12 ++++++++++++
> >  2 files changed, 26 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index e418ef3ecfcb..4d38e4eba772 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -1665,6 +1665,18 @@ static inline void kvm_mod_used_mmu_pages(struct kvm *kvm, long nr)
> >       percpu_counter_add(&kvm_total_used_mmu_pages, nr);
> >  }
> >
> > +static void kvm_account_mmu_page(struct kvm *kvm, struct kvm_mmu_page *sp)
> > +{
> > +     kvm_mod_used_mmu_pages(kvm, +1);
> > +     kvm_account_pgtable_pages((void *)sp->spt, +1);
> > +}
> > +
> > +static void kvm_unaccount_mmu_page(struct kvm *kvm, struct kvm_mmu_page *sp)
> > +{
> > +     kvm_mod_used_mmu_pages(kvm, -1);
> > +     kvm_account_pgtable_pages((void *)sp->spt, -1);
> > +}
>
> Hrm, this is causing build on x86 issues for me.  AFAICT, modpost doesn't detect
> that this creates a new module dependency on __mod_lruvec_page_state() and so doesn't
> refresh vmlinux.symvers.
>
>   ERROR: modpost: "__mod_lruvec_page_state" [arch/x86/kvm/kvm.ko] undefined!
>   make[2]: *** [scripts/Makefile.modpost:128: modules-only.symvers] Error 1
>   make[1]: *** [Makefile:1769: modules] Error 2
>   make[1]: *** Waiting for unfinished jobs....
>   Kernel: arch/x86/boot/bzImage is ready  (#128)
>   make[1]: Leaving directory '/usr/local/google/home/seanjc/build/kernel/vm'
>   make: *** [Makefile:222: __sub-make] Error 2
>
> Both gcc and clang yield the same behavior, so I doubt it's the compiler doing
> something odd.  Cleaning the build makes the problem go away, but that's a poor
> band-aid.
>
> If I squash this with the prior patch that adds kvm_account_pgtable_pages() to
> kvm_host.h, modpost detects the need to refresh and all is well.
>
> Given that ARM doesn't support building KVM as a module, i.e. can't run afoul
> of whatever modpost weirdness I'm hitting, I'm inclined to squash this with the
> previous patch and punt on the modpost issue so that we can get this merged.
>
> Any objections?  Or thoughts on what's going wrong?

I am not familiar at all with modpost so I have no idea what's going
wrong, but I have no problem with squashing the patches if you think
this works best.
