Return-Path: <cgroups+bounces-16194-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHDeNA7CD2oIPgYAu9opvQ
	(envelope-from <cgroups+bounces-16194-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 04:40:14 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E855AE175
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 04:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B94BC300FAA8
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 02:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F71D16A956;
	Fri, 22 May 2026 02:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpMw8dK4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524EA30674C
	for <cgroups@vger.kernel.org>; Fri, 22 May 2026 02:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779417612; cv=none; b=AdwWZX1kiaj+x+s2NEdIsKE5cllZ9sFBvhpCR3sccC728lengHYByJsfKLNEDtVEdKHtIcJu7Jw/MRCJvp0aRFtTHeV01l5qIX+zsIWagGZ8GvpchHpB8bnxUhYJWla/YCZN99sTMeMqbvxgExzJaGB0wRc9byxx8CWFPMvIMuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779417612; c=relaxed/simple;
	bh=SVQEKYdpdNnKbRYWNJeLNtIxpMqsFNK9r30AKMgQ/XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atgb6/anowAZLzOO0THtbZs9F83RtvduQWmOtRExRRoiNVjPtE8JUWnJ886kBTJFvyxWqzoXj6AXFZzAdjqr/nyqQbP65At4kl/0u3prug8Fp77C3GcGUVR9cdGxOgYsJexLGTSct0MwDAHqJMknlAW+N3JrM6tk0UerXYIM5EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpMw8dK4; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36974217d4eso4332508a91.2
        for <cgroups@vger.kernel.org>; Thu, 21 May 2026 19:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779417608; x=1780022408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fm97KPHUVYZqun0p/IlrOCNvbRaK3CQJwbnFDIX8nLA=;
        b=KpMw8dK41KouEnK+o6NAwu0/1g519AlVS6yPXX08PAvNmOg6HyXRiC9jawGm66kTUp
         uRjMzcHnFkb0eHR5gxRI4ILxT1guF3mSnKHQCNeo+YRG3eUwyfI5qxKAntM/yPLHfiJ0
         FLVzlcm48hYgt7fIUpwsKjWy9g34WARVJL4bOpNf6aoFNiBsvFuftSE0Ka5IFMaTOVmP
         dv1VQEY0LfWKYm9OOwTwDXv7FuZoP3bMnInpTStp1zQ9Zc1vzGLt+WozwdOPhCso0hod
         jwgFpZGI+Z8HnzYpxv8H4IGVuXY9c0Kn4ogk7fwUP8OkrjfUUvcEnUysk2ICEFtuWttA
         Pi5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779417608; x=1780022408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fm97KPHUVYZqun0p/IlrOCNvbRaK3CQJwbnFDIX8nLA=;
        b=TZcbygTeSeZzpczATorBfB20iyeXsSPedR0IAlVGWoa6VxiXiO24wsHLQjfy78b/U0
         c4XMleeVWhOIU8YBKy3vpx+aw8qo3o1tvBnLPnK4mdhv8C+t5xtH0POZ1Yhh+fdYEoWy
         JPMFhdawWjmbgiHmi0roE10HSPT8eaiUjbrsDjm9vyQniOSnEGvEfMkoJr2c9zRSV4Jv
         JRjUQRqYoBmocRjxih8TitGdX6Lu1GqLEyKcr9n0Cwsd3/nXHcJADq7rVvZJ4CX4vFYG
         z8PI6wgsoRrmk+XzyOS300ul6FVo/co+1uiIa7wwdmfps8xPH+htPyZJwHv6vCrRwgpx
         2HUA==
X-Forwarded-Encrypted: i=1; AFNElJ9ksiDjzrc0qFXwTRM/6Hj5mRvfhGyAm7lXeSnwu3NK1/miCEQ9FRoyZE8RuBROHRVL7iv5IHtp@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/+UipMueXhVmAm4Uz81798bcTZQpqCwHSLITF4F3n0LTC7Nvx
	WXkEgA9hJTD2vrsbYzP+WDmhTJLi9KoNS3bVTKcQCdBTNBgTvrbyjXzJ
X-Gm-Gg: Acq92OGBzZW/jj5O6TrW7hmlSULdAd8UqKv9/mTNkLcMV63sGqbL4thfdI48yqyk5Pr
	lZjmeXBHL4oCmkKPkXOLIpU9+l3QOt0InNilXWQsyhw8XbxAdUQK64NR5+xrkJs+dic3ycpsNOe
	NRuGfWpvQfaRSMVrWhEw7A6L7AgbkQqs6S/TEi3ev1PXhkKe9Yfz9kZraJW2pmzfJzf4wM6kG0c
	cNCMJ29Q+48tPntEoJOxr4qa4O97QFviSMtanTolthldkPwZFUstdkTCxVs4BVPQNCCzdb+cZ7t
	bXc4zQKJTtV72qdfjElPX2cPrDmLe3pGiPrk1dU2962t7wP5siMF+qEEeuAhGE1vwqMWzQA1UE1
	rg4yodsWq8Smce/axz6Jzf36B4avfRH6iTUfkWSFxA8rYkeiM+CdLMb2+tyDJ13ZDIIk8t1Cxro
	jjnnm9h1PkvPGoiWRnNiELSM2dshIYq6RViaxR6XhDdNnPLaj8Ywn9rY90UTYFovb7cgKHouB+
X-Received: by 2002:a05:6a21:a343:b0:3a2:dbaa:82ee with SMTP id adf61e73a8af0-3b328caba66mr1544588637.9.1779417608238;
        Thu, 21 May 2026 19:40:08 -0700 (PDT)
Received: from KASONG-MC4 ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85202901e6sm72726a12.2.2026.05.21.19.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 19:40:07 -0700 (PDT)
Date: Fri, 22 May 2026 10:39:59 +0800
From: Kairui Song <ryncsn@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kasong@tencent.com, 
	Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>, linux-mm@kvack.org, David Hildenbrand <david@kernel.org>, 
	Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Barry Song <baohua@kernel.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Youngjun Park <youngjun.park@lge.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Lorenzo Stoakes <ljs@kernel.org>, Yosry Ahmed <yosry@kernel.org>, Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH v5 12/12] mm, swap: merge zeromap into swap table
