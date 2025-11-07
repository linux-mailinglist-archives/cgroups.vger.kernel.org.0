Return-Path: <cgroups+bounces-11660-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 894F1C3E4B1
	for <lists+cgroups@lfdr.de>; Fri, 07 Nov 2025 03:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 409EB4E23C6
	for <lists+cgroups@lfdr.de>; Fri,  7 Nov 2025 02:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8482DEA80;
	Fri,  7 Nov 2025 02:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPDgsJkZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3CA1D5CC7
	for <cgroups@vger.kernel.org>; Fri,  7 Nov 2025 02:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762484373; cv=none; b=g9/oPF2NU1waH4Ch9LrZzEDU37P8gkTCae90S82KBF8F8PacDzES89TUx4qkhmLDI2T3+4CApvonrbizzMVeS7uIjIHY84WZ+zQLTjl0d+HZOmeicaeZopKOze3B086lQHMl2h455GnWcdOf4esaEVWGebqPEopCbLhw4OK8Ai4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762484373; c=relaxed/simple;
	bh=7kYaO9LAsrQg2gA5NZyjJKOrXGzd5EBEC2uGAfwyk1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaMGOhh9rCE5DC1N3/6XC3fpnAZ2yV/aVbKny/r4gWfl73f/m6NqhWZj4gPH8NnQ6vv35hwl/+CiuhbFk4o6lzQXBzsJa+pRFHA9Xq3z6MhAB0UgrcQaWNmSiF2vbDFOlFJClOoiLZY9AJKRRacXS3FDVK4oAwA2mexekUecwiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPDgsJkZ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b64cdbb949cso53556066b.1
        for <cgroups@vger.kernel.org>; Thu, 06 Nov 2025 18:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762484370; x=1763089170; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRB1Tw7h2xkUcCCy6v82k8nRrxR/9OQEbGB4ap5uUfQ=;
        b=YPDgsJkZa0ALtLZuqIopl9aD4JPOkbCF97uhocZafRj9SWbJAAT09zuYKYa5lnJ7qU
         EI8X3vvdyMfHXTNlglLRWU3hXYKbIrTnc7NYfoI9Un17u7FxhvewG8XYPUVKi0Xpx3J8
         7VffmxA4n+xMvrV3hpcQHn4bbotfeeVXoQvTAo9vGGh+nJtjSh9u17j2nPqukVFnbBLD
         HX2QxC5zIVt77xQ3Elc7NbejdXcTb/AUTr8D7UgulDJinlfJwPt4gQnpgrWy3YngMwmI
         Gtdodcr/SDk7iRrNbcT1PiviBtgWd6pOpBXIPoyvArqvFIqb2T68DGKuZAKsIAV0OZlF
         2JOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762484370; x=1763089170;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IRB1Tw7h2xkUcCCy6v82k8nRrxR/9OQEbGB4ap5uUfQ=;
        b=YCV0TswlbvaUJ5DgGj7LrtoeMpijdhx7hwC0M7yxrTfYvHNTHgFkVhXxn+KKZhXYWG
         BrAGlZun0YZxJg9POi1q/l+BFAgvbTR8i5TttrhDNYAAg65K4YSdXahZ70+6qZ5phGZG
         W+ws4MadHOQMn2CpQU0KpMsIaibsM5IAOR/NMW+bIJmmnkW9CcKhC6XcWX6uPoE7MBmS
         HEEg09ZI8l78mWCb5UzoSH0oEFS7d4yUoctr8mjNlNbt0ioLz3PeKJgBRghv4ODFW/6p
         74XnOCPZlFprIgT2yMrSXuWX2L+I8kmYek31AMNGq2v1oWtP1K7sssuLP8kD5tY5WzHN
         b/KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKXOkRpJfTyqJcC0I4tpsrBTWAT4gGGhiPWTQiCcTuqUFyLdXuPeZ2UOVrorYFekrLLj9HKr7V@vger.kernel.org
