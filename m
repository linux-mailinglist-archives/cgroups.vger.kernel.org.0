Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB871B4C63
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2020 20:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgDVSB5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Apr 2020 14:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726154AbgDVSB5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Apr 2020 14:01:57 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7A9C03C1A9
        for <cgroups@vger.kernel.org>; Wed, 22 Apr 2020 11:01:56 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a21so3297257ljb.9
        for <cgroups@vger.kernel.org>; Wed, 22 Apr 2020 11:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VeICkZcacX5o5DfIzM6geA/GUL/N+krHSEmjMqZ24Ck=;
        b=cL4XfOMRgrSEemK6NhlwLMnQug9WZa18bhIbX62Kuv//MMo/AbdFk7SezdnPca2O6j
         7Z98w0ubkPO7fv98GDmkR/MoSl9cfL0Tcvs92lqyqx8RfgALPRIw7IssCtZZ3wFe9zJJ
         bfi4qrCpsmOag4OR1QHluehtfQE/oHErG8BFd1HmHFdhj+yVtenXBTciJQ864x6wipD6
         cTzANHcDT4OXVOurM+RCx3wWYGawzR0anSa2YE4c6puLTIA9aIF8yMjgB7tmMkT+vw2J
         KnyQeGNi4hAiYt2r0u5LrazJnVwzSDjFXg95O4uEtTU5RRVPffX+jKrcmLxg0Y9alJJ+
         WLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VeICkZcacX5o5DfIzM6geA/GUL/N+krHSEmjMqZ24Ck=;
        b=nFwzFE8JNK1ZN8izr7Jctdss+BorpyzEgA1jPQ6hpJqmwJFBeTKHDn5pMycW6u13Gj
         yUrYP1TjNoXZYaO7icY6s3lBW785AII5D4bu6UiVn8WM11izRBvrz+gP97J0QuN5D+5O
         dxCGBzao9+FyJbRgDRAZfEVgpWCI7ERNKAAgzCNOFPzyfn6XCr2AUO7XQJ6mBNak2Hst
         pX7ples3rRHX34saCblPKUDA1gwNsdzGgtn6f3X/j/TET8j8qGGHJafcK5ZgeNjulZwN
         UumSFaS5YVygq55A6ZzsVrkvZxTnvKWeKLpFrTQ+5ad80L2ZJaH5u7uYB+Tpi7bAcNqL
         L/Pw==
X-Gm-Message-State: AGi0PuYJlXuXTRawAc5zshr9FfJM2dddLxxfrm3m8PF27q9uskcuVfQx
        TjpjoVOPvOEhbGZ1bQC5imkEQAr3JuB/KGwCzl/Lkw==
X-Google-Smtp-Source: APiQypKl3UYhU9fAxPl/IQhzSvDx7R/nce6w2dJxZfvNJTkneHQkG2mQu+SCu00s+rs+TxVR605HW1Re6IhK2rEh0+4=
X-Received: by 2002:a2e:b6cf:: with SMTP id m15mr28214ljo.168.1587578514909;
 Wed, 22 Apr 2020 11:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200420221126.341272-1-hannes@cmpxchg.org> <20200420221126.341272-3-hannes@cmpxchg.org>
 <CALvZod4gFC1TDo8dtdaeQKj_ZEoOnQvRnw_dZANH7qQYCmnnGA@mail.gmail.com> <20200422174229.GD362484@cmpxchg.org>
In-Reply-To: <20200422174229.GD362484@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 22 Apr 2020 11:01:42 -0700
Message-ID: <CALvZod63SORMunUa5nqNqLoKuz--tvcURs-sqHD0ds0uaM7cDg@mail.gmail.com>
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

On Wed, Apr 22, 2020 at 10:42 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Apr 22, 2020 at 09:51:20AM -0700, Shakeel Butt wrote:
> > On Mon, Apr 20, 2020 at 3:11 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > @@ -5426,15 +5420,23 @@ static int mem_cgroup_move_account(struct page *page,
> > >         }
> > >
> > >         /*
> > > +        * All state has been migrated, let's switch to the new memcg.
> > > +        *
> > >          * It is safe to change page->mem_cgroup here because the page
> > > -        * is referenced, charged, and isolated - we can't race with
> > > -        * uncharging, charging, migration, or LRU putback.
> > > +        * is referenced, charged, isolated, and locked: we can't race
> > > +        * with (un)charging, migration, LRU putback, or anything else
> > > +        * that would rely on a stable page->mem_cgroup.
> > > +        *
> > > +        * Note that lock_page_memcg is a memcg lock, not a page lock,
> > > +        * to save space. As soon as we switch page->mem_cgroup to a
> > > +        * new memcg that isn't locked, the above state can change
> > > +        * concurrently again. Make sure we're truly done with it.
> > >          */
> > > +       smp_mb();
> >
> > You said theoretical race in the subject but the above comment
> > convinced me that smp_mb() is required. So, why is the race still
> > theoretical?
>
> Sorry about the confusion.
>
> I said theoretical because I spotted it while thinking about the
> code. I'm not aware of any real users that suffered the consequences
> of this race condition. But they could exist in theory :-)
>
> I think it's a real bug that needs fixing.

Thanks for the clarification. I would suggest removing "theoretical"
from the subject as it undermines that a real bug is fixed by the
patch.
