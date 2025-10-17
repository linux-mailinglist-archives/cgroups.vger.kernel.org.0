Return-Path: <cgroups+bounces-10833-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4490BE5FCC
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 02:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2413BDA52
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 00:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6652D405F7;
	Fri, 17 Oct 2025 00:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FApuJBvm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58666168BD
	for <cgroups@vger.kernel.org>; Fri, 17 Oct 2025 00:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760661976; cv=none; b=ZIZM2k+dNOb7FCrGv3n7I38oXn7D/tRRTmufu463C4ZKEn1XQyu5TIwzxUeX7Fll2FrQ/AQ/GaM7/woF0uWgjBFkiPGb+96ssRAiuf81GAqRnQjd4fu6J7pBvteX2An8yFib4d2CUhJmQDP9sU5hiwWc2XCVvP30s/td2oKtelA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760661976; c=relaxed/simple;
	bh=x3ENAolDhGepo8Lva0Y8IQnpFONqZhyhxoMK7eF5O1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjYYjs5H8kNpmO7qFpLPZXZ73Bqd1lHbVHiC/xOAgdGKrNcmcHJvc3x2GdJtzhJHTDpU/rFyjWKSw9RG+ionDlse6UjuKHx57O+wWmKCPqe2culu93aFJq89aYVPPDJnaKCJwuLqj1CSFhcmcl107uxvfF8MAdKpun/Sk8nZ0tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FApuJBvm; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3dbf11fa9eso262199466b.0
        for <cgroups@vger.kernel.org>; Thu, 16 Oct 2025 17:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760661973; x=1761266773; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+B/rNIxGB0E8lYNQb7e+4S76Mddht/U4IBaRSdc7uX4=;
        b=FApuJBvm7hfHwLlh+ODwe6/PM1E1ZEO1YFVo+OCtCk7O33BtokEmQHIq0dgl1e9Khy
         MqzWLnBDgcCCHXuZIQg263siFP4xjFIZRNT7Y4vT7EpQ9CttUGulc1uztMUT8XeArscw
         WRgL7iUECIzrzIhkpFnaP0edDYw7ej198F8FDDH16WxJ98FwVaKM0wlYaJZ+5dCUxd0b
         bqxtrUAWvP218IfrN9M4YDYVwb4DAaQyrFkvB/AINK9rSh1nBEtD2NUrIwTY7MbUND0R
         FMmXprNYRq3F0ahO0HWeMdxtHTVNND4G1ZvK4740GanwuBjW72pLRK4B5iWiU7az62S9
         bkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760661973; x=1761266773;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+B/rNIxGB0E8lYNQb7e+4S76Mddht/U4IBaRSdc7uX4=;
        b=pq1iGPqpEt+ypijvB73taKBPO9eVajNgMzM4keQ2Jqbh5Idse2T4te9Sal0RJZNAZc
         O5L7PX4zC0pU1lYC08re6adpuaPCb2s2gANdzRZPZWvCeskLDz37BpiF/66nvkTgNwgr
         acaIRTMWosLQrnlY00M3Xs+59wMkiwP8eiVF4g3wwYc0c3iy3XUU2z+VlUGTq3Vjj2cl
         GaUXiOXyVlujPV2chrWlm/rMDz0Bfk7ADdRS5BbKQPSC2S8TdwHjeya1vIu36gdLhLZR
         /dm7Safk5lKtsGx59racXgGZ+F3WKXMJybYHtmBJ/kGxXcqPL3r5qLhFyCMzPnbzPI0W
         +lSA==
X-Forwarded-Encrypted: i=1; AJvYcCV0b5qninEWbeCS+DyC5yQA8IqBcIQtzZl9RctI933XgKlcUPFxgQryFUiwUTNuD4y1cD0K7jA6@vger.kernel.org
X-Gm-Message-State: AOJu0YzfZO6vY3epmK7jvTLaV4Bkzp1JDlD2gIMydopGB2/9cmVaLbRn
	RmzqgM2xGFY1R1keodsTctp7HK1Y1Hy0qOhTnBVSWECnXkkLnQB6ViSS
X-Gm-Gg: ASbGnctcPwJWKMXGXxFRJKaQtZSQ11vye3zvs6v1FKYUZhpP7KWFzuhJco2PWSmFJGh
	arTYLj8/IhmMFgvDD7BMsWF0YXdQ3iCRU9fd97YIkn7+AgMdp8hRDmTEYobXhu7l3fKBILDT5fy
	habam1T6dGtFdUxKWH4IZyVRgKxfJBcRxTfODou0Hm8UdpCf5P5b5hBE4xb8aMmtXLl8gV2n3og
	ufg5L0nxFBxssWMpl1c2Cx0b1uNOQXoHrclodFEe3A7IPCmf5vodhLuxee6YEFxtl4i9Ewf40ox
	6xJibzeRcMdLl8hjANqPsgSzQt77L0nFVKYWF6sP6Fr2Q66Z4yxghLonqqt8pCGfO4kQ8ApdCHj
	5wQrcWc5n3bbGY1EnA5Gtpu7qwM1klRto+OWlloE80vlrSDRj/WkHHslUa1AtF5jiWuZToMlHpP
	geSy6fBdR4O3j0wg==
