Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1965162FD3
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2020 20:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgBRTZa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 Feb 2020 14:25:30 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44964 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgBRTZ1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 Feb 2020 14:25:27 -0500
Received: by mail-ot1-f68.google.com with SMTP id h9so20623659otj.11
        for <cgroups@vger.kernel.org>; Tue, 18 Feb 2020 11:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ckyuMsvFFux27LQS5gOMapLWD0YEn71aKg1bpT/CAjA=;
        b=LInPmrzntLI+jey3b9w6N4OrF2TdfG25R+K2QF/mwg6GTKX2jDpNjmqDrf8XptazpF
         0eJnz6Q1Nly0gjKtPY5OS3iUmwv2lWV1k8wAwe2ozY+oI5mVBxRPMXXZihTZQor5kX0u
         3Z77DqUqb83Gcv5APxzKjWL+9YImg9aDivBa0Yw8wOsd48e1PeNJhVnQoYPq+5fWyPQ7
         UY64+pNkMncc7yibup3yOtrxNd1WCEAXPZPTFTY3lPqdM23ARdrIdLB7gIW137/Ml04T
         QIo328ZrSU7GsXA8u/PQQuXj4f+n8xkH3xf7jSC/xzzDjs/3KufJnszHAFlIni42hjyI
         z/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ckyuMsvFFux27LQS5gOMapLWD0YEn71aKg1bpT/CAjA=;
        b=V+hm/4ayJg1UwFkSePe5l2U0kHTAy8mwOVVhbth82jtw2RkBaFz846cKhLYJmLh11P
         c4EhINhMntcs5SWQN5VJxj1y/hZwL/OPOP8PaDgtLSxbmKwM7PSrMlGejKtgmRo/IRDx
         Hvvl45vIGlxgZ3qEZqLHclGjpEYO50DT/h3DEc/SjAJUgh3Uyr8rZ4DHZ4YgqoFuwdaO
         UaXXERZ/TQn1jm4T/rBnaUdCcejNfSvtiNLZ3Yp4yOZ5etFNE7zxBI70ZCWY677oGBZ4
         tUL2gxpIpF9mEGv3I6Oc/tNKJ4T1zT6/uVyd9V2pNy56tLj9w0CeA24G34nu+o1xq2wR
         LMtQ==
X-Gm-Message-State: APjAAAXnSuTd1jXPTdO4Z4+2ns57VfAgszwKvYIplvHSrsBxj5ZRt53H
        h0KWDDnpIgDUHhvT7oHAKQUMVsX31Q/J9SzgHemVmg==
X-Google-Smtp-Source: APXvYqxdPz6sqyLtEpkrPTZBYVznrMujoqBsbH5oFjCkK58IwNmBJxEu5A/RAN57n0ppJXZezlJKQabZ5mLB3Rudsc4=
X-Received: by 2002:a9d:6a2:: with SMTP id 31mr16569798otx.313.1582053925869;
 Tue, 18 Feb 2020 11:25:25 -0800 (PST)
MIME-Version: 1.0
References: <20200211213128.73302-1-almasrymina@google.com>
 <20200211151906.637d1703e4756066583b89da@linux-foundation.org>
 <1582035660.7365.90.camel@lca.pw> <CAHS8izO5=vKs-v9v=Di3hQXBD41+_YpYarXn1yZu9YE6SR-i6Q@mail.gmail.com>
 <d498012a-ec87-ca48-ed78-5fcdaf372888@oracle.com>
In-Reply-To: <d498012a-ec87-ca48-ed78-5fcdaf372888@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 18 Feb 2020 11:25:14 -0800
Message-ID: <CAHS8izPbMizJMNB-y9y2OViXYLStA6VT-HkWRd2hCS-5JSMwSA@mail.gmail.com>
Subject: Re: [PATCH v12 1/9] hugetlb_cgroup: Add hugetlb_cgroup reservation counter
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 18, 2020 at 11:14 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 2/18/20 10:35 AM, Mina Almasry wrote:
> > On Tue, Feb 18, 2020 at 6:21 AM Qian Cai <cai@lca.pw> wrote:
> >>
> >> On Tue, 2020-02-11 at 15:19 -0800, Andrew Morton wrote:
> >>> On Tue, 11 Feb 2020 13:31:20 -0800 Mina Almasry <almasrymina@google.com> wrote:
> >>>
> >> [ 7933.806377][T14355] ------------[ cut here ]------------
> >> [ 7933.806541][T14355] kernel BUG at mm/hugetlb.c:490!
> >> VM_BUG_ON(t - f <= 1);
> >> [ 7933.806562][T14355] Oops: Exception in kernel mode, sig: 5 [#1]
> <snip>
> > Hi Qian,
> >
> > Yes this VM_BUG_ON was added by a patch in the series ("hugetlb:
> > disable region_add file_region coalescing") so it's definitely related
> > to the series. I'm taking a look at why this VM_BUG_ON fires. Can you
> > confirm you reproduce this by running hugemmap06 from the ltp on a
> > powerpc machine? Can I maybe have your config?
> >
> > Thanks!
>
> Hi Mina,
>
> Looking at the region_chg code again, we do a
>
>         resv->adds_in_progress += *out_regions_needed;
>
> and then potentially drop the lock to allocate the needed entries.  Could
> anopther thread (only adding reservation for a single page) then come in
> and notice that there are not enough entries in the cache and hit the
> VM_BUG_ON()?

Maybe. Also I'm thinking the code thinks actual_regions_needed >=
in_regions_needed, but that doesn't seem like a guarantee. I think
this call sequence with the same t->f range would violate that:

region_chg (regions_needed=1)
region_chg (regions_needed=1)
region_add (fills in the range)
region_add (in_regions_needed = 1, actual_regions_needed = 0, so
assumptions in the code break).

Luckily it seems the ltp readily reproduces this, so I'm working on
reproducing it. I should have a fix soon, at least if I can reproduce
it as well.
