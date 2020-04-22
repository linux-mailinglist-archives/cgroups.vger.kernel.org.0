Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394301B4AE2
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2020 18:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgDVQve (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Apr 2020 12:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgDVQvd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Apr 2020 12:51:33 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B14C03C1A9
        for <cgroups@vger.kernel.org>; Wed, 22 Apr 2020 09:51:33 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x23so2298258lfq.1
        for <cgroups@vger.kernel.org>; Wed, 22 Apr 2020 09:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WMU2sdANRlebnl16w8n5PRa+nqFLI55fKcb7gFihZwY=;
        b=lb8r9xb492dHP5+E9i8W4r6C52dw70KTq4NynepcjSjXvxIqTqRhzsIw/ttkMxrwR+
         j65ZyTEhp61QhtOvHDWc1S1Gaoob8C7seTN0+h615yPlj2d3h6iKXEMBokSYRM7iBfw2
         wOx+DdKKvbiST5q/iSH8Zo6nzHoqELKr4D8cflowDrI/wIZIsZtR+puJFNCBBOQxCPFP
         zooVfRTMyWh0vdBpp4pjpVqBJTo8TpjwReKJMe+TIa/g0NEZPob/vo8o5fdY5lKWvlhe
         SAcrPWWpLCQCvjII891JE5HLeOF2Tg1gHwGQ+Pq6Z6lAAH1rPcLwEnbLP6JvB8ttEoSE
         Mstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WMU2sdANRlebnl16w8n5PRa+nqFLI55fKcb7gFihZwY=;
        b=GwGFQrDCl+P8+aO87uw33nzB3CX5d4TK43iNN96f5O0WlkLlKD2rl8L2NP+29JdmMt
         482PjJK9RQ23avwqJx9BRrCdi3Q6CMmeiQFZc0P4hlgYgxmQ6kFRnpcFfcMvbpzflIG0
         ftEOqd2hNj/j/Q1aNH7LxyO8+PxzL9kYR+pW1ylWIFEVHX0UFN73IQpiyPTu+7S4Ru5T
         uqZsVVXEFG/q3PrncmlHLh5p+syrqnAKXJ2Y6jvDM/HHUgLK/r4C78JueZRPx2Uqqg20
         tkP5p/bwQ3KxhOwJGY3+FpURz1Z/EbJp+NxuIudmKb1PApdKYuRTwzrDDOP41RlgO9PZ
         gGEw==
X-Gm-Message-State: AGi0Pub1q2JG5kKQWN3ZDCvHsV5FWb5SxUwL4LLhLjUCbTsHRPscBkEE
        Rq7D/ZVNuA965abBZCDFPZVZuB6RWBF9w/CTXVBb/A==
X-Google-Smtp-Source: APiQypJtQGrxDfBO6FRzQwyn1VRRG66vnIy7KhdMUkT0BoBj6QcZuE2W1TDMuCsZHxMwE+LdhOg4VSc5w+oEWJXa/vc=
X-Received: by 2002:a19:7407:: with SMTP id v7mr17903201lfe.124.1587574291394;
 Wed, 22 Apr 2020 09:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200420221126.341272-1-hannes@cmpxchg.org> <20200420221126.341272-3-hannes@cmpxchg.org>
In-Reply-To: <20200420221126.341272-3-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 22 Apr 2020 09:51:20 -0700
Message-ID: <CALvZod4gFC1TDo8dtdaeQKj_ZEoOnQvRnw_dZANH7qQYCmnnGA@mail.gmail.com>
Subject: Re: [PATCH 02/18] mm: memcontrol: fix theoretical race in charge moving
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Joonsoo Kim <js1304@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 20, 2020 at 3:11 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> The move_lock is a per-memcg lock, but the VM accounting code that
> needs to acquire it comes from the page and follows page->mem_cgroup
> under RCU protection. That means that the page becomes unlocked not
> when we drop the move_lock, but when we update page->mem_cgroup. And
> that assignment doesn't imply any memory ordering. If that pointer
> write gets reordered against the reads of the page state -
> page_mapped, PageDirty etc. the state may change while we rely on it
> being stable and we can end up corrupting the counters.
>
> Place an SMP memory barrier to make sure we're done with all page
> state by the time the new page->mem_cgroup becomes visible.
>
> Also replace the open-coded move_lock with a lock_page_memcg() to make
> it more obvious what we're serializing against.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/memcontrol.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5beea03dd58a..41f5ed79272e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5372,7 +5372,6 @@ static int mem_cgroup_move_account(struct page *page,
>  {
>         struct lruvec *from_vec, *to_vec;
>         struct pglist_data *pgdat;
> -       unsigned long flags;
>         unsigned int nr_pages = compound ? hpage_nr_pages(page) : 1;
>         int ret;
>         bool anon;
> @@ -5399,18 +5398,13 @@ static int mem_cgroup_move_account(struct page *page,
>         from_vec = mem_cgroup_lruvec(from, pgdat);
>         to_vec = mem_cgroup_lruvec(to, pgdat);
>
> -       spin_lock_irqsave(&from->move_lock, flags);
> +       lock_page_memcg(page);
>
>         if (!anon && page_mapped(page)) {
>                 __mod_lruvec_state(from_vec, NR_FILE_MAPPED, -nr_pages);
>                 __mod_lruvec_state(to_vec, NR_FILE_MAPPED, nr_pages);
>         }
>
> -       /*
> -        * move_lock grabbed above and caller set from->moving_account, so
> -        * mod_memcg_page_state will serialize updates to PageDirty.
> -        * So mapping should be stable for dirty pages.
> -        */
>         if (!anon && PageDirty(page)) {
>                 struct address_space *mapping = page_mapping(page);
>
> @@ -5426,15 +5420,23 @@ static int mem_cgroup_move_account(struct page *page,
>         }
>
>         /*
> +        * All state has been migrated, let's switch to the new memcg.
> +        *
>          * It is safe to change page->mem_cgroup here because the page
> -        * is referenced, charged, and isolated - we can't race with
> -        * uncharging, charging, migration, or LRU putback.
> +        * is referenced, charged, isolated, and locked: we can't race
> +        * with (un)charging, migration, LRU putback, or anything else
> +        * that would rely on a stable page->mem_cgroup.
> +        *
> +        * Note that lock_page_memcg is a memcg lock, not a page lock,
> +        * to save space. As soon as we switch page->mem_cgroup to a
> +        * new memcg that isn't locked, the above state can change
> +        * concurrently again. Make sure we're truly done with it.
>          */
> +       smp_mb();

You said theoretical race in the subject but the above comment
convinced me that smp_mb() is required. So, why is the race still
theoretical?

>
> -       /* caller should have done css_get */
> -       page->mem_cgroup = to;
> +       page->mem_cgroup = to;  /* caller should have done css_get */
>
> -       spin_unlock_irqrestore(&from->move_lock, flags);
> +       __unlock_page_memcg(from);
>
>         ret = 0;
>
> --
> 2.26.0
>
