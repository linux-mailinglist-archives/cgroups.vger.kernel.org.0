Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DFE1E676F
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2020 18:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405005AbgE1QbI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 May 2020 12:31:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46968 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405003AbgE1QbH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 May 2020 12:31:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id x6so15065321wrm.13;
        Thu, 28 May 2020 09:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4XalwJaYGWFf0aCUMIGKcmEa/lHl73yMoLw+LggKu2U=;
        b=U4Hm7QRSaYNpyYBZzejASLNDTjeER5N/awIb+DYz8BxQXGKbywnHNCMVTP28Bw6Bla
         GaRETdfXaWWZhubQjp1UtNKI7GlFusEasJfC32tT4IgmRxM8M1QhFgmYPj/gpfpfMS7E
         5mrXhf5+2jtm96ckMcrQ/GpHqCa9kiPal9mXc5rXrYN9fDM2JRb9WB/6aadn9ApekMLS
         Xe4HfpnN2B6GgzEf9afT6o4A9lxEAEMrarGPQ8fVY+iB48p1XkHd0SuHuVu8aOZj9CP0
         YG/XVb/l4LopEvHW9pCDOlU824kwiR9Uefo+Pp5DoEkG6ijynVj6YWhzhyeb1+pqWOVQ
         mgDw==
X-Gm-Message-State: AOAM532Y62mYe+L18DahEGYOycoBdBdO5dwO9mNLBI9pZ/HGpl4UXr7/
        7s2j57oQZ0htGbwNMORf9Naew6eS
X-Google-Smtp-Source: ABdhPJwmtb0i8EHWevCrRID0KPYlg3QniOw6ATKxJAqczO5h739aBdk6I/FoA/q6JKi+CghlhIUvIQ==
X-Received: by 2002:adf:8023:: with SMTP id 32mr4550265wrk.247.1590683464666;
        Thu, 28 May 2020 09:31:04 -0700 (PDT)
Received: from localhost (ip-37-188-185-40.eurotel.cz. [37.188.185.40])
        by smtp.gmail.com with ESMTPSA id t7sm6745931wrq.41.2020.05.28.09.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 09:31:03 -0700 (PDT)
Date:   Thu, 28 May 2020 18:31:01 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200528163101.GJ27484@dhcp22.suse.cz>
References: <20200520160756.GE6462@dhcp22.suse.cz>
 <20200520165131.GB630613@cmpxchg.org>
 <20200520170430.GG6462@dhcp22.suse.cz>
 <20200520175135.GA793901@cmpxchg.org>
 <20200521073245.GI6462@dhcp22.suse.cz>
 <20200521135152.GA810429@cmpxchg.org>
 <20200521143515.GU6462@dhcp22.suse.cz>
 <20200521163833.GA813446@cmpxchg.org>
 <20200521173701.GX6462@dhcp22.suse.cz>
 <20200521184505.GA815980@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521184505.GA815980@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 21-05-20 14:45:05, Johannes Weiner wrote:
