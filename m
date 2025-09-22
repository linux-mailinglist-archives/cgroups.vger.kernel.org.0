Return-Path: <cgroups+bounces-10327-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C61AB8F9C1
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 10:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074E418A153D
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 08:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050DF275860;
	Mon, 22 Sep 2025 08:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PX1+1JZ1"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F6C264638
	for <cgroups@vger.kernel.org>; Mon, 22 Sep 2025 08:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758530622; cv=none; b=ewbD5QtWtiQTh3JbSRccXgspgL/EooLxL/+zjCxs6VWNVNQax8JZYQTVeh8CHh5ZNmwYajyg6CkJezl3co27LIp56fHA4hSsXrQK3pkSBHTLG1H0uC6LqOeplgVJ/QfMG/rirCCTtC6f1K2wDfXPfNObAYkzgQ+bqQo5QloRYog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758530622; c=relaxed/simple;
	bh=+9HMtrTkXAzLZ32UBZ7J2GpcpHn91xWSkVfFtOkLtvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AU7LG+iboRaMwSGp9Sqbyxc9xH9BYzSS+kwI2BsI3s/f40JEIbIHMciiO6VB7gTwXGHaS+trK5DJzBHgRgDFQr5jmqEz9raWdj6zV2HQO5lfZ94fsGEWyBbCLl32yEtoFz9j/27nw057Zv+hR2rJsDTF9wcWqGhvLkD28gTuwLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PX1+1JZ1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758530620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6dZLLbjdMnUvIg9VzmdVPy48qNzYPknOh8uhqC3nYWs=;
	b=PX1+1JZ19Jt63AgrU+mo7X7NLrkzEUUkH/O6DOys3chN/Dv+e3TbhK0J4Ocar3TyOfMxlT
	OEqISJitM1KT4rDX9+9QHd0adKfGSZyUSoqkeTmoM7d30g2tb3ZZ9Okgak2w4gf5wMx2Y7
	YSvw/Zw3Dh+bEdsxX/ashd96fEejbhg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-cEOyUq-8OZqHQFlHoYRu6Q-1; Mon, 22 Sep 2025 04:43:38 -0400
X-MC-Unique: cEOyUq-8OZqHQFlHoYRu6Q-1
X-Mimecast-MFC-AGG-ID: cEOyUq-8OZqHQFlHoYRu6Q_1758530617
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46d46692831so3448455e9.3
        for <cgroups@vger.kernel.org>; Mon, 22 Sep 2025 01:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758530617; x=1759135417;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6dZLLbjdMnUvIg9VzmdVPy48qNzYPknOh8uhqC3nYWs=;
        b=JGLhjZRuN6nRIlNosTJFlmQ+HQUF7GEoIaubX3TFAeYNZjC1TRidm8B5MUcgy3ULJr
         pR23j6XQl08MxrQH+jkmvupj6XYVDatjptJk6MG4mg+2Xx3LYEpY82DQtP8JoN56q1tB
         n7fa1cnPDzZqIo/9VMWz9/JY0gDIiq5pqwqhOe30KrPIeOuB3/0o+dSXeqNOTfDryCmK
         19hr1/ObTQurmO4rr9NNyZG7xOpV1vZQuZvOfinsQVt8bzYhbhDYD5bjV7WILOdB0Q+i
         7SpmipKyVrZCXl9x8LLACjdu6f0gxW06mDcRk7F+B53MIg+HOBXRc5JUIfZfU82Ytty3
         osYg==
X-Forwarded-Encrypted: i=1; AJvYcCXnjgPkKnqpUZeQ8fEugz1PVF2OxFLqurPeImb22tqCo4MWsy2HlooL5eiHAGGn8QMao5IlVgFw@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7LbS28xOwSqV1lYT6Tjnp7mi0UvUf11whasq2s9etqtkJE0bq
	dHUcSiaPjIV0Dw+ETUnbti5t64GpIIgushJuNhWiFHkzmFv6Ljt76eOhDZ2gQlgR4XCtSEy/KKd
	unu1e6G0VGIdLS9fOoFmW9nNYpT8IjaGudPy3NWv6idJX9eg3yX/b0uOtY7I=
