Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9C421630A5
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2020 20:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgBRTw4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 Feb 2020 14:52:56 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46672 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgBRTw4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 Feb 2020 14:52:56 -0500
Received: by mail-qk1-f195.google.com with SMTP id u124so20242794qkh.13
        for <cgroups@vger.kernel.org>; Tue, 18 Feb 2020 11:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IIIglP3lrK/bbp+/obNoUshm2KDGr/A+JSgxj0zWQRM=;
        b=ELdiNAZK1VKWaWwrqcP20fOHQWrj6DQbxwmx7w0WY0RLNf/+TiQXVgXp1SSUSKJ7Dc
         kX1M4c0YRCIaN75Ek1yR4KFIY5VdTQfcF9se/BPJhGkT2OPjhWSJQKJhsiCcsh6Eki4s
         3+SBBD6Kj8S+CT9mZAZRvesFECSrv9uyfF51ktO6kaaXsF9bJblm+VGhyV+zzhmts4tc
         k+x6QSZV8M/4Qtwim/E8ujQMPG7bhKOnWnqe0puPTTsYp9q8UBjZXBJH1BEizh9M8L65
         s4DOQB6B2yOIslgio1SC9jx+Hm1muU3oRTPIHTJ4epmQ2XW+bjJA9IgL8jWoqqohTn1R
         Jhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IIIglP3lrK/bbp+/obNoUshm2KDGr/A+JSgxj0zWQRM=;
        b=s/LiscgaW0d3+gtTB0JMTyd7aIqyhGMg4dALt4OUXyOFrURXJtb/n7hd/TLfhqUorn
         UIBNGgbNOCMDBvLO8VmIhGFilQye0xQbGAENyOoQ8GlAJmHphxIYFgtoTjraQWM842ly
         3VnetVHv4YzcXrZBpFnBmY0dEeyDy2GzXeqoUCsqux7nbXYeIJ6YvBmpSeBlxeigXNvz
         BGsXQDAFaqvpZw+/pdoUp8UIoQRlwFoqnG8BL65jgzxD0xZOoxRpE/ENs+l3ovmGRH6t
         w8b0jHsedesRSNsvlYnQn46gx8mY+gFKOHKupsv1kxpbLr/qCOjAA+X58NvpPRFMA6Y6
         7GzQ==
X-Gm-Message-State: APjAAAVeTjmpYZ5ISF+4qclzwwo+7WuTCzgQl16+BYc2++S48Dll+vor
        /cK/sZyaQnv2hp5c2WgInJDbfA==
X-Google-Smtp-Source: APXvYqyZnf5b/A44XYNB6cKskTQewARfA8b8mZ8AF5A/ycBVB3ulEFtPoltvEGgKlX1y1eqfDAPolA==
X-Received: by 2002:a05:620a:1586:: with SMTP id d6mr20897459qkk.234.1582055575085;
        Tue, 18 Feb 2020 11:52:55 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:9742])
        by smtp.gmail.com with ESMTPSA id p50sm2426635qtf.5.2020.02.18.11.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 11:52:54 -0800 (PST)
Date:   Tue, 18 Feb 2020 14:52:53 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] mm: memcontrol: recursive memory.low protection
Message-ID: <20200218195253.GA13406@cmpxchg.org>
References: <20200213135348.GF88887@mtj.thefacebook.com>
 <20200213154731.GE31689@dhcp22.suse.cz>
 <20200213155249.GI88887@mtj.thefacebook.com>
 <20200213163636.GH31689@dhcp22.suse.cz>
 <20200213165711.GJ88887@mtj.thefacebook.com>
 <20200214071537.GL31689@dhcp22.suse.cz>
 <20200214135728.GK88887@mtj.thefacebook.com>
 <20200214151318.GC31689@dhcp22.suse.cz>
 <20200214165311.GA253674@cmpxchg.org>
 <20200217084100.GE31531@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217084100.GE31531@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Feb 17, 2020 at 09:41:00AM +0100, Michal Hocko wrote:
