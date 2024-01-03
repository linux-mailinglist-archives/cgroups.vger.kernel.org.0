Return-Path: <cgroups+bounces-1063-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32856823321
	for <lists+cgroups@lfdr.de>; Wed,  3 Jan 2024 18:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A207D285EB6
	for <lists+cgroups@lfdr.de>; Wed,  3 Jan 2024 17:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F6F1C292;
	Wed,  3 Jan 2024 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Atl/xmbL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216951C284
	for <cgroups@vger.kernel.org>; Wed,  3 Jan 2024 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d5b7be937so58905e9.1
        for <cgroups@vger.kernel.org>; Wed, 03 Jan 2024 09:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704302419; x=1704907219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hb5xC6t0pn96kkmtug80GejA/Np7+9OFKKytSk7vENk=;
        b=Atl/xmbLWu0ixoQ0qomQ+glm35ECiDbUtDkc52eEjoUCuQ45DN5CJeOP+w5KyHPpYh
         tTn+I++i11EHfjrpRjUipAfRwej6HV769xbaIYznGFdd5Cf9Y3jH7nidqdj108Bm4qdL
         qYAzs3Yw1mRorlbMF3Tg/GeKwUZDAlFJq9FMfqM/Z6gBqQOkHA+LPPr3Y19dKcmjmvC3
         +E6dkIcxBgc9OwQ6BPueAtwiqGxK7QJ0cUCWr88qnv74kZmrjx49W0jrBKNJxDEk6RK4
         QvAqXrmG0WeIbDiIZAN7BCdP2JWnM1sEcVSLarpILKsuwIptdVG0XwjLaZ9kpFZ5swPi
         eUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704302419; x=1704907219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hb5xC6t0pn96kkmtug80GejA/Np7+9OFKKytSk7vENk=;
        b=Y/rWpLQNZqNaFlls/YKhAi6qCJdJxn1lDeajEG3OrasFjW3uHBZH4EcgR1lSmgtdse
         NhaxwmACk6YcwAJolYAkLto7AYUcDAV5yl9NPSgXbWHEI68r5nyPn3K4cI1WdCYiaimO
         y6Qi+Etnz2wKfXixZ5L8qiy4dSlJXBV9X2HnsLk2u1pDibRg1D2LLefe68OqK6gnSU6y
         watGfH55xfU+YvrzvyEBeTlNQPoBsjPBonSUMl2s6XmCC0/foGkTiW8Mg3+A8+0j/CLe
         Wgj9v8VDsr74k4f+Xj86hemyda0mV/Us5GXjI+5+Pupt47eZXgVfJCywAmVfboECb9ZM
         /6ZQ==
X-Gm-Message-State: AOJu0YzSobrrINXuba5PXj/LlcazVBE7vnUQFwBdaMt3Nk517jRSFX3/
	nAHqXg2Cum9/eOHXUhYRUH82yNbboGanJkWuidR2sOJFNw1K
X-Google-Smtp-Source: AGHT+IHqshiEzaF64yv7x29Y57uTQUHR/9YOqRhLJ4WX5tYZSEcWBmcwyF4+aQoJ1J6W74i8ZRdYAi2/NRyaDjo9O44=
X-Received: by 2002:a05:600c:1c20:b0:40d:3ab7:86e0 with SMTP id
 j32-20020a05600c1c2000b0040d3ab786e0mr128881wms.3.1704302419113; Wed, 03 Jan
 2024 09:20:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103164841.2800183-1-schatzberg.dan@gmail.com> <20240103164841.2800183-3-schatzberg.dan@gmail.com>
In-Reply-To: <20240103164841.2800183-3-schatzberg.dan@gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 3 Jan 2024 10:19:40 -0700
Message-ID: <CAOUHufZ-hTwdiy7eYgJWo=CHyPbdxTX60hxjPmwa9Ox6FXMYQQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] mm: add swapiness= arg to memory.reclaim
To: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, 
	Yosry Ahmed <yosryahmed@google.com>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Chris Li <chrisl@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 9:49=E2=80=AFAM Dan Schatzberg <schatzberg.dan@gmail=
