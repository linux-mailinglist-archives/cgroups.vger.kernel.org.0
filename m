Return-Path: <cgroups+bounces-16590-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z+sFIt2KH2oLnAAAu9opvQ
	(envelope-from <cgroups+bounces-16590-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 04:01:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C6263391D
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 04:01:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=OpV6w1zh;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16590-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16590-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 93FBE3007280
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 02:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F93B3AB298;
	Wed,  3 Jun 2026 02:00:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2BE3AB271
	for <cgroups@vger.kernel.org>; Wed,  3 Jun 2026 02:00:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780452056; cv=none; b=A4semyWTQbVgk5FrOXEv2HhxUn2RpJ/eYJsiMLSfrigIn377wXgxf3OKyoTctzqUnwouTDO5IohnoZL5nxLZ0qCxsd7vO/oOL43TuvCzhVMGW4vBZLn0cgVuVEFB0GP1Lyfot9D9sx5O2qLEpC/GiQfaEO3BPMHQ0vNq42BqJGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780452056; c=relaxed/simple;
	bh=cvRv8xMtq0WCcjq7Ft9xBpdBJQmg8mtlgWqmwiKIPbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qnglozntZApEb8FwXbUKC4bw1eQweBHbvY2URQ29NC5G0727S8n7Ko0yCB/CXKusiMmElC1RsRYyml3QSju42IB09vWaJuwRaO7LwSTZEyXlqz8FvHtx19qZ3BWm8gJMTHJa3M7vwRdIAtpTa+OCkYwjBwqI1+sVf3oIhmKWie4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OpV6w1zh; arc=none smtp.client-ip=95.215.58.170
Message-ID: <f5061a2f-c52a-47c4-855c-82f3967833d6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780452052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LeJhAZRLWtGVTIwFCHuqUJodfl2KhzLTyWve4qcCjP0=;
	b=OpV6w1zhJuO9Fvzn8HsG5QQIKizSG6UQlTGMYcaaGFMyxQu6EKE+D7en/a3XSllzlZr09c
	OL45e43afq5M8uzJH+i6A6D/I/7sBvkz4DASrXvWF8YTzQPYljiqO0j2vMSg8whTUhwLAm
	sdEXdAeJV4ySUtPk/pQSFbGcLsXdX4g=
Date: Wed, 3 Jun 2026 10:00:33 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] mm/thp: clear deferred split shrinker bits when
 queues drain
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: david@kernel.org, ljs@kernel.org, shakeel.butt@linux.dev,
 mhocko@kernel.org, david@fromorbit.com, roman.gushchin@linux.dev,
 muchun.song@linux.dev, qi.zheng@linux.dev, yosry.ahmed@linux.dev,
 ziy@nvidia.com, liam@infradead.org, usama.arif@linux.dev, kas@kernel.org,
 vbabka@kernel.org, ryncsn@gmail.com, zaslonko@linux.ibm.com,
 gor@linux.ibm.com, wangkefeng.wang@huawei.com,
 baolin.wang@linux.alibaba.com, baohua@kernel.org, dev.jain@arm.com,
 npache@redhat.com, ryan.roberts@arm.com, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>
References: <20260602043453.67597-1-lance.yang@linux.dev>
 <20260602133706.d737a82858d1cf89870521b1@linux-foundation.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20260602133706.d737a82858d1cf89870521b1@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16590-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:david@fromorbit.com,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:qi.zheng@linux.dev,m:yosry.ahmed@linux.dev,m:ziy@nvidia.com,m:liam@infradead.org,m:usama.arif@linux.dev,m:kas@kernel.org,m:vbabka@kernel.org,m:ryncsn@gmail.com,m:zaslonko@linux.ibm.com,m:gor@linux.ibm.com,m:wangkefeng.wang@huawei.com,m:baolin.wang@linux.alibaba.com,m:baohua@kernel.org,m:dev.jain@arm.com,m:npache@redhat.com,m:ryan.roberts@arm.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:hannes@cmpxchg.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lance.yang@linux.dev,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,huawei.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org,cmpxchg.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux.dev:from_mime,linux.dev:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86C6263391D



On 2026/6/3 04:37, Andrew Morton wrote:
> On Tue,  2 Jun 2026 12:34:53 +0800 Lance Yang <lance.yang@linux.dev> wrote:
> 
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> deferred_split_count() returns the raw list_lru count. When the per-memcg,
>> per-node list is empty, that count is 0.
>>
>> That skips scanning, but it does not tell memcg reclaim that the shrinker
>> is empty. shrink_slab_memcg() only clears the memcg shrinker bit when the
>> count callback reports SHRINK_EMPTY.
>>
>> Return SHRINK_EMPTY for an empty deferred split list, so the bit can be
>> cleared once the queue has drained.
>>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>>   mm/huge_memory.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 72f6caf0fec6..62d598290c3b 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -4397,7 +4397,10 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
>>   static unsigned long deferred_split_count(struct shrinker *shrink,
>>   		struct shrink_control *sc)
>>   {
>> -	return list_lru_shrink_count(&deferred_split_lru, sc);
>> +	unsigned long count;
>> +
>> +	count = list_lru_shrink_count(&deferred_split_lru, sc);
>> +	return count ?: SHRINK_EMPTY;
>>   }
>>   
>>   static bool thp_underused(struct folio *folio)
> 
> Should this be handled as a fix against hannes's "mm: switch deferred
> split shrinker to list_lru"?

Hmm ... I noticed this while looking at Johannes' work, but the
behavior is older than that ...

We also discussed the Fixes tag earlier[1] and decided to leave it
out. There is no missed reclaim, only some extra reclaim work :)

[1] 
https://lore.kernel.org/linux-mm/63797977-1c18-4885-8099-f5c21c80da39@linux.dev/

Cheers, Lance

