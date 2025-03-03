Return-Path: <cgroups+bounces-6788-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5863A4CB1A
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 19:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398253AA171
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 18:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0A921638E;
	Mon,  3 Mar 2025 18:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XtsQeyZB"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF8920F09D
	for <cgroups@vger.kernel.org>; Mon,  3 Mar 2025 18:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027254; cv=none; b=XIjXJjZ0+UtV9ssZTfk81X7sgurpd1vtMgY26yVmsUbMw0aVKdvhzkE8bNq1RHyefqNfrw0t36zatQro3C/Ey53ByDNJGUegPK+QAm2J/S/CQDX4rysv0zkgHAVEeUTtM5ZaduZRtRA/80sUnr+pdivG9z5TKzSPEagwI0CS34E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027254; c=relaxed/simple;
	bh=oSuKABHOREdfTEVIRk9uzSXwukCyIg/ASAKFL6/ZgQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9ViBm0BBlqW884zY8QjjgDRPwrjrYawJmIvGYC2twRa8FGoxqXUgedk4jkISMDluQLotR5541ujprlHvGPaY362KxlexwCM/Y1VwwkbAOP6L24rxt+tuyDVQYTH79dPoYmqAHmxpAk3FEeN/0utIDVCJqCSqY80FMbwvnpvA0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XtsQeyZB; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 3 Mar 2025 10:40:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741027249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EM3cfj2D+hRqRRZcQ0TuiGHZsS+SJp4y47psfwmgNS8=;
	b=XtsQeyZB2JhTw01TKG4uxDOC4o8cZDRMjt8CVkDrHHhz4jFsHWCh0300lUQEkIcEClbSkI
	fXTwYKOyR/nnwBZyjcNKQjjpqlfyadoKdvcceb5ADurR9+kJKZAWNMUn/i3zSreElmHCmN
	yXwoPdB6h6jMXiiAcGb9yusdsviQnCc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	inwardvessel <inwardvessel@gmail.com>, tj@kernel.org, mhocko@kernel.org, hannes@cmpxchg.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH 3/4 v2] cgroup: separate rstat locks for subsystems
Message-ID: <jnxu6dot3od74pu57mhnx7sssf36tx462n5obx53wmvtuaxlcq@b4dqcpnenoyv>
References: <20250227215543.49928-1-inwardvessel@gmail.com>
 <20250227215543.49928-4-inwardvessel@gmail.com>
 <n4pe2mks7idmyd5rg6o3d6ay75f3pf4bkwv4hcwkpa2jsryk6v@5d5r3wdiddil>
 <Z8X1IfzdjbKEg5OM@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8X1IfzdjbKEg5OM@google.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 03, 2025 at 06:29:53PM +0000, Yosry Ahmed wrote:
> On Mon, Mar 03, 2025 at 04:22:42PM +0100, Michal Koutný wrote:
> > On Thu, Feb 27, 2025 at 01:55:42PM -0800, inwardvessel <inwardvessel@gmail.com> wrote:
> > > From: JP Kobryn <inwardvessel@gmail.com>
> > ...
> > > +static inline bool is_base_css(struct cgroup_subsys_state *css)
> > > +{
> > > +	return css->ss == NULL;
> > > +}
> > 
> > Similar predicate is also used in cgroup.c (various cgroup vs subsys
> > lifecycle functions, e.g. css_free_rwork_fn()). I think it'd better
> > unified, i.e. open code the predicate here or use the helper in both
> > cases (css_is_cgroup() or similar).
> > 
> > >  void __init cgroup_rstat_boot(void)
> > >  {
> > > -	int cpu;
> > > +	struct cgroup_subsys *ss;
> > > +	int cpu, ssid;
> > >  
> > > -	for_each_possible_cpu(cpu)
> > > -		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu));
> > > +	for_each_subsys(ss, ssid) {
> > > +		spin_lock_init(&cgroup_rstat_subsys_lock[ssid]);
> > > +	}
> > 
> > Hm, with this loop I realize it may be worth putting this lock into
> > struct cgroup_subsys_state and initializing them in
> > cgroup_init_subsys() to keep all per-subsys data in one pack.
> 
> I thought about this, but this would have unnecessary memory overhead as
> we only need one lock per-subsystem. So having a lock in every single
> css is wasteful.
> 
> Maybe we can put the lock in struct cgroup_subsys? Then we can still
> initialize them in cgroup_init_subsys().
> 

Actually one of things I was thinking about if we can just not have
per-subsystem lock at all. At the moment, it is protecting
rstat_flush_next field (today in cgroup and JP's series it is in css).
What if we make it a per-cpu then we don't need the per-subsystem lock
all? Let me know if I missed something which is being protected by this
lock.

This is help the case where there are multiple same subsystem stat
flushers, possibly of differnt part of cgroup tree. Though they will
still compete on per-cpu lock but still would be better than a
sub-system level lock.