X-Gm-Gg: ASbGncsiYSTeQ7RxBOZPJHTtA6mRJvEb0tNUZnG5eiPP5kwySjgv/SN3/6Ixd8obUK6
	TtpNXCmSf55X28JCBqQULGJDibv0tcThTH5Je5O13ab7JrOH6oEeUqZ4r8xOEe683dwVwmKx53O
	yxotdtPQYVpFQh3gl4JU0AxSu/fe7f4yU1CESuSHyvaCflCqtJ2+kVzNjaEQbd4+xZKOaa4U/ga
	n1gXzvstmRDdY6hSWSaXHWWlbnb6jN3bjzLSd2fS6Pe7eQ4nv0TsWr9N3qVRVFvT1IJlEc9MYmp
	Di8vnLlTApdKCZvoXLUWoRhEdldHJiyZooClpqsuncZ58WnHohuYksyVtfbliYgIBTkL5en15QF
	bFILLBgzejIvMD3sxxv9KEGDuHdi14Hk1F+3brOex0a6ovgpWKSekmtzxmUm0JGw=
X-Received: by 2002:a05:600c:4f42:b0:468:7a5a:725 with SMTP id 5b1f17b1804b1-4687a5a0801mr110690805e9.1.1758530616707;
        Mon, 22 Sep 2025 01:43:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd8F58bMwqbxykxW2EHlng+H3tgYCitYi/ROlfT1EKPjCK0qI5N5OizLnvQxyLC3ZQisYmoA==
