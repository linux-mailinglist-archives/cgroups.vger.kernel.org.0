Return-Path: <cgroups+bounces-16360-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHaDOsAvF2rd7wcAu9opvQ
	(envelope-from <cgroups+bounces-16360-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 19:54:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 446D95E88D6
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 19:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44FA2304C11A
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 17:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1FB3DD874;
	Wed, 27 May 2026 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJIGJjUh"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD5A3803FA
	for <cgroups@vger.kernel.org>; Wed, 27 May 2026 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779904265; cv=none; b=CD7IgXHSTNtgfzt31HOruHWg3YcAOyH2154kKt2QRkuvYhq36hdvT1q+TvSFSvXArT/aYJBYccDQH03xh0QiklaoZ8lBeGsplHPHvUvy1HJ86Oq85Loc4vQv38FVySznvai5Bm8rVKzVN68VhJoq4wN/QS8o/LPhZrNtoNFE/HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779904265; c=relaxed/simple;
	bh=d+5ICLCo+S77AZqFhPku9jt0+vTq7/hPt9ZODr3BzEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+Ok3FtvShenVujrF6siVHFRsCgqREoiLD945xXYgkXAc/11QT+CP0WKL2IKTogq3D2gK3HwLj7DxNpGIV4gPXzQS83a2KRG+9mMqFt/bsDj9HJVVKr1qBOGs84KvuPO2HzuY2ua/a/D6YLoTTasIVxRBQSaix5qohXs5iQDkQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJIGJjUh; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36abfe17c11so3916363a91.0
        for <cgroups@vger.kernel.org>; Wed, 27 May 2026 10:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779904264; x=1780509064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hS9rtV02plSUcr5CmEuAfEmwWOS8suPI5jczfgl+/Y0=;
        b=ZJIGJjUhSAjzALcH1E9mvix9lPYi7zaj6k3ukJzByoyUeywnIeuYXTkyD45DflFEaj
         CS5lIyGXkqyyTJXW6tDkshSwL8zTt5CTxljQbq4YZuYVTGzE2dBwE+mwzB5A0JaT3u6p
         XHyNsjuP5XSxww+usQAu33fy1Z1VWHGaf565rtVe41yyktQEhHYI2950ajLzt0hvum/e
         /x6eKt0o1twg3A0y+TXdFN6ophTWdryDjXYmFDn71nCDx35OlQsEpnJV+ozr8y3bljiH
         ckeHKfqRuxt9TnDLbQpZ/+51vWjEB7yKrsMpx9N76TDi0cS891wZoSXHfUdU9Um2GDw7
         4ogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779904264; x=1780509064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hS9rtV02plSUcr5CmEuAfEmwWOS8suPI5jczfgl+/Y0=;
        b=Xsg9X7YTq1uGoOXcoP7NJUF7zw1ir4GrLek/sWfra1waODdT22QpfrVoR0669STEN1
         lmDYGiozSZkkt30yYQU54WlfC9h0uGJhjCe81x/aNhJhy5yTezCYZFDVic+SRb2Z3NBV
         +G5KNnsWdJQ9Mbh1fhd1Fjjr5vSShflJeM0IbpeNixPJWTsZ74FyP/EviHUiNsG0qspo
         xZil+C1lr+EZqpRboepfGsVXUz0Mw0FFg29wU/EgqUZPMvr7bI9GjUMGXMfPT/8c0BOZ
         m5MrwR8DMZ6jbzL4uM4rl8EGmdZuMuNeGZWb0j8R5YRmCkgpMmzS5Ox+/2DJqw42dlPw
         mMsg==
X-Forwarded-Encrypted: i=1; AFNElJ8j6POhcMXdkNsB4SGYAEZf3cukp26+Tq/iyxGf0NijcrxdL9MaW/wBJ1c9MSFOsSPZzvmuj+I8@vger.kernel.org
X-Gm-Message-State: AOJu0YzBEfv7nVw9nBD++bFV2grnUVKQZOBOBv4SyfHRhuwdQ7VALaC3
	+ysGDx0guFJXQuPtthbPhFcIS/C6B5nQ7KOqh0ILe6Gwz5BZgDE+tF7Q
X-Gm-Gg: Acq92OH2Sq/Xq1aEjvIfA9jeVAkYxDbiy2XP/eIZmbpBX8I/qC52zLklze4nHqzCEq/
	Q5BX7LH0WfYoEk9thsrnqgaB00zi0wUZNUhIDUggM0JFxGYUF0GHnTrzWZmUCzPZUGc/0FTiOBa
	hmuud2ldJcsilgifj+Jkh/99SVoF9w4UH+62rv1nP8vfM5+/18rxsWxTglUB1b/Cp1nJ5n0Cqye
	qw6qY9+NMF31TU6huz+inIgFlkWK7Bt+t6Poi7WMTOdvHZCKhbxjihkx7KZDZxM4G/zj/JJ6Mta
	Qt5UOUZoMWw5lycoJ0tCIMPbO+4GP7bFz83KGHu2mI64fLCHawg88M+7TIhf1JdRbrkJ45Xg7BA
	Kx266+my9Tjdq5LgWmTTnT2msGf+HlSR/+mm4eujPgrF2ZLzDA0dXybqltaEqBLP8DnCbOySFyB
	DR8SMWtQj4j4qLNWdoupVoZHf7QWFTHFV1Iv+Dg/QDu7ebLUw4e0GTuix+kTJuvrlgHSSgEzB9t
	AMn5elVldSY
X-Received: by 2002:a17:90b:3f44:b0:36a:9d7:8589 with SMTP id 98e67ed59e1d1-36a6763a97amr26262173a91.21.1779904263550;
        Wed, 27 May 2026 10:51:03 -0700 (PDT)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8520561e94sm14405043a12.22.2026.05.27.10.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:51:02 -0700 (PDT)
Date: Thu, 28 May 2026 01:50:55 +0800
From: Kairui Song <ryncsn@gmail.com>
To: Youngjun Park <youngjun.park@lge.com>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, kasong@tencent.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, baoquan.he@linux.dev, baohua@kernel.org, gunho.lee@lge.com, 
	taejoon.song@lge.com, hyungjun.cho@lge.com, mkoutny@suse.com, baver.bae@lge.com, 
	matia.kim@lge.com
Subject: Re: [PATCH v7 4/4] mm: swap: filter swap allocation by memcg tier
 mask
Message-ID: <ahcuEuPhyvOSaBH4@KASONG-MC4>
References: <20260527062247.3440692-1-youngjun.park@lge.com>
 <20260527062247.3440692-5-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527062247.3440692-5-youngjun.park@lge.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16360-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,lge.com,suse.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tencent.com:email]
