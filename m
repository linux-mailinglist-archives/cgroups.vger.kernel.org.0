Return-Path: <cgroups+bounces-1777-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5073485E9C5
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 22:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067671F22C65
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 21:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6711F1272A6;
	Wed, 21 Feb 2024 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="lwP34nuD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE4463DD
	for <cgroups@vger.kernel.org>; Wed, 21 Feb 2024 21:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550195; cv=none; b=HU/9jJIux0WQNqz/WUndOpJ4rI+Q6uiaX0mkYUKNyNste9g1sxtpxBtrnU9swympPo6bAwlQgutdAOQDAEs0nfh+gDpC4/ichz5ObyP9ffosighlBRtH8MWHtb40uOCFwMC9FHdtYczg9pfQWxg56PtcQJQfFWBptVP6nolraPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550195; c=relaxed/simple;
	bh=04iwdfiihTWiqSIzPHAdzy89EcAty14KO44MmWzyPPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsAwwlLlRfOpGhlS8t7Uep5YmkdzoqTDYxK/fCT9eAGzO03Pspxei8e7hJlPTDgDGWaRs0vUoZKWNoIfD0IFFsMn1s1p63ujhTKPt6jN4BY1LwF/vKtV1aiAKfCMnRX+DiQhq5LzIvO4iwCPThcQ3oZC9PWDnT6fIe5kWF1E36g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=lwP34nuD; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e4423b64acso2750284a34.2
        for <cgroups@vger.kernel.org>; Wed, 21 Feb 2024 13:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708550192; x=1709154992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWpAXMfptvXBWhPj/Zu9FAZfSnAxEQBXKk45RWYFa4c=;
        b=lwP34nuD6nw4awH46Am+5av5lRCOibnaz9Ie7pvz945R95r/dnwwF5031LRlEHIX06
         9rbHEtXuoNoO2ozZ3VkcvznexnbC5ACiq5lQ+15Zwd9MW5YQpfJ4uNfhX9aBR2oI3q0p
         55vt5GxmCf/Y52qtArIACuoNxJ0H8rROljiOqAA35XrVj1E48Cgm1Sofi8C/ZOX+g1xM
         HY0EkiGd9ugAvCz9VIxfX/Zmmn+CrHJzr9bzu3mrq0riPB5lgk6KV4jYnoWt/0RvwDiB
         7/rOeNZkit6L36UCGeGm0ouAhXQjAy9f245UHOd5wo8kcyHXeV2Uoj7fZNBbA8IFBjrg
         abUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708550192; x=1709154992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWpAXMfptvXBWhPj/Zu9FAZfSnAxEQBXKk45RWYFa4c=;
        b=EvTTu7FtJRz7HZLySlxTsSC9eMBMJ7E9jLVdPB59VTN920lKFW2s12hfFNWJk4OQDF
         GFz9SqLCwJFqb8qLVxa+rVU31PxkIq0j6y0RaG5Noh9q+PNMwcd0IR8wFuKs+KYb7lBQ
         2uEwdzjlFuTQ60JhZWHfs4PAQPdfdXA6qgB3Z/+xCGhvA+3KvIfJb7ZlaVCHw4NAl++a
         8nXKhf+vlfMYVuh6ckJGlyswkzugcAbUXRmgkjH/5vov7jnVA30CPSsiO7TRwX70BXUZ
         Yza7X0bu8sht+4vy1Ku5mSNDQNpoANKL5wEdpEvwK86gYwYkgn9k5sn53UR1udFmAMYm
         vVXA==
X-Forwarded-Encrypted: i=1; AJvYcCWv3Vg5d2G5ksNge13urdPGEsKnDtSHqI6h5LnRxlK/86Nfl2sD3dDdtgDA3SP9+gRdDBjikf6oP7bMQbgKsL4zdfCw27+D8w==
X-Gm-Message-State: AOJu0YwlZt/njwI4SSb6ZOiuvSabOQo6VM3Tmn8aTvFppFS6lxm1Yw4c
	OUXqiQ2LV5yf/vVrN7T/k1HDAO77llotRLwv6yOnEMLbCtakzJ9avk61daG9STvJMC6h4yMXkoS
	G0raZUS8qWdjHiruNSf/8fFR1S212akcA5mucnA==
X-Google-Smtp-Source: AGHT+IFlqSylMCeI6KGNha3000K+lFHjDKANDOKnq2alJEDr9oyGg2RKFtJGNI+yjwYm19RTm7J/7Xp71REjuXyqMMY=
X-Received: by 2002:a05:6830:1345:b0:6e2:f2cc:e985 with SMTP id
 r5-20020a056830134500b006e2f2cce985mr19962028otq.13.1708550192733; Wed, 21
 Feb 2024 13:16:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-4-surenb@google.com>
In-Reply-To: <20240221194052.927623-4-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 16:15:56 -0500
Message-ID: <CA+CK2bD8Cr1V2=PWAsf6CwDnakZ54Qaf_q5t4aVYV-jXQPtPbg@mail.gmail.com>
Subject: Re: [PATCH v4 03/36] mm/slub: Mark slab_free_freelist_hook() __always_inline
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 2:41=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> From: Kent Overstreet <kent.overstreet@linux.dev>
>
> It seems we need to be more forceful with the compiler on this one.
> This is done for performance reasons only.
>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  mm/slub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 2ef88bbf56a3..d31b03a8d9d5 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2121,7 +2121,7 @@ bool slab_free_hook(struct kmem_cache *s, void *x, =
bool init)
>         return !kasan_slab_free(s, x, init);
>  }
>
> -static inline bool slab_free_freelist_hook(struct kmem_cache *s,
> +static __always_inline bool slab_free_freelist_hook(struct kmem_cache *s=
,

__fastpath_inline seems to me more appropriate here. It prioritizes
memory vs performance.

>                                            void **head, void **tail,
>                                            int *cnt)
>  {
> --
> 2.44.0.rc0.258.g7320e95886-goog
>

