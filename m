Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DFA3110A2
	for <lists+cgroups@lfdr.de>; Fri,  5 Feb 2021 20:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbhBERTm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Feb 2021 12:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbhBERRg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 5 Feb 2021 12:17:36 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74ECFC061786
        for <cgroups@vger.kernel.org>; Fri,  5 Feb 2021 10:59:19 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id g9so6801440ilc.3
        for <cgroups@vger.kernel.org>; Fri, 05 Feb 2021 10:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=umcUJjWlYyqhcB34L7jgiVYkOGucvAbPTMYmElui7W8=;
        b=sxvdKwLVtJjOYJactSKqj9AfcdPfdvYp/V6Mg0fIQpYbLA8SHxX0K6BJDTpBjkL4Qv
         lmem8SOCb37UshDi2wl22+MCq4w+kmqrM8+C7BxN9ng+4g5Jv+E0D470uPlk9606zyDH
         H6607b6EDARbFm/hZH4nW6Dllif4XUfsJJkaxtFsAX3TRZPkDxlF+Y7KwKp/p5QD8t+q
         2l2eaEjfR86d42X3W8MESoXsYXk7D9Fsx+TGcBIGbhFOvK3Hequ+8MYg4B7JcH4CzBAu
         xbReADtXCiPXx9Zr4+nMdp9YumSadxv6wRiu7O7zAAMyGK/+w72fe4Ti+3OysAhLZSKn
         NTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=umcUJjWlYyqhcB34L7jgiVYkOGucvAbPTMYmElui7W8=;
        b=MaEGWqSo/48KpFBprBrcnPI2nV8plRtWeUlgsZ5EZMXdWZ8feNcBroF5vmKXpJzddi
         8pqhIgQim4R6rH1R/n4jRwXZ9vQaj6QAXrIiQES1MTYlgKNx7jNOqzEidaT4pEJt6e5Q
         FBE7mvg2WfUXIo9Fc/BZWlVRkG6OQ+5Sb9G1TL0VROSDOAbdnXRrd+MXgIZwGf+VMApC
         6tiPOrKdTI3YS4H/MlqINp2hvOC5I5TVNKXhnv/2iyj0mKrUdTzGogLTCzm9wFxOtaMP
         Zz3xePBJGmwoQ+ZikkJ59gP9OxcVIqhlIOIfXERD6UDyxOY+a2J30jwQVYLhBLJ2xBdM
         3VOw==
X-Gm-Message-State: AOAM533T7A7plVJlcP2uGXQlBuA8ZvynLAr+Ja9rUigeq/ZTstdqf7ZS
        x4ZD4bG7DOEjnvEKGFsY+FD2RiqLU9bvuGdix/pFosy350g=
X-Google-Smtp-Source: ABdhPJzRjyWFdBr5HltCd4z7bm71JYdOrZsSRUuNoWy4DyikEu7SE2W8cMJ25NmgWLn8OTjw3wqbX2rnNlrxUEEX44I=
X-Received: by 2002:a05:6e02:1be6:: with SMTP id y6mr4840036ilv.145.1612551558458;
 Fri, 05 Feb 2021 10:59:18 -0800 (PST)
MIME-Version: 1.0
References: <20210205062719.74431-1-songmuchun@bytedance.com>
 <YB0DnAlCaQza4Uf9@dhcp22.suse.cz> <CAMZfGtVhBrwgkJVwiah6eDsppSf8fYp+uZ=tZmHBLDFeTmQX3w@mail.gmail.com>
 <YB0euLiMU+T/9bMK@dhcp22.suse.cz> <YB2LTIeTPN72Xrxj@cmpxchg.org>
