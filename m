Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8B7410DD1
	for <lists+cgroups@lfdr.de>; Mon, 20 Sep 2021 01:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbhISXcz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 19 Sep 2021 19:32:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhISXcy (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 19 Sep 2021 19:32:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1E6260F9D;
        Sun, 19 Sep 2021 23:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1632094288;
        bh=zyJGiIuWE5OLgrUwe9tcbx/tG63SoIirkujQLHeuHsk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ueCIGMa2UqDW7NZYr2xH1V1f2uLeYgpzucwCUQsgrMzW1PofIQ59as8TZpWnli+P9
         EUKAVZXzAPzg4ZiWrxiQio7O2cU+4X6QoXL6rhQZrPG/m1WGOposi9Gb1c6ei6SMNY
         QyzFxQUkv59B/4V5H9uH6lYE0kxYf0t55rngF3Sg=
Date:   Sun, 19 Sep 2021 16:31:26 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH mm] vmalloc: back off when the current task is
 OOM-killed
Message-Id: <20210919163126.431674722b8db218453dc18c@linux-foundation.org>
In-Reply-To: <d07a5540-3e07-44ba-1e59-067500f024d9@virtuozzo.com>
References: <YT8PEBbYZhLixEJD@dhcp22.suse.cz>
        <d07a5540-3e07-44ba-1e59-067500f024d9@virtuozzo.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 17 Sep 2021 11:06:49 +0300 Vasily Averin <vvs@virtuozzo.com> wrote:

> Huge vmalloc allocation on heavy loaded node can lead to a global
> memory shortage. A task called vmalloc can have the worst badness
> and be chosen by OOM-killer, however received fatal signal and
> oom victim mark does not interrupt allocation cycle. Vmalloc will
> continue allocating pages over and over again, exacerbating the crisis
> and consuming the memory freed up by another killed tasks.
> 
> This patch allows OOM-killer to break vmalloc cycle, makes OOM more
> effective and avoid host panic.
> 
> Unfortunately it is not 100% safe. Previous attempt to break vmalloc
> cycle was reverted by commit b8c8a338f75e ("Revert "vmalloc: back off when
> the current task is killed"") due to some vmalloc callers did not handled
> failures properly. Found issues was resolved, however, there may
> be other similar places.

Well that was lame of us.

I believe that at least one of the kernel testbots can utilize fault
injection.  If we were to wire up vmalloc (as we have done with slab
and pagealloc) then this will help to locate such buggy vmalloc callers.

> Such failures may be acceptable for emergencies, such as OOM. On the other
> hand, we would like to detect them earlier. However they are quite rare,
> and will be hidden by OOM messages, so I'm afraid they wikk have quite
> small chance of being noticed and reported.
> 
> To improve the detection of such places this patch also interrupts the vmalloc
> allocation cycle for all fatal signals. The checks are hidden under DEBUG_VM
> config option to do not break unaware production kernels.

This sounds like a pretty sad half-measure?

