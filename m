Return-Path: <cgroups+bounces-14998-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AC0XL9JCwWmqRwQAu9opvQ
	(envelope-from <cgroups+bounces-14998-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 14:40:34 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D71D2F31F7
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 14:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C75EC3014883
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 13:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3283A9DAB;
	Mon, 23 Mar 2026 13:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVVTbnDx"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B3940DFC4;
	Mon, 23 Mar 2026 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774272559; cv=none; b=l8cXp/sQgP7PR2sMCxvkopbdokh1kn1DbBPn/idvUpP/roXwsCrD6WoX18TR6fLX3JvLoCanS2rPqt2Y3aFrf8CF/o9526uwmUrdebJ7S78pn9e9xb6HVTDmo7dhaK7c1qyOQE9q9E+jdOz5Pou7GA/SoaKqXONL7FSu0WswCEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774272559; c=relaxed/simple;
	bh=P9eVkuvtmt2z3nk/0veMt1ApqzvU1NdVXo2AoE58exA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDOk6dlbz+fMcVRaPRNTsRmTbXhCDzJ5UxqXtt2FAtDBX3tgd/qy5ElHYIlXWU3f/yc+uCs94q3Kjf/Jj9vo7BPYpZZ8Nqww7fmbpZx3bNIgarhw8BhqbUEV5x61QtqfdgI01Kb2SlI4n3tqRuX1y3xqpcCStVX+/sFuDmlke7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVVTbnDx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5084AC4CEF7;
	Mon, 23 Mar 2026 13:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774272558;
	bh=P9eVkuvtmt2z3nk/0veMt1ApqzvU1NdVXo2AoE58exA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HVVTbnDx7x8iyGtpS6nvyNdpZ2lFZdxuqkD8BwKCh0ozt/dsmdQiuBg9smBtq7zGh
	 mKxVwOuhJlVoSmoyI8kN4wwkGrDq4kQ8/fSZFJBl3EZsNH4MpehQDJmQ2Keb885a1n
	 8GHzS++UgJcsmuTJtz1+UrCyMraXNuUmCbLTsxqulV4eVy75moPlodS9ln6X5VlaxT
	 deCYDw21LzWx2HW0TrjFyWngv2dP9Rc1F5K5HrjfsEr9dtrWrzn/SqPjPCqkPiQDE9
	 ctssjasWQbvfsj5syAygeQ1crEEVFkIfjCgOJUW7kaskyn+KXPE5ab3uP0otEUa/IK
	 sgwf48SEimMtw==
Date: Mon, 23 Mar 2026 22:29:16 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, david@kernel.org, lorenzo.stoakes@oracle.com,
	ziy@nvidia.com, harry.yoo@oracle.com, yosry.ahmed@linux.dev,
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	chenridong@huaweicloud.com, mkoutny@suse.com,
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com, lance.yang@linux.dev, bhe@redhat.com,
	usamaarif642@gmail.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v6 26/33] mm: vmscan: prepare for reparenting MGLRU folios
Message-ID: <acFALMLIvjP4i76U@hyeyoo>
References: <cover.1772711148.git.zhengqi.arch@bytedance.com>
 <e75050354cdbc42221a04f7cf133292b61105548.1772711148.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e75050354cdbc42221a04f7cf133292b61105548.1772711148.git.zhengqi.arch@bytedance.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14998-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email,bytedance.com:email]
