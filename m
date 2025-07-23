Return-Path: <cgroups+bounces-8897-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46279B0F904
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 19:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B2373A9100
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 17:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098E72192F4;
	Wed, 23 Jul 2025 17:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ESWzRUlq"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32271E5B71
	for <cgroups@vger.kernel.org>; Wed, 23 Jul 2025 17:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291725; cv=none; b=cKNyhxDXXzDUZrPIKubllpH3NUHxYmzVGbRd8BXu5ufVInEf4tF5ay/1Qae+bm1CAJT+HQ1LsRuZfnk55Pm/FJrBdgefGr+0THeP027i788f9bu1dGjWNfiDT1gkfTTaUBvXvTrA6IUT5ZrTamjaN2py+Lz3hEZTcbayrK/ehv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291725; c=relaxed/simple;
	bh=xsqvkM5ANWjuaNC0gtr6n/xNah8JyVbYdJB0M1dk4CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9C4qEGnjUFiukGL2qhISnohyiwbdRrtV//HnIzmLQtOSQIK+mMKNQz0FjBnOlmI830eFz/9+cJbBzhhelXYl7vMYkKYpk0igZzYmY9Bb7IOei848TbCbJDYm6SWm3vZOc80xj9SoWNvQC9i/jUCELtUTVTpTqhw3wl5TgLV580=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ESWzRUlq; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 23 Jul 2025 10:28:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753291711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qLskRxgcaK46IteoEZp426l7L5IGh6tRkZFLXTMPYHM=;
	b=ESWzRUlqs6B4VD+/4WgG/ogXmFBi6o1zZ3IV91rTtlqqEkHOEbbnPDCCErhFN1QBEAGin0
	/zZmVczzek5Vw8cW8ES8kNVxGGMyKG0Rak8FJBlCiztIvQUzcivlWh1J+4DbHaMmr1BdjB
	yc8628umd6E/3vJ9+wU0EEwgEZK4RUg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Tejun Heo <tj@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
Message-ID: <e6qunyonbd4yxgf3g7gyc4435ueez6ledshde6lfdq7j5nslsh@xl7mcmaczfmk>
References: <z7kkbenhkndwyghwenwk6c4egq3ky4zl36qh3gfiflfynzzojv@qpcazlpe3l7b>
 <CANn89iLg-VVWqbWvLg__Zz=HqHpQzk++61dbOyuazSah7kWcDg@mail.gmail.com>
 <jc6z5d7d26zunaf6b4qtwegdoljz665jjcigb4glkb6hdy6ap2@2gn6s52s6vfw>
 <CAAVpQUAJCLaOr7DnOH9op8ySFN_9Ky__easoV-6E=scpRaUiJQ@mail.gmail.com>
 <p4fcser5zrjm4ut6lw4ejdr7gn2gejrlhy2u2btmhajiiheoax@ptacajypnvlw>
 <CAAVpQUAk4F__D7xdWpt0SEE4WEM_-6V1P7DUw9TGaV=pxZ+tgw@mail.gmail.com>
 <xjtbk6g2a3x26sqqrdxbm2vxgxmm3nfaryxlxwipwohsscg7qg@64ueif57zont>
 <CAAVpQUAL09OGKZmf3HkjqqkknaytQ59EXozAVqJuwOZZucLR0Q@mail.gmail.com>
 <jmbszz4m7xkw7fzolpusjesbreaczmr4i64kynbs3zcoehrkpj@lwso5soc4dh3>
 <CAAVpQUCv+CpKkX9Ryxa5ATG3CC0TGGE4EFeGt4Xnu+0kV7TMZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUCv+CpKkX9Ryxa5ATG3CC0TGGE4EFeGt4Xnu+0kV7TMZg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

Cc Tejun & Michal to get their opinion on memcg vs cgroup vs BPF
options.

On Tue, Jul 22, 2025 at 07:35:52PM -0700, Kuniyuki Iwashima wrote:
[...]
> >
> > Running workloads in root cgroup is not normal and comes with a warning
> > of no isolation provided.
> >
> > I looked at the patch again to understand the modes you are introducing.
> > Initially, I thought the series introduced multiple modes, including an
> > option to exclude network memory from memcg accounting. However, if I
> > understand correctly, that is not the case—the opt-out applies only to
> > the global TCP/UDP accounting. That’s a relief, and I apologize for the
> > misunderstanding.
> >
> > If I’m correct, you need a way to exclude a workload from the global
> > TCP/UDP accounting, and currently, memcg serves as a convenient
> > abstraction for the workload. Please let me know if I misunderstood.
> 
> Correct.
> 
> Currently, memcg by itself cannot guarantee that memory allocation for
> socket buffer does not fail even when memory.current < memory.max
> due to the global protocol limits.
> 
> It means we need to increase the global limits to
> 
> (bytes of TCP socket buffer in each cgroup) * (number of cgroup)
> 
> , which is hard to predict, and I guess that's the reason why you
> or Wei set tcp_mem[] to UINT_MAX so that we can ignore the global
> limit.

No that was not the reason. The main reason behind max tcp_mem global
limit was it was not needed as memcg should account and limit the
network memory. I think the reason you don't want tcp_mem global limit
unlimited now is you have internal feature to let workloads opt out of
the memcg accounting of network memory which is causing isolation
issues.

> 
> But we should keep tcp_mem[] within a sane range in the first place.
> 
> This series allows us to configure memcg limits only and let memcg
> guarantee no failure until it fully consumes memory.max.
> 
> The point is that memcg should not be affected by the global limits,
> and this is orthogonal with the assumption that every workload should
> be running under memcg.
> 
> 
> >
> > Now memcg is one way to represent the workload. Another more natural, at
> > least to me, is the core cgroup. Basically cgroup.something interface.
> > BPF is yet another option.
> >
> > To me cgroup seems preferrable but let's see what other memcg & cgroup
> > folks think. Also note that for cgroup and memcg the interface will need
> > to be hierarchical.
> 
> As the root cgroup doesn't have the knob, these combinations are
> considered hierarchical:
> 
> (parent, child) = (0, 0), (0, 1), (1, 1)
> 
> and only the pattern below is not considered hierarchical
> 
> (parent, child) = (1, 0)
> 
> Let's say we lock the knob at the first socket creation like your
> idea above.
> 
> If a parent and its child' knobs are (0, 0) and the child creates a
> socket, the child memcg is locked as 0.  When the parent enables
> the knob, we must check all child cgroups as well.  Or, we lock
> the all parents' knobs when a socket is created in a child cgroup
> with knob=0 ?  In any cases we need a global lock.
> 
> Well, I understand that the hierarchical semantics is preferable
> for cgroup but I think it does not resolve any real issue and rather
> churns the code unnecessarily.

All this is implementation detail and I am asking about semantics. More
specifically:

1. Will the root be non-isolated always?
2. If a cgroup is isolated, does it mean all its desendants are
   isolated?
3. Will there ever be a reasonable use-case where there is non-isolated
   sub-tree under an isolated ancestor?

Please give some thought to the above (and related) questions.

I am still not convinced that memcg is the right home for this opt-out
feature. I have CCed cgroup folks to get their opinion as well.

