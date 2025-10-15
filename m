Return-Path: <cgroups+bounces-10786-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA12BE038A
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 20:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDEE1486B48
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 18:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E92298CC0;
	Wed, 15 Oct 2025 18:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xBrMecK8"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3741B27A135
	for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 18:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553596; cv=none; b=VJuWkPVmU8U5AdSDDSeDzQsXkdY9Jk+KFOnKwd4SlQUV1PoTGZGQp7rY/GaWdfokvPcuiYBdbQI92vGARmaKBFuQ4shaC4UxNlv/M7IoxcDXx2lfcdkdgd6y7T2r0/lf7LI1LtSngAJNB2WeQUJTlqT9BTluL2gHeCUJvb48KBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553596; c=relaxed/simple;
	bh=GzWAJfXQ4mx7p23ahMXnxdcu++d2hZmirVEaQTUUJwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thKlIis+FR2TVdArNWAbepN+SN9eGA5cbCfhKVD75Xm/ZcXnwXmSo4vzDFH73JIZrAHtjsEh+LNXdhSTOFN0W+N989ZbJOaoiuM1I3Vie7eAEqmgKLYurYmAbnutLr3aydjLBZlrA/6LjY++Xnl9j/pbvyBVpT1zgZI9gndqkF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xBrMecK8; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 15 Oct 2025 11:39:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760553582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oblg0R0ccBxtMNIXCr7M4Sp9kMpHmHDbv49DnKelLKY=;
	b=xBrMecK88RlyCjYmuhCquUFna3t95yMcfcJHi+PbM+XKpyzNvHP9UHwn6FB7oHM2BdAVjW
	bb2BzGz1BdhNe3t0TD4v/Pkk7OAfREX0mklQVRPXGSoMS7z21I0qt0Htudxk5Dekc0Nqly
	wY+Z05WK7ZIwPTN+TEVuJrbvdvSneO4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Daniel Sedlak <daniel.sedlak@cdn77.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Matyas Hurtik <matyas.hurtik@cdn77.com>
Subject: Re: [PATCH v5] memcg: expose socket memory pressure in a cgroup
Message-ID: <cfoc35cqn7sa63w6kufwvq7rs6s7xiivfbmr752h4rmur4demz@d7joq6oho6qc>
References: <87qzvdqkyh.fsf@linux.dev>
 <13b5aeb6-ee0a-4b5b-a33a-e1d1d6f7f60e@cdn77.com>
 <87o6qgnl9w.fsf@linux.dev>
 <tr7hsmxqqwpwconofyr2a6czorimltte5zp34sp6tasept3t4j@ij7acnr6dpjp>
 <87a5205544.fsf@linux.dev>
 <qdblzbalf3xqohvw2az3iogevzvgn3c3k64nsmyv2hsxyhw7r4@oo7yrgsume2h>
 <875xcn526v.fsf@linux.dev>
 <89618dcb-7fe3-4f15-931b-17929287c323@cdn77.com>
 <6ras4hgv32qkkbh6e6btnnwfh2xnpmoftanw4xlbfrekhskpkk@frz4uyuh64eq>
 <CAAVpQUDWKaB6jH3Ouyx35z5eUb9GKfgHS0H7ngcPEFeBdtPjRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUDWKaB6jH3Ouyx35z5eUb9GKfgHS0H7ngcPEFeBdtPjRw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 15, 2025 at 11:21:17AM -0700, Kuniyuki Iwashima wrote:
> On Tue, Oct 14, 2025 at 1:33 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
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
> I think we could simply put memcg_memory_event() in
> mem_cgroup_sk_under_memory_pressure() when it returns
> true.
> 
> Other than tcp_adjust_rcv_ssthresh(), if tcp_under_memory_pressure()
> returns true, it indicates something bad will happen, failure to expand
> rcvbuf and sndbuf, need to prune out-of-order queue more aggressively,
> FIN deferred to a retransmitted packet.
> 
> Also, we could cover mptcp and sctp too.
> 

I wanted to start simple and focus on one specific action but I am open
to other actins as well. Do we want a generic network throttled metric
or do we want different metric for different action? At the moment I
think for memcg, a single metric would be sufficient and then we can
have tracepoints for more fine grained debugging.


