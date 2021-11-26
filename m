Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8041D45E82A
	for <lists+cgroups@lfdr.de>; Fri, 26 Nov 2021 07:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359054AbhKZHDE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 Nov 2021 02:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359129AbhKZHBE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 Nov 2021 02:01:04 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85F1C0613F4;
        Thu, 25 Nov 2021 22:54:35 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id g14so34681368edb.8;
        Thu, 25 Nov 2021 22:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H19UTR6A3kWJJtvYx5Y6mT7M01EqlCEK84X1kiQHMws=;
        b=bqxUG9GBwRxXusR0vQDwXIKE6tmcfVDsDscQDKgRdXOuIiQDmox3u/A8r0+NArAguX
         ryOAq6uwAHZira08kD6Pu7FjfRAqNG2Lw8IkeSjlPR20UPa9uslZ6fEl85gCwOfaY2+Z
         JvMMepT01lYXH6+p4Uc9HYYV7u0SXQwJ+cyxy4xHteJGk6Q61AlBs+kNfMFNkrbhpSmc
         ugm+v0S6yqERyuaNatOq9swdrMA1oXVgA3qcsRD2bkC+DUc/bmeIIh/7UpPKWVJoGPnr
         HSyCu7ECVTvXK1zs/ZvsEXHuU4LJSFp1p/J3gouteiUm/d9gBdoMZec9azTWVnnlofkV
         8mFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H19UTR6A3kWJJtvYx5Y6mT7M01EqlCEK84X1kiQHMws=;
        b=LbCYxumQT6m1ezCjPQ+ri6TztMS4RAazjNYyk+3feGnZusA9yENYzM6/KveSCegWFQ
         Md8nMI01ioG3B128jqN4DkrcH5hMRJRWDGVA1uTS64eHQFfk54pxF0zINjuT7m1yurKL
         WqcRtgR1nwP1zLkbDT06wsRHubtFP3k4Tl9PghtDWgl+h09PUipVYUJWJ2qTiWm4A0I0
         E840P2ds6QsxhY+8OjGc5MqE8iGHvvP3C3CQX1p0LJSzGBQ5Kd/peBJn43Oqfoy+HerE
         UiKklhss9M+WwScJ7dTf/PjvUn/czElNUn1uxLCkIvcxPmzdAMH7edAPLAc2WJLoEn89
         6Z0w==
X-Gm-Message-State: AOAM5322gGYlnXXG4EqvN/t5ZEBjC/orB+AZ/MHEjYeR1flRslnD/Mi/
        BgLK4a6/kAN02hkbEEkg6Kv5pknP+JiXlo0d21U=
X-Google-Smtp-Source: ABdhPJxs0IPvPnqp3NBCU2rei0wRCuf8DbXNhGodW3vBcZa4EIEe4pIsjnkZ2X/CJLloy+mGOw6/PG0KgQ7sW9JeyV0=
X-Received: by 2002:a05:6402:84f:: with SMTP id b15mr44196111edz.323.1637909674456;
 Thu, 25 Nov 2021 22:54:34 -0800 (PST)
MIME-Version: 1.0
References: <20211124151915.GA6163@haolee.io> <YZ5o/VmU59evp65J@dhcp22.suse.cz>
 <CA+PpKPmy-u_BxYMCQOFyz78t2+3uM6nR9mQeX+MPyH6H2tOOHA@mail.gmail.com>
 <YZ8DZHERun6Fej2P@casper.infradead.org> <20211125080238.GA7356@haolee.io> <YZ/QFWzt/XbsLCqR@casper.infradead.org>
In-Reply-To: <YZ/QFWzt/XbsLCqR@casper.infradead.org>
From:   Hao Lee <haolee.swjtu@gmail.com>
Date:   Fri, 26 Nov 2021 14:54:23 +0800
Message-ID: <CA+PpKPmHfHca07W8aO+3bGjsqpUYOid=qBzm6dNuTyMmmkEpzQ@mail.gmail.com>
Subject: Re: [PATCH] mm: reduce spinlock contention in release_pages()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>, vdavydov.dev@gmail.com,
        Shakeel Butt <shakeelb@google.com>, cgroups@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 26, 2021 at 2:04 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Nov 25, 2021 at 08:02:38AM +0000, Hao Lee wrote:
> > On Thu, Nov 25, 2021 at 03:30:44AM +0000, Matthew Wilcox wrote:
> > > On Thu, Nov 25, 2021 at 11:24:02AM +0800, Hao Lee wrote:
> > > > On Thu, Nov 25, 2021 at 12:31 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > We do batch currently so no single task should be
> > > > > able to monopolize the cpu for too long. Why this is not sufficient?
> > > >
> > > > uncharge and unref indeed take advantage of the batch process, but
> > > > del_from_lru needs more time to complete. Several tasks will contend
> > > > spinlock in the loop if nr is very large.
> > >
> > > Is SWAP_CLUSTER_MAX too large?  Or does your architecture's spinlock
> > > implementation need to be fixed?
> > >
> >
> > My testing server is x86_64 with 5.16-rc2. The spinlock should be normal.
> >
> > I think lock_batch is not the point. lock_batch only break spinning time
> > into small parts, but it doesn't reduce spinning time. The thing may get
> > worse if lock_batch is very small.
>
> OK.  So if I understand right, you've got a lot of processes all
> calling exit_mmap() at the same time, which eventually becomes calls to
> unmap_vmas(), unmap_single_vma(), unmap_page_range(), zap_pte_range(),
> tlb_flush_mmu(), tlb_batch_pages_flush(), free_pages_and_swap_cache(),
> release_pages(), and then you see high contention on the LRU lock.

Exactly.

>
> Your use-case doesn't seem to mind sleeping (after all, these processes
> are exiting).

Yes!

>  So we could put a semaphore in exit_mmap() to limit the
> number of simultaneous callers to unmap_vmas().  Do you want to try
> that out and see if it solves your problem?  You might want to make it
> a counting semaphore (eg permit two tasks to exit at once) rather than
> a mutex.  But maybe a mutex is just fine.

This is really a good idea. My train of thought was trapped in reducing the
lock contention. I will try to implement this idea and see if the service
stability will be improved much. Thanks for your help!
