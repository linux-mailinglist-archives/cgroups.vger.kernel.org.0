Return-Path: <cgroups+bounces-9193-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FABB2731D
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 01:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900853A1545
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 23:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D86F212B0A;
	Thu, 14 Aug 2025 23:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZLT1hDk9"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA80219E0
	for <cgroups@vger.kernel.org>; Thu, 14 Aug 2025 23:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755215218; cv=none; b=RT2H2gf2MMSVRdGhJFkkIm+Lf5ghkTwsgr/TT54IfiRKaT88MhHc5BgjY/9vJau5o/GA3JT7an0/Sw0+cYNXpqhiHnyF6qY5kllF+BwwgfHSbAYZ5kpfsH+tCqi8xHZkumOQvidq1H4zwS7XgSucURjQGKhed/UfOTnrD6jSTzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755215218; c=relaxed/simple;
	bh=Ke60j/N6Arg3luHMmKhxp0CCL2RoyhRUDs+NVMijRTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4lR568aYvE04ad2lH/KYSJi56/rX3rvjPiruP/uNfrtFQ8OTi47w/3afbjXI3GJwW8lLhG1SmVyYpXTIUFUibeCiC8DQ5OvXddOl/laaPBYfFxF5VDNNE9pIMR2IOyhSft4mW1IwPcFC24YPmGe3zVL4RwKiR+IddgdUbrhz/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZLT1hDk9; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 14 Aug 2025 16:46:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755215203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGIdFybk+kRLges3ScZ8VUkCQcp4M1Wu7yEzp4KW/MM=;
	b=ZLT1hDk95uSd62R3ZCt8vxzdrGH0dCDcV8SAixDlYtSQGJ9T0Fb2vbmbfRI0sWncn3K6LT
	2S7D2jdY921fEQgbWRRjyOFwX6or7Qtqj1apAEvgjj6VbF5171jh8eZao+JGgmXjCw1Old
	ivCArvOUDegxUsSqdNG1bqYhuLPFdas=
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
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 net-next 01/10] mptcp: Fix up subflow's memcg when
 CONFIG_SOCK_CGROUP_DATA=n.
Message-ID: <r3czpatkdegf7aoo3ezvrvzuqkixsb557okybueig4fcuknku3@jkgzexpt7dnq>
References: <20250814200912.1040628-1-kuniyu@google.com>
 <20250814200912.1040628-2-kuniyu@google.com>
 <cs5uvm72eyzqljcxtmienkmmth54pqqjmlyya5vf3twncbp7u5@jfnktl43r5se>
 <CAAVpQUDyy9f7=LNZc2ka2RiOhR3_eOhEb+Nih37HnF0_cdrJqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUDyy9f7=LNZc2ka2RiOhR3_eOhEb+Nih37HnF0_cdrJqA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 14, 2025 at 04:27:31PM -0700, Kuniyuki Iwashima wrote:
> On Thu, Aug 14, 2025 at 2:44 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Thu, Aug 14, 2025 at 08:08:33PM +0000, Kuniyuki Iwashima wrote:
> > > When sk_alloc() allocates a socket, mem_cgroup_sk_alloc() sets
> > > sk->sk_memcg based on the current task.
> > >
> > > MPTCP subflow socket creation is triggered from userspace or
> > > an in-kernel worker.
> > >
> > > In the latter case, sk->sk_memcg is not what we want.  So, we fix
> > > it up from the parent socket's sk->sk_memcg in mptcp_attach_cgroup().
> > >
> > > Although the code is placed under #ifdef CONFIG_MEMCG, it is buried
> > > under #ifdef CONFIG_SOCK_CGROUP_DATA.
> > >
> > > The two configs are orthogonal.  If CONFIG_MEMCG is enabled without
> > > CONFIG_SOCK_CGROUP_DATA, the subflow's memory usage is not charged
> > > correctly.
> > >
> > > Let's wrap sock_create_kern() for subflow with set_active_memcg()
> > > using the parent sk->sk_memcg.
> > >
> > > Fixes: 3764b0c5651e3 ("mptcp: attach subflow socket to parent cgroup")
> > > Suggested-by: Michal Koutný <mkoutny@suse.com>
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > ---
> > >  mm/memcontrol.c     |  5 ++++-
> > >  net/mptcp/subflow.c | 11 +++--------
> > >  2 files changed, 7 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 8dd7fbed5a94..450862e7fd7a 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -5006,8 +5006,11 @@ void mem_cgroup_sk_alloc(struct sock *sk)
> > >       if (!in_task())
> > >               return;
> > >
> > > +     memcg = current->active_memcg;
> > > +
> >
> > Use active_memcg() instead of current->active_memcg and do before the
> > !in_task() check.
> 
> Why not reuse the !in_task() check here ?
> We never use int_active_memcg for socket and also
> know int_active_memcg is always NULL here.
> 

If we are making mem_cgroup_sk_alloc() work with set_active_memcg()
infra then make it work for both in_task() and !in_task() contexts.