Message-ID: <ag_Bt1MpdF4IIXc9@KASONG-MC4>
References: <20260517-swap-table-p4-v5-0-88ae43e064c7@tencent.com>
 <20260517-swap-table-p4-v5-12-88ae43e064c7@tencent.com>
 <20260521185204.a109bfcd1e0e8f52135c5ed5@linux-foundation.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521185204.a109bfcd1e0e8f52135c5ed5@linux-foundation.org>
X-Spamd-Result: default: False [5.34 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-16194-lists,cgroups=lfdr.de];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	GREYLIST(0.00)[pass,meta];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[tencent.com,kernel.org,kvack.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.871];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups,kasong.tencent.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 76E855AE175
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 06:52:04PM +0800, Andrew Morton wrote:
> On Sun, 17 May 2026 23:39:51 +0800 Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org> wrote:
> 
> > From: Kairui Song <kasong@tencent.com>
> > 
> > By allocating one additional bit in the swap table entry's flags field
> > alongside the count, we can store the zeromap inline
> > 
> > For 64 bit systems, zeromap will store in the swap table, avoiding zeromap
> > allocation. It reduces the allocated memory. That is the happy path.
> > 
> > For certain 32-bit archs, there might not be enough bits in the swap
> > table to contain both PFN and flags. Therefore, conditionally let each
> > cluster have a zeromap field at build time, and use that instead.
> > If the swapfile cluster is not fully used, it will still save memory for
> > zeromap. The empty cluster does not allocate a zeromap. In the worst case,
> > all cluster are fully populated. We will use memory similar to the
> > previous zeromap implementation.
> > 
> > A few macros were moved to different headers for build time struct
> > definition.
> > 
> > ...
> >
> > @@ -469,13 +474,21 @@ static int swap_cluster_alloc_table(struct swap_cluster_info *ci, gfp_t gfp)
> >  		VM_WARN_ON_ONCE(ci->memcg_table);
> >  		ci->memcg_table = kzalloc_obj(*ci->memcg_table, gfp);
> >  		if (!ci->memcg_table)
> > -			ret = -ENOMEM;
> > +			goto err_free;
> >  	}
> >  #endif
> > -	if (ret)
> > -		swap_cluster_free_table(ci);
> >  
> > -	return ret;
> > +#if !SWAP_TABLE_HAS_ZEROFLAG
> > +	VM_WARN_ON_ONCE(ci->zero_bitmap);
> > +	ci->zero_bitmap = bitmap_zalloc(SWAPFILE_CLUSTER, gfp);
> > +	if (!ci->zero_bitmap)
> > +		goto err_free;
> > +#endif
> > +	return 0;
> > +
> > +err_free:
> > +	swap_cluster_free_table(ci);
> > +	return -ENOMEM;
> >  }
> 
> My m68k defconfig warned.  I'll do the below, which looks good enough. 
> Please check.
> 
> Perhaps a custom guard() handler would clean things up here.
> 
> 
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: mm-swap-merge-zeromap-into-swap-table-fix-2
> Date: Thu May 21 06:39:20 PM PDT 2026
> 
> mm/swapfile.c: In function 'swap_cluster_alloc_table':
> mm/swapfile.c:488:1: warning: label 'err_free' defined but not used [-Wunused-label]
>   488 | err_free:
>       | ^~~~~~~~
> 
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Chengming Zhou <chengming.zhou@linux.dev>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: Kemeng Shi <shikemeng@huaweicloud.com>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Nhat Pham <nphamcs@gmail.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: Youngjun Park <youngjun.park@lge.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  mm/swapfile.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> --- a/mm/swapfile.c~mm-swap-merge-zeromap-into-swap-table-fix-2
> +++ a/mm/swapfile.c
> @@ -472,22 +472,22 @@ static int swap_cluster_alloc_table(stru
>  	if (!mem_cgroup_disabled()) {
>  		VM_WARN_ON_ONCE(ci->memcg_table);
>  		ci->memcg_table = kzalloc_obj(*ci->memcg_table, gfp);
> -		if (!ci->memcg_table)
> -			goto err_free;
> +		if (!ci->memcg_table) {
> +			swap_cluster_free_table(ci);
> +			return -ENOMEM;
> +		}
>  	}
>  #endif
>  
>  #if !SWAP_TABLE_HAS_ZEROFLAG
>  	VM_WARN_ON_ONCE(ci->zero_bitmap);
>  	ci->zero_bitmap = bitmap_zalloc(SWAPFILE_CLUSTER, gfp);
> -	if (!ci->zero_bitmap)
> -		goto err_free;
> +	if (!ci->zero_bitmap) {
> +		swap_cluster_free_table(ci);
> +		return -ENOMEM;
> +	}
>  #endif
>  	return 0;
> -
> -err_free:
> -	swap_cluster_free_table(ci);
> -	return -ENOMEM;
>  }
>  
>  /*
> _
> 

Looks good, thank you. The error path is still simple and
straight at the moment.

It will be even better if we also remove the now unused ret
variable as well (this isn't triggering warning yet since Kbuild
don't set unused-but-set-variable by default):

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 9712cc862c9c..615d90867111 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -450,7 +450,6 @@ static int swap_cluster_alloc_table(struct swap_cluster_info *ci, gfp_t gfp)
 {
 	struct swap_table *table = NULL;
 	struct folio *folio;
-	int ret = 0;
 
 	/* The cluster must be empty and not on any list during allocation. */
 	VM_WARN_ON_ONCE(ci->flags || !cluster_is_empty(ci));

