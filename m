Return-Path: <cgroups+bounces-15009-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPIoAnn7wWlSYgQAu9opvQ
	(envelope-from <cgroups+bounces-15009-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 03:48:25 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB42301505
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 03:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 714E6304E328
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 02:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DDC388E60;
	Tue, 24 Mar 2026 02:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a/glTq6O"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23566388E6C
	for <cgroups@vger.kernel.org>; Tue, 24 Mar 2026 02:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774320408; cv=none; b=e3fODoyriqBpBh+kYdqOtTCYfYCS2+KxGLI6dU9xcpwqqtSr3ImuWLNrhgH/RU4O1ZzxA5A90QWBpF8r2fiT6OZcqlPkL6CUA5j39zO+V4daC+LEliHWSv8p7u6TfRqOrdzEEtESjprr2A++3dz6z/IijedvRZJcT6Wqql5sJjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774320408; c=relaxed/simple;
	bh=1FYuLNdWS0USt95/63h5h3/CEmUJ86hIDzG1HPJ/Efc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f2l7KAT/ry5K1OMPcQJYqDZCJA8CrZ5i5tIt4q1wAsqSVPZYbwPDzdJkXfB/cpgszfSnViueVGkwPWe4sHB6f1OP4HneSt8pQvKwtDDBxB+NEU6ZYQBSKp6dG17+UGSaI0/64QvVPSquwb9iQEBPD93w2BmF1ajdJkWbfpOyY0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a/glTq6O; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a17b441e-fe6f-4e5c-ab26-0ab71475fbbc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774320395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qGGy2UriqUad3XopEFOCAp7JAApD+roBCI5i10BvlVY=;
	b=a/glTq6OdDzqBk054fBaNRf1YQfSf9qqa7zrtsfqKjMT3HrWJygwOce3dCrKDI4GSd3pED
	v8DRAwlqTMrxaaax61tUHbDrPY4EpNBhEZUV0NakFcOZckuBTbbPVoc/RROZXQ/4LmTx6a
	MePPyWSY1LxmmfhvQscxvIgF0NUGahY=
Date: Tue, 24 Mar 2026 10:46:12 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 26/33] mm: vmscan: prepare for reparenting MGLRU folios
To: "Harry Yoo (Oracle)" <harry@kernel.org>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 harry.yoo@oracle.com, yosry.ahmed@linux.dev, imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com,
 akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
 apais@linux.microsoft.com, lance.yang@linux.dev, bhe@redhat.com,
 usamaarif642@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1772711148.git.zhengqi.arch@bytedance.com>
 <e75050354cdbc42221a04f7cf133292b61105548.1772711148.git.zhengqi.arch@bytedance.com>
 <acFALMLIvjP4i76U@hyeyoo>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <acFALMLIvjP4i76U@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15009-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid,oracle.com:email]
