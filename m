Return-Path: <cgroups+bounces-7956-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF03AA4ED0
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 16:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88DF6189C527
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 14:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF8725DCE9;
	Wed, 30 Apr 2025 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="mvl71Vpb"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB8825DD19
	for <cgroups@vger.kernel.org>; Wed, 30 Apr 2025 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746023844; cv=none; b=qF591zvzZWY3CJloxY1eqhkKG8Z3KZ5odNkuIvcxWedcJ8TE4GdhcyqY0bIjCaKOlwWkxx+PV3U4snSdZoX6Ch9d9k0za9LjiSLnEBvFmCQoImp0TaaqODBj1/+u09D+BKjUWWGFL5VQ99WnOmqDTCftIQRKL0mxiC7Fz+tuHw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746023844; c=relaxed/simple;
	bh=x7bH5IM/o9aq40OpfG0lr+55flVGQfdSrcby2S7JJ5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDRZUUmVfxKJIHu/ChB6Ioy2zHYDRYMvkcixPwt3DjsLe+SzkcUFc+JdlCjhieJryIY3CpU9MSndW+Vv8S1Z0AeulzbUEQCu9btjywWaa2iNc0REQe0skW2Q9wgjhcV9yEQEuOD+VDn+qZps2RtY6LKPY3lutdCRTsO+y7wWYQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=mvl71Vpb; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c5aecec8f3so1286658285a.1
        for <cgroups@vger.kernel.org>; Wed, 30 Apr 2025 07:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1746023839; x=1746628639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MzVj9ui+z7nAPJ/VH08Dz8u4s9z3xTyhLsSPXPC81XI=;
        b=mvl71Vpbo+MKrJ3C2JKEGiDqKZiZ+N59zynMpkaMGfqNniwGfalQIXv2nMeq7CmLfC
         IY3m4Qen9ISyUbHHzCe1TbgJk+VK1i5ywoz2uhAEL4gDzbFuJgmskHxRz4uAxljuZhfv
         +x5ZopxXnsxcxQ+S3iGeEa64KdQVDe7iNJXELOviOLvNdKHqO5AiKq1W0OgR4cjmPb62
         /EgPeLUhobzKIac1rjTRmqLX7u1p04m1Y0TYjH0Nh2abCeLJlPOspOV2XZruAU6Nyg64
         QS/6ro8sjMOgK/2DzBVUGbRc4G6aBJbGeKjxyZp6NzYxj9v86NjogqDZ6vX0mHAXIX0l
         dyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746023839; x=1746628639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzVj9ui+z7nAPJ/VH08Dz8u4s9z3xTyhLsSPXPC81XI=;
        b=VInJ1sKU1ZS+g45lodDR8jIvyrgVW8brxzdqXaWXDVq9fUaD6BBE8F1I5h1mTZbUGv
         pX2RAWvEwSk4HbqQy0c2LkS0Jk9DTixzPxbHJ5JtXJ9Z8QGd+O7v7pIOamDGh9qbx22O
         Nm1YvoBUKMbj7698b2LkRw1TgPlDMFFLHzwsMSEQM+o6UjUMy/CATsiILGDoZmRurzT+
         Pkgcjzed+hKOTf6zBg1aKUMVL7YJn+4q6ztLNoitsVCJJiKZtEfQ8pKuw4SO/Y+DD5k0
         077T1iWc5h7BRGJeh0ibvJeT7zh5hrK0szRoSxM6dViYTHHRNWIyruYMVYcAAct79I4Z
         OaJw==
X-Forwarded-Encrypted: i=1; AJvYcCVDF/kW74QbqaIEUceOXcVAfZyMsBL1JWrvgV3Zfogvg9yofW8okw7H4Ka8bmow4GnkOMIOaKu7@vger.kernel.org
X-Gm-Message-State: AOJu0YyUnIczKgWBzxc6Lt5fdoisgtqd80QcIEXVqDwkLD3dMscSRIU5
	z6Q8hQJOxqSHici+8sE+gFTADWElbQeFh+T7W7CtQviLOvPaeHExbkud8OsV+zY=
