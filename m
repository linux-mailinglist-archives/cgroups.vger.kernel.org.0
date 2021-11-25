Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC2845D3A3
	for <lists+cgroups@lfdr.de>; Thu, 25 Nov 2021 04:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbhKYDdc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Nov 2021 22:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhKYDba (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 Nov 2021 22:31:30 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AB5C06175B;
        Wed, 24 Nov 2021 19:24:14 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id y12so19229891eda.12;
        Wed, 24 Nov 2021 19:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t/Nlxsq9kW/Hom8aFbXv00FjzaRJZNLNO5zx85ROZpc=;
        b=iGvZ8sbmh/4SE7+kimL/hMSaYE6r3hTAUYMI1l1prKEWmHZwP4CZeYeMDyPAmsPta+
         FwQrQaLpCEo6tG39Unv35ph6rBzGZacRiXcEqCmPHZ34POlGCVRwXkasiqA5VzzdNPV/
         f5qVk911D4yMley6KUZFDJjQ6cx060O0k7yZUCE1N92qpg9B4dFQQRTWfJ2QbFMbLw0Z
         SlnJRYLQms27nZlMngnOuPBHq/QbijNdcbDeiYrQB4czAFqQoJ4OFtH1GB0MS8pdzYt1
         cKL12skDmYNcy+0+LVCfXrzsnHNaO5ihPHcwGflVoq5v4xOEvMeVXG730b9fWi6lxWX0
         sPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t/Nlxsq9kW/Hom8aFbXv00FjzaRJZNLNO5zx85ROZpc=;
        b=7ckf2ooyRGvwsGs87J+yHv7VF/mhb/YVFAnLdglxfX+eyIuGt05EAk/fljaLv+Tv2s
         3Ag08TMQT+frHaY2eRpXSrBg/37X7ULSypYWKNB4pP2aFELud7KUZsEpr5HccQSnX+S0
         JzUkp8Uiwz6iY9f0qnkSxRw+O23rvLcrBk7kOAIF3D25CFjV8ciUD19XGRKWH6Ne8p+T
         w88CKH32FGT4+WREAl8zbAaQRC2U/kdBKYoZQZciSpvnZd3n5WFp6AAcLV/esKA8N4OQ
         yzG+3z351ZzppdL2qDZ4MQsXbU2GOXha0OX2Yk7fTAgbU0OxXWsbxNcNtW1e15UHi68s
         6f6A==
X-Gm-Message-State: AOAM533iiXbuSc40dIRGFDM8yvboXyiDwKIISF6rFTy/drIqq64L7Oxg
        yspLqd3kp1kU/YsNk4oXfBO2o08QkIvAx4zlp5knPuQ9iHEBYlT6
X-Google-Smtp-Source: ABdhPJySMgGvdmDaRvFQFVEQoB2qGvJuSyAXBbrPED7a/l3n6RMuGIvBLy1Q2Qq7q7GYTcScKEsxxfkxtjgdrHBodFY=
X-Received: by 2002:a05:6402:90c:: with SMTP id g12mr33019827edz.36.1637810653452;
 Wed, 24 Nov 2021 19:24:13 -0800 (PST)
MIME-Version: 1.0
References: <20211124151915.GA6163@haolee.io> <YZ5o/VmU59evp65J@dhcp22.suse.cz>
In-Reply-To: <YZ5o/VmU59evp65J@dhcp22.suse.cz>
From:   Hao Lee <haolee.swjtu@gmail.com>
Date:   Thu, 25 Nov 2021 11:24:02 +0800
Message-ID: <CA+PpKPmy-u_BxYMCQOFyz78t2+3uM6nR9mQeX+MPyH6H2tOOHA@mail.gmail.com>
Subject: Re: [PATCH] mm: reduce spinlock contention in release_pages()
To:     Michal Hocko <mhocko@suse.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>, vdavydov.dev@gmail.com,
        Shakeel Butt <shakeelb@google.com>, cgroups@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Nov 25, 2021 at 12:31 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 24-11-21 15:19:15, Hao Lee wrote:
> > When several tasks are terminated simultaneously, lots of pages will be
> > released, which can cause severe spinlock contention. Other tasks which
> > are running on the same core will be seriously affected. We can yield
> > cpu to fix this problem.
>
> How does this actually address the problem? You are effectivelly losing
> fairness completely.

Got it. Thanks!

> We do batch currently so no single task should be
> able to monopolize the cpu for too long. Why this is not sufficient?

uncharge and unref indeed take advantage of the batch process, but
del_from_lru needs more time to complete. Several tasks will contend
spinlock in the loop if nr is very large. We can notice a transient peak
of sys% reflecting this, and perf can also report spinlock slowpath takes
too much time. This scenario is not rare, especially when containers are
destroyed simultaneously and other latency critical tasks may be affected
by this problem. So I want to figure out a way to deal with it.

Thanks.

>
> > diff --git a/mm/swap.c b/mm/swap.c
> > index e8c9dc6d0377..91850d51a5a5 100644
> > --- a/mm/swap.c
> > +++ b/mm/swap.c
> > @@ -960,8 +960,14 @@ void release_pages(struct page **pages, int nr)
> >               if (PageLRU(page)) {
> >                       struct lruvec *prev_lruvec = lruvec;
> >
> > -                     lruvec = folio_lruvec_relock_irqsave(folio, lruvec,
> > +retry:
> > +                     lruvec = folio_lruvec_tryrelock_irqsave(folio, lruvec,
> >                                                                       &flags);
> > +                     if (!lruvec) {
> > +                             cond_resched();
> > +                             goto retry;
> > +                     }
> > +
> >                       if (prev_lruvec != lruvec)
> >                               lock_batch = 0;
> >
> > --
> > 2.31.1
>
> --
> Michal Hocko
> SUSE Labs
