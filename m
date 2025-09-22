Return-Path: <cgroups+bounces-10335-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A36ACB906D3
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 13:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E6D5169226
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 11:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B232FC037;
	Mon, 22 Sep 2025 11:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZuOzSJDf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2215E27A10F
	for <cgroups@vger.kernel.org>; Mon, 22 Sep 2025 11:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758540981; cv=none; b=EESFT5pCfDwlEeXkM7Rl7h1lthjXrO+0ywx/eJdR8l3n7bakwZVaEK1u08i8FSuLMSzwFKcKQJ/ZaV2QHULWG4OrNceRqikgqg5jD18t+yI476Uiyv3FrY6hyB+i5FORuRq1w6XNT2k9PeyGqQQwsMdnKxIPLFS9GefTgTutA6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758540981; c=relaxed/simple;
	bh=/i/QjJCSnl81HMVrz6IGeARxHKvGKeRUP+nDaWfI3CA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CcFpUo5Z26oiUPZQo5+4DHvaGy39PoD/kH/p2U545nONBR2C2d/yn0bkA04Skdq/5If0HZzmxExPZGYKgbkNasZfzqJ6maQvL5E77Vt0HNOAlSYZVknjvLusTSixfw6tZmfsRb/Ol834aDF2K+t+NjWI0KV9udMGIFLrdy/c6qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZuOzSJDf; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-330469eb750so4848396a91.2
        for <cgroups@vger.kernel.org>; Mon, 22 Sep 2025 04:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758540978; x=1759145778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0u+YpSV/wxdA6FA5LVbjzCi32nJBgZrsJFyY0iW11c=;
        b=ZuOzSJDfcvdDKZKCQ6FkDl+n49rMGZiobUVgRCFxb8t6+cd8h4bCf1UH2GagNfOPz2
         oOBfAChkH3RvonK89f44L2zeJv8IY5Q7i064CoGODz9xyvG7mTP8qHLK13+S2kI/C3xe
         o97i+tNgkRBetd7A9oc0tVq31UdjYut3aeLhACxw648fA7VZU2yYLwoTmR13h7y5aPso
         YpFMzPLhDkkRszZdw3dlcTd5AU/Wi/vB/RF/sVyZnUj58ZhA2RW3an3DIspoLP2m2veg
         4xixAOUeUAVAbJ17CVezsT3sAp+63KQ9X4zjPrSCDvEzKJHB4ZqnzubDtpREd+C7E+pq
         lAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758540978; x=1759145778;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X0u+YpSV/wxdA6FA5LVbjzCi32nJBgZrsJFyY0iW11c=;
        b=ZelmYhDJsHCr4Ivzn4IRzXB22KVEBDuZy4Zrm7etclJPVvyz1zpvDSLyoKcv54rHcA
         bNkb8udnXqXP8S5MbZUsbQCI4GsRoDfa+eF4dQ228ZbvVOfheFNY6530KVkzz/4GtkXN
         m3q7Igtk56ZLMt7QD1V6GftCsxuZtKTo70+xdM+PeccZLP/UxA8ysEsxUMjDjhkUt6L8
         UPCtdPLegg5wDDo3LD6Nx4nl1Z/7uE4kbLdb4Mi2+nyZPzTFoFglw2LKKOBUxys51vnS
         xyL2iPpjE4QXlOrL2dMjcb6ibZBU/KDBbcLRU/GlEZkBotNWEDuqibPM12jhjqhTjF64
         lPfg==
X-Forwarded-Encrypted: i=1; AJvYcCVp1bKbrwx5j5j3H7jB0H5f/nqxZVKbfbeyCzzCgyhphyNkO15GeilLoGfmENG7psmFVtluANlo@vger.kernel.org
X-Gm-Message-State: AOJu0YyfruFYmd+DmTSpu30pe3SUJ4L31aX2KCLBbHMyP5q8Y3Yo7ETK
	31s1OQfxe8cc9pKJYEsLYMTaYY/BMQuGIFraNxLvI9FfAoPIgXBh20jr5DDqFm/b8cE=
