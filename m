Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B4533BFAD
	for <lists+cgroups@lfdr.de>; Mon, 15 Mar 2021 16:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhCOPYP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Mar 2021 11:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbhCOPXs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Mar 2021 11:23:48 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C34C06175F
        for <cgroups@vger.kernel.org>; Mon, 15 Mar 2021 08:23:47 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id e7so57531295lft.2
        for <cgroups@vger.kernel.org>; Mon, 15 Mar 2021 08:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QcfCS3OT8mvBdrnyO72dgaCH8JvijbKyt7yMCuBSTlQ=;
        b=JlCakE/RcNDC7cdQJ2qbTWWcuBViyVc8yQxJ/a3Rbc7xxypLQGhdBJWuMRQ7XgqY2D
         H/caDda5QYMgkAKbUo8Q1vRyGEsseBdOEkuIuOyvvxXUEFyRmzem78jmXqlDFIH26C0o
         FvNmKqpChls7ZYziwyNI8jIHSVW6GRhp8/TCeOxA9/1kCIIFMtRL+PSzipX6bsFfJBaf
         Okn1IiP9o3JSMyRNNmxtu2CUHxfDEHvZeB9z415x23+4TzvJPdIbfU6B+8vHOwheE3ME
         UDlpK1PmsswIVQIggydljLXiNlJ82C6Rt8TtgVYmvSmLQUJcrBns/xGxTeHPiVR89mFc
         AhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QcfCS3OT8mvBdrnyO72dgaCH8JvijbKyt7yMCuBSTlQ=;
        b=Y2EOvJWI4jGgrfNZ6MPNaxzOyjpBzSTySH5FsbGl0E5VqMzEgi09pODWCjkWsnoe3j
         XQ5ukGl6VmC7mwH7OC93yj3sgX6C+wjMZeTgHlnDAO7qA5zIGBlWsI79HcDaxSU72qox
         tLXQ8EB1oqXR9SkoadBzCCBwqo5m2dNxRDDql4TvVmv1dlKSZilN3Jn1pTrWZroaTOkc
         TPmwDi/bodJy9un7KKrQBKv9OH/Po2yyiJ5cJEIyagQmUPIyj9AZAOGOpHeNO5cfNawm
         Ftb6rCwD++XmsD7ym9avnbjQFaBk2ZXIdFyIsxm6EzBaVS1nkDXgHs9uVted208BEMU3
         2Y2g==
X-Gm-Message-State: AOAM531B7WCL7D5yRjwaCpvIf6Na4/YbhcCz1eb7JrL8SLPalEz8qAUg
        W3mUOay6rP59IfWaRGMFjVJbI/o3+alcVF2sOLQYzw==
X-Google-Smtp-Source: ABdhPJw3wK90cYrKbIlCkyVqGgXLSUXUZt6KRNSsAX5juDUzx2wewIXznZz3QegYg3QLWAo1PPWtaa05ds2RC/w23eg=
X-Received: by 2002:a19:f50e:: with SMTP id j14mr8331279lfb.299.1615821826094;
 Mon, 15 Mar 2021 08:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <YEnWUrYOArju66ym@dhcp22.suse.cz> <85b5f428-294b-af57-f496-5be5fddeeeea@virtuozzo.com>
In-Reply-To: <85b5f428-294b-af57-f496-5be5fddeeeea@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 15 Mar 2021 08:23:34 -0700
Message-ID: <CALvZod7pts6i9Zfijt+ht331z04D=t3p+6JD6yoLCw9vtzDBbQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] memcg: accounting for fib6_nodes cache
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Mar 15, 2021 at 5:23 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> An untrusted netadmin inside a memcg-limited container can create a
> huge number of routing entries. Currently, allocated kernel objects
> are not accounted to proper memcg, so this can lead to global memory
> shortage on the host and cause lot of OOM kiils.
>
> One such object is the 'struct fib6_node' mostly allocated in
> net/ipv6/route.c::__ip6_ins_rt() inside the lock_bh()/unlock_bh() section:
>
>  write_lock_bh(&table->tb6_lock);
>  err = fib6_add(&table->tb6_root, rt, info, mxc);
>  write_unlock_bh(&table->tb6_lock);
>
> It this case is

'In this case it is'

> not enough to simply add SLAB_ACCOUNT to corresponding
> kmem cache. The proper memory cgroup still cannot be found due to the
> incorrect 'in_interrupt()' check used in memcg_kmem_bypass().
> To be sure that caller is not executed in process contxt

'context'

> '!in_task()' check should be used instead

You missed the signoff and it seems like the whole series is missing
it as well. Please run scripts/checkpatch.pl on the patches before
sending again.

> ---
>  mm/memcontrol.c    | 2 +-
>  net/ipv6/ip6_fib.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 845eec0..568f2cb 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1076,7 +1076,7 @@ static __always_inline bool memcg_kmem_bypass(void)
>                 return false;
>
>         /* Memcg to charge can't be determined. */
> -       if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
> +       if (!in_task() || !current->mm || (current->flags & PF_KTHREAD))

Can you please also add some explanation in the commit message on the
differences between in_interrupt() and in_task()? Why is
in_interrupt() not correct here but !in_task() is? What about kernels
with or without PREEMPT_COUNT?

>                 return true;
>
>         return false;
> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index ef9d022..fa92ed1 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -2445,7 +2445,7 @@ int __init fib6_init(void)
>
>         fib6_node_kmem = kmem_cache_create("fib6_nodes",
>                                            sizeof(struct fib6_node),
> -                                          0, SLAB_HWCACHE_ALIGN,
> +                                          0, SLAB_HWCACHE_ALIGN|SLAB_ACCOUNT,
>                                            NULL);
>         if (!fib6_node_kmem)
>                 goto out;
> --
> 1.8.3.1
>
