Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 951A3E4D3
	for <lists+cgroups@lfdr.de>; Mon, 29 Apr 2019 16:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfD2OhU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Apr 2019 10:37:20 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:40136 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbfD2OhU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Apr 2019 10:37:20 -0400
Received: by mail-yb1-f194.google.com with SMTP id q17so3848582ybg.7
        for <cgroups@vger.kernel.org>; Mon, 29 Apr 2019 07:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M/6XEsIqR8VWQpLXIhH0FRoDcnonKS2KQt8PYqdEcmQ=;
        b=ms9nqUQx6QnRoflbPjYgEjlFy2Y9D0/6+0G9VqgYNlscBxoReHFFvdNWni+KPvrniA
         LyI6meDC6xaCQQcZpNBsWnausZSGUkfQLsxB2kAWos+57OQ52Pucuo8tCUdUsIudCDHZ
         vElK/QYsTago67Nbpl89mqFDK5RGuySBGU82zoLexyXiz1juRlqppKtH90OmOxaXTtwX
         Fio82mWAZZel9R/jB+y1QQYy4IHkRmjTMwdLDcuhsJpgFPqDu7u+6OKrhzVYEH2LN4R6
         NvvyeAIeOtREkegp0JCSBfdKaIbf9KB9vV7F6z0b5Xawd5KXDHlUeFFLCsrW3vW8G+Cx
         KX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M/6XEsIqR8VWQpLXIhH0FRoDcnonKS2KQt8PYqdEcmQ=;
        b=e7lh81bGB2bT+VAnSiu0w5ChMu67ILPIbJMUFpKr10FLoem68X4hXopz0KdVmK4L34
         NJNMpsIGz8arLSMF59Yqnlluz1uBhYcS9HGkKd2TNPRgwv4I0TC757La9MqGBo4FjC2G
         gVKoy3Gj8KzHzLw0SqEpL651pTjfhIhBg9cuwFT0bIX0KSlepmxFGu/La1NWAGIUYLDo
         vOQw16Imr57kJByzVJKas01fyEt1CqZbyCC9IDQ606OxuTH630yj77bzW3cPzqcHRPvE
         myEc96f7xz+zGIB297Bk3qMq0ipMEmPHHCAhSRgxnHSyeZpGyrdYDTmfUWBMxOnbOezX
         PZWQ==
X-Gm-Message-State: APjAAAWUM4JXJattycsYu6ZALBkSllBQ6Wumo3QTQ92umNtNlJ3xAhyS
        oiHiOVhTVBtMMyWHgtSrVNceSMgd2DK63QDqq59qkWgbfFg=
X-Google-Smtp-Source: APXvYqx/Z+xcfTj7msxd406E4QiWuVUE8NaIn1RLZw9Lw5xls8pb2+5DuUvvMRyfEQAXJ9Frvtwob28ZJJDlwvkGBe4=
X-Received: by 2002:a25:f507:: with SMTP id a7mr49459321ybe.164.1556548639264;
 Mon, 29 Apr 2019 07:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190428235613.166330-1-shakeelb@google.com> <20190429122214.GK21837@dhcp22.suse.cz>
In-Reply-To: <20190429122214.GK21837@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 29 Apr 2019 07:37:08 -0700
Message-ID: <CALvZod6-EOAkcuiuBpoE6uR2DFNUkUY8syHxenFEAZTxhgNMhQ@mail.gmail.com>
Subject: Re: [PATCH] memcg, oom: no oom-kill for __GFP_RETRY_MAYFAIL
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 29, 2019 at 5:22 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Sun 28-04-19 16:56:13, Shakeel Butt wrote:
> > The documentation of __GFP_RETRY_MAYFAIL clearly mentioned that the
> > OOM killer will not be triggered and indeed the page alloc does not
> > invoke OOM killer for such allocations. However we do trigger memcg
> > OOM killer for __GFP_RETRY_MAYFAIL. Fix that.
>
> An example of __GFP_RETRY_MAYFAIL memcg OOM report would be nice. I
> thought we haven't been using that flag for memcg allocations yet.
> But this is definitely good to have addressed.

Actually I am planning to use it for memcg allocations (specifically
fsnotify allocations).

>
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks.

>
> > ---
> >  mm/memcontrol.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 2713b45ec3f0..99eca724ed3b 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2294,7 +2294,6 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >       unsigned long nr_reclaimed;
> >       bool may_swap = true;
> >       bool drained = false;
> > -     bool oomed = false;
> >       enum oom_status oom_status;
> >
> >       if (mem_cgroup_is_root(memcg))
> > @@ -2381,7 +2380,7 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >       if (nr_retries--)
> >               goto retry;
> >
> > -     if (gfp_mask & __GFP_RETRY_MAYFAIL && oomed)
> > +     if (gfp_mask & __GFP_RETRY_MAYFAIL)
> >               goto nomem;
> >
> >       if (gfp_mask & __GFP_NOFAIL)
> > @@ -2400,7 +2399,6 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >       switch (oom_status) {
> >       case OOM_SUCCESS:
> >               nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
> > -             oomed = true;
> >               goto retry;
> >       case OOM_FAILED:
> >               goto force;
> > --
> > 2.21.0.593.g511ec345e18-goog
> >
>
> --
> Michal Hocko
> SUSE Labs
