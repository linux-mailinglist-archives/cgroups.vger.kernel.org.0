Return-Path: <cgroups+bounces-16330-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABWmAxRSFmqPlAcAu9opvQ
	(envelope-from <cgroups+bounces-16330-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 04:08:20 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2445DE79D
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 04:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D80FA3029625
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 02:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04631305688;
	Wed, 27 May 2026 02:08:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB12124DD15
	for <cgroups@vger.kernel.org>; Wed, 27 May 2026 02:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779847691; cv=none; b=dTjBHKQuqUjgG11yvFzAKT5gdVASOckdmFjIKtTKjmzB0cmXG9G+4mpyWXiI9pHiY9RRmIVkIuM9/xE7nvcULH+WjorPAj4+9HAa4PMmLfqJkn9h7WCe7dAVto6bHzmIUXoRDsW1dvZ2iNlDLVYIXfhAhSvlSCS1jgJh4cDC+LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779847691; c=relaxed/simple;
	bh=YtOGXPKzjwHe3CBze1OxbTjnaP/Q1E0k/DEeaU6VamU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANuaQzR/XpTwsQrzfiEKGLh3xmtW/Bf9HA6Fhvd6koWl/PJfE/nOMcp5Hbolv2Ka9ODA/RdFSqUxDIkl/Gr1/26O1t71Ufiht+6RVjFe7ezBSuPyFhCh7cZ+OwV/u+39sUq1Y9YCIbsGh27szPYvOH0F/bA4SSg7Fz/sicERNzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 27 May 2026 11:08:07 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Wed, 27 May 2026 11:08:06 +0900
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
Subject: Re: [PATCH v6 3/4] mm: memcontrol: add interfaces for swap tier
 selection
Message-ID: <ahZSBsSiSeQnJZrn@yjaykim-PowerEdge-T330>
References: <20260421055323.940344-1-youngjun.park@lge.com>
 <20260421055323.940344-4-youngjun.park@lge.com>
 <ahYzNVQHnWlwYq8u@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahYzNVQHnWlwYq8u@MiWiFi-R3L-srv>
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
	TAGGED_FROM(0.00)[bounces-16330-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,redhat.com,lge.com,suse.com];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5F2445DE79D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 07:56:37AM +0800, Baoquan He wrote:
> On 04/21/26 at 02:53pm, Youngjun Park wrote:
> ...snip...
> > diff --git a/mm/swap_tier.c b/mm/swap_tier.c
> > index 9019b8978770..b53d6cc67d1e 100644
> > --- a/mm/swap_tier.c
> > +++ b/mm/swap_tier.c
> ...snip...
> > @@ -374,6 +404,80 @@ bool swap_tiers_update(void)
> >  			break;
> >  		swap_tiers_assign_dev(swp);
> >  	}
> > +	/*
> > +	 * XXX: Unused tiers default to ON, disabled after next tier added.
> > +	 * Use removed tier mask to clear settings for removed/re-added tiers.
> > +	 * (Could hold tier refs, but better to keep cgroup config independent)
> > +	 */
> > +	if (mask)
> > +		swap_tier_memcg_propagate(mask);
> 
> Code is neat, and high efficiency, while it's not easy to understand. I
> just sat in front of my computer the whole day yesterday to recall and
> understand why it's done like this, even though I made it clear to my
> self in the past. I think more words would be helpful to decrease the
> difficulty for people to undersntand it. E.g below two paragraphes. Just
> a suggestion and for your reference.

Thanks for the review again :)

Okay I see.
This explanation seems heavily abbreviated.

> diff --git a/mm/swap_tier.c b/mm/swap_tier.c
> index b53d6cc67d1e..0a6adf14ab91 100644
> --- a/mm/swap_tier.c
> +++ b/mm/swap_tier.c
> @@ -405,9 +405,17 @@ bool swap_tiers_update(int mask)
>  		swap_tiers_assign_dev(swp);
>  	}
>  	/*
> -	 * XXX: Unused tiers default to ON, disabled after next tier added.
> -	 * Use removed tier mask to clear settings for removed/re-added tiers.
> -	 * (Could hold tier refs, but better to keep cgroup config independent)
> +	 * When a tier is removed, its index (bit position in the mask) becomes
> +	 * free for reassignment to a future tier.  If a memcg had previously
> +	 * disabled this tier (cleared the bit in its swap.tiers file), the
> +	 * effective mask would keep that bit clear -- meaning the new tier at
> +	 * the same index would be silently unavailable, an invisible cgroup
> +	 * constraint left behind by a tier that no longer exists.
> +	 *
> +	 * To prevent this, OR the removed tier's mask bit into every memcg's
> +	 * tier_mask and tier_effective_mask.  This resets the bit so the new
> +	 * tier is accessible by default; users who want to restrict it must
> +	 * explicitly disable it after the tier is re-created.
>  	 */

The explanation seems good.

it explains why we must clear the "disabled bit",
when a new tier comes and we don't automatically diable,
it can implicitly disable "new tier" which user might not want.

This comes from that fact we don't have a cgroup refecounting on the tier land.
it is the corner case, we must sync for correct behavior.

I will change the comments as like it is.

