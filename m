Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F18A2F7FB7
	for <lists+cgroups@lfdr.de>; Fri, 15 Jan 2021 16:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbhAOPhh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Jan 2021 10:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730146AbhAOPhg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Jan 2021 10:37:36 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19C9C0613C1
        for <cgroups@vger.kernel.org>; Fri, 15 Jan 2021 07:36:55 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d15so824389qtw.12
        for <cgroups@vger.kernel.org>; Fri, 15 Jan 2021 07:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QRf6Q1+nAKg/5f3LQqDa/bSVIz2h6VIL5CFQ4uJbSKg=;
        b=RQqXcuplX7hvIugdsKL/m6CF0vKoc/OtlFxaUyNU+nUQK2YWyNQpOlqq06UED+mvwR
         OyraygDJmmJRgkyuYnC4qpcTt5BLl2xbq9D7SgHR00MnhZVvd31NJyQ25fgSTSSAnP6x
         IUDhlsy8pMJn+PyoyGirpBmEyiZiAnfhIh0rmJPFkAJ/fHYwlDaCtIebujOloliqRbRe
         pM8jNVEvGekZTIjleM2S3PhCpUZczs8erW4E5I0QyJ/A1yX/d9NHuOWoMqWQ/16dcSJB
         5LD54jP5gG9TvZp1Z5/6AlWA40cKwd7uwCAqMwAMyx/hN0BmOgHUO5oeeYkJMYwjhx0t
         Nw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QRf6Q1+nAKg/5f3LQqDa/bSVIz2h6VIL5CFQ4uJbSKg=;
        b=K2FGfS00Ar6aKofcAVK+WGXV8NkAsmrxMP/XCYySBR4Z0M5dOWhmEkVL6bJbiSf7gD
         hYYHLmpzQiDdF9NKenQArm6/aTLU2VfRg21dCzftjjNm840QfflSkoB521FtNXIJrcu1
         XnXI39U8097/FzokyOJkJpVtyFX/DYRmRZFjxkD7QVn+3lr01tctZzLoBmpGfdiF67LI
         ir41383KxU8Uo1fCmE5qJreft1GeSuoZMg4fhg/zpOtuAAF4ZHskO8AZejVNPALF8BiF
         MBL4I0pYfYAwcVzd/rb8G5vwoiuPB3b+NMvnPsmvJvPb7pWunWS2LyWjsqVsAicYuFgn
         kg3Q==
X-Gm-Message-State: AOAM530ZKtTzkjvK8wVlY1IsKFshYnktRp7plOOv8oRhE7zUXH9LMjNX
        g3QF+Py+qsn6nat7tAjie71y/w==
X-Google-Smtp-Source: ABdhPJzoMLylCnooro2BEl4UPjBH+4ehIXHZ9uSRvZnOB4HkTVXPtCl5dY0BcocScW2JrQZZQYFGsQ==
X-Received: by 2002:ac8:4553:: with SMTP id z19mr12182190qtn.278.1610725015164;
        Fri, 15 Jan 2021 07:36:55 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:dbed])
        by smtp.gmail.com with ESMTPSA id 141sm5121111qkn.53.2021.01.15.07.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 07:36:53 -0800 (PST)
Date:   Fri, 15 Jan 2021 10:34:26 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: prevent starvation when writing
 memory.high
Message-ID: <YAG2Am9YaohQ4YWS@cmpxchg.org>
References: <20210112163011.127833-1-hannes@cmpxchg.org>
 <20210112170322.GA99586@carbon.dhcp.thefacebook.com>
 <X/38ZwyOE96SAfa9@cmpxchg.org>
 <20210112201237.GB99586@carbon.dhcp.thefacebook.com>
 <X/4Qfxe1OKXACDLM@cmpxchg.org>
 <20210112214512.GC99586@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112214512.GC99586@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 12, 2021 at 01:45:12PM -0800, Roman Gushchin wrote:
