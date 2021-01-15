Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9082F80A3
	for <lists+cgroups@lfdr.de>; Fri, 15 Jan 2021 17:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbhAOQYB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Jan 2021 11:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbhAOQYA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Jan 2021 11:24:00 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2300C061794
        for <cgroups@vger.kernel.org>; Fri, 15 Jan 2021 08:23:19 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id 186so12168805qkj.3
        for <cgroups@vger.kernel.org>; Fri, 15 Jan 2021 08:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d8Z+PWPkeXqU4sVnEZWxtzrZF8DqYxnDeZ23COUUVZo=;
        b=jmNfe3u7/Jx6sddnUHr0M4wMCCLmSUAgwMTvm1sMlKyzlzfIXrkClAgtlPfPBD8WtH
         6pf5xxYYrew/dipIl81zwoGMZcDWbZw0hgxiowtOTRfToSarJCNfK0ElFwdtZD/JAihm
         JwuWtyH/AlO43NtcdSSFAU5Y7z622ZHR4KWaJD/T9rDlP+qxQ8B80ZgTC3t7upJB5rO3
         gVJRDkv4B7g2IA8PeJbfu++m81oGgu6R7ULd24CpqYiwAkB/MFl9azyzi3cyoNH0dl86
         Jhf9HO1STrmiowlPFWFLjC15z3Xy6Mg8MKi66qj6uC5E4yD7KaLwYLsfyBBhl/M1EL/h
         tOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d8Z+PWPkeXqU4sVnEZWxtzrZF8DqYxnDeZ23COUUVZo=;
        b=NplcP+yImL5dqbkIUjjM/ATUr0vGSnkFP1ay9c9nYfh13F+knhwV6zD8QHat8/wucp
         T5GDIOEI2vtcthjXMXMUFpFL3jZN4LrWNJBWPmbeYUkU8+4rVx5mW68FCLSX4dzb2Yqd
         2U++fjkz1OiOifwTr8ZjAX08gIQg8LILRPd0+h3hOGpd3NLvbJnqpCQusyOVL73ba7p4
         b/l6L3pf5u8AXE16azmpd4fLPG1v4wUPmVh7GaNY6XbTyf0sdFuqNZlQz3JZNA1WuWCv
         cybr5+J1E81XzKfs9h3y/3axNmzv18tO/zfxwHHc8y6p1MtFeeXd2GWnyl/yd5zSRjL6
         Vz5Q==
X-Gm-Message-State: AOAM530Oa0WVATXb05OjUY8bHPtNGlk2sqCnBjRuRhqqZNup/s0oivWN
        R8Zs8zx+evhq1SwuULRKkIepCg==
X-Google-Smtp-Source: ABdhPJxXUtVdGXDE1KDYt2fuo9xFsv8jd/AAg4JV8ZLoeAReCdNnvp+uKN7wG3+X2yEaCz8ncdCdAw==
X-Received: by 2002:a05:620a:f92:: with SMTP id b18mr13123017qkn.146.1610727799140;
        Fri, 15 Jan 2021 08:23:19 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:dbed])
        by smtp.gmail.com with ESMTPSA id h26sm4950319qtq.18.2021.01.15.08.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 08:23:17 -0800 (PST)
Date:   Fri, 15 Jan 2021 11:20:50 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: prevent starvation when writing
 memory.high
Message-ID: <YAHA4uBSLlnxxAbu@cmpxchg.org>
References: <20210112163011.127833-1-hannes@cmpxchg.org>
 <20210113144654.GD22493@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113144654.GD22493@dhcp22.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jan 13, 2021 at 03:46:54PM +0100, Michal Hocko wrote:
> On Tue 12-01-21 11:30:11, Johannes Weiner wrote:
> > When a value is written to a cgroup's memory.high control file, the
> > write() context first tries to reclaim the cgroup to size before
> > putting the limit in place for the workload. Concurrent charges from
> > the workload can keep such a write() looping in reclaim indefinitely.
> > 
> > In the past, a write to memory.high would first put the limit in place
> > for the workload, then do targeted reclaim until the new limit has
> > been met - similar to how we do it for memory.max. This wasn't prone
> > to the described starvation issue. However, this sequence could cause
> > excessive latencies in the workload, when allocating threads could be
> > put into long penalty sleeps on the sudden memory.high overage created
> > by the write(), before that had a chance to work it off.
> > 
> > Now that memory_high_write() performs reclaim before enforcing the new
> > limit, reflect that the cgroup may well fail to converge due to
> > concurrent workload activity. Bail out of the loop after a few tries.
> 
> I can see that you have provided some more details in follow up replies
> but I do not see any explicit argument why an excessive time for writer
> is an actual problem. Could you be more specific?

Our writer isn't necessarily time sensitive, but there is a difference
between a) the write taking a few seconds to reclaim down the
requested delta and b) the writer essentially turning into kswapd for
the workload and busy-spinning inside the kernel indefinitely.

We've seen the writer stuck in this function for minutes, long after
the requested delta has been reclaimed, consuming alarming amounts of
CPU cycles - CPU time that should really be accounted to the workload,
not the system software performing the write.

Obviously, we could work around it using timeouts and signals. In
fact, we may have to until the new kernel is deployed everywhere. But
this is the definition of an interface change breaking userspace, so
I'm a bit surprised by your laid-back response.

> > Fixes: 536d3bf261a2 ("mm: memcontrol: avoid workload stalls when lowering memory.high")
> > Cc: <stable@vger.kernel.org> # 5.8+
> 
> Why is this worth backporting to stable? The behavior is different but I
> do not think any of them is harmful.

The referenced patch changed user-visible behavior in a way that is
causing real production problems for us. From stable-kernel-rules:

 - It must fix a real bug that bothers people (not a, "This could be a
   problem..." type thing).

> > Reported-by: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> I am not against the patch. The existing interface doesn't provide any
> meaningful feedback to the userspace anyway. User would have to re check
> to see the result of the operation. So how hard we try is really an
> implementation detail.

Yeah, I wish it was a bit more consistent from an interface POV.

Btw, if you have noticed, Roman's patch to enforce memcg->high *after*
trying to reclaim went into the tree at the same exact time as Chris's
series "mm, memcg: reclaim harder before high throttling" (commit
b3ff92916af3b458712110bb83976a23471c12fa). It's likely they overlap.

Chris's patch changes memory.high reclaim on the allocation side from

	reclaim once, sleep if there is still overage

to

	reclaim the overage as long as you make forward progress;
	sleep after 16 no-progress loops if there is still overage

Roman's patch describes a problem where allocating threads go to sleep
when memory.high is lowered by a wider step. This is exceedingly
unlikely after Chris's change.

Because after Chris's change, memory.high is reclaimed on the
allocation side as aggressively as memory.max. The only difference is
that upon failure, one sleeps and the other OOMs.

If Roman's issue were present after Chris's change, then we'd also see
premature OOM kills when memory.max is lowered by a large step. And I
have never seen that happening.

So I suggest instead of my fix here, we revert Roman's patch instead,
as it should no longer be needed. Thoughts?