X-Google-Smtp-Source: AGHT+IHIrzM9nmQS/QH3e+TBJNCq5g1hcZGI45fz5wnzA+TbcN3hecCz0LjMxm3I+m+5Dg3KP8R8Xg==
X-Received: by 2002:a17:907:3e85:b0:b3e:8252:cd54 with SMTP id a640c23a62f3a-b647395033fmr219806766b.32.1760661972374;
        Thu, 16 Oct 2025 17:46:12 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cba06b7f6sm689297966b.30.2025.10.16.17.46.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Oct 2025 17:46:11 -0700 (PDT)
Date: Fri, 17 Oct 2025 00:46:11 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, david@redhat.com, lorenzo.stoakes@oracle.com,
	ziy@nvidia.com, harry.yoo@oracle.com, baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v5 3/4] mm: thp: use folio_batch to handle THP splitting
 in deferred_split_scan()
Message-ID: <20251017004611.ccjq2343v43mimqq@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <cover.1760509767.git.zhengqi.arch@bytedance.com>
 <4f5d7a321c72dfe65e0e19a3f89180d5988eae2e.1760509767.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f5d7a321c72dfe65e0e19a3f89180d5988eae2e.1760509767.git.zhengqi.arch@bytedance.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Oct 15, 2025 at 02:35:32PM +0800, Qi Zheng wrote:
>From: Muchun Song <songmuchun@bytedance.com>
>
>The maintenance of the folio->_deferred_list is intricate because it's
>reused in a local list.
>
>Here are some peculiarities:
>
>   1) When a folio is removed from its split queue and added to a local
>      on-stack list in deferred_split_scan(), the ->split_queue_len isn't
>      updated, leading to an inconsistency between it and the actual
>      number of folios in the split queue.
>
>   2) When the folio is split via split_folio() later, it's removed from
>      the local list while holding the split queue lock. At this time,
>      the lock is not needed as it is not protecting anything.
>
>   3) To handle the race condition with a third-party freeing or migrating
>      the preceding folio, we must ensure there's always one safe (with
>      raised refcount) folio before by delaying its folio_put(). More
>      details can be found in commit e66f3185fa04 ("mm/thp: fix deferred
>      split queue not partially_mapped"). It's rather tricky.
>
>We can use the folio_batch infrastructure to handle this clearly. In this
>case, ->split_queue_len will be consistent with the real number of folios
>in the split queue. If list_empty(&folio->_deferred_list) returns false,
>it's clear the folio must be in its split queue (not in a local list
>anymore).
>
>In the future, we will reparent LRU folios during memcg offline to
>eliminate dying memory cgroups, which requires reparenting the split queue
>to its parent first. So this patch prepares for using
>folio_split_queue_lock_irqsave() as the memcg may change then.
>
>Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>Reviewed-by: Zi Yan <ziy@nvidia.com>
>Acked-by: David Hildenbrand <david@redhat.com>
>Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

One nit below

>---
[...]
>@@ -4239,38 +4245,27 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
> 		}
> 		folio_unlock(folio);
> next:
>+		if (did_split || !folio_test_partially_mapped(folio))
>+			continue;
> 		/*
>-		 * split_folio() removes folio from list on success.
> 		 * Only add back to the queue if folio is partially mapped.
> 		 * If thp_underused returns false, or if split_folio fails
> 		 * in the case it was underused, then consider it used and
> 		 * don't add it back to split_queue.
> 		 */
>-		if (did_split) {
>-			; /* folio already removed from list */
>-		} else if (!folio_test_partially_mapped(folio)) {
>-			list_del_init(&folio->_deferred_list);
>-			removed++;
>-		} else {
>-			/*
>-			 * That unlocked list_del_init() above would be unsafe,
>-			 * unless its folio is separated from any earlier folios
>-			 * left on the list (which may be concurrently unqueued)
>-			 * by one safe folio with refcount still raised.
>-			 */
>-			swap(folio, prev);
>+		fqueue = folio_split_queue_lock_irqsave(folio, &flags);
>+		if (list_empty(&folio->_deferred_list)) {
>+			list_add_tail(&folio->_deferred_list, &fqueue->split_queue);
>+			fqueue->split_queue_len++;
> 		}
>-		if (folio)
>-			folio_put(folio);
>+		split_queue_unlock_irqrestore(fqueue, flags);
> 	}
>+	folios_put(&fbatch);
> 
>-	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>-	list_splice_tail(&list, &ds_queue->split_queue);
>-	ds_queue->split_queue_len -= removed;
>-	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>-
>-	if (prev)
>-		folio_put(prev);
>+	if (sc->nr_to_scan && !list_empty(&ds_queue->split_queue)) {

Maybe we can use ds_queue->split_queue_len instead?

>+		cond_resched();
>+		goto retry;
>+	}
> 
> 	/*
> 	 * Stop shrinker if we didn't split any page, but the queue is empty.
>-- 
>2.20.1
>

-- 
Wei Yang
Help you, Help me

