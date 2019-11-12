Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13B02F9AC9
	for <lists+cgroups@lfdr.de>; Tue, 12 Nov 2019 21:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKLUeS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Nov 2019 15:34:18 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34719 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfKLUeS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Nov 2019 15:34:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id j18so3207856wmk.1
        for <cgroups@vger.kernel.org>; Tue, 12 Nov 2019 12:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w2HWZCYTuyG/iiIWgucV3SL/wKiXCiXBU5oRVlG/JoY=;
        b=nIfBYYpx2BPy8Ny2KgYnvusMIUoId7JvzJVuq3x4uT3Ce5l33QonIgnPodqpzgfLnk
         KwUjAuYZyyC504ndkw8KH/zz1rB8QWChYirmO4TSeQRJ6uW970ne8kuJ64kiTf0mP6tZ
         9ZZS1D4Xr29niL4OXMBJhIWVbzrtBr4f5Gfee8T9zAZSGa+P8TpFWxnmeZbIMKgJCZ30
         +1tG1fXzk837jA0obwmLORJ95JlTbdlhD4AAy0UG/RNvvw71D1IifjG6atHbmC0HWnxf
         bjCtQ/mXtEzj3NNFH/q/nufeqZqdwQMDoM+7iXWW0rH2UrGK1DgF9QP5YIrOobEwuu7e
         uzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w2HWZCYTuyG/iiIWgucV3SL/wKiXCiXBU5oRVlG/JoY=;
        b=BhugdiRHEvW6C6ndTd9NchX0X/6vxltIu+h7fMcJ9P5iJUfQK3t0kcBBQAYFS1J+sG
         usvb9+HZGYfmr1CxJidH79A1INM9DiZnudgku1OIopqfeiSf6rxjzbmJXIUrs8gqj/e3
         rhTihF3XvCbjsKMdPKUw3w3K+ulj7sYwRQEF5xVYfpgtR/5BqZ7Ark+zb6ZY1GCsxy9b
         4/Xcq7DSdO8WEEpY7kYrYF3qmKr/IJLNfF4O14+ftGVvKMcwGem3gyyZ1QksjhZhKvRz
         LJyjbIiJxizKtLL+NaU54ShPTWOXtEk6v3cPIJHLR2gFBTlBh4LOLN22CpQS4G/MMiaI
         dnWA==
X-Gm-Message-State: APjAAAV8TPjDSyagLn+yyKBO2K7OPCsfHJOgNJUoo+pO+F03icdf7YVP
        pT15SLbfYCTYRdgfkHAflvSHRmk+a9/cQ+mPtHWSpA==
X-Google-Smtp-Source: APXvYqzdm1vE6Jn2Mh+18qqFj1F/ivuD1zl/RbxZQOJ5F83vkznTI6U6nlIC66zByigw9coumwdcaYjoCrBFyy6cb7M=
X-Received: by 2002:a1c:8055:: with SMTP id b82mr5959862wmd.176.1573590854911;
 Tue, 12 Nov 2019 12:34:14 -0800 (PST)
MIME-Version: 1.0
References: <20191107205334.158354-1-hannes@cmpxchg.org> <20191107205334.158354-4-hannes@cmpxchg.org>
 <CAJuCfpHSTr8Vt+Tj-Hj4OBYHq1ucw7_B1VoVWKEHQVPHaMhUdA@mail.gmail.com>
 <20191112180019.GB178331@cmpxchg.org> <CAJuCfpFJ-tzqc6Ng-6ntQn46iatgOdLF5PY6WAcOHVvGSQGwMg@mail.gmail.com>
