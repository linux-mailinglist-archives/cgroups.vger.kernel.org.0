Return-Path: <cgroups+bounces-15135-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kH7CGsbpy2myMQYAu9opvQ
	(envelope-from <cgroups+bounces-15135-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 17:35:34 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C1A36BCAE
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 17:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D820230466D3
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 15:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A1D41C314;
	Tue, 31 Mar 2026 15:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sKZGMqC/"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0069D41C2EF
	for <cgroups@vger.kernel.org>; Tue, 31 Mar 2026 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971179; cv=none; b=qVYNc1opYzEE5/61fdRmZGOymVa2ZUDBtN6ckHcwU/w0V5dK33e8yj38DuZuxtveZ0VK6xQ6X79a1tKtInA5QDuwgKLrLwwtAPUcPdU6bgNnU7iW8IhIRaanuz56xFEVtVxO/MgIlbY+O1RLYyAGMpzNnksFn3mgEc8RBIuC+j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971179; c=relaxed/simple;
	bh=y3fTQJT1tsbjISezoUHGQk1DRsrJs2b1clxEm1dfFs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPCgsuf8dSawDw+GnUS7WiCswpIkV2NsQdRdAvivtYrZpvxBbx8HVLs+g7CGAyUHVV/lyXYh7dpvgQradvfIWHuoJtUK6kffICbN//QnW7KfADhwU/G0IXFHjZyhJpW5yLeg4toS9r21BzRpwxf3Bx2tiYgh8kIKtd6wySHkjlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sKZGMqC/; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 31 Mar 2026 08:32:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774971158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t+C4y+Sd7HEYKiCpd074wxzMXELc1k81DcNxRvKzgNU=;
	b=sKZGMqC/Uvyj61yMCKaL651i5TTogdGlkkt7N3+McpC8oWHRAfvawOHR9ZUzGkxR1tcS4b
	zPGenokao5vS5odsctcupTepRR8NMQrqSRcQdL7U7DQrRjHC/g3fLxaJ5qk0MrOConMCNF
	/HnxTf+ZV1Z2k7OhTO/DDr7ARMYddRM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [PATCH mm-stable v3] mm/memcontrol: batch memcg charging in
 __memcg_slab_post_alloc_hook
Message-ID: <acvnjCr26zpQUW0h@linux.dev>
References: <20260331091707.226786-1-hui.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331091707.226786-1-hui.zhu@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15135-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Queue-Id: 42C1A36BCAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 05:17:07PM +0800, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> When kmem_cache_alloc_bulk() allocates multiple objects, the post-alloc
> hook __memcg_slab_post_alloc_hook() previously charged memcg one object
> at a time, even though consecutive objects may reside on slabs backed by
> the same pgdat node.
> 
> Batch the memcg charging by scanning ahead from the current position to
> find a contiguous run of objects whose slabs share the same pgdat, then
> issue a single __obj_cgroup_charge() / __consume_obj_stock() call for
> the entire run. The per-object obj_ext assignment loop is preserved as-is
> since it cannot be further collapsed.
> 
> This implements the TODO comment left in commit bc730030f956 ("memcg:
> combine slab obj stock charging and accounting").
> 
> The existing error-recovery contract is unchanged: if size == 1 then
> memcg_alloc_abort_single() will free the sole object, and for larger
> bulk allocations kmem_cache_free_bulk() will uncharge any objects that
> were already charged before the failure.
> 
> Benchmark using kmem_cache_alloc_bulk() with SLAB_ACCOUNT
> (iters=100000):
> 
>   bulk=32  before: 215 ns/object   after: 174 ns/object  (-19%)
>   bulk=1   before: 344 ns/object   after: 335 ns/object  (  ~)
> 
> No measurable regression for bulk=1, as expected.
> 
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>

Do we have an actual user of kmem_cache_alloc_bulk(GFP_ACCOUNT) in kernel? If
yes, can you please benchmark that usage? Otherwise can we please wait for an
actual user before adding more complexity? Or you can look for opportunities
for kmem_cache_alloc_bulk(GFP_ACCOUNT) users and add the optimization along with
the user.

Have you looked at the bulk free side? I think we already have rcu freeing in
bulk as a user. Did you find any opportunities in optimizing the
__memcg_slab_free_hook() from bulk free?


