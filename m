Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59296546DB0
	for <lists+cgroups@lfdr.de>; Fri, 10 Jun 2022 21:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348954AbiFJTzr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Jun 2022 15:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349925AbiFJTzo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Jun 2022 15:55:44 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149EB12770
        for <cgroups@vger.kernel.org>; Fri, 10 Jun 2022 12:55:43 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id c196so351738pfb.1
        for <cgroups@vger.kernel.org>; Fri, 10 Jun 2022 12:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QBy6NjH2ouB9J4AcBo7wTpbSKkOShDZoTHSArfldiUw=;
        b=sklHbZakJDBBoAiTpjSD5q4HxK1etfA1WIC7E1GGXxranlMwDMPGy/uz2sJhGgVhFh
         PsuwAc1Kvt+JrVxUxoIbUT41GO80lUj3bVmOMXx/EiCDoPrvSZTi5VA6KlhM0oySyOuR
         +tYZA59GVkAhi7mk0TAsOWGswz98wriVH5TPC/c2Qf2YokWtgLtStUvjfTvamYaneEGH
         bzvkFbDMtZuEKw/jnULBvxk8zwbsM2bB87HtefiubybLbL+H3NdXdw9PHE9MFa1uwCCh
         tyZDjrUVtcAARyszAW1G5DhaCKiwkKolBeX5R2/hKBE7ytxWxLfuo/5GEb1KHAlQavBv
         Z93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QBy6NjH2ouB9J4AcBo7wTpbSKkOShDZoTHSArfldiUw=;
        b=L9mzN2w8z+gSM9jJE7xQFh4ou8X2eWjYvHiTIQgsI4lxsVM4o1J/khmXSX4VCq7pRI
         xx8DTFQ64LH0M/8rs2JEDvtlMgphYhHz0wvEj50bZ1bDpOpDajGLXKijZ4NPA/bGS6Rp
         jJ/bsXJYeBWlYBsZCtZM+zp+l8EIVi4sddDnXR6eeKofT0FI5bijNuW4k96eKmYP5u+Y
         VTV7Nm5iWhomdOb6U1d7ae/qEbKJ81cDwKejBPyq0rIxR12+nWfgnOZLN/Kg3ePkWC2n
         yVep/xM0R9uo5Qr2L6u+KjP84leXtRPzfZOmb0II6VdrlUMbsMvbpD57ce2AYSS4FQst
         h8KQ==
X-Gm-Message-State: AOAM532eF9mcd6McK/61zO6WA1/b7JAtqr9iKZ/Kju/6w/ttxwsWHQal
        /2Qxf1IgXr3G7Kf+caJMH/Q4EmwSysdoF3fqPHwNrw==
X-Google-Smtp-Source: ABdhPJzEcSokF/zla93DIjSWei/mG/WMD+1gosW/4iq24fWu9VXSfgg5vd1o6/WI+TarUi1z/A31bQpqsNJXGPSmzwc=
X-Received: by 2002:a05:6a00:a12:b0:51b:92d7:ec55 with SMTP id
 p18-20020a056a000a1200b0051b92d7ec55mr55432987pfh.85.1654890942318; Fri, 10
 Jun 2022 12:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220606222058.86688-1-yosryahmed@google.com> <20220606222058.86688-2-yosryahmed@google.com>
In-Reply-To: <20220606222058.86688-2-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 10 Jun 2022 12:55:31 -0700
Message-ID: <CALvZod4XtEfdSjq=Jq51tvwXkpv-TKr32G6aeyjzcwxvdPv9SQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] mm: add NR_SECONDARY_PAGETABLE to count secondary
 page table uses.
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
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
        Oliver Upton <oupton@google.com>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>
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

On Mon, Jun 6, 2022 at 3:21 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> Add NR_SECONDARY_PAGETABLE stat to count secondary page table uses, e.g.
> KVM mmu. This provides more insights on the kernel memory used
> by a workload.
>
> This stat will be used by subsequent patches to count KVM mmu
> memory usage.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
