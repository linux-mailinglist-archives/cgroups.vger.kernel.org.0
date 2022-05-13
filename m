Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872515267FE
	for <lists+cgroups@lfdr.de>; Fri, 13 May 2022 19:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382785AbiEMROL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 May 2022 13:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382715AbiEMROI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 May 2022 13:14:08 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D00735DF1
        for <cgroups@vger.kernel.org>; Fri, 13 May 2022 10:14:07 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x23so8211096pff.9
        for <cgroups@vger.kernel.org>; Fri, 13 May 2022 10:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VM6L7CzHZq+DP15ACyDCNeBcnTiw96jhTORnn16Mcn8=;
        b=m7gQomUnSLOq+9pE4q9ffHGKLb3L3GE/tyqnZaMpqmJHNyG5wt5m5mpVnrt/R5fltk
         yK5RyYuw70QdsT3xpjionXDVduKVwIkENV/Mv5F0EHktzxJsXpmHkKAWfcOwy5gVtQvt
         Jb9aF197MUvc/8VfJWEKOA0A5W6r7Y5jyFAxdXtd+z7v8GihBIgqkMzUgDgmRLDEQBOl
         8CqLPCu3zlaWk59USw4+jqNDxNbSsUsyKPMu7PWzekJIARr0BRZnv82P4+e07sbtFdHd
         l7nGCtA297XhzYezBsDN16APQINq+JlpmHHYdQbrAp93SyhwC2tFFlzq6Ax51hV8P071
         YexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VM6L7CzHZq+DP15ACyDCNeBcnTiw96jhTORnn16Mcn8=;
        b=59rFYpBGfrz86S6WKA2EHlbdUa54S+CUYqszcL6hOQAW4ENBhUNAuTJWOPz0GZVycs
         r/nLkqduk8nw2a6wC7i6kL00YKuWv8wIQWalhC2kBwAavGdao/RLs8omgtCgcZ6YEhj5
         Ze69h81s0fQVKT50E5zN6LbB1BirRnQS2ArffcK1oWVEekMlPSG+ABxS/212kjUoa/2i
         VY10OzwFDERLV7lSn4I41Iq8GbxZHuv//9dHpCLjl6OpRE25qwtqxmxDZ9Kg+i3mi7L2
         ljr6l+6xQKvg6CAAOqTjXyJ1b0xca2xvN20D9/ADuCkYPHxrpNIS2vMgXqeAjPRiT0UK
         j+5A==
X-Gm-Message-State: AOAM532SpUbA10qKAVIiFIQb/zXqh52vYlRNfojZIF0FOFDL7nk9Xfko
        vZHV8xXS7jiRfkvNBlikDbtHo4/VxvMDO3GZQlusTg==
X-Google-Smtp-Source: ABdhPJzzJRHomgqXTbd3lMoRoFV7vbrkO5L/UrOYsIgvGq7U/iV65DcmY+1YVfkRJDcWOE7WzBlet9mYxMGwLWQyyE4=
X-Received: by 2002:a63:1866:0:b0:3db:4b04:9f56 with SMTP id
 38-20020a631866000000b003db4b049f56mr4750300pgy.509.1652462046391; Fri, 13
 May 2022 10:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220429201131.3397875-1-yosryahmed@google.com>
 <20220429201131.3397875-2-yosryahmed@google.com> <87ilqoi77b.wl-maz@kernel.org>
 <CAJD7tkY7JF25XXUFq2mGroetMkfo-2zGOaQC94pjZE3D42+oaw@mail.gmail.com>
 <Yn2TGJ4vZ/fst+CY@cmpxchg.org> <Yn2YYl98Vhh/UL0w@google.com>
 <Yn5+OtZSSUZZgTQj@cmpxchg.org> <Yn6DeEGLyR4Q0cDp@google.com>
In-Reply-To: <Yn6DeEGLyR4Q0cDp@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 13 May 2022 10:13:54 -0700
Message-ID: <CALvZod6nERq4j=L0V+pc-rd5+QKi4yb_23tWV-1MF53xL5KE6Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] mm: add NR_SECONDARY_PAGETABLE to count secondary
 page table uses.
To:     Sean Christopherson <seanjc@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Marc Zyngier <maz@kernel.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
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

On Fri, May 13, 2022 at 9:12 AM Sean Christopherson <seanjc@google.com> wrote:
>
[...]
>
> It was mostly an honest question, I too am trying to understand what userspace
> wants to do with this information.  I was/am also trying to understand the benefits
> of doing the tracking through page_state and not a dedicated KVM stat.  E.g. KVM
> already has specific stats for the number of leaf pages mapped into a VM, why not
> do the same for non-leaf pages?

Let me answer why a more general stat is useful and the potential
userspace reaction:

For a memory type which is significant enough, it is useful to expose
it in the general interfaces, so that the general data/stat collection
infra can collect them instead of having workload dependent stat
collectors. In addition, not necessarily that stat has to have a
userspace reaction in an online fashion. We do collect stats for
offline analysis which greatly influence the priority order of
optimization workitems.

Next the question is do we really need a separate stat item
(secondary_pagetable instead of just plain pagetable) exposed in the
stable API? To me secondary_pagetable is general (not kvm specific)
enough and can be significant, so having a separate dedicated stat
should be ok. Though I am ok with lump it with pagetable stat for now
but we do want it to be accounted somewhere.
