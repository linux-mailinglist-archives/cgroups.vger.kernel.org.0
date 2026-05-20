Return-Path: <cgroups+bounces-16116-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCBUKIBdDWpLwgUAu9opvQ
	(envelope-from <cgroups+bounces-16116-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 09:06:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C748588A5A
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 09:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FCB130815FC
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 07:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9B133ADA4;
	Wed, 20 May 2026 07:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOFWBjlJ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3B5351C27;
	Wed, 20 May 2026 07:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779260511; cv=none; b=k+adf9ZrGsWxAx7QaNPoyYU3/QwtW+pacCGHrC8TmuL4rnlIBwCte6hBc8sPOtUIw0oQNdl6YAIeAhKk7kU7+KW8mywsmTH+N4apU5D0IwqrtNdXFJ53JvliiUJp6wqmc5wXmmKZ3xOk3mnD3K4Vge08tNyFR0tuhw1eQqcYTX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779260511; c=relaxed/simple;
	bh=srNG3iP+hPO9M0vqLew3pJ95Crxf1O7M42QenH++Qbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i3n/Q3ge6W91B3OoeQ4zThvMMJRS5npL2J4M/rjmtq9jixEg+tHtG+vPZoxciPKP3+BL6V0Bz8ZPf1o5nt1ZJNChWj3dFP4u8saXVTl1oKbid8oDFp+mZoWPswKGHy5RN2X+RianlxKjVYR4DGh4nW0ksjM57+Ywmf91FpMP/OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOFWBjlJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDE41F000E9;
	Wed, 20 May 2026 07:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779260510;
	bh=MPhfsCpAc4bB8xZOq67u18U7o/poPVjXl7qQNddEXA4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HOFWBjlJl6bDy5fYkCOBcVmEVj8iMQxzXOXkIE9WfDCO6ELoAShFH/g0LIeoO6uqE
	 HujHBo62soO0KWGxOgNFIGttk3wu/Mw/I4BdRCa7KQUAPPu2ZBppx1deymufciSWxL
	 X3tlFZy01tg/P7+8n4tv4VMHgjTcSzG4wpgI0rXaNHEcAqlBCho6zGzSvaLqm5Y9F9
	 eRO+QB0O1pbGtvuLVK9RxvRtsEoe+E0VQ8iWvOgeMZUu1HD837uuBYG3lhBE7Xa/90
	 TYNPG9Zty2JkonQS3b5dbzHoUN9+le9cry/VtMcwRY+SG1ld0dXOQsn8R9EXJa9QPa
	 tyIWfAKyKhjbw==
Message-ID: <55d36f91-fcae-4506-9b76-4a7cad3d256d@kernel.org>
Date: Wed, 20 May 2026 16:01:45 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] memcg: uint16_t for nr_bytes in obj_stock_pcp
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
 <20260520053123.2709959-3-shakeel.butt@linux.dev>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260520053123.2709959-3-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16116-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: 0C748588A5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/20/26 2:31 PM, Shakeel Butt wrote:
> Currently struct obj_stock_pcp stores nr_bytes in an 'unsigned int'
> which is 4 bytes on 64-bit machines. Switch the field to uint16_t to
> shrink the per-CPU cache.
> 
> The kernel supports PAGE_SIZE_4KB, _8KB, _16KB, _32KB, _64KB and
> _256KB (see HAVE_PAGE_SIZE_* in arch/Kconfig). After the
> PAGE_SIZE-aligned flush in __refill_obj_stock(), the sub-page
> remainder fits in uint16_t up through 64KiB pages where PAGE_SIZE - 1
> == U16_MAX, but on 256KiB pages PAGE_SIZE - 1 == 0x3FFFF exceeds
> U16_MAX. The accumulator also needs to stay within uint16_t between
> page-aligned flushes on 64KiB pages where PAGE_SIZE itself is
> U16_MAX + 1.
> 
> Accumulate the new total in an 'unsigned int' local, then:
> 
>    1. Flush whenever the accumulator would hit U16_MAX. Together with
>       the existing allow_uncharge flush at PAGE_SIZE, this keeps the
>       uint16_t safe on PAGE_SIZE <= 64KiB.
> 
>    2. On configs with PAGE_SHIFT > 16 (PAGE_SIZE_256KB on hexagon and
>       powerpc 44x), push any sub-page remainder above U16_MAX into
>       objcg->nr_charged_bytes via atomic_add before storing back, so
>       the store cannot silently truncate. The PAGE_SHIFT > 16 guard
>       folds the branch out at compile time on smaller page sizes.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Tested-by: kernel test robot <oliver.sang@intel.com>
> ---
>   mm/memcontrol.c | 33 +++++++++++++++++++++++++++------
>   1 file changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d7c162946719..b3d63d9f267c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3339,21 +3340,41 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
>   		goto out;
>   	}
>   
> +	stock_nr_bytes = stock->nr_bytes;
>   	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
>   		drain_obj_stock(stock);
>   		obj_cgroup_get(objcg);
> -		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
> +		stock_nr_bytes = atomic_read(&objcg->nr_charged_bytes)
>   				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
>   		WRITE_ONCE(stock->cached_objcg, objcg);
>   
>   		allow_uncharge = true;	/* Allow uncharge when objcg changes */
>   	}
> -	stock->nr_bytes += nr_bytes;
> +	stock_nr_bytes += nr_bytes;
> +
> +	/* Since stock->nr_bytes is uint16_t, don't refill >= U16_MAX */
> +	if ((allow_uncharge && (stock_nr_bytes > PAGE_SIZE)) ||
> +	    stock_nr_bytes >= U16_MAX) {

nit: This should be > U16_MAX?

> +		nr_pages = stock_nr_bytes >> PAGE_SHIFT;
> +		stock_nr_bytes &= (PAGE_SIZE - 1);
> +
> +		/*
> +		 * On configs with PAGE_SHIFT > 16 (PAGE_SIZE_256KB on
> +		 * hexagon and powerpc 44x), the sub-page remainder can
> +		 * still exceed U16_MAX. Push the excess back to
> +		 * objcg->nr_charged_bytes so the store into uint16_t
> +		 * cannot silently truncate; folded out at compile time
> +		 * on smaller page sizes.
> +		 */
> +		if (PAGE_SHIFT > 16 && stock_nr_bytes > U16_MAX) {
> +			unsigned int kept = stock_nr_bytes & U16_MAX;
>   
> -	if (allow_uncharge && (stock->nr_bytes > PAGE_SIZE)) {
> -		nr_pages = stock->nr_bytes >> PAGE_SHIFT;
> -		stock->nr_bytes &= (PAGE_SIZE - 1);
> +			atomic_add(stock_nr_bytes - kept,
> +				   &objcg->nr_charged_bytes);
> +			stock_nr_bytes = kept;
> +		}
>   	}
> +	stock->nr_bytes = stock_nr_bytes;
>   
>   out:
>   	if (nr_pages)

-- 
Cheers,
Harry / Hyeonggon


