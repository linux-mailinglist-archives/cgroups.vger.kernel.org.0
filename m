Return-Path: <cgroups+bounces-14876-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHF7M9UDu2kdeQIAu9opvQ
	(envelope-from <cgroups+bounces-14876-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 20:58:13 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D0D2C2467
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 20:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 653973090EE1
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 19:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AAC3264CD;
	Wed, 18 Mar 2026 19:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nkNHq1UK"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99E422097
	for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 19:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773863763; cv=none; b=dg7hhRbP+zKcoNBKUtOzyaWbHDMqTzDyeTOFOSw+bVbSXqEjlvdnWdiJ068gU+4bL9CjiaU6iI1ps8KdMa6i8sGbuzjHbiwoupSK8yatcWGCSO8QxMzYH/kvWWTPZkWAA0ajkBUkqogf25WzKj73L9QEYiFftRELhQPChwjHaSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773863763; c=relaxed/simple;
	bh=0oVoSOWBmgSmiPuPd4UYjkIkIS8F0zm7eBwax8hj488=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otTsNsCwm5VGFOj3YxAYqayg2AMw+uphpgvfB4K9Afk+XBE4dHvwciJyTwXqDm5P2DRN69CdbloHIzJjl/Fy+HlQwWO5xr4D9M/wWlti159TrAP9DuBvQX5eHaq4emEBO5N3AX9GG5kpxt+rCb+z4zKrDP40C/dfLCfk0ROzMgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nkNHq1UK; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 18 Mar 2026 12:55:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773863759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qn28qcTqY23acAMwPqY5EzcQaQiRCWYQzB9ll9fxjks=;
	b=nkNHq1UKY0IObCr6MXOxnFOXYvZm2QkeEXwfwhyKIOC/nQgOgcRJ1odex9tA1LmOyv8J3N
	0HD+6PaSAg+JNu+4lj6sN6Z4n301cAV78luQjzQCHIjT6m9uBa6nSAjjkQrlKWWU79Op3h
	xe4ADbiNKxzt7MtIJ/uQwO/4G8zuo4Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, yc-core@yandex-team.ru
Subject: Re: [PATCH] mm: add memory.compact_unevictable_allowed cgroup
 attribute
Message-ID: <absA_ryDAnfaKJXC@linux.dev>
References: <20260317121736.f73a828de2a989d1a07efea1@linux-foundation.org>
 <3db237d0-1ee8-44b7-a356-f3015173f7c2@yandex-team.ru>
 <abphjNOYaNslTA90@tiehlicka>
 <7ca9876c-f3fa-441c-9a21-ae0ee5523318@yandex-team.ru>
 <abpue_k_9mjQAP6X@tiehlicka>
 <73322279-c6f8-4319-827b-938c20c96b9b@yandex-team.ru>
 <abp3-iJbazCpygIm@tiehlicka>
 <b9ceff32-1f8f-454e-84ce-b8788b3a4952@yandex-team.ru>
 <abqQtcNqxzxiZyf1@tiehlicka>
 <fd7409a3-5f8c-492b-836d-559b001a61dd@yandex-team.ru>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd7409a3-5f8c-492b-836d-559b001a61dd@yandex-team.ru>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14876-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 36D0D2C2467
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Daniil,

On Wed, Mar 18, 2026 at 05:03:53PM +0300, Daniil Tatianin wrote:
> 
> On 3/18/26 2:47 PM, Michal Hocko wrote:
> > On Wed 18-03-26 13:08:31, Daniil Tatianin wrote:
> > > On 3/18/26 1:01 PM, Michal Hocko wrote:
> > > > On Wed 18-03-26 12:25:17, Daniil Tatianin wrote:
> > > > > On 3/18/26 12:20 PM, Michal Hocko wrote:
> > > > [...]
> > > > > > Shouldn't those use mlock?
> > > > > Absolutely, mlock is required to mark a folio as unevictable. Note that
> > > > > unevictable folios are still
> > > > > perfectly eligible for compaction. This new property makes it so a cgroup
> > > > > can say whether its
> > > > > unevictable pages should be compacted (same as the global
> > > > > compact_unevictable_allowed sysctl).
> > > > If the mlock is already used then why do we need a per memcg control as
> > > > well? Do we have different classes of mlocked pages some with acceptable
> > > > compaction while others without?
> > OK, I have misread the intention and this is exactly focused at mlock
> > rather than general protection of all memcg charged memory. Now
> > 
> > > The way it works is mlock(2) only prevents pages from being evicted
> > > from the page cache by setting unevictable | mlocked flags on the
> > > page. Such pages, however, are still allowed for compaction by
> > > default, unless /proc/sys/vm/compact_unevictable_allowed is set to 0.
> > > That property essentially "promotes" ALL such (unevictable) pages to a
> > > new synthetic tier by making compaction skip them. The per-cgroup
> > > property works similarly, however, it allows the scope to be much
> > > smaller: from a global setting that promotes literally ALL unevictable
> > > (mlocked) pages to this tier, to only promoting pages belonging to the
> > > cgroup that has memory.compact_unevictable_allowed as 0.
> > This is clear but what is not really clear to me is whether this is
> > worth having as mlock workloads are already quite specific, the amount
> > of mlocked memory shouldn't really consume huge portion of the memory so
> > you still need to have a solid usecase where such a micro management
> > really is worth it. In other words why a global
> > compact_unevictable_allowed is not sufficient.
> 
> In my opinion both mlocked memory and non-compactible memory have the right
> to
> co-exist on the same host without a global switch that turns one into the
> other. I agree
> that it's not a super common thing, but I still think it can be beneficial.
> 
> Some examples include but not limited to: security: so that sensitive data
> is never swapped
> to disk yet we have no problem if it gets compacted and the actual physical
> page gets replaced,
> performance for some apps: so that we can e.g. memlock a large binary in
> memory to keep it in
> page cache and improve startup time, but again don't care much if the actual
> backing pages are
> replaced via compaction.
> 
> On the other hand, some critically important/real time applications do need
> protection from compaction
> as well on top of the regular mlock, so that they have predictable latency
> and response time, which can
> really fluctuate during heavy compaction. Both of these cases can coexist on
> the same physical machine.
> 

IMO we should actually deprecate compact_unevictable_allowed and always allow
compaction for unevictable memory. We should decouple the notion of mlocked
memory from the pinned/unmovable memory. Pinned memory has much more
consequences on the system related to fragmentation and availability of larger
folios than mlocked memory. If there are applications which need unmovable
memory, they should request it explicitly. I don't think there is an API for
such memory but for such use-cases, it makes sense to have an explicit API.





