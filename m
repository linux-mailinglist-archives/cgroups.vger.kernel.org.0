Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F181B78CC
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2020 17:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgDXPFP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Apr 2020 11:05:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35118 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbgDXPFP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Apr 2020 11:05:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id r26so11186829wmh.0
        for <cgroups@vger.kernel.org>; Fri, 24 Apr 2020 08:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tUTBy5fIsPSGLAED3RD1/QdnNbiATC1koGDZtuwuw2Y=;
        b=dQ5NRBYO9IXTzVKHNpxPjt9ESX/PindEQG2nqmvVJcx2a0F8QWVsNGD5Kq8Cli7r2/
         nAOIcqVQt9fckm8W6bAxyzWRy1NS9hBxyiPcOMv2KEHCuI/diM5KjA8dHzb8Eaq5eZ9g
         E08vScXMF4TE2oTMScs4cnFXCeNdBXMP8hS2F37B4kIMuGtRpwkX3v+LWGAloWccPP+J
         zfLKKB9kZnQra9FmlDQGrcdgvKHFXV2qZP0RYmoZ0mJH7Rebwu8Rvni08KUIioQt6uQa
         ReVANLXP99cdSjk+UCLCqSoRjJjTH+kxb/zu0nup2rPA01WL6twcEqOQr4mrHRXaCjPy
         JTCQ==
X-Gm-Message-State: AGi0PubTAWzT8nayBEAS5g9rRwempa3UQ4Jxv/SKtJPG8raPxtiZbxO9
        0NoWBkACs9uTunTOY8UWXRc=
X-Google-Smtp-Source: APiQypLd173SepUHXL+0Qssr/SFU89okKZBmXtTcwCPORUe219b0PTqPw4HqcZ1hqqXlkwizgxCVPw==
X-Received: by 2002:a1c:3c54:: with SMTP id j81mr10325686wma.140.1587740712998;
        Fri, 24 Apr 2020 08:05:12 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id j11sm8656172wrr.62.2020.04.24.08.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 08:05:11 -0700 (PDT)
Date:   Fri, 24 Apr 2020 17:05:10 +0200
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
Message-ID: <20200424150510.GH11591@dhcp22.suse.cz>
References: <20200421110612.GD27314@dhcp22.suse.cz>
 <20200421142746.GA341682@cmpxchg.org>
 <20200421161138.GL27314@dhcp22.suse.cz>
 <20200421165601.GA345998@cmpxchg.org>
 <20200422132632.GG30312@dhcp22.suse.cz>
 <20200422141514.GA362484@cmpxchg.org>
 <20200422154318.GK30312@dhcp22.suse.cz>
 <20200422171328.GC362484@cmpxchg.org>
 <20200422184921.GB4206@dhcp22.suse.cz>
 <20200423150015.GE362484@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423150015.GE362484@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 23-04-20 11:00:15, Johannes Weiner wrote:
> On Wed, Apr 22, 2020 at 08:49:21PM +0200, Michal Hocko wrote:
> > On Wed 22-04-20 13:13:28, Johannes Weiner wrote:
> > > On Wed, Apr 22, 2020 at 05:43:18PM +0200, Michal Hocko wrote:
> > > > On Wed 22-04-20 10:15:14, Johannes Weiner wrote:
> > > > I am also missing some information about what the user can actually do
> > > > about this situation and call out explicitly that the throttling is
> > > > not going away until the swap usage is shrunk and the kernel is not
> > > > capable of doing that on its own without a help from the userspace. This
> > > > is really different from memory.high which has means to deal with the
> > > > excess and shrink it down in most cases. The following would clarify it
> > > 
> > > I think we may be talking past each other. The user can do the same
> > > thing as in any OOM situation: wait for the kill.
> > 
> > That assumes that reaching swap.high is going to converge to the OOM
> > eventually. And that is far from the general case. There might be a
> > lot of other reclaimable memory to reclaim and stay in the current
> > state.
> 
> No, that's really the general case. And that's based on what users
> widely experience, including us at FB. When swap is full, it's over.
> Multiple parties have independently reached this conclusion.

But we are talking about two things. You seem to be focusing on the full
swap (quota) while I am talking about swap.high which doesn't imply
that the quota/full swap is going to be reached soon.

[...]

> The assymetry you see between memory.high and swap.high comes from the
> page cache. memory.high can set a stop to the mindless expansion of
> the file cache and remove *unused* cache pages from the application's
> workingset. It cannot permanently remove used cache pages, they'll
> just refault. So unused cache is where reclaim is useful.

Exactly! And I have seen memory.high being used to throttle huge page
cache producers to not disrupt other workloads.
 
> Once the workload expands its set of *used* pages past memory.high, we
> are talking about indefinite slowdowns / OOM situations. Because at
> that point, reclaim cannot push the workload back and everything will
> be okay: the pages it takes off mean refaults and continued reclaim,
> i.e. throttling. You get slowed down either way, and whether you
> reclaim or sleep() is - to the workload - an accounting difference.
>
> Reclaim does NOT have the power to help the workload get better. It
> can only do amputations to protect the rest of the system, but it
> cannot reduce the number of pages the workload is trying to access.

Yes I do agree with you here and I believe this scenario wasn't really
what the dispute is about. As soon as the real working set doesn't
fit into the high limit and still growing then you are effectively
OOM and either you do handle that from the userspace or you have to
waaaaaaaaait for the kernel oom killer to trigger.

But I believe this scenario is much easier to understand because the
memory consumption is growing. What I find largely unintuitive from the
user POV is that the throttling will remain in place without a userspace
intervention even when there is no runaway.

Let me give you an example. Say you have a peak load which pushes
out a large part of an idle memory to swap. So much it fills up the
swap.high. The peak eventually finishes freeing up its resources.  The
swap situation remains the same because that memory is not refaulted and
we do not pro-actively swap in memory (aka reclaim the swap space). You
are left with throttling even though the overall memcg consumption is
really low. Kernel is currently not able to do anything about that
and the userspace would need to be aware of the situation to fault in
swapped out memory back to get a normal behavior. Do you think this
is something so obvious that people would keep it in mind when using
swap.high?

Anyway, it seems that we are not making progress here. As I've said I
believe that swap.high might lead to a surprising behavior and therefore
I would appreciate more clarity in the documentation. If you see a
problem with that for some reason then I can live with that. This is not
a reason to nack.
-- 
Michal Hocko
SUSE Labs
