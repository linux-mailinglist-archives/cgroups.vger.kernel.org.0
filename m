Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B4A513F35
	for <lists+cgroups@lfdr.de>; Fri, 29 Apr 2022 01:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbiD1XxH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Apr 2022 19:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353419AbiD1XxH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Apr 2022 19:53:07 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB66AAC057
        for <cgroups@vger.kernel.org>; Thu, 28 Apr 2022 16:49:46 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n32-20020a05600c3ba000b00393ea7192faso3856070wms.2
        for <cgroups@vger.kernel.org>; Thu, 28 Apr 2022 16:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=focMG0Yvzu8kTNlJIkjfWrJiugje96+mCpIttRqo5P4=;
        b=GOeTnHyfLUj1kYuuIm0Y/SV6rdbaURUuZyug5U8+bM9txNVDB4zqvMsTo6LgWxqqJ+
         EJzVOKlCGbXzZnVXdg3zImUfxT1mhWA8cbxLRGVt1mE5eBxCAY3hnU4fMZFKFe1/ysTG
         cyomFq/31PJ7L9dLLImNGTzmHFLpGkzqWJGCsZd6ESc2YMwmrym/vaV+ntsJIKN6uPzN
         GHJN6ZJmWTueQxTkthcuYUVcXcDsF4uUX/S+zj4KBcwgIjmuet5DXc3NMlNVPJ+MF4Jl
         g76wI45mkRhG8Ow9F+ienA/5IabcbdIA62pAqypAHshKR/CNShI7i+XFMGHcSQdqfi8n
         ZW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=focMG0Yvzu8kTNlJIkjfWrJiugje96+mCpIttRqo5P4=;
        b=NM0uYtfNIWqiY8LLP9E8YEp+IuNzilGIsAcTLLAk/+8uwrBY/w2Rw1fJ55aRojBNwc
         IwOM0wXQHeWZlk+ZAlNiMmwBwDXi3oNJlWLqI5yYA7JSVKIh4ahYbA173nAfU+hsaIBk
         vyRrf6HzwbL6tzJwQ/yIIDuBSC4gVwFHJ+OFmLKfoO8zmEOvoMMD+X3UzPLM2WmkHrr0
         osam2uUfOmRVHhjf5IOmDQPfmAQErxHndpnBjioBTBEP5oqOXSjEFqqIGvDuHiyozukb
         GeosmO2HjVW/19qZ8LXVDh+83fU0M9ZUiRFtNIWyWQwCvTxrcEjHkuUYsdoWwaOHOW1g
         xh7g==
X-Gm-Message-State: AOAM530kxhnX2Z3xGFbygTVN5p0EwG0WDFAnXcKB+CO+iT0O/o8/iAx2
        bsturzI85Gk20ppHUz5dPwx64Qxv6ApW+Nxf5Osy8g==
X-Google-Smtp-Source: ABdhPJya8b5HEmPINhPN/otjpFgAZMsVFO+BsikAPMu9LghWg6ZEVzzp+YtbjdBMxFE0lABxkDoCV9sNN45FlpkElhQ=
X-Received: by 2002:a05:600c:1c88:b0:394:dfa:917f with SMTP id
 k8-20020a05600c1c8800b003940dfa917fmr536458wms.27.1651189785285; Thu, 28 Apr
 2022 16:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220426053904.3684293-1-yosryahmed@google.com>
 <20220426053904.3684293-5-yosryahmed@google.com> <YmegoB/fBkfwaE5z@google.com>
 <CAJD7tkY-WZKcyer=TbWF0dVfOhvZO7hqPN=AYCDZe1f+2HA-QQ@mail.gmail.com> <YmrSywSU1ezREvT6@google.com>
In-Reply-To: <YmrSywSU1ezREvT6@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 28 Apr 2022 16:49:09 -0700
Message-ID: <CAJD7tkY1sdjXFAhftWG+ZV1B4z_HR9mf4QZGA-EJWeKaRQGs4Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] KVM: arm64/mmu: count KVM page table pages in
 pagetable stats
To:     Oliver Upton <oupton@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Marc Zyngier <maz@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 28, 2022 at 10:45 AM Oliver Upton <oupton@google.com> wrote:
>
> On Tue, Apr 26, 2022 at 12:27:57PM -0700, Yosry Ahmed wrote:
> > > What page tables do we want to account? KVM on ARM manages several page
> > > tables.
> > >
> > > For regular KVM, the host kernel manages allocations for the hyp stage 1
> > > tables in addition to the stage 2 tables used for a particular VM. The
> > > former is system overhead whereas the latter could be attributed to a
> > > guest VM.
> >
> > Honestly I would love to get your input on this. The main motivation
> > here is to give users insights on the kernel memory usage on their
> > system (or in a cgroup). We currently have NR_PAGETABLE stats for
> > normal kernel page tables (allocated using
> > __pte_alloc_one()/pte_free()), this shows up in /proc/meminfo,
> > /path/to/cgroup/memory.stat, and node stats. The idea is to add
> > NR_SECONDARY_PAGETABLE that should include the memory used for kvm
> > pagetables, which should be a separate category (no overlap). What
> > gets included or not depends on the semantics of KVM and what exactly
> > falls under the category of secondary pagetables from the user's pov.
> >
> > Currently it looks like s2 page table allocations get accounted to
> > kmem of memory control groups (GFP_KERNEL_ACCOUNT), while hyp page
> > table allocations do not (GFP_KERNEL). So we could either follow this
> > and only account s2 page table allocations in the stats, or make hyp
> > allocations use GFP_KERNEL_ACCOUNT as well and add them to the stats.
> > Let me know what you think.
>
> I think it is reasonable to just focus on stage 2 table allocations and
> ignore all else. As Marc pointed out it isn't workable in other
> contexts anyway (pKVM), and keeps the patch tidy too.
>
> GFP_KERNEL_ACCOUNT for hyp allocations wouldn't make sense, as it is
> done at init to build out the system page tables for EL2.

Thanks so much for the insights, will send out v4 according to our discussion.

>
> --
> Thanks,
> Oliver
