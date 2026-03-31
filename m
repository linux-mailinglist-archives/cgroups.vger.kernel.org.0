Return-Path: <cgroups+bounces-15136-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJoKE9f7y2mcNAYAu9opvQ
	(envelope-from <cgroups+bounces-15136-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 18:52:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D2636D4D0
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 18:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C1A3B306422C
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 16:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ED5426EDA;
	Tue, 31 Mar 2026 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpoZhlqW"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963CA42669C;
	Tue, 31 Mar 2026 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975298; cv=none; b=HRwA/tSbYMiYhFyWlijW5khMjlVeZK4V7gOX55LT5kjVi32ChMfXjqLRm7vr9EjdugjZjnINekckWIFzUEsrw1t/LzjmsKkOCy7ZA1VjTak2/yhcCmN3eZxl0CrV6OvtyDt5u0CSqCIGofEF7N/2Nk8GhZTKRqHbjTIkpj67icY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975298; c=relaxed/simple;
	bh=ywVHlTRf5Tl9PysYqy8ehrxhpxHsZDl2JA5xh4pA8mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbXXNadmV9guW1T5mI9qF6meYUJNW+o3zJAK4KRLBsxYoOKOtDvVTd0N751PpEUQ/LrZ5c/sysYGOFSr+r3DINdjgNmTflq+1EAXrhZoG1zlHWgR4DqBnr5Bb0aagKNIM125xY2m/QqLeCsjovaTiAfSsrTFQYN9CDMLdeGt2oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpoZhlqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33591C2BCB1;
	Tue, 31 Mar 2026 16:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774975298;
	bh=ywVHlTRf5Tl9PysYqy8ehrxhpxHsZDl2JA5xh4pA8mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IpoZhlqW77ifhqsrVptmAFxDbIwtx3rAPM8fBui7v2JQSwdJHRZorsMPaAaUAtkCX
	 HiyVJxZZldfllhLGXBRgY6g0GGsiIviwg2ZVaIjg+jWqDqC8jSDT8szOFkU0JjzQTY
	 rQMGkJjSfj0liCM8zOCIlkKnxDeFb9P9mFA7rtn7//srCjmnJ0jBqR3QHh3vF7NxcT
	 /rZaOvvGEVJCnB2UwAPA9GOjDD5a0zsg5OIfFrdjFaTURtr98LVei7vhu+k+RAiFHH
	 RuBV+gR9z+VSlG3pRQrlxoDIVYiEJgX69ObHWc+MSXnlUCRGnnhbdNwwsLRaTzQwiY
	 6wUuw/CT6KfQA==
Date: Wed, 1 Apr 2026 01:41:36 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Hui Zhu <hui.zhu@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Hui Zhu <zhuhui@kylinos.cn>, Vlastimil Babka <vbabka@kernel.org>,
	Hao Li <hao.li@linux.dev>
Subject: Re: [PATCH mm-stable v3] mm/memcontrol: batch memcg charging in
 __memcg_slab_post_alloc_hook
Message-ID: <acv5QCe0qMUUW2xP@hyeyoo>
References: <20260331091707.226786-1-hui.zhu@linux.dev>
 <acvnjCr26zpQUW0h@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acvnjCr26zpQUW0h@linux.dev>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15136-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E1D2636D4D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 08:32:30AM -0700, Shakeel Butt wrote:
> On Tue, Mar 31, 2026 at 05:17:07PM +0800, Hui Zhu wrote:
> > From: Hui Zhu <zhuhui@kylinos.cn>
> > 
> > When kmem_cache_alloc_bulk() allocates multiple objects, the post-alloc
> > hook __memcg_slab_post_alloc_hook() previously charged memcg one object
> > at a time, even though consecutive objects may reside on slabs backed by
> > the same pgdat node.
> > 
> > Batch the memcg charging by scanning ahead from the current position to
> > find a contiguous run of objects whose slabs share the same pgdat, then
> > issue a single __obj_cgroup_charge() / __consume_obj_stock() call for
> > the entire run. The per-object obj_ext assignment loop is preserved as-is
> > since it cannot be further collapsed.
> > 
> > This implements the TODO comment left in commit bc730030f956 ("memcg:
> > combine slab obj stock charging and accounting").
> > 
> > The existing error-recovery contract is unchanged: if size == 1 then
> > memcg_alloc_abort_single() will free the sole object, and for larger
> > bulk allocations kmem_cache_free_bulk() will uncharge any objects that
> > were already charged before the failure.
> > 
> > Benchmark using kmem_cache_alloc_bulk() with SLAB_ACCOUNT
> > (iters=100000):
> > 
> >   bulk=32  before: 215 ns/object   after: 174 ns/object  (-19%)
> >   bulk=1   before: 344 ns/object   after: 335 ns/object  (  ~)
> > 
> > No measurable regression for bulk=1, as expected.
> > 
> > Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> 
> Do we have an actual user of kmem_cache_alloc_bulk(GFP_ACCOUNT) in kernel?

Apparently we have a SLAB_ACCOUNT user in io_uring.c.
(perhaps it's the only user?)

> If yes, can you please benchmark that usage? Otherwise can we please wait for
> an actual user before adding more complexity? Or you can look for opportunities
> for kmem_cache_alloc_bulk(GFP_ACCOUNT) users and add the optimization along with
> the user.

Good point. I was also wondering what are use cases benefiting
from this beyond the microbenchmark.

> Have you looked at the bulk free side? I think we already have rcu freeing in
> bulk as a user. Did you find any opportunities in optimizing the
> __memcg_slab_free_hook() from bulk free?

Probably a bit out of scope but one thing to note on slab side:
kfree_bulk() (called by kfree_rcu batching) doesn't specify slab cache,
and it builds a detached freelist which contains objects from the same slab.

On the other hand kmem_cache_free_bulk() with non-NULL slab cache
simply calls free_to_pcs_bulk() and it passes objects one by one to
__memcg_slab_free_hook() since objects may not come from the same slab.

Now that we have sheaves enabled for (almost) all slab caches, it might
be worth revisiting - e.g. sort objects by slab cache and
pass them to free_to_pcs_bulk() instead of building a detached freelist.

And let __memcg_slab_free_hook() handle objects from the same cache but
from different slabs.

-- 
Cheers,
Harry / Hyeonggon

