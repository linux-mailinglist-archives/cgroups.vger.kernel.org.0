Return-Path: <cgroups+bounces-16122-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Cn7CJGADWosyAUAu9opvQ
	(envelope-from <cgroups+bounces-16122-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 11:36:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B10F758ADF2
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 11:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14E5C301954A
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 09:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606133C9EEF;
	Wed, 20 May 2026 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GetjQ/uU"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A910C3A4F51;
	Wed, 20 May 2026 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779269738; cv=none; b=RUhQG8dXPnsMqwiWQ3Wfrm+9q+/H9URlWIvI7k6YZauK1xTao9wEQ0Vubw8L30vQIWlKPRNpivKOfaw8Ku6UTRiuD4Xtfoqc3gzbjMA1gwSb/N//MyTe+Kr7t+SGGgD3pR7Lery6xh9Oe6+2Yj2Tjk8WzRKTZFizZ2/tPWjMAIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779269738; c=relaxed/simple;
	bh=gPa4LfxMsVgEEYah2FCalbzmj6BE/lExGX0MWgsjCIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ihUv6ws4jmO049yyDdaBMf+7MEOFn0X2iO/yKcekASD03eB3UnhDbPzfR904HZ/UQq9S/8Rn8vQJNq0NEf5SSvaArnevm68qTo+zM9UsLOp/42++gFCWKJMDLUQ7eXL3MQAnboU8rKkzB9DHVgZvoLzS3/fKj2P1AcU0ShFhsuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GetjQ/uU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48E41F000E9;
	Wed, 20 May 2026 09:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779269735;
	bh=cKQ8TEy4a/F3xgQZDjI4b33O37xBHC3B7sYri3TaWOE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GetjQ/uUxGQgtxfzq+bLELhGxJlEL0BVV0+a8LUQgyPJ3AEyqrBND1etreZRkq8ZL
	 20qfHoY1y4dT1DYsR8cp2k7AGGPczNbv0JeUp12TxGJZKXu6MFRZBU0P02+JUifixp
	 bBaeGTe2q4gxahkVNvRP8alEP+x3AeFii0RE9Jj7Mq2UVfKJujaKIxy255sm7J6tps
	 JeLYFmsmnoolpvXsYYrB09OcH266m9xHJKZUDlUH+gx/CsIlpX2OGd2RTfl46CCnNC
	 WNnoGjWlEd0ZOj7v+FWkDSE2yR52+88zQf+z+jPHaBdYK9vplZwOu9BitMhaww8gTP
	 nmEkJG02q872Q==
Message-ID: <4e20f643-6983-4b6e-b12d-c6c4eb20ae0c@kernel.org>
Date: Wed, 20 May 2026 18:35:30 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] memcg: multi objcg charge support
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
 Alexandre Ghiti <alex@ghiti.fr>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>
References: <20260520053123.2709959-1-shakeel.butt@linux.dev>
 <20260520053123.2709959-5-shakeel.butt@linux.dev>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260520053123.2709959-5-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16122-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,ghiti.fr,gmail.com,meta.com,kvack.org,vger.kernel.org,intel.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,linux.dev:email]
X-Rspamd-Queue-Id: B10F758ADF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/20/26 2:31 PM, Shakeel Butt wrote:
> Commit 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg
> per-node type") split a memcg's single obj_cgroup into one per NUMA
> node so that reparenting LRU folios can take per-node lru locks. As a
> side effect, the per-CPU obj_stock_pcp -- which caches exactly one
> cached_objcg -- thrashes on workloads where threads of the same memcg
> run on different NUMA nodes. The kernel test robot reported a 67.7%
> regression on stress-ng.switch.ops_per_sec from this pattern.
> 
> Mirror the multi-slot pattern already used by memcg_stock_pcp: turn
> nr_bytes and cached_objcg into NR_OBJ_STOCK-element arrays, scan all
> slots on consume/refill/account, prefer empty slots when inserting,
> and evict a random slot only when full. With multiple slots a CPU can
> hold the per-node objcg variants of one memcg plus a few siblings
> without ever forcing a drain.
> 
> A single int8_t index records which slot the cached slab stats belong
> to; the stats are flushed on slot or pgdat change. With NR_OBJ_STOCK
> = 5 the layout (verified with pahole) is:
> 
>    offset 0  : lock(1) + index(1) + node_id(2) + slab stats(4) = 8B
>    offset 8  : nr_bytes[5]                                     = 10B
>    offset 18 : padding                                         = 6B
>    offset 24 : cached[5]                                       = 40B
>    offset 64 : (line 2) work_struct + flags (cold)
> 
> so consume_obj_stock, refill_obj_stock and the slab account path each
> touch exactly one 64-byte cache line on non-debug 64-bit builds.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202605121641.b6a60cb0-lkp@intel.com
> Fixes: 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg per-node type")
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Tested-by: kernel test robot <oliver.sang@intel.com>
> ---
> @@ -3350,19 +3405,45 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
>   		goto out;
>   	}
>   
> -	stock_nr_bytes = stock->nr_bytes;
> -	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
> -		drain_obj_stock(stock);
> +	for (i = 0; i < NR_OBJ_STOCK; ++i) {
> +		struct obj_cgroup *cached = READ_ONCE(stock->cached[i]);
> +
> +		if (!cached) {
> +			if (empty_slot == -1)
> +				empty_slot = i;
> +			continue;
> +		}
> +		if (cached == objcg) {
> +			slot = i;
> +			break;
> +		}
> +	}
> +
> +	if (slot == -1) {
> +		slot = empty_slot;
> +		if (slot == -1) {
> +			slot = get_random_u32_below(NR_OBJ_STOCK);

It would break kmalloc_nolock() because _get_random_bytes() uses a 
spinlock. perhaps prandom_u32_state() should be sufficient in this case.

Is there a reason why it uses random eviction, unlike multi-memcg percpu 
charge cache?

Otherwise LGTM!

-- 
Cheers,
Harry / Hyeonggon