In-Reply-To: <YB2LTIeTPN72Xrxj@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 5 Feb 2021 10:59:06 -0800
Message-ID: <CALvZod6Z-C_2Dg0iAc2XA6AQTj9jHovjVuoM6QqPRUmjP3Fu=Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: remove rcu_read_lock from get_mem_cgroup_from_page
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 5, 2021 at 10:31 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, Feb 05, 2021 at 11:32:24AM +0100, Michal Hocko wrote:
> > On Fri 05-02-21 17:14:30, Muchun Song wrote:
> > > On Fri, Feb 5, 2021 at 4:36 PM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Fri 05-02-21 14:27:19, Muchun Song wrote:
> > > > > The get_mem_cgroup_from_page() is called under page lock, so the page
> > > > > memcg cannot be changed under us.
> > > >
> > > > Where is the page lock enforced?
> > >
> > > Because it is called from alloc_page_buffers(). This path is under
> > > page lock.
> >
> > I do not see any page lock enforecement there. There is not even a
> > comment requiring that. Can we grow more users where this is not the
> > case? There is no actual relation between alloc_page_buffers and
> > get_mem_cgroup_from_page except that the former is the only _current_
> > existing user. I would be careful to dictate locking based solely on
> > that.
>
> Since alloc_page_buffers() holds the page lock throughout the entire
> time it uses the memcg, there is no actual reason for it to use RCU or
> even acquire an additional reference on the css. We know it's pinned,
> the charge pins it, and the page lock pins the charge. It can neither
> move to a different cgroup nor be uncharged.
>
> So what do you say we switch alloc_page_buffers() to page_memcg()?
>
> And because that removes the last user of get_mem_cgroup_from_page(),
> we can kill it off and worry about a good interface once a consumer
> materializes for it.

This seems like even better approach.

>
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 96c7604f69b3..12a10f461b81 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -847,7 +847,7 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
>         if (retry)
>                 gfp |= __GFP_NOFAIL;
>
> -       memcg = get_mem_cgroup_from_page(page);
> +       memcg = page_memcg(page);

A comment explaining why page_memcg(page) is safe here and then the
patch looks good to me.

>         old_memcg = set_active_memcg(memcg);
>
>         head = NULL;
> @@ -868,7 +868,6 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
>         }
>  out:
>         set_active_memcg(old_memcg);
> -       mem_cgroup_put(memcg);
>         return head;
>  /*
>   * In case anything failed, we just free everything we got.
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index a8c7a0ccc759..a44b2d51aecc 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -687,8 +687,6 @@ struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
>
>  struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
>
> -struct mem_cgroup *get_mem_cgroup_from_page(struct page *page);
> -
>  struct lruvec *lock_page_lruvec(struct page *page);
>  struct lruvec *lock_page_lruvec_irq(struct page *page);
>  struct lruvec *lock_page_lruvec_irqsave(struct page *page,
> @@ -1169,11 +1167,6 @@ static inline struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
>         return NULL;
>  }
>
> -static inline struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
> -{
> -       return NULL;
> -}
> -
>  static inline void mem_cgroup_put(struct mem_cgroup *memcg)
>  {
>  }
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 490357945f2c..ff52550d2f65 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1048,29 +1048,6 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
>  }
>  EXPORT_SYMBOL(get_mem_cgroup_from_mm);
>
> -/**
> - * get_mem_cgroup_from_page: Obtain a reference on given page's memcg.
> - * @page: page from which memcg should be extracted.
> - *
> - * Obtain a reference on page->memcg and returns it if successful. Otherwise
> - * root_mem_cgroup is returned.
> - */
> -struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
> -{
> -       struct mem_cgroup *memcg = page_memcg(page);
> -
> -       if (mem_cgroup_disabled())
> -               return NULL;
> -
> -       rcu_read_lock();
> -       /* Page should not get uncharged and freed memcg under us. */
> -       if (!memcg || WARN_ON_ONCE(!css_tryget(&memcg->css)))
> -               memcg = root_mem_cgroup;
> -       rcu_read_unlock();
> -       return memcg;
> -}
> -EXPORT_SYMBOL(get_mem_cgroup_from_page);
> -
>  static __always_inline struct mem_cgroup *active_memcg(void)
>  {
>         if (in_interrupt())
