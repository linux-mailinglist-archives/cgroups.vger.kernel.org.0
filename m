Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0266463F0
	for <lists+cgroups@lfdr.de>; Wed,  7 Dec 2022 23:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiLGWPd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Dec 2022 17:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiLGWPa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Dec 2022 17:15:30 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F3E663CA
        for <cgroups@vger.kernel.org>; Wed,  7 Dec 2022 14:15:29 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id d128so24545221ybf.10
        for <cgroups@vger.kernel.org>; Wed, 07 Dec 2022 14:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6md11XMzi0tM9VfuttVehehretVvYJGzXswfjHRw2Yk=;
        b=FVhyDC1j451hmgMkwi1V7ZI4X8jOVWr/eIXmSC2wvcstj2nqmH63mzvSgwTtApATU7
         c5BKCleqCvOmWqkJMjNflr+8QXYBnxcOe+vMskQUHOYE6kLQMtsWp1TscflaWmBvVchW
         1+T44q440TMM6kpmml1fH/7sz02N0B0oPTP/arw7d+LG2oYA1h3b83NbFIbbTJASfxrL
         hvFcOa6aCxls9HxIdBn80Leq+fJS4b/Qu4JUpuIbAuBsk7hlWLhuzXiizfLeCfikD0Vu
         kPIHF7EbCCpHToNq47vCM2gtuZGqmzjfqNe3Itbh8AzNvl7j1zF04iWA4a0LZgTg/mUY
         hIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6md11XMzi0tM9VfuttVehehretVvYJGzXswfjHRw2Yk=;
        b=SQ29fPG3QsklxfialyEZLFxyThyn1l7m/aKmLavX8W0u/nZwT/48fhxUItWiQwMLgA
         xc0s03Udg74dqP/wLLZfpgRy6aB+Q2Rb+ji8XDHxX5aTlwCofcZqZ0BZE5b8FbnuFm3o
         9lZXoKxzoGl06CH3Pwvm/RiXW90iONHHw0U4M+GTvD9c2LxQr4pyFOv9UdwlzZdZWEpn
         3P55GPBWxDUt4KOUmlbj+0TLCLvFoxKd4NKB/aAGxTGUkN0IKjNxBl05HVurcKnIc0w4
         lArbJ3r0s5kSHaPniV9BgKQvMz2ODTs/6zkq0EaDdbBZNgcLi3dYUYw1GgyhksGrtdEy
         PFbA==
X-Gm-Message-State: ANoB5pmUqk2qOUzAtTdR131aNcg1+ou4ugimX0OoW3WD/GL3csPJNynF
        IahG2dF9WsBkbnwRxrDKmnkpKyc4rF1xYuJ5YjXvSSxEVjPWWg==
X-Google-Smtp-Source: AA0mqf7TLp05aDxpxhqV9kkhq645nCfRl6FYotHcE+YUw02Xl0zYpu/u76VpGq2O89cFFgpqbpUDHfwV18Nu9M3LsA4=
X-Received: by 2002:a25:38ce:0:b0:6f2:2d94:2404 with SMTP id
 f197-20020a2538ce000000b006f22d942404mr62740808yba.450.1670451328572; Wed, 07
 Dec 2022 14:15:28 -0800 (PST)
MIME-Version: 1.0
References: <20221206171340.139790-1-hannes@cmpxchg.org> <20221206171340.139790-4-hannes@cmpxchg.org>
 <CALvZod6WcBifeWJYG_QLr9Uy5aSbpLoCVyOp+FVx0ca1gzq4fA@mail.gmail.com> <20221207135108.fe1d51f7581f6ff86dbf9bc8@linux-foundation.org>
In-Reply-To: <20221207135108.fe1d51f7581f6ff86dbf9bc8@linux-foundation.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 7 Dec 2022 14:15:17 -0800
Message-ID: <CALvZod63UBrAGXpzs0ukdazvjmBfb61t9PCzUhjrbnDWTaP59Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: memcontrol: deprecate charge moving
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Dec 7, 2022 at 1:51 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 6 Dec 2022 16:03:54 -0800 Shakeel Butt <shakeelb@google.com> wrote:
>
> > On Tue, Dec 6, 2022 at 9:14 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > Charge moving mode in cgroup1 allows memory to follow tasks as they
> > > migrate between cgroups. This is, and always has been, a questionable
> > > thing to do - for several reasons.
> > >
> > > First, it's expensive. Pages need to be identified, locked and
> > > isolated from various MM operations, and reassigned, one by one.
> > >
> > > Second, it's unreliable. Once pages are charged to a cgroup, there
> > > isn't always a clear owner task anymore. Cache isn't moved at all, for
> > > example. Mapped memory is moved - but if trylocking or isolating a
> > > page fails, it's arbitrarily left behind. Frequent moving between
> > > domains may leave a task's memory scattered all over the place.
> > >
> > > Third, it isn't really needed. Launcher tasks can kick off workload
> > > tasks directly in their target cgroup. Using dedicated per-workload
> > > groups allows fine-grained policy adjustments - no need to move tasks
> > > and their physical pages between control domains. The feature was
> > > never forward-ported to cgroup2, and it hasn't been missed.
> > >
> > > Despite it being a niche usecase, the maintenance overhead of
> > > supporting it is enormous. Because pages are moved while they are live
> > > and subject to various MM operations, the synchronization rules are
> > > complicated. There are lock_page_memcg() in MM and FS code, which
> > > non-cgroup people don't understand. In some cases we've been able to
> > > shift code and cgroup API calls around such that we can rely on native
> > > locking as much as possible. But that's fragile, and sometimes we need
> > > to hold MM locks for longer than we otherwise would (pte lock e.g.).
> > >
> > > Mark the feature deprecated. Hopefully we can remove it soon.
> > >
> > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> >
> > Acked-by: Shakeel Butt <shakeelb@google.com>
> >
> > I would request this patch to be backported to stable kernels as well
> > for early warnings to users which update to newer kernels very late.
>
> Sounds reasonable, but the changelog should have a few words in it
> explaining why we're requesting the backport.  I guess I can type those
> in.

Thanks a lot.

>
> We're at -rc8 and I'm not planning on merging these up until after
> 6.2-rc1 is out.  Please feel free to argue with me on that score.

No, I totally agree with you. There is no such urgency in merging
these and a couple of weeks delay is totally fine.
