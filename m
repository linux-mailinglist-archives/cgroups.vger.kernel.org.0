Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8748A52566B
	for <lists+cgroups@lfdr.de>; Thu, 12 May 2022 22:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358387AbiELUg7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 May 2022 16:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358275AbiELUg6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 May 2022 16:36:58 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE94C46B15
        for <cgroups@vger.kernel.org>; Thu, 12 May 2022 13:36:56 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id s14so6025742plk.8
        for <cgroups@vger.kernel.org>; Thu, 12 May 2022 13:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8iEGBmtJoxRg/w5RBuhSp0K5Od/nybtVVk1rH49oGiM=;
        b=ixitpKQ3SEMJx6+vyRqfYZFPsTDVscIcPWYVwAot2TlYWB/whS7xd2WA0N3kFVhdWv
         xykgHSXbXR13UoiVi6kmSmkzX2tfIsv7vsZph7eFSvV1S0D9T3FHIUWA8LMD0Do236on
         FTisXIdk9sh4KeO0hAlhE0GBNUnBqeKLa0sWqmXuxnr73Xr9DqUdwX/qiP840xQT6KmX
         vUwaNHv4yq0UjkHIbCtTCBZttGQQrebwZJ05pQro3hanExvUMkgnoB8A3xPfeZTScIFd
         ifuuI96/H0MEDTv8C00E3fyfMSJ/KwBkl5YM9aUbb9nKKbBlKdnD3y7zJcQs9AzZnuVI
         uC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8iEGBmtJoxRg/w5RBuhSp0K5Od/nybtVVk1rH49oGiM=;
        b=MoSJ4Ybo22t2P0rzzyIv0L7Dn+vZvHow13EHlKJOxFGHSfmCaQM1lbPEKy/f2WIOoQ
         MrW/uBWMrjjlIMXRPfG10Y5tNi33G3C5N9RfIGj1bnwKAuoLmHiY+BmY8qG1mNaA2RXX
         ZII8xKZEwzCyOD6FeB4gJV+a18GiydIVq58uP54f/nGLuUQhEwwGwKfh+xfbgSJBhmIF
         4viSOIN7AIVVWaeBztw8ZUjHzcCRx1LepCRfPJCZ83kZuKjv+I1/AygXSxeCd9MIvCAc
         260FgsbJ4PzgZavO6M/oF3uCg7rA1nQYVGN8An38sSiyfR2ut4NIlSC+LzNYkyP6xsJq
         2FfQ==
X-Gm-Message-State: AOAM530nK6uJv386UgdKlmEyZ9qYqPQFG+NCnbGM/Edbyn2Ia2CwEsdN
        HKzc8Tf1Lu/hsD6QEf76dr41szgfTNzsfEoWQTc/7w==
X-Google-Smtp-Source: ABdhPJwuhYymsZ0StsyNYTXEvlNbykWVyGE1D/eBaulkendPrYdPMp+9LrsPeBKypjw3sXfyHpF2VAkA0+PEtw1SNjc=
X-Received: by 2002:a17:90b:1d83:b0:1dc:4362:61bd with SMTP id
 pf3-20020a17090b1d8300b001dc436261bdmr12577913pjb.126.1652387816246; Thu, 12
 May 2022 13:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220429201131.3397875-1-yosryahmed@google.com>
 <20220429201131.3397875-2-yosryahmed@google.com> <87ilqoi77b.wl-maz@kernel.org>
 <CAJD7tkY7JF25XXUFq2mGroetMkfo-2zGOaQC94pjZE3D42+oaw@mail.gmail.com> <CAJD7tkbfT-FRs3LE2GPddqrQSWw_eC1R6k3z04x=z9Zvt5yLpg@mail.gmail.com>
In-Reply-To: <CAJD7tkbfT-FRs3LE2GPddqrQSWw_eC1R6k3z04x=z9Zvt5yLpg@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 12 May 2022 13:36:44 -0700
Message-ID: <CALvZod4w88YDCpageGPDZfCcFwi2C4YfSsavd-Svixovvx5n_A@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] mm: add NR_SECONDARY_PAGETABLE to count secondary
 page table uses.
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 9, 2022 at 9:38 AM Yosry Ahmed <yosryahmed@google.com> wrote:
>
[...]
> > >
> > > What do you plan to do for IOMMU page tables? After all, they serve
> > > the exact same purpose, and I'd expect these to be handled the same
> > > way (i.e. why is this KVM specific?).
> >
> > The reason this was named NR_SECONDARY_PAGTABLE instead of
> > NR_KVM_PAGETABLE is exactly that. To leave room to incrementally
> > account other types of secondary page tables to this stat. It is just
> > that we are currently interested in the KVM MMU usage.
> >
>
>
> Any thoughts on this? Do you think MEMCG_SECONDARY_PAGETABLE would be
> more appropriate here?

I think NR_SECONDARY_PAGTABLE is good. Later it can include pagetables
from other subsystems. The only nit (which you can ignore) I have is
the very long memcg stat and vmstat names. Other than that the patch
looks good to me.
