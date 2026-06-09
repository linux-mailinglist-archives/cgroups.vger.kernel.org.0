Return-Path: <cgroups+bounces-16756-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mwd2G6LDJ2oI1wIAu9opvQ
	(envelope-from <cgroups+bounces-16756-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 09:41:22 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DFB65D514
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 09:41:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QKM7zKoO;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16756-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16756-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D16C304B0B3
	for <lists+cgroups@lfdr.de>; Tue,  9 Jun 2026 07:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF29E3DFC67;
	Tue,  9 Jun 2026 07:35:44 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A903DEAC3;
	Tue,  9 Jun 2026 07:35:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780990544; cv=none; b=t8RK0tA3M7bLqmVRL7VZ8iB99FBB9kytMBtG27LezKFoEzpN+VpNMlC+vlVHNg6IK6EbabN5nbjAkdbOrQ4PiPoych3YV1vtjyxgW2PD+E/Inw6Ro7XIxXYz4rTA9Holb97VnG05M2eOtPJZOLWndysbuocMoRsjy2kK3KY2M4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780990544; c=relaxed/simple;
	bh=KwUNQ9cZs/pIlSeDAu0pgxS8JGTfN/76PWxF0LhR1Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHvJxC1NFeXnFABu8w2gYMJOzlfenOJRuxmjXwj9DDhUBZhbJs2+yNZmvdZJdMn6X1bBJSKZkww7ZnvIKHSzRbt0SlI2S1qCpIA1lmQ6061zKQdrAGBJvWTkf/pBEpb9zxU1GZD6Rh19SbKxMMUToY8LcrV9mYQfuH53i3LYY7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKM7zKoO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D521F00893;
	Tue,  9 Jun 2026 07:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780990539;
	bh=y7BX3CVcz1NCkcZ9VRBH6DdOLwzw/KIRmNNQBjRMkfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QKM7zKoOEGCmMOgjqz22FaKfmugoiB47u0nOGoRF+NOmN4l3nOkdpksy+GKxK4DWw
	 4WYMWzVXJI9bMUCaTElKkEpgWpCvycuMhBRMi9/Kyc7WnxI/o0F1HEYfT4OJPt2gwV
	 riQ4+si0ZdaOzfmaT5XiUDCG1nF3cyT2H8LjMY2KxQcEhxAM6gjWI59jaAgMxBsZMd
	 /J7YJBXZnPGAhxBqBCDJXfiw3gGo+Y6FCNaomGkb9Yt1KNyfICXjtq8UOOz61RIsXN
	 SCVTcDdXsg9MUCvSC5qXuq6jKSFtShI3F19CxxVnfKCdj013Dw2LsQ4QuwouEHROp4
	 QJSRvJNsI0rbw==
Date: Tue, 9 Jun 2026 08:35:29 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: hannes@cmpxchg.org, baolin.wang@linux.alibaba.com, 
	akpm@linux-foundation.org, david@kernel.org, shakeel.butt@linux.dev, mhocko@kernel.org, 
	david@fromorbit.com, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	qi.zheng@linux.dev, yosry.ahmed@linux.dev, ziy@nvidia.com, liam@infradead.org, 
	usama.arif@linux.dev, kas@kernel.org, vbabka@kernel.org, ryncsn@gmail.com, 
	zaslonko@linux.ibm.com, gor@linux.ibm.com, baohua@kernel.org, dev.jain@arm.com, 
	npache@redhat.com, ryan.roberts@arm.com, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 9/9] mm: switch deferred split shrinker to list_lru
