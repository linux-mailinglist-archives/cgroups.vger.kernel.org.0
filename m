Return-Path: <cgroups+bounces-16753-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SeQnDNKGJ2o7ygIAu9opvQ
	(envelope-from <cgroups+bounces-16753-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 05:21:54 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B9065C056
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 05:21:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=FZke0vfO;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16753-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16753-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37A013073480
	for <lists+cgroups@lfdr.de>; Tue,  9 Jun 2026 03:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988C03655EB;
	Tue,  9 Jun 2026 03:21:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C2F3603DB
	for <cgroups@vger.kernel.org>; Tue,  9 Jun 2026 03:21:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780975297; cv=none; b=qE/EohabQnbYTGoLak3y+Dz3vLzgPY2P4rnetcCLHUZ/FC9AeDKLDfiwdYdt7aG9/OzJ3oGz38ip2lZB9TX8pJkKWs8u3hKyOfz6FPBRZkAt7FNYAklC2yu5rEqt6kmHRB+VdrJkC+5erOh0NHbgp5bJJA7GDdONN7CbJhKJwRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780975297; c=relaxed/simple;
	bh=wATMRDzNJdCbN5HuzQxjF6c7i7/DlB+3OtSVfRbNmr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d4gD8phsN//dQaB0tp+3/REQUKJOBlAnaPe87NN03+NekswmuzSqu662dbs73ryo00XCWd/8eM2rlzRTLxWElfNjG4tAYeRDpbBfrkU72OYCg/IH1VBNg9z9nGs1a6LA9CrjrD2YXjoGgLWkTmr+jVMwil6OxrCb2QY6kzgFjvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FZke0vfO; arc=none smtp.client-ip=95.215.58.181
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780975283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xlehNq+dGhjF8xlBwPq9xUEl93005P8DJEDN49foV2w=;
	b=FZke0vfO68yr6RGe+gmExYKpGubD3NRE4r0BoJb/bgJd1TBzspF/AJkmv3vdYQ21xphqqT
	GO3OdzWzK4UGast1YrK+Oz22+ee21ay+UTrsAJ/sfTXt82KPv26klQsKExZBVj2Y82Gykb
	gWOI/qBsQAz01ln6jRz1jxcjWYDh1vs=
From: Lance Yang <lance.yang@linux.dev>
To: hannes@cmpxchg.org
Cc: lance.yang@linux.dev,
	baolin.wang@linux.alibaba.com,
	akpm@linux-foundation.org,
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
	npache@redhat.com,
	ryan.roberts@arm.com,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 9/9] mm: switch deferred split shrinker to list_lru
Date: Tue,  9 Jun 2026 11:20:58 +0800
Message-Id: <20260609032058.23770-1-lance.yang@linux.dev>
In-Reply-To: <ah3MuK3GuimKVORB@cmpxchg.org>
References: <ah3MuK3GuimKVORB@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,linux.alibaba.com,linux-foundation.org,kernel.org,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16753-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hannes@cmpxchg.org,m:lance.yang@linux.dev,m:baolin.wang@linux.alibaba.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:david@fromorbit.com,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:qi.zheng@linux.dev,m:yosry.ahmed@linux.dev,m:ziy@nvidia.com,m:liam@infradead.org,m:usama.arif@linux.dev,m:kas@kernel.org,m:vbabka@kernel.org,m:ryncsn@gmail.com,m:zaslonko@linux.ibm.com,m:gor@linux.ibm.com,m:baohua@kernel.org,m:dev.jain@arm.com,m:npache@redhat.com,m:ryan.roberts@arm.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[lance.yang@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 95B9065C056


On Mon, Jun 01, 2026 at 02:17:28PM -0400, Johannes Weiner wrote:
>On Mon, Jun 01, 2026 at 09:21:35PM +0800, Lance Yang wrote:
>> 
>> On Wed, May 27, 2026 at 04:45:16PM -0400, Johannes Weiner wrote:
>> [...]
>> >diff --git a/mm/swap_state.c b/mm/swap_state.c
>> >index 04f5ce992401..9c3a5cf99778 100644
>> >--- a/mm/swap_state.c
>> >+++ b/mm/swap_state.c
>> >@@ -465,6 +465,16 @@ static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
>> > 		return ERR_PTR(-ENOMEM);
>> > 	}
>> > 
>> 
>> Shouldn't this be limited to anon swapin?
>> 
>> e.g. vmf && vma_is_anonymous(vmf->vma)
>> 
>> >+	if (order > 1 && folio_memcg_alloc_deferred(folio)) {
>> 
>> __swap_cache_alloc() is also used by shmem direct swapin, so shmem can
>> get here too when handling a large swap entry:
>> 
>> shmem_get_folio_gfp()
>>   shmem_swapin_folio()
>>     shmem_swap_alloc_folio()
>>       swapin_sync()
>>         swap_cache_alloc_folio()
>>           __swap_cache_alloc()
>>             folio_memcg_alloc_deferred()
>
>Good catch, I think you're right. I shouldn't have dismissed that
>branch due to "/* Direct swapin skipping swap cache & readahead */"
>
>> @Baolin please correct me if I got it wrong :)
>> 
>> folio_memcg_alloc_deferred() itself doesn't filter shmem out either; it
>> only allocates the memcg list_lru metadata for deferred_split_lru:
>> 
>> int folio_memcg_alloc_deferred(struct folio *folio)
>> {
>> 	if (mem_cgroup_disabled())
>> 		return 0;
>> 	return folio_memcg_list_lru_alloc(folio, &deferred_split_lru, GFP_KERNEL);
>> }
>> 
>> Since deferred_split_lru only queues anon large folios, doing this for
>> shmem swapin doesn't buy us anything :)
>
>Yes, agreed. I don't think it's a big deal / show stopper in terms of
>user-visible effect, but of course still worth fixing.
>
>I'll send a follow-up patch.

Thanks.

Looks like this has already landed in mm-stable. If you're okay with it,
I can send the follow-up.

From: Lance Yang <lance.yang@linux.dev>
Date: Tue, 9 Jun 2026 10:56:45 +0800
Subject: [PATCH] mm: prepare deferred split metadata only for anon swapin

__swap_cache_alloc() prepares deferred split metadata for large swapcache
folios.

That also covers shmem swapin, because shmem_swap_alloc_folio() can call
swapin_sync() with a large order[1]. But shmem folios are not queued on
the deferred split queue, so preparing the metadata doesn't buy us
anything there.

So let's limit it to anon swapin.

[1] https://lore.kernel.org/all/20260601132135.14272-1-lance.yang@linux.dev/

Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 mm/swap_state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 9c3a5cf99778..7adac957c2b8 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -465,7 +465,8 @@ static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	if (order > 1 && folio_memcg_alloc_deferred(folio)) {
+	if (order > 1 && vma && vma_is_anonymous(vma) &&
+	    folio_memcg_alloc_deferred(folio)) {
 		spin_lock(&ci->lock);
 		__swap_cache_do_del_folio(ci, folio, entry, shadow);
 		spin_unlock(&ci->lock);
-- 
2.39.3 (Apple Git-146)

