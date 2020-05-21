Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09171DCD0E
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 14:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgEUMhr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 May 2020 08:37:47 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:44425 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgEUMhq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 May 2020 08:37:46 -0400
Received: by mail-ej1-f66.google.com with SMTP id x20so8566421ejb.11;
        Thu, 21 May 2020 05:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2vhA5VZC0nBvo7ys++OSqz3+TT1aqRd8PraCHE7WA7k=;
        b=U6/k5ElFSdZME2o5n7me/vMJMF0YoXJvrpKyg3z2aPljSwtldN699JLNHL1FZVpg+R
         UsOZlQu1c0lL24UDvOEesP184yfPNmSlqhrM2kvewi3cHVWYmh+ky5de4pUus9ZwV1Mu
         bQN3pvfxfERnfuGfwGJIOGG725jSLCys8EGm8Y1iYlkCWLzeh8uDjji0JRfCRQLQIf8m
         yG+i3eINvP1f9fsu1rUvOLheEt0ZLz5K58a6VuoMWh6LqHqTOrCr2HxVpBUptOSJj2os
         jDEexTAcCjK9HuCrJMJVsJGDwG1ayPCh9DrfcWeIkAFkVj3zlqpNRoOtbuB6/ADK4eQI
         eQZg==
X-Gm-Message-State: AOAM531TI9xQkKUzwuRTulJpjUMduKjNRYI7kbULCKfATVe8k+wqub/t
        vUJeFl/J+JWGw0S5gphV174=
X-Google-Smtp-Source: ABdhPJz3IWgvzhsJwT+nI7vhlMqWbOUJ8KKpNxjwtDjBUDZk1awt/EAZFDeW9+LNiq9SeMvb8vZp2g==
X-Received: by 2002:a17:906:9518:: with SMTP id u24mr3393542ejx.137.1590064664511;
        Thu, 21 May 2020 05:37:44 -0700 (PDT)
Received: from localhost (ip-37-188-180-112.eurotel.cz. [37.188.180.112])
        by smtp.gmail.com with ESMTPSA id lx8sm4721542ejb.75.2020.05.21.05.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 05:37:43 -0700 (PDT)
Date:   Thu, 21 May 2020 14:37:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200521123742.GO6462@dhcp22.suse.cz>
References: <20200520143712.GA749486@chrisdown.name>
 <20200520160756.GE6462@dhcp22.suse.cz>
 <20200520202650.GB558281@chrisdown.name>
 <20200521071929.GH6462@dhcp22.suse.cz>
 <20200521112711.GA990580@chrisdown.name>
 <20200521120455.GM6462@dhcp22.suse.cz>
 <20200521122327.GB990580@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521122327.GB990580@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 21-05-20 13:23:27, Chris Down wrote:
> (I'll leave the dirty throttling discussion to Johannes, because I'm not so
> familiar with that code or its history.)
> 
> Michal Hocko writes:
> > > > The main problem I see with that approach is that the loop could easily
> > > > lead to reclaim unfairness when a heavy producer which doesn't leave the
> > > > kernel (e.g. a large read/write call) can keep a different task doing
> > > > all the reclaim work. The loop is effectivelly unbound when there is a
> > > > reclaim progress and so the return to the userspace is by no means
> > > > proportional to the requested memory/charge.
> > > 
> > > It's not unbound when there is reclaim progress, it stops when we are within
> > > the memory.high throttling grace period. Right after reclaim, we check if
> > > penalty_jiffies is less than 10ms, and abort and further reclaim or
> > > allocator throttling:
> > 
> > Just imagine that you have parallel producers increasing the high limit
> > excess while somebody reclaims those. Sure in practice the loop will be
> > bounded but the reclaimer might perform much more work on behalf of
> > other tasks.
> 
> A cgroup is a unit and breaking it down into "reclaim fairness" for
> individual tasks like this seems suspect to me. For example, if one task in
> a cgroup is leaking unreclaimable memory like crazy, everyone in that cgroup
> is going to be penalised by allocator throttling as a result, even if they
> aren't "responsible" for that reclaim.

You are right, but that doesn't mean that it is desirable that some
tasks would be throttled unexpectedly too long because of the other's activity.
We already have that behavior for the direct reclaim and I have to say I
really hate it and had to spend a lot of time debugging latency issues.
Our excuse has been that the system is struggling at that time so any
quality of service is simply out of picture. I do not think the same
argument can be applied to memory.high which doesn't really represent a
mark when the memcg is struggling so hard to drop any signs of fairness
on the floor.

> So the options here are as follows when a cgroup is over memory.high and a
> single reclaim isn't enough:
> 
> 1. Decline further reclaim. Instead, throttle for up to 2 seconds.
> 2. Keep on reclaiming. Only throttle if we can't get back under memory.high.
> 
> The outcome of your suggestion to decline further reclaim is case #1, which
> is significantly more practically "unfair" to that task. Throttling is
> extremely disruptive to tasks and should be a last resort when we've
> exhausted all other practical options. It shouldn't be something you get
> just because you didn't try to reclaim hard enough.

I believe I have asked in other email in this thread. Could you explain
why enforcint the requested target (memcg_nr_pages_over_high) is
insufficient for the problem you are dealing with? Because that would
make sense for large targets to me while it would keep relatively
reasonable semantic of the throttling - aka proportional to the memory
demand rather than the excess.
-- 
Michal Hocko
SUSE Labs
