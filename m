Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669DB1DC7B8
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 09:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgEUHcw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 May 2020 03:32:52 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39711 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgEUHcw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 May 2020 03:32:52 -0400
Received: by mail-ed1-f67.google.com with SMTP id bs4so5954682edb.6;
        Thu, 21 May 2020 00:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CIs2f+9mvt6X0epmC+MlJo55capX2w3vIg9emhYp22E=;
        b=LX0XVzjwWtVWl46mtpJoXQvCvOaYooz7plewctsHXM2UZ5hyzOQNzvTs5ZkfxevqyH
         DMFXAelXPerbXYwzn2VUCQ7V6p6CCS+4MKSKb106mh5u8AJTA8+3GU0d7JJ01WkbIQ7u
         0lAWxiJ/QezHhaUA5DtIH6cepSeG/Lvc6pEyBBYg0PNPkNKTlXm0TSSWEJY96sSy9xH8
         zTGriW9zvW2gOBlmLmvRYvUc0h3QgaWFKlzuJV25sLUvYSr6nr51k+rrhNzWV2aQxOD6
         oxhk4P2r9+8M24b1Ve2BK529tPAD0g790t7YNcx7IkBzIfbW1R2EbKQ3Mn6lqxZK9Ri6
         I5iQ==
X-Gm-Message-State: AOAM531Rw4b749MM3v18eKkSq7i/3jtQbxxm8CL+z3TzgPQWdzziurlV
        otcBAn46Xu1xFw3hhjmfh78=
X-Google-Smtp-Source: ABdhPJxCKk/t2VY13WddHe4RLLp/gX40dcFgqguBcisAcJV20a5GHx4V0pn7ipz9AjzCL9dfxSK6iw==
X-Received: by 2002:a05:6402:8c1:: with SMTP id d1mr6811027edz.265.1590046368007;
        Thu, 21 May 2020 00:32:48 -0700 (PDT)
Received: from localhost (ip-37-188-180-112.eurotel.cz. [37.188.180.112])
        by smtp.gmail.com with ESMTPSA id kq5sm4085647ejb.20.2020.05.21.00.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 00:32:46 -0700 (PDT)
Date:   Thu, 21 May 2020 09:32:45 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200521073245.GI6462@dhcp22.suse.cz>
References: <20200520143712.GA749486@chrisdown.name>
 <20200520160756.GE6462@dhcp22.suse.cz>
 <20200520165131.GB630613@cmpxchg.org>
 <20200520170430.GG6462@dhcp22.suse.cz>
 <20200520175135.GA793901@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520175135.GA793901@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 20-05-20 13:51:35, Johannes Weiner wrote:
> On Wed, May 20, 2020 at 07:04:30PM +0200, Michal Hocko wrote:
> > On Wed 20-05-20 12:51:31, Johannes Weiner wrote:
> > > On Wed, May 20, 2020 at 06:07:56PM +0200, Michal Hocko wrote:
> > > > On Wed 20-05-20 15:37:12, Chris Down wrote:
> > > > > In Facebook production, we've seen cases where cgroups have been put
> > > > > into allocator throttling even when they appear to have a lot of slack
> > > > > file caches which should be trivially reclaimable.
> > > > > 
> > > > > Looking more closely, the problem is that we only try a single cgroup
> > > > > reclaim walk for each return to usermode before calculating whether or
> > > > > not we should throttle. This single attempt doesn't produce enough
> > > > > pressure to shrink for cgroups with a rapidly growing amount of file
> > > > > caches prior to entering allocator throttling.
> > > > > 
> > > > > As an example, we see that threads in an affected cgroup are stuck in
> > > > > allocator throttling:
> > > > > 
> > > > >     # for i in $(cat cgroup.threads); do
> > > > >     >     grep over_high "/proc/$i/stack"
> > > > >     > done
> > > > >     [<0>] mem_cgroup_handle_over_high+0x10b/0x150
> > > > >     [<0>] mem_cgroup_handle_over_high+0x10b/0x150
> > > > >     [<0>] mem_cgroup_handle_over_high+0x10b/0x150
> > > > > 
> > > > > ...however, there is no I/O pressure reported by PSI, despite a lot of
> > > > > slack file pages:
> > > > > 
> > > > >     # cat memory.pressure
> > > > >     some avg10=78.50 avg60=84.99 avg300=84.53 total=5702440903
> > > > >     full avg10=78.50 avg60=84.99 avg300=84.53 total=5702116959
> > > > >     # cat io.pressure
> > > > >     some avg10=0.00 avg60=0.00 avg300=0.00 total=78051391
> > > > >     full avg10=0.00 avg60=0.00 avg300=0.00 total=78049640
> > > > >     # grep _file memory.stat
> > > > >     inactive_file 1370939392
> > > > >     active_file 661635072
> > > > > 
> > > > > This patch changes the behaviour to retry reclaim either until the
> > > > > current task goes below the 10ms grace period, or we are making no
> > > > > reclaim progress at all. In the latter case, we enter reclaim throttling
> > > > > as before.
> > > > 
> > > > Let me try to understand the actual problem. The high memory reclaim has
> > > > a target which is proportional to the amount of charged memory. For most
> > > > requests that would be SWAP_CLUSTER_MAX though (resp. N times that where
> > > > N is the number of memcgs in excess up the hierarchy). I can see to be
> > > > insufficient if the memcg is already in a large excess but if the
> > > > reclaim can make a forward progress this should just work fine because
> > > > each charging context should reclaim at least the contributed amount.
> > > > 
> > > > Do you have any insight on why this doesn't work in your situation?
> > > > Especially with such a large inactive file list I would be really
> > > > surprised if the reclaim was not able to make a forward progress.
> > > 
> > > The workload we observed this in was downloading a large file and
> > > writing it to disk, which means that a good chunk of that memory was
> > > dirty. The first reclaim pass appears to make little progress because
> > > it runs into dirty pages.
> > 
> > OK, I see but why does the subsequent reclaim attempt makes a forward
> > progress? Is this just because dirty pages are flushed in the mean time?
> > Because if this is the case then the underlying problem seems to be that
> > the reclaim should be throttled on dirty data.
> 
> That's what I assume. Chris wanted to do more reclaim tracing. But is
> this actually important beyond maybe curiosity?

Yes, because it might show that there is a deeper problem. Having an
extremely large file list full of dirty data and pre-mature failure for
the reclaim sounds like a problem that is worth looking into closely.

> We retry every other reclaim invocation on forward progress. There is
> not a single naked call to try_to_free_pages(), and this here is the
> only exception where we don't loop on try_to_free_mem_cgroup_pages().

I am not saying the looping over try_to_free_pages is wrong. I do care
about the final reclaim target. That shouldn't be arbitrary. We have
established a target which is proportional to the requested amount of
memory. And there is a good reason for that. If any task tries to
reclaim down to the high limit then this might lead to a large
unfairness when heavy producers piggy back on the active reclaimer(s).

I wouldn't mind to loop over try_to_free_pages to meet the requested
memcg_nr_pages_over_high target.

[...]

> > > > Also if the current high reclaim scaling is insufficient then we should
> > > > be handling that via memcg_nr_pages_over_high rather than effectivelly
> > > > unbound number of reclaim retries.
> > > 
> > > ???
> > 
> > I am not sure what you are asking here.
> 
> You expressed that some alternate solution B would be preferable,
> without any detail on why you think that is the case.
> 
> And it's certainly not obvious or self-explanatory - in particular
> because Chris's proposal *is* obvious and self-explanatory, given how
> everybody else is already doing loops around page reclaim.

Sorry, I could have been less cryptic. I hope the above and my response
to Chris goes into more details why I do not like this proposal and what
is the alternative. But let me summarize. I propose to use memcg_nr_pages_over_high
target. If the current calculation of the target is unsufficient - e.g.
in situations where the high limit excess is very large then this should
be reflected in memcg_nr_pages_over_high.

Is it more clear?

-- 
Michal Hocko
SUSE Labs
