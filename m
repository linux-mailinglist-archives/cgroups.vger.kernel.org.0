Return-Path: <cgroups+bounces-14908-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MQ2NoGtu2k8mgIAu9opvQ
	(envelope-from <cgroups+bounces-14908-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 09:02:09 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9ED82C79B7
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 09:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B8603151631
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 07:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195043A5437;
	Thu, 19 Mar 2026 07:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kEMuBnl5"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7421E9919
	for <cgroups@vger.kernel.org>; Thu, 19 Mar 2026 07:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773907027; cv=none; b=CNsFE9voDAictUghCnnAWhKoJm9wk7UjruPRSEIJM1fkIUoSqVvWSDLFSO4T93QpWhTOFzokfzyhYE6/UoQSAsWkxupGWymgRyn5z7JLDLEoqqxOfBAeVtoqoIgET0p+m+bDEvr0pXnQv79dzbPLYNqMbvU3bZTMQGsqE0acbeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773907027; c=relaxed/simple;
	bh=EEUWZqus7ucXdk/WFGo+NqdisLQY4Uc9jzC7pUbLM4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rp6mQ4Q5/xClJl5Sc5OgYLPvt3yDydlxsokVpdtBEwtWw+H4MqbH28mHUCfQraOZO2iYrP8oHAhR4MuY4jlOcwu67XF6HhedTAv7OfIerO8brH4N4PdKFAWBwWn/IpTflBtyy9I4+hS6vila7TWcUlNTYdUL7K4lu7XzcLWeSjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kEMuBnl5; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=s8A69keN0dzb00KIbKoLnTjne6XlDApP9njkXdbia9M=; b=kEMuBnl5QdgU2yGgwfMddW2g5p
	VLX/fnB8GUBtoa0nqe9dfZwrYsqfbEz9RB9gGgt/P0dDr2YcnKNxfN/HMD/y21qYcO9V2lGz8QbPV
	s4o1WzhrWSr23X18Whfz38aFl1qyitlAD0ID6MBLNDNHzrDJgQDKDWRVllbg95qKyJ1etUU7ta06+
	Sze/wW8OLJh0rocRdaV0H2nRNLPmarQOJz3a3iCgr6NW2iqrx6D0PhA6AxnCY9aXsFPZ3A4gbvxtx
	dOL4bASOmjGuVvXm4YOz5TYUNRco6AhAc1//laLG7EvTPVHD004g4y6nm+aqaDGYeQbpweoSVQ7wO
	ajBWtQwg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w38Ex-0000000CyQr-2Ztq;
	Thu, 19 Mar 2026 07:56:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F141F301BD5; Thu, 19 Mar 2026 08:56:21 +0100 (CET)
Date: Thu, 19 Mar 2026 08:56:21 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: kasong@tencent.com, Liam.Howlett@oracle.com, akpm@linux-foundation.org,
	apopple@nvidia.com, axelrasmussen@google.com, baohua@kernel.org,
	baolin.wang@linux.alibaba.com, bhe@redhat.com, byungchul@sk.com,
	cgroups@vger.kernel.org, chengming.zhou@linux.dev,
	chrisl@kernel.org, corbet@lwn.net, david@kernel.org,
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org,
	hughd@google.com, jannh@google.com, joshua.hahnjy@gmail.com,
	lance.yang@linux.dev, lenb@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com,
	matthew.brost@intel.com, mhocko@suse.com, muchun.song@linux.dev,
	npache@redhat.com, pavel@kernel.org, peterx@redhat.com,
	pfalcato@suse.de, rafael@kernel.org, rakie.kim@sk.com,
	roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com,
	shakeel.butt@linux.dev, shikemeng@huaweicloud.com,
	surenb@google.com, tglx@kernel.org, vbabka@suse.cz,
	weixugc@google.com, ying.huang@linux.alibaba.com,
	yosry.ahmed@linux.dev, yuanchu@google.com,
	zhengqi.arch@bytedance.com, ziy@nvidia.com, kernel-team@meta.com,
	riel@surriel.com
Subject: Re: [PATCH v4 09/21] mm: swap: allocate a virtual swap slot for each
 swapped out page
Message-ID: <20260319075621.GR3738010@noisy.programming.kicks-ass.net>
References: <20260318222953.441758-1-nphamcs@gmail.com>
 <20260318222953.441758-10-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318222953.441758-10-nphamcs@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[tencent.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	TAGGED_FROM(0.00)[bounces-14908-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[53];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.974];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim,noisy.programming.kicks-ass.net:mid]
X-Rspamd-Queue-Id: C9ED82C79B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 03:29:40PM -0700, Nhat Pham wrote:
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 62cd7b35a29c9..85cb45022e796 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -86,6 +86,7 @@ enum cpuhp_state {
>  	CPUHP_FS_BUFF_DEAD,
>  	CPUHP_PRINTK_DEAD,
>  	CPUHP_MM_MEMCQ_DEAD,
> +	CPUHP_MM_VSWAP_DEAD,
>  	CPUHP_PERCPU_CNT_DEAD,
>  	CPUHP_RADIX_DEAD,
>  	CPUHP_PAGE_ALLOC,

> +static int vswap_cpu_dead(unsigned int cpu)
> +{
> +	struct vswap_cluster *cluster;
> +	int order;
> +
> +	rcu_read_lock();

nit:
	guard(rcu)();

> +	for (order = 0; order < SWAP_NR_ORDERS; order++) {
> +		cluster = per_cpu(percpu_vswap_cluster.clusters[order], cpu);
> +		if (cluster) {
> +			per_cpu(percpu_vswap_cluster.clusters[order], cpu) = NULL;
> +			spin_lock(&cluster->lock);

This breaks on PREEMPT_RT as this is ran with IRQs disabled. This must
be a raw_spinlock_t.

> +			cluster->cached = false;
> +			if (refcount_dec_and_test(&cluster->refcnt))
> +				vswap_cluster_free(cluster);

And this... below.

> +			spin_unlock(&cluster->lock);
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	return 0;
> +}

> +static void vswap_cluster_free(struct vswap_cluster *cluster)
> +{
> +	VM_WARN_ON(cluster->count || cluster->cached);
> +	VM_WARN_ON(!spin_is_locked(&cluster->lock));

This is terrible, please use:

	lockdep_assert_held(&cluster->lock);

> +	xa_lock(&vswap_cluster_map);

This is again broken, this cannot be from a DEAD callback with IRQs
disabled.

> +	list_del_init(&cluster->list);
> +	__xa_erase(&vswap_cluster_map, cluster->id);

Strictly speaking this can end up in xas_alloc(), which is again, not
allowed in a DEAD callback.

> +	xa_unlock(&vswap_cluster_map);
> +	rcu_head_init(&cluster->rcu);
> +	kvfree_rcu(cluster, rcu);
> +}


