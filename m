Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB04C55D488
	for <lists+cgroups@lfdr.de>; Tue, 28 Jun 2022 15:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbiF0Q3Q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Jun 2022 12:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239168AbiF0Q3P (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Jun 2022 12:29:15 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C0CB7C7
        for <cgroups@vger.kernel.org>; Mon, 27 Jun 2022 09:29:13 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q9so13828213wrd.8
        for <cgroups@vger.kernel.org>; Mon, 27 Jun 2022 09:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gq7iVePtX9OMXEUxruOPEde6hXUmiczdKpj9eXTuegY=;
        b=Ub1BAIMzdKFr+whCpBiAWhp0s8tYt12ZNPKk99qiMYNRD5+OYUzq488SqpH/xgr25t
         tP6UW3BBP+BkhP4WSdd4xXE6Ci/tsk2iyT5Bhr9RQbir03Oa/iDHCs+QNPuMohYTUcPi
         walxvoBGdCuOHpz56cewOoIomTU+g774SkXfUalipYiRJMVJoZ3pkUJWKDtxaJOUs9Wp
         z0yK72oV7D8umgBnfJqMPVe0CbYroH1c27oYPHH9DprMH4CUrxPNoWI6SVXsXvOIGR2j
         g7f70C02303LI4FevNbv4LB2Bfe3rGsWoe0WkiFs0zaMl+gMi3egdBS6vCi70LctvgjH
         FSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gq7iVePtX9OMXEUxruOPEde6hXUmiczdKpj9eXTuegY=;
        b=w811jov+VyjTLMSV4RiBdbLKjt03GSYVht8gsNIOgzR0Coq++EktZwSi7Sc+BKwLcQ
         R6UjxxXRh7EsCt/1VosBYutda4rQI558cx5MnAEwe33EIh9JODmboy5v+syKKK26mn3e
         tSlbYjGuHrHK9UZpou6uBhLsCFb273zFkF/pGpQdOHSa3TaVeY8YqrERwmf7Bt0JMmHn
         qP8iz+LDeCQu/S492AaeN3BebRfy1QuWVfojrZCGLICIbST2bTzxGgMMLSfk9WUSfRA9
         lRKGes3byymi4uSkh0efCZPymwC2zJDorw71N2sVJgkhIwSL/4twHZ0OSypDdWN3SYEi
         KopQ==
X-Gm-Message-State: AJIora8RUXOn47PN5veW0Bf08u3fmk2qZ7kZBVH4ciHSMPiedc61Wii0
        ZJYuaVhbsq5t3ESizpvRWb2zySPaOfhzNwATbMAgDw==
X-Google-Smtp-Source: AGRyM1uGAMC8S/HveHGgFfIt33JanygNnC6EqBWAtLcqKvSeXaHFdpGJHdDoPIAbhtZxeIi7YUBzjamq9VMTyn+dDKo=
X-Received: by 2002:a5d:4308:0:b0:219:e5a4:5729 with SMTP id
 h8-20020a5d4308000000b00219e5a45729mr13879267wrq.210.1656347352384; Mon, 27
 Jun 2022 09:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220606222058.86688-1-yosryahmed@google.com> <20220606222058.86688-3-yosryahmed@google.com>
 <YrnYtMGmGDxCrwdv@google.com>
In-Reply-To: <YrnYtMGmGDxCrwdv@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 27 Jun 2022 09:28:36 -0700
Message-ID: <CAJD7tkbqAignkN-Vh3A3gyBV_n_gZDBpM56r9HiXrYG+F0v8wg@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] KVM: mmu: add a helper to account memory used by
 KVM MMU.
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
        Oliver Upton <oupton@google.com>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jun 27, 2022 at 9:20 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, Jun 06, 2022, Yosry Ahmed wrote:
> > Add a helper to account pages used by KVM for page tables in secondary
> > pagetable stats. This function will be used by subsequent patches in
> > different archs.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  include/linux/kvm_host.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 883e86ec8e8c4..645585f3a4bed 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -2246,6 +2246,15 @@ static inline void kvm_handle_signal_exit(struct kvm_vcpu *vcpu)
> >  }
> >  #endif /* CONFIG_KVM_XFER_TO_GUEST_WORK */
> >
> > +/*
> > + * If nr > 1, we assume virt is the address of the first page of a block of
>
> But what if @nr is -2, which is technically less than 1?  :-)
>
> > + * pages that were allocated together (i.e accounted together).
>
> Don't document assumptions, document the rules.  And avoid "we", pronouns are
> ambiguous, e.g. is "we" the author, or KVM, or something else entirely?
>
> /*
>  * If more than one page is being (un)accounted, @virt must be the address of
>  * the first page of a block of pages what were allocated together.
>  */
>

Looks much better, I will use that in the next version.

Thanks!

>
> > + */
> > +static inline void kvm_account_pgtable_pages(void *virt, int nr)
> > +{
> > +     mod_lruvec_page_state(virt_to_page(virt), NR_SECONDARY_PAGETABLE, nr);
> > +}
> > +
> >  /*
> >   * This defines how many reserved entries we want to keep before we
> >   * kick the vcpu to the userspace to avoid dirty ring full.  This
> > --
> > 2.36.1.255.ge46751e96f-goog
> >
