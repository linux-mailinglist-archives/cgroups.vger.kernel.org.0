Return-Path: <cgroups+bounces-6926-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 284B6A590EB
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 11:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3D5B7A22A8
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 10:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF59D221F12;
	Mon, 10 Mar 2025 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfatjEro"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8762224234
	for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741601943; cv=none; b=rSnifpsCLLNHlj6mQcPhW0n3ZvkbD97jHgZG2CAsDplkJPkQJHgipZtvE5Va4I1XZkSyMWZYp4jB/jy9eHSq8L+oFgnbE2oRZdome+cgBA6uFEkeEJhJWYy9haQGop8frYOFmy4s3egQZDh3eJf4rkgsF6lgxPlhVFppD/bInZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741601943; c=relaxed/simple;
	bh=sbktM/iIfqIFsq3p+oM/Ugt337iQEwJK+oIKZ+0FCRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q0JnThEqdI8sPd7FF3xf2POE0pE+wjC+H8vjTlWBBPf7ChNhOi8M9p7/LLWsCiI4DOT6aojTNsbknpGrBtc+233DZ4r1pwP1Mka25L/fspfhvsE4nGou17HJ98lRSKFkz5Gx1aLmCG0AyjNjY2CbySz3XM1fmrxy9USPxaNdwW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfatjEro; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4394a823036so33866025e9.0
        for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 03:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741601940; x=1742206740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYIXrxRXI3mrwzjgczaAzsl5AVZ+PHyTsjrGME/HqJY=;
        b=JfatjEroEp8lvC4XLHs6+QWbpVgcycIqKcc9fug81diWGcyq7Ls9y4M4Z7HYLd57Z7
         wv0DFVGSp2q/99XAj0YCPW0g2Gg+S3HdlLkR5rFwdAoFz0+esDAuH7Cc1SJ/xZTBRi42
         LuN9mE4Pba3vhZeD0hGIyZEHQLjZ3Wxm41W7bitvtEERo1NdlNaz9d/iO7DplorA3eYi
         LjdpA6AEivOPrUsYsx6awcHyggRs/HyaR2ByWiZAVZpjUzkPrmqqrqsPD0439+F7GBt3
         YZmW0RkBUMqnXtcTLB1rFyRkqkzLXnhYw+cGJA3xXTqx7t2ThdkITHbFNFKmyJpZ1iHN
         KL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741601940; x=1742206740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYIXrxRXI3mrwzjgczaAzsl5AVZ+PHyTsjrGME/HqJY=;
        b=Vy+byNw7Sibo8GT95Cd9m8PlJaTtBNLo0tNA/WpZPqWYlE+R4SCtG0G8QPqT/XjmT8
         TOdNKW2ifE4EVkZ64dShtnYf6bnDjSUAEyPWtzrRYkGV2EVQATv7cA77FPmH1PtUL/BD
         ECEiMp5gbmIFsiAkpPVc+P3nIRjFw6pRBPCYvIiI35GHQRLMUjDut8G3maoo8kDE43HM
         QslOW4LekjtqgNJCJkmkPEKQnEqWVyRLJwF1jKhojigMIKHxH+9Z61xX/gnNNv6xG/8K
         gCqe41jXgrurphhQxRdD+tDYfTH2+o0Q1ymV++XcQCQOU2xBVx0f5IaEuRZ/KmFQJVpQ
         Up4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7oQtbfQwAi0g7im8ZU6XrWlFHhhhpfFLnz6OuhlkTgAGoekkzpBbvqkalXZf6i0Sf2kY3eqDq@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvwn/kyBeIcpWMVHwmfjn1TCByG3MbwuW8IvgeKfIiiDxJmqzE
	zGA2R7C9eERjO2nOUTUN1ca5djdllDbbw3Nvmn1Nr+gZYMni9IWM6hM/vd2jJP9jkssEes2r4YK
	2elsYT12bh7he2km4ghwALYTqyqw=
X-Gm-Gg: ASbGncv0m8FuZl+w4pE7NgdDZmEjGX0BKn3H0XQegjEw2SntB9OUroJq+mMd1Cfk5x0
	VhqDs47gS53IG97zTZftZkHRTuIZYFtis6hKaK6qTj3EcDt80DDpJGJc0OhBzzBEv/WJW8CKUVO
	wIghGLBcpoG1VRYDuzOsNV07wmHQ==