X-Rspamd-Queue-Id: 5BB42301505
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/23/26 9:29 PM, Harry Yoo (Oracle) wrote:
> On Thu, Mar 05, 2026 at 07:52:44PM +0800, Qi Zheng wrote:
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> Similar to traditional LRU folios, in order to solve the dying memcg
>> problem, we also need to reparenting MGLRU folios to the parent memcg when
>> memcg offline.
>>
>> However, there are the following challenges:
>>
>> 1. Each lruvec has between MIN_NR_GENS and MAX_NR_GENS generations, the
>>     number of generations of the parent and child memcg may be different,
>>     so we cannot simply transfer MGLRU folios in the child memcg to the
>>     parent memcg as we did for traditional LRU folios.
>> 2. The generation information is stored in folio->flags, but we cannot
>>     traverse these folios while holding the lru lock, otherwise it may
>>     cause softlockup.
>> 3. In walk_update_folio(), the gen of folio and corresponding lru size
>>     may be updated, but the folio is not immediately moved to the
>>     corresponding lru list. Therefore, there may be folios of different
>>     generations on an LRU list.
>> 4. In lru_gen_del_folio(), the generation to which the folio belongs is
>>     found based on the generation information in folio->flags, and the
>>     corresponding LRU size will be updated. Therefore, we need to update
>>     the lru size correctly during reparenting, otherwise the lru size may
>>     be updated incorrectly in lru_gen_del_folio().
>>
>> Finally, this patch chose a compromise method, which is to splice the lru
>> list in the child memcg to the lru list of the same generation in the
>> parent memcg during reparenting. And in order to ensure that the parent
>> memcg has the same generation, we need to increase the generations in the
>> parent memcg to the MAX_NR_GENS before reparenting.
>>
>> Of course, the same generation has different meanings in the parent and
>> child memcg, this will cause confusion in the hot and cold information of
>> folios. But other than that, this method is simple enough, the lru size
>> is correct, and there is no need to consider some concurrency issues (such
>> as lru_gen_del_folio()).
>>
>> To prepare for the above work, this commit implements the specific
>> functions, which will be used during reparenting.
>>
>> Suggested-by: Harry Yoo <harry.yoo@oracle.com>
>> Suggested-by: Imran Khan <imran.f.khan@oracle.com>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Acked-by: Harry Yoo <harry.yoo@oracle.com>
>> ---
>> +/*
>> + * Compared to traditional LRU, MGLRU faces the following challenges:
>> + *
>> + * 1. Each lruvec has between MIN_NR_GENS and MAX_NR_GENS generations, the
>> + *    number of generations of the parent and child memcg may be different,
>> + *    so we cannot simply transfer MGLRU folios in the child memcg to the
>> + *    parent memcg as we did for traditional LRU folios.
>> + * 2. The generation information is stored in folio->flags, but we cannot
>> + *    traverse these folios while holding the lru lock, otherwise it may
>> + *    cause softlockup.
>> + * 3. In walk_update_folio(), the gen of folio and corresponding lru size
>> + *    may be updated, but the folio is not immediately moved to the
>> + *    corresponding lru list. Therefore, there may be folios of different
>> + *    generations on an LRU list.
>> + * 4. In lru_gen_del_folio(), the generation to which the folio belongs is
>> + *    found based on the generation information in folio->flags, and the
>> + *    corresponding LRU size will be updated. Therefore, we need to update
>> + *    the lru size correctly during reparenting, otherwise the lru size may
>> + *    be updated incorrectly in lru_gen_del_folio().
>> + *
>> + * Finally, we choose a compromise method, which is to splice the lru list in
>> + * the child memcg to the lru list of the same generation in the parent memcg
>> + * during reparenting.
>> + *
>> + * The same generation has different meanings in the parent and child memcg,
>> + * so this compromise method will cause the LRU inversion problem. But as the
>> + * system runs, this problem will be fixed automatically.
>> + */
>> +static void __lru_gen_reparent_memcg(struct lruvec *child_lruvec, struct lruvec *parent_lruvec,
>> +				     int zone, int type)
>> +{
>> +	struct lru_gen_folio *child_lrugen, *parent_lrugen;
>> +	enum lru_list lru = type * LRU_INACTIVE_FILE;
>> +	int i;
>> +
>> +	child_lrugen = &child_lruvec->lrugen;
>> +	parent_lrugen = &parent_lruvec->lrugen;
>> +
>> +	for (i = 0; i < get_nr_gens(child_lruvec, type); i++) {
>> +		int gen = lru_gen_from_seq(child_lrugen->max_seq - i);
>> +		long nr_pages = child_lrugen->nr_pages[gen][type][zone];
>> +		int child_lru_active = lru_gen_is_active(child_lruvec, gen) ? LRU_ACTIVE : 0;
>> +		int parent_lru_active = lru_gen_is_active(parent_lruvec, gen) ? LRU_ACTIVE : 0;
> 
> Not a correctness thing, but...
> 
>> +		/* Assuming that child pages are colder than parent pages */
>> +		list_splice_init(&child_lrugen->folios[gen][type][zone],
>> +				 &parent_lrugen->folios[gen][type][zone]);
> 
> I think the other end (tail) is where cold pages go in MGLRU just like
> in the traditional LRU, since  lru_to_folio(head) returns the tail folio?

I checked the history, and in v2 we used list_splice_tail_init() here,
but I don't know why I changed it to list_splice_init() in v3.

Right, lru_to_folio(head) returns the tail folio, and lruvec_add_folio()
adds folio to the head, so the tail page is colder, so now I think we
should go back and use list_splice_tail_init().

Thanks,
Qi

> 
>> +		WRITE_ONCE(child_lrugen->nr_pages[gen][type][zone], 0);
>> +		WRITE_ONCE(parent_lrugen->nr_pages[gen][type][zone],
>> +			   parent_lrugen->nr_pages[gen][type][zone] + nr_pages);
>> +
>> +		if (lru_gen_is_active(child_lruvec, gen) != lru_gen_is_active(parent_lruvec, gen)) {
>> +			__update_lru_size(child_lruvec, lru + child_lru_active, zone, -nr_pages);
>> +			__update_lru_size(parent_lruvec, lru + parent_lru_active, zone, nr_pages);
>> +		}
>> +	}
>> +}
> 


