Return-Path: <cgroups+bounces-16595-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yHZHN/bhH2r4rgAAu9opvQ
	(envelope-from <cgroups+bounces-16595-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 10:12:38 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E945635900
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 10:12:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VKj6Rfrg;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16595-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16595-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD9383042584
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 08:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEFE407CF2;
	Wed,  3 Jun 2026 08:03:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A74E407CE2;
	Wed,  3 Jun 2026 08:03:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780473789; cv=none; b=HeFP9Bb2pO61/uUY2KUao7ZWadofoTXsL1yi+4wiP/9ufBgxvxi53go0BPKB5VENQrjRrEO2RbqhkJLBuni58TYOlM4yGK9WRUrbPcrBIIUfESmYXL+W3aihSFgTcCJ8ntfYgAKci/THGxZ1UrZrce0RpB6KQZYYc9EwUqN7OTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780473789; c=relaxed/simple;
	bh=qWPpCg+e8pAoFNl3Pxs8PtfzF1KTT18RGKSwmrXhurc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sRbZ1bPIpVqLGnMbd7jXilepG3IgcqQWQw9UrYay+mublDljnX1rikHm6MXQa7V4Tgt289qadqSCUQtKyye51Qo9oihu+ME/t3R4eDVJZRjYHWp5FXP5g6M/98Wbqjdy5mSUxAiLtnSpXm5U2Cx9TQBioE8X03yE5yZEXka+ESY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKj6Rfrg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9441F00898;
	Wed,  3 Jun 2026 08:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780473788;
	bh=LTJYCksleeQZKtt5TSmRNFAkMP5Na0YE2idGvPI9oDk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VKj6Rfrgsp6QP0eG7Y3A+lrDbhLZF4gwVt/aPAAjjvBEnqcEM/PpY+m+gEIyDlqMc
	 jzbk4H6ZNQAcIQ9wSYXBuputJZPcep4pMsKflExIXshMbs5gHH1CVyE/ZJpowNn7U3
	 JW3rHZPfNAa+Tqz/3Ac8PcTcMhIp+oaY9NhAK3nANzSpUb9j3jI6ieisZ5hUy+CD33
	 5713rY047/9h+3YZqKvJgH5yDr96rT8xGCu71YVr1v3jisS1W+iYaRVYz5EPWRjv84
	 8jKogWkE8hAHlvTmgW4S65PWk55R43ihnb8vOQIxo6/FEM6p1OqLvjdh9pDGLxuVrx
	 BgINdphckN48A==
Message-ID: <de8878c6-1cb6-476b-814c-907dec842073@kernel.org>
Date: Wed, 3 Jun 2026 10:02:59 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/thp: clear deferred split shrinker bits when
 queues drain
To: Lance Yang <lance.yang@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: ljs@kernel.org, shakeel.butt@linux.dev, mhocko@kernel.org,
 david@fromorbit.com, roman.gushchin@linux.dev, muchun.song@linux.dev,
 qi.zheng@linux.dev, yosry.ahmed@linux.dev, ziy@nvidia.com,
 liam@infradead.org, usama.arif@linux.dev, kas@kernel.org, vbabka@kernel.org,
 ryncsn@gmail.com, zaslonko@linux.ibm.com, gor@linux.ibm.com,
 wangkefeng.wang@huawei.com, baolin.wang@linux.alibaba.com,
 baohua@kernel.org, dev.jain@arm.com, npache@redhat.com,
 ryan.roberts@arm.com, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
References: <20260602043453.67597-1-lance.yang@linux.dev>
 <20260602133706.d737a82858d1cf89870521b1@linux-foundation.org>
 <f5061a2f-c52a-47c4-855c-82f3967833d6@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <f5061a2f-c52a-47c4-855c-82f3967833d6@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16595-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lance.yang@linux.dev,m:akpm@linux-foundation.org,m:ljs@kernel.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:david@fromorbit.com,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:qi.zheng@linux.dev,m:yosry.ahmed@linux.dev,m:ziy@nvidia.com,m:liam@infradead.org,m:usama.arif@linux.dev,m:kas@kernel.org,m:vbabka@kernel.org,m:ryncsn@gmail.com,m:zaslonko@linux.ibm.com,m:gor@linux.ibm.com,m:wangkefeng.wang@huawei.com,m:baolin.wang@linux.alibaba.com,m:baohua@kernel.org,m:dev.jain@arm.com,m:npache@redhat.com,m:ryan.roberts@arm.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:hannes@cmpxchg.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[david@kernel.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,huawei.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org,cmpxchg.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E945635900

On 6/3/26 04:00, Lance Yang wrote:
> 
> 
> On 2026/6/3 04:37, Andrew Morton wrote:
>> On Tue,  2 Jun 2026 12:34:53 +0800 Lance Yang <lance.yang@linux.dev> wrote:
>>
>>> From: Lance Yang <lance.yang@linux.dev>
>>>
>>> deferred_split_count() returns the raw list_lru count. When the per-memcg,
>>> per-node list is empty, that count is 0.
>>>
>>> That skips scanning, but it does not tell memcg reclaim that the shrinker
>>> is empty. shrink_slab_memcg() only clears the memcg shrinker bit when the
>>> count callback reports SHRINK_EMPTY.
>>>
>>> Return SHRINK_EMPTY for an empty deferred split list, so the bit can be
>>> cleared once the queue has drained.
>>>
>>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>>> ---
>>>   mm/huge_memory.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 72f6caf0fec6..62d598290c3b 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -4397,7 +4397,10 @@ void deferred_split_folio(struct folio *folio, bool
>>> partially_mapped)
>>>   static unsigned long deferred_split_count(struct shrinker *shrink,
>>>           struct shrink_control *sc)
>>>   {
>>> -    return list_lru_shrink_count(&deferred_split_lru, sc);
>>> +    unsigned long count;
>>> +
>>> +    count = list_lru_shrink_count(&deferred_split_lru, sc);
>>> +    return count ?: SHRINK_EMPTY;
>>>   }
>>>     static bool thp_underused(struct folio *folio)
>>
>> Should this be handled as a fix against hannes's "mm: switch deferred
>> split shrinker to list_lru"?
> 
> Hmm ... I noticed this while looking at Johannes' work, but the
> behavior is older than that ...
> 
> We also discussed the Fixes tag earlier[1] and decided to leave it
> out. There is no missed reclaim, only some extra reclaim work :)

Right, I conclude that this can be a separate patch on top.

-- 
Cheers,

David