X-Gm-Gg: ASbGnctD91oz0RyRuUVI/XiWDbabza5EnatV+iGqzdyWPOGhe4vgjIp+0hIY2ey4V/A
	dFH5VZjjzBDm6jtkEqy5fKLEHI2i7B3ggyZg8LdWpAO8/wTf5r7iurMmoh4lpag8TFtXY3oP1gx
	/p5bZ08FJ2zU137gtBB6RJx5aeu7iG7tMcX9s15veQjfW3oN05vD87RKqTB7u8nx7Wx+pIIjIyR
	KIgEKjjiJuZKSdnsQSsmgXFZJXFfD0+pKD2k8KNdJ7JlxrHdawUO8rHq/DfWCAARg2cpqfLbSm1
	9V18350ambg2zK8xWz/XwAgSBe6SkIXjuopU1ic=
X-Google-Smtp-Source: AGHT+IF/g0RVsanqksAWT9Fbsscv/im0UZWq7N41chxmZ092JzV8NwJVeYMDw+WxTk+jdjo8RoJDcQ==
X-Received: by 2002:a05:620a:2404:b0:7c5:dfd6:dc7b with SMTP id af79cd13be357-7cac7e26161mr407447985a.22.1746023839465;
        Wed, 30 Apr 2025 07:37:19 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c958d871efsm859944785a.84.2025.04.30.07.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 07:37:18 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:37:14 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	david@fromorbit.com, zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev, nphamcs@gmail.com, chengming.zhou@linux.dev,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH RFC 07/28] mm: thp: use folio_batch to handle THP
 splitting in deferred_split_scan()
Message-ID: <20250430143714.GA2020@cmpxchg.org>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <20250415024532.26632-8-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415024532.26632-8-songmuchun@bytedance.com>

On Tue, Apr 15, 2025 at 10:45:11AM +0800, Muchun Song wrote:
> The maintenance of the folio->_deferred_list is intricate because it's
> reused in a local list.
> 
> Here are some peculiarities:
> 
>    1) When a folio is removed from its split queue and added to a local
>       on-stack list in deferred_split_scan(), the ->split_queue_len isn't
>       updated, leading to an inconsistency between it and the actual
>       number of folios in the split queue.
> 
>    2) When the folio is split via split_folio() later, it's removed from
>       the local list while holding the split queue lock. At this time,
>       this lock protects the local list, not the split queue.
> 
>    3) To handle the race condition with a third-party freeing or migrating
>       the preceding folio, we must ensure there's always one safe (with
>       raised refcount) folio before by delaying its folio_put(). More
>       details can be found in commit e66f3185fa04. It's rather tricky.
> 
> We can use the folio_batch infrastructure to handle this clearly. In this
> case, ->split_queue_len will be consistent with the real number of folios
> in the split queue. If list_empty(&folio->_deferred_list) returns false,
> it's clear the folio must be in its split queue (not in a local list
> anymore).
> 
> In the future, we aim to reparent LRU folios during memcg offline to
> eliminate dying memory cgroups. This patch prepares for using
> folio_split_queue_lock_irqsave() as folio memcg may change then.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

This is a very nice simplification. And getting rid of the stack list
and its subtle implication on all the various current and future
list_empty(&folio->_deferred_list) checks should be much more robust.

However, I think there is one snag related to this:

> ---
>  mm/huge_memory.c | 69 +++++++++++++++++++++---------------------------
>  1 file changed, 30 insertions(+), 39 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 70820fa75c1f..d2bc943a40e8 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4220,40 +4220,47 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>  	struct pglist_data *pgdata = NODE_DATA(sc->nid);
>  	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
>  	unsigned long flags;
> -	LIST_HEAD(list);
> -	struct folio *folio, *next, *prev = NULL;
> -	int split = 0, removed = 0;
> +	struct folio *folio, *next;
> +	int split = 0, i;
> +	struct folio_batch fbatch;
> +	bool done;
>  
>  #ifdef CONFIG_MEMCG
>  	if (sc->memcg)
>  		ds_queue = &sc->memcg->deferred_split_queue;
>  #endif
> -
> +	folio_batch_init(&fbatch);
> +retry:
> +	done = true;
>  	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>  	/* Take pin on all head pages to avoid freeing them under us */
>  	list_for_each_entry_safe(folio, next, &ds_queue->split_queue,
>  							_deferred_list) {
>  		if (folio_try_get(folio)) {
> -			list_move(&folio->_deferred_list, &list);
> -		} else {
> +			folio_batch_add(&fbatch, folio);
> +		} else if (folio_test_partially_mapped(folio)) {
>  			/* We lost race with folio_put() */
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
>  		}
> +		list_del_init(&folio->_deferred_list);
> +		ds_queue->split_queue_len--;
>  		if (!--sc->nr_to_scan)
>  			break;
> +		if (folio_batch_space(&fbatch) == 0) {
> +			done = false;
> +			break;
> +		}
>  	}
>  	split_queue_unlock_irqrestore(ds_queue, flags);
>  
> -	list_for_each_entry_safe(folio, next, &list, _deferred_list) {
> +	for (i = 0; i < folio_batch_count(&fbatch); i++) {
>  		bool did_split = false;
>  		bool underused = false;
> +		struct deferred_split *fqueue;
>  
> +		folio = fbatch.folios[i];
>  		if (!folio_test_partially_mapped(folio)) {
>  			underused = thp_underused(folio);
>  			if (!underused)
> @@ -4269,39 +4276,23 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>  		}
>  		folio_unlock(folio);
>  next:
> +		if (did_split || !folio_test_partially_mapped(folio))
> +			continue;

There IS a list_empty() check in the splitting code that we actually
relied on, for cleaning up the partially_mapped state and counter:

		    !list_empty(&folio->_deferred_list)) {
			ds_queue->split_queue_len--;
			if (folio_test_partially_mapped(folio)) {
				folio_clear_partially_mapped(folio);
				mod_mthp_stat(folio_order(folio),
					      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
			}
			/*
			 * Reinitialize page_deferred_list after removing the
			 * page from the split_queue, otherwise a subsequent
			 * split will see list corruption when checking the
			 * page_deferred_list.
			 */
			list_del_init(&folio->_deferred_list);

With the folios isolated up front, it looks like you need to handle
this from the shrinker.

Otherwise this looks correct to me. But this code is subtle, I would
feel much better if Hugh (CC-ed) could take a look as well.

Thanks!

>  		/*
> -		 * split_folio() removes folio from list on success.
>  		 * Only add back to the queue if folio is partially mapped.
>  		 * If thp_underused returns false, or if split_folio fails
>  		 * in the case it was underused, then consider it used and
>  		 * don't add it back to split_queue.
>  		 */
> -		if (did_split) {
> -			; /* folio already removed from list */
> -		} else if (!folio_test_partially_mapped(folio)) {
> -			list_del_init(&folio->_deferred_list);
> -			removed++;
> -		} else {
> -			/*
> -			 * That unlocked list_del_init() above would be unsafe,
> -			 * unless its folio is separated from any earlier folios
> -			 * left on the list (which may be concurrently unqueued)
> -			 * by one safe folio with refcount still raised.
> -			 */
> -			swap(folio, prev);
> -		}
> -		if (folio)
> -			folio_put(folio);
> +		fqueue = folio_split_queue_lock_irqsave(folio, &flags);
> +		list_add_tail(&folio->_deferred_list, &fqueue->split_queue);
> +		fqueue->split_queue_len++;
> +		split_queue_unlock_irqrestore(fqueue, flags);
>  	}
> +	folios_put(&fbatch);
>  
> -	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> -	list_splice_tail(&list, &ds_queue->split_queue);
> -	ds_queue->split_queue_len -= removed;
> -	split_queue_unlock_irqrestore(ds_queue, flags);
> -
> -	if (prev)
> -		folio_put(prev);
> -
> +	if (!done)
> +		goto retry;
>  	/*
>  	 * Stop shrinker if we didn't split any page, but the queue is empty.
>  	 * This can happen if pages were freed under us.
> -- 
> 2.20.1

