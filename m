Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E733C1315E8
	for <lists+cgroups@lfdr.de>; Mon,  6 Jan 2020 17:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgAFQSq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Jan 2020 11:18:46 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:39528 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgAFQSp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Jan 2020 11:18:45 -0500
Received: by mail-io1-f66.google.com with SMTP id c16so19316370ioh.6;
        Mon, 06 Jan 2020 08:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1iBF+C1NHazjfiJGahas8jIgSGj241V/MA8/jj2HpLE=;
        b=ScZ+BLpeYEmcBri4/E40jt+m15BKdbAIG7h7sy3ejJj/Dtb+nL8mk9HYuTan58Ac5v
         1jtRC/XgW9iWes1rejXCb5Nkiv5JXH6T9ZGxBYCL+6tKO6G18SbfNq01Hee7NCjGU29q
         sPkjPpV3m1fQxCSNdaOmoqXu4lvyH7Q5dXDZKFCvLTwrQW1XaQf0NumtQUoDu2227ya2
         DfJoLQvdnFKa7/6WrrmLuPVLOmX1NyFUKfWqUg8DzsYodq7qhN3ILwABQCrq9awbO9fu
         r430448Ffc4Qp7BbEPtygBu1l6bcwp97AvALV4Cn3puvjnJCSlDYaTHUm59DJXzKmGPX
         vWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1iBF+C1NHazjfiJGahas8jIgSGj241V/MA8/jj2HpLE=;
        b=GZQ1w8XmTm9Ht6miyey856EK2nPlhFQIf3FUC2xQQPWkacn/ZKYmxn8zvotIMzwXHg
         CyiSuKUI2pBrtMb2hLxsgAFJYUeB+v0RknYNHpJ5UAWjqNnppiY4ozJmlYady6HR91Kx
         4b647hUP+GzPNKyg9BaqLI1ltbrVntjSVtTW+hk+983ew6NLLRn0SssFYt0IStSOdvt2
         dtL5Tbrex8sNC26FA3pMWeZTHoL/jfrgSu/W2DI0V09tr6+LYH3ftbOOXm2KkRgGi5VF
         rLULkJkefmHkZavXnzj+d1h31xvRyk5KHHvNn0wA0SspNXQ5oflAoGGb3IhwSKPG5+zw
         gwQw==
X-Gm-Message-State: APjAAAXwzN7EZdWQB2LuHJvLAaGfjP7kZqAdnk5Up6uwn/djq5s24NUw
        DTNzRJ91Dxzddgff5ojxJmuiBVb7h1JLYf6sGAi4oO/8v5A=
X-Google-Smtp-Source: APXvYqzuPLiJ4vUg0YkwQhUHnUnwKKB/CsT/pr8SpYnnKWoouOidOXCDH2ImDMv0T/GGKjlvg+D0xcL+eVRS4FkS4C8=
X-Received: by 2002:a5d:80d9:: with SMTP id h25mr63343225ior.97.1578327524845;
 Mon, 06 Jan 2020 08:18:44 -0800 (PST)
MIME-Version: 1.0
References: <20200103143407.1089-1-richardw.yang@linux.intel.com>
In-Reply-To: <20200103143407.1089-1-richardw.yang@linux.intel.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 6 Jan 2020 08:18:34 -0800
Message-ID: <CAKgT0Uf+EP8yGf93=R3XK0Y=0To0KQDys0O1BkG-Odej3Rwj5A@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: thp: grab the lock before manipulation defer list
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, vdavydov.dev@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        cgroups@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 3, 2020 at 6:34 AM Wei Yang <richardw.yang@linux.intel.com> wrote:
>
> As all the other places, we grab the lock before manipulate the defer list.
> Current implementation may face a race condition.
>
> Fixes: 87eaceb3faa5 ("mm: thp: make deferred split shrinker memcg aware")
>
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>
> ---
> I notice the difference during code reading and just confused about the
> difference. No specific test is done since limited knowledge about cgroup.
>
> Maybe I miss something important?
> ---
>  mm/memcontrol.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index bc01423277c5..62b7ec34ef1a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5368,12 +5368,12 @@ static int mem_cgroup_move_account(struct page *page,
>         }
>
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +       spin_lock(&from->deferred_split_queue.split_queue_lock);
>         if (compound && !list_empty(page_deferred_list(page))) {
> -               spin_lock(&from->deferred_split_queue.split_queue_lock);
>                 list_del_init(page_deferred_list(page));
>                 from->deferred_split_queue.split_queue_len--;
> -               spin_unlock(&from->deferred_split_queue.split_queue_lock);
>         }
> +       spin_unlock(&from->deferred_split_queue.split_queue_lock);
>  #endif
>         /*
>          * It is safe to change page->mem_cgroup here because the page

So I suspect the lock placement has to do with the compound boolean
value passed to the function.

One thing you might want to do is pull the "if (compound)" check out
and place it outside of the spinlock check. It would then simplify
this signficantly so it is something like
if (compound) {
  spin_lock();
  list = page_deferred_list(page);
  if (!list_empty(list)) {
    list_del_init(list);
    from->..split_queue_len--;
  }
  spin_unlock();
}

Same for the block below. I would pull the check for compound outside
of the spinlock call since it is a value that shouldn't change and
would eliminate an unnecessary lock in the non-compound case.

> @@ -5385,13 +5385,13 @@ static int mem_cgroup_move_account(struct page *page,
>         page->mem_cgroup = to;
>
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +       spin_lock(&to->deferred_split_queue.split_queue_lock);
>         if (compound && list_empty(page_deferred_list(page))) {
> -               spin_lock(&to->deferred_split_queue.split_queue_lock);
>                 list_add_tail(page_deferred_list(page),
>                               &to->deferred_split_queue.split_queue);
>                 to->deferred_split_queue.split_queue_len++;
> -               spin_unlock(&to->deferred_split_queue.split_queue_lock);
>         }
> +       spin_unlock(&to->deferred_split_queue.split_queue_lock);
>  #endif
>
>         spin_unlock_irqrestore(&from->move_lock, flags);
> --
