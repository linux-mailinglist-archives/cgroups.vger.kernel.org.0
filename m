Return-Path: <cgroups+bounces-4271-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE529524DF
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 23:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81D02B20ACB
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 21:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776FC1C7B6F;
	Wed, 14 Aug 2024 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VtnBZ7+2"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCA81B0125
	for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 21:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723671688; cv=none; b=KzqiOs7Z/DZUw3r0UEyP2lGBVFJjtFuQmO4MIISdhz970cr5qAHVmImKMcMv8UHsAj81eVmHhltOuR04hlPfXRFsFabsu+VtN6nraPeHlsMPP+pHXrAv1Rnsr2ufrIhqwYd/wgZ7cK+YZlVb3f1IqrBwWqN49pT/ij7lrNJ1/5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723671688; c=relaxed/simple;
	bh=MBo6i4B+ud6F72Xe3hryLxnM611i6puIHcpoluR7Nus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pg/bsGQOQ5C9e0FP6aql/unpdaqTI2Hl8Ac2ACwL5mne7V7tAEkSYxYXJ38Im+alrNydZ1qbODGXkz3VQ5h9EAio/bu4D0W/YVpGo5hyx1II51oUiZ8Dv+76VG6h0s5D1opLcHNE5KC5BUa92DTG3rpe2JQxNH/7+yhakng8jJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VtnBZ7+2; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 14 Aug 2024 14:41:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723671681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XkZH7xVDbhk7zC0mNzM98IJtjGbzpC00H/rbbebB8o8=;
	b=VtnBZ7+2ryBAY6leshpfKVYYOcVSdoAq8sDcEJZgqhk5SIjS3N1KTxoF/B7BlzLGMzcgP5
	cAS5xpwDMoSmtwlUXbcDI53hk1t1TQg8Gk0OA7bsUQxM3PcQT3EhZJwd/Yejk+rClxwbN3
	Q1Kv6Gsk8RCpql7Nf1nIO+9pZSzWsjE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH 3/4] memcg: initiate deprecation of oom_control
Message-ID: <vixhnru2gag4wav5m2qesoihlhuce75s662ccxcekdp3ba44kj@ml7tlkaefqsx>
References: <20240814202825.2694077-1-shakeel.butt@linux.dev>
 <20240814202825.2694077-4-shakeel.butt@linux.dev>
 <CABdmKX2HvW3qZ9zrTq0Gz6q0Gg7_XubVY22o3GJoTOhQg=V+8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdmKX2HvW3qZ9zrTq0Gz6q0Gg7_XubVY22o3GJoTOhQg=V+8Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 14, 2024 at 02:00:03PM GMT, T.J. Mercier wrote:
> On Wed, Aug 14, 2024 at 1:29 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > The oom_control provides functionality to disable memcg oom-killer,
> > notifications on oom-kill and reading the stats regarding oom-kills.
> > This interface was mainly introduced to provide functionality for
> > userspace oom-killers. However it is not robust enough and only supports
> > OOM handling in the page fault path.
> >
> > For v2, the users can use the combination of memory.events notifications
> > and memory.high interface to provide userspace OOM-killing functionality.
> > Let's start the deprecation process for v1 and gather the info on how
> > the current users are using this interface and work on providing a more
> > robust functionality in v2.
> >
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > ---
> >  Documentation/admin-guide/cgroup-v1/memory.rst | 8 ++++++--
> >  mm/memcontrol-v1.c                             | 7 +++++++
> >  2 files changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
> > index afe5e95e9f7b..74cea6712d06 100644
> > --- a/Documentation/admin-guide/cgroup-v1/memory.rst
> > +++ b/Documentation/admin-guide/cgroup-v1/memory.rst
> > @@ -92,6 +92,8 @@ Brief summary of control files.
> >                                       This knob is deprecated and shouldn't be
> >                                       used.
> >   memory.oom_control                 set/show oom controls.
> > +                                     This knob is deprecated and shouldn't be
> > +                                     used.
> >   memory.numa_stat                   show the number of memory usage per numa
> >                                      node
> >   memory.kmem.limit_in_bytes          Deprecated knob to set and read the kernel
> > @@ -846,8 +848,10 @@ It's applicable for root and non-root cgroup.
> >
> >  .. _cgroup-v1-memory-oom-control:
> >
> > -10. OOM Control
> > -===============
> > +10. OOM Control (DEPRECATED)
> > +============================
> > +
> > +THIS IS DEPRECATED!
> >
> >  memory.oom_control file is for OOM notification and other controls.
> >
> > diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> > index e0bb54e42011..07343e338e4e 100644
> > --- a/mm/memcontrol-v1.c
> > +++ b/mm/memcontrol-v1.c
> > @@ -1907,6 +1907,9 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
> >                 event->register_event = mem_cgroup_usage_register_event;
> >                 event->unregister_event = mem_cgroup_usage_unregister_event;
> >         } else if (!strcmp(name, "memory.oom_control")) {
> > +               pr_warn_once("oom_control is deprecated and will be removed. "
> > +                            "Please report your usecase to linux-mm-@kvack.org"
> > +                            " if you depend on this functionality. \n";
> 
> Missing close paren?

Ah, thanks for catching that. I compile tested the old version before
moving text around. Anyways, will resend.

> 
> >                 event->register_event = mem_cgroup_oom_register_event;
> >                 event->unregister_event = mem_cgroup_oom_unregister_event;
> >         } else if (!strcmp(name, "memory.pressure_level")) {
> > @@ -2754,6 +2757,10 @@ static int mem_cgroup_oom_control_write(struct cgroup_subsys_state *css,
> >  {
> >         struct mem_cgroup *memcg = mem_cgroup_from_css(css);
> >
> > +       pr_warn_once("oom_control is deprecated and will be removed. "
> > +                    "Please report your usecase to linux-mm-@kvack.org if you "
> > +                    "depend on this functionality. \n";
> > +
> 
> Missing close paren?
> 
> >         /* cannot set to root cgroup and only 0 and 1 are allowed */
> >         if (mem_cgroup_is_root(memcg) || !((val == 0) || (val == 1)))
> >                 return -EINVAL;
> > --
> > 2.43.5
> >
> >

