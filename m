Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2786F164F45
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2020 20:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgBSTxi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Feb 2020 14:53:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55908 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgBSTxh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Feb 2020 14:53:37 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so1996534wmj.5;
        Wed, 19 Feb 2020 11:53:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nnIsYFJ4c+zLIzekV3dJ84C94gebKMjwkIZilDifoOM=;
        b=cQRLWEs6TK9fDm33/0sC/m8agKnSbuU8Hrm72nhitiyVFK2A7tRZcgmSgvzYpoXyE5
         1OpJMSUzXn6cvppZ0+7lEwXIV3+WEqa2JdfyGtqH6lOhY1WhT8ZRTgV16muazapCUjya
         L8dBlLgeMkHXKs/e7kl9ICm562DssRm9S2mahXXQcid1VUwSak1D1BZRVGZykJ7CjbTs
         hCzYGecjmRP075FJ4w94B8Bf/j4fpWmxoNL/qF69r4o5hjeX0JIxT+uXB5+be0Gu1bw9
         2o0R2lmHfn0jiPeTQwYJ177IeygGZ9eg3RVSKa2bc0zIAFvrWz7mIRbmiy6DNT56Wb4t
         xOww==
X-Gm-Message-State: APjAAAU9kMkpfsq5Z7u7gWMZJkkh+ztIo0SsBi45GAoglzGFBnxKj8KZ
        xRKUqrrjxOgSm1UVSV71Xfc=
X-Google-Smtp-Source: APXvYqwxkGqDAk0Y2VhBAmNNJv3d+gI7R73J4kZe59ouysIC5YMAqD8Yb25dW1TmHIlJdsprmgqMEQ==
X-Received: by 2002:a1c:1d13:: with SMTP id d19mr12267421wmd.163.1582142015105;
        Wed, 19 Feb 2020 11:53:35 -0800 (PST)
Received: from localhost (ip-37-188-133-21.eurotel.cz. [37.188.133.21])
        by smtp.gmail.com with ESMTPSA id e22sm1082263wme.45.2020.02.19.11.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 11:53:34 -0800 (PST)
Date:   Wed, 19 Feb 2020 20:53:32 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: asynchronous reclaim for memory.high
Message-ID: <20200219195332.GE11847@dhcp22.suse.cz>
References: <20200219181219.54356-1-hannes@cmpxchg.org>
 <20200219183731.GC11847@dhcp22.suse.cz>
 <20200219191618.GB54486@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219191618.GB54486@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 19-02-20 14:16:18, Johannes Weiner wrote:
> On Wed, Feb 19, 2020 at 07:37:31PM +0100, Michal Hocko wrote:
> > On Wed 19-02-20 13:12:19, Johannes Weiner wrote:
> > > We have received regression reports from users whose workloads moved
> > > into containers and subsequently encountered new latencies. For some
> > > users these were a nuisance, but for some it meant missing their SLA
> > > response times. We tracked those delays down to cgroup limits, which
> > > inject direct reclaim stalls into the workload where previously all
> > > reclaim was handled my kswapd.
> > 
> > I am curious why is this unexpected when the high limit is explicitly
> > documented as a throttling mechanism.
> 
> Memory.high is supposed to curb aggressive growth using throttling
> instead of OOM killing. However, if the workload has plenty of easily
> reclaimable memory and just needs to recycle a couple of cache pages
> to permit an allocation, there is no need to throttle the workload -
> just as there wouldn't be any need to trigger the OOM killer.
> 
> So it's not unexpected, but it's unnecessarily heavy-handed: since
> memory.high allows some flexibility around the target size, we can
> move the routine reclaim activity (cache recycling) out of the main
> execution stream of the workload, just like we do with kswapd. If that
> cannot keep up, we can throttle and do direct reclaim.
> 
> It doesn't change the memory.high semantics, but it allows exploiting
> the fact that we have SMP systems and can parallize the book keeping.

Thanks, this describes the problem much better and I believe this all
belongs to the changelog.

> > > This patch adds asynchronous reclaim to the memory.high cgroup limit
> > > while keeping direct reclaim as a fallback. In our testing, this
> > > eliminated all direct reclaim from the affected workload.
> > 
> > Who is accounted for all the work? Unless I am missing something this
> > just gets hidden in the system activity and that might hurt the
> > isolation. I do see how moving the work to a different context is
> > desirable but this work has to be accounted properly when it is going to
> > become a normal mode of operation (rather than a rare exception like the
> > existing irq context handling).
> 
> Yes, the plan is to account it to the cgroup on whose behalf we're
> doing the work.

OK, great, because honestly I am not really sure we can merge this work
without that being handled, I am afraid. We've had similar attempts
- mostly to parallelize work on behalf of the process (e.g. address space
tear down) - and the proper accounting was always the main obstacle so we
really need to handle this problem for other reasons. This doesn't sound
very different. And your example of a workload not meeting SLAs just
shows that the amount of the work required for the high limit reclaim
can be non-trivial. Somebody has to do that work and we cannot simply
allow everybody else to pay for that.

> The problem is that we have a general lack of usable CPU control right
> now - see Rik's work on this: https://lkml.org/lkml/2019/8/21/1208.
> For workloads that are contended on CPU, we cannot enable the CPU
> controller because the scheduling latencies are too high. And for
> workloads that aren't CPU contended, well, it doesn't really matter
> where the reclaim cycles are accounted to.
> 
> Once we have the CPU controller up to speed, we can add annotations
> like these to account stretches of execution to specific
> cgroups. There just isn't much point to do it before we can actually
> enable CPU control on the real workloads where it would matter.
> 
> [ This is generally work in process: for example, if you isolate
>   workloads with memory.low, kswapd cpu time isn't accounted to the
>   cgroup that causes it. Swap IO issued by kswapd isn't accounted to
>   the group that is getting swapped.

Well, kswapd is a system activity and as such it is acceptable that it
is accounted to the system. But in this case we are talking about a
memcg configuration which influences all other workloads by stealing CPU
cycles from them without much throttling on the consumer side -
especially when the memory is reclaimable without a lot of sleeping or
contention on locks etc.

I am absolutely aware that we will never achieve a perfect isolation due
to all sorts of shared data structures, lock contention and what not but
this patch alone just allows spill over to unaccounted work way too
easily IMHO.

>   The memory consumed by struct
>   cgroup itself, the percpu allocations for the vmstat arrays etc.,
>   which is sizable, are not accounted to the cgroup that creates
>   subgroups, and so forth. ]

-- 
Michal Hocko
SUSE Labs