Message-ID: <aifB-YGdJAGzgprt@lucifer>
References: <ah3MuK3GuimKVORB@cmpxchg.org>
 <20260609032058.23770-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609032058.23770-1-lance.yang@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16756-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[cmpxchg.org,linux.alibaba.com,linux-foundation.org,kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lance.yang@linux.dev,m:hannes@cmpxchg.org,m:baolin.wang@linux.alibaba.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:david@fromorbit.com,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:qi.zheng@linux.dev,m:yosry.ahmed@linux.dev,m:ziy@nvidia.com,m:liam@infradead.org,m:usama.arif@linux.dev,m:kas@kernel.org,m:vbabka@kernel.org,m:ryncsn@gmail.com,m:zaslonko@linux.ibm.com,m:gor@linux.ibm.com,m:baohua@kernel.org,m:dev.jain@arm.com,m:npache@redhat.com,m:ryan.roberts@arm.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ljs@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 62DFB65D514

On Tue, Jun 09, 2026 at 11:20:58AM +0800, Lance Yang wrote:
>
> On Mon, Jun 01, 2026 at 02:17:28PM -0400, Johannes Weiner wrote:
> >On Mon, Jun 01, 2026 at 09:21:35PM +0800, Lance Yang wrote:
> >>
> >> On Wed, May 27, 2026 at 04:45:16PM -0400, Johannes Weiner wrote:
> >> [...]
> >> >diff --git a/mm/swap_state.c b/mm/swap_state.c
> >> >index 04f5ce992401..9c3a5cf99778 100644
> >> >--- a/mm/swap_state.c
> >> >+++ b/mm/swap_state.c
> >> >@@ -465,6 +465,16 @@ static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
> >> > 		return ERR_PTR(-ENOMEM);
> >> > 	}
> >> >
> >>
> >> Shouldn't this be limited to anon swapin?
> >>
> >> e.g. vmf && vma_is_anonymous(vmf->vma)
> >>
> >> >+	if (order > 1 && folio_memcg_alloc_deferred(folio)) {
> >>
> >> __swap_cache_alloc() is also used by shmem direct swapin, so shmem can
> >> get here too when handling a large swap entry:
> >>
> >> shmem_get_folio_gfp()
> >>   shmem_swapin_folio()
> >>     shmem_swap_alloc_folio()
> >>       swapin_sync()
> >>         swap_cache_alloc_folio()
> >>           __swap_cache_alloc()
> >>             folio_memcg_alloc_deferred()
> >
> >Good catch, I think you're right. I shouldn't have dismissed that
> >branch due to "/* Direct swapin skipping swap cache & readahead */"
> >
> >> @Baolin please correct me if I got it wrong :)
> >>
> >> folio_memcg_alloc_deferred() itself doesn't filter shmem out either; it
> >> only allocates the memcg list_lru metadata for deferred_split_lru:
> >>
> >> int folio_memcg_alloc_deferred(struct folio *folio)
> >> {
> >> 	if (mem_cgroup_disabled())
> >> 		return 0;
> >> 	return folio_memcg_list_lru_alloc(folio, &deferred_split_lru, GFP_KERNEL);
> >> }
> >>
> >> Since deferred_split_lru only queues anon large folios, doing this for
> >> shmem swapin doesn't buy us anything :)
> >
> >Yes, agreed. I don't think it's a big deal / show stopper in terms of
> >user-visible effect, but of course still worth fixing.
> >
> >I'll send a follow-up patch.
>
> Thanks.
>
> Looks like this has already landed in mm-stable. If you're okay with it,
> I can send the follow-up.
>
> From: Lance Yang <lance.yang@linux.dev>
> Date: Tue, 9 Jun 2026 10:56:45 +0800
> Subject: [PATCH] mm: prepare deferred split metadata only for anon swapin
>
> __swap_cache_alloc() prepares deferred split metadata for large swapcache
> folios.
>
> That also covers shmem swapin, because shmem_swap_alloc_folio() can call
> swapin_sync() with a large order[1]. But shmem folios are not queued on
> the deferred split queue, so preparing the metadata doesn't buy us
> anything there.
>
> So let's limit it to anon swapin.
>
> [1] https://lore.kernel.org/all/20260601132135.14272-1-lance.yang@linux.dev/
>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
>  mm/swap_state.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 9c3a5cf99778..7adac957c2b8 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -465,7 +465,8 @@ static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
>  		return ERR_PTR(-ENOMEM);
>  	}
>
> -	if (order > 1 && folio_memcg_alloc_deferred(folio)) {
> +	if (order > 1 && vma && vma_is_anonymous(vma) &&

A folio can be anon for a non-shmem file-backed VMA though?
E.g. MAP_PRIVATE-mapped file-backed mappings?

Not sure if that's something that'd be a factor here/meaningful though.

> +	    folio_memcg_alloc_deferred(folio)) {
>  		spin_lock(&ci->lock);
>  		__swap_cache_do_del_folio(ci, folio, entry, shadow);
>  		spin_unlock(&ci->lock);
> --
> 2.39.3 (Apple Git-146)

Cheers, Lorenzo

