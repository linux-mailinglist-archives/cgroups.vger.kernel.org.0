Return-Path: <cgroups+bounces-5245-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4319AF65E
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2024 02:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 955CB1C216FC
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2024 00:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FBDA945;
	Fri, 25 Oct 2024 00:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OXbKjMQk"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CABA4C8C
	for <cgroups@vger.kernel.org>; Fri, 25 Oct 2024 00:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729817886; cv=none; b=K/rRp6VeBHNRlUaAosHO3/SBUQYuAtx/wKIRDxl6kUQmGw0ghMaDxN+iFOzyPRHqqjb6Nh8Z/Xpm9nuZmyEo5VYCDTJ0Qq2RmfENoQRlAUWC5CBlSF/d6w4HgLA2UB6Ts4FJuON9fdrVWdtl2pspVfU0ZJ6HGCOC1Z636Lmk86E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729817886; c=relaxed/simple;
	bh=xolqDSiF/t8NwBqI8KyIL1EDoz2Z1cEnzxLkapNXHyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GgPOCL3jHLwptuXOYMBMa1b2xASZgkv6D0nKtTT/wR0YBIGVMfJWRBEkIVOA5xyuQT2Zqe54XzMN106e9Xbiz7r/4NxOeT0c5Yo+PC1lRQFEeDOlNP0k7aeyng2ugv+zrFinew1J92wCOZgPDoPNJNIJlDD1KQCfOMU7stJFcM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OXbKjMQk; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so23374641fa.0
        for <cgroups@vger.kernel.org>; Thu, 24 Oct 2024 17:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729817882; x=1730422682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRxYZ+h/FbwZnes9RTBiCcRs5Qa6ycoRJlEPDD/8+ls=;
        b=OXbKjMQkGwDiIVJVNo+LQDaqejYU7YRo6qOZbzEOrNTcDQVAv4GlCbc6ohOP0y874u
         Z4TCekFDf3nTc7HLJrtAN0z9HH8qPOdH+NZz7ng7OXNHGrmz6qSJz2jGgJJqBg0YrNTh
         pPtweJS+5OQEMqiSa/YREM6xte+tyryJCMIbjIq+6zlm2u6up2mXxcBgJVb4tu6bRO8L
         i1vCm01qZGDBw98raXXrjKbr83IwcQGbodDkC7f4NMF9i6jMYLo0LG/JD9hzuae7Sugo
         2OpDbh0ZbJdu9VZji5bYepInk3Al6BII2QVtgh47PeqxwGaeFA8jleDzbl0a2CVn84Ih
         hZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729817882; x=1730422682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRxYZ+h/FbwZnes9RTBiCcRs5Qa6ycoRJlEPDD/8+ls=;
        b=PP/OslaiQMA5+TbBqhIxHZyohUC3jbM+xY/9FZ0y8za0qb6/emzZL5V5SJ+kXgyyFq
         cIdHtOoyuqbwT9DXV66zNFqyqMnc7efSO3ukuVbj4muoGaeY1Fs6kISG/TuAqzgq5kS5
         9UY6/c4vuLKy09WJcXRfBzsU0np/VkVtW8XqDnf498BxloLE62bEvJkhBtNNNK3JRtJL
         l733DkXdYJHHuFg9yd7inUKuvN1zWIUjWULoCsjF5eW3ns7Mz7dcm1FSAr2/cxROu919
         UWV07LQRShJ0iGfnJx/noAfAeZjLvKYU/VhKA3DXkvwqhE7VQnzlV+uFV8x+cyiDaDFs
         becQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/uTlVomslwyBj4uNmTXJcSTzPX6AvXtg41xXLvQGezh1l+y+8eb1CuuCzFMhROSOtYEw4lZiY@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2XXN+odwAmzWSeSsdyDq9pwTt1IpYMi8q1bJpq7703ocUOk2+
	tsNkaBsg5QksCt2gQ2aI1RUJnrSDZWltaT+QOrMYfD2T9GgJOx530getg9Wn7YTMYA6QDSrBeLM
	5iRrXcIGKj3bux6cozY9mcNeP7szvU7KccN7HoQTtSYHnvWREojMp
X-Google-Smtp-Source: AGHT+IGrmh2Cz6j6Rf4aibLQWQ9fp2BT5ntf4bIsDVqu5o3T8uAPGXryIIHdG+RHC2uG400sMXQr9MqHNLDnBS4Tstw=
X-Received: by 2002:a05:651c:2117:b0:2fb:5ae7:24e7 with SMTP id
 38308e7fff4ca-2fc9d2e6223mr72283631fa.4.1729817881950; Thu, 24 Oct 2024
 17:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025002511.129899-1-inwardvessel@gmail.com> <20241025002511.129899-3-inwardvessel@gmail.com>
In-Reply-To: <20241025002511.129899-3-inwardvessel@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 24 Oct 2024 17:57:25 -0700
Message-ID: <CAJD7tkZaMH04mBK649iHRhdTwRJh8teSOcc1mg=y8fRey2zHzA@mail.gmail.com>
Subject: Re: [PATCH 2/2] memcg: use memcg flush tracepoint
To: JP Kobryn <inwardvessel@gmail.com>
Cc: shakeel.butt@linux.dev, hannes@cmpxchg.org, akpm@linux-foundation.org, 
	rostedt@goodmis.org, linux-mm@kvack.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 5:26=E2=80=AFPM JP Kobryn <inwardvessel@gmail.com> =
wrote:
>
> Make use of the flush tracepoint within memcontrol.
>
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

Is the intention to use tools like bpftrace to analyze where we flush
the most? In this case, why can't we just attach to the fentry of
do_flush_stats() and use the stack trace to find the path?

We can also attach to mem_cgroup_flush_stats(), and the difference in
counts between the two will be the number of skipped flushes.

Are there other use cases for these tracepoints?

> ---
>  mm/memcontrol.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 18c3f513d766..f816737228fa 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -613,8 +613,11 @@ void mem_cgroup_flush_stats(struct mem_cgroup *memcg=
)
>         if (!memcg)
>                 memcg =3D root_mem_cgroup;
>
> -       if (memcg_vmstats_needs_flush(memcg->vmstats))
> +       if (memcg_vmstats_needs_flush(memcg->vmstats)) {
> +               trace_memcg_flush_stats(memcg, TRACE_MEMCG_FLUSH_READER);
>                 do_flush_stats(memcg);
> +       } else
> +               trace_memcg_flush_stats(memcg, TRACE_MEMCG_FLUSH_READER_S=
KIP);
>  }
>
>  void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg)
> @@ -630,6 +633,7 @@ static void flush_memcg_stats_dwork(struct work_struc=
t *w)
>          * Deliberately ignore memcg_vmstats_needs_flush() here so that f=
lushing
>          * in latency-sensitive paths is as cheap as possible.
>          */
> +       trace_memcg_flush_stats(root_mem_cgroup, TRACE_MEMCG_FLUSH_PERIOD=
IC);
>         do_flush_stats(root_mem_cgroup);
>         queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_T=
IME);
>  }
> @@ -5285,6 +5289,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
>                  * mem_cgroup_flush_stats() ignores small changes. Use
>                  * do_flush_stats() directly to get accurate stats for ch=
arging.
>                  */
> +               trace_memcg_flush_stats(memcg, TRACE_MEMCG_FLUSH_ZSWAP);
>                 do_flush_stats(memcg);
>                 pages =3D memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE_S=
IZE;
>                 if (pages < max)
> --
> 2.47.0
>

