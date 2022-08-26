Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41ABA5A3062
	for <lists+cgroups@lfdr.de>; Fri, 26 Aug 2022 22:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbiHZUUI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 Aug 2022 16:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiHZUUH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 Aug 2022 16:20:07 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE7732EFB
        for <cgroups@vger.kernel.org>; Fri, 26 Aug 2022 13:20:04 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 199so2502348pfz.2
        for <cgroups@vger.kernel.org>; Fri, 26 Aug 2022 13:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Yy3h91/LZL0yMN3Y+gPnYCc8uzqqu6+PEMw/uYOkvrQ=;
        b=QI2iqRq9/94E6zl7r9mZw4F+7Daqhq8WErAzs7MCXRZvrz4GpEbY7Dstc+ZZ2JEyb2
         q0xcA8xKqPk01eYmQLRlBIm9I9enL9gle1pvxTgv3hEVqdUw5C4cSi7lwuKtIjcxf5KZ
         MNemfeMqo0zzfRvxEdPkaXJq+V0CXBJoNhrKZhmH2a/6fEvyddf2Pci6F7c3hz5Uh2KZ
         p9XfmAZB3QDZNhI51WLuUsrX5a34H43X0h0MgNESMM7lb3mZRO5lRiW8QfXtTjK0Iio8
         Bx/faeNKIHAHpdLZt2Qt47/Jnw19TxwGoB6eZJ5V4qbulyod0s+zhEZ6nWzqexbUBQl1
         6MGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Yy3h91/LZL0yMN3Y+gPnYCc8uzqqu6+PEMw/uYOkvrQ=;
        b=eveszQLhDonaP0wv6EZsUm0xj9ikUg4oOw+gzAB21/0x3fqJKRpQ8IbnkPRFqoVi8c
         fOpGT+ThuQBnHwTVMVUXuAGJhViffgTJQpA9uz0YIDlIM9DrKKdxVb3z3k6sz98dxDrO
         /juj9tN5w5ls74WVwRfbJNb5J8Y4KzKeOyDm87KiaNd6o0mOIPoDT+2QwgtmNbmhJfZV
         vaBGBuI6EdRPmKp2WUIPs9J7psidZ2evmAaYx3YChJVpIwD+KTQVRiiv02PfC2mEuZWY
         d2zdnr7jmZlwBJPm/e/5RiLoAbdVn0VLb1tzN66woVA8xxdg/PejfT+hBcmYMrM3i0ry
         k3PQ==
X-Gm-Message-State: ACgBeo2SkHaCOrkEhfHVVl0Ln8npVs7IN63RVYCrecYqD9tNg+Pkk89g
        F6gBBdPxUavLoZBthjC2e94VJA==
X-Google-Smtp-Source: AA6agR5n02jhbK1nhPu/jZhpJFX2d1euSOaYUkGIxcjNNi+QlVmGNtQ1h1+3uTxVaQGYEwd8dNh3mw==
X-Received: by 2002:a05:6a00:4147:b0:52e:2d56:17c8 with SMTP id bv7-20020a056a00414700b0052e2d5617c8mr5478964pfb.51.1661545204289;
        Fri, 26 Aug 2022 13:20:04 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id x21-20020a63f715000000b0042b117e8bf8sm1843703pgh.23.2022.08.26.13.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 13:20:03 -0700 (PDT)
Date:   Fri, 26 Aug 2022 20:20:00 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
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
        Shaoqin <shaoqin.huang@intel.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v7 3/4] KVM: x86/mmu: count KVM mmu usage in secondary
 pagetable stats.
Message-ID: <Ywkq8HYyTI1eStSO@google.com>
References: <20220823004639.2387269-1-yosryahmed@google.com>
 <20220823004639.2387269-4-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823004639.2387269-4-yosryahmed@google.com>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 23, 2022, Yosry Ahmed wrote:
> Count the pages used by KVM mmu on x86 in memory stats under secondary
> pagetable stats (e.g. "SecPageTables" in /proc/meminfo) to give better
> visibility into the memory consumption of KVM mmu in a similar way to
> how normal user page tables are accounted.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Reviewed-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c     | 16 ++++++++++++++--
>  arch/x86/kvm/mmu/tdp_mmu.c | 12 ++++++++++++
>  2 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index e418ef3ecfcb..4d38e4eba772 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -1665,6 +1665,18 @@ static inline void kvm_mod_used_mmu_pages(struct kvm *kvm, long nr)
>  	percpu_counter_add(&kvm_total_used_mmu_pages, nr);
>  }
>  
> +static void kvm_account_mmu_page(struct kvm *kvm, struct kvm_mmu_page *sp)
> +{
> +	kvm_mod_used_mmu_pages(kvm, +1);
> +	kvm_account_pgtable_pages((void *)sp->spt, +1);
> +}
> +
> +static void kvm_unaccount_mmu_page(struct kvm *kvm, struct kvm_mmu_page *sp)
> +{
> +	kvm_mod_used_mmu_pages(kvm, -1);
> +	kvm_account_pgtable_pages((void *)sp->spt, -1);
> +}

Hrm, this is causing build on x86 issues for me.  AFAICT, modpost doesn't detect
that this creates a new module dependency on __mod_lruvec_page_state() and so doesn't
refresh vmlinux.symvers.

  ERROR: modpost: "__mod_lruvec_page_state" [arch/x86/kvm/kvm.ko] undefined!
  make[2]: *** [scripts/Makefile.modpost:128: modules-only.symvers] Error 1
  make[1]: *** [Makefile:1769: modules] Error 2
  make[1]: *** Waiting for unfinished jobs....
  Kernel: arch/x86/boot/bzImage is ready  (#128)
  make[1]: Leaving directory '/usr/local/google/home/seanjc/build/kernel/vm'
  make: *** [Makefile:222: __sub-make] Error 2

Both gcc and clang yield the same behavior, so I doubt it's the compiler doing
something odd.  Cleaning the build makes the problem go away, but that's a poor
band-aid.

If I squash this with the prior patch that adds kvm_account_pgtable_pages() to
kvm_host.h, modpost detects the need to refresh and all is well.

Given that ARM doesn't support building KVM as a module, i.e. can't run afoul
of whatever modpost weirdness I'm hitting, I'm inclined to squash this with the
previous patch and punt on the modpost issue so that we can get this merged.

Any objections?  Or thoughts on what's going wrong?
