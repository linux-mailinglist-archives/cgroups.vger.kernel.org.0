Return-Path: <cgroups+bounces-777-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DF5801B84
	for <lists+cgroups@lfdr.de>; Sat,  2 Dec 2023 09:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1468E281EA8
	for <lists+cgroups@lfdr.de>; Sat,  2 Dec 2023 08:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEBEBA31;
	Sat,  2 Dec 2023 08:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MShJEUEz"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFBA196
	for <cgroups@vger.kernel.org>; Sat,  2 Dec 2023 00:31:32 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5c668b87db3so580a12.3
        for <cgroups@vger.kernel.org>; Sat, 02 Dec 2023 00:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701505892; x=1702110692; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RsUdxN3rEKIxfrBuDtxm58n3Q5/dFJQLUdAs66Hut1M=;
        b=MShJEUEzENjNwWoJezzhBQZOjctUkNEpt0Ur0LcriNCkEPkJeXV5Hzt48ikjmbdlEE
         4flTeoovGc5J98C7K3KrUu4jD+0HvgvrVmcdP/u8qws8PPFg76fveDJqvW17GIUXSWF9
         MZMpFttgoyDmuUBDlk300DRq9QaQnAk8ntLudSo3TY6RLVtlPSLF4SGaetiyTTYGk+J1
         bC9fCyBk4Bbrq8v1wiZP5IiFnl9aY7eu/Etb8L0QR3TXxNAB1U46XPCvEiH3B0bTQJKK
         9ojkRXjzqwUbWbNQG8PJLwX0SeZj4LCooIycUA5Iic8r4v++IpRCuc6KsikZYVajxep2
         LNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701505892; x=1702110692;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RsUdxN3rEKIxfrBuDtxm58n3Q5/dFJQLUdAs66Hut1M=;
        b=dIvbyNv445BsI3ucXG/Gk81iRHyXmqsTdDfXx6S5r2cMH0YRD+wHMbpJVJDYKar3Sg
         4VIH4y9KVTLAzGwZoL6bJLJQ7NBUDlBeXVBN6E42TIGz2zgtrnySBA/qp+uPEaJa1HUg
         B3O7bWPAFCoOBH2QzVzJ9doi0tWttUKm/tz9rKlZ3blRZIQvJfGTpjf5RRnYfDb9lk05
         0QBy++0v5SvgEGWm6JAKlbRhNWuSnBvYGsAG6IyXQQinWlbRgncmOlTgS4HHvFsqOBbx
         lidAwEb4XxuCIbZ1FyI99kalkS/H903Rh1df2pc4211g5sMtq4wIfPFW20h/bg50ITvo
         27iA==
X-Gm-Message-State: AOJu0YwVw7/WkRV0fxdalKwDVHRl6Hf2WqtCkFKe/eTg2pmpPoDCGQhX
	mPyKTa0He4u20QSijAQNOw+xnYbieGuI+g==
X-Google-Smtp-Source: AGHT+IF4f5vUtic/5wEWsO4maQQ3yGnMxcSHVpbovj/TMUbKq4uvbD+NDX7zW2s8EKvkAZHr3JG7LPHRBRuUXQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a63:d249:0:b0:5bd:408a:5e1f with SMTP id
 t9-20020a63d249000000b005bd408a5e1fmr4143862pgi.3.1701505891574; Sat, 02 Dec
 2023 00:31:31 -0800 (PST)
Date: Sat, 2 Dec 2023 08:31:29 +0000
In-Reply-To: <20231129032154.3710765-6-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129032154.3710765-1-yosryahmed@google.com> <20231129032154.3710765-6-yosryahmed@google.com>
Message-ID: <20231202083129.3pmds2cddy765szr@google.com>
Subject: Re: [mm-unstable v4 5/5] mm: memcg: restore subtree stats flushing
From: Shakeel Butt <shakeelb@google.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>, 
	"Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>, Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com, 
	Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 29, 2023 at 03:21:53AM +0000, Yosry Ahmed wrote:
[...]
> +void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
>  {
> -	if (memcg_should_flush_stats(root_mem_cgroup))
> -		do_flush_stats();
> +	static DEFINE_MUTEX(memcg_stats_flush_mutex);
> +
> +	if (mem_cgroup_disabled())
> +		return;
> +
> +	if (!memcg)
> +		memcg = root_mem_cgroup;
> +
> +	if (memcg_should_flush_stats(memcg)) {
> +		mutex_lock(&memcg_stats_flush_mutex);

What's the point of this mutex now? What is it providing? I understand
we can not try_lock here due to targeted flushing. Why not just let the
global rstat serialize the flushes? Actually this mutex can cause
latency hiccups as the mutex owner can get resched during flush and then
no one can flush for a potentially long time.

> +		/* Check again after locking, another flush may have occurred */
> +		if (memcg_should_flush_stats(memcg))
> +			do_flush_stats(memcg);
> +		mutex_unlock(&memcg_stats_flush_mutex);
> +	}
>  }


