Return-Path: <cgroups+bounces-9146-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 141C3B254BF
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 22:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C79AA4E34BE
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 20:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329502E36E8;
	Wed, 13 Aug 2025 20:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PoBWnEIx"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CB12FD7BF
	for <cgroups@vger.kernel.org>; Wed, 13 Aug 2025 20:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755118461; cv=none; b=ZucgzQd8BtqLGY1N3+SvzEkCkUppYGrbiYcmRH5/7NEgHjQNVkbezWQ2/h4RpYnI9DfcWpRDfKE6g6bw+TYKKZFW+fGFD0AKZ7QPXOmtKr7mf0SxVmxyo71PlopQfRoovlf3EXetP0vjVlNltk6ipzxzN1yC3h2E2r0AtWhNNaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755118461; c=relaxed/simple;
	bh=9DH8u6qIUtGbxO9LA7iEGvsWUvMMlo8SaH3exJ2B8QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dj4Ebu4gPIgAHjp67PU1TkPVRWvLBws+zuhBFnusxs4SodDKiLhszqsh2Uk1kgkNGZQr7yr5K5tePjtSFKZucCWYnu5PnYethN6KJi/W11IT0wD0dP3qwVuotulW+EenqRt+B7XFH7yh6MtQg8HXGnK3mmSSP6Mgo9j1TGkN6pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PoBWnEIx; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 13 Aug 2025 13:53:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755118445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BnHjAcE2afHw2ZH4ahTMmzFeMhbV05T1AU89RXbzZLs=;
	b=PoBWnEIxIcfMYl/tlSSwqrpgpdkIgUnt+/l5CiIfW4q7tMLS63s9dpu3LCinuWGdf2pZLI
	PFouMpIDd+OtRzFJ0DZjD6mxEhmzKK6mUYtO0jIMBKS2DPJrYVw2hs6FmH7tH0tstH4dSA
	7GSmRfkdmXKgTvsCjyX68rxPSWqhU08=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Tejun Heo <tj@kernel.org>, Simon Horman <horms@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 net-next 12/12] net-memcg: Decouple controlled memcg
 from global protocol memory accounting.
Message-ID: <oafk5om7v5vtxjmo5rtwy6ullprfaf6mk2lh4km7alj3dtainn@jql2rih5es4n>
References: <20250812175848.512446-1-kuniyu@google.com>
 <20250812175848.512446-13-kuniyu@google.com>
 <w6klr435a4rygmnifuujg6x4k77ch7cwoq6dspmyknqt24cpjz@bbz4wzmxjsfk>
 <CAAVpQUCU=VJxA6NKx+O1_zwzzZOxUEsG9mY+SNK+bzb=dj9s5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUCU=VJxA6NKx+O1_zwzzZOxUEsG9mY+SNK+bzb=dj9s5w@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 13, 2025 at 11:19:31AM -0700, Kuniyuki Iwashima wrote:
> On Wed, Aug 13, 2025 at 12:11 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Tue, Aug 12, 2025 at 05:58:30PM +0000, Kuniyuki Iwashima wrote:
> > > Some protocols (e.g., TCP, UDP) implement memory accounting for socket
> > > buffers and charge memory to per-protocol global counters pointed to by
> > > sk->sk_proto->memory_allocated.
> > >
> > > When running under a non-root cgroup, this memory is also charged to the
> > > memcg as "sock" in memory.stat.
> > >
> > > Even when a memcg controls memory usage, sockets of such protocols are
> > > still subject to global limits (e.g., /proc/sys/net/ipv4/tcp_mem).
> > >
> > > This makes it difficult to accurately estimate and configure appropriate
> > > global limits, especially in multi-tenant environments.
> > >
> > > If all workloads were guaranteed to be controlled under memcg, the issue
> > > could be worked around by setting tcp_mem[0~2] to UINT_MAX.
> > >
> > > In reality, this assumption does not always hold, and processes that
> > > belong to the root cgroup or opt out of memcg can consume memory up to
> > > the global limit, becoming a noisy neighbour.
> >
> > Processes running in root memcg (I am not sure what does 'opt out of
> > memcg means')
> 
> Sorry, I should've clarified memory.max==max (and same
> up to all ancestors as you pointed out below) as opt-out,
> where memcg works but has no effect.
> 
> 
> > means admin has intentionally allowed scenarios where
> 
> Not really intentionally, but rather reluctantly because the admin
> cannot guarantee memory.max solely without tcp_mem=UINT_MAX.
> We should not disregard the cause that the two mem accounting are
> coupled now.
> 
> 
> > noisy neighbour situation can happen, so I am not really following your
> > argument here.
> 
> So basically here I meant with tcp_mem=UINT_MAX any process
> can be noisy neighbour unnecessarily.

Only if there are processes in cgroups with unlimited memory limits.

I think you are still missing the point. So, let me be very clear:

Please stop using the "processes in cgroup with memory.max==max can be
source of isolation issues" argument. Having unlimited limit means you
don't want isolation. More importantly you don't really need this
argument for your work. It is clear (to me at least) that we want global
TCP memory accounting to be decoupled from memcg accounting. Using the
flawed argument is just making your series controversial.

[...]
> > Why not start with just two global options (maybe start with boot
> > parameter)?
> >
> > Option 1: Existing behavior where memcg and global TCP accounting are
> > coupled.
> >
> > Option 2: Completely decouple memcg and global TCP accounting i.e. use
> > mem_cgroup_sockets_enabled to either do global TCP accounting or memcg
> > accounting.
> >
> > Keep the option 1 default.
> >
> > I assume you want third option where a mix of these options can happen
> > i.e. some sockets are only accounted to a memcg and some are accounted
> > to both memcg and global TCP.
> 
> Yes because usually not all memcg have memory.max configured
> and we do not want to allow unlimited TCP memory for them.
> 
> Option 2 works for processes in the root cgroup but doesn't for
> processes in non-root cgroup with memory.max == max.
> 
> A good example is system processes managed by systemd where
> we do not want to specify memory.max but want a global seatbelt.
> 
> Note this is how it works _now_, and we want to _preserve_ the case.
> Does this make sense  ? > why decouple only for some
> 

I hope I am very clear to stop using the memory.max == max argument.

> 
> > I would recommend to make that a followup
> > patch series. Keep this series simple and non-controversial.
> 
> I can separate the series, but I'd like to make sure the
> Option 2 is a must for you or Meta configured memory.max
> for all cgroups ?  I didn't think it's likely but if there's a real
> use case, I'm happy to add a boot param.
> 
> The only diff would be boot param addition and the condition
> change in patch 11 so simplicity won't change.

I am not sure if option 2 will be used by Meta or someone else, so no
objection from me to not pursue it. However I don't want some possibly
userspace policy to opt-in in one or the other accounting mechanism in
the kernel.

What I think is the right approach is to have BPF struct ops based
approach with possible callback 'is this socket under pressure' or maybe
'is this socket isolated' and then you can do whatever you want in those
callbacks. In this way your can follow the same approach of caching the
result in kernel (lower bits of sk->sk_memcg).

I am CCing bpf list to get some suggestions or concerns on this
approach.


