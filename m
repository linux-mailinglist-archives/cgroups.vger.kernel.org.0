Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7BC61DBBF5
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2020 19:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgETRwF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 May 2020 13:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgETRwA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 May 2020 13:52:00 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E705C061A0E
        for <cgroups@vger.kernel.org>; Wed, 20 May 2020 10:51:59 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id dh1so1730506qvb.13
        for <cgroups@vger.kernel.org>; Wed, 20 May 2020 10:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BBt9l8cUazK4TnjR35XVTQxIy3dkIye1Hokpe2DSKT0=;
        b=QvrXDmy07KF+8sdXRlLr8XCujGmu3TUNcNETHmwk8hoxSlXc0+2+926W0PDByCWR0d
         52mwdgUvRcNE4e9Wyj+omtW1XSlbODdDd73Uph/4Xd83B6zeMsFH+oIw0xdUeoDMRn1o
         YmWtERuOYaoGCEVJeiC1qngsN8R0XwZrKYJjv2VBZ+QB+EzeHiUhUWiLn3vI8d2wYL4f
         j5v+1G9pbwfyw2F/RxegM47t5QUFVqS7xgyemLMhHqqo6dco6hte0Hoh+xf/c3u+KnvX
         13QxNL79YQ2fCcqI3qpTOv9nM4GIqd3mI61+aljOPyQPPq3JV2FptKR55qAqaH71IMLb
         wdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BBt9l8cUazK4TnjR35XVTQxIy3dkIye1Hokpe2DSKT0=;
        b=MjmQY+L/QEWI6uRy4rT5lDYHj5T7qGSejGk0tiAzAlmzdbKcYhSnXasaAk4lmy/pT2
         ukN/WoZ+BXcQndGK4BRp94b5yUqVRfU7pcDzFptR9Cwb255CKdiWn9W5LdNw0Qawix0n
         83rnRvqG13GkXx/62s5tUnG9ChxcF7V4mjkP48//MwENhcwCLgnmUKakVil3/t4hTN+E
         Z8cQpX3nhFAJjU6n1tQBgismxzdrpnCq2xBQ89/iRvNyKW/tN9Mdu/ECgj5MzoOEMSFA
         50zKD7ZTJLguqwpuju3EersSkaRtZfzZxzXeJKOykzVNXcwOobGwY2Zzk5fqvWEIjfRL
         wd2g==
X-Gm-Message-State: AOAM533lNYN8Q8BhAwkE20SS2v2YVjc44s67oziqFT64+GEc4iHGqudZ
        UqgMiObiiD9saKA7ZsYiHQfD/w==
X-Google-Smtp-Source: ABdhPJz04mLZ8PDzBUJwn2l+EaHEZdex/tWdtF/HC1qK0VQtYi4cimOQC3LRX9lG0z47uP1ao/RGKg==
X-Received: by 2002:a05:6214:15ce:: with SMTP id p14mr2783533qvz.159.1589997118771;
        Wed, 20 May 2020 10:51:58 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4708])
        by smtp.gmail.com with ESMTPSA id n123sm2941239qkf.23.2020.05.20.10.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 10:51:58 -0700 (PDT)
Date:   Wed, 20 May 2020 13:51:35 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200520175135.GA793901@cmpxchg.org>
References: <20200520143712.GA749486@chrisdown.name>
 <20200520160756.GE6462@dhcp22.suse.cz>
 <20200520165131.GB630613@cmpxchg.org>
 <20200520170430.GG6462@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520170430.GG6462@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 20, 2020 at 07:04:30PM +0200, Michal Hocko wrote:
