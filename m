Return-Path: <cgroups+bounces-7671-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6309A94529
	for <lists+cgroups@lfdr.de>; Sat, 19 Apr 2025 20:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7233B18964E1
	for <lists+cgroups@lfdr.de>; Sat, 19 Apr 2025 18:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B89D1DF755;
	Sat, 19 Apr 2025 18:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wb8VTJLX"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC7E4207F
	for <cgroups@vger.kernel.org>; Sat, 19 Apr 2025 18:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745088540; cv=none; b=ZpJIcpjvYVBt4RcUUpl4tdJ4gzE6w1InKiwKLIG5CruUSV6NDIpAlZizOHdY5se4Q4wgP3q2A61D9hDPqyQ0HBzATFJmBQU9qk65TT0VK3AIBcVIG++5YynG5r16BMl8SPEi1j2JNN1bUG58TpfvWpQ+O7YSu/LzCzilerpA/+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745088540; c=relaxed/simple;
	bh=24eD9HsUZ7vKwgeNXnA/D+RAVe2asRJVKU/aPVQYrRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D89Ct7JpEtfngk8ucNnYQVBVjNTwqgqtqNO31IfYf68PS9ixDScc+mv+0ciFKgvKZ1ft6EoEpc3Iqx7j22wms5d04nybDcGuKkxL/f2vY1BuJ7SL+4wGJ4gIuAPtlPCLdY2ByMfHHeR6PaZEE8cRtHrY5HzSaEAf3Y+rMVw6oKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wb8VTJLX; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 19 Apr 2025 11:48:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745088535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ApAd7dHfvc/cXoQ6QveWIWCoCJKlspxr8Ja20JxbU3M=;
	b=Wb8VTJLXN2S0qzIP1vjKMSyk03NWvsDhyJfUYQruSzn/bgkivRhLO8BYf5vMgt/iz8grsL
	8mj6Zew7eGxb911EDcYjR5r6+5W07YHSR1HZPXCcOCCE5EyHQrvRU7f+4ATD7vVtjBAPYj
	WPSOi5mVXY7oFKE3dAIphm8V7HVSSqs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, longman@redhat.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev, tj@kernel.org, 
	mkoutny@suse.com, akpm@linux-foundation.org
Subject: Re: [PATCH v3 2/2] vmscan,cgroup: apply mems_effective to reclaim
Message-ID: <ro3uqeyri65voutamqttzipfk7yiya4zv5kdiudcmhacrm6tej@br7ebk2kanf4>
References: <20250419053824.1601470-1-gourry@gourry.net>
 <20250419053824.1601470-3-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250419053824.1601470-3-gourry@gourry.net>
X-Migadu-Flow: FLOW_OUT

On Sat, Apr 19, 2025 at 01:38:24AM -0400, Gregory Price wrote:
>  
> +bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
> +{
> +	struct cgroup_subsys_state *css;
> +	unsigned long flags;
> +	struct cpuset *cs;
> +	bool allowed;
> +
> +	css = cgroup_get_e_css(cgroup, &cpuset_cgrp_subsys);
> +	if (!css)
> +		return true;
> +
> +	cs = container_of(css, struct cpuset, css);
> +	spin_lock_irqsave(&callback_lock, flags);

Do we really need callback_lock here? We are not modifying and I am
wondering if simple rcu read lock is enough here (similar to
update_nodemasks_hier() where parent's effective_mems is accessed within
rcu read lock).

> +	/* On v1 effective_mems may be empty, simply allow */
> +	allowed = node_isset(nid, cs->effective_mems) ||
> +		  nodes_empty(cs->effective_mems);
> +	spin_unlock_irqrestore(&callback_lock, flags);
> +	css_put(css);
> +	return allowed;
> +}

