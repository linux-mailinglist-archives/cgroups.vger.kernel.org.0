Return-Path: <cgroups+bounces-16549-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IPoN01eHmo/iwkAu9opvQ
	(envelope-from <cgroups+bounces-16549-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 06:38:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E9594628208
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 06:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0C5DF30028CC
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 04:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219AA2E173D;
	Tue,  2 Jun 2026 04:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jTqW2E1O"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5432D8DC4
	for <cgroups@vger.kernel.org>; Tue,  2 Jun 2026 04:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780375110; cv=none; b=n6QdJSOmG0XnDyHvU/dv5oZp+JfB4IBwL5b7luPiqwPCH/wgeS4CGMSYu6DjhaYEwg7Qk+S4iOY5Ujrcna833CqA2YOkWaMM5CU8hpU57h0om9cbVPeHaISAx4sjmTBg4+XQpPj24gpsHlU1OfLkRRlplUQpW5VeGBmNh+lYOME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780375110; c=relaxed/simple;
	bh=DQh8SihepS/bdj/Vqb0/Ye6Gngc7/uF3vsBGv/GTXVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d4VG5AQyTpu0jzClTWblaXp0f1CqfN2WfhAMTaO93ySGPJYSfvnmltnzCxpprTv6lYUEq0nqBeSKw2P7P1p2+S/GdTqPMRf3Ps0GJsOfcH4TYWhT7YiXRukXoz1vQRUO1KRsSaXkkjqs5ynN0+rfVNuw5nzX/SyPouVhKp9XE64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jTqW2E1O; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1dce1561-b42a-4322-a99f-89eba1e7c227@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780375107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/14mXd0q1MBnuc0ydGe40mVtZmaecJq1itLWhQAj/UQ=;
	b=jTqW2E1OzAFOKAWGc9K+vAdZbQ+j6VvpFnF5EObq7hBUO5GDclhGAbTbV06Jht+tayX7um
	Egbg7h7ufGLgiyds8gmkt9HPomylcdCY6byqJY9Y2Ymab1HCK0uAtRGPMImqs8n/5Qotfz
	l3671eM2Cj6zd0Ew2rimViAUVa+skV8=
Date: Tue, 2 Jun 2026 12:38:01 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] mm/thp: clear deferred split shrinker bits when
 queues drain
Content-Language: en-US
To: akpm@linux-foundation.org, hannes@cmpxchg.org
Cc: david@kernel.org, ljs@kernel.org, shakeel.butt@linux.dev,
 mhocko@kernel.org, david@fromorbit.com, roman.gushchin@linux.dev,
 muchun.song@linux.dev, qi.zheng@linux.dev, yosry.ahmed@linux.dev,
 ziy@nvidia.com, liam@infradead.org, usama.arif@linux.dev, kas@kernel.org,
 vbabka@kernel.org, ryncsn@gmail.com, zaslonko@linux.ibm.com,
 gor@linux.ibm.com, wangkefeng.wang@huawei.com,
 baolin.wang@linux.alibaba.com, baohua@kernel.org, dev.jain@arm.com,
 npache@redhat.com, ryan.roberts@arm.com, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20260602043453.67597-1-lance.yang@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20260602043453.67597-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,huawei.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_FROM(0.00)[bounces-16549-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_TWELVE(0.00)[28]
X-Rspamd-Queue-Id: E9594628208
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sorry, I missed Johannes in Cc ...

On 2026/6/2 12:34, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> deferred_split_count() returns the raw list_lru count. When the per-memcg,
> per-node list is empty, that count is 0.
> 
> That skips scanning, but it does not tell memcg reclaim that the shrinker
> is empty. shrink_slab_memcg() only clears the memcg shrinker bit when the
> count callback reports SHRINK_EMPTY.
> 
> Return SHRINK_EMPTY for an empty deferred split list, so the bit can be
> cleared once the queue has drained.
> 
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
>   mm/huge_memory.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 72f6caf0fec6..62d598290c3b 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4397,7 +4397,10 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
>   static unsigned long deferred_split_count(struct shrinker *shrink,
>   		struct shrink_control *sc)
>   {
> -	return list_lru_shrink_count(&deferred_split_lru, sc);
> +	unsigned long count;
> +
> +	count = list_lru_shrink_count(&deferred_split_lru, sc);
> +	return count ?: SHRINK_EMPTY;
>   }
>   
>   static bool thp_underused(struct folio *folio)


