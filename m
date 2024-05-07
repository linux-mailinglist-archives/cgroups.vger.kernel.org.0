Return-Path: <cgroups+bounces-2821-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EE08BE31A
	for <lists+cgroups@lfdr.de>; Tue,  7 May 2024 15:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08819B26FCA
	for <lists+cgroups@lfdr.de>; Tue,  7 May 2024 13:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5064815DBD1;
	Tue,  7 May 2024 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mEr6vVUy";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mEr6vVUy"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D69315DBC0;
	Tue,  7 May 2024 13:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715087439; cv=none; b=JHmLjxtgsxxTNZ/US8EJA5ja8jLHKgZnbHkQHNHSj8lrLCauHRgy/jq5uwjRDhDQKJegU4r+gNHpobBfnz+2ObNe+reLz4LpQHW/Hk7lGXpnJeEWoXRaNm1GbC/pmoksJf4sm33MzFIH2PtPeyg7WQDKba5aZZxZb9hoZUj8kOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715087439; c=relaxed/simple;
	bh=rCVgSTjqPAd/3KYGkH96DgJEzXYATaywQ/hkyyPZNr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLKwAi7nqduHZ+Rx8u0tV7D3vz3RGmmkZ7JQC7V73RaC87g4/HCSaK4skrM4V1e34j8AQGsRZd5y2HEy586HwFNt3InFaR1E63ikG3nqQc3b0qebA4xKTh7ROcRDi3D0wa9iRoeoQ0IAL5BJmy7pPI5I1cz9DGufaBXCuCET9M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mEr6vVUy; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mEr6vVUy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 53CDA209FA;
	Tue,  7 May 2024 13:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715087435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dAZpLauRUWle98y9NtAQwrBGA7VGXb5wiPKUo7xqrPE=;
	b=mEr6vVUyItkaToAyyFIN+wXb6OaBcJFjk1lmRS4N/iZfs1e6GuPLgw1xqvfIfCFY7rtK6e
	evC25NppBCgUvRo+ou0m1vj7JLTpf4MOA87Gw4an8Kdq8hIu2dRzyaB883aM57RN3E5uVs
	pSuCiifBJkeN811hI2k9Nc7eroOhjbs=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=mEr6vVUy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715087435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dAZpLauRUWle98y9NtAQwrBGA7VGXb5wiPKUo7xqrPE=;
	b=mEr6vVUyItkaToAyyFIN+wXb6OaBcJFjk1lmRS4N/iZfs1e6GuPLgw1xqvfIfCFY7rtK6e
	evC25NppBCgUvRo+ou0m1vj7JLTpf4MOA87Gw4an8Kdq8hIu2dRzyaB883aM57RN3E5uVs
	pSuCiifBJkeN811hI2k9Nc7eroOhjbs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 351A2139CB;
	Tue,  7 May 2024 13:10:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lByMCksoOmZ/IgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 07 May 2024 13:10:35 +0000
Date: Tue, 7 May 2024 15:10:34 +0200
From: Michal Hocko <mhocko@suse.com>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] mm: memcg: make
 alloc_mem_cgroup_per_node_info() return bool
Message-ID: <ZjooSnQ_vS30EXCT@tiehlicka>
References: <20240507110832.1128370-1-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507110832.1128370-1-xiujianfeng@huawei.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 53CDA209FA
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -5.01

On Tue 07-05-24 11:08:32, Xiu Jianfeng wrote:
> Currently alloc_mem_cgroup_per_node_info() returns 1 if failed,
> make it return bool, false for failure and true for success.

This describes what the patch does rather than why it is doing that.
The former is clear from the diff while the motivation for this change
is unclear. I would propose something like:

alloc_mem_cgroup_per_node_info() returns int that doesn't map to any
errno error code. The only existing caller doesn't really need an error
code so change the the function to return bool (true on success) because
this is slightly less confusing and more consistent with the other code.

> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

With changelog clarified feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d11536ef59ef..69d70feb8e68 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5653,13 +5653,13 @@ struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
>  }
>  #endif
>  
> -static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
> +static bool alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
>  {
>  	struct mem_cgroup_per_node *pn;
>  
>  	pn = kzalloc_node(sizeof(*pn), GFP_KERNEL, node);
>  	if (!pn)
> -		return 1;
> +		return false;
>  
>  	pn->lruvec_stats = kzalloc_node(sizeof(struct lruvec_stats), GFP_KERNEL,
>  					node);
> @@ -5675,11 +5675,11 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
>  	pn->memcg = memcg;
>  
>  	memcg->nodeinfo[node] = pn;
> -	return 0;
> +	return true;
>  fail:
>  	kfree(pn->lruvec_stats);
>  	kfree(pn);
> -	return 1;
> +	return false;
>  }
>  
>  static void free_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
> @@ -5751,7 +5751,7 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
>  	}
>  
>  	for_each_node(node)
> -		if (alloc_mem_cgroup_per_node_info(memcg, node))
> +		if (!alloc_mem_cgroup_per_node_info(memcg, node))
>  			goto fail;
>  
>  	if (memcg_wb_domain_init(memcg, GFP_KERNEL))
> -- 
> 2.34.1
> 

-- 
Michal Hocko
SUSE Labs

