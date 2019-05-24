Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D32229DB0
	for <lists+cgroups@lfdr.de>; Fri, 24 May 2019 20:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfEXSET (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 May 2019 14:04:19 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34129 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfEXSET (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 May 2019 14:04:19 -0400
Received: by mail-yw1-f65.google.com with SMTP id n76so3976076ywd.1
        for <cgroups@vger.kernel.org>; Fri, 24 May 2019 11:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ac3B/Xe+w3ROTUibljmXKgMNFheZh3fEEGPnecMKhL8=;
        b=r1OoUil15z41t05s7Vkc/zjldTqEYgmmxywmhKuW54yfFoy/DzoLQdlPOyYRIwSPds
         sEHDpgwMAcqLq1YXHhMikBuTJisl+J2t2x60kdRX3fh+DCltNpsWy5VjfrYhj93J/WV9
         hrRLr/L897Xl/6cxVjDjl8EB/mnP3sCPl+QE8oW6qtneUdfiqvfxgUyLSqP/wtg/foth
         i+Wxt0gU2HJ0rfVhaCvQ6415HVjOy7xHl2d9q0YhQjQFIqCXXQvxMliZxaEgaiXcRr6u
         Ovm0UwnXvMH3SnusLsATmcCksvmzuf4hl8kotBCewE2zc/q8LmW+uDruXRlmZFlvwfT8
         EPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ac3B/Xe+w3ROTUibljmXKgMNFheZh3fEEGPnecMKhL8=;
        b=m03vlKCdVj03XmSy/7em8qHVaPGFmq3WEA/x0Qj8uLvBqTJqfUsPPf/nWTVdgzW7jh
         /f744WqiSnKO7cpfQKpFVYMUx46UdDAEg8fXLni9vxnHuEfWPzO8ALYd2t9cyBm+VkIK
         XvQ1j+n42c/zXwqyvNUXiIjJOQ4IcIWEdRc6j1OomOxtsS59P5O5upNaSLpmXt5DOrpJ
         0NYf9tBAKN5rPWORnhsBxxPH3bbF4mO4+Bn7hDabaVc7cYy6G2EMIWRgOPcSY7SilrBb
         nao+FAwU8bfuscQH2Xw5EBcOcDNpaO70UQK8FsHSgLT0Lwq4oQr1VQsvk68Qi9ELncCG
         Cjyg==
X-Gm-Message-State: APjAAAUl6xWpPdeqpz0q9H9UE7Po5M1dmP/5o5Ni3qpCUjHhwaTE6dkU
        I/bC2B/gMAZfKa2qV1pTjP1PykiMGEq58NBVr0Kf3f/Vj1c=
X-Google-Smtp-Source: APXvYqwGxgNhe0/sR2Bra3VIvf25c+d9ZRZytcuC+KZ8FBRUDOjzqpxCJXpC987qr7W/yk2gPJa5HVzkIHmlaFATPpo=
X-Received: by 2002:a0d:d9d7:: with SMTP id b206mr28725213ywe.398.1558721058115;
 Fri, 24 May 2019 11:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190524153148.18481-1-hannes@cmpxchg.org> <20190524160417.GB1075@bombadil.infradead.org>
 <20190524173900.GA11702@cmpxchg.org>
In-Reply-To: <20190524173900.GA11702@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 24 May 2019 11:04:06 -0700
Message-ID: <CALvZod4ZK5X+Tf2BMgwi40XmSTqHW-=wAwSVg_eFrtCf2=rCQw@mail.gmail.com>
Subject: Re: [PATCH] mm: fix page cache convergence regression
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 24, 2019 at 10:41 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, May 24, 2019 at 09:04:17AM -0700, Matthew Wilcox wrote:
> > On Fri, May 24, 2019 at 11:31:48AM -0400, Johannes Weiner wrote:
> > > diff --git a/include/linux/xarray.h b/include/linux/xarray.h
> > > index 0e01e6129145..cbbf76e4c973 100644
> > > --- a/include/linux/xarray.h
> > > +++ b/include/linux/xarray.h
> > > @@ -292,6 +292,7 @@ struct xarray {
> > >     spinlock_t      xa_lock;
> > >  /* private: The rest of the data structure is not to be used directly. */
> > >     gfp_t           xa_flags;
> > > +   gfp_t           xa_gfp;
> > >     void __rcu *    xa_head;
> > >  };
> >
> > No.  I'm willing to go for a xa_flag which says to use __GFP_ACCOUNT, but
> > you can't add another element to the struct xarray.
>
> Ok, we can generalize per-tree gfp flags later if necessary.
>
> Below is the updated fix that uses an XA_FLAGS_ACCOUNT flag instead.
>
> ---
> From 63a0dbc571ff38f7c072c62d6bc28192debe37ac Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Fri, 24 May 2019 10:12:46 -0400
> Subject: [PATCH] mm: fix page cache convergence regression
>
> Since a28334862993 ("page cache: Finish XArray conversion"), on most
> major Linux distributions, the page cache doesn't correctly transition
> when the hot data set is changing, and leaves the new pages thrashing
> indefinitely instead of kicking out the cold ones.
>
> On a freshly booted, freshly ssh'd into virtual machine with 1G RAM
> running stock Arch Linux:
>
> [root@ham ~]# ./reclaimtest.sh
> + dd of=workingset-a bs=1M count=0 seek=600
> + cat workingset-a
> + cat workingset-a
> + cat workingset-a
> + cat workingset-a
> + cat workingset-a
> + cat workingset-a
> + cat workingset-a
> + cat workingset-a
> + ./mincore workingset-a
> 153600/153600 workingset-a
> + dd of=workingset-b bs=1M count=0 seek=600
> + cat workingset-b
> + cat workingset-b
> + cat workingset-b
> + cat workingset-b
> + ./mincore workingset-a workingset-b
> 104029/153600 workingset-a
> 120086/153600 workingset-b
> + cat workingset-b
> + cat workingset-b
> + cat workingset-b
> + cat workingset-b
> + ./mincore workingset-a workingset-b
> 104029/153600 workingset-a
> 120268/153600 workingset-b
>
> workingset-b is a 600M file on a 1G host that is otherwise entirely
> idle. No matter how often it's being accessed, it won't get cached.
>
> While investigating, I noticed that the non-resident information gets
> aggressively reclaimed - /proc/vmstat::workingset_nodereclaim. This is
> a problem because a workingset transition like this relies on the
> non-resident information tracked in the page cache tree of evicted
> file ranges: when the cache faults are refaults of recently evicted
> cache, we challenge the existing active set, and that allows a new
> workingset to establish itself.
>
> Tracing the shrinker that maintains this memory revealed that all page
> cache tree nodes were allocated to the root cgroup. This is a problem,
> because 1) the shrinker sizes the amount of non-resident information
> it keeps to the size of the cgroup's other memory and 2) on most major
> Linux distributions, only kernel threads live in the root cgroup and
> everything else gets put into services or session groups:
>
> [root@ham ~]# cat /proc/self/cgroup
> 0::/user.slice/user-0.slice/session-c1.scope
>
> As a result, we basically maintain no non-resident information for the
> workloads running on the system, thus breaking the caching algorithm.
>
> Looking through the code, I found the culprit in the above-mentioned
> patch: when switching from the radix tree to xarray, it dropped the
> __GFP_ACCOUNT flag from the tree node allocations - the flag that
> makes sure the allocated memory gets charged to and tracked by the
> cgroup of the calling process - in this case, the one doing the fault.
>
> To fix this, allow xarray users to specify per-tree flag that makes
> xarray allocate nodes using __GFP_ACCOUNT. Then restore the page cache
> tree annotation to request such cgroup tracking for the cache nodes.
>
> With this patch applied, the page cache correctly converges on new
> workingsets again after just a few iterations:
>
> [root@ham ~]# ./reclaimtest.sh
> + dd of=workingset-a bs=1M count=0 seek=600
> + cat workingset-a
> + cat workingset-a
> + cat workingset-a
> + cat workingset-a
> + cat workingset-a
> + cat workingset-a
> + cat workingset-a
> + cat workingset-a
> + ./mincore workingset-a
> 153600/153600 workingset-a
> + dd of=workingset-b bs=1M count=0 seek=600
> + cat workingset-b
> + ./mincore workingset-a workingset-b
> 124607/153600 workingset-a
> 87876/153600 workingset-b
> + cat workingset-b
> + ./mincore workingset-a workingset-b
> 81313/153600 workingset-a
> 133321/153600 workingset-b
> + cat workingset-b
> + ./mincore workingset-a workingset-b
> 63036/153600 workingset-a
> 153600/153600 workingset-b
>
> Cc: stable@vger.kernel.org # 4.20+
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
