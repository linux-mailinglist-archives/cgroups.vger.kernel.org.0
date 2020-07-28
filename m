Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980E5230CC6
	for <lists+cgroups@lfdr.de>; Tue, 28 Jul 2020 16:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbgG1OyO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Jul 2020 10:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730455AbgG1OyN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Jul 2020 10:54:13 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748C8C061794;
        Tue, 28 Jul 2020 07:54:13 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id q75so12878716iod.1;
        Tue, 28 Jul 2020 07:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rlXEKJ8xEIOgNHiN29J7TVPDIEGm7u8gbZy3u1s9Ctw=;
        b=t5IBgxDmqzCT6sfkH5/d8FUEdSDdI2dJz1S8qZ1ZiU+8a6LEYgoUdHC7V+GMiMw/5Y
         TVjf/4KKXxfObmWFzed1Ov64eHn8wDiSC4LJTQC1LV6suKmQw72Wnud2TRs6QafppeYq
         +RTfvgb55wEeFd2AOM4jJHQOkfgm44l0ROWwTVjPmaW4J3ZwHRF747lsegTE9kOxt2nc
         lG30esH922EGIPfNLuuuNh+56AJL4x1Zpi8P2J2tfhf/C2+Fpm+kBa9PXCpksfIPy6wv
         GezNC01nzIpMgnSJn9ve9dutdqJpKucoQxvvzUOJrLX4Sr1u7TwJZ78crHveaaYoHnBY
         ydWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rlXEKJ8xEIOgNHiN29J7TVPDIEGm7u8gbZy3u1s9Ctw=;
        b=UsxwC6WxKpFg0PRTJcKKF7Ei2X0jpRsh/s1SWw6D0B37XR9wEhlcPid9uPHx08C4Zm
         9YEMJc8C4g68rO+R0v6ESKFdQv7v0fBggcXqlW4JzFgH6SK5VyrLt5TN8M1lijuST8Zk
         XxWy/veAqmGBJqldRQ1ybOXKeJ2EZ88o5yxRmtClQn8m7jOM1xfD4SM7w4tvsY81QE8G
         xGEr86iGhNhwUGST27ETSqU4lCApgOTLpkTTPQLBDXlSTCYKtuhM3nyvK3OZTRQh8sa7
         pSYMXyuY4ZmieGM5xXt5hDvY3/yZxnW4A8qRwLITWXfB8RfH6ZOUKB2qOafc82nwH1GD
         ZDSw==
X-Gm-Message-State: AOAM530P/wb6g7Z6tkrt4W/7/FxhZZJrbTXx3w/RytrukDwhD016mtxk
        kbVVSmOV/LAEqlTKu8/fNpHevpKXivBz0ZIqpGs=
X-Google-Smtp-Source: ABdhPJzsjlGbnYWKWKFNjvkbjOng3dZaS0dcx1SQ26KWeacdxavQUtITJe1QdcIRNEyS9V0x9BCYJakotwCelSWEajY=
X-Received: by 2002:a05:6638:771:: with SMTP id y17mr32711779jad.96.1595948052581;
 Tue, 28 Jul 2020 07:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
 <1595681998-19193-18-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0UdaW4Rf43yULhQBuP07vQgmoPbaWHGKv1Z7fEPP6jH83w@mail.gmail.com> <ccd01046-451c-463d-7c5d-9c32794f4b1e@linux.alibaba.com>
In-Reply-To: <ccd01046-451c-463d-7c5d-9c32794f4b1e@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 28 Jul 2020 07:54:01 -0700
Message-ID: <CAKgT0UdrQpa9OSusi=TZoj4RgC63-BNiF1GmeTG=rS47r7rGvQ@mail.gmail.com>
Subject: Re: [PATCH v17 17/21] mm/lru: replace pgdat lru_lock with lruvec lock
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        kbuild test robot <lkp@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Rong Chen <rong.a.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jul 28, 2020 at 4:20 AM Alex Shi <alex.shi@linux.alibaba.com> wrote=
:
>
>
>
> =E5=9C=A8 2020/7/28 =E4=B8=8A=E5=8D=887:34, Alexander Duyck =E5=86=99=E9=
=81=93:
> >> @@ -1876,6 +1876,12 @@ static unsigned noinline_for_stack move_pages_t=
o_lru(struct lruvec *lruvec,
> >>                  *                                        list_add(&pa=
ge->lru,)
> >>                  *     list_add(&page->lru,) //corrupt
> >>                  */
> >> +               new_lruvec =3D mem_cgroup_page_lruvec(page, page_pgdat=
(page));
> >> +               if (new_lruvec !=3D lruvec) {
> >> +                       if (lruvec)
> >> +                               spin_unlock_irq(&lruvec->lru_lock);
> >> +                       lruvec =3D lock_page_lruvec_irq(page);
> >> +               }
> >>                 SetPageLRU(page);
> >>
> >>                 if (unlikely(put_page_testzero(page))) {
> > I was going through the code of the entire patch set and I noticed
> > these changes in move_pages_to_lru. What is the reason for adding the
> > new_lruvec logic? My understanding is that we are moving the pages to
> > the lruvec provided are we not?If so why do we need to add code to get
> > a new lruvec? The code itself seems to stand out from the rest of the
> > patch as it is introducing new code instead of replacing existing
> > locking code, and it doesn't match up with the description of what
> > this function is supposed to do since it changes the lruvec.
>
> this new_lruvec is the replacement of removed line, as following code:
> >> -               lruvec =3D mem_cgroup_page_lruvec(page, pgdat);
> This recheck is for the page move the root memcg, otherwise it cause the =
bug:

Okay, now I see where the issue is. You moved this code so now it has
a different effect than it did before. You are relocking things before
you needed to. Don't forget that when you came into this function you
already had the lock. In addition the patch is broken as it currently
stands as you aren't using similar logic in the code just above this
addition if you encounter an evictable page. As a result this is
really difficult to review as there are subtle bugs here.

I suppose the correct fix is to get rid of this line, but  it should
be placed everywhere the original function was calling
spin_lock_irq().

In addition I would consider changing the arguments/documentation for
move_pages_to_lru. You aren't moving the pages to lruvec, so there is
probably no need to pass that as an argument. Instead I would pass
pgdat since that isn't going to be moving and is the only thing you
actually derive based on the original lruvec.