X-Gm-Gg: ASbGncv5u9orLRxLdOFJx+sCZF9oAt36zCV8CqboeOdDrd47hwfqgyLpVq8dmNkxx+X
	vJLZwNnUO/XaPA7x9M/6twHWls2Y4CuEhQc3xgZJqHvxNvRsoMMbteFv75vy2e8Gqe3eC/ff7sK
	5UmRTKjrssdxNrHdF6Yqx7/KTG6V5mxlO5mGm/Ea1Pc2WqX5N+girJde/3gXNL8hjjCg+CDjKUh
	QAwJDnBHp5cTPgpxTR4ryWrZq7H7z0mMsEJgVesXDVZCnhRbEtgzs+ovQMHvUWaWWw2gFlarWGY
	TEZaf4tivLa0HwfJdzYimxqkG/KQCrjWE6VRg6NLhb00lsG0QVxEuFSrWZ0/AUQ9VmLcaVx4e9j
	wdiOm7vRLpoyaranEe1l0i0Kgkg8LMC+rDPVKm1Ps50JrU1GlKK4T3sLDdjTDqQ==
X-Google-Smtp-Source: AGHT+IFu8eiVI48iUvVgVKbcFTq4WvOFa2+0AYyjYOZYbm0gMsPD46CwjI8fpjFeWEGqYdUgtuMPzA==
X-Received: by 2002:a17:90b:2788:b0:32b:94a2:b0d5 with SMTP id 98e67ed59e1d1-3309838dff7mr15360958a91.37.1758540978490;
        Mon, 22 Sep 2025 04:36:18 -0700 (PDT)
Received: from [100.82.90.25] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ea0852a82sm10802765a91.0.2025.09.22.04.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 04:36:17 -0700 (PDT)
Message-ID: <65b6c32a-7eb4-4023-94c0-968735b784f6@bytedance.com>
Date: Mon, 22 Sep 2025 19:36:08 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mm: thp: use folio_batch to handle THP splitting in
 deferred_split_scan()
To: David Hildenbrand <david@redhat.com>, hannes@cmpxchg.org,
 hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, lance.yang@linux.dev, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>
References: <cover.1758253018.git.zhengqi.arch@bytedance.com>
 <3db5da29d767162a006a562963eb52df9ce45a51.1758253018.git.zhengqi.arch@bytedance.com>
 <40772b34-30c8-4f16-833c-34fdd7c69176@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <40772b34-30c8-4f16-833c-34fdd7c69176@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David,