> On Tue, Jan 12, 2021 at 04:11:27PM -0500, Johannes Weiner wrote:
> > On Tue, Jan 12, 2021 at 12:12:37PM -0800, Roman Gushchin wrote:
> > > On Tue, Jan 12, 2021 at 02:45:43PM -0500, Johannes Weiner wrote:
> > > > On Tue, Jan 12, 2021 at 09:03:22AM -0800, Roman Gushchin wrote:
> > > > > On Tue, Jan 12, 2021 at 11:30:11AM -0500, Johannes Weiner wrote:
> > > > > > When a value is written to a cgroup's memory.high control file, the
> > > > > > write() context first tries to reclaim the cgroup to size before
> > > > > > putting the limit in place for the workload. Concurrent charges from
> > > > > > the workload can keep such a write() looping in reclaim indefinitely.
> > > > > > 
> > > > > > In the past, a write to memory.high would first put the limit in place
> > > > > > for the workload, then do targeted reclaim until the new limit has
> > > > > > been met - similar to how we do it for memory.max. This wasn't prone
> > > > > > to the described starvation issue. However, this sequence could cause
> > > > > > excessive latencies in the workload, when allocating threads could be
> > > > > > put into long penalty sleeps on the sudden memory.high overage created
> > > > > > by the write(), before that had a chance to work it off.
> > > > > > 
> > > > > > Now that memory_high_write() performs reclaim before enforcing the new
> > > > > > limit, reflect that the cgroup may well fail to converge due to
> > > > > > concurrent workload activity. Bail out of the loop after a few tries.
> > > > > > 
> > > > > > Fixes: 536d3bf261a2 ("mm: memcontrol: avoid workload stalls when lowering memory.high")
> > > > > > Cc: <stable@vger.kernel.org> # 5.8+
> > > > > > Reported-by: Tejun Heo <tj@kernel.org>
> > > > > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > > > ---
> > > > > >  mm/memcontrol.c | 7 +++----
> > > > > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > > > > > 
> > > > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > > > index 605f671203ef..63a8d47c1cd3 100644
> > > > > > --- a/mm/memcontrol.c
> > > > > > +++ b/mm/memcontrol.c
> > > > > > @@ -6275,7 +6275,6 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
> > > > > >  
> > > > > >  	for (;;) {
> > > > > >  		unsigned long nr_pages = page_counter_read(&memcg->memory);
> > > > > > -		unsigned long reclaimed;
> > > > > >  
> > > > > >  		if (nr_pages <= high)
> > > > > >  			break;
> > > > > > @@ -6289,10 +6288,10 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
> > > > > >  			continue;
> > > > > >  		}
> > > > > >  
> > > > > > -		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
> > > > > > -							 GFP_KERNEL, true);
> > > > > > +		try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
> > > > > > +					     GFP_KERNEL, true);
> > > > > >  
> > > > > > -		if (!reclaimed && !nr_retries--)
> > > > > > +		if (!nr_retries--)
> > > > > 
> > > > > Shouldn't it be (!reclaimed || !nr_retries) instead?
> > > > > 
> > > > > If reclaimed == 0, it probably doesn't make much sense to retry.
> > > > 
> > > > We usually allow nr_retries worth of no-progress reclaim cycles to
> > > > make up for intermittent reclaim failures.
> > > > 
> > > > The difference to OOMs/memory.max is that we don't want to loop
> > > > indefinitely on forward progress, but we should allow the usual number
> > > > of no-progress loops.
> > > 
> > > Re memory.max: trying really hard makes sense because we are OOMing otherwise.
> > > With memory.high such an idea is questionable: if were not able to reclaim
> > > a single page from the first attempt, it's unlikely that we can reclaim many
> > > from repeating 16 times.
> > > 
> > > My concern here is that we can see CPU regressions in some cases when there is
> > > no reclaimable memory. Do you think we can win something by trying harder?
> > > If so, it's worth mentioning in the commit log. Because it's really a separate
> > > change to what's described in the log, to some extent it's a move into an opposite
> > > direction.
> > 
> > Hm, I'm confused what change you are referring to.
> > 
> > Current upstream allows:
> > 
> >     a. unlimited progress loops
> >     b. 16 no-progress loops
> > 
> > My patch is fixing the issue resulting from the unlimited progress
> > loops in a). This is described in the changelog.
> > 
> > You seem to be advocating for an unrelated change to the no-progress
> > loops condition in b).
> 
> Fair enough.
> 
> But still the question remains: what are we gaining by trying again after not
> being able to reclaim a single page? If you want, it can be done separately,
> but it looks like a good idea to me to bail out if we can't reclaim a single
> page.

You lost me there.

If memory.max retries before declaring oom, why shouldn't memory.high
retry before returning to userspace? If there is intermittent reclaim
failure, then returning from the memory.high write before the limit is
enforced in such rare situations saves very little, but makes the user
visible behavior unpredictable and inconsistent. It's extra code and a
special case that needs to be documented.