> On Wed 20-05-20 12:51:31, Johannes Weiner wrote:
> > On Wed, May 20, 2020 at 06:07:56PM +0200, Michal Hocko wrote:
> > > On Wed 20-05-20 15:37:12, Chris Down wrote:
> > > > In Facebook production, we've seen cases where cgroups have been put
> > > > into allocator throttling even when they appear to have a lot of slack
> > > > file caches which should be trivially reclaimable.
> > > > 
> > > > Looking more closely, the problem is that we only try a single cgroup
> > > > reclaim walk for each return to usermode before calculating whether or
> > > > not we should throttle. This single attempt doesn't produce enough
> > > > pressure to shrink for cgroups with a rapidly growing amount of file
> > > > caches prior to entering allocator throttling.
> > > > 
> > > > As an example, we see that threads in an affected cgroup are stuck in
> > > > allocator throttling:
> > > > 
> > > >     # for i in $(cat cgroup.threads); do
> > > >     >     grep over_high "/proc/$i/stack"
> > > >     > done
> > > >     [<0>] mem_cgroup_handle_over_high+0x10b/0x150
> > > >     [<0>] mem_cgroup_handle_over_high+0x10b/0x150
> > > >     [<0>] mem_cgroup_handle_over_high+0x10b/0x150
> > > > 
> > > > ...however, there is no I/O pressure reported by PSI, despite a lot of
> > > > slack file pages:
> > > > 
> > > >     # cat memory.pressure
> > > >     some avg10=78.50 avg60=84.99 avg300=84.53 total=5702440903
> > > >     full avg10=78.50 avg60=84.99 avg300=84.53 total=5702116959
> > > >     # cat io.pressure
> > > >     some avg10=0.00 avg60=0.00 avg300=0.00 total=78051391
> > > >     full avg10=0.00 avg60=0.00 avg300=0.00 total=78049640
> > > >     # grep _file memory.stat
> > > >     inactive_file 1370939392
> > > >     active_file 661635072
> > > > 
> > > > This patch changes the behaviour to retry reclaim either until the
> > > > current task goes below the 10ms grace period, or we are making no
> > > > reclaim progress at all. In the latter case, we enter reclaim throttling
> > > > as before.
> > > 
> > > Let me try to understand the actual problem. The high memory reclaim has
> > > a target which is proportional to the amount of charged memory. For most
> > > requests that would be SWAP_CLUSTER_MAX though (resp. N times that where
> > > N is the number of memcgs in excess up the hierarchy). I can see to be
> > > insufficient if the memcg is already in a large excess but if the
> > > reclaim can make a forward progress this should just work fine because
> > > each charging context should reclaim at least the contributed amount.
> > > 
> > > Do you have any insight on why this doesn't work in your situation?
> > > Especially with such a large inactive file list I would be really
> > > surprised if the reclaim was not able to make a forward progress.
> > 
> > The workload we observed this in was downloading a large file and
> > writing it to disk, which means that a good chunk of that memory was
> > dirty. The first reclaim pass appears to make little progress because
> > it runs into dirty pages.
> 
> OK, I see but why does the subsequent reclaim attempt makes a forward
> progress? Is this just because dirty pages are flushed in the mean time?
> Because if this is the case then the underlying problem seems to be that
> the reclaim should be throttled on dirty data.

That's what I assume. Chris wanted to do more reclaim tracing. But is
this actually important beyond maybe curiosity?

We retry every other reclaim invocation on forward progress. There is
not a single naked call to try_to_free_pages(), and this here is the
only exception where we don't loop on try_to_free_mem_cgroup_pages().

And there are very good, widely established reason for that:

Under pressure, page reclaim can struggle to satisfy the reclaim
goal and may return with less pages reclaimed than asked to.

Under concurrency, a parallel allocation can invalidate the reclaim
progress made by a thread.

When either of these happen, the reclaiming thread should not throw
its hands up and give up. It shouldn't invoke the kernel OOM killer,
and it shouldn't go to sleep to trigger the userspace OOM killer.
Reclaim hasn't failed as long as there is forward progress to be made.

This isn't a daring concept, it's standard practice throughout the VM.

I don't quite understand what makes this situation different. It's not
*that* important which of the many known reasons for reclaim to not
succeed on first try has prompted this patch, is it?

> > > Now to your patch. I do not like it much to be honest.
> > > MEM_CGROUP_RECLAIM_RETRIES is quite arbitrary and I neither like it in
> > > memory_high_write because the that is an interruptible context so there
> > > shouldn't be a good reason to give up after $FOO number of failed
> > > attempts. try_charge and memory_max_write are slightly different because
> > > we are invoking OOM killer based on the number of failed attempts.
> > 
> > The same is true for memory.high. We are invoking the userspace OOM
> > killer when memory.high reclaim fails and we put tasks to sleep.
> 
> Right but there is no way to indicate that the reclaim has failed when
> writing to memory.high.

I'm less concerned about memory.high-writing than try_charge().

Although IMO it's nice to be consistent and make the same effort as we
would everywhere else to meet the limit before returning from the write().

> > The actual number of retries is arbitrary, correct. That's because OOM
> > is arbitrary. It's a sampled state, and this is our sampling period.
> > 
> > But it's not that important. The much more important thing is that we
> > continue reclaiming as long as there is forward progress. How many
> > times we retry when there is no forward progress is less critical -
> > but it's nice to have the same cutoff for OOM situations everywhere.
> > 
> > > Also if the current high reclaim scaling is insufficient then we should
> > > be handling that via memcg_nr_pages_over_high rather than effectivelly
> > > unbound number of reclaim retries.
> > 
> > ???
> 
> I am not sure what you are asking here.

You expressed that some alternate solution B would be preferable,
without any detail on why you think that is the case.

And it's certainly not obvious or self-explanatory - in particular
because Chris's proposal *is* obvious and self-explanatory, given how
everybody else is already doing loops around page reclaim.
