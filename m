Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 937FD15BF29
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2020 14:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbgBMNXV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Feb 2020 08:23:21 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39366 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729772AbgBMNXU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Feb 2020 08:23:20 -0500
Received: by mail-qt1-f196.google.com with SMTP id c5so4319644qtj.6
        for <cgroups@vger.kernel.org>; Thu, 13 Feb 2020 05:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HF11zg8VhmODSLvrm5fXTfTQXLWL6ILILD4NNstRYp8=;
        b=fd7eAB7reY05ia7xvwEb3tqhBP6ogKTnBo5phcgaV2UtplZOXERpcbUYR/6vM7jeOC
         6lk3a49mmWTp3IeaCfGyZNAN7Vc0yOfAJnEOK1avYkFQY7V+wq4hhICL2J0rNk7HnMUX
         AWxb1+/CI0/6y5w84TynH62CppBwHffHp7fF5SAreV9cJ9ChsRoGpviJSrRPy/aqTunU
         UnOe0GJo/8zYkP1GN2HDaqxXzokFrGpzuG2PWtRRbfmlScULYiONwe5IYMU4QylziFJ3
         kPMzsSZ/DLE1A19alQgRaH3HzZ5vWU1/3/Sxbatb8S3cBqaxkuI2aDKvvlMsZxwllpdP
         CYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HF11zg8VhmODSLvrm5fXTfTQXLWL6ILILD4NNstRYp8=;
        b=r+d83d4EcEaSDA9eVcjXB0Fo0+yR4kvcKVx7X/iAfxki+hEQ56qr32pRiDF/yYDkT2
         TwOy8Bc7gIwsBnhigrTb5zeU7hxHVJfT873kIS9QbT4BXe7Jq2ERCitHkM2Q2HIR0prJ
         wDV85CD20gTIjo+Zg7BfP1j1Wiyz0foBVUvcltTYryxxvLM2k06LDQrsGP/n+gzh/N9W
         //DdSZ/fEYteonATGIE2uQ9T9Lyzi62c1RIFIAimr4YiiKgQV1pTMiSDIAnUcALf1e03
         /NSU/2Vn/XHuNFzKAjowUT3pTR1zbeP6PxC19D0pzh+soSdS5sCwZ/Li961q5wCbbB1F
         3U0Q==
X-Gm-Message-State: APjAAAWXZdAF4FyyJJAJtI2XMkd6xCzHdRdrVvVKHQUQDuhNkQ7l4wjd
        VajwHioiSoizUWZ7/veqhFmJjQ==
X-Google-Smtp-Source: APXvYqztyM9wu0eJZLn4MfZpIlFLjoe12bBDZu5ErSW2KL2UGAaNfQkgeAR+W+nz2rlAliJ1unsqXQ==
X-Received: by 2002:ac8:130c:: with SMTP id e12mr11576944qtj.233.1581600199440;
        Thu, 13 Feb 2020 05:23:19 -0800 (PST)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id b12sm1320245qkl.0.2020.02.13.05.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 05:23:18 -0800 (PST)
Date:   Thu, 13 Feb 2020 08:23:17 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] mm: memcontrol: recursive memory.low protection
Message-ID: <20200213132317.GA208501@cmpxchg.org>
References: <20191219200718.15696-1-hannes@cmpxchg.org>
 <20191219200718.15696-4-hannes@cmpxchg.org>
 <20200130170020.GZ24244@dhcp22.suse.cz>
 <20200203215201.GD6380@cmpxchg.org>
 <20200211164753.GQ10636@dhcp22.suse.cz>
 <20200212170826.GC180867@cmpxchg.org>
 <20200213074049.GA31689@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213074049.GA31689@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 13, 2020 at 08:40:49AM +0100, Michal Hocko wrote:
> On Wed 12-02-20 12:08:26, Johannes Weiner wrote:
> > On Tue, Feb 11, 2020 at 05:47:53PM +0100, Michal Hocko wrote:
> > > Unless I am missing something then I am afraid it doesn't. Say you have a
> > > default systemd cgroup deployment (aka deeper cgroup hierarchy with
> > > slices and scopes) and now you want to grant a reclaim protection on a
> > > leaf cgroup (or even a whole slice that is not really important). All the
> > > hierarchy up the tree has the protection set to 0 by default, right? You
> > > simply cannot get that protection. You would need to configure the
> > > protection up the hierarchy and that is really cumbersome.
> > 
> > Okay, I think I know what you mean. Let's say you have a tree like
> > this:
> > 
> >                           A
> >                          / \
> >                         B1  B2
> >                        / \   \
> >                       C1 C2   C3
> > 
> > and there is no actual delegation point - everything belongs to the
> > same user / trust domain. C1 sets memory.low to 10G, but its parents
> > set nothing. You're saying we should honor the 10G protection during
> > global and limit reclaims anywhere in the tree?
> 
> No, only in the C1 which sets the limit, because that is the woriking
> set we want to protect.
> 
> > Now let's consider there is a delegation point at B1: we set up and
> > trust B1, but not its children. What effect would the C1 protection
> > have then? Would we ignore it during global and A reclaim, but honor
> > it when there is B1 limit reclaim?
> 
> In the scheme with the inherited protection it would act as the gate
> and require an explicit low limit setup defaulting to 0 if none is
> specified.
> 
> > Doing an explicit downward propagation from the root to C1 *could* be
> > tedious, but I can't think of a scenario where it's completely
> > impossible. Especially because we allow proportional distribution when
> > the limit is overcommitted and you don't have to be 100% accurate.
> 
> So let's see how that works in practice, say a multi workload setup
> with a complex/deep cgroup hierachies (e.g. your above example). No
> delegation point this time.
> 
> C1 asks for low=1G while using 500M, C3 low=100M using 80M.  B1 and
> B2 are completely independent workloads and the same applies to C2 which
> doesn't ask for any protection at all? C2 uses 100M. Now the admin has
> to propagate protection upwards so B1 low=1G, B2 low=100M and A low=1G,
> right? Let's say we have a global reclaim due to external pressure that
> originates from outside of A hierarchy (it is not overcommited on the
> protection).
> 
> Unless I miss something C2 would get a protection even though nobody
> asked for it.

Good observation, but I think you spotted an unintentional side effect
of how I implemented the "floating protection" calculation rather than
a design problem.

My patch still allows explicit downward propagation. So if B1 sets up
1G, and C1 explicitly claims those 1G (low>=1G, usage>=1G), C2 does
NOT get any protection. There is no "floating" protection left in B1
that could get to C2.

However, to calculate the float, I'm using the utilized protection
counters (children_low_usage) to determine what is "claimed". Mostly
for convenience because they were already there. In your example, C1
is only utilizing 500M of its protection, leaving 500M in the float
that will go toward C2. I agree that's undesirable.

But it's fixable by adding a hierarchical children_low counter that
tracks the static configuration, and using that to calculate floating
protection instead of the dynamic children_low_usage.

That way you can propagate protection from A to C1 without it spilling
to anybody else unintentionally, regardless of how much B1 and C1 are
actually *using*.

Does that sound reasonable?
