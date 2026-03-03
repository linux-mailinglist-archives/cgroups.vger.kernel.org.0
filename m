Return-Path: <cgroups+bounces-14552-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGvzAV+spmn9SgAAu9opvQ
	(envelope-from <cgroups+bounces-14552-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 10:39:43 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 599A41EBFE8
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 10:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ECD131055B7
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 09:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA3E38C436;
	Tue,  3 Mar 2026 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrgZIT4+"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB3138C2C2;
	Tue,  3 Mar 2026 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772530464; cv=none; b=rco+cIamP2giKOX/lRt0i/q90la0lqbKijEfnAuwAcZTeDVXJRKe0jLasjRIZbKss7p47nnF/1Y4mrry7PVVhrrdTOG8CtQ6XIQCsyrip9Vnvjbx/+EB4u1knhZAIYCJ3tGl1vymDV0DzmGZs2bCFG6428cNzrHSEd9ZuVae+aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772530464; c=relaxed/simple;
	bh=aF0geMfZfg7K36R3UA50A5lGdrThrnCyNqDKuaHXlUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oNSaUV4iVliLJhnp+V/pU3u5YKT5rlYBsNSUGfL/8kW/Euo38eWsjWROnN11TR/8C064cCV5hz6kugUU2cWhfnbQf6kYSk77w/8kusGCLgjPL5ZyPmugCGmEztEbOkBQJqg1ChjXPyIAAGY5+KEcjxdZQiT3Scy7ZCwPUGuJah0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrgZIT4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E94C116C6;
	Tue,  3 Mar 2026 09:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772530464;
	bh=aF0geMfZfg7K36R3UA50A5lGdrThrnCyNqDKuaHXlUU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TrgZIT4+ZXZ5Ij0Pckh4JcvO6r3FTtQqoX3igL1DYRgXGSlUB2kmvsCk2EWI3KSOD
	 onrlbftUWavPQo3y3shH+1g15Lr3BxFMVeJsqyZhGmTL+Hi569qcQBiA+c0+nBRiU/
	 U16dsnQKo6xoeAX5L2v4GQ/tjadQ1c/ddea9YUAXMMdyIov7FAaogWAnGnhuRzsy+c
	 R/4BJT/0udRLDF2MjHIcVxziOE3GLDi7v2dH7cg6Ws7zBMYALep8TU7+o8tqygQYQo
	 hNtH2kzCuJIIUJyJ7FSnrGzIG2lLUna0yfybyDh5aMZVdC0IpopPBjIZQTVKjfzaMa
	 pTJrRFC3GzrmA==
Message-ID: <8580309c-7166-4475-80de-fb2a11a8a1e8@kernel.org>
Date: Tue, 3 Mar 2026 10:34:19 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] mm: memcg: simplify objcg charge size and stock
 remainder math
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Li <hao.li@linux.dev>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
 Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Johannes Weiner <jweiner@meta.com>
References: <20260302195305.620713-1-hannes@cmpxchg.org>
 <20260302195305.620713-3-hannes@cmpxchg.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260302195305.620713-3-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 599A41EBFE8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14552-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,meta.com:email]
X-Rspamd-Action: no action

On 3/2/26 20:50, Johannes Weiner wrote:
> From: Johannes Weiner <jweiner@meta.com>
> 
> Use PAGE_ALIGN() and a more natural cache remainder calculation.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
>  mm/memcontrol.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index a975ab3aee10..0d0a77fedb00 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3417,7 +3417,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
>  static int obj_cgroup_charge_account(struct obj_cgroup *objcg, gfp_t gfp, size_t size,
>  				     struct pglist_data *pgdat, enum node_stat_item idx)
>  {
> -	unsigned int nr_pages, nr_bytes;
> +	size_t charge_size, remainder;
>  	int ret;
>  
>  	if (likely(consume_obj_stock(objcg, size, pgdat, idx)))
> @@ -3446,16 +3446,12 @@ static int obj_cgroup_charge_account(struct obj_cgroup *objcg, gfp_t gfp, size_t
>  	 * bytes is (sizeof(object) + PAGE_SIZE - 2) if there is no data
>  	 * race.
>  	 */
> -	nr_pages = size >> PAGE_SHIFT;
> -	nr_bytes = size & (PAGE_SIZE - 1);
> +	charge_size = PAGE_ALIGN(size);
> +	remainder = charge_size - size;
>  
> -	if (nr_bytes)
> -		nr_pages += 1;
> -
> -	ret = obj_cgroup_charge_pages(objcg, gfp, nr_pages);
> -	if (!ret && (nr_bytes || pgdat))
> -		refill_obj_stock(objcg, nr_bytes ? PAGE_SIZE - nr_bytes : 0,
> -					 false, size, pgdat, idx);
> +	ret = obj_cgroup_charge_pages(objcg, gfp, charge_size >> PAGE_SHIFT);
> +	if (!ret && (remainder || pgdat))
> +		refill_obj_stock(objcg, remainder, false, size, pgdat, idx);
>  
>  	return ret;
>  }


