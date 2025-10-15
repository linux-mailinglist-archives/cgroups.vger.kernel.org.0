Return-Path: <cgroups+bounces-10785-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 805CFBE034B
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 20:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84E074FEFA3
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 18:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBAA248F78;
	Wed, 15 Oct 2025 18:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s9kHS2f+"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7003254AF
	for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 18:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553375; cv=none; b=ljkKwzE4ktW3CR1qv70bZXYOIO3Bf/r7RiUBNSE+W8Tlc/yg6CRoaO0dwBDrQycHeAq36cNnWqrEaUorvn6jnWtG77LsJjmH5KzxNPXWNnypc34soo4gnz/tHo5iiPUA2m1clQ9t6R8pWj8tGGVgkuvq7h/wETIYGsAbtIlWjhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553375; c=relaxed/simple;
	bh=NrHrgqd4V2MMqihEmUJ2sF6Rk1LRK2acLFpeHzQKZaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnYisf+LRxyK0KJqOm22p3VQFS50rSeU22hh9KUHCQu27yGCbJkDrHJpVXCmYLChczo1rOkEnp8XHc+OoKgmdYJmZRal92DlxhBv70ALvZV7suhzdRjW7lY/8MW9CAB8HTGiBnlKTwDWmjDFpZjeAfEp/ZuUCzovYu/33ziAC+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s9kHS2f+; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 15 Oct 2025 11:36:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760553370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uk3MP3pS+gPT2tihmTeblANXv366efmN7AcXHGrPOtY=;
	b=s9kHS2f+k/PNc+fE4JKbXrv3jOMar+OiymkJ5MXwoiaCapJXLGkeyEkkVJC2qcVNdc9X/e
	oWrjUpyMZBSmuB1pO/8/WU8bpR6pkPv/vC+rZN3IwGTnLNPYOC7kfe3MPAEmnf41RqwBP1
	FQ66pVe3ZLXCkQkcegJFiri8n2RBS98=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Daniel Sedlak <daniel.sedlak@cdn77.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, 
	netdev@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Matyas Hurtik <matyas.hurtik@cdn77.com>
Subject: Re: [PATCH v5] memcg: expose socket memory pressure in a cgroup
Message-ID: <xfvvlbicyui22lhwptmdxtjfmcyei3m2bhhie7l2vjw4xa23cf@lhuh5q7vhwt4>
References: <87qzvdqkyh.fsf@linux.dev>
 <13b5aeb6-ee0a-4b5b-a33a-e1d1d6f7f60e@cdn77.com>
 <87o6qgnl9w.fsf@linux.dev>
 <tr7hsmxqqwpwconofyr2a6czorimltte5zp34sp6tasept3t4j@ij7acnr6dpjp>
 <87a5205544.fsf@linux.dev>
 <qdblzbalf3xqohvw2az3iogevzvgn3c3k64nsmyv2hsxyhw7r4@oo7yrgsume2h>
 <875xcn526v.fsf@linux.dev>
 <89618dcb-7fe3-4f15-931b-17929287c323@cdn77.com>
 <6ras4hgv32qkkbh6e6btnnwfh2xnpmoftanw4xlbfrekhskpkk@frz4uyuh64eq>
 <5e603850-2cfc-4eb6-a5cc-da5282525b0d@cdn77.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e603850-2cfc-4eb6-a5cc-da5282525b0d@cdn77.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 15, 2025 at 03:57:29PM +0200, Daniel Sedlak wrote:
> On 10/14/25 10:32 PM, Shakeel Butt wrote:
> > On Mon, Oct 13, 2025 at 04:30:53PM +0200, Daniel Sedlak wrote:
> > [...]
> > > > > > > How about we track the actions taken by the callers of
> > > > > > > mem_cgroup_sk_under_memory_pressure()? Basically if network stack
> > > > > > > reduces the buffer size or whatever the other actions it may take when
> > > > > > > mem_cgroup_sk_under_memory_pressure() returns, tracking those actions
> > > > > > > is what I think is needed here, at least for the debugging use-case.
> > > 
> > > I am not against it, but I feel that conveying those tracked actions (or how
> > > to represent them) to the user will be much harder. Are there already
> > > existing APIs to push this information to the user?
> > > 
> > 
> > I discussed with Wei Wang and she suggested we should start tracking the
> > calls to tcp_adjust_rcv_ssthresh() first. So, something like the
> > following. I would like feedback frm networking folks as well:
> 
> Looks like a good start. Are you planning on sending this patch separately,
> or can we include it in our v6 (with maybe slight modifications)?

What else you are planning to add in v6?

> > 
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 873e510d6f8d..5fe254813123 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -52,6 +52,7 @@ enum memcg_memory_event {
> >   	MEMCG_SWAP_HIGH,
> >   	MEMCG_SWAP_MAX,
> >   	MEMCG_SWAP_FAIL,
> > +	MEMCG_SOCK_THROTTLED,
> 
> This probably should be MEMCG_TCP_SOCK_THROTTLED, because it checks only
> tcp_under_memory_pressure, however there is also the
> sk_under_memory_pressure used in net/sctp/sm_statefuns.c:6597 to also reduce
> the sending rate. Or also add the counter there and keep the name?

Yeah makes sense to add the counter in sctp as well.

