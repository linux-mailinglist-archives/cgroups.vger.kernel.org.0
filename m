Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5E73173D7
	for <lists+cgroups@lfdr.de>; Thu, 11 Feb 2021 00:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhBJXA1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Feb 2021 18:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbhBJXAZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 10 Feb 2021 18:00:25 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A395C061574
        for <cgroups@vger.kernel.org>; Wed, 10 Feb 2021 14:59:45 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id f1so5430555lfu.3
        for <cgroups@vger.kernel.org>; Wed, 10 Feb 2021 14:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xrTlzAySlcJTUXRnlEJkf0lrI9Iuz7zvICLmzyym/xM=;
        b=eMT+HrSpUk67s7D9Fb/wYqRRhLhygRRnmrKjid5+dGjRRdcWnl+Coe1Hmivi013BcD
         vM7qrpbntHPGYw3ZR2mT73sG3gTPW+Ae1qRtuLiiI+dqqOKuimFiDxcTK8abjY31E3rf
         Fmq+1ScDwhhI6jHG7o9mVfPDf1sBmPRQsQLW79d/E3O3s4IGItRepiKnHYMt1D30bRmR
         MM+t2zmasxETxauJwuE6V8yQF8vBKu/UNkNA0RFX4nCUyjeyCijXg0fMI7T9wwjnhnNQ
         0u4Vr+WykIzPW6B+1Kw9DctVhRNP42iVTrRSwiizbnXzW/vUetxSQ8bVn1+17zIlc7Ni
         ft3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xrTlzAySlcJTUXRnlEJkf0lrI9Iuz7zvICLmzyym/xM=;
        b=k+52EIPuGHPa3iIL899cO0QW8cPBoawzlrbMaJsmywN6qCK96UjSqbcEFCFeofD2eM
         pN0kIJZt3qFqPf/c0unSUSfiAfX8ylY6okvEybgeOFCsAhi3QJTW70H0UvwHgqQxPgk/
         RUZv5ElECDZQMb99Sp2pDqlMzxCXlLrpTBRyqxRiNpT7YNoJjnx148EFFcht8XPz9+Jg
         wmaSzrTVbu5rwt2eFCG5jDLh/kMkuehDY+WoKrnCxZoj61GPjCrQ9B5o5fDhVXOJvjAy
         qtzPpdqfr1QzagjJmp2o8QGBQL4NoFtPxcBcyzdhWBeoXvTm3nJ7Imb/DtwHiGAJyo5G
         hmhQ==
X-Gm-Message-State: AOAM533nUnyPq18X9qsmRB96/z96Hg7i6JbQUcs+bV7JrJXCnc/t0nue
        cEXFiU3kmYm5MBL87limckHrlJufKx2RG7RxfTLvqw==
X-Google-Smtp-Source: ABdhPJw6wefq5+DqM++nrhDWfNPnH6l/1z2hdn+8UkJNXwUTzgKLrXbPfqsQWUSSzXJb8EYLGptouvYaVvCRqnVy9jc=
X-Received: by 2002:a19:4cc2:: with SMTP id z185mr2657923lfa.83.1612997983406;
 Wed, 10 Feb 2021 14:59:43 -0800 (PST)
MIME-Version: 1.0
References: <20210209214543.112655-1-hannes@cmpxchg.org> <alpine.LSU.2.11.2102092058290.7553@eggly.anvils>
 <alpine.LSU.2.11.2102100813050.8131@eggly.anvils> <YCQbYAWg4nvBFL6h@cmpxchg.org>
In-Reply-To: <YCQbYAWg4nvBFL6h@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 10 Feb 2021 14:59:32 -0800
Message-ID: <CALvZod6vgYcpgskf7NaRagH999L6VkfnVtD1UDb+JhQceCuUEA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: page-writeback: simplify memcg handling in test_clear_page_writeback()
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Arjun Roy <arjunroy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 10, 2021 at 9:44 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Feb 10, 2021 at 08:22:00AM -0800, Hugh Dickins wrote:
> > On Tue, 9 Feb 2021, Hugh Dickins wrote:
> > > On Tue, 9 Feb 2021, Johannes Weiner wrote:
> > >
> > > > Page writeback doesn't hold a page reference, which allows truncate to
> > > > free a page the second PageWriteback is cleared. This used to require
> > > > special attention in test_clear_page_writeback(), where we had to be
> > > > careful not to rely on the unstable page->memcg binding and look up
> > > > all the necessary information before clearing the writeback flag.
> > > >
> > > > Since commit 073861ed77b6 ("mm: fix VM_BUG_ON(PageTail) and
> > > > BUG_ON(PageWriteback)") test_clear_page_writeback() is called with an
> > > > explicit reference on the page, and this dance is no longer needed.
> > > >
> > > > Use unlock_page_memcg() and dec_lruvec_page_stat() directly.
> > >
> > > s/stat()/state()/
> > >
> > > This is a nice cleanup: I hadn't seen that connection at all.
> > >
> > > But I think you should take it further:
> > > __unlock_page_memcg() can then be static in mm/memcontrol.c,
> > > and its declarations deleted from include/linux/memcontrol.h?
> >
> > And further: void lock_page_memcg(page), not returning memcg.
>
> You're right on all counts!
>
> > > And further: delete __dec_lruvec_state() and dec_lruvec_state()
> > > from include/linux/vmstat.h - unless you feel that every "inc"
> > > ought to be matched by a "dec", even when unused.
>
> Hey look, there isn't a user for the __inc, either :) There is one for
> inc, but I don't insist on having symmetry there.
>
> > > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > >
> > > Acked-by: Hugh Dickins <hughd@google.com>
>
> Thanks for the review and good feedback.
>
> How about this v2?
>
> ---
>
> From 5bcc0f468460aa2670c40318bb657e8b08ef96d5 Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Tue, 9 Feb 2021 16:22:42 -0500
> Subject: [PATCH] mm: page-writeback: simplify memcg handling in
>  test_clear_page_writeback()
>
> Page writeback doesn't hold a page reference, which allows truncate to
> free a page the second PageWriteback is cleared. This used to require
> special attention in test_clear_page_writeback(), where we had to be
> careful not to rely on the unstable page->memcg binding and look up
> all the necessary information before clearing the writeback flag.
>
> Since commit 073861ed77b6 ("mm: fix VM_BUG_ON(PageTail) and
> BUG_ON(PageWriteback)") test_clear_page_writeback() is called with an
> explicit reference on the page, and this dance is no longer needed.
>
> Use unlock_page_memcg() and dec_lruvec_page_state() directly.
>
> This removes the last user of the lock_page_memcg() return value,
> change it to void. Touch up the comments in there as well. This also
> removes the last extern user of __unlock_page_memcg(), make it
> static. Further, it removes the last user of dec_lruvec_state(),
> delete it, along with a few other unused helpers.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Hugh Dickins <hughd@google.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

The patch looks fine. I don't want to spoil the fun but just wanted to
call out that I might bring back __unlock_page_memcg() for the memcg
accounting of zero copy TCP memory work where we are uncharging the
page in page_remove_rmap().