> On Thu, May 21, 2020 at 07:37:01PM +0200, Michal Hocko wrote:
> > On Thu 21-05-20 12:38:33, Johannes Weiner wrote:
> > > On Thu, May 21, 2020 at 04:35:15PM +0200, Michal Hocko wrote:
> > > > On Thu 21-05-20 09:51:52, Johannes Weiner wrote:
> > > > > On Thu, May 21, 2020 at 09:32:45AM +0200, Michal Hocko wrote:
> > > > [...]
> > > > > > I am not saying the looping over try_to_free_pages is wrong. I do care
> > > > > > about the final reclaim target. That shouldn't be arbitrary. We have
> > > > > > established a target which is proportional to the requested amount of
> > > > > > memory. And there is a good reason for that. If any task tries to
> > > > > > reclaim down to the high limit then this might lead to a large
> > > > > > unfairness when heavy producers piggy back on the active reclaimer(s).
> > > > > 
> > > > > Why is that different than any other form of reclaim?
> > > > 
> > > > Because the high limit reclaim is a best effort rather than must to
> > > > either get over reclaim watermarks and continue allocation or meet the
> > > > hard limit requirement to continue.
> > > 
> > > It's not best effort. It's a must-meet or get put to sleep. You are
> > > mistaken about what memory.high is.
> > 
> > I do not see anything like that being documented. Let me remind you what
> > the documentation says:
> >   memory.high
> >         A read-write single value file which exists on non-root
> >         cgroups.  The default is "max".
> > 
> >         Memory usage throttle limit.  This is the main mechanism to
> >         control memory usage of a cgroup.  If a cgroup's usage goes
> >         over the high boundary, the processes of the cgroup are
> >         throttled and put under heavy reclaim pressure.
> > 
> >         Going over the high limit never invokes the OOM killer and
> >         under extreme conditions the limit may be breached.
> > 
> > My understanding is that breaching the limit is acceptable if the memory
> > is not reclaimable after placing a heavy reclaim pressure. We can
> > discuss what the heavy reclaim means but the underlying fact is that the
> > keeping the consumption under the limit is a best effort.
> 
> It says it's the main mechanism to control memory usage, and that
> "under extreme conditions the limit may be breached". This doesn't
> sound like "let's try some reclaim and see how it goes" to me.
> 
> As the person who designed and implemented this feature, it certainly
> wasn't the intention.
> 
> > Please also let me remind you that the best effort implementation has
> > been there since the beginning when the memory.high has been introduced.
> > Now you seem to be convinced that the semantic is _obviously_ different.
> >
> > It is not the first time when the high limit behavior has changed.
> > Mostly based on "what is currently happening in your fleet". And can see
> > why it is reasonable to adopt to a real life usage. That is OK most of
> > the time. But I haven't heard why keeping the existing approach and
> > enforcing the reclaim target is not working properly so far. All I can
> > hear is a generic statement that consistency matters much more than all
> > potential problem it might introduce.
> 
> The assumption when writing the first implementation was that the full
> reclaim cycle that we impose on every subsequent allocation was enough
> to 1) mount a significant effort to push back allocations or 2) if it
> fails, at least hold up allocations enough to curb further growth.
> 
> As it turned out when deploying this code at scale, reclaim is not
> sufficient to achieve #2, because it simply may fail with not that
> many pages to scan - especially on systems without swap. So after
> observing a violation of the promised behavior, we added the sleeps
> for situations where reclaim fails to contain the workload as stated.
> 
> After adding the sleeps, we noticed - again after deploying at scale -
> that in certain situations reclaim isn't failing but simply returning
> early, and we go to sleep and get OOM killed on full file LRUs.
> 
> After analyzing this problem, it's clear that we had an oversight
> here: all other reclaimers are already familiar with the fact that
> reclaim may not be able to complete the reclaim target in one call, or
> that page reclaim is inherently racy and reclaim work can be stolen.

There is no disagreement here.

> We send a simple bug fix: bring this instance of reclaim in line with
> how everybody else is using the reclaim API, to meet the semantics as
> they are intendend and documented.

Here is where we are not on the same page though. Once you have identified
that the main problem is that the reclaim fails too early to meet the
target then the fix would be to enforce that target. I have asked why
this hasn't been done and haven't got any real answer for that. Instead
what you call "a simple bug fix" has larger consequences which are not
really explained in the changelog and they are also not really trivial
to see. If the changelog explicitly stated that the proportional memory
reclaim is not sufficient because XYZ and the implementation has been
changed to instead meet the high limit target then this would be a
completely different story and I believe we could have saved some
discussion.

> And somehow this is controversial, and we're just changing around user
> promises as we see fit for our particular usecase?
> 
> I don't even understand how the supposed alternate semantics you read
> between the lines in the documentation would make for a useful
> feature: It may fail to contain a group of offending tasks to the
> configured limit, but it will be fair to those tasks while doing so?
> 
> > But if your really want to push this through then let's do it
> > properly at least. memcg->memcg_nr_pages_over_high has only very
> > vague meaning if the reclaim target is the high limit.
> 
> task->memcg_nr_pages_over_high is not vague, it's a best-effort
> mechanism to distribute fairness. It's the current task's share of the
> cgroup's overage, and it allows us in the majority of situations to
> distribute reclaim work and sleeps in proportion to how much the task
> is actually at fault.

Agreed. But this stops being the case as soon as the reclaim target has
been reached and new reclaim attempts are enforced because the memcg is
still above the high limit. Because then you have a completely different
reclaim target - get down to the limit. This would be especially visible
with a large memcg_nr_pages_over_high which could even lead to an over
reclaim.
-- 
Michal Hocko
SUSE Labs