.com> wrote:
>
> Allow proactive reclaimers to submit an additional swappiness=3D<val>
> argument to memory.reclaim. This overrides the global or per-memcg
> swappiness setting for that reclaim attempt.
>
> For example:
>
> echo "2M swappiness=3D0" > /sys/fs/cgroup/memory.reclaim
>
> will perform reclaim on the rootcg with a swappiness setting of 0 (no
> swap) regardless of the vm.swappiness sysctl setting.
>
> Userspace proactive reclaimers use the memory.reclaim interface to
> trigger reclaim. The memory.reclaim interface does not allow for any way
> to effect the balance of file vs anon during proactive reclaim. The only
> approach is to adjust the vm.swappiness setting. However, there are a
> few reasons we look to control the balance of file vs anon during
> proactive reclaim, separately from reactive reclaim:
>
> * Swapout should be limited to manage SSD write endurance. In near-OOM
> situations we are fine with lots of swap-out to avoid OOMs. As these are
> typically rare events, they have relatively little impact on write
> endurance. However, proactive reclaim runs continuously and so its
> impact on SSD write endurance is more significant. Therefore it is
> desireable to control swap-out for proactive reclaim separately from
> reactive reclaim
>
> * Some userspace OOM killers like systemd-oomd[1] support OOM killing on
> swap exhaustion. This makes sense if the swap exhaustion is triggered
> due to reactive reclaim but less so if it is triggered due to proactive
> reclaim (e.g. one could see OOMs when free memory is ample but anon is
> just particularly cold). Therefore, it's desireable to have proactive
> reclaim reduce or stop swap-out before the threshold at which OOM
> killing occurs.
>
> In the case of Meta's Senpai proactive reclaimer, we adjust
> vm.swappiness before writes to memory.reclaim[2]. This has been in
> production for nearly two years and has addressed our needs to control
> proactive vs reactive reclaim behavior but is still not ideal for a
> number of reasons:
>
> * vm.swappiness is a global setting, adjusting it can race/interfere
> with other system administration that wishes to control vm.swappiness.
> In our case, we need to disable Senpai before adjusting vm.swappiness.
>
> * vm.swappiness is stateful - so a crash or restart of Senpai can leave
> a misconfigured setting. This requires some additional management to
> record the "desired" setting and ensure Senpai always adjusts to it.
>
> With this patch, we avoid these downsides of adjusting vm.swappiness
> globally.
>
> [1]https://www.freedesktop.org/software/systemd/man/latest/systemd-oomd.s=
ervice.html
> [2]https://github.com/facebookincubator/oomd/blob/main/src/oomd/plugins/S=
enpai.cpp#L585-L598
>
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> Suggested-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Acked-by: Chris Li <chrisl@kernel.org>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 18 ++++----
>  include/linux/swap.h                    |  3 +-
>  mm/memcontrol.c                         | 56 ++++++++++++++++++++-----
>  mm/vmscan.c                             | 25 +++++++++--
>  4 files changed, 80 insertions(+), 22 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index 3f85254f3cef..ee42f74e0765 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1282,17 +1282,10 @@ PAGE_SIZE multiple when read back.
>         This is a simple interface to trigger memory reclaim in the
>         target cgroup.
>
> -       This file accepts a single key, the number of bytes to reclaim.
> -       No nested keys are currently supported.
> -
>         Example::
>
>           echo "1G" > memory.reclaim
>
> -       The interface can be later extended with nested keys to
> -       configure the reclaim behavior. For example, specify the
> -       type of memory to reclaim from (anon, file, ..).
> -
>         Please note that the kernel can over or under reclaim from
>         the target cgroup. If less bytes are reclaimed than the
>         specified amount, -EAGAIN is returned.
> @@ -1304,6 +1297,17 @@ PAGE_SIZE multiple when read back.
>         This means that the networking layer will not adapt based on
>         reclaim induced by memory.reclaim.
>
> +The following nested keys are defined.
> +
> +         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D            =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +         swappiness            Swappiness value to reclaim with
> +         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D            =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +       Specifying a swappiness value instructs the kernel to perform
> +       the reclaim with that swappiness value. Note that this has the
> +       same semantics as vm.swappiness applied to memcg reclaim with
> +       all the existing limitations and potential future extensions.
> +
>    memory.peak
>         A read-only single value file which exists on non-root
>         cgroups.
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index e2ab76c25b4a..8afdec40efe3 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -412,7 +412,8 @@ extern unsigned long try_to_free_pages(struct zonelis=
t *zonelist, int order,
>  extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *mem=
cg,
>                                                   unsigned long nr_pages,
>                                                   gfp_t gfp_mask,
> -                                                 unsigned int reclaim_op=
tions);
> +                                                 unsigned int reclaim_op=
tions,
> +                                                 int *swappiness);
>  extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
>                                                 gfp_t gfp_mask, bool nosw=
ap,
>                                                 pg_data_t *pgdat,
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index fbe9f02dd206..6d627a754851 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -52,6 +52,7 @@
>  #include <linux/sort.h>
>  #include <linux/fs.h>
>  #include <linux/seq_file.h>
> +#include <linux/parser.h>
>  #include <linux/vmpressure.h>
>  #include <linux/memremap.h>
>  #include <linux/mm_inline.h>
> @@ -2449,7 +2450,8 @@ static unsigned long reclaim_high(struct mem_cgroup=
 *memcg,
>                 psi_memstall_enter(&pflags);
>                 nr_reclaimed +=3D try_to_free_mem_cgroup_pages(memcg, nr_=
pages,
>                                                         gfp_mask,
> -                                                       MEMCG_RECLAIM_MAY=
_SWAP);
> +                                                       MEMCG_RECLAIM_MAY=
_SWAP,
> +                                                       NULL);
>                 psi_memstall_leave(&pflags);
>         } while ((memcg =3D parent_mem_cgroup(memcg)) &&
>                  !mem_cgroup_is_root(memcg));
> @@ -2740,7 +2742,7 @@ static int try_charge_memcg(struct mem_cgroup *memc=
g, gfp_t gfp_mask,
>
>         psi_memstall_enter(&pflags);
>         nr_reclaimed =3D try_to_free_mem_cgroup_pages(mem_over_limit, nr_=
pages,
> -                                                   gfp_mask, reclaim_opt=
ions);
> +                                                   gfp_mask, reclaim_opt=
ions, NULL);
>         psi_memstall_leave(&pflags);
>
>         if (mem_cgroup_margin(mem_over_limit) >=3D nr_pages)
> @@ -3660,7 +3662,7 @@ static int mem_cgroup_resize_max(struct mem_cgroup =
*memcg,
>                 }
>
>                 if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
> -                                       memsw ? 0 : MEMCG_RECLAIM_MAY_SWA=
P)) {
> +                                       memsw ? 0 : MEMCG_RECLAIM_MAY_SWA=
P, NULL)) {
>                         ret =3D -EBUSY;
>                         break;
>                 }
> @@ -3774,7 +3776,7 @@ static int mem_cgroup_force_empty(struct mem_cgroup=
 *memcg)
