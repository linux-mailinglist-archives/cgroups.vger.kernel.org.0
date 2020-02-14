Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9C215D34B
	for <lists+cgroups@lfdr.de>; Fri, 14 Feb 2020 08:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgBNH7V (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Feb 2020 02:59:21 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40799 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbgBNH7V (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Feb 2020 02:59:21 -0500
Received: by mail-wr1-f67.google.com with SMTP id t3so9772619wru.7;
        Thu, 13 Feb 2020 23:59:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=udCkngad74/IZdO0bbcBH03qd1xNzhotx1Ov+wg5Bm4=;
        b=YmZIZ7JDq6ULsNsLseZCKuTnvUMdi/yA9gaGLkr7SUjWCBoRUsmz12YsB0X9Q9dANa
         rP0QoXHiEVinsWEV+M0kAzBwOYJvqfSwWj4/JmY5bB5qu/cFdK6NKMsDF2u8Xp8fsfZT
         pKQbTpK9jXrIqIxOaTbE1k6ikr3rjrgBghJHz9S3VV0NSx1o4HZo25om28nZ7TE/mI7q
         c+rFoGqIcK4sGDkJbAJX6L7/MKfhLpqXSNBi2vLaxYcOFq4NLIRBhUVjQnQlV15ua8Fz
         ZY0nZVv0Qh8kChZ3A5gjoy/xuRpgVPJkJ2wPqy+BAbiLt1IMrkefSyFIJIBTbaWm378V
         +IeA==
X-Gm-Message-State: APjAAAXEOz+kNTXKEiUUQ+cui0zm6Btf+QMQiy4EuGW+Z5+NZ8ZXotPf
        7le1iRHeH6bdcpZxXVewF1U=
X-Google-Smtp-Source: APXvYqxz+jkxylBT36UuGzhfxMV0vrrr2Y0p0MKJoHUiZtm0iiGSTFkgcNyOlgsJFlYeuUQybauVLg==
X-Received: by 2002:a5d:484d:: with SMTP id n13mr2481187wrs.420.1581667159094;
        Thu, 13 Feb 2020 23:59:19 -0800 (PST)
Received: from localhost (ip-37-188-133-87.eurotel.cz. [37.188.133.87])
        by smtp.gmail.com with ESMTPSA id n1sm6026173wrw.52.2020.02.13.23.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 23:59:17 -0800 (PST)
Date:   Fri, 14 Feb 2020 08:59:16 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] mm: memcontrol: recursive memory.low protection
Message-ID: <20200214075916.GM31689@dhcp22.suse.cz>
References: <20191219200718.15696-4-hannes@cmpxchg.org>
 <20200130170020.GZ24244@dhcp22.suse.cz>
 <20200203215201.GD6380@cmpxchg.org>
 <20200211164753.GQ10636@dhcp22.suse.cz>
 <20200212170826.GC180867@cmpxchg.org>
 <20200213074049.GA31689@dhcp22.suse.cz>
 <20200213132317.GA208501@cmpxchg.org>
 <20200213154627.GD31689@dhcp22.suse.cz>
 <20200213174135.GC208501@cmpxchg.org>
 <20200213175813.GA216470@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213175813.GA216470@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 13-02-20 12:58:13, Johannes Weiner wrote:
> On Thu, Feb 13, 2020 at 12:41:36PM -0500, Johannes Weiner wrote:
> > On Thu, Feb 13, 2020 at 04:46:27PM +0100, Michal Hocko wrote:
> > > On Thu 13-02-20 08:23:17, Johannes Weiner wrote:
> > > > On Thu, Feb 13, 2020 at 08:40:49AM +0100, Michal Hocko wrote:
> > > > > On Wed 12-02-20 12:08:26, Johannes Weiner wrote:
> > > > > > On Tue, Feb 11, 2020 at 05:47:53PM +0100, Michal Hocko wrote:
> > > > > > > Unless I am missing something then I am afraid it doesn't. Say you have a
> > > > > > > default systemd cgroup deployment (aka deeper cgroup hierarchy with
> > > > > > > slices and scopes) and now you want to grant a reclaim protection on a
> > > > > > > leaf cgroup (or even a whole slice that is not really important). All the
> > > > > > > hierarchy up the tree has the protection set to 0 by default, right? You
> > > > > > > simply cannot get that protection. You would need to configure the
> > > > > > > protection up the hierarchy and that is really cumbersome.
> > > > > > 
> > > > > > Okay, I think I know what you mean. Let's say you have a tree like
> > > > > > this:
> > > > > > 
> > > > > >                           A
> > > > > >                          / \
> > > > > >                         B1  B2
> > > > > >                        / \   \
> > > > > >                       C1 C2   C3
> 
> > > > > So let's see how that works in practice, say a multi workload setup
> > > > > with a complex/deep cgroup hierachies (e.g. your above example). No
> > > > > delegation point this time.
> > > > > 
> > > > > C1 asks for low=1G while using 500M, C3 low=100M using 80M.  B1 and
> > > > > B2 are completely independent workloads and the same applies to C2 which
> > > > > doesn't ask for any protection at all? C2 uses 100M. Now the admin has
> > > > > to propagate protection upwards so B1 low=1G, B2 low=100M and A low=1G,
> > > > > right? Let's say we have a global reclaim due to external pressure that
> > > > > originates from outside of A hierarchy (it is not overcommited on the
> > > > > protection).
> > > > > 
> > > > > Unless I miss something C2 would get a protection even though nobody
> > > > > asked for it.
> > > > 
> > > > Good observation, but I think you spotted an unintentional side effect
> > > > of how I implemented the "floating protection" calculation rather than
> > > > a design problem.
> > > > 
> > > > My patch still allows explicit downward propagation. So if B1 sets up
> > > > 1G, and C1 explicitly claims those 1G (low>=1G, usage>=1G), C2 does
> > > > NOT get any protection. There is no "floating" protection left in B1
> > > > that could get to C2.
> > > 
> > > Yeah, the saturated protection works reasonably AFAICS.
> > 
> > Hm, Tejun raises a good point though: even if you could direct memory
> > protection down to one targeted leaf, you can't do the same with IO or
> > CPU. Those follow non-conserving weight distribution, and whatever you
> 
>                     "work-conserving", obviously.
> 
> > allocate to a certain level is available at that level - if one child
> > doesn't consume it, the other children can.

Right, but isn't this pretty much a definition of weight based resource
distribution? Memory knobs operate in absolute numbers (limits) and that
means that children might both over/under commit what parent assigns to
them. Or have I misunderstood you here?

> > And we know that controlling memory without controlling IO doesn't
> > really work in practice. The sibling with less memory allowance will
> > just page more.
> > 
> > So the question becomes: is this even a legit usecase? If every other
> > resource is distributed on a level-by-level method already, does it
> > buy us anything to make memory work differently?

Aren't you mixing weights and limits here? I am quite confused TBH.

Let me give you an example. Say you have a DB workload which is the
primary thing running on your system and which you want to protect from
an unrelated activity (backups, frontends, etc). Running it inside a
cgroup with memory.low while other components in other cgroups without
any protection achieves that. If those cgroups are top level then this
is simple and straightforward configuration.

Things would get much more tricky if you want run the same workload
deeper down the hierarchy - e.g. run it in a container. Now your
"root" has to use an explicit low protection as well and all other
potential cgroups that are in the same sub-hierarchy (read in the same
container) need to opt-out from the protection because they are not
meant to be protected.

In short we simply have to live with usecases where the cgroup hierarchy
follows the "logical" workload organization at the higher level more
than resource control. This is the case for systemd as well btw.
Workloads are organized into slices and scopes without any direct
relation to resources in mind.

Does this make it more clear what I am thinking about? Does it sound
like a legit usecase?
-- 
Michal Hocko
SUSE Labs