> On Fri 14-02-20 11:53:11, Johannes Weiner wrote:
> [...]
> > The proper solution to implement the kind of resource hierarchy you
> > want to express in cgroup2 is to reflect it in the cgroup tree. Yes,
> > the_workload might have been started by user 100 in session c2, but in
> > terms of resources, it's prioritized over system.slice and user.slice,
> > and so that's the level where it needs to sit:
> > 
> >                                root
> >                        /        |                 \
> >                system.slice  user.slice       the_workload
> >                /    |           |
> >            cron  journal     user-100.slice
> >                                 |
> >                              session-c2.scope
> >                                 |
> >                              misc
> > 
> > Then you can configure not just memory.low, but also a proper io
> > weight and a cpu weight. And the tree correctly reflects where the
> > workload is in the pecking order of who gets access to resources.
> 
> I have already mentioned that this would be the only solution when the
> protection would work, right. But I am also saying that this a trivial
> example where you simply _can_ move your workload to the 1st level. What
> about those that need to reflect organization into the hierarchy. Please
> have a look at http://lkml.kernel.org/r/20200214075916.GM31689@dhcp22.suse.cz
> Are you saying they are just not supported? Are they supposed to use
> cgroup v1 for the organization and v2 for the resource control?

From that email:

    > Let me give you an example. Say you have a DB workload which is the
    > primary thing running on your system and which you want to protect from
    > an unrelated activity (backups, frontends, etc). Running it inside a
    > cgroup with memory.low while other components in other cgroups without
    > any protection achieves that. If those cgroups are top level then this
    > is simple and straightforward configuration.
    > 
    > Things would get much more tricky if you want run the same workload
    > deeper down the hierarchy - e.g. run it in a container. Now your
    > "root" has to use an explicit low protection as well and all other
    > potential cgroups that are in the same sub-hierarchy (read in the same
    > container) need to opt-out from the protection because they are not
    > meant to be protected.

You can't prioritize some parts of a cgroup higher than the outside of
the cgroup, and other parts lower than the outside. That's just not
something that can be sanely supported from the controller interface.

However, that doesn't mean this usecase isn't supported. You *can*
always split cgroups for separate resource policies.

And you *can* split cgroups for group labeling purposes too (tracking
stuff that belongs to a certain user).

So in the scenario where you have an important database and a
not-so-important secondary workload, and you want them to run them
containerized, there are two possible scenarios:

- The workloads are co-dependent (e.g. a logging service for the
  db). In that case you actually need to protect them equally,
  otherwise you'll have priority inversions, where the primary gets
  backed up behind the secondary in some form or another.

- The workloads don't interact with each other. In that case, you can
  create two separate containers, one high-pri, one low-pri, and run
  them in parallel. They can share filesystem data, page cache
  etc. where appropriate, so this isn't a problem.

  The fact that they belong to the same team/organization/"user"
  e.g. is an attribute that can be tracked from userspace and isn't
  material from a kernel interface POV.

  You just have two cgroups instead of one to track; but those cgroups
  will still contain stuff like setsid(), setuid() etc. so users
  cannot escape whatever policy/containment you implement for them.

    > In short we simply have to live with usecases where the cgroup hierarchy
    > follows the "logical" workload organization at the higher level more
    > than resource control. This is the case for systemd as well btw.
    > Workloads are organized into slices and scopes without any direct
    > relation to resources in mind.

As I said in the previous email: Yes, per default, because it starts
everything in a single resource domain. But it has all necessary
support for dividing the tree into disjunct resource domains.

    > Does this make it more clear what I am thinking about? Does it sound
    > like a legit usecase?

The desired behavior is legit, but you have to split the cgroups on
conflicting attributes - whether organizational or policy-related -
for properly expressing what you want from the kernel.