>                         return -EINTR;
>
>                 if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
> -                                                 MEMCG_RECLAIM_MAY_SWAP)=
)
> +                                                 MEMCG_RECLAIM_MAY_SWAP,=
 NULL))
>                         nr_retries--;
>         }
>
> @@ -6720,7 +6722,7 @@ static ssize_t memory_high_write(struct kernfs_open=
_file *of,
>                 }
>
>                 reclaimed =3D try_to_free_mem_cgroup_pages(memcg, nr_page=
s - high,
> -                                       GFP_KERNEL, MEMCG_RECLAIM_MAY_SWA=
P);
> +                                       GFP_KERNEL, MEMCG_RECLAIM_MAY_SWA=
P, NULL);
>
>                 if (!reclaimed && !nr_retries--)
>                         break;
> @@ -6769,7 +6771,7 @@ static ssize_t memory_max_write(struct kernfs_open_=
file *of,
>
>                 if (nr_reclaims) {
>                         if (!try_to_free_mem_cgroup_pages(memcg, nr_pages=
 - max,
> -                                       GFP_KERNEL, MEMCG_RECLAIM_MAY_SWA=
P))
> +                                       GFP_KERNEL, MEMCG_RECLAIM_MAY_SWA=
P, NULL))
>                                 nr_reclaims--;
>                         continue;
>                 }
> @@ -6895,19 +6897,50 @@ static ssize_t memory_oom_group_write(struct kern=
fs_open_file *of,
>         return nbytes;
>  }
>
> +enum {
> +       MEMORY_RECLAIM_SWAPPINESS =3D 0,
> +       MEMORY_RECLAIM_NULL,
> +};
> +
> +static const match_table_t tokens =3D {
> +       { MEMORY_RECLAIM_SWAPPINESS, "swappiness=3D%d"},
> +       { MEMORY_RECLAIM_NULL, NULL },
> +};
> +
>  static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
>                               size_t nbytes, loff_t off)
>  {
>         struct mem_cgroup *memcg =3D mem_cgroup_from_css(of_css(of));
>         unsigned int nr_retries =3D MAX_RECLAIM_RETRIES;
>         unsigned long nr_to_reclaim, nr_reclaimed =3D 0;
> +       int swappiness =3D -1;
>         unsigned int reclaim_options;
> -       int err;
> +       char *old_buf, *start;
> +       substring_t args[MAX_OPT_ARGS];
>
>         buf =3D strstrip(buf);
> -       err =3D page_counter_memparse(buf, "", &nr_to_reclaim);
> -       if (err)
> -               return err;
> +
> +       old_buf =3D buf;
> +       nr_to_reclaim =3D memparse(buf, &buf) / PAGE_SIZE;
> +       if (buf =3D=3D old_buf)
> +               return -EINVAL;
> +
> +       buf =3D strstrip(buf);
> +
> +       while ((start =3D strsep(&buf, " ")) !=3D NULL) {
> +               if (!strlen(start))
> +                       continue;
> +               switch (match_token(start, tokens, args)) {
> +               case MEMORY_RECLAIM_SWAPPINESS:
> +                       if (match_int(&args[0], &swappiness))
> +                               return -EINVAL;
> +                       if (swappiness < MIN_SWAPPINESS || swappiness > M=
AX_SWAPPINESS)
> +                               return -EINVAL;
> +                       break;
> +               default:
> +                       return -EINVAL;
> +               }
> +       }
>
>         reclaim_options =3D MEMCG_RECLAIM_MAY_SWAP | MEMCG_RECLAIM_PROACT=
IVE;
>         while (nr_reclaimed < nr_to_reclaim) {
> @@ -6926,7 +6959,8 @@ static ssize_t memory_reclaim(struct kernfs_open_fi=
le *of, char *buf,
>
>                 reclaimed =3D try_to_free_mem_cgroup_pages(memcg,
>                                         min(nr_to_reclaim - nr_reclaimed,=
 SWAP_CLUSTER_MAX),
> -                                       GFP_KERNEL, reclaim_options);
> +                                       GFP_KERNEL, reclaim_options,
> +                                       swappiness =3D=3D -1 ? NULL : &sw=
appiness);
>
>                 if (!reclaimed && !nr_retries--)
>                         return -EAGAIN;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index d91963e2d47f..394e0dd46b2e 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -92,6 +92,11 @@ struct scan_control {
>         unsigned long   anon_cost;
>         unsigned long   file_cost;
>
> +#ifdef CONFIG_MEMCG
> +       /* Swappiness value for proactive reclaim. Always use sc_swappine=
ss()! */
> +       int *proactive_swappiness;
> +#endif

Why is proactive_swappiness still a pointer? The whole point of the
previous conversation is that sc->proactive can tell whether
sc->swappiness is valid or not, and that's less awkward than using a
pointer.

Also why the #ifdef here? I don't see the point for a small stack
variable. Otherwise wouldn't we want to do this for sc->proactive as
well?

If you really want it to be explicit, you could do
  struct scan_control {
    ...
    struct {
      bool is_set;
      int swappiness;
    } proactive;
  };

But I think even this is too much.

