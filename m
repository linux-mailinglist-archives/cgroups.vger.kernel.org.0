Return-Path: <cgroups+bounces-13884-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMMbOl+BjWn93QAAu9opvQ
	(envelope-from <cgroups+bounces-13884-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 08:29:35 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6139412AF37
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 08:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA25A30616C2
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 07:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A952BF3F4;
	Thu, 12 Feb 2026 07:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H4RmVW/h"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33842BD5BB
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 07:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770881371; cv=none; b=QPeWWLqZYWFY1v3c7qJbwovjAB9EouDyo2pUvC3je+82xlcFtcqRlTP31BWV5/+8KHkRMCIJLFj0aLDrczJFE2FLZBl8jHAZwIu5HzOBYVNUyMgAeh7zrhw4ubqU+YRPb4AUCmQncRDLZ47jrDlEXjMv5PzraZSroq51cNaC/bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770881371; c=relaxed/simple;
	bh=OXnMiWI0fnYRPjEEH6nfYgcL2OAEUU7y990o6OqVNjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdGaUwRv0wNfzkrw2J61tF4+/17QAMqjkyVGBkybcDW8rBot4PLRvtVgkloNb6EX3fr8QG3IyyWT0YGW2q7e70oShTHd2u+ev1Ofqf/acvn+woH+ePEWa5K8d8BRlMSHC8sVdFl+76HudLZxrUxFW21z+OzPws67PFLfXY9LnOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H4RmVW/h; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-48039fdc8aeso17836075e9.3
        for <cgroups@vger.kernel.org>; Wed, 11 Feb 2026 23:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770881368; x=1771486168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=587vbBvDprUYK6+gAj7UCfYA0MqK2wMUAauQ0TnCSkk=;
        b=H4RmVW/h46SZORRAHoyh3LxpeHMIdSpQrMYXOvWupl2aXwsuel3N73IwAogiCH/CwM
         n1h52upcdAEJ5lMujWx6hk2BsESZiBwbZw5BknKXdZNAxAeVz0tvsxu16LtYQE2FEbYR
         x6IR+fSi+X3v8N6xgmxD/bdIZjAQ9P4DPCTT4MTM5jfo15WXFm8JqtbdlyhPncmQGH9a
         KkYc7gyG7P5eee9S40ataTGFARzKAfJv2H+0WmOfFWCHwDz7rE6hj5rChgHLJM9NxtgX
         gEuqo8YWZuEFcwPz7Tk91X+33DIP0mKIKWNo2nKJZP4zRURPzNXEOn9NmkDssV1TGzm0
         6f1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770881368; x=1771486168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=587vbBvDprUYK6+gAj7UCfYA0MqK2wMUAauQ0TnCSkk=;
        b=D7+mdgiVzC1V6NVUHHDNjgiYWzqYWwyo7nfCmtfHHMbhKuZITz+xBP2PQqu167TUT3
         CKoYq/fFodXC4GX0yZ2vG9l7j1bbWV4TVAbV92zIZ8XssAvsuREpRCe08ebBEODOKl0y
         aQNqHaVjtH+qF00zzCeJ2cbfvcH3MMUkVTFs7m933WgiTvPK3rStsWH9QPfAtVFRQfel
         72Pgs0+1hCbeSXNZyAM8DG/M4WSrtnURP8XYGguO3BKuymC76XxRAJs7wyvWSVNaoeCM
         LbWHKEoA1pQkrZ/deuGQvSle702SdFom/KmrxMQlw7nn6BhT825hUnD43+iNs1INIO0S
         /J4w==
X-Forwarded-Encrypted: i=1; AJvYcCWKCi6nbxQn++a7rv15WaY5/5ovQct1CsIpzAMzW0WZ8Hc1p27eH/+zegwAEqcwVB8TMXLF3bHs@vger.kernel.org
X-Gm-Message-State: AOJu0YyvMgUYGzMT14VGHsVDvqJcUsk8ZbFK2o/ImV3Qh8gIFXSL8NRG
	yGKq0KdBYDly8qkK/kG/0kZh3MnNJZxu9TLRYCLm9xOn9qo8CoOrIL2q493EInn1nV4=
X-Gm-Gg: AZuq6aIC1MRVIg1347ammcYBdVTo8gcbBwIWSsDtVSfdkpods0FxAvEpuF1wWvA5XGO
	Qqs8KG9za35eUIJYeMGXOyUpv6Pl5+V3xyqIBpXcPj8VEcbR04q78nvBQ5ZxrSzQA4oHKnPswHV
	2K5Uw2MAs8M/tes8vJ3C0JI+ESMeQ4ANpg0ff+JZwQ6mIz5XbZFpuFkOE8kbM1xai5qHye8eAqy
	mo2hvlPS3G5XXSgsJq7yYz4DYoPZDuuVvJj7UJZmHx9ZO/OkohW5mtpB6/u0roMaIV5VW8GFKhX
	y+iA5DP08VcdolP4a/V1KvSKqghCCeJUUmHq069tlYq4c9v1FrXG38PCZCw6RoS6b8WngJ/oOdk
	xcLVUFfogJbxMQMXOPZhms26whu0eDnuOqalRVikOSZovEG6pH6fbEhubfbsM4wssnAq0e0Yt5R
	jnKZx/DFXrFfTyMZWIHOAW9+XJ/lHZYoJMJU1Z
X-Received: by 2002:a05:600c:3f06:b0:477:73e9:dc17 with SMTP id 5b1f17b1804b1-4836717f09fmr15988475e9.35.1770881368188;
        Wed, 11 Feb 2026 23:29:28 -0800 (PST)
Received: from localhost (109-81-87-131.rct.o2.cz. [109.81.87.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835b9768c9sm69077875e9.2.2026.02.11.23.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 23:29:27 -0800 (PST)
Date: Thu, 12 Feb 2026 08:29:26 +0100
From: Michal Hocko <mhocko@suse.com>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: linux-mm@kvack.org, apopple@nvidia.com, akpm@linux-foundation.org,
	axelrasmussen@google.com, byungchul@sk.com, cgroups@vger.kernel.org,
	david@kernel.org, eperezma@redhat.com, gourry@gourry.net,
	jasowang@redhat.com, hannes@cmpxchg.org, joshua.hahnjy@gmail.com,
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com, matthew.brost@intel.com, mst@redhat.com,
	rppt@kernel.org, muchun.song@linux.dev, zhengqi.arch@bytedance.com,
	rakie.kim@sk.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	surenb@google.com, virtualization@lists.linux.dev, vbabka@suse.cz,
	weixugc@google.com, xuanzhuo@linux.alibaba.com,
	ying.huang@linux.alibaba.com, yuanchu@google.com, ziy@nvidia.com,
	kernel-team@meta.com
Subject: Re: [PATCH 2/2] mm: move pgscan and pgsteal to node stats
Message-ID: <aY2BVsYlPa4QMbUC@tiehlicka>
References: <20260212045109.255391-1-inwardvessel@gmail.com>
 <20260212045109.255391-3-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212045109.255391-3-inwardvessel@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13884-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[kvack.org,nvidia.com,linux-foundation.org,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,linux.dev,bytedance.com,lists.linux.dev,suse.cz,linux.alibaba.com,meta.com];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cmpxchg.org:email,suse.com:dkim]
X-Rspamd-Queue-Id: 6139412AF37
X-Rspamd-Action: no action

On Wed 11-02-26 20:51:09, JP Kobryn wrote:
> It would be useful to narrow down reclaim to specific nodes.
> 
> Provide per-node reclaim visibility by changing the pgscan and pgsteal
> stats from global vm_event_item's to node_stat_item's. Note this change has
> the side effect of now tracking these stats on a per-memcg basis.

The changelog could have been more clear about the actual changes as
this is not overly clear for untrained eyes. The most important parts
are that /proc/vmstat will preserve reclaim stats with slightly
different counters ordering (shouldn't break userspace much^W), per-node
stats will be now newly displayed in /proc/zoneinfo - this is presumably
the primary motivation to have a better insight of per-node reclaim
activity, and memcg stats will now show their share of the global memory
reclaim.

Have I missed anything?

> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  drivers/virtio/virtio_balloon.c |  8 ++++----
>  include/linux/mmzone.h          | 12 +++++++++++
>  include/linux/vm_event_item.h   | 12 -----------
>  mm/memcontrol.c                 | 36 ++++++++++++++++++---------------
>  mm/vmscan.c                     | 32 +++++++++++------------------
>  mm/vmstat.c                     | 24 +++++++++++-----------
>  6 files changed, 60 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 74fe59f5a78c..1341d9d1a2a1 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -374,13 +374,13 @@ static inline unsigned int update_balloon_vm_stats(struct virtio_balloon *vb)
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_ALLOC_STALL, stall);
>  
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_ASYNC_SCAN,
> -		    pages_to_bytes(events[PGSCAN_KSWAPD]));
> +		    pages_to_bytes(global_node_page_state(PGSCAN_KSWAPD)));
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_DIRECT_SCAN,
> -		    pages_to_bytes(events[PGSCAN_DIRECT]));
> +		    pages_to_bytes(global_node_page_state(PGSCAN_DIRECT)));
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_ASYNC_RECLAIM,
> -		    pages_to_bytes(events[PGSTEAL_KSWAPD]));
> +		    pages_to_bytes(global_node_page_state(PGSTEAL_KSWAPD)));
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_DIRECT_RECLAIM,
> -		    pages_to_bytes(events[PGSTEAL_DIRECT]));
> +		    pages_to_bytes(global_node_page_state(PGSTEAL_DIRECT)));
>  
>  #ifdef CONFIG_HUGETLB_PAGE
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGALLOC,
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 762609d5f0af..fc39c107a4b5 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -255,6 +255,18 @@ enum node_stat_item {
>  	PGDEMOTE_DIRECT,
>  	PGDEMOTE_KHUGEPAGED,
>  	PGDEMOTE_PROACTIVE,
> +	PGSTEAL_KSWAPD,
> +	PGSTEAL_DIRECT,
> +	PGSTEAL_KHUGEPAGED,
> +	PGSTEAL_PROACTIVE,
> +	PGSTEAL_ANON,
> +	PGSTEAL_FILE,
> +	PGSCAN_KSWAPD,
> +	PGSCAN_DIRECT,
> +	PGSCAN_KHUGEPAGED,
> +	PGSCAN_PROACTIVE,
> +	PGSCAN_ANON,
> +	PGSCAN_FILE,
>  #ifdef CONFIG_NUMA
>  	PGALLOC_MPOL_DEFAULT,
>  	PGALLOC_MPOL_PREFERRED,
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index 92f80b4d69a6..6f1787680658 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -40,19 +40,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  		PGLAZYFREED,
>  		PGREFILL,
>  		PGREUSE,
> -		PGSTEAL_KSWAPD,
> -		PGSTEAL_DIRECT,
> -		PGSTEAL_KHUGEPAGED,
> -		PGSTEAL_PROACTIVE,
> -		PGSCAN_KSWAPD,
> -		PGSCAN_DIRECT,
> -		PGSCAN_KHUGEPAGED,
> -		PGSCAN_PROACTIVE,
>  		PGSCAN_DIRECT_THROTTLE,
> -		PGSCAN_ANON,
> -		PGSCAN_FILE,
> -		PGSTEAL_ANON,
> -		PGSTEAL_FILE,
>  #ifdef CONFIG_NUMA
>  		PGSCAN_ZONE_RECLAIM_SUCCESS,
>  		PGSCAN_ZONE_RECLAIM_FAILED,
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 86f43b7e5f71..bde0b6536be6 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -328,6 +328,18 @@ static const unsigned int memcg_node_stat_items[] = {
>  	PGDEMOTE_DIRECT,
>  	PGDEMOTE_KHUGEPAGED,
>  	PGDEMOTE_PROACTIVE,
> +	PGSTEAL_KSWAPD,
> +	PGSTEAL_DIRECT,
> +	PGSTEAL_KHUGEPAGED,
> +	PGSTEAL_PROACTIVE,
> +	PGSTEAL_ANON,
> +	PGSTEAL_FILE,
> +	PGSCAN_KSWAPD,
> +	PGSCAN_DIRECT,
> +	PGSCAN_KHUGEPAGED,
> +	PGSCAN_PROACTIVE,
> +	PGSCAN_ANON,
> +	PGSCAN_FILE,
>  #ifdef CONFIG_HUGETLB_PAGE
>  	NR_HUGETLB,
>  #endif
> @@ -441,14 +453,6 @@ static const unsigned int memcg_vm_event_stat[] = {
>  #endif
>  	PSWPIN,
>  	PSWPOUT,
> -	PGSCAN_KSWAPD,
> -	PGSCAN_DIRECT,
> -	PGSCAN_KHUGEPAGED,
> -	PGSCAN_PROACTIVE,
> -	PGSTEAL_KSWAPD,
> -	PGSTEAL_DIRECT,
> -	PGSTEAL_KHUGEPAGED,
> -	PGSTEAL_PROACTIVE,
>  	PGFAULT,
>  	PGMAJFAULT,
>  	PGREFILL,
> @@ -1496,15 +1500,15 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
>  
>  	/* Accumulated memory events */
>  	seq_buf_printf(s, "pgscan %lu\n",
> -		       memcg_events(memcg, PGSCAN_KSWAPD) +
> -		       memcg_events(memcg, PGSCAN_DIRECT) +
> -		       memcg_events(memcg, PGSCAN_PROACTIVE) +
> -		       memcg_events(memcg, PGSCAN_KHUGEPAGED));
> +		       memcg_page_state(memcg, PGSCAN_KSWAPD) +
> +		       memcg_page_state(memcg, PGSCAN_DIRECT) +
> +		       memcg_page_state(memcg, PGSCAN_PROACTIVE) +
> +		       memcg_page_state(memcg, PGSCAN_KHUGEPAGED));
>  	seq_buf_printf(s, "pgsteal %lu\n",
> -		       memcg_events(memcg, PGSTEAL_KSWAPD) +
> -		       memcg_events(memcg, PGSTEAL_DIRECT) +
> -		       memcg_events(memcg, PGSTEAL_PROACTIVE) +
> -		       memcg_events(memcg, PGSTEAL_KHUGEPAGED));
> +		       memcg_page_state(memcg, PGSTEAL_KSWAPD) +
> +		       memcg_page_state(memcg, PGSTEAL_DIRECT) +
> +		       memcg_page_state(memcg, PGSTEAL_PROACTIVE) +
> +		       memcg_page_state(memcg, PGSTEAL_KHUGEPAGED));
>  
>  	for (i = 0; i < ARRAY_SIZE(memcg_vm_event_stat); i++) {
>  #ifdef CONFIG_MEMCG_V1
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 614ccf39fe3f..16a0f21e3ea1 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1977,7 +1977,7 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
>  	unsigned long nr_taken;
>  	struct reclaim_stat stat;
>  	bool file = is_file_lru(lru);
> -	enum vm_event_item item;
> +	enum node_stat_item item;
>  	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>  	bool stalled = false;
>  
> @@ -2003,10 +2003,8 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
>  
>  	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, nr_taken);
>  	item = PGSCAN_KSWAPD + reclaimer_offset(sc);
> -	if (!cgroup_reclaim(sc))
> -		__count_vm_events(item, nr_scanned);
> -	count_memcg_events(lruvec_memcg(lruvec), item, nr_scanned);
> -	__count_vm_events(PGSCAN_ANON + file, nr_scanned);
> +	mod_lruvec_state(lruvec, item, nr_scanned);
> +	mod_lruvec_state(lruvec, PGSCAN_ANON + file, nr_scanned);
>  
>  	spin_unlock_irq(&lruvec->lru_lock);
>  
> @@ -2023,10 +2021,8 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
>  					stat.nr_demoted);
>  	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
>  	item = PGSTEAL_KSWAPD + reclaimer_offset(sc);
> -	if (!cgroup_reclaim(sc))
> -		__count_vm_events(item, nr_reclaimed);
> -	count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
> -	__count_vm_events(PGSTEAL_ANON + file, nr_reclaimed);
> +	mod_lruvec_state(lruvec, item, nr_reclaimed);
> +	mod_lruvec_state(lruvec, PGSTEAL_ANON + file, nr_reclaimed);
>  
>  	lru_note_cost_unlock_irq(lruvec, file, stat.nr_pageout,
>  					nr_scanned - nr_reclaimed);
> @@ -4536,7 +4532,7 @@ static int scan_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
>  {
>  	int i;
>  	int gen;
> -	enum vm_event_item item;
> +	enum node_stat_item item;
>  	int sorted = 0;
>  	int scanned = 0;
>  	int isolated = 0;
> @@ -4595,13 +4591,11 @@ static int scan_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
>  	}
>  
>  	item = PGSCAN_KSWAPD + reclaimer_offset(sc);
> -	if (!cgroup_reclaim(sc)) {
> -		__count_vm_events(item, isolated);
> +	if (!cgroup_reclaim(sc))
>  		__count_vm_events(PGREFILL, sorted);
> -	}
> -	count_memcg_events(memcg, item, isolated);
> +	mod_lruvec_state(lruvec, item, isolated);
>  	count_memcg_events(memcg, PGREFILL, sorted);
> -	__count_vm_events(PGSCAN_ANON + type, isolated);
> +	mod_lruvec_state(lruvec, PGSCAN_ANON + type, isolated);
>  	trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, scan_batch,
>  				scanned, skipped, isolated,
>  				type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
> @@ -4686,7 +4680,7 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
>  	LIST_HEAD(clean);
>  	struct folio *folio;
>  	struct folio *next;
> -	enum vm_event_item item;
> +	enum node_stat_item item;
>  	struct reclaim_stat stat;
>  	struct lru_gen_mm_walk *walk;
>  	bool skip_retry = false;
> @@ -4750,10 +4744,8 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
>  					stat.nr_demoted);
>  
>  	item = PGSTEAL_KSWAPD + reclaimer_offset(sc);
> -	if (!cgroup_reclaim(sc))
> -		__count_vm_events(item, reclaimed);
> -	count_memcg_events(memcg, item, reclaimed);
> -	__count_vm_events(PGSTEAL_ANON + type, reclaimed);
> +	mod_lruvec_state(lruvec, item, reclaimed);
> +	mod_lruvec_state(lruvec, PGSTEAL_ANON + type, reclaimed);
>  
>  	spin_unlock_irq(&lruvec->lru_lock);
>  
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 74e0ddde1e93..e4b259989d58 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1291,6 +1291,18 @@ const char * const vmstat_text[] = {
>  	[I(PGDEMOTE_DIRECT)]			= "pgdemote_direct",
>  	[I(PGDEMOTE_KHUGEPAGED)]		= "pgdemote_khugepaged",
>  	[I(PGDEMOTE_PROACTIVE)]			= "pgdemote_proactive",
> +	[I(PGSTEAL_KSWAPD)]			= "pgsteal_kswapd",
> +	[I(PGSTEAL_DIRECT)]			= "pgsteal_direct",
> +	[I(PGSTEAL_KHUGEPAGED)]			= "pgsteal_khugepaged",
> +	[I(PGSTEAL_PROACTIVE)]			= "pgsteal_proactive",
> +	[I(PGSTEAL_ANON)]			= "pgsteal_anon",
> +	[I(PGSTEAL_FILE)]			= "pgsteal_file",
> +	[I(PGSCAN_KSWAPD)]			= "pgscan_kswapd",
> +	[I(PGSCAN_DIRECT)]			= "pgscan_direct",
> +	[I(PGSCAN_KHUGEPAGED)]			= "pgscan_khugepaged",
> +	[I(PGSCAN_PROACTIVE)]			= "pgscan_proactive",
> +	[I(PGSCAN_ANON)]			= "pgscan_anon",
> +	[I(PGSCAN_FILE)]			= "pgscan_file",
>  #ifdef CONFIG_NUMA
>  	[I(PGALLOC_MPOL_DEFAULT)]		= "pgalloc_mpol_default",
>  	[I(PGALLOC_MPOL_PREFERRED)]		= "pgalloc_mpol_preferred",
> @@ -1344,19 +1356,7 @@ const char * const vmstat_text[] = {
>  
>  	[I(PGREFILL)]				= "pgrefill",
>  	[I(PGREUSE)]				= "pgreuse",
> -	[I(PGSTEAL_KSWAPD)]			= "pgsteal_kswapd",
> -	[I(PGSTEAL_DIRECT)]			= "pgsteal_direct",
> -	[I(PGSTEAL_KHUGEPAGED)]			= "pgsteal_khugepaged",
> -	[I(PGSTEAL_PROACTIVE)]			= "pgsteal_proactive",
> -	[I(PGSCAN_KSWAPD)]			= "pgscan_kswapd",
> -	[I(PGSCAN_DIRECT)]			= "pgscan_direct",
> -	[I(PGSCAN_KHUGEPAGED)]			= "pgscan_khugepaged",
> -	[I(PGSCAN_PROACTIVE)]			= "pgscan_proactive",
>  	[I(PGSCAN_DIRECT_THROTTLE)]		= "pgscan_direct_throttle",
> -	[I(PGSCAN_ANON)]			= "pgscan_anon",
> -	[I(PGSCAN_FILE)]			= "pgscan_file",
> -	[I(PGSTEAL_ANON)]			= "pgsteal_anon",
> -	[I(PGSTEAL_FILE)]			= "pgsteal_file",
>  
>  #ifdef CONFIG_NUMA
>  	[I(PGSCAN_ZONE_RECLAIM_SUCCESS)]	= "zone_reclaim_success",
> -- 
> 2.47.3
> 

-- 
Michal Hocko
SUSE Labs

