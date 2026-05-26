Return-Path: <cgroups+bounces-16327-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mApfMN81FmrrjAcAu9opvQ
	(envelope-from <cgroups+bounces-16327-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 02:07:59 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 620F85DDDB8
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 02:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F10A3322CAD7
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 23:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1453E6DCA;
	Tue, 26 May 2026 23:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nCtGHuvN"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DF03E4C60
	for <cgroups@vger.kernel.org>; Tue, 26 May 2026 23:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779839837; cv=none; b=InE/GxTmYgvB81UrdD0OgRplc1wi6Ol9ELDMDXILYu3CT3WbAFCm43w0rtBo/woZDsMLEUAqaxxKcU14f3Ze2lj0ffyE3bfXVJ5Bm3za+n714nOBoEdM8C/dh/DORtrY7/juOndFDsO8f3KG4Q3J6Yijj7jyqhcLPuDHQz21bu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779839837; c=relaxed/simple;
	bh=EzmwvXK5lIzEjI0fBP5q3l94bDG1xn2JjOaEErSSY/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSgFptn/vi4ivyYns0l+Juj4HMT44jCOxfoKv9A0ixxSBdELjHToNsbcBtnuuplU0ayXHAGoV6fZiPvOmfWK0XUgcHeB1WPXKNK21gD0J3IsvicfRwH48/dW1iPAjCAz2iMoQ4vPmYLweU2aGp5H8/Ncf9piX5h64bMl2xvYFfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nCtGHuvN; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 27 May 2026 07:56:37 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779839812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tm9T6xdhcOXHEKQrNHqLca+zli/ELYHEK45n3ISnhH0=;
	b=nCtGHuvN7vc9jEp+LwRnttX4IG4GiV3KcsdQ/rP26chRrmjw2NFOU/sTcRblLH/k8IUhSX
	WCwBQ9DVacJHQGXx4xKs6I+lAXjTzSfG+NptrHCbwzXORZZkrwmgGCwS+3N9B6LPAx3SIp
	aGvXunDOj6uHTbSek5qgyfBc1TJ51mY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Baoquan He <baoquan.he@linux.dev>
To: Youngjun Park <youngjun.park@lge.com>
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
Message-ID: <ahYzNVQHnWlwYq8u@MiWiFi-R3L-srv>
References: <20260421055323.940344-1-youngjun.park@lge.com>
 <20260421055323.940344-4-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421055323.940344-4-youngjun.park@lge.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16327-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,redhat.com,lge.com,suse.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baoquan.he@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 620F85DDDB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/21/26 at 02:53pm, Youngjun Park wrote:
...snip...
> diff --git a/mm/swap_tier.c b/mm/swap_tier.c
> index 9019b8978770..b53d6cc67d1e 100644
> --- a/mm/swap_tier.c
> +++ b/mm/swap_tier.c
...snip...
> @@ -374,6 +404,80 @@ bool swap_tiers_update(void)
>  			break;
>  		swap_tiers_assign_dev(swp);
>  	}
> +	/*
> +	 * XXX: Unused tiers default to ON, disabled after next tier added.
> +	 * Use removed tier mask to clear settings for removed/re-added tiers.
> +	 * (Could hold tier refs, but better to keep cgroup config independent)
> +	 */
> +	if (mask)
> +		swap_tier_memcg_propagate(mask);

Code is neat, and high efficiency, while it's not easy to understand. I
just sat in front of my computer the whole day yesterday to recall and
understand why it's done like this, even though I made it clear to my
self in the past. I think more words would be helpful to decrease the
difficulty for people to undersntand it. E.g below two paragraphes. Just
a suggestion and for your reference.

diff --git a/mm/swap_tier.c b/mm/swap_tier.c
index b53d6cc67d1e..0a6adf14ab91 100644
--- a/mm/swap_tier.c
+++ b/mm/swap_tier.c
@@ -405,9 +405,17 @@ bool swap_tiers_update(int mask)
 		swap_tiers_assign_dev(swp);
 	}
 	/*
-	 * XXX: Unused tiers default to ON, disabled after next tier added.
-	 * Use removed tier mask to clear settings for removed/re-added tiers.
-	 * (Could hold tier refs, but better to keep cgroup config independent)
+	 * When a tier is removed, its index (bit position in the mask) becomes
+	 * free for reassignment to a future tier.  If a memcg had previously
+	 * disabled this tier (cleared the bit in its swap.tiers file), the
+	 * effective mask would keep that bit clear -- meaning the new tier at
+	 * the same index would be silently unavailable, an invisible cgroup
+	 * constraint left behind by a tier that no longer exists.
+	 *
+	 * To prevent this, OR the removed tier's mask bit into every memcg's
+	 * tier_mask and tier_effective_mask.  This resets the bit so the new
+	 * tier is accessible by default; users who want to restrict it must
+	 * explicitly disable it after the tier is re-created.
 	 */
 	if (mask)
 		swap_tier_memcg_propagate(mask);

>  
>  	return true;
>  }
> +
...snip...

