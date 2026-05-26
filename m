Return-Path: <cgroups+bounces-16320-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMEUCH6/FWrYZgcAu9opvQ
	(envelope-from <cgroups+bounces-16320-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 17:42:54 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B95285D8F4B
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 17:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 53A2D306485D
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 15:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA2A366065;
	Tue, 26 May 2026 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xi7XAV3l"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85BD30F80C
	for <cgroups@vger.kernel.org>; Tue, 26 May 2026 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809629; cv=none; b=lqzEMu4gnT7MYrXvuAQUpsai6Uc3eu69qKgw7b2xP6HqFA7Z7wdwDCdx+XQnhfT56IpebCygFNRCvMrEtiXWHlhWfOaGQTrd2EOAo2S+0PtX6LsybCvKe2DlW1iWwJOearwYA8Vgrl9W1xPTuW2/6nU5TShxB5UEppGVn1rZj0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809629; c=relaxed/simple;
	bh=xpnjY2kxhcf877bhzUZaTGKn9SA3OCRNvKpGKrLX+NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSDKvUu9TEAtvfFgX/mls9jiVYumW71hh4prlbVlC1EFRkSOhkOnMOGi89y04GKVfbvOnhhdD6b3NHIuaib0utNMwiECwt0+wPnZZ+TgT2w6miEjAq47RAJkr3DqZr0ItWMPxHJhRSbPyeQWUgCCNy0gmWTZR8tKPKFowAtlTBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xi7XAV3l; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 26 May 2026 23:33:37 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779809625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NHV2IZakIJ6ChTDpKQtKC37v7LOZC1b1R6tmDq4OICA=;
	b=Xi7XAV3lh9hYv2hFye5tI8gAsLnnSPo2uW/9r0tMSCh/Kd9CO/NqZYX0/zQtQch+Xf02+m
	tDdsa0IFcReKI/y+7D2fLOL7nESYfktQq5z/ewCd8n800Ht2D8N5M9LUyimL08QfnFdF8c
	GNqblj8Rv4P4X1DQvrp+bSOcQg+AKXk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Baoquan He <baoquan.he@linux.dev>
To: Youngjun Park <youngjun.park@lge.com>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	kasong@tencent.com, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, baohua@kernel.org, gunho.lee@lge.com,
	taejoon.song@lge.com, hyungjun.cho@lge.com, mkoutny@suse.com,
	baver.bae@lge.com, matia.kim@lge.com
Subject: Re: [PATCH v6 3/4] mm: memcontrol: add interfaces for swap tier
 selection
Message-ID: <ahW9UQH93jBT_VaD@MiWiFi-R3L-srv>
References: <20260421055323.940344-1-youngjun.park@lge.com>
 <20260421055323.940344-4-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421055323.940344-4-youngjun.park@lge.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16320-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,redhat.com,lge.com,suse.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baoquan.he@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B95285D8F4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/21/26 at 02:53pm, Youngjun Park wrote:
...snip...
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c3d98ab41f1f..0f67572e5e3e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -68,6 +68,7 @@
>  #include <net/ip.h>
>  #include "slab.h"
>  #include "memcontrol-v1.h"
> +#include "swap_tier.h"
>  
>  #include <linux/uaccess.h>
>  
> @@ -4130,6 +4131,8 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
>  	refcount_set(&memcg->id.ref, 1);
>  	css_get(css);
>  
> +	swap_tiers_memcg_inherit_mask(memcg);
> +
>  	/*
>  	 * Ensure mem_cgroup_from_private_id() works once we're fully online.
>  	 *
> @@ -5667,6 +5670,88 @@ static int swap_events_show(struct seq_file *m, void *v)
>  	return 0;
>  }
>  
> +static int swap_tier_show(struct seq_file *m, void *v)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
> +
> +	swap_tiers_mask_show(m, READ_ONCE(memcg->tier_mask));
> +	return 0;
> +}
> +
> +static ssize_t swap_tier_write(struct kernfs_open_file *of,
> +				char *buf, size_t nbytes, loff_t off)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> +	char *pos, *token;
> +	int ret = 0;
> +	int original_mask = 0;
> +
> +	pos = strstrip(buf);
> +
> +	spin_lock(&swap_tier_lock);
> +	if (!*pos) {
> +		WRITE_ONCE(memcg->tier_mask, TIER_ALL_MASK);
> +		goto sync;
> +	}
> +
> +	original_mask = memcg->tier_mask;
> +
> +	while ((token = strsep(&pos, " \t\n")) != NULL) {
> +		int mask;
> +
> +		if (!*token)
> +			continue;
> +
> +		if (token[0] != '-' && token[0] != '+') {
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +
> +		mask = swap_tiers_mask_lookup(token+1);
> +		if (!mask) {
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +
> +		/*
> +		 * if child already set, cannot add that tiers for hierarch mismatching.
> +		 * parent compatible, child must respect parent selected swap device.
> +		 */

This paragraph of code comment sounds a little unnatural. We are writing
it into memcg, the child memcg is handled in
swap_tiers_memcg_sync_mask(), isn't it? I don't get the 2nd sentence.
Could you help explain?

> +		switch (token[0]) {
> +		case '-':
> +			WRITE_ONCE(memcg->tier_mask,
> +				   memcg->tier_mask & ~mask);
> +			break;
> +		case '+':
> +			WRITE_ONCE(memcg->tier_mask,
> +				   memcg->tier_mask | mask);
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		if (ret)
> +			goto err;
> +	}
> +
> +sync:
> +	swap_tiers_memcg_sync_mask(memcg);
> +err:
> +	if (ret)
> +		WRITE_ONCE(memcg->tier_mask, original_mask);
> +	spin_unlock(&swap_tier_lock);
> +	return ret ? ret : nbytes;
> +}
> +
...snip...

