Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934871DCFF6
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 16:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbgEUOfU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 May 2020 10:35:20 -0400
Received: from mail-ej1-f43.google.com ([209.85.218.43]:42780 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgEUOfU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 May 2020 10:35:20 -0400
Received: by mail-ej1-f43.google.com with SMTP id se13so9054359ejb.9;
        Thu, 21 May 2020 07:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CU+URAOiaTBHZIYOLMUlPNn3m2wcv+iphqIOyVuOtwk=;
        b=P+XlbChfsbGe4Si5ItiY2sfAFacau+gGajGbeZcUkZjUj5mFhi7xekm0PYqvpJaWKr
         oqW9uECQ4m+oe7YL8hhVmQa2m7zi2Sj7oAw/ieuBILCWWvzluY40U19oszWgjoBzOwUg
         6mEwnE+SWhTSKIh6rcwSYDJDc4EaFWrKUVyUhE0FW3ELlNHjw6QPHDpyhF+IA1NoRyfH
         XqeMKPHA7uphtyFkjPZIN7utYzmjZo2gZA9+wQw9EkphrcxfPOl0K9m3yqiYwyARH9WZ
         Og+ZNMx8Xwc37roed5dFiJdkShzz9nqlOp8GsJ2q3/FjlZ7HznpsYWwQ0sJIlqm6HQAp
         ZGZA==
X-Gm-Message-State: AOAM530F+hmY+Vr+OaWwX79XaC62/EDt5y5uRqtsSm58U28k4iym8xSP
        HH3AhOsLkjw0mF88nee9SSA=
X-Google-Smtp-Source: ABdhPJwy5UVqhy2hd2MPmbnGZiwjLo8zlJjUJXRkIS9VzgWClA9n0F1GJHDd5SiZziEhBHQFyjuJZA==
X-Received: by 2002:a17:906:4a8b:: with SMTP id x11mr3702141eju.107.1590071717110;
        Thu, 21 May 2020 07:35:17 -0700 (PDT)
Received: from localhost (ip-37-188-180-112.eurotel.cz. [37.188.180.112])
        by smtp.gmail.com with ESMTPSA id x23sm1891978edr.14.2020.05.21.07.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 07:35:16 -0700 (PDT)
Date:   Thu, 21 May 2020 16:35:15 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200521143515.GU6462@dhcp22.suse.cz>
References: <20200520143712.GA749486@chrisdown.name>
 <20200520160756.GE6462@dhcp22.suse.cz>
 <20200520165131.GB630613@cmpxchg.org>
 <20200520170430.GG6462@dhcp22.suse.cz>
 <20200520175135.GA793901@cmpxchg.org>
 <20200521073245.GI6462@dhcp22.suse.cz>
 <20200521135152.GA810429@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521135152.GA810429@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 21-05-20 09:51:52, Johannes Weiner wrote:
> On Thu, May 21, 2020 at 09:32:45AM +0200, Michal Hocko wrote:
[...]
> > I am not saying the looping over try_to_free_pages is wrong. I do care
> > about the final reclaim target. That shouldn't be arbitrary. We have
> > established a target which is proportional to the requested amount of
> > memory. And there is a good reason for that. If any task tries to
> > reclaim down to the high limit then this might lead to a large
> > unfairness when heavy producers piggy back on the active reclaimer(s).
> 
> Why is that different than any other form of reclaim?

Because the high limit reclaim is a best effort rather than must to
either get over reclaim watermarks and continue allocation or meet the
hard limit requirement to continue.

In an ideal world even the global resp. hard limit reclaim should
consider fairness. They don't because that is easier but that sucks. I
have been involved in debugging countless of issues where direct reclaim
was taking too long because of the unfairness. Users simply see that as
bug and I am not surprised.

> > I wouldn't mind to loop over try_to_free_pages to meet the requested
> > memcg_nr_pages_over_high target.
> 
> Should we do the same for global reclaim? Move reclaim to userspace
> resume where there are no GFP_FS, GFP_NOWAIT etc. restrictions and
> then have everybody just reclaim exactly what they asked for, and punt
> interrupts / kthread allocations to a worker/kswapd?

This would be quite challenging considering the page allocator wouldn't
be able to make a forward progress without doing any reclaim. But maybe
you can be creative with watermarks.

> > > > > > Also if the current high reclaim scaling is insufficient then we should
> > > > > > be handling that via memcg_nr_pages_over_high rather than effectivelly
> > > > > > unbound number of reclaim retries.
> > > > > 
> > > > > ???
> > > > 
> > > > I am not sure what you are asking here.
> > > 
> > > You expressed that some alternate solution B would be preferable,
> > > without any detail on why you think that is the case.
> > > 
> > > And it's certainly not obvious or self-explanatory - in particular
> > > because Chris's proposal *is* obvious and self-explanatory, given how
> > > everybody else is already doing loops around page reclaim.
> > 
> > Sorry, I could have been less cryptic. I hope the above and my response
> > to Chris goes into more details why I do not like this proposal and what
> > is the alternative. But let me summarize. I propose to use memcg_nr_pages_over_high
> > target. If the current calculation of the target is unsufficient - e.g.
> > in situations where the high limit excess is very large then this should
> > be reflected in memcg_nr_pages_over_high.
> > 
> > Is it more clear?
> 
> Well you haven't made a good argument why memory.high is actually
> different than any other form of reclaim, and why it should be the
> only implementation of page reclaim that has special-cased handling
> for the inherent "unfairness" or rather raciness of that operation.
> 
> You cut these lines from the quote:
> 
>   Under pressure, page reclaim can struggle to satisfy the reclaim
>   goal and may return with less pages reclaimed than asked to.
> 
>   Under concurrency, a parallel allocation can invalidate the reclaim
>   progress made by a thread.
> 
> Even if we *could* invest more into trying to avoid any unfairness,
> you haven't made a point why we actually should do that here
> specifically, yet not everywhere else.

I have tried to explain my thinking elsewhere in the thread. The bottom
line is that high limit is a way of throttling rather than meeting a
specific target. With the current implementation we scale the reclaim
activity by the consumer's demand which is something that is not
terribly complex to wrap your head around and reason about. Because the
objective is to not increase the excess much. It offers some sort of
fairness as well. I fully recognize that a full fairness is not
something we can target but working reasonably well most of the time
sounds good enough for me.

> (And people have tried to do it for global reclaim[1], but clearly
> this isn't a meaningful problem in practice.)
> 
> I have a good reason why we shouldn't: because it's special casing
> memory.high from other forms of reclaim, and that is a maintainability
> problem. We've recently been discussing ways to make the memory.high
> implementation stand out less, not make it stand out even more. There
> is no solid reason it should be different from memory.max reclaim,
> except that it should sleep instead of invoke OOM at the end. It's
> already a mess we're trying to get on top of and straighten out, and
> you're proposing to add more kinks that will make this work harder.

I do see your point of course. But I do not give the code consistency
a higher priority than the potential unfairness aspect of the user
visible behavior for something that can do better. Really the direct
reclaim unfairness is really painfull and hard to explain to users. You
can essentially only hand wave that system is struggling so fairness is
not really a priority anymore.

> I have to admit, I'm baffled by this conversation. I consider this a
> fairly obvious, idiomatic change, and I cannot relate to the
> objections or counter-proposals in the slightest.

I have to admit that I would prefer a much less aggressive tone. We are
discussing a topic which is obviously not black and white and there are
different aspects of it.

Thanks!

> [1] http://lkml.iu.edu/hypermail//linux/kernel/0810.0/0169.html

-- 
Michal Hocko
SUSE Labs
