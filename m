Return-Path: <cgroups+bounces-17647-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RNHZHt6eUGoW2gIAu9opvQ
	(envelope-from <cgroups+bounces-17647-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 09:27:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BAD7380A4
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 09:27:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=SPjPBuPV;
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17647-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17647-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A0F43058D7A
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 07:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39E33C819A;
	Fri, 10 Jul 2026 07:21:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685C138F92D;
	Fri, 10 Jul 2026 07:21:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783668114; cv=none; b=lsgUaOEM98bpnpcNk/XottiQAXi0YR8pPKcW5UrTPQENPgJRwrQK66k9I8B2N/wThzpFu8Z+7FEk7DmdQRLu7oGNLqJVl3jir8LVDT8D8KelNBeOnosvuaS4KsQ9+LAyjZORzUfoHOgFrUnH9Z4LITDdj3Q1bTED1bP8o5hfE64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783668114; c=relaxed/simple;
	bh=GGdC5z0KSncv5qo868h8rhcsT2wyDfFF7Eay9xvSc4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xdd5ij8J+WPPQ2HJ2MWHwDJRdRJuJkaOJqJgjFDsbmlQJ2S74PEgEF0cIySmPWx8jIDjSw0cjAYmgWPB4pjHB15U8YrGKdpwr04rox5WZOuQ8A/7Mo8XIi7Lvc5MwWb9MyRNS+Z8j4jMhz8QIeUi9wxYjdZqnf6qNbr69Q8rxAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SPjPBuPV; arc=none smtp.client-ip=115.124.30.111
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783668109; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=s0jsS6CvIf8h9YNVfslpOzzkSogUyLYNAlZCZLFhTUw=;
	b=SPjPBuPVDRcbDIXIZcofbJ0VZXytSaL6dSPueXfwFi0NCNJ8uKFMZpSLeBF8gUNwXvvWMFQTuUgortUQDvM6x5KV64D3tGLdYET1XpTDDQfJWq8rfLDLU741m9ioYh1iPi93Vd02pICdAfpv2P0Rh/9WAhRaJ1wcMVd4VWbItGg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X6n.faJ_1783668105;
Received: from 30.74.144.121(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X6n.faJ_1783668105 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Jul 2026 15:21:47 +0800
Message-ID: <7ec7533f-e1dc-4236-99cc-6848d651976e@linux.alibaba.com>
Date: Fri, 10 Jul 2026 15:21:44 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/3] mm/vmscan: avoid pointless large folio splits
 without swap
To: Xueyuan Chen <xueyuan.chen21@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Barry Song <baohua@kernel.org>, Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <bhe@redhat.com>, Youngjun Park <youngjun.park@lge.com>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Qi Zheng <qi.zheng@linux.dev>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>
References: <20260709145124.764807-1-xueyuan.chen21@gmail.com>
 <20260709145124.764807-4-xueyuan.chen21@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260709145124.764807-4-xueyuan.chen21@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xueyuan.chen21@gmail.com,m:akpm@linux-foundation.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:baohua@kernel.org,m:zhaonanzhe@xiaomi.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:chrisl@kernel.org,m:kasong@tencent.com,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:bhe@redhat.com,m:youngjun.park@lge.com,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:qi.zheng@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:xueyuanchen21@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux-foundation.org,kvack.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER(0.00)[baolin.wang@linux.alibaba.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17647-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baolin.wang@linux.alibaba.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,xiaomi.com,cmpxchg.org,linux.dev,tencent.com,huaweicloud.com,gmail.com,redhat.com,lge.com,infradead.org,google.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.alibaba.com:from_mime,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B7BAD7380A4



On 7/9/26 10:51 PM, Xueyuan Chen wrote:
> From: "Barry Song (Xiaomi)" <baohua@kernel.org>
> 
> When swap is disabled, exhausted, or unavailable due to memcg swap
> limits, splitting a large anonymous folio cannot make swapout progress.
> The fallback only destroys the large folio and inflates split statistics.
> 
> Use -E2BIG from folio_alloc_swap() as the explicit signal that splitting
> the folio might allow swapout of smaller pieces. For other allocation
> failures, keep the existing activation path and avoid the split.
> 
> This preserves the split fallback for fragmented or partially available
> swap, while avoiding it when there is no backing space for any part of the
> folio.
> 
> Reported-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
> ---
>   mm/vmscan.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index bd1b1aa12581..40340a88f78e 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1260,6 +1260,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>   		 */
>   		if (folio_test_anon(folio) && folio_test_swapbacked(folio) &&
>   				!folio_test_swapcache(folio)) {
> +			int ret;
> +
>   			if (!(sc->gfp_mask & __GFP_IO))
>   				goto keep_locked;
>   			if (folio_maybe_dma_pinned(folio))
> @@ -1278,10 +1280,11 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>   				    split_folio_to_list(folio, folio_list))
>   					goto activate_locked;
>   			}
> -			if (folio_alloc_swap(folio)) {
> +			ret = folio_alloc_swap(folio);
> +			if (ret) {
>   				int __maybe_unused order = folio_order(folio);
>   
> -				if (!folio_test_large(folio))
> +				if (!folio_test_large(folio) || ret != -E2BIG)
>   					goto activate_locked_split;

Like I said in v1 [1], please apply the same change to shmem swap as well.

[1] 
https://lore.kernel.org/all/6e89f868-ca7a-484f-aeea-5d8d029714f2@linux.alibaba.com/

