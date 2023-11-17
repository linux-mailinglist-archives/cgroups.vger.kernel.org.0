Return-Path: <cgroups+bounces-466-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA48D7EF777
	for <lists+cgroups@lfdr.de>; Fri, 17 Nov 2023 19:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2085D1C20952
	for <lists+cgroups@lfdr.de>; Fri, 17 Nov 2023 18:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F9643AB7;
	Fri, 17 Nov 2023 18:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXWrazzd"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FCD433D4
	for <cgroups@vger.kernel.org>; Fri, 17 Nov 2023 18:27:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FD5C433B6
	for <cgroups@vger.kernel.org>; Fri, 17 Nov 2023 18:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700245676;
	bh=H2YJzXZHeJMrqobov57j5Mo2OH4tf0fbT7tTCJHnXIo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oXWrazzdj4fEldueS4rULJ5F/DAW9Te1RVNyHNBdkoXhUW9Wx3X6kYxQikIFgJnJL
	 s0ZnPj+Ha+FnZCKm+LB+yErJsPvh/5MVORN17pUuGEfTB4nhK8XBXYrdWCkocGxKiu
	 RVm0g7wPCbb5iDcsj4hjM/VQzx/i0RG7NYWEun1lUOJ8w+BBFt0As6Pqfw/+KOAtLX
	 i6m6wQRMKxUZLxdxBw5jcihA15/9my3kZphYYEOprR0sRp4VmflVd0KUCsYqe12qcy
	 5gqcXAuaM2iEHQiin2LYU6Q/pjxqR6qfAu9dgz8RUW7Hakb2huEHBYGauzrizQGB/d
	 yALJaa0qh581w==
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2802d218242so1977116a91.1
        for <cgroups@vger.kernel.org>; Fri, 17 Nov 2023 10:27:56 -0800 (PST)
X-Gm-Message-State: AOJu0YzEZnD3o449d+WZWRnaqDmtqny6+M+WaLzw8MEk7UmlBt2eEA46
	3lmpLUGk56TI5cYgtKV+mp7oxeBu9tIOyH2tkaXPOA==
X-Google-Smtp-Source: AGHT+IFoONsJ5TfEjg90Ha4FkisHSprLoOsbnKOCvt55cyMLKRofW8yCafXcaCGInFvYbr5apUmtHKRD6VY5ZEM3NNg=
X-Received: by 2002:a17:90b:1c83:b0:27d:b3d:5c33 with SMTP id
 oo3-20020a17090b1c8300b0027d0b3d5c33mr386546pjb.28.1700245675572; Fri, 17 Nov
 2023 10:27:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116022411.2250072-1-yosryahmed@google.com> <20231116022411.2250072-2-yosryahmed@google.com>
In-Reply-To: <20231116022411.2250072-2-yosryahmed@google.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 17 Nov 2023 10:27:44 -0800
X-Gmail-Original-Message-ID: <CAF8kJuOh9rLBGBr3z2MXZgjjVbrSyFXQFCV+p1eC6DmKiir3Mw@mail.gmail.com>
Message-ID: <CAF8kJuOh9rLBGBr3z2MXZgjjVbrSyFXQFCV+p1eC6DmKiir3Mw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] mm: memcg: change flush_next_time to flush_last_time
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com, 
	Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm <linux-mm@kvack.org>, 
	cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yosry,

Acked-by: Chris Li <chrisl@kernel.org> (Google)

Chris

On Wed, Nov 15, 2023 at 6:24=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> flush_next_time is an inaccurate name. It's not the next time that
> periodic flushing will happen, it's rather the next time that
> ratelimited flushing can happen if the periodic flusher is late.
>
> Simplify its semantics by just storing the timestamp of the last flush
> instead, flush_last_time. Move the 2*FLUSH_TIME addition to
> mem_cgroup_flush_stats_ratelimited(), and add a comment explaining it.
> This way, all the ratelimiting semantics live in one place.
>
> No functional change intended.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Tested-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> ---
>  mm/memcontrol.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 774bd6e21e278..18931d82f108f 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -593,7 +593,7 @@ static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flu=
sh_memcg_stats_dwork);
>  static DEFINE_PER_CPU(unsigned int, stats_updates);
>  static atomic_t stats_flush_ongoing =3D ATOMIC_INIT(0);
>  static atomic_t stats_flush_threshold =3D ATOMIC_INIT(0);
> -static u64 flush_next_time;
> +static u64 flush_last_time;
>
>  #define FLUSH_TIME (2UL*HZ)
>
> @@ -653,7 +653,7 @@ static void do_flush_stats(void)
>             atomic_xchg(&stats_flush_ongoing, 1))
>                 return;
>
> -       WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
> +       WRITE_ONCE(flush_last_time, jiffies_64);
>
>         cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
>
> @@ -669,7 +669,8 @@ void mem_cgroup_flush_stats(void)
>
>  void mem_cgroup_flush_stats_ratelimited(void)
>  {
> -       if (time_after64(jiffies_64, READ_ONCE(flush_next_time)))
> +       /* Only flush if the periodic flusher is one full cycle late */
> +       if (time_after64(jiffies_64, READ_ONCE(flush_last_time) + 2*FLUSH=
_TIME))
>                 mem_cgroup_flush_stats();
>  }
>
> --
> 2.43.0.rc0.421.g78406f8d94-goog
>
>

