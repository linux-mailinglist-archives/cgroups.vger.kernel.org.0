Return-Path: <cgroups+bounces-16331-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFwIDjdUFmo+lQcAu9opvQ
	(envelope-from <cgroups+bounces-16331-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 04:17:27 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 977435DE7F0
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 04:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD7943042C47
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 02:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1929D351C13;
	Wed, 27 May 2026 02:17:10 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4169615B998
	for <cgroups@vger.kernel.org>; Wed, 27 May 2026 02:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779848229; cv=none; b=gnjH7ruzRx3u8s9lKyWScl9SluLFCoToFvVEdOkkzv3acVcobbNpM/+4DhGReh1zOfpXTYa8OimUBoYWTSmYsFQvhob7d1c42M6KikzXWwYUXy3kLbiyuKh1+MLgihikwX5qLtUwmcCr/BQceh23qsYWJcNG+puLghgfa4wBNWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779848229; c=relaxed/simple;
	bh=QceR/h9l49suMYoHkd7/50YxKiX96eBfnlwbqRGe+Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhfS7QqBUKL04flfq/jj4vylrgmiSCycXZqC3JIxE4ZMZAXT+V1uDEgKKDzrecktK5oAyqDqqMtzP3rDaoM1/7xzBrWbvNun9qOqdpVskOC7yKj/v/O6JR7c2oa/tOaT8h0mk6WF251PGr88uLWIdAFr5xG3SU9USZuEtHtoJ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 27 May 2026 11:17:05 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Wed, 27 May 2026 11:17:05 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Baoquan He <baoquan.he@linux.dev>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	kasong@tencent.com, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, baohua@kernel.org, gunho.lee@lge.com,
	taejoon.song@lge.com, hyungjun.cho@lge.com, mkoutny@suse.com,
	baver.bae@lge.com, matia.kim@lge.com
Subject: Re: [PATCH v6 4/4] mm: swap: filter swap allocation by memcg tier
 mask
Message-ID: <ahZUIQHreEaqd6z4@yjaykim-PowerEdge-T330>
References: <20260421055323.940344-1-youngjun.park@lge.com>
 <20260421055323.940344-5-youngjun.park@lge.com>
 <ahZMHmMbhnNPspQj@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahZMHmMbhnNPspQj@MiWiFi-R3L-srv>
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16331-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[lge.com:server fail,tor.lore.kernel.org:server fail];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,redhat.com,lge.com,suse.com];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lge.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 977435DE7F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 09:42:54AM +0800, Baoquan He wrote:
> On 04/21/26 at 02:53pm, Youngjun Park wrote:
> > Apply memcg tier effective mask during swap slot allocation to
> > enforce per-cgroup swap tier restrictions.
> > 
> > In the fast path, check the percpu cached swap_info's tier_mask
> > against the folio's effective mask. If it does not match, fall
> > through to the slow path. In the slow path, skip swap devices
> > whose tier_mask is not covered by the folio's effective mask.
> > 
> > This works correctly when there is only one non-rotational
> > device in the system and no devices share the same priority.
> > However, there are known limitations:
> > 
> >  - When non-rotational devices are distributed across multiple
> >    tiers, and different memcgs are configured to use those
> >    distinct tiers, they may constantly overwrite the shared
> >    percpu swap cache. This cache thrashing leads to frequent
> >    fast path misses.
> > 
> >  - Combined with the above issue, if same-priority devices exist
> >    among them, a percpu cache miss (overwritten by another memcg)
> >    forces the allocator to round-robin to the next device
> >    prematurely, even if the current cluster is not fully
> >    exhausted.
> > 
> > These edge cases do not affect the primary use case of
> > directing swap traffic per cgroup. Further optimization is
> > planned for future work.
> > 
> > Signed-off-by: Youngjun Park <youngjun.park@lge.com>
> > ---
> >  mm/swapfile.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index d5abc831cde7..8734e5d26b08 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -1352,15 +1352,22 @@ static bool swap_alloc_fast(struct folio *folio)
> >  	struct swap_cluster_info *ci;
> >  	struct swap_info_struct *si;
> >  	unsigned int offset;
> > +	int mask = folio_tier_effective_mask(folio);
> >  
> >  	/*
> >  	 * Once allocated, swap_info_struct will never be completely freed,
> >  	 * so checking it's liveness by get_swap_device_info is enough.
> >  	 */
> >  	si = this_cpu_read(percpu_swap_cluster.si[order]);
> > +	if (!si || !swap_tiers_mask_test(si->tier_mask, mask) ||
> > +		!get_swap_device_info(si))
> > +		return false;
> > +
> >  	offset = this_cpu_read(percpu_swap_cluster.offset[order]);
> > -	if (!si || !offset || !get_swap_device_info(si))
> > +	if (!offset) {
> > +		put_swap_device(si);
> >  		return false;
> > +	}
> 
> The whole patch looks good to me except of one nitpick. Is it a lille
> cleaner with below tiny adjustment?
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 2864cd8c2da9..cdf453bf6b80 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1359,15 +1359,12 @@ static bool swap_alloc_fast(struct folio *folio)
>  	 * so checking it's liveness by get_swap_device_info is enough.
>  	 */
>  	si = this_cpu_read(percpu_swap_cluster.si[order]);
> -	if (!si || !swap_tiers_mask_test(si->tier_mask, mask) ||
> -		!get_swap_device_info(si))
> +	if (!si || !swap_tiers_mask_test(si->tier_mask, mask))
>  		return false;
>  
>  	offset = this_cpu_read(percpu_swap_cluster.offset[order]);
> -	if (!offset) {
> -		put_swap_device(si);
> +	if (!offset || !get_swap_device_info(si))
>  		return false;
> -	}

Thanks!

Your suggested version of code is simpler than privious one.
I will apply it.

