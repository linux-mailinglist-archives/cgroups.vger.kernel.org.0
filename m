Return-Path: <cgroups+bounces-5794-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D90799EC420
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 06:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C58D188B210
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 05:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5E51BEF91;
	Wed, 11 Dec 2024 05:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nRHMXtVh"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D156F30C
	for <cgroups@vger.kernel.org>; Wed, 11 Dec 2024 05:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733893570; cv=none; b=nOqHCpHpclP/2hoscAXlw3FI7w1JyHsinD5O7RCHv569jzACG27REmZ/87xUX3qGOYo/J8tRwkGyqaih9XCjdlLpvriImUHHFh7eD7aNUFwfSPbl4CpNiuSxtxD86sfhhyRNiMPrOZQ6eofIkhHUIB6hNrSMVWbvNaqwb8Fn4Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733893570; c=relaxed/simple;
	bh=o/WWiYugsJIwauItRCFdRG28LLtzcz8vjgTvpF0SxY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRWjRfTqCfqA7LCghwCQ2nvlEchAsRQoreaQoNyiFOnZ2kHPfooW3HVdn9W2qPHjUCaBoyuesiXYkrgq3II3KTyDeYUtnoxAxbhcGM0AiD3PFwxYFukptHccFZ4QFOkU56mP9GzDy/dXAy97VoHHPsHYoqXjI1iCBlPEvtD3Ogs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nRHMXtVh; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 10 Dec 2024 21:06:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733893565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JPb00wfkIgOVCDhI/4b1eMraMt3MwKHLazM/Qku2T0I=;
	b=nRHMXtVhDX2vUhA8f9Nf3P8o6/Kz/krM6cQoAEAksxbK8dsoKeNimZPA3sTZ9CEmQerwsY
	ZMw2aGYVh6tZSyWjTzON9uGhSH8zSeHkpBclvaHQuWchKv/F+mQ0ZzbIF86pY9aJWbh5U6
	9ZT2kecvbzmllwqqCm90pG5Hyrb7y6A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] vmalloc: Account memcg per vmalloc
Message-ID: <txdwd3r7wwyhdntqfzlqrtyoo4hui2ltlhkzi7ysjvhojtgatu@zsk6dkavlgxz>
References: <20241211043252.3295947-1-willy@infradead.org>
 <20241211043252.3295947-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211043252.3295947-2-willy@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 11, 2024 at 04:32:50AM +0000, Matthew Wilcox (Oracle) wrote:
[...]
> +int obj_cgroup_charge_vmalloc(struct obj_cgroup **objcgp,
> +		unsigned int nr_pages, gfp_t gfp)
> +{
> +	struct obj_cgroup *objcg;
> +	int err;
> +
> +	if (mem_cgroup_disabled() || !(gfp & __GFP_ACCOUNT))
> +		return 0;
> +
> +	objcg = current_obj_cgroup();
> +	if (!objcg)
> +		return 0;
> +
> +	err = obj_cgroup_charge_pages(objcg, gfp, nr_pages);
> +	if (err)
> +		return err;
> +	obj_cgroup_get(objcg);
> +	mod_memcg_state(obj_cgroup_memcg(objcg), MEMCG_VMALLOC, nr_pages);

obj_cgroup_memcg() needs to be within rcu. See MEMCG_PERCPU_B as an
example.

> +	*objcgp = objcg;
> +
> +	return 0;
> +}
> +
> +/**
> + * obj_cgroup_uncharge_vmalloc - Uncharge vmalloc memory
> + * @objcg: The object cgroup
> + * @nr_pages: Number of pages
> + */
> +void obj_cgroup_uncharge_vmalloc(struct obj_cgroup *objcg,
> +		unsigned int nr_pages)
> +{
> +	if (!objcg)
> +		return;
> +	mod_memcg_state(objcg->memcg, MEMCG_VMALLOC, 0L - nr_pages);

Please use obj_cgroup_memcg() above instead of objcg->memcg and within
rcu lock.

Overall the patch looks good.

