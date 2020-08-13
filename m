Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CDB243B98
	for <lists+cgroups@lfdr.de>; Thu, 13 Aug 2020 16:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgHMOc7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Aug 2020 10:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgHMOc7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Aug 2020 10:32:59 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE2FC061757;
        Thu, 13 Aug 2020 07:32:58 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id v6so7431111iow.11;
        Thu, 13 Aug 2020 07:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3t8eGrZXM10uYzb31bPcLIKkAbsLARz4dGnB5Cy2z60=;
        b=TWdedpVEAeL5F4lIHfRmXjcM2gOol8GetJGIbvGEfn2PzRRvGuQmT9qms8dyox4tBC
         TV4olmsqv+0yl4gwyaxhsyMADP4gykCx7w0DeuEAK0G0iKyTcxtK409+XnpWCKn77hM9
         fGLuSGnkag+rfc+u0KvKsUoGTz7XH2m7xDeTKGi6QXOlYKfSDhZe+K/6trEwSbHHWdGN
         on+Ef55218X7FivayasbemenUR1HH+CVbum0FuKSmuDOJ5sg5KBdBa3eiKWnW5DcE1FA
         Nqq/G/Qfu86pN4x96xifFsjaO08utj7p933Ow7bdiPB9+wF2p1BIdWkeFyTKPxrrVnkh
         3M3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3t8eGrZXM10uYzb31bPcLIKkAbsLARz4dGnB5Cy2z60=;
        b=RNbiWdL8oJYTsYa2/zcmMAyeBjuMA51XhJKcEwl7YtWE77RjdTyG7yNgwpx59SSfe7
         +qRRZomBcXCEX1+x40W9cKEDJ8B96dGwVjkboEkIMtDC2eSWD7p4YUMpSsDlFz7Meg1f
         SDdyc3YZBmLyOt1VXSmB2+7gj1yybavySpB7d8RIrtoM62q773G/2i15QClBLLWP0620
         iOHYsYki7VdSUgHOV1jOd/vmZrQrwVuWgcFMe//xiKTB4Xl9Hh0nbbnafPlqHEj/Uj5g
         28Ab2DtpS/fj/TOvHuYW7pzX6WIpfOw0jXikUdzWFoMNzo1XjbivAlgCAohfK/4zcP7h
         z7dA==
X-Gm-Message-State: AOAM533SqFpgQrdM6DnhCyUctXCnAwy+1Zqk98L3NZnXBF+HJ5OAjEyl
        qi29yV6/Ba6sGzFbTT+T0ilcxp3QdtMYwdyXQcA=
X-Google-Smtp-Source: ABdhPJwfgtmbxCwJdo0mgmwrDG+x4UEu/0RCzfB6YOy8Mg4PEVKtUqPRqlJrLwfvIg901BirRGdH+47G6zM8fBc3IDg=
X-Received: by 2002:a6b:da0d:: with SMTP id x13mr5199494iob.138.1597329177753;
 Thu, 13 Aug 2020 07:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200813035100.13054.25671.stgit@localhost.localdomain>
 <20200813040224.13054.96724.stgit@localhost.localdomain> <8ea9e186-b223-fb1b-5c82-2aa43c5e9f10@linux.alibaba.com>
In-Reply-To: <8ea9e186-b223-fb1b-5c82-2aa43c5e9f10@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 13 Aug 2020 07:32:46 -0700
Message-ID: <CAKgT0UcRFqXUOJ+QjgtjdQE6A7EMgAc_v9b7+mXy-ZJLvG2AgQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] mm: Drop locked from isolate_migratepages_block
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        kbuild test robot <lkp@intel.com>,
        Rong Chen <rong.a.chen@intel.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 12, 2020 at 11:57 PM Alex Shi <alex.shi@linux.alibaba.com> wrot=
e:
>
>
>
> =E5=9C=A8 2020/8/13 =E4=B8=8B=E5=8D=8812:02, Alexander Duyck =E5=86=99=E9=
=81=93:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > We can drop the need for the locked variable by making use of the
> > lruvec_holds_page_lru_lock function. By doing this we can avoid some rc=
u
> > locking ugliness for the case where the lruvec is still holding the LRU
> > lock associated with the page. Instead we can just use the lruvec and i=
f it
> > is NULL we assume the lock was released.
> >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
> >  mm/compaction.c |   45 ++++++++++++++++++++-------------------------
> >  1 file changed, 20 insertions(+), 25 deletions(-)
>
> Thanks a lot!
> Don't know if community is ok if we keep the patch following whole patchs=
et alone?

I am fine with you squashing it with another patch if you want. In
theory this could probably be squashed in with the earlier patch I
submitted that introduced lruvec_holds_page_lru_lock or some other
patch. It is mostly just a cleanup anyway as it gets us away from
needing to hold the RCU read lock in the case that we already have the
correct lruvec.
