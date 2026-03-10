Return-Path: <cgroups+bounces-14728-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FT/Ma+Sr2kragIAu9opvQ
	(envelope-from <cgroups+bounces-14728-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 04:40:31 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2F5244EAB
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 04:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D347303A099
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 03:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125C63BA246;
	Tue, 10 Mar 2026 03:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDGh/p7r"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14D93BA225
	for <cgroups@vger.kernel.org>; Tue, 10 Mar 2026 03:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773114013; cv=pass; b=RY3SbBOPnmZb2uQaSAEFd0p+xfCODnonNDn8DQxc3RouTfZgfHVuxflHfI8u/mFACWhxboJsgXC8W7vU3g1KUqGiHT5NNzgVReJ76En64dka3A0F9aB2BAF5K66ZGYZW2Q7ePlxLn8DNYHpDdxu/S2q4Jm53gxDFY5bZ5mweJAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773114013; c=relaxed/simple;
	bh=nrF7vlGYzrNGs/7YHhPH/NnJVLHS4kdieXhq3F5zpFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOfx6kRVZDTFreMKyOi0k7IgdzxIHSITWo0xk+7JEWlsqh8hr36/xr1ZfZCq95U5UoBj3QmGJjHkbhYJoSaIIRXLWAsbZk2QhmfL0frT6xn105JCrPmzY/r60GH4JN59V1gfLTDRUssFLOYKxd7tm99LXD7ls1FjzhUKshJVIoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDGh/p7r; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c648bc907ebso7819024a12.3
        for <cgroups@vger.kernel.org>; Mon, 09 Mar 2026 20:40:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773114012; cv=none;
        d=google.com; s=arc-20240605;
        b=j5RiyfPLNbi5UVYiTTWknvj3KiBAXaIEZhn5edN9nChO9XQBxPscB6D3Btw2Lkemee
         etGdZcr6vzzetASyvEaTxGLL99yTyTAmfB/LV0DZlbd6VjwC0RFbFpMSmLenrhIoAagn
         XREPHpwPlBEMFWwmIZRqFKTzqTgO8s2BSSzSt1W2+c/+j2eHjNvCIcLFlVvVggEIO6yb
         jceVy9/zZvNi5DYBXh3/b4SvSPaFS5x+dgHZOvERHfINnMzz/pFwF1EE2lyuH47UpYbq
         LJ/UwvEvohF4jTjQNE3tafrZp3Wxz0y+UDtOuRYNC82V1NuTNThdIGtcOsoc9Lz6UHjP
         +ZZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1PR62EF1lAki6+/h7SawFbTNGruJi0XAMWivo94NRLc=;
        fh=4mGUPQsGGPqfoCvLhEbRcQiW7LY14DL8rQc9DVXnzMA=;
        b=KnGaoOwfIqOnlGH/OtIPN6cRWFEGaQzGlDWfrezdv76RkDVIybhbwi++kG/p+Y1V/Z
         lEbgzkPi6ghp/tMa0IrmSls3udIoYKJjVFJrrTMkHX97ONemSLflRPuPBVxhSx01Rll4
         2LOpQSxbGg5Yi+P9nADKbTx3tQEyUmBtRR5f6z/aTCX4/V9CZAsmJL4G6hos6bZrh5qS
         rMKjp/mzfh4BNQpw6teWyZjqP1vkMhv7wtDx3MCHrgvC5Bgi7q3bAUGYO/nDT2MgJCaL
         gM0goaBUUq1tHszfo+4nqMFrkDH/FYti5YRbyXqYr0h7tCcyI43cfnQrKerZsOVODHL/
         CiEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773114012; x=1773718812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PR62EF1lAki6+/h7SawFbTNGruJi0XAMWivo94NRLc=;
        b=LDGh/p7r4q4O4SNLhBjYnjbsAWHkfrcHUi/YqyWGyBQCMy8rpaRzIiI8nRaATiFmgz
         WXDg+LaLkXdxnNhVsYRPoomPfBjn9QcTAj0ZW5hBUdzM+ntlWClVGhP+Ai9TI//i4Qds
         uYmAjTuU9IOGx/qaBC3UJ93WjrpKdL464r+HcmOVwaIXypg1fMC/GdVhu2QWEp+EZnCK
         hNm3w6YGZxM8Vy2NmvRUnvtf0HwgJIM9+9Ymn8boWZiQsiUcItdrRpwGMaNdk01Wh3vS
         HcAfLdNtoHGrci7cbcR3NIWZSgpykecmktQp2Frk2R5n4f2C5LosFp2MJQuGjjSFDPL7
         aKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773114012; x=1773718812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1PR62EF1lAki6+/h7SawFbTNGruJi0XAMWivo94NRLc=;
        b=mTruBGfZWVMC0omeHRGg9V2vqz6GzkD44R0dWo+vtynJh69H0BMVGBYISE/nivFvFq
         +KfQ59jYoJrHzgqLrjR9InbKIFIPQG48XZxO1IUJSXMPIROmK6Sv3w0zHwg5mdCR5c4U
         k7GMM3uQIuKbNouYn2++1Jv15Py8b8O4VTPe5qEq6bBPRCOcixSjMRf/Xvq/Vl84ZmdH
         r5x8DKKgtv9tjOszXJwTDgQAlh3QuSj//qrhv0xOurxziphFG+1dMx7ZkUbE4PqlSLoo
         iV0Kbu8tsCo5e4/X8OXfB4MF8gqvuYbaeJF8OAyzZ0bjqwux4bmdzcXhF91+/47zyJWB
         emGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ1sA4MCZF5HOUPHYqUcgLRV02t/1+Od0maSymlBF/ZtT4aAy9+RvkmC/JDiCAj8euh98GNXfr@vger.kernel.org
X-Gm-Message-State: AOJu0YxpQojRHL2o+GwZUvZX8HMCIqqDS/Bv9fgWxIf7XynlOYyrMnRu
	fUElD5KXEKPQn8rLLUpd08Xt/qiE14t8JNXz9QT6kn6ygPhVQdF3flc7yFtjTGYSCKS/Xfm9BqW
	pTfdh7NNF4YtteTvLMvmRWY1au7dam/w=
X-Gm-Gg: ATEYQzx0V7MMM9v1G8c7o49rgqMrgV/MPM2uJyNqIVH8ARhJBeragpKXzNzXT+TmfHp
	cguBhAFtLcvq/HsKZmpMtPXIGuicnSo2/9Vc0iNWZ3luT1V5RVmw/e7eDQdVXqUZU1m9AvU1A+w
	fkXPyv4diLXR6nKx+9elA0Y7X+eizfuePRhz94Q0nnRj1U305C/ZGMomH4ZMluwtIMKPFDiAxGR
	SjI7qq13+xrIXA4jzwe8sEIDvpghHEOuieSYmrZGNXv/b1YYCKxM5kBKLLoBcwjJH3zTWcZ5vIl
	tpaAEmI=
X-Received: by 2002:a05:6a21:9ccb:b0:395:291b:f555 with SMTP id
 adf61e73a8af0-398590ebdaamr11794026637.69.1773114012045; Mon, 09 Mar 2026
 20:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aa5NmA25QsFDMhof@hyeyoo> <20260309072219.22653-1-harry.yoo@oracle.com>
In-Reply-To: <20260309072219.22653-1-harry.yoo@oracle.com>
From: Zw Tang <shicenci@gmail.com>
Date: Tue, 10 Mar 2026 11:40:00 +0800
X-Gm-Features: AaiRm51P9s3DC7FjytFC4I2paYZUeQw-qAwJyjCHl-40jBVff_9Gjy4xmE9iqAQ
Message-ID: <CAPHJ_VLzRECge4=L5RRqZyf-Sou8APi=Sc=d0brBAMdj3UC_Cw@mail.gmail.com>
Subject: Re: [PATCH] mm/slab: fix an incorrect check in obj_exts_alloc_size()
To: Harry Yoo <harry.yoo@oracle.com>
Cc: adilger.kernel@dilger.ca, akpm@linux-foundation.org, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, hao.li@linux.dev, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@kernel.org, 
	cl@gentwo.org, rientjes@google.com, roman.gushchin@linux.dev, 
	viro@zeniv.linux.org.uk, surenb@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5E2F5244EAB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14728-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shicenci@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,oracle.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Harry,

Thanks for the patch.

I tested it on my environment with the original syzkaller reproducer,
and the warning no longer reproduces after applying the patch.

Kernel version tested: v7.0-rc2

Tested-by: Zw Tang shicenci@gmail.com

Best regards,
Zw Tang

Harry Yoo <harry.yoo@oracle.com> =E4=BA=8E2026=E5=B9=B43=E6=9C=889=E6=97=A5=
=E5=91=A8=E4=B8=80 15:22=E5=86=99=E9=81=93=EF=BC=9A
>
> obj_exts_alloc_size() prevents recursive allocation of slabobj_ext
> array from the same cache, to avoid creating slabs that are never freed.
>
> There is one mistake that returns the original size when memory
> allocation profiling is disabled. The assumption was that
> memcg-triggered slabobj_ext allocation is always served from
> KMALLOC_CGROUP type. But this is wrong [1]: when the caller specifies
> both __GFP_RECLAIMABLE and __GFP_ACCOUNT with SLUB_TINY enabled, the
> allocation is served from normal kmalloc. This is because kmalloc_type()
> prioritizes __GFP_RECLAIMABLE over __GFP_ACCOUNT, and SLUB_TINY aliases
> KMALLOC_RECLAIM with KMALLOC_NORMAL.
>
> As a result, the recursion guard is bypassed and the problematic slabs
> can be created. Fix this by removing the mem_alloc_profiling_enabled()
> check entirely. The remaining is_kmalloc_normal() check is still
> sufficient to detect whether the cache is of KMALLOC_NORMAL type and
> avoid bumping the size if it's not.
>
> Without SLUB_TINY, no functional change intended.
> With SLUB_TINY, allocations with __GFP_ACCOUNT|__GFP_RECLAIMABLE
> now allocate a larger array if the sizes equal.
>
> Reported-by: Zw Tang <shicenci@gmail.com>
> Fixes: 280ea9c3154b ("mm/slab: avoid allocating slabobj_ext array from it=
s own slab")
> Closes: https://lore.kernel.org/linux-mm/CAPHJ_VKuMKSke8b11AZQw1PTSFN4n2C=
0gFxC6xGOG0ZLHgPmnA@mail.gmail.com [1]
> Cc: stable@vger.kernel.org
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>
> Zw Tang, could you please confirm that the warning disappears
> on your test environment, with this patch applied?
>
>  mm/slub.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 20cb4f3b636d..6371838d2352 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2119,13 +2119,6 @@ static inline size_t obj_exts_alloc_size(struct km=
em_cache *s,
>         size_t sz =3D sizeof(struct slabobj_ext) * slab->objects;
>         struct kmem_cache *obj_exts_cache;
>
> -       /*
> -        * slabobj_ext array for KMALLOC_CGROUP allocations
> -        * are served from KMALLOC_NORMAL caches.
> -        */
> -       if (!mem_alloc_profiling_enabled())
> -               return sz;
> -
>         if (sz > KMALLOC_MAX_CACHE_SIZE)
>                 return sz;
>
>
> base-commit: 6432f15c818cb30eec7c4ca378ecdebd9796f741
> --
> 2.43.0
>

