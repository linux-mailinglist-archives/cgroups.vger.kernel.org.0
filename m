Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3D34372A8
	for <lists+cgroups@lfdr.de>; Fri, 22 Oct 2021 09:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhJVHZx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Oct 2021 03:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhJVHZx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Oct 2021 03:25:53 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021E0C061766
        for <cgroups@vger.kernel.org>; Fri, 22 Oct 2021 00:23:36 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id i65so4149065ybb.2
        for <cgroups@vger.kernel.org>; Fri, 22 Oct 2021 00:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I1vQaOge6Eq30iCGGtZzSSi/EQTEwgL0ohNIjHQi/KM=;
        b=uuv/tbejcRUmXHleRBldEGi/B8O1kL8uWt2IdylNW0f2jJK06tE3pdZp0cpmNvkwVC
         kqX0xP4gNIFA7x4hAdgmR5rmPmd7l4Cz3aR9LSqPxw5b4wZd3xJrhY8hjJLg5PIL60d6
         VY/xp17n3XgfIHdpbNch2nQ0W4rS3KvDK+UJXhmTNg1ImhZOv1b4W36tyIkFYGIJb6qd
         MEYUD7/Nlmfc8ojqzQcELshvhKkOQz4qQCiQK3ozfd3XaMngCCAfbDC1dDyCUVoUKiWF
         3+Y4SwVMNediRvwJD/8uzvVUFe9Mo8yON8fYU14LYUWogIr4xdYza8vMqTYn6+xBo4Ca
         Jmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I1vQaOge6Eq30iCGGtZzSSi/EQTEwgL0ohNIjHQi/KM=;
        b=R32STDp0fLEt8Cyg6HZZ6zm/LHQirXea1VM7fshdm8kHN8YzF0yE0fzlimR5ouSzhL
         J/eWhqyng4Qebcj8+kOyL+VX99UK2idA3H6H8wLR0FeiXNf8Vczt0bfe7kMLEp68ljJY
         h3lMSnJAVEvh9u+kKbfHNf5D9c4Ny4pcQS+NLchx8obg6J7jkbH8AMLRNrcbaaa5++1f
         KzKN31kIFYcIRb9YXEt173utcvmGJxfJXuSJt1EUw4c2071vI1YIn4wSsQULCNRyhZoc
         qUOAGsPOHe1eTUIQZraP6quT3PhnbVYwBRL/a3Ls6ijeaSnOgMJa6iyR2+dRZpnnNOxp
         gMEA==
X-Gm-Message-State: AOAM532X82MMwyLggRwr2/d+a22tC1I0T5bJuYJmjvDY8QqxSTYqN3Qm
        Uqp//JA/WRHtTs5/Z2fwf1uEhYxwoTh2Mp7rjDu4cg==
X-Google-Smtp-Source: ABdhPJynaUJMm1pfY8vtl1azmPeIhZmAuFMCkwyfcLnEQitvb2qbakd1SlCiKsqH9PoA3mbuhs3+0Wm6ZuFdvQYfJ+k=
X-Received: by 2002:a25:5443:: with SMTP id i64mr11067396ybb.125.1634887415224;
 Fri, 22 Oct 2021 00:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211022070542.679839-1-arnd@kernel.org>
In-Reply-To: <20211022070542.679839-1-arnd@kernel.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 22 Oct 2021 15:22:57 +0800
Message-ID: <CAMZfGtUL7_EfE4L-j0LxhqmpAX4ed94+1tuQYn6y4D1MBv0FDw@mail.gmail.com>
Subject: Re: [PATCH] memcg, kmem: mark cancel_charge() inline
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Roman Gushchin <guro@fb.com>, Arnd Bergmann <arnd@arndb.de>,
        Shakeel Butt <shakeelb@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Oct 22, 2021 at 3:05 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> cancel_charge() is no longer called for CONFIG_MEMCG_KMEM on NOMMU
> targets, which causes a compiletime warning:
>
> mm/memcontrol.c:2774:13: error: unused function 'cancel_charge' [-Werror,-Wunused-function]
>
> Remove the now-incorrect #ifdef and just mark the function
> 'inline' like the other related helpers. This is simpler
> and means we no longer have to match the #ifdef with the
> caller.
>
> Fixes: 5f3345c17079 ("memcg, kmem: further deprecate kmem.limit_in_bytes")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks. I guess this should be squashed into the commit 5f3345c17079
("memcg, kmem: further deprecate kmem.limit_in_bytes").

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

> ---
> The 5f3345c17079 commit is in -mm, so the commit ID is not
> stable. Feel free to just fold this into the other patch, or
> take out that reference
> ---
>  mm/memcontrol.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6538595994d2..9edccfeac804 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2770,8 +2770,7 @@ static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>         return try_charge_memcg(memcg, gfp_mask, nr_pages);
>  }
>
> -#if defined(CONFIG_MEMCG_KMEM) || defined(CONFIG_MMU)
> -static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
> +static inline void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
>  {
>         if (mem_cgroup_is_root(memcg))
>                 return;
> @@ -2780,7 +2779,6 @@ static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
>         if (do_memsw_account())
>                 page_counter_uncharge(&memcg->memsw, nr_pages);
>  }
> -#endif
>
>  static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
>  {
> --
> 2.29.2
>
