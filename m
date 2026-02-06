Return-Path: <cgroups+bounces-13748-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCU0EAg5hmmcLAQAu9opvQ
	(envelope-from <cgroups+bounces-13748-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 19:55:04 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E291024D8
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 19:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB44D307A977
	for <lists+cgroups@lfdr.de>; Fri,  6 Feb 2026 18:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0CC4279FD;
	Fri,  6 Feb 2026 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sitd4Vye"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913873D9043
	for <cgroups@vger.kernel.org>; Fri,  6 Feb 2026 18:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770403936; cv=none; b=Pm2TGP9HBe/eYkZYHIkCRJfN+PGvKy2n5m/u9zunF7z/ZnpFYFpXflXaMOkl1YVHhXxfm3f4bPlOrR4XY7LM1VFejLw0oxhvtgfOhFwQ/P8ZSY1aVGE7LqKCcmxBzyzXb6aERk4S4MlCkmc7fA0U2FUcFdKnIjKOvtQljC5m894=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770403936; c=relaxed/simple;
	bh=f63dsk0wa9kOaQro3oFzPnzpavve7SChOom4RDIoMjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sR7um2xW3EtpCXu7l8ze0HC3xPb12AiR0T+YBfv7RqWMwB+b/rgSKzxqUJFsG9Sbo6x8vfHr7ZaWXdQrRvg60ZqJP1A5KzB+GgyCNHg3arLD07YnNzhx/2LkjCVjMkBDHVgVw7pw/3eGZ32M6MHGjqQSUMM6CctmpmcVuRlB00A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sitd4Vye; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 6 Feb 2026 10:52:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770403933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r7mumZbXKpp+UcC6LYCZ5Q8LNGAoHw/22vUr8wOhvA4=;
	b=sitd4Vye4V/h7qHTBkS38bDEsI6P/BMUzZU1dGeEAQ7LW0tF0D+Xry1ug3ppPBmOqyXrwC
	D/QEjYc8d0wumdHpoeTnUJMnl6As6win53CMiNTMMfcYMZmcmkNwIbLcCqTZl7FzJM52eF
	Bwl6eGOB4b2Q1AbfDVxoZfR38JQX/mQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Bing Jiao <bingjiao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, tj@kernel.org, longman@redhat.com, chenridong@huaweicloud.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v9 2/2] mm/vmscan: select the closest perferred node in
 demote_folio_list()
Message-ID: <aYY39YGAHmF1Oi5H@linux.dev>
References: <20260114070053.2446770-1-bingjiao@google.com>
 <20260114205305.2869796-1-bingjiao@google.com>
 <20260114205305.2869796-3-bingjiao@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114205305.2869796-3-bingjiao@google.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13748-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,oracle.com,suse.cz,google.com,suse.com,cmpxchg.org,bytedance.com,gourry.net,gmail.com,linux.dev,redhat.com,huaweicloud.com,kvack.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 97E291024D8
X-Rspamd-Action: no action

On Wed, Jan 14, 2026 at 08:53:03PM +0000, Bing Jiao wrote:
> The preferred demotion node (migration_target_control.nid) should be the
> one closest to the source node to minimize migration latency.  Currently,
> a discrepancy exists where demote_folio_list() randomly selects an allowed
> node if the preferred node from next_demotion_node() is not set in
> mems_effective.
> 
> To address it, update next_demotion_node() to select a preferred target
> against allowed nodes; and to return the closest demotion target if all
> preferred nodes are not in mems_effective via next_demotion_node().
> 
> It ensures that the preferred demotion target is consistently the closest
> available node to the source node.
> 
> Signed-off-by: Bing Jiao <bingjiao@google.com>

One nit below:

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

[...]

> @@ -320,16 +320,17 @@ void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
>  /**
>   * next_demotion_node() - Get the next node in the demotion path
>   * @node: The starting node to lookup the next node
> + * @allowed_mask: The pointer to allowed node mask
>   *
>   * Return: node id for next memory node in the demotion path hierarchy
>   * from @node; NUMA_NO_NODE if @node is terminal.  This does not keep
>   * @node online or guarantee that it *continues* to be the next demotion
>   * target.
>   */
> -int next_demotion_node(int node)
> +int next_demotion_node(int node, const nodemask_t *allowed_mask)
>  {
>  	struct demotion_nodes *nd;
> -	int target;
> +	nodemask_t mask;
> 
>  	if (!node_demotion)
>  		return NUMA_NO_NODE;
> @@ -344,6 +345,10 @@ int next_demotion_node(int node)
>  	 * node_demotion[] reads need to be consistent.
>  	 */
>  	rcu_read_lock();
> +	/* Filter out nodes that are not in allowed_mask. */
> +	nodes_and(mask, nd->preferred, *allowed_mask);
> +	rcu_read_unlock();
> +
>  	/*
>  	 * If there are multiple target nodes, just select one
>  	 * target node randomly.
> @@ -356,10 +361,16 @@ int next_demotion_node(int node)
>  	 * caching issue, which seems more complicated. So selecting
>  	 * target node randomly seems better until now.
>  	 */
> -	target = node_random(&nd->preferred);
> -	rcu_read_unlock();
> +	if (!nodes_empty(mask))
> +		return node_random(&mask);
> 
> -	return target;
> +	/*
> +	 * Preferred nodes are not in allowed_mask. Filp bits in

Filp -> Flip

> +	 * allowed_mask as used node mask. Then, use it to get the
> +	 * closest demotion target.
> +	 */
> +	nodes_complement(mask, *allowed_mask);
> +	return find_next_best_node(node, &mask);
>  }
> 