X-Rspamd-Queue-Id: 446D95E88D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 03:22:47PM +0800, Youngjun Park wrote:
> Apply memcg tier effective mask during swap slot allocation to
> enforce per-cgroup swap tier restrictions.
> 
> In the fast path, check the percpu cached swap_info's tier_mask
> against the folio's effective mask. If it does not match, fall
> through to the slow path. In the slow path, skip swap devices
> whose tier_mask is not covered by the folio's effective mask.
> 
> This works correctly when there is only one non-rotational
> device in the system and no devices share the same priority.
> However, there are known limitations:
> 
>  - When non-rotational devices are distributed across multiple
>    tiers, and different memcgs are configured to use those
>    distinct tiers, they may constantly overwrite the shared
>    percpu swap cache. This cache thrashing leads to frequent
>    fast path misses.
> 
>  - Combined with the above issue, if same-priority devices exist
>    among them, a percpu cache miss (overwritten by another memcg)
>    forces the allocator to round-robin to the next device
>    prematurely, even if the current cluster is not fully
>    exhausted.
> 
> These edge cases do not affect the primary use case of
> directing swap traffic per cgroup. Further optimization is
> planned for future work.
> 
> Signed-off-by: Youngjun Park <youngjun.park@lge.com>
> ---
>  mm/swapfile.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 9a86ebe992f4..1a2d29735b71 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1365,14 +1365,18 @@ static bool swap_alloc_fast(struct folio *folio)
>  	struct swap_cluster_info *ci;
>  	struct swap_info_struct *si;
>  	unsigned int offset;
> +	int mask = folio_tier_effective_mask(folio);
>  
>  	/*
>  	 * Once allocated, swap_info_struct will never be completely freed,
>  	 * so checking it's liveness by get_swap_device_info is enough.
>  	 */
>  	si = this_cpu_read(percpu_swap_cluster.si[order]);
> +	if (!si || !swap_tiers_mask_test(si->tier_mask, mask))
> +		return false;
> +
>  	offset = this_cpu_read(percpu_swap_cluster.offset[order]);
> -	if (!si || !offset || !get_swap_device_info(si))
> +	if (!offset || !get_swap_device_info(si))
>  		return false;
>  
>  	ci = swap_cluster_lock(si, offset);
> @@ -1392,10 +1396,14 @@ static bool swap_alloc_fast(struct folio *folio)
>  static void swap_alloc_slow(struct folio *folio)
>  {
>  	struct swap_info_struct *si, *next;
> +	int mask = folio_tier_effective_mask(folio);
>  
>  	spin_lock(&swap_avail_lock);
>  start_over:
>  	plist_for_each_entry_safe(si, next, &swap_avail_head, avail_list) {
> +		if (!swap_tiers_mask_test(si->tier_mask, mask))
> +			continue;
> +
>  		/* Rotate the device and switch to a new cluster */
>  		plist_requeue(&si->avail_list, &swap_avail_head);
>  		spin_unlock(&swap_avail_lock);
> -- 
> 2.34.1

This part looks good to me, the known limitations are not regression
and only for tiering, so can be improved later, and we do have plan
to refine the priority / rotation / pcp cluster so they aligns well.

Reviewed-by: Kairui Song <kasong@tencent.com>