X-Google-Smtp-Source: AGHT+IG3KKR3sztBqM854chtE6ZigydmE5r2mOU3fRk0CgwZyiSgnHBPqXoRnnAMaab3bvuMcyOuCUbobZKBc/m9An0=
X-Received: by 2002:a05:600c:5108:b0:43b:c0fa:f9cd with SMTP id
 5b1f17b1804b1-43c5ca74af6mr80960235e9.7.1741601939328; Mon, 10 Mar 2025
 03:18:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202503101254.cfd454df-lkp@intel.com> <7c41d8d7-7d5a-4c3d-97b3-23642e376ff9@suse.cz>
In-Reply-To: <7c41d8d7-7d5a-4c3d-97b3-23642e376ff9@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Mar 2025 11:18:45 +0100
X-Gm-Features: AQ5f1JqFqw3tvfIj8rggR3xxiFMFdt52DuLrMnDSxkTVXR-gJz_FZwsVzLZ6uWs
Message-ID: <CAADnVQ+NKZtNxS+jBW=tMnmca18S2jfuGCR+ap1bPHYyhxy6HQ@mail.gmail.com>
Subject: Re: [linux-next:master] [memcg] 01d37228d3: netperf.Throughput_Mbps
 37.9% regression
To: Vlastimil Babka <vbabka@suse.cz>
Cc: kernel test robot <oliver.sang@intel.com>, Alexei Starovoitov <ast@kernel.org>, oe-lkp@lists.linux.dev, 
	kbuild test robot <lkp@intel.com>, Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 10:55=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 3/10/25 06:50, kernel test robot wrote:
> >
> >
> > Hello,
> >
> > kernel test robot noticed a 37.9% regression of netperf.Throughput_Mbps=
 on:
>
> I assume this is some network receive context where gfpflags do not allow
> blocking.

gfpflags_allow_spinning() should be true for all current callers
including networking.

