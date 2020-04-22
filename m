Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E841B4CDB
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2020 20:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgDVStZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Apr 2020 14:49:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34832 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgDVStZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Apr 2020 14:49:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id x18so3762641wrq.2
        for <cgroups@vger.kernel.org>; Wed, 22 Apr 2020 11:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FbPPWpYkZnIMG2RggwQqEZ2RVvkykjibS0WXqdLfUdQ=;
        b=Vd3w7G+xVbhJgYcxk4RPGUwOTg9wLCVUAt+fN+uV9xBD/wKSbGDH+wids3Zs9ej8t3
         2ZIX+FlroPQh1ayuwoeX9e1AhGjHjVhiXKwFZYl2omCz3gxWZcCk/3cpo493vA0aWjV+
         CubgVtXPQSnVMpwWosVJnLOSh1eRJdZ+3ekGuaDWZwgej6jNxLN8D2OiEIhkQGoSkG8H
         hF6z1nwPhXKha2VDPWjKauCwujvW1sCIMSwq3hGVOB4moL6lniT7j/0A9WXvxUiTAFc5
         UhJNsNA+GhrHJK5rTn9Li6E80DBT+2x9db1GifRALDeRMWXHGWsGNGxvhfG/+Vpb6hc2
         od1A==
X-Gm-Message-State: AGi0PuYMHu+ZX8RSNo3zqEYYELQQCQsOOkaLAOEwyzsPl/xaXaj33Y+S
        4iVZgSpHEWaLJsb0tmBajmhxGa0h
X-Google-Smtp-Source: APiQypL8dFHQu9vVFnP6IiwOlw0Ztqt4pCV4ecVJhEgtDndI2BkMJQtw83n0sbXbQJI2YI9mPHyWoQ==
X-Received: by 2002:a5d:6302:: with SMTP id i2mr519579wru.80.1587581363265;
        Wed, 22 Apr 2020 11:49:23 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id x132sm201271wmg.33.2020.04.22.11.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 11:49:22 -0700 (PDT)
Date:   Wed, 22 Apr 2020 20:49:21 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH 0/3] memcg: Slow down swap allocation as the available
 space gets depleted
Message-ID: <20200422184921.GB4206@dhcp22.suse.cz>
References: <20200420170318.GV27314@dhcp22.suse.cz>
 <20200420170650.GA169746@mtj.thefacebook.com>
 <20200421110612.GD27314@dhcp22.suse.cz>
 <20200421142746.GA341682@cmpxchg.org>
 <20200421161138.GL27314@dhcp22.suse.cz>
 <20200421165601.GA345998@cmpxchg.org>
 <20200422132632.GG30312@dhcp22.suse.cz>
 <20200422141514.GA362484@cmpxchg.org>
 <20200422154318.GK30312@dhcp22.suse.cz>
 <20200422171328.GC362484@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422171328.GC362484@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 22-04-20 13:13:28, Johannes Weiner wrote:
> On Wed, Apr 22, 2020 at 05:43:18PM +0200, Michal Hocko wrote:
> > On Wed 22-04-20 10:15:14, Johannes Weiner wrote:
[...]
> > > +	Swap usage throttle limit.  If a cgroup's swap usage exceeds
> > > +	this limit, allocations inside the cgroup will be throttled.
> > 
> > Hm, so this doesn't talk about which allocatios are affected. This is
> > good for potential future changes but I am not sure this is useful to
> > make any educated guess about the actual effects. One could expect that
> > only those allocations which could contribute to future memory.swap
> > usage. I fully realize that we do not want to be very specific but we
> > want to provide something useful I believe. I am sorry but I do not have
> > a good suggestion on how to make this better. Mostly because I still
> > struggle on how this should behave to be sane.
> 
> I honestly don't really follow you here. Why is it not helpful to say
> all allocations will slow down when condition X is met?

This might be just me and I definitely do not want to pick on words here
but your wording was not specific on which allocations. You can very
well interpret that as really all allocations but I wouldn't be surprised
if some would interpret it in a way that the kernel doesn't throttle
unnecessarily and if allocations cannot really contribute to more swap
then why should they be throttled.

> We do the same for memory.high.
>
> > I am also missing some information about what the user can actually do
> > about this situation and call out explicitly that the throttling is
> > not going away until the swap usage is shrunk and the kernel is not
> > capable of doing that on its own without a help from the userspace. This
> > is really different from memory.high which has means to deal with the
> > excess and shrink it down in most cases. The following would clarify it
> 
> I think we may be talking past each other. The user can do the same
> thing as in any OOM situation: wait for the kill.

That assumes that reaching swap.high is going to converge to the OOM
eventually. And that is far from the general case. There might be a
lot of other reclaimable memory to reclaim and stay in the current
state.
 
[...]

> > for me
> > 	"Once the limit is exceeded it is expected that the userspace
> > 	 is going to act and either free up the swapped out space
> > 	 or tune the limit based on needs. The kernel itself is not
> > 	 able to do that on its own.
> > 	"
> 
> I mean, in rare cases, maybe userspace can do some loadshedding and be
> smart about it. But we certainly don't expect it to.

I really didn't mean to suggest any clever swap management.  All I
wanted so say and have documented is that users of swap.high should
be aware of the fact that kernel is not able to do much to reduce the
throttling. This is really different from memory.high where the kernel
pro-actively tries to keep the memory usage below the watermark.  So a
certain level of userspace cooperation is really needed unless you can
tolerate a workload to be throttled to the end of times.

So let me be clear here. This is a very tricky interface to use and the
more verbose we can be the better.
-- 
Michal Hocko
SUSE Labs
