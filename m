Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8685A0055
	for <lists+cgroups@lfdr.de>; Wed, 24 Aug 2022 19:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240092AbiHXR0Y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Aug 2022 13:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238645AbiHXR0X (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 Aug 2022 13:26:23 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2710E7CA82
        for <cgroups@vger.kernel.org>; Wed, 24 Aug 2022 10:26:22 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bq11so15044453wrb.12
        for <cgroups@vger.kernel.org>; Wed, 24 Aug 2022 10:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=PyL5R0h/l4gJt239ptqG1oF6MWjvvRhnBKs2TUqoy18=;
        b=jQo8Hnb2GH3hf1ONG3xswu3V43RapwZZQv/uLqocxPR835oyqTUFMASIxiUoHL6XPp
         EbyicGfCO/sXpp4HRUcZkK6eb5S/FJk3LCRWifleT2kwRNWUQdb3Pycb7gz+LLxmY/R5
         cAwAKSjcgIGBXG8vtmnslPBHLQtM2g3cCibWehD2SbdsVHqGT2G9+BKT5dnCmoA5yLS/
         NVGYZip8bdVm+/+hyVO7QlJ3mzWEUYz9x/mwMcK90WZe3i29zVqh6PZXN9gfUwGFhwoX
         BqhSoPB12QVEr5eJwWyR6ofuIoW/nLes2Q//tqKQFwWjS9S5Pc7b3jtbxpG9zRwoyvst
         uW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=PyL5R0h/l4gJt239ptqG1oF6MWjvvRhnBKs2TUqoy18=;
        b=pABDgoQjT+FGxNvv08tJZJzFR7k5tY+/Xp+BECKu0wc4k3s2kBaEUY0I7t9JVyKhRO
         aAdxQ+4c8a58B1rDdZE6gQt/ps5WmEd+mLt3dUOzDq4VCoeqQ1tBjHV1pSc1p7+2N6gY
         ONjip2FhM/v1n3jqoPtaVdZy9LN1O+2RVi+msZ3jJhOmGuLhS72fOwj5MGFfHcapftxo
         HJm+gFhA5MlQyZ0RQPnAQGeWnW07bLmwXvYJ/hVb+YdJewUwtGIQzV7JLaIdB5228LeF
         iPo6LwznL5vrC3me4BYJEOFZBQbmPxaOKEtLGUsyTYWma1fNSJpG+y09I5xv/cu6BPov
         g1CQ==
X-Gm-Message-State: ACgBeo1qBSL71vhReJXsGgOx6WhnjhUcokEvdAVveiY/d3KMvkCiPzfE
        6idSf5pJFFP7dB+rpndmoVvO6wHv8boT7ZX33pS8Tg==
X-Google-Smtp-Source: AA6agR7iXw73BTfjDZ8jZn+Fm8FhmEI+9YASQfOV4iSJ8ZIWQgBMY6R5SVjUTupDZtCPK8fsP9gfgnCHrt3adgZF1rc=
X-Received: by 2002:adf:9ccf:0:b0:225:4934:53e3 with SMTP id
 h15-20020adf9ccf000000b00225493453e3mr158800wre.210.1661361980453; Wed, 24
 Aug 2022 10:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220823004639.2387269-1-yosryahmed@google.com>
 <20220823004639.2387269-2-yosryahmed@google.com> <5ac13c91-0e42-533b-42d0-c78573c7aef3@arm.com>
In-Reply-To: <5ac13c91-0e42-533b-42d0-c78573c7aef3@arm.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 24 Aug 2022 10:25:43 -0700
Message-ID: <CAJD7tkbn7mFvf0oiUKPZtu92GtuMht-s5iPBRfEuUfTxXC_j8Q@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] mm: add NR_SECONDARY_PAGETABLE to count secondary
 page table uses.
To:     Ryan Roberts <ryan.roberts@arm.com>
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
        Shakeel Butt <shakeelb@google.com>,
        Oliver Upton <oupton@google.com>, kvm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Huang@google.com, Shaoqin <shaoqin.huang@intel.com>,
        Linux-MM <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        nd@arm.com
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

On Wed, Aug 24, 2022 at 6:42 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> > index e7aafc82be99..898c99eae8e4 100644
> > --- a/Documentation/filesystems/proc.rst
> > +++ b/Documentation/filesystems/proc.rst
> > @@ -982,6 +982,7 @@ Example output. You may not have all of these fields.
> >       SUnreclaim:       142336 kB
> >       KernelStack:       11168 kB
> >       PageTables:        20540 kB
> > +    SecPageTables:         0 kB
> >       NFS_Unstable:          0 kB
> >       Bounce:                0 kB
> >       WritebackTmp:          0 kB
> > @@ -1090,6 +1091,9 @@ KernelStack
> >                 Memory consumed by the kernel stacks of all tasks
> >   PageTables
> >                 Memory consumed by userspace page tables
> > +SecPageTables
> > +              Memory consumed by secondary page tables, this currently
> > +              currently includes KVM mmu allocations on x86 and arm64.
>
> nit: I think you have a typo here: "currently currently".

Sorry I missed this, thanks for catching it. The below diff fixes it
(let me know if I need to send v8 for this, hopefully not).

diff --git a/Documentation/filesystems/proc.rst
b/Documentation/filesystems/proc.rst
index 898c99eae8e4..0b3778ec12e1 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1093,7 +1093,7 @@ PageTables
               Memory consumed by userspace page tables
 SecPageTables
               Memory consumed by secondary page tables, this currently
-              currently includes KVM mmu allocations on x86 and arm64.
+              includes KVM mmu allocations on x86 and arm64.
 NFS_Unstable
               Always zero. Previous counted pages which had been written to
               the server, but has not been committed to stable storage.

>
> Thanks,
> Ryan