> > commit: 01d37228d331047a0bbbd1026cec2ccabef6d88d ("memcg: Use trylock t=
o access memcg stock_lock.")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> >
> > [test failed on linux-next/master 7ec162622e66a4ff886f8f28712ea1b13069e=
1aa]
> >
> > testcase: netperf
> > config: x86_64-rhel-9.4
> > compiler: gcc-12
> > test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.=
00GHz (Ice Lake) with 256G memory
> > parameters:
> >
> >       ip: ipv4
> >       runtime: 300s
> >       nr_threads: 50%
> >       cluster: cs-localhost
> >       test: TCP_MAERTS
> >       cpufreq_governor: performance
> >
> >
> > In addition to that, the commit also has significant impact on the foll=
owing tests:
> >
> > +------------------+---------------------------------------------------=
-------------------------------------------------+
> > | testcase: change | stress-ng: stress-ng.mmapfork.ops_per_sec  63.5% r=
egression                                        |
>
> Hm interesting, this one at least from the name would be a GFP_KERNEL con=
text?

weird indeed.

> > | test machine     | 256 threads 4 sockets INTEL(R) XEON(R) PLATINUM 85=
92+ (Emerald Rapids) with 256G memory            |
> > | test parameters  | cpufreq_governor=3Dperformance                    =
                                                   |
> > |                  | nr_threads=3D100%                                 =
                                                   |
> > |                  | test=3Dmmapfork                                   =
                                                   |
> > |                  | testtime=3D60s                                    =
                                                   |
> > +------------------+---------------------------------------------------=
-------------------------------------------------+
> > | testcase: change | hackbench: hackbench.throughput  26.6% regression =
                                                 |
> > | test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 C=
PU @ 2.00GHz (Ice Lake) with 256G memory         |
> > | test parameters  | cpufreq_governor=3Dperformance                    =
                                                   |
> > |                  | ipc=3Dsocket                                      =
                                                   |
> > |                  | iterations=3D4                                    =
                                                   |
> > |                  | mode=3Dthreads                                    =
                                                   |
> > |                  | nr_threads=3D100%                                 =
                                                   |
> > +------------------+---------------------------------------------------=
-------------------------------------------------+
> > | testcase: change | lmbench3: lmbench3.TCP.socket.bandwidth.64B.MB/sec=
  33.0% regression                               |
> > | test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 84=
80CTDX (Sapphire Rapids) with 512G memory        |
> > | test parameters  | cpufreq_governor=3Dperformance                    =
                                                   |
> > |                  | mode=3Ddevelopment                                =
                                                   |
> > |                  | nr_threads=3D100%                                 =
                                                   |
> > |                  | test=3DTCP                                        =
                                                   |
> > |                  | test_memory_size=3D50%                            =
                                                   |
> > +------------------+---------------------------------------------------=
-------------------------------------------------+
> > | testcase: change | vm-scalability: vm-scalability.throughput  86.8% r=
egression                                        |
> > | test machine     | 256 threads 4 sockets INTEL(R) XEON(R) PLATINUM 85=
92+ (Emerald Rapids) with 256G memory            |
> > | test parameters  | cpufreq_governor=3Dperformance                    =
                                                   |
> > |                  | runtime=3D300s                                    =
                                                   |
> > |                  | size=3D1T                                         =
                                                   |
> > |                  | test=3Dlru-shm                                    =
                                                   |
> > +------------------+---------------------------------------------------=
-------------------------------------------------+
> > | testcase: change | netperf: netperf.Throughput_Mbps 39.9% improvement=
                                                 |
>
> An improvement? Weird.

Even more weird and makes no sense to me so far.

>
> > | test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 C=
PU @ 2.00GHz (Ice Lake) with 256G memory         |
> > | test parameters  | cluster=3Dcs-localhost                            =
                                                   |
> > |                  | cpufreq_governor=3Dperformance                    =
                                                   |
> > |                  | ip=3Dipv4                                         =
                                                   |
> > |                  | nr_threads=3D200%                                 =
                                                   |
> > |                  | runtime=3D300s                                    =
                                                   |
> > |                  | test=3DTCP_MAERTS                                 =
                                                   |
> > +------------------+---------------------------------------------------=
-------------------------------------------------+
> > | testcase: change | will-it-scale: will-it-scale.per_thread_ops  68.8%=
 regression                                      |
> > | test machine     | 104 threads 2 sockets (Skylake) with 192G memory  =
                                                 |
> > | test parameters  | cpufreq_governor=3Dperformance                    =
                                                   |
> > |                  | mode=3Dthread                                     =
                                                   |
> > |                  | nr_task=3D100%                                    =
                                                   |
> > |                  | test=3Dfallocate1                                 =
                                                   |
> > +------------------+---------------------------------------------------=
-------------------------------------------------+
>
> Some of those as well.
>
> Anyway we should not be expecting the localtry_trylock_irqsave() itself b=
e
> failing and resulting in a slow path, as that woulre require an allocatio=
n
> attempt from a nmi. So what else the commit does?
>
> >       0.10 =C2=B1  4%     +11.3       11.43 =C2=B1  3%  perf-profile.se=
lf.cycles-pp.try_charge_memcg
> >       0.00           +13.7       13.72 =C2=B1  2%  perf-profile.self.cy=
cles-pp.page_counter_try_charge
>
> This does suggest more time spent in try_charge_memcg() because consume_s=
tock() has failed.
>
> And I suspect this:
>
> +       if (!gfpflags_allow_spinning(gfp_mask))
> +               /* Avoid the refill and flush of the older stock */
> +               batch =3D nr_pages;
>
> because this will affect the refill even if consume_stock() fails not due=
 to
> a trylock failure (which should not be happening), but also just because =
the
> stock was of a wrong memcg or depleted. So in the nowait context we deny =
the
> refill even if we have the memory. Attached patch could be used to see if=
 it
> if fixes things. I'm not sure about the testcases where it doesn't look l=
ike
> nowait context would be used though, let's see.

Not quite.
GFP_NOWAIT includes __GFP_KSWAPD_RECLAIM,
so gfpflags_allow_spinning() will return true.

So 'batch' won't change.

> I've also found this:
> https://lore.kernel.org/all/7s6fbpwsynadnzybhdqg3jwhls4pq2sptyxuyghxpaufh=
issj5@iadb6ibzscjj/

Right. And notice Shakeel's suggestion doesn't include '!' in
the condition.
I assumed it's a typo.
Hence added it as "if (!gfpflags_allow_spinning(gfp_mask))"

> >
> > BTW after the done_restock tag in try_charge_memcg(), we will another
> > gfpflags_allow_spinning() check to avoid schedule_work() and
> > mem_cgroup_handle_over_high(). Maybe simply return early for
> > gfpflags_allow_spinning() without checking high marks.
>
> looks like a small possible optimization that was forgotten?
>  ----8<----
> From 29e7d18645577ce13d8a0140c0df050ce1ce0f95 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Mon, 10 Mar 2025 10:32:14 +0100
> Subject: [PATCH] memcg: Avoid stock refill only if stock_lock can't be
>  acquired
>
> Since commit 01d37228d331 ("memcg: Use trylock to access memcg
> stock_lock.") consume_stock() can fail if it can't obtain
> memcg_stock.stock_lock. In that case try_charge_memcg() also avoids
> refilling or flushing the stock when gfp flags indicate we are in the
> context where obtaining the lock could fail.
>
> However consume_stock() can also fail because the stock was depleted, or
> belonged to a different memcg. Avoiding the stock refill then reduces
> the caching efficiency, as the refill could still succeed with memory
> available. This has caused various regressions to be reported by the
> kernel test robot.
>
> To fix this, make the decision to avoid stock refill more precise by
> making consume_stock() return -EBUSY when it fails to obtain stock_lock,
> and using that for the no-refill decision.
>
> Fixes: 01d37228d331 ("memcg: Use trylock to access memcg stock_lock.")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202503101254.cfd454df-lkp@intel.co=
m
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/memcontrol.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 092cab99dec7..a8371a22c7f4 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1772,22 +1772,23 @@ static bool obj_stock_flush_required(struct memcg=
_stock_pcp *stock,
>   * stock, and at least @nr_pages are available in that stock.  Failure t=
o
>   * service an allocation will refill the stock.
>   *
> - * returns true if successful, false otherwise.
> + * returns 0 if successful, -EBUSY if lock cannot be acquired, or -ENOME=
M
> + * if the memcg does not match or there are not enough pages
>   */
> -static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_page=
s,
> +static int consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages=
,
>                           gfp_t gfp_mask)
>  {
>         struct memcg_stock_pcp *stock;
>         unsigned int stock_pages;
>         unsigned long flags;
> -       bool ret =3D false;
> +       bool ret =3D -ENOMEM;
>
>         if (nr_pages > MEMCG_CHARGE_BATCH)
>                 return ret;
>
>         if (!localtry_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
>                 if (!gfpflags_allow_spinning(gfp_mask))
> -                       return ret;
> +                       return -EBUSY;
>                 localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
>         }
>
> @@ -1795,7 +1796,7 @@ static bool consume_stock(struct mem_cgroup *memcg,=
 unsigned int nr_pages,
>         stock_pages =3D READ_ONCE(stock->nr_pages);
>         if (memcg =3D=3D READ_ONCE(stock->cached) && stock_pages >=3D nr_=
pages) {
>                 WRITE_ONCE(stock->nr_pages, stock_pages - nr_pages);
> -               ret =3D true;
> +               ret =3D 0;
>         }
>
>         localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
> @@ -2228,13 +2229,18 @@ int try_charge_memcg(struct mem_cgroup *memcg, gf=
p_t gfp_mask,
>         bool drained =3D false;
>         bool raised_max_event =3D false;
>         unsigned long pflags;
> +       int consume_ret;
>
>  retry:
> -       if (consume_stock(memcg, nr_pages, gfp_mask))
> +       consume_ret =3D consume_stock(memcg, nr_pages, gfp_mask);
> +       if (!consume_ret)
>                 return 0;
>
> -       if (!gfpflags_allow_spinning(gfp_mask))
> -               /* Avoid the refill and flush of the older stock */
> +       /*
> +        * Avoid the refill and flush of the older stock if we failed to =
acquire
> +        * the stock_lock
> +        */
> +       if (consume_ret =3D=3D -EBUSY)
>                 batch =3D nr_pages;

Sure.
I think it's a good optimization, but I don't think it will make
any difference here.
Fixes tag is not appropriate and the commit log is off too.

I have strong suspicion that this bot report is bogus.

I'll try to repro anyway.