On 9/22/25 4:43 PM, David Hildenbrand wrote:
> On 19.09.25 05:46, Qi Zheng wrote:
>> From: Muchun Song <songmuchun@bytedance.com>
>>
>> The maintenance of the folio->_deferred_list is intricate because it's
>> reused in a local list.
>>
>> Here are some peculiarities:
>>
>>     1) When a folio is removed from its split queue and added to a local
>>        on-stack list in deferred_split_scan(), the ->split_queue_len 
>> isn't
>>        updated, leading to an inconsistency between it and the actual
>>        number of folios in the split queue.
> 
> deferred_split_count() will now return "0" even though there might be 
> concurrent scanning going on. I assume that's okay because we are not 
> returning SHRINK_EMPTY (which is a difference).
> 
>>
>>     2) When the folio is split via split_folio() later, it's removed from
>>        the local list while holding the split queue lock. At this time,
>>        this lock protects the local list, not the split queue.
>>
>>     3) To handle the race condition with a third-party freeing or 
>> migrating
>>        the preceding folio, we must ensure there's always one safe (with
>>        raised refcount) folio before by delaying its folio_put(). More
>>        details can be found in commit e66f3185fa04 ("mm/thp: fix deferred
>>        split queue not partially_mapped"). It's rather tricky.
>>
>> We can use the folio_batch infrastructure to handle this clearly. In this
>> case, ->split_queue_len will be consistent with the real number of folios
>> in the split queue. If list_empty(&folio->_deferred_list) returns false,
>> it's clear the folio must be in its split queue (not in a local list
>> anymore).
>>
>> In the future, we will reparent LRU folios during memcg offline to
>> eliminate dying memory cgroups, which requires reparenting the split 
>> queue
>> to its parent first. So this patch prepares for using
>> folio_split_queue_lock_irqsave() as the memcg may change then.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   mm/huge_memory.c | 88 +++++++++++++++++++++++-------------------------
>>   1 file changed, 42 insertions(+), 46 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index d34516a22f5bb..ab16da21c94e0 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3760,21 +3760,22 @@ static int __folio_split(struct folio *folio, 
>> unsigned int new_order,
>>           struct lruvec *lruvec;
>>           int expected_refs;
>> -        if (folio_order(folio) > 1 &&
>> -            !list_empty(&folio->_deferred_list)) {
>> -            ds_queue->split_queue_len--;
>> +        if (folio_order(folio) > 1) {
>> +            if (!list_empty(&folio->_deferred_list)) {
>> +                ds_queue->split_queue_len--;
>> +                /*
>> +                 * Reinitialize page_deferred_list after removing the
>> +                 * page from the split_queue, otherwise a subsequent
>> +                 * split will see list corruption when checking the
>> +                 * page_deferred_list.
>> +                 */
>> +                list_del_init(&folio->_deferred_list);
>> +            }
>>               if (folio_test_partially_mapped(folio)) {
>>                   folio_clear_partially_mapped(folio);
>>                   mod_mthp_stat(folio_order(folio),
>>                             MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
>>               }
>> -            /*
>> -             * Reinitialize page_deferred_list after removing the
>> -             * page from the split_queue, otherwise a subsequent
>> -             * split will see list corruption when checking the
>> -             * page_deferred_list.
>> -             */
>> -            list_del_init(&folio->_deferred_list);
>>           }
> 
> BTW I am not sure about holding the split_queue_lock before freezing the 
> refcount (comment above the freeze):
> 
> freezing should properly sync against the folio_try_get(): one of them 
> would fail.
> 
> So not sure if that is still required. But I recall something nasty 
> regarding that :)

I'm not sure either, need some investigation.

> 
> 
>>           split_queue_unlock(ds_queue);
>>           if (mapping) {
>> @@ -4173,40 +4174,48 @@ static unsigned long 
>> deferred_split_scan(struct shrinker *shrink,
>>       struct pglist_data *pgdata = NODE_DATA(sc->nid);
>>       struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
>>       unsigned long flags;
>> -    LIST_HEAD(list);
>> -    struct folio *folio, *next, *prev = NULL;
>> -    int split = 0, removed = 0;
>> +    struct folio *folio, *next;
>> +    int split = 0, i;
>> +    struct folio_batch fbatch;
>> +    bool done;
> 
> Is "done" really required? Can't we just use sc->nr_to_scan tos ee if 
> there is work remaining to be done so we retry?

I think you are right, will do in the next version.

> 
>>   #ifdef CONFIG_MEMCG
>>       if (sc->memcg)
>>           ds_queue = &sc->memcg->deferred_split_queue;
>>   #endif
>> +    folio_batch_init(&fbatch);
>> +retry:
>> +    done = true;
>>       spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>>       /* Take pin on all head pages to avoid freeing them under us */
>>       list_for_each_entry_safe(folio, next, &ds_queue->split_queue,
>>                               _deferred_list) {
>>           if (folio_try_get(folio)) {
>> -            list_move(&folio->_deferred_list, &list);
>> -        } else {
>> +            folio_batch_add(&fbatch, folio);
>> +        } else if (folio_test_partially_mapped(folio)) {
>>               /* We lost race with folio_put() */
>> -            if (folio_test_partially_mapped(folio)) {
>> -                folio_clear_partially_mapped(folio);
>> -                mod_mthp_stat(folio_order(folio),
>> -                          MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
>> -            }
>> -            list_del_init(&folio->_deferred_list);
>> -            ds_queue->split_queue_len--;
>> +            folio_clear_partially_mapped(folio);
>> +            mod_mthp_stat(folio_order(folio),
>> +                      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
>>           }
>> +        list_del_init(&folio->_deferred_list);
>> +        ds_queue->split_queue_len--;
>>           if (!--sc->nr_to_scan)
>>               break;
>> +        if (folio_batch_space(&fbatch) == 0) {
> 
> Nit: if (!folio_batch_space(&fbatch)) {

OK, will do.

Thanks,
Qi

> 
> 


