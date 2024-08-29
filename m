Return-Path: <cgroups+bounces-4572-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CA6964B27
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 18:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A110AB21598
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 16:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332851B3F1E;
	Thu, 29 Aug 2024 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hrqDNfnD"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE83192B84;
	Thu, 29 Aug 2024 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947866; cv=none; b=NCriO+hd8kG/w9M+pbAGAh+rMsLReywOUTxf8ZbXtUr1Oz7gU2137PCMqZsgvdirHbNE30QXtp8AhCSh8H7sH0pnlGIyGcSp0V5TYf8eXicYsieSyE/KhRGmNXuG9bjLoiOlkOqjbG5XUqG2ozj+u6W3VfjFDQIhGnh2j+mMoJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947866; c=relaxed/simple;
	bh=DY7oqtCWi3Gr0j/wHl0PYqK7Sy/TikvGGe3rvyUSFIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/jHoebGFbEp/DrsLC6THpm6wYLlSvEJxv3y891WsD6brxWepA78lTYxBXI4Ed3x7sjxiPWxgSeMR2GdbsGvfhVfjdIZUbRZPkEtZ/I7xA1g2GMAy/Xm7vZSQ8OJUrEFYhVVIg+5TT4Ycc0TKWBB9OvK/RU3MyiefO2R8+IsVq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hrqDNfnD; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Aug 2024 09:10:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724947859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tMNX7CC2ZokFN7tmkODHv3OqmYDEKIEaSqAFQdA/2uI=;
	b=hrqDNfnDx0E+8b7nai3Ir81wZO3rzI2sVvhQ1sasU4acY5grkfXMtDS4oH0iiPBfNNZOOi
	Gkg/9xEp7tV0NsgpZb7E/PSBeK7w+7okdsgaAbviPBZXSdcsCe45T3L6ksPFRzYP0PoR0g
	100bDwm30tkPs/6ucLw9qlOvCqS/J+g=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2] memcg: add charging of already allocated slab objects
Message-ID: <mvxyevmpzwatlt7z4fdjakvuixmp5hcqmvo3467kzlgp2xkbgf@xumnm2y6xxrg>
References: <20240827235228.1591842-1-shakeel.butt@linux.dev>
 <9fb06d9b-dec5-4300-acef-bbce51a9a0c1@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fb06d9b-dec5-4300-acef-bbce51a9a0c1@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 29, 2024 at 11:42:10AM GMT, Vlastimil Babka wrote:
> On 8/28/24 01:52, Shakeel Butt wrote:
> > At the moment, the slab objects are charged to the memcg at the
> > allocation time. However there are cases where slab objects are
> > allocated at the time where the right target memcg to charge it to is
> > not known. One such case is the network sockets for the incoming
> > connection which are allocated in the softirq context.
> > 
> > Couple hundred thousand connections are very normal on large loaded
> > server and almost all of those sockets underlying those connections get
> > allocated in the softirq context and thus not charged to any memcg.
> > However later at the accept() time we know the right target memcg to
> > charge. Let's add new API to charge already allocated objects, so we can
> > have better accounting of the memory usage.
> > 
> > To measure the performance impact of this change, tcp_crr is used from
> > the neper [1] performance suite. Basically it is a network ping pong
> > test with new connection for each ping pong.
> > 
> > The server and the client are run inside 3 level of cgroup hierarchy
> > using the following commands:
> > 
> > Server:
> >  $ tcp_crr -6
> > 
> > Client:
> >  $ tcp_crr -6 -c -H ${server_ip}
> > 
> > If the client and server run on different machines with 50 GBPS NIC,
> > there is no visible impact of the change.
> > 
> > For the same machine experiment with v6.11-rc5 as base.
> > 
> >           base (throughput)     with-patch
> > tcp_crr   14545 (+- 80)         14463 (+- 56)
> > 
> > It seems like the performance impact is within the noise.
> > 
> > Link: https://github.com/google/neper [1]
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > ---
> > v1: https://lore.kernel.org/all/20240826232908.4076417-1-shakeel.butt@linux.dev/
> > Changes since v1:
> > - Correctly handle large allocations which bypass slab
> > - Rearrange code to avoid compilation errors for !CONFIG_MEMCG builds
> > 
> > RFC: https://lore.kernel.org/all/20240824010139.1293051-1-shakeel.butt@linux.dev/
> > Changes since the RFC:
> > - Added check for already charged slab objects.
> > - Added performance results from neper's tcp_crr
> > 
> >  include/linux/slab.h            |  1 +
> >  mm/slub.c                       | 51 +++++++++++++++++++++++++++++++++
> >  net/ipv4/inet_connection_sock.c |  5 ++--
> >  3 files changed, 55 insertions(+), 2 deletions(-)
> 
> I can take the v3 in slab tree, if net people ack?

Thanks.

> 
> BTW, will this be also useful for Linus's idea of charging struct files only
> after they exist? But IIRC there was supposed to be also a part where we
> have a way to quickly determine if we're not over limit (while allowing some
> overcharge to make it quicker).
>

Do you have link to those discussions or pointers to the code? From what
you have described, I think this should work. We have the relevant gfp
flags to control the charging behavior (with some caveats).

> Because right now this just overcharges unconditionally, but that's
> understandable when the irq context creating the socket can't know the memcg
> upfront. In the open() situation this is different.
> 

For networking we deliberately overcharges in the irq context (if
needed) and the course correct in the task context. However networking
stack is very robust due to mechanisms like backoff, retransmit to handle
situations like packet drops, allocation failures, congestion etc. Other
subsystem are not that robust against ENOMEM. Once I have more detail I
can follow up on the struct files case.

thanks,
Shakeel



