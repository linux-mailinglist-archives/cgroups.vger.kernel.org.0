Return-Path: <cgroups+bounces-4740-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA5C96FBC6
	for <lists+cgroups@lfdr.de>; Fri,  6 Sep 2024 21:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC40D1F22194
	for <lists+cgroups@lfdr.de>; Fri,  6 Sep 2024 19:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBE11CE6F8;
	Fri,  6 Sep 2024 19:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HuSBnH3k"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1EA13D508
	for <cgroups@vger.kernel.org>; Fri,  6 Sep 2024 19:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725649480; cv=none; b=eargAyuGpj86kD+OId25gkZsDZs9W3OGHu4X7Vdc/G+iTjfj7GrqjAfXO+9NQUc6uWszEZhJrcpIUdZuRQdYcsoA6HsBZainiuf1RfMB8HRQXaRI8vBtr+Fj4m+dr3UdqXGjH5QJHJLI2GXhQG6zvUrthHD98fPHx59To/JwtrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725649480; c=relaxed/simple;
	bh=MwIP6aB4W2UqOhl0uKHq0vwdKl6bbY+6/2oddvxRw/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUNnSDpaoR9LS6ZVjlADaT8ky+P20w5d0ixS1P1NQPx4G/iOQlDbpUTfaKEVGVYFhbT5JwutFRD9ZSBm+vVzOVwA82T3iCAeit721zt0AKlXihbU4Unn9UZyr/VIJm4sUM1GGq2sHTs45nZKzw1p/2rEwWMiabySpS2un/bhG6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HuSBnH3k; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 6 Sep 2024 12:04:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725649475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yGhIrh+rQpPnyonW7hAs/7/T5yo5hXID+LB/v3yhQQA=;
	b=HuSBnH3k4p4CRY+caXHgDwk0PA1jBcjQKJJZsfnO1tGxmb1w1xQFavKHbW0iknuQJ1THdd
	p63X1WHVfhVLaAYVFzrwOTtA4Rr8rh7kjsEjmDKOPBRejuI9e25HjWbQIY/YpiBKO5afSP
	EmNB3vZlMoLDxc0UMboZCcZ1yfPhOh4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Yosry Ahmed <yosryahmed@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, David Rientjes <rientjes@google.com>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4] memcg: add charging of already allocated slab objects
Message-ID: <ylswk3xbfulik5bumfsbnocnmdxez24qgoyh2dfi5nobfpxdvf@3dfbwepuztbb>
References: <20240905173422.1565480-1-shakeel.butt@linux.dev>
 <CAJD7tkbWLYG7-G9G7MNkcA98gmGDHd3DgS38uF6r5o60H293rQ@mail.gmail.com>
 <qk3437v2as6pz2zxu4uaniqfhpxqd3qzop52zkbxwbnzgssi5v@br2hglnirrgx>
 <572688a7-8719-4f94-a5cd-e726486c757d@suse.cz>
 <CAJD7tkZ+PYqvq6oUHtrtq1JE670A+kUBcOAbtRVudp1JBPkCwA@mail.gmail.com>
 <e7ec0800-f551-4b32-ad26-f625f88962f1@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7ec0800-f551-4b32-ad26-f625f88962f1@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 06, 2024 at 07:28:56PM GMT, Vlastimil Babka wrote:
> On 9/6/24 19:19, Yosry Ahmed wrote:
> > [..]
> >> I felt it could be improved more, so ended up with this. Thoughts?
> >>
> >> /**
> >>  * kmem_cache_charge - memcg charge an already allocated slab memory
> >>  * @objp: address of the slab object to memcg charge
> >>  * @gfpflags: describe the allocation context
> >>  *
> >>  * kmem_cache_charge allows charging a slab object to the current memcg,
> >>  * primarily in cases where charging at allocation time might not be possible
> >>  * because the target memcg is not known (i.e. softirq context)
> >>  *
> >>  * The objp should be pointer returned by the slab allocator functions like
> >>  * kmalloc (with __GFP_ACCOUNT in flags) or kmem_cache_alloc. The memcg charge
> > 
> > Aren't allocations done with kmalloc(__GFP_ACCOUNT) already accounted?
> > Why would we need to call kmem_cache_charge() for those?
> 
> AFAIU current_obj_cgroup() returns NULL because we're in the interrupt
> context and no remote memcg context has been set. Thus the charging is
> skipped. The patch commit log describes such scenario for network receive.
> But in case of kmalloc() the allocation must have been still attempted with
> __GFP_ACCOUNT so a kmalloc-cg cache is used even if the charging fails.
> 
> If there's another usage for kmem_cache_charge() where the memcg is
> available but we don't want to charge immediately on purpose (such as the
> Linus' idea for struct file), we might need to find another way to tell
> kmalloc() to use the kmalloc-cg cache but not charge immediately...
> 

For the struct file, we already have a dedicated kmem_cache
(filp_cachep), so no additional handling would be needed. However in
future we might have cases where we want the kmalloc allocations to
happen from non-normal kmalloc caches and then we can add mechanism to
support such cases.

