Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0A81E76A8
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2020 09:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgE2HbY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 May 2020 03:31:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56086 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgE2HbX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 May 2020 03:31:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id c71so2015839wmd.5;
        Fri, 29 May 2020 00:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ffhLZMrViw3MrgcjzzAlVHQkuqxpqvv1nCa66wY1aZo=;
        b=PczKixOTHrtiPvjgB2DJyuCIxde8avftNJttXvmcON7Rct7YZLQNcis4v8bZAUabnJ
         oJ5lPYS0d/0kRGph8lOEtbWOO/A2lq7IvQjLjhhH0jZNbnFhduNqF6GbL08XXsQewD3k
         Vu/IGralvFqPULjc5GJIDKue8AbCGwgcwv4sq50iA1jR084fZib0GOmU6LK6skpHMMOw
         VnAxFJldxltR40AgH211NhYvojBvUmMQ8tIKTn2/a6uXT997yYpL3tv21CeX6jqimo0/
         aOdNQOTvpbULsm7V0QE9HxPAu5t4O8PpAy4XRf4zS5QJAUh18V8c8zOGihnD0n2lakHs
         SXrQ==
X-Gm-Message-State: AOAM531TOFtboXUjyAYPZgxeGwiJWGVA4Ac4WWKr+ZRCbNIplYNdOmFw
        qBzW+AjAepjhWXeX/JpelBc=
X-Google-Smtp-Source: ABdhPJwqGRvBJZ39RA8lb+c5fQWLg7apIx+WQpWJMiVct5D3jPraX49B8Wt72Som/FLeLVqDkSKw1A==
X-Received: by 2002:a7b:cc06:: with SMTP id f6mr7086871wmh.119.1590737481490;
        Fri, 29 May 2020 00:31:21 -0700 (PDT)
Received: from localhost (ip-37-188-185-40.eurotel.cz. [37.188.185.40])
        by smtp.gmail.com with ESMTPSA id s5sm9358013wme.37.2020.05.29.00.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 00:31:19 -0700 (PDT)
Date:   Fri, 29 May 2020 09:31:18 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200529073118.GE4406@dhcp22.suse.cz>
References: <20200520170430.GG6462@dhcp22.suse.cz>
 <20200520175135.GA793901@cmpxchg.org>
 <20200521073245.GI6462@dhcp22.suse.cz>
 <20200521135152.GA810429@cmpxchg.org>
 <20200521143515.GU6462@dhcp22.suse.cz>
 <20200521163833.GA813446@cmpxchg.org>
 <20200521173701.GX6462@dhcp22.suse.cz>
 <20200521184505.GA815980@cmpxchg.org>
 <20200528163101.GJ27484@dhcp22.suse.cz>
 <20200528164848.GB839178@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528164848.GB839178@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 28-05-20 17:48:48, Chris Down wrote:
> Michal Hocko writes:
> > > We send a simple bug fix: bring this instance of reclaim in line with
> > > how everybody else is using the reclaim API, to meet the semantics as
> > > they are intendend and documented.
> > 
> > Here is where we are not on the same page though. Once you have identified
> > that the main problem is that the reclaim fails too early to meet the
> > target then the fix would be to enforce that target. I have asked why
> > this hasn't been done and haven't got any real answer for that. Instead
> > what you call "a simple bug fix" has larger consequences which are not
> > really explained in the changelog and they are also not really trivial
> > to see. If the changelog explicitly stated that the proportional memory
> > reclaim is not sufficient because XYZ and the implementation has been
> > changed to instead meet the high limit target then this would be a
> > completely different story and I believe we could have saved some
> > discussion.
> 
> I agree that the changelog can be made more clear. Any objection if I send
> v2 with changelog changes to that effect, then? :-)

Yes, please. And I would highly appreciate to have the above addressed.
So that we do not have to really scratch heads why a particular design
decision has been made and argue what was the thinking behind.

> > > And somehow this is controversial, and we're just changing around user
> > > promises as we see fit for our particular usecase?
> > > 
> > > I don't even understand how the supposed alternate semantics you read
> > > between the lines in the documentation would make for a useful
> > > feature: It may fail to contain a group of offending tasks to the
> > > configured limit, but it will be fair to those tasks while doing so?
> > > 
> > > > But if your really want to push this through then let's do it
> > > > properly at least. memcg->memcg_nr_pages_over_high has only very
> > > > vague meaning if the reclaim target is the high limit.
> > > 
> > > task->memcg_nr_pages_over_high is not vague, it's a best-effort
> > > mechanism to distribute fairness. It's the current task's share of the
> > > cgroup's overage, and it allows us in the majority of situations to
> > > distribute reclaim work and sleeps in proportion to how much the task
> > > is actually at fault.
> > 
> > Agreed. But this stops being the case as soon as the reclaim target has
> > been reached and new reclaim attempts are enforced because the memcg is
> > still above the high limit. Because then you have a completely different
> > reclaim target - get down to the limit. This would be especially visible
> > with a large memcg_nr_pages_over_high which could even lead to an over
> > reclaim.
> 
> We actually over reclaim even before this patch -- this patch doesn't bring
> much new in that regard.
> 
> Tracing try_to_free_pages for a cgroup at the memory.high threshold shows
> that before this change, we sometimes even reclaim on the order of twice the
> number of pages requested. For example, I see cases where we requested 1000
> pages to be reclaimed, but end up reclaiming 2000 in a single reclaim
> attempt.

This is interesting and worth looking into. I am aware that we can
reclaim potentially much more pages during the icache reclaim and that
there was a heated discussion without any fix merged in the end IIRC.
Do you have any details?

-- 
Michal Hocko
SUSE Labs
