Return-Path: <cgroups+bounces-6792-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFA3A4CC17
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 20:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7073173695
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 19:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8544233D8D;
	Mon,  3 Mar 2025 19:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W6dry1Rf"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A226E232367
	for <cgroups@vger.kernel.org>; Mon,  3 Mar 2025 19:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741030753; cv=none; b=jxN0/aLq3kFGsoki45ok6PsqrUh1g3M4QCbKXbJnhzxxcKF39gNBmUG9Cgh4qvcw8YJroMOePYYLcM4toNLc9S6cZlrZgYaR8No2E3Clu8qeeVNt1c/WoCdBA34Y9HDZH66E7zK4gkdEuGp0vDtewVD0YRJrFZeNoTVcHGIWEDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741030753; c=relaxed/simple;
	bh=4GIs36PF/V89OSl72bXcTe6gizc9xW3WHyv4qmBNzbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlEja7gCXTjzP/q0SL13PTpQPx0LEkfcMIbmMTYj/DsaqPZsWptqZtyNo63mogAfgrIjkp8pn4lehKIMFMWF+2N+PkQEX5jw5anySUfgqJgIBvCYMp4QJOCzc1yJKNgXrDkdhn6j6fzItIQ9Qam7KCeX4/4vzmFpU1Yq0YTwJFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W6dry1Rf; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 3 Mar 2025 11:39:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741030749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9/V50uOri+cvgAKtCo8ESnh6ojnA6ZO0bR1zyNyugFE=;
	b=W6dry1RfZWU+AZeUuHEdTAMl//VqzYFar/1KzMgD9PreBcNVkSFTlTsi4vw2vw3NC6n38g
	re53uxq0h9k+H6O093OdgjmxggO2aMFv2zktRJDZMhIqaYs/7x21+65XJcB3MZg9SE+KNS
	d0y8XTntUErI3TdU8GHmAYOmkQXLoVs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, tj@kernel.org, mhocko@kernel.org, hannes@cmpxchg.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH 3/4 v2] cgroup: separate rstat locks for subsystems
Message-ID: <bbxmxyiexzb462ogltxwbhnp2bxif22lgwicr4ddubpabmut2h@5zhqhgse4iz6>
References: <20250227215543.49928-1-inwardvessel@gmail.com>
 <20250227215543.49928-4-inwardvessel@gmail.com>
 <n4pe2mks7idmyd5rg6o3d6ay75f3pf4bkwv4hcwkpa2jsryk6v@5d5r3wdiddil>
 <Z8X1IfzdjbKEg5OM@google.com>
 <jnxu6dot3od74pu57mhnx7sssf36tx462n5obx53wmvtuaxlcq@b4dqcpnenoyv>
 <f59a7b94-d2eb-42bc-a4a1-2aa6e35bedc6@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f59a7b94-d2eb-42bc-a4a1-2aa6e35bedc6@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 03, 2025 at 11:23:49AM -0800, JP Kobryn wrote:
> 
> 
> On 3/3/25 10:40 AM, Shakeel Butt wrote:
> > On Mon, Mar 03, 2025 at 06:29:53PM +0000, Yosry Ahmed wrote:
> > > On Mon, Mar 03, 2025 at 04:22:42PM +0100, Michal Koutný wrote:
> > > > On Thu, Feb 27, 2025 at 01:55:42PM -0800, inwardvessel <inwardvessel@gmail.com> wrote:
> > > > > From: JP Kobryn <inwardvessel@gmail.com>
> > > > ...
> > > > > +static inline bool is_base_css(struct cgroup_subsys_state *css)
> > > > > +{
> > > > > +	return css->ss == NULL;
> > > > > +}
> > > > 
> > > > Similar predicate is also used in cgroup.c (various cgroup vs subsys
> > > > lifecycle functions, e.g. css_free_rwork_fn()). I think it'd better
> > > > unified, i.e. open code the predicate here or use the helper in both
> > > > cases (css_is_cgroup() or similar).
> > > > 
> > > > >   void __init cgroup_rstat_boot(void)
> > > > >   {
> > > > > -	int cpu;
> > > > > +	struct cgroup_subsys *ss;
> > > > > +	int cpu, ssid;
> > > > > -	for_each_possible_cpu(cpu)
> > > > > -		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu));
> > > > > +	for_each_subsys(ss, ssid) {
> > > > > +		spin_lock_init(&cgroup_rstat_subsys_lock[ssid]);
> > > > > +	}
> > > > 
> > > > Hm, with this loop I realize it may be worth putting this lock into
> > > > struct cgroup_subsys_state and initializing them in
> > > > cgroup_init_subsys() to keep all per-subsys data in one pack.
> > > 
> > > I thought about this, but this would have unnecessary memory overhead as
> > > we only need one lock per-subsystem. So having a lock in every single
> > > css is wasteful.
> > > 
> > > Maybe we can put the lock in struct cgroup_subsys? Then we can still
> > > initialize them in cgroup_init_subsys().
> > > 
> > 
> > Actually one of things I was thinking about if we can just not have
> > per-subsystem lock at all. At the moment, it is protecting
> > rstat_flush_next field (today in cgroup and JP's series it is in css).
> > What if we make it a per-cpu then we don't need the per-subsystem lock
> > all? Let me know if I missed something which is being protected by this
> > lock.
> > 
> > This is help the case where there are multiple same subsystem stat
> > flushers, possibly of differnt part of cgroup tree. Though they will
> > still compete on per-cpu lock but still would be better than a
> > sub-system level lock.
> 
> Right, the trade-off would mean one subsystem flushing could contend for
> a cpu where a different subsystem is updating and vice versa.
> 

I meant we keep the per-subsystem per-cpu locks but remove the
per-subsystem lock (i.e. cgroup_rstat_subsys_lock) if we make
rstat_flush_next per-cpu. In that case two memory stats readers will not
compete on memory subsystem lock but they will compete on per-cpu memory
locks. Though we will have to experiment to see if this really helps or
not.