X-Rspamd-Queue-Id: 9D71D2F31F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 05, 2026 at 07:52:44PM +0800, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Similar to traditional LRU folios, in order to solve the dying memcg
> problem, we also need to reparenting MGLRU folios to the parent memcg when
> memcg offline.
> 
> However, there are the following challenges:
> 
> 1. Each lruvec has between MIN_NR_GENS and MAX_NR_GENS generations, the
>    number of generations of the parent and child memcg may be different,
>    so we cannot simply transfer MGLRU folios in the child memcg to the
>    parent memcg as we did for traditional LRU folios.
> 2. The generation information is stored in folio->flags, but we cannot
>    traverse these folios while holding the lru lock, otherwise it may
>    cause softlockup.
> 3. In walk_update_folio(), the gen of folio and corresponding lru size
>    may be updated, but the folio is not immediately moved to the
>    corresponding lru list. Therefore, there may be folios of different
>    generations on an LRU list.
> 4. In lru_gen_del_folio(), the generation to which the folio belongs is
>    found based on the generation information in folio->flags, and the
>    corresponding LRU size will be updated. Therefore, we need to update
>    the lru size correctly during reparenting, otherwise the lru size may
>    be updated incorrectly in lru_gen_del_folio().
> 
> Finally, this patch chose a compromise method, which is to splice the lru
> list in the child memcg to the lru list of the same generation in the
> parent memcg during reparenting. And in order to ensure that the parent
> memcg has the same generation, we need to increase the generations in the
> parent memcg to the MAX_NR_GENS before reparenting.
> 
> Of course, the same generation has different meanings in the parent and
> child memcg, this will cause confusion in the hot and cold information of
> folios. But other than that, this method is simple enough, the lru size
> is correct, and there is no need to consider some concurrency issues (such
> as lru_gen_del_folio()).
> 
> To prepare for the above work, this commit implements the specific
> functions, which will be used during reparenting.
> 
> Suggested-by: Harry Yoo <harry.yoo@oracle.com>
> Suggested-by: Imran Khan <imran.f.khan@oracle.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: Harry Yoo <harry.yoo@oracle.com>
> ---
> +/*
> + * Compared to traditional LRU, MGLRU faces the following challenges:
> + *
> + * 1. Each lruvec has between MIN_NR_GENS and MAX_NR_GENS generations, the
> + *    number of generations of the parent and child memcg may be different,
> + *    so we cannot simply transfer MGLRU folios in the child memcg to the
> + *    parent memcg as we did for traditional LRU folios.
> + * 2. The generation information is stored in folio->flags, but we cannot
> + *    traverse these folios while holding the lru lock, otherwise it may
> + *    cause softlockup.
> + * 3. In walk_update_folio(), the gen of folio and corresponding lru size
> + *    may be updated, but the folio is not immediately moved to the
> + *    corresponding lru list. Therefore, there may be folios of different
> + *    generations on an LRU list.
> + * 4. In lru_gen_del_folio(), the generation to which the folio belongs is
> + *    found based on the generation information in folio->flags, and the
> + *    corresponding LRU size will be updated. Therefore, we need to update
> + *    the lru size correctly during reparenting, otherwise the lru size may
> + *    be updated incorrectly in lru_gen_del_folio().
> + *
> + * Finally, we choose a compromise method, which is to splice the lru list in
> + * the child memcg to the lru list of the same generation in the parent memcg
> + * during reparenting.
> + *
> + * The same generation has different meanings in the parent and child memcg,
> + * so this compromise method will cause the LRU inversion problem. But as the
> + * system runs, this problem will be fixed automatically.
> + */
> +static void __lru_gen_reparent_memcg(struct lruvec *child_lruvec, struct lruvec *parent_lruvec,
> +				     int zone, int type)
> +{
> +	struct lru_gen_folio *child_lrugen, *parent_lrugen;
> +	enum lru_list lru = type * LRU_INACTIVE_FILE;
> +	int i;
> +
> +	child_lrugen = &child_lruvec->lrugen;
> +	parent_lrugen = &parent_lruvec->lrugen;
> +
> +	for (i = 0; i < get_nr_gens(child_lruvec, type); i++) {
> +		int gen = lru_gen_from_seq(child_lrugen->max_seq - i);
> +		long nr_pages = child_lrugen->nr_pages[gen][type][zone];
> +		int child_lru_active = lru_gen_is_active(child_lruvec, gen) ? LRU_ACTIVE : 0;
> +		int parent_lru_active = lru_gen_is_active(parent_lruvec, gen) ? LRU_ACTIVE : 0;

Not a correctness thing, but...

> +		/* Assuming that child pages are colder than parent pages */
> +		list_splice_init(&child_lrugen->folios[gen][type][zone],
> +				 &parent_lrugen->folios[gen][type][zone]);

I think the other end (tail) is where cold pages go in MGLRU just like
in the traditional LRU, since  lru_to_folio(head) returns the tail folio?

> +		WRITE_ONCE(child_lrugen->nr_pages[gen][type][zone], 0);
> +		WRITE_ONCE(parent_lrugen->nr_pages[gen][type][zone],
> +			   parent_lrugen->nr_pages[gen][type][zone] + nr_pages);
> +
> +		if (lru_gen_is_active(child_lruvec, gen) != lru_gen_is_active(parent_lruvec, gen)) {
> +			__update_lru_size(child_lruvec, lru + child_lru_active, zone, -nr_pages);
> +			__update_lru_size(parent_lruvec, lru + parent_lru_active, zone, nr_pages);
> +		}
> +	}
> +}

-- 
Cheers,
Harry / Hyeonggon