X-Gm-Message-State: AOJu0YxCDNTIJnKCEUPmkZPJ9CX6S3GUwfH/YevzPNVBgZVHqKDm1z5Z
	faoHN/vQURILufCH0oGCZzZXcIBBSXVdYSj3/Z2jxBCO74lELfHfTI5M
X-Gm-Gg: ASbGncvyLuZrG6o/siPwFg6PrdN9fRdIEK81if2rqw0J+y0MywIgOSBpQkHWGap+5Nr
	fe+bWfKywYjly+GxsINGAWcW6QtgmGP3iBCyv4epPE8jyM21uNaiFQXQqWKaTdDWvbpwt7CTvdx
	TJ7gg7M5vH3kyYgnQ+Ca9MEXZ6rOZVV/63Eq5hbOTIE1ci5AMQfIf3ul8wGjL1OOHVd5rpxWCNf
	iWrdYvnVTUjw0lN0zQUiKTY74F2AjLWezxJZRrTeukbsllkZ83L2rMTxoYzIgnR9/7dnTBSa6GK
	lOdaArdw08vCpj1IvdPrS+8c1PYft/iTUqnpA7BFLdKTm78nF22lm1VEdicGIN2njB13wck//eE
	5rILcOmxjHdCDoVFEwrtckkypvKwsSq5kCGeexuG4QUWn9A0ZF1o6MRieKRjaQBl1m3bKSlCAPk
	o=
X-Google-Smtp-Source: AGHT+IFYQHUtWFRHWqFYpUOzfeOZKWLRs72LtDXtfw94FiLCK3pbE+9wjzmpCPK3XTLCfJO1tMrm1w==
X-Received: by 2002:a17:907:6d0e:b0:b6d:6c1a:31ae with SMTP id a640c23a62f3a-b72c0d30be8mr136231266b.49.1762484369606;
        Thu, 06 Nov 2025 18:59:29 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbca75bsm117386666b.14.2025.11.06.18.59.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Nov 2025 18:59:29 -0800 (PST)
Date: Fri, 7 Nov 2025 02:59:28 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Wei Yang <richard.weiyang@gmail.com>, hannes@cmpxchg.org,
	hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, david@redhat.com,
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, lance.yang@linux.dev, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v5 3/4] mm: thp: use folio_batch to handle THP splitting
 in deferred_split_scan()
Message-ID: <20251107025928.fkevdc2ftewqrq7y@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <cover.1760509767.git.zhengqi.arch@bytedance.com>
 <4f5d7a321c72dfe65e0e19a3f89180d5988eae2e.1760509767.git.zhengqi.arch@bytedance.com>
 <20251106145213.jblfgslgjzfr3z7h@master>
 <131176ed-8901-4a04-92ce-e270fc536404@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <131176ed-8901-4a04-92ce-e270fc536404@linux.dev>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Nov 07, 2025 at 10:51:15AM +0800, Qi Zheng wrote:
