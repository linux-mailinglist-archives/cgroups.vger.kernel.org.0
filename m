Return-Path: <cgroups+bounces-1013-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0EC81DBAF
	for <lists+cgroups@lfdr.de>; Sun, 24 Dec 2023 18:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E4D61F21899
	for <lists+cgroups@lfdr.de>; Sun, 24 Dec 2023 17:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAA1C8FD;
	Sun, 24 Dec 2023 17:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dg5gIxNT"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A757BCA69
	for <cgroups@vger.kernel.org>; Sun, 24 Dec 2023 17:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E45C433CB
	for <cgroups@vger.kernel.org>; Sun, 24 Dec 2023 17:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703438504;
	bh=6WgdcpKwy6mdrgckrPfIftbBONnLJienzp1Ht42/LRI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Dg5gIxNTOKYHX2S3xgcTqr1Sj9w7VxOXPGlFGVI4jMmdma6P6ye3d0GmxmTkZAB55
	 wUdm7oKGJ+XmrZpaEY+erQp6844EJhT51CEsbHS2w8laYQnFtjcrQ7c/su2s12cC2v
	 mM4b50LW11yRZeeZCJvyAXsTqUq+08Xy3Z1gBB/IOqinAICl7Baulrm7JCFnVDC9ZP
	 6T2CoYXGvZYwl/7vFO1XDPGwWEIdynIizv8m9yLm0WeZSh86Q1DIwM8MUvftNcfkiT
	 +gTWYwywfgzWeN63XfwSAg7ji0WD/hgOA/FWpirOAbRP6EroPrn4bMjlIcFBPSuTei
	 XJdh3OosAzA+A==
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-35ff6de2068so4347455ab.0
        for <cgroups@vger.kernel.org>; Sun, 24 Dec 2023 09:21:44 -0800 (PST)
X-Gm-Message-State: AOJu0YzIh0wTqDgL2wlFruUr/tzywagXHhWo1YYDso/t7TAON2e1VrtI
	FIKHgr2v/XVx+L4CbpXfYnH81y2zfu8tGPfebfY7V+vRycjs
X-Google-Smtp-Source: AGHT+IHvCD5Qsq8aq0F14G0DVNdbjasQXiIU0/8Ngq3op9K0Wvz4LKqBcg7ZgT+On9vJO1EQY93/fSUy5UA2kZ5qHuE=
X-Received: by 2002:a05:6e02:1585:b0:35d:5995:1d75 with SMTP id
 m5-20020a056e02158500b0035d59951d75mr9904657ilu.58.1703438503435; Sun, 24 Dec
 2023 09:21:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220152653.3273778-1-schatzberg.dan@gmail.com> <20231220152653.3273778-3-schatzberg.dan@gmail.com>
In-Reply-To: <20231220152653.3273778-3-schatzberg.dan@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Sun, 24 Dec 2023 09:21:32 -0800
X-Gmail-Original-Message-ID: <CAF8kJuNCDDCk+Xn9wu+xuohRCTi8ah3z6TcdW6ZUoOYwmJQ1Lw@mail.gmail.com>
Message-ID: <CAF8kJuNCDDCk+Xn9wu+xuohRCTi8ah3z6TcdW6ZUoOYwmJQ1Lw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] mm: add swapiness= arg to memory.reclaim
To: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Jonathan Corbet <corbet@lwn.net>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, SeongJae Park <sj@kernel.org>, 
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Nhat Pham <nphamcs@gmail.com>, 
	Yue Zhao <findns94@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,

Thanks for removing the -1 special cases.

Acked-by: Chris Li <chrisl@kernel.org>

Chris

On Wed, Dec 20, 2023 at 7:27=E2=80=AFAM Dan Schatzberg <schatzberg.dan@gmai=
l.com> wrote:
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
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 18 ++++----
>  include/linux/swap.h                    |  3 +-
>  mm/memcontrol.c                         | 56 ++++++++++++++++++++-----
>  mm/vmscan.c                             | 13 +++++-
>  4 files changed, 69 insertions(+), 21 deletions(-)
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
> index d91963e2d47f..aa5666842c49 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -92,6 +92,9 @@ struct scan_control {
>         unsigned long   anon_cost;
>         unsigned long   file_cost;
>
> +       /* Swappiness value for reclaim. NULL will fall back to per-memcg=
/global value */
> +       int *swappiness;
> +
>         /* Can active folios be deactivated as part of reclaim? */
>  #define DEACTIVATE_ANON 1
>  #define DEACTIVATE_FILE 2
> @@ -2327,7 +2330,8 @@ static void get_scan_count(struct lruvec *lruvec, s=
truct scan_control *sc,
>         struct pglist_data *pgdat =3D lruvec_pgdat(lruvec);
>         struct mem_cgroup *memcg =3D lruvec_memcg(lruvec);
>         unsigned long anon_cost, file_cost, total_cost;
> -       int swappiness =3D mem_cgroup_swappiness(memcg);
> +       int swappiness =3D sc->swappiness ?
> +               *sc->swappiness : mem_cgroup_swappiness(memcg);
>         u64 fraction[ANON_AND_FILE];
>         u64 denominator =3D 0;    /* gcc */
>         enum scan_balance scan_balance;
> @@ -2608,6 +2612,9 @@ static int get_swappiness(struct lruvec *lruvec, st=
ruct scan_control *sc)
>             mem_cgroup_get_nr_swap_pages(memcg) < MIN_LRU_BATCH)
>                 return 0;
>
> +       if (sc->swappiness)
> +               return *sc->swappiness;
> +
>         return mem_cgroup_swappiness(memcg);
>  }
>
> @@ -6463,12 +6470,14 @@ unsigned long mem_cgroup_shrink_node(struct mem_c=
group *memcg,
>  unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>                                            unsigned long nr_pages,
>                                            gfp_t gfp_mask,
> -                                          unsigned int reclaim_options)
> +                                          unsigned int reclaim_options,
> +                                          int *swappiness)
>  {
>         unsigned long nr_reclaimed;
>         unsigned int noreclaim_flag;
>         struct scan_control sc =3D {
>                 .nr_to_reclaim =3D max(nr_pages, SWAP_CLUSTER_MAX),
> +               .swappiness =3D swappiness,
>                 .gfp_mask =3D (current_gfp_context(gfp_mask) & GFP_RECLAI=
M_MASK) |
>                                 (GFP_HIGHUSER_MOVABLE & ~GFP_RECLAIM_MASK=
),
>                 .reclaim_idx =3D MAX_NR_ZONES - 1,
> --
> 2.39.3
>
>

