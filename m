Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14BB413A62
	for <lists+cgroups@lfdr.de>; Tue, 21 Sep 2021 20:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhIUS4x (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Sep 2021 14:56:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232142AbhIUS4x (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 21 Sep 2021 14:56:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 449AB61186;
        Tue, 21 Sep 2021 18:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1632250524;
        bh=4nfKbEEvnuIK73VTBrjV7lsPLdW7d5cR0/3cZDpflDE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XQ+uwo9Ce+qeUe704wH19OCWWpxZTbGGZupNJ9QAWTxokV6Pl54kFG8CGUjfSin5P
         2qTK4wVyhoeLepL7/wCyWf9SYbghTbeZ9lU9z7iIS+ZxtmF1wiEpq6H4d9beaaP3bG
         FCxw6qzVjGkphbM53CO0re/aquN3en7e4TUSt7NY=
Date:   Tue, 21 Sep 2021 11:55:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH mm] vmalloc: back off when the current task is
 OOM-killed
Message-Id: <20210921115523.8606cea0b2f0a5ca4e79cbd0@linux-foundation.org>
In-Reply-To: <c9d43874-138e-54a9-3222-a08c269eeeb5@virtuozzo.com>
References: <YT8PEBbYZhLixEJD@dhcp22.suse.cz>
        <d07a5540-3e07-44ba-1e59-067500f024d9@virtuozzo.com>
        <20210919163126.431674722b8db218453dc18c@linux-foundation.org>
        <bb5616b0-faa6-e12a-102b-b9c402e27ec1@i-love.sakura.ne.jp>
        <c9d43874-138e-54a9-3222-a08c269eeeb5@virtuozzo.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 20 Sep 2021 13:59:35 +0300 Vasily Averin <vvs@virtuozzo.com> wrote:

> On 9/20/21 4:22 AM, Tetsuo Handa wrote:
> > On 2021/09/20 8:31, Andrew Morton wrote:
> >> On Fri, 17 Sep 2021 11:06:49 +0300 Vasily Averin <vvs@virtuozzo.com> wrote:
> >>
> >>> Huge vmalloc allocation on heavy loaded node can lead to a global
> >>> memory shortage. A task called vmalloc can have the worst badness
> >>> and be chosen by OOM-killer, however received fatal signal and
> >>> oom victim mark does not interrupt allocation cycle. Vmalloc will
> >>> continue allocating pages over and over again, exacerbating the crisis
> >>> and consuming the memory freed up by another killed tasks.
> >>>
> >>> This patch allows OOM-killer to break vmalloc cycle, makes OOM more
> >>> effective and avoid host panic.
> >>>
> >>> Unfortunately it is not 100% safe. Previous attempt to break vmalloc
> >>> cycle was reverted by commit b8c8a338f75e ("Revert "vmalloc: back off when
> >>> the current task is killed"") due to some vmalloc callers did not handled
> >>> failures properly. Found issues was resolved, however, there may
> >>> be other similar places.
> >>
> >> Well that was lame of us.
> >>
> >> I believe that at least one of the kernel testbots can utilize fault
> >> injection.  If we were to wire up vmalloc (as we have done with slab
> >> and pagealloc) then this will help to locate such buggy vmalloc callers.
> 
> Andrew, could you please clarify how we can do it?
> Do you mean we can use exsiting allocation fault injection infrastructure to trigger
> such kind of issues? Unfortunately I found no ways to reach this goal.
> It  allows to emulate single faults with small probability, however it is not enough,
> we need to completely disable all vmalloc allocations. 

I don't see why there's a problem?  You're saying "there might still be
vmalloc() callers which don't correctly handle allocation failures",
yes?

I'm suggesting that we use fault injection to cause a small proportion
of vmalloc() calls to artificially fail, so such buggy callers will
eventually be found and fixed.  Why does such a scheme require that
*all* vmalloc() calls fail?


