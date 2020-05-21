Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F391DD633
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 20:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbgEUSpb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 May 2020 14:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729092AbgEUSpa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 May 2020 14:45:30 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A22C061A0F
        for <cgroups@vger.kernel.org>; Thu, 21 May 2020 11:45:30 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id l1so6324880qtp.6
        for <cgroups@vger.kernel.org>; Thu, 21 May 2020 11:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ztCfYXHp0xjTe1ByVE5PYmFSI5M3i5vgP1eRzIwh63g=;
        b=dWuVXEZsuOp5cRhJMMJC2shV3CwbSqCQ1u66ngT91g9dypqVYIV536Tv/WCZChXnpu
         oxK5LFvBwRhWWggxLMuKSJtv/ZDhBPI3MLYWpOHBKcVjrVFarzos6BXPRTDMkoSjzFlV
         YFRxjUOYZPqdv6GZsnoGg42QanyhUZeEivbVzDipEUzHNnv0pFaUQkRAIq2CHlalJDbL
         GewYHRYl54P2cc4HJKK5jqJR85rYejfldkwNdobX5yq5osZMC0vZlvc1+LbI5BZ3uRze
         oKZa7xRcbzHDsGWFq8zTNcRANo51ngVu2OX4HAQJbknwxaDhdKWsv6yDYeQC6mZmP1HN
         9KIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ztCfYXHp0xjTe1ByVE5PYmFSI5M3i5vgP1eRzIwh63g=;
        b=oZzJX9ZwmYUDumT5SKinOISM1EBrzaVy2i2woudPW7NANJIwitaZBTRzPRLJOEfISd
         PP2mWcKHQCRMWgxFbFlVdxXacWwxO3pPZtyevIwYNXgTLFPHKB3Rw4kVd/87+sD1ttKE
         VfDNIOZ4Xe2f846iqYWliQ+NZbBg/t0uzcnfV+R6/Azvv8Z7bWK9onFZCh+Av8tHy23B
         av+kp4WKORusYBQDJNqKBVZN8qZHbxkwKQFYdV0SRaHwLHVpU3Z6o5rKrWA/oBHy3Epv
         DnKp2YmrjDJzrthw9SW31A15Sdyhg9S7JQ5frICPFLrhD4YgRkYDJKcT7mZDdRNZRnD7
         ssbw==
X-Gm-Message-State: AOAM531kRtw1vXb5O/NVaSzp6KoDEALGnP2ipfBnjaWzRcFPP8SyO50s
        u8IZs7sDmGI1fZWIT3dqX8ye4w==
X-Google-Smtp-Source: ABdhPJwNTq7cVA20GGMwYXgfQgpkgMnAGkrlWkN59I1DGvJejeNqAdXFVqrRqUG/171doAyU3Z4UFw==
X-Received: by 2002:ac8:f94:: with SMTP id b20mr12319235qtk.291.1590086729238;
        Thu, 21 May 2020 11:45:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4708])
        by smtp.gmail.com with ESMTPSA id r18sm5539703qtn.1.2020.05.21.11.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 11:45:28 -0700 (PDT)
Date:   Thu, 21 May 2020 14:45:05 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200521184505.GA815980@cmpxchg.org>
References: <20200520143712.GA749486@chrisdown.name>
 <20200520160756.GE6462@dhcp22.suse.cz>
 <20200520165131.GB630613@cmpxchg.org>
 <20200520170430.GG6462@dhcp22.suse.cz>
 <20200520175135.GA793901@cmpxchg.org>
 <20200521073245.GI6462@dhcp22.suse.cz>
 <20200521135152.GA810429@cmpxchg.org>
 <20200521143515.GU6462@dhcp22.suse.cz>
 <20200521163833.GA813446@cmpxchg.org>
 <20200521173701.GX6462@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521173701.GX6462@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 21, 2020 at 07:37:01PM +0200, Michal Hocko wrote:
