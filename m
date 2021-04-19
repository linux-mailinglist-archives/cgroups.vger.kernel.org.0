Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F28363B43
	for <lists+cgroups@lfdr.de>; Mon, 19 Apr 2021 08:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhDSGHm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Apr 2021 02:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbhDSGHl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Apr 2021 02:07:41 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69CBC061760
        for <cgroups@vger.kernel.org>; Sun, 18 Apr 2021 23:07:12 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n10so5963505plc.0
        for <cgroups@vger.kernel.org>; Sun, 18 Apr 2021 23:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I/pTwkQPxJMQ6l4p78nod3nlL4rUQvx1xoHYKzDAsFA=;
        b=f/9cvpFcKS+WzsdiHb4rmMOFg+au1XzMQsLcR+o+IU6et+sCJSDFqPkf4UWHQTocgK
         EwsvtFzxqSH3X4Rw50ZP+rgTvjC66EZQLWLPkHVdGH6twi1uaJs9Sa9RkH8ivcoPAdfO
         rGrgu0ShYa+/cLy3Yx0rm8RBR1BJ/8yTy4dt80OjVRULhRd+aU4lZFl99cPOoSj8iMbT
         GlNOqPSjOdoeEM4l20Eu3948/No0AM01fpPvlxHIQhsqezo4rF4IV6vHoywnqQVlgo5b
         OT8/q0ChJvd6Oi4rs0BuFiUdEnPrREzhu1Q+gp6bfmhc4osxeOkCDLM9lhHQHF8+OkAw
         b4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I/pTwkQPxJMQ6l4p78nod3nlL4rUQvx1xoHYKzDAsFA=;
        b=LLRIUuJ4P4QLnyrxmwB/wE0fhLT5x8YCENuxZIBuByBKQMe5QL2cL9OhO2lrvf0LR5
         CdoNSbnyE+iRizdJp/QCeJgEKBXBffY43vT9UCztP1qs0QtGAV+xARv7dnyk5e1cRgJM
         IflRQpAJgBCZ+qMCmCcDL+cy0CmE582+h9fZunafKLAhf6aPx8Sw2vZJYDWDzeoaiG2T
         UVtunrJPw8Qq5vznJFv3N1NfkpvEQxrb9dZ66KUqRAgStOtMjV/IduYIOdJrnqKwv/ds
         VmzuQoxS+MGvUjSOUY/UGypIUXcoTKnKrOaLmZ3zuJoGFKX9wbAnrzwsk5Dpne7NH3CD
         Q5Ig==
X-Gm-Message-State: AOAM533vRKyRCZJJzF9yEPIv7hDV6pqhpwyvCPFsTD4p1tWQ8/ApqWBK
        zNP2sSAGjbKkJ9poXJWzEjnlH0lVShf8YQ00vpkFbQ==
X-Google-Smtp-Source: ABdhPJxqVdcYpe7OSZvgQprMdb2BqvZpCVSjDbrFb0yJYSh6VapcywSPE+nBf4qt6g7HgeZawAZwNiV/mSt9s9ByV/I=
X-Received: by 2002:a17:902:ea93:b029:eb:65ee:ddd3 with SMTP id
 x19-20020a170902ea93b02900eb65eeddd3mr21320918plb.24.1618812427191; Sun, 18
 Apr 2021 23:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210419000032.5432-1-longman@redhat.com> <20210419000032.5432-6-longman@redhat.com>
In-Reply-To: <20210419000032.5432-6-longman@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 19 Apr 2021 14:06:30 +0800
Message-ID: <CAMZfGtWX-Gik3i9_wmipuQZf0c-O-Yo_ejJYoN6-sf25vMLfog@mail.gmail.com>
Subject: Re: [External] [PATCH v4 5/5] mm/memcg: Improve refill_obj_stock() performance
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 19, 2021 at 8:01 AM Waiman Long <longman@redhat.com> wrote:
>
> There are two issues with the current refill_obj_stock() code. First of
> all, when nr_bytes reaches over PAGE_SIZE, it calls drain_obj_stock() to
> atomically flush out remaining bytes to obj_cgroup, clear cached_objcg
> and do a obj_cgroup_put(). It is likely that the same obj_cgroup will
> be used again which leads to another call to drain_obj_stock() and
> obj_cgroup_get() as well as atomically retrieve the available byte from
> obj_cgroup. That is costly. Instead, we should just uncharge the excess
> pages, reduce the stock bytes and be done with it. The drain_obj_stock()
> function should only be called when obj_cgroup changes.
>
> Secondly, when charging an object of size not less than a page in
> obj_cgroup_charge(), it is possible that the remaining bytes to be
> refilled to the stock will overflow a page and cause refill_obj_stock()
> to uncharge 1 page. To avoid the additional uncharge in this case,
> a new overfill flag is added to refill_obj_stock() which will be set
> when called from obj_cgroup_charge().
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/memcontrol.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index a6dd18f6d8a8..d13961352eef 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3357,23 +3357,34 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
>         return false;
>  }
>
> -static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
> +static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
> +                            bool overfill)
>  {
>         unsigned long flags;
>         struct obj_stock *stock = get_obj_stock(&flags);
> +       unsigned int nr_pages = 0;
>
>         if (stock->cached_objcg != objcg) { /* reset if necessary */
> -               drain_obj_stock(stock);
> +               if (stock->cached_objcg)
> +                       drain_obj_stock(stock);
>                 obj_cgroup_get(objcg);
>                 stock->cached_objcg = objcg;
>                 stock->nr_bytes = atomic_xchg(&objcg->nr_charged_bytes, 0);
>         }
>         stock->nr_bytes += nr_bytes;
>
> -       if (stock->nr_bytes > PAGE_SIZE)
> -               drain_obj_stock(stock);
> +       if (!overfill && (stock->nr_bytes > PAGE_SIZE)) {
> +               nr_pages = stock->nr_bytes >> PAGE_SHIFT;
> +               stock->nr_bytes &= (PAGE_SIZE - 1);
> +       }
>
>         put_obj_stock(flags);
> +
> +       if (nr_pages) {
> +               rcu_read_lock();
> +               __memcg_kmem_uncharge(obj_cgroup_memcg(objcg), nr_pages);
> +               rcu_read_unlock();
> +       }

It is not safe to call __memcg_kmem_uncharge() under rcu lock
and without holding a reference to memcg. More details can refer
to the following link.

https://lore.kernel.org/linux-mm/20210319163821.20704-2-songmuchun@bytedance.com/

In the above patchset, we introduce obj_cgroup_uncharge_pages to
uncharge some pages from object cgroup. You can use this safe
API.

Thanks.

>  }
>
>  int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
> @@ -3410,7 +3421,7 @@ int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
>
>         ret = __memcg_kmem_charge(memcg, gfp, nr_pages);
>         if (!ret && nr_bytes)
> -               refill_obj_stock(objcg, PAGE_SIZE - nr_bytes);
> +               refill_obj_stock(objcg, PAGE_SIZE - nr_bytes, true);
>
>         css_put(&memcg->css);
>         return ret;
> @@ -3418,7 +3429,7 @@ int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
>
>  void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
>  {
> -       refill_obj_stock(objcg, size);
> +       refill_obj_stock(objcg, size, false);
>  }
>
>  #endif /* CONFIG_MEMCG_KMEM */
> --
> 2.18.1
>