>
>
>On 11/6/25 10:52 PM, Wei Yang wrote:
>> On Wed, Oct 15, 2025 at 02:35:32PM +0800, Qi Zheng wrote:
>> > From: Muchun Song <songmuchun@bytedance.com>
>> > 
>> > The maintenance of the folio->_deferred_list is intricate because it's
>> > reused in a local list.
>> > 
>> > Here are some peculiarities:
>> > 
>> >    1) When a folio is removed from its split queue and added to a local
>> >       on-stack list in deferred_split_scan(), the ->split_queue_len isn't
>> >       updated, leading to an inconsistency between it and the actual
>> >       number of folios in the split queue.
>> > 
>> >    2) When the folio is split via split_folio() later, it's removed from
>> >       the local list while holding the split queue lock. At this time,
>> >       the lock is not needed as it is not protecting anything.
>> > 
>> >    3) To handle the race condition with a third-party freeing or migrating
>> >       the preceding folio, we must ensure there's always one safe (with
>> >       raised refcount) folio before by delaying its folio_put(). More
>> >       details can be found in commit e66f3185fa04 ("mm/thp: fix deferred
>> >       split queue not partially_mapped"). It's rather tricky.
>> > 
>> > We can use the folio_batch infrastructure to handle this clearly. In this
>> > case, ->split_queue_len will be consistent with the real number of folios
>> > in the split queue. If list_empty(&folio->_deferred_list) returns false,
>> > it's clear the folio must be in its split queue (not in a local list
>> > anymore).
>> > 
>> > In the future, we will reparent LRU folios during memcg offline to
>> > eliminate dying memory cgroups, which requires reparenting the split queue
>> > to its parent first. So this patch prepares for using
>> > folio_split_queue_lock_irqsave() as the memcg may change then.
>> > 
>> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> > Reviewed-by: Zi Yan <ziy@nvidia.com>
>> > Acked-by: David Hildenbrand <david@redhat.com>
>> > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
>> > ---
>> > mm/huge_memory.c | 87 +++++++++++++++++++++++-------------------------
>> > 1 file changed, 41 insertions(+), 46 deletions(-)
>> > 
>> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> > index a68f26547cd99..e850bc10da3e2 100644
>> > --- a/mm/huge_memory.c
>> > +++ b/mm/huge_memory.c
>> > @@ -3782,21 +3782,22 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>> > 		struct lruvec *lruvec;
>> > 		int expected_refs;
>> > 
>> > -		if (folio_order(folio) > 1 &&
>> > -		    !list_empty(&folio->_deferred_list)) {
>> > -			ds_queue->split_queue_len--;
>> > +		if (folio_order(folio) > 1) {
>> > +			if (!list_empty(&folio->_deferred_list)) {
>> > +				ds_queue->split_queue_len--;
>> > +				/*
>> > +				 * Reinitialize page_deferred_list after removing the
>> > +				 * page from the split_queue, otherwise a subsequent
>> > +				 * split will see list corruption when checking the
>> > +				 * page_deferred_list.
>> > +				 */
>> > +				list_del_init(&folio->_deferred_list);
>> > +			}
>> > 			if (folio_test_partially_mapped(folio)) {
>> > 				folio_clear_partially_mapped(folio);
>> > 				mod_mthp_stat(folio_order(folio),
>> > 					      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
>> > 			}
>> > -			/*
>> > -			 * Reinitialize page_deferred_list after removing the
>> > -			 * page from the split_queue, otherwise a subsequent
>> > -			 * split will see list corruption when checking the
>> > -			 * page_deferred_list.
>> > -			 */
>> > -			list_del_init(&folio->_deferred_list);
>> 
>> @Andrew
>> 
>> Current mm-new looks not merge the code correctly?
>> 
>> The above removed code is still there.
>> 
>> @Qi
>> 
>> After rescan this, I am confused about this code change.
>> 
>> The difference here is originally it would check/clear partially_mapped if
>> folio is on a list. But now we would do this even folio is not on a list.
>> 
>> If my understanding is correct, after this change, !list_empty() means folio
>> is on its ds_queue. And there are total three places to remove it from
>> ds_queue.
>> 
>>    1) __folio_unqueue_deferred_split()
>>    2) deferred_split_scan()
>>    3) __folio_split()
>> 
>> In 1) and 2) we all clear partially_mapped bit before removing folio from
>> ds_queue, this means if the folio is not on ds_queue in __folio_split(), it is
>> not necessary to check/clear partially_mapped bit.
>
>In deferred_split_scan(), if folio_try_get() succeeds, then only the
>folio will be removed from ds_queue, but not clear partially_mapped.
>

Hmm... you are right. Sorry for the trouble.

>> 
>> Maybe I missed something, would you mind correct me on this?
>> 

-- 
Wei Yang
Help you, Help me