In-Reply-To: <CAJuCfpFJ-tzqc6Ng-6ntQn46iatgOdLF5PY6WAcOHVvGSQGwMg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 12 Nov 2019 12:34:03 -0800
Message-ID: <CAJuCfpFtJcp8Ry7eC=1SbQwn2rgxvKO1Ej_QjxBxEPY_dYsjBg@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: vmscan: enforce inactive:active ratio at the
 reclaim root
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 12, 2019 at 11:13 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Tue, Nov 12, 2019 at 10:00 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Sun, Nov 10, 2019 at 06:15:50PM -0800, Suren Baghdasaryan wrote:
> > > On Thu, Nov 7, 2019 at 12:53 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > @@ -2758,7 +2775,17 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> > > >                         total_high_wmark += high_wmark_pages(zone);
> > > >                 }
> > > >
> > > > -               sc->file_is_tiny = file + free <= total_high_wmark;
> > > > +               /*
> > > > +                * Consider anon: if that's low too, this isn't a
> > > > +                * runaway file reclaim problem, but rather just
> > > > +                * extreme pressure. Reclaim as per usual then.
> > > > +                */
> > > > +               anon = node_page_state(pgdat, NR_INACTIVE_ANON);
> > > > +
> > > > +               sc->file_is_tiny =
> > > > +                       file + free <= total_high_wmark &&
> > > > +                       !(sc->may_deactivate & DEACTIVATE_ANON) &&
> > > > +                       anon >> sc->priority;
> > >
> > > The name of file_is_tiny flag seems to not correspond with its actual
> > > semantics anymore. Maybe rename it into "skip_file"?
> >
> > I'm not a fan of file_is_tiny, but I also don't like skip_file. IMO
> > it's better to have it describe a situation instead of an action, in
> > case we later want to take additional action for that situation.
> >
> > Any other ideas? ;)
>
> All other ideas still yield verbs (like sc->prefer_anon). Maybe then
> add some comment at the file_is_tiny declaration that it represents
> not only the fact that the file LRU is too small to reclaim but also
> that there are easily reclaimable anon pages?
>
> >
> > > I'm confused about why !(sc->may_deactivate & DEACTIVATE_ANON) should
> > > be a prerequisite for skipping file LRU reclaim. IIUC this means we
> > > will skip reclaiming from file LRU only when anonymous page
> > > deactivation is not allowed. Could you please add a comment explaining
> > > this?
> >
> > The comment above this check tries to explain it: the definition of
> > file being "tiny" is dependent on the availability of anon. It's a
> > relative comparison.
> >
> > If file only has a few pages, and anon is easily reclaimable (does not
> > require deactivation to reclaim pages), then file is "tiny" and we
> > should go after the more plentiful anon pages.
>
> Your above explanation is much clearer to me than the one in the comment :)
>
> >
> > If anon is under duress, too, this preference doesn't make sense and
> > we should just reclaim both lists equally, as per usual.
> >
> > Note that I'm not introducing this constraint, I'm just changing how
> > it's implemented. From the patch:
> >
> > > >         /*
> > > >          * If the system is almost out of file pages, force-scan anon.
> > > > -        * But only if there are enough inactive anonymous pages on
> > > > -        * the LRU. Otherwise, the small LRU gets thrashed.
> > > >          */
> > > > -       if (sc->file_is_tiny &&
> > > > -           !inactive_list_is_low(lruvec, false, sc, false) &&
> > > > -           lruvec_lru_size(lruvec, LRU_INACTIVE_ANON,
> > > > -                           sc->reclaim_idx) >> sc->priority) {
> > > > +       if (sc->file_is_tiny) {
> > > >                 scan_balance = SCAN_ANON;
> > > >                 goto out;
> > > >         }
> >
> > So it's always been checking whether reclaim would deactivate anon,
> > and whether inactive_anon has sufficient pages for this priority.
>
> I didn't realize !inactive_list_is_low(lruvec, false, sc, false) is
> effectively the same as !(sc->may_deactivate & DEACTIVATE_ANON) but
> after re-reading the patch that makes sense... Except when
> force_deactivate==true, in which case shouldn't you consider
> NR_ACTIVE_ANON as easily reclaimable too? IOW should it be smth like
> this:
>
> anon = node_page_state(pgdat, NR_INACTIVE_ANON) +
> (sc->force_deactivate ? node_page_state(pgdat, NR_ACTIVE_ANON) : 0);
>
> ?

On second thought that proposal would not be correct since
deactivation is not the same as reclaim... So the way it is now looks
correct.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
