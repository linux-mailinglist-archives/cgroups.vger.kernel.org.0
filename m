Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6591B4B6A
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2020 19:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgDVRNc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Apr 2020 13:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726057AbgDVRNc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Apr 2020 13:13:32 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE35C03C1A9
        for <cgroups@vger.kernel.org>; Wed, 22 Apr 2020 10:13:31 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 20so3163176qkl.10
        for <cgroups@vger.kernel.org>; Wed, 22 Apr 2020 10:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MwyrCZRymIVF3h654uJnEBCqJ3AtG9v1tu0i4qSd6eM=;
        b=F2ZOPuj4V9GN5VN2W2CWgq90Bsax8po7aVqM1xq+7b9iqcwd18SeQRka8DMGRAn49q
         yEpOG0Dk9eyRg9YdDAT9SJjMRPiYO8K3H+ay8NJpFWLDyf6HaQ/kHCU0YCSbvJbWsN6f
         u8sRX/o8oozGqL1Cor/m1Yiz5xjCIvFul5nTjImnrorX4mgTe16FLVlGf6enl/AOro3y
         hQaaT81hzANlcFf96zPfyAegU79G5D+fOJg6aj4MxEJnxl30aGLJQR9N/JIjm9z/VdOg
         ymr7qpM4ZZV1CP7M6DG3XmEYq86spnTBkC7abrHnqcBmx/rIQb9FXDTN+4YQ0tPSwM4V
         3B1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MwyrCZRymIVF3h654uJnEBCqJ3AtG9v1tu0i4qSd6eM=;
        b=QmgFRsI4SvP6rjUGA2sIXVvlWbYw5WjGEn86n2FrkIkLw5fQU8OilguSSXQJpFIcZe
         tx/t8H9R5BJD5f6aHBnJuPUj2hI1ZOdJbLcQJ5PojSF8LoFXMm9cUXSAaGo2YCDBkCB4
         92bd5PoaekV5XIf7kZf0oIWkmxjrMCyKNPSC+Sd0vI/dxP7ca71ZTjW/7oDrbLjyvO5d
         RjEsuupnhdby9dt9o3ewHmA9HJnZ1GEeB3VhRWoTeANmrkiLbrIsN4ORlZW2v2FjC++S
         1Ar4YG7ep3Qk+LeNZakWxI6s6BLTlvx2tJiORnsiOxc50298gZI71OnoZB1pzYGbMrv9
         wYmw==
X-Gm-Message-State: AGi0PuaFY+Arxr4mgXilc/lyLAUZvx8hv36sejjcTQDsmJtA2z+Ej7u1
        Cxezj7Iy1wQ1sWLqrPMDoFSdeqwiGY0=
X-Google-Smtp-Source: APiQypLjZFtxAWxfBtcDpVxNE67M+0/HHajEG8u67pfUbPAgZV742n0ER1R1DJPHm9RS0Y/4X0l3QA==
X-Received: by 2002:a05:620a:81b:: with SMTP id s27mr27972475qks.351.1587575610127;
        Wed, 22 Apr 2020 10:13:30 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::921])
        by smtp.gmail.com with ESMTPSA id x66sm4318224qka.121.2020.04.22.10.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 10:13:29 -0700 (PDT)
Date:   Wed, 22 Apr 2020 13:13:28 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH 0/3] memcg: Slow down swap allocation as the available
 space gets depleted
Message-ID: <20200422171328.GC362484@cmpxchg.org>
References: <20200420164740.GF43469@mtj.thefacebook.com>
 <20200420170318.GV27314@dhcp22.suse.cz>
 <20200420170650.GA169746@mtj.thefacebook.com>
 <20200421110612.GD27314@dhcp22.suse.cz>
 <20200421142746.GA341682@cmpxchg.org>
 <20200421161138.GL27314@dhcp22.suse.cz>
 <20200421165601.GA345998@cmpxchg.org>
 <20200422132632.GG30312@dhcp22.suse.cz>
 <20200422141514.GA362484@cmpxchg.org>
 <20200422154318.GK30312@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422154318.GK30312@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 22, 2020 at 05:43:18PM +0200, Michal Hocko wrote:
> On Wed 22-04-20 10:15:14, Johannes Weiner wrote:
> > On Wed, Apr 22, 2020 at 03:26:32PM +0200, Michal Hocko wrote:
> > > That being said I believe our discussion is missing an important part.
> > > There is no description of the swap.high semantic. What can user expect
> > > when using it?
> > 
> > Good point, we should include that in cgroup-v2.rst. How about this?
> > 
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > index bcc80269bb6a..49e8733a9d8a 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1370,6 +1370,17 @@ PAGE_SIZE multiple when read back.
> >  	The total amount of swap currently being used by the cgroup
> >  	and its descendants.
> >  
> > +  memory.swap.high
> > +	A read-write single value file which exists on non-root
> > +	cgroups.  The default is "max".
> > +
> > +	Swap usage throttle limit.  If a cgroup's swap usage exceeds
> > +	this limit, allocations inside the cgroup will be throttled.
> 
> Hm, so this doesn't talk about which allocatios are affected. This is
> good for potential future changes but I am not sure this is useful to
> make any educated guess about the actual effects. One could expect that
> only those allocations which could contribute to future memory.swap
> usage. I fully realize that we do not want to be very specific but we
> want to provide something useful I believe. I am sorry but I do not have
> a good suggestion on how to make this better. Mostly because I still
> struggle on how this should behave to be sane.

I honestly don't really follow you here. Why is it not helpful to say
all allocations will slow down when condition X is met? We do the same
for memory.high.

> I am also missing some information about what the user can actually do
> about this situation and call out explicitly that the throttling is
> not going away until the swap usage is shrunk and the kernel is not
> capable of doing that on its own without a help from the userspace. This
> is really different from memory.high which has means to deal with the
> excess and shrink it down in most cases. The following would clarify it

I think we may be talking past each other. The user can do the same
thing as in any OOM situation: wait for the kill.

Swap being full is an OOM situation.

Yes, that does not match the kernel's internal definition of an OOM
situation. But we've already established that kernel OOM killing has a
different objective (memory deadlock avoidance) than userspace OOM
killing (quality of life)[1]

[1] https://lkml.org/lkml/2019/8/4/15

As Tejun said, things like earlyoom and oomd already kill based on
swap exhaustion, no further questions asked. Reclaim has been running
for a while, it went after all the low-hanging fruit: it doesn't swap
as long as there is easy cache; it also didn't just swap a little, it
filled up all of swap; and the pages in swap are all cold too, because
refaults would free that space again.

The workingset is hugely oversized for the available capacity, and
nobody has any interest in sticking around to see what tricks reclaim
still has up its sleeves (hint: nothing good). From here on out, it's
all thrashing and pain. The kernel might not OOM kill yet, but the quality
of life expectancy for a workload with full swap is trending toward zero.

We've been killing based on swap exhaustion as a stand-alone trigger
for several years now and it's never been the wrong call.

All swap.high does is acknowledge that swap-full is a common OOM
situation from a userspace view, and helps it handle that situation.

Just like memory.high acknowledges that if reclaim fails per kernel
definition, it's an OOM situation from a kernel view, and it helps
userspace handle that.

> for me
> 	"Once the limit is exceeded it is expected that the userspace
> 	 is going to act and either free up the swapped out space
> 	 or tune the limit based on needs. The kernel itself is not
> 	 able to do that on its own.
> 	"

I mean, in rare cases, maybe userspace can do some loadshedding and be
smart about it. But we certainly don't expect it to. Just like we
don't expect it to when memory.high starts injecting sleeps. We expect
the workload to die, usually.