X-Received: by 2002:a05:600c:4f42:b0:468:7a5a:725 with SMTP id 5b1f17b1804b1-4687a5a0801mr110690495e9.1.1758530616252;
        Mon, 22 Sep 2025 01:43:36 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2a:e200:f98f:8d71:83f:f88? (p200300d82f2ae200f98f8d71083f0f88.dip0.t-ipconnect.de. [2003:d8:2f2a:e200:f98f:8d71:83f:f88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee106fd0edsm18355715f8f.53.2025.09.22.01.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 01:43:35 -0700 (PDT)
Message-ID: <40772b34-30c8-4f16-833c-34fdd7c69176@redhat.com>
Date: Mon, 22 Sep 2025 10:43:34 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mm: thp: use folio_batch to handle THP splitting in
 deferred_split_scan()
To: Qi Zheng <zhengqi.arch@bytedance.com>, hannes@cmpxchg.org,
 hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, lance.yang@linux.dev, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>
References: <cover.1758253018.git.zhengqi.arch@bytedance.com>
 <3db5da29d767162a006a562963eb52df9ce45a51.1758253018.git.zhengqi.arch@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <3db5da29d767162a006a562963eb52df9ce45a51.1758253018.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.09.25 05:46, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> The maintenance of the folio->_deferred_list is intricate because it's
> reused in a local list.
> 
> Here are some peculiarities:
> 
>     1) When a folio is removed from its split queue and added to a local
>        on-stack list in deferred_split_scan(), the ->split_queue_len isn't
>        updated, leading to an inconsistency between it and the actual
>        number of folios in the split queue.

deferred_split_count() will now return "0" even though there might be 
concurrent scanning going on. I assume that's okay because we are not 
returning SHRINK_EMPTY (which is a difference).

> 
>     2) When the folio is split via split_folio() later, it's removed from
>        the local list while holding the split queue lock. At this time,
>        this lock protects the local list, not the split queue.
> 
>     3) To handle the race condition with a third-party freeing or migrating
>        the preceding folio, we must ensure there's always one safe (with
>        raised refcount) folio before by delaying its folio_put(). More
>        details can be found in commit e66f3185fa04 ("mm/thp: fix deferred
>        split queue not partially_mapped"). It's rather tricky.
> 
> We can use the folio_batch infrastructure to handle this clearly. In this
> case, ->split_queue_len will be consistent with the real number of folios
> in the split queue. If list_empty(&folio->_deferred_list) returns false,
> it's clear the folio must be in its split queue (not in a local list
> anymore).
> 
> In the future, we will reparent LRU folios during memcg offline to
> eliminate dying memory cgroups, which requires reparenting the split queue
> to its parent first. So this patch prepares for using
> folio_split_queue_lock_irqsave() as the memcg may change then.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>   mm/huge_memory.c | 88 +++++++++++++++++++++++-------------------------
>   1 file changed, 42 insertions(+), 46 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index d34516a22f5bb..ab16da21c94e0 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3760,21 +3760,22 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>   		struct lruvec *lruvec;
>   		int expected_refs;
>   
> -		if (folio_order(folio) > 1 &&
> -		    !list_empty(&folio->_deferred_list)) {
> -			ds_queue->split_queue_len--;
> +		if (folio_order(folio) > 1) {
> +			if (!list_empty(&folio->_deferred_list)) {
> +				ds_queue->split_queue_len--;
> +				/*
> +				 * Reinitialize page_deferred_list after removing the
> +				 * page from the split_queue, otherwise a subsequent
> +				 * split will see list corruption when checking the
> +				 * page_deferred_list.
> +				 */
> +				list_del_init(&folio->_deferred_list);
> +			}
>   			if (folio_test_partially_mapped(folio)) {
>   				folio_clear_partially_mapped(folio);
>   				mod_mthp_stat(folio_order(folio),
>   					      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
>   			}
> -			/*
> -			 * Reinitialize page_deferred_list after removing the
> -			 * page from the split_queue, otherwise a subsequent
> -			 * split will see list corruption when checking the
> -			 * page_deferred_list.
> -			 */
> -			list_del_init(&folio->_deferred_list);
>   		}

BTW I am not sure about holding the split_queue_lock before freezing the 
refcount (comment above the freeze):

freezing should properly sync against the folio_try_get(): one of them 
would fail.

So not sure if that is still required. But I recall something nasty 
regarding that :)


>   		split_queue_unlock(ds_queue);
>   		if (mapping) {
> @@ -4173,40 +4174,48 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>   	struct pglist_data *pgdata = NODE_DATA(sc->nid);
>   	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
>   	unsigned long flags;
> -	LIST_HEAD(list);
> -	struct folio *folio, *next, *prev = NULL;
> -	int split = 0, removed = 0;
> +	struct folio *folio, *next;
> +	int split = 0, i;
> +	struct folio_batch fbatch;
> +	bool done;

Is "done" really required? Can't we just use sc->nr_to_scan tos ee if 
there is work remaining to be done so we retry?

>   
>   #ifdef CONFIG_MEMCG
>   	if (sc->memcg)
>   		ds_queue = &sc->memcg->deferred_split_queue;
>   #endif
>   
> +	folio_batch_init(&fbatch);
> +retry:
> +	done = true;
>   	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>   	/* Take pin on all head pages to avoid freeing them under us */
>   	list_for_each_entry_safe(folio, next, &ds_queue->split_queue,
>   							_deferred_list) {
>   		if (folio_try_get(folio)) {
> -			list_move(&folio->_deferred_list, &list);
> -		} else {
> +			folio_batch_add(&fbatch, folio);
> +		} else if (folio_test_partially_mapped(folio)) {
>   			/* We lost race with folio_put() */
> -			if (folio_test_partially_mapped(folio)) {
> -				folio_clear_partially_mapped(folio);
> -				mod_mthp_stat(folio_order(folio),
> -					      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
> -			}
> -			list_del_init(&folio->_deferred_list);
> -			ds_queue->split_queue_len--;
> +			folio_clear_partially_mapped(folio);
> +			mod_mthp_stat(folio_order(folio),
> +				      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
>   		}
> +		list_del_init(&folio->_deferred_list);
> +		ds_queue->split_queue_len--;
>   		if (!--sc->nr_to_scan)
>   			break;
> +		if (folio_batch_space(&fbatch) == 0) {

Nit: if (!folio_batch_space(&fbatch)) {


-- 
Cheers

David / dhildenb


