Return-Path: <cgroups+bounces-16516-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OZWDRGJHWrAbQkAu9opvQ
	(envelope-from <cgroups+bounces-16516-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 15:28:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9592A620095
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 15:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3033C301D307
	for <lists+cgroups@lfdr.de>; Mon,  1 Jun 2026 13:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB5A372057;
	Mon,  1 Jun 2026 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VS5JAOKQ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CC43A544E
	for <cgroups@vger.kernel.org>; Mon,  1 Jun 2026 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780320108; cv=none; b=uOTZhREO8FTSr4gt5X7jkDR4kzlu0XXxoe11MheTWqA9JcjKBSNDuLaIQjSjElwp2F3dOJLGXkuj722CcP6sOWhuEozoUS/KaAxBUGK/xPzw2sFHs27qBVqBcLXKeRVBpSMksoJi/PfJOJ9Ux2cpFXfCIoZBZFmhDKmrYhX5SlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780320108; c=relaxed/simple;
	bh=ebCKDyfzRHth1EEtv0OJWII8KGWcouKKxG+A66kpqZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qme/4q8XDpVI96OlkT47MQDB+RBXf0MnFqAbqaCFjgWb47FKG0Tj6OEUP+vlfhaY7TVSsAsV2t4bZSIHfqN/t74rASc5LOL7xF6y3dFnZWe3TWq9QLfMBwnpPL4nV1AA+THBhlONkWZYzjM3Z7SDCU1lAB5feRRisAIBxjqEV+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VS5JAOKQ; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780320104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=io/nWNe86lhvjJWsubKx+bggG1DCxvRqyS7n1xMOY/s=;
	b=VS5JAOKQy+tQJA3X0tyQ+VPzBr0usyd3U2XwNbpi+S72w1R3mZ0hN5nhEjzmdeRGKdqsIZ
	ml1rA0qowCaJ3Wb8Z7oks84ILx8+GdHCezYkfd1MjmySVCDLBuMExOPVCJSy0/4XV/4a04
	bnannMrYBKhS4p10E5HXbvqyDtBo3RE=
From: Lance Yang <lance.yang@linux.dev>
To: hannes@cmpxchg.org,
	baolin.wang@linux.alibaba.com
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	shakeel.butt@linux.dev,
	mhocko@kernel.org,
	david@fromorbit.com,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	qi.zheng@linux.dev,
	yosry.ahmed@linux.dev,
	ziy@nvidia.com,
	liam@infradead.org,
	usama.arif@linux.dev,
	kas@kernel.org,
	vbabka@kernel.org,
	ryncsn@gmail.com,
	zaslonko@linux.ibm.com,
	gor@linux.ibm.com,
	baohua@kernel.org,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	npache@redhat.com,
	ryan.roberts@arm.com,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 9/9] mm: switch deferred split shrinker to list_lru
Date: Mon,  1 Jun 2026 21:21:35 +0800
Message-Id: <20260601132135.14272-1-lance.yang@linux.dev>
In-Reply-To: <20260527204757.2544958-10-hannes@cmpxchg.org>
References: <20260527204757.2544958-10-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16516-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_TWELVE(0.00)[28];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 9592A620095
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, May 27, 2026 at 04:45:16PM -0400, Johannes Weiner wrote:
[...]
>diff --git a/mm/swap_state.c b/mm/swap_state.c
>index 04f5ce992401..9c3a5cf99778 100644
>--- a/mm/swap_state.c
>+++ b/mm/swap_state.c
>@@ -465,6 +465,16 @@ static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
> 		return ERR_PTR(-ENOMEM);
> 	}
> 

Shouldn't this be limited to anon swapin?

e.g. vmf && vma_is_anonymous(vmf->vma)

>+	if (order > 1 && folio_memcg_alloc_deferred(folio)) {

__swap_cache_alloc() is also used by shmem direct swapin, so shmem can
get here too when handling a large swap entry:

shmem_get_folio_gfp()
  shmem_swapin_folio()
    shmem_swap_alloc_folio()
      swapin_sync()
        swap_cache_alloc_folio()
          __swap_cache_alloc()
            folio_memcg_alloc_deferred()

@Baolin please correct me if I got it wrong :)

folio_memcg_alloc_deferred() itself doesn't filter shmem out either; it
only allocates the memcg list_lru metadata for deferred_split_lru:

int folio_memcg_alloc_deferred(struct folio *folio)
{
	if (mem_cgroup_disabled())
		return 0;
	return folio_memcg_list_lru_alloc(folio, &deferred_split_lru, GFP_KERNEL);
}

Since deferred_split_lru only queues anon large folios, doing this for
shmem swapin doesn't buy us anything :)

Maybe I'm missing something, just wanted to raise it.

>+		spin_lock(&ci->lock);
>+		__swap_cache_do_del_folio(ci, folio, entry, shadow);
>+		spin_unlock(&ci->lock);
>+		folio_unlock(folio);
>+		/* nr_pages refs from swap cache, 1 from allocation */
>+		folio_put_refs(folio, nr_pages + 1);
>+		return ERR_PTR(-ENOMEM);
>+	}
>+
> 	/* memsw uncharges swap when folio is added to swap cache */
> 	memcg1_swapin(folio);
> 	if (shadow)
>-- 
>2.54.0
>
>