> On Thu 21-05-20 12:38:33, Johannes Weiner wrote:
> > On Thu, May 21, 2020 at 04:35:15PM +0200, Michal Hocko wrote:
> > > On Thu 21-05-20 09:51:52, Johannes Weiner wrote:
> > > > On Thu, May 21, 2020 at 09:32:45AM +0200, Michal Hocko wrote:
> > > [...]
> > > > > I am not saying the looping over try_to_free_pages is wrong. I do care
> > > > > about the final reclaim target. That shouldn't be arbitrary. We have
> > > > > established a target which is proportional to the requested amount of
> > > > > memory. And there is a good reason for that. If any task tries to
> > > > > reclaim down to the high limit then this might lead to a large
> > > > > unfairness when heavy producers piggy back on the active reclaimer(s).
> > > > 
> > > > Why is that different than any other form of reclaim?
> > > 
> > > Because the high limit reclaim is a best effort rather than must to
> > > either get over reclaim watermarks and continue allocation or meet the
> > > hard limit requirement to continue.
> > 
> > It's not best effort. It's a must-meet or get put to sleep. You are
> > mistaken about what memory.high is.
> 
> I do not see anything like that being documented. Let me remind you what
> the documentation says:
>   memory.high
>         A read-write single value file which exists on non-root
>         cgroups.  The default is "max".
> 
>         Memory usage throttle limit.  This is the main mechanism to
>         control memory usage of a cgroup.  If a cgroup's usage goes
>         over the high boundary, the processes of the cgroup are
>         throttled and put under heavy reclaim pressure.
> 
>         Going over the high limit never invokes the OOM killer and
>         under extreme conditions the limit may be breached.
> 
> My understanding is that breaching the limit is acceptable if the memory
> is not reclaimable after placing a heavy reclaim pressure. We can
> discuss what the heavy reclaim means but the underlying fact is that the
> keeping the consumption under the limit is a best effort.

It says it's the main mechanism to control memory usage, and that
"under extreme conditions the limit may be breached". This doesn't
sound like "let's try some reclaim and see how it goes" to me.

As the person who designed and implemented this feature, it certainly
wasn't the intention.

> Please also let me remind you that the best effort implementation has
> been there since the beginning when the memory.high has been introduced.
> Now you seem to be convinced that the semantic is _obviously_ different.
>
> It is not the first time when the high limit behavior has changed.
> Mostly based on "what is currently happening in your fleet". And can see
> why it is reasonable to adopt to a real life usage. That is OK most of
> the time. But I haven't heard why keeping the existing approach and
> enforcing the reclaim target is not working properly so far. All I can
> hear is a generic statement that consistency matters much more than all
> potential problem it might introduce.

The assumption when writing the first implementation was that the full
reclaim cycle that we impose on every subsequent allocation was enough
to 1) mount a significant effort to push back allocations or 2) if it
fails, at least hold up allocations enough to curb further growth.

As it turned out when deploying this code at scale, reclaim is not
sufficient to achieve #2, because it simply may fail with not that
many pages to scan - especially on systems without swap. So after
observing a violation of the promised behavior, we added the sleeps
for situations where reclaim fails to contain the workload as stated.

After adding the sleeps, we noticed - again after deploying at scale -
that in certain situations reclaim isn't failing but simply returning
early, and we go to sleep and get OOM killed on full file LRUs.

After analyzing this problem, it's clear that we had an oversight
here: all other reclaimers are already familiar with the fact that
reclaim may not be able to complete the reclaim target in one call, or
that page reclaim is inherently racy and reclaim work can be stolen.

We send a simple bug fix: bring this instance of reclaim in line with
how everybody else is using the reclaim API, to meet the semantics as
they are intendend and documented.

And somehow this is controversial, and we're just changing around user
promises as we see fit for our particular usecase?

I don't even understand how the supposed alternate semantics you read
between the lines in the documentation would make for a useful
feature: It may fail to contain a group of offending tasks to the
configured limit, but it will be fair to those tasks while doing so?

> But if your really want to push this through then let's do it
> properly at least. memcg->memcg_nr_pages_over_high has only very
> vague meaning if the reclaim target is the high limit.

task->memcg_nr_pages_over_high is not vague, it's a best-effort
mechanism to distribute fairness. It's the current task's share of the
cgroup's overage, and it allows us in the majority of situations to
distribute reclaim work and sleeps in proportion to how much the task
is actually at fault.

However, due to the inherent raciness of reclaim, this may sometimes
fail. In that situation, it's way better to suffer some unfairness
than to give up, go to sleep, and risk OOM intervention - or give up,
let the task continue and fail memory containment of the cgroup.

Both of these are more important than the concept of "fairness"
between tasks that already share a cgroup and memory pool, and likely
have a myriad of other resource dependencies between them.

> The changelog should be also explicit about a potentially large
> stalls so that people debugging such a problem have a clue at least.

The large stalls you see from hitting your memory limit?

At what point would that be unexpected? All you see is a task inside
reclaim while it's trying to allocate and the cgroup is at its limit.
The same as you would with memory.max and global reclaim.
