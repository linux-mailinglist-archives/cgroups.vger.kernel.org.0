Return-Path: <cgroups+bounces-914-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF0880E0AE
	for <lists+cgroups@lfdr.de>; Tue, 12 Dec 2023 02:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C70282606
	for <lists+cgroups@lfdr.de>; Tue, 12 Dec 2023 01:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E25064A;
	Tue, 12 Dec 2023 01:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EP1BbKtW"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58EF639
	for <cgroups@vger.kernel.org>; Tue, 12 Dec 2023 01:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD062C433CC
	for <cgroups@vger.kernel.org>; Tue, 12 Dec 2023 01:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702343227;
	bh=MDets05mPCDoqLxyZIXukdeciXvfqDz5mf6mMUdN2sM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EP1BbKtWWaBQvGIDk2Hvi9L+UYeZNhtroplbMAv4+6AOEMlK9FiFAJu3sLFOtrRmp
	 rCm3llUhRUAm1nytlNBhtwfWBccJSw6d8IXmR0eL+JmSmtvwk4o4Gmij8s1wCglQV4
	 9vgx8+yHxEk2+VLCs5cgT5IYk3GhA6ci0ezuKIOUpEzUpE+skYvIaqOmuXr3ypnnUn
	 n58VZNGX97+59IlwUSj5TonA5d0jTtWG2xDRA3dysBuYNy7PzpxWEdb0gBoG60+8R7
	 mUkQb1FfCcFa8FV4E/I9e6TVTGpjWYpj0SRveBKPqwdkfkja7BJItoB51Ae1PP0Cjl
	 Al12d+wQu0OpQ==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-58dd3528497so3060544eaf.3
        for <cgroups@vger.kernel.org>; Mon, 11 Dec 2023 17:07:07 -0800 (PST)
X-Gm-Message-State: AOJu0Yx2CY3tOAeVkbyhL8008iK9ZmSWXApoMCddS+oNyKCEXSod9YJs
	ZBPujmQZeNgZ+rSJh3a5b51gYav4XuB1LKNf6SZ1HA==
X-Google-Smtp-Source: AGHT+IFnU6Zg6gtbcKGpVVyMUgGn/eZhHtC+eRX3XCuRhFv0V1qwZo+7UWlo2LwQsjS0Um0ppKxvMMc5FhFchTfzT50=
X-Received: by 2002:a05:6358:d598:b0:170:2abc:6e34 with SMTP id
 ms24-20020a056358d59800b001702abc6e34mr5702692rwb.19.1702343226888; Mon, 11
 Dec 2023 17:07:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211140419.1298178-1-schatzberg.dan@gmail.com> <20231211140419.1298178-2-schatzberg.dan@gmail.com>
In-Reply-To: <20231211140419.1298178-2-schatzberg.dan@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 11 Dec 2023 17:06:54 -0800
X-Gmail-Original-Message-ID: <CAF8kJuOhwjZZWab1poi1rPiV4u8O1CEZSO0cO23+aewt6S74-g@mail.gmail.com>
Message-ID: <CAF8kJuOhwjZZWab1poi1rPiV4u8O1CEZSO0cO23+aewt6S74-g@mail.gmail.com>
Subject: Re: [PATCH V3 1/1] mm: add swapiness= arg to memory.reclaim
To: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Jonathan Corbet <corbet@lwn.net>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, 
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Yue Zhao <findns94@gmail.com>, 
	Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,

Thank you for the patch.

On Mon, Dec 11, 2023 at 6:04=E2=80=AFAM Dan Schatzberg <schatzberg.dan@gmai=
l.com> wrote:
>
> Allow proactive reclaimers to submit an additional swappiness=3D<val>
> argument to memory.reclaim. This overrides the global or per-memcg
> swappiness setting for that reclaim attempt.

I am curious what prompted you to develop this patch. I understand
what this patch does, just want to know more of your background story
why this is needed.

>
> For example:
>
> echo "2M swappiness=3D0" > /sys/fs/cgroup/memory.reclaim
>
> will perform reclaim on the rootcg with a swappiness setting of 0 (no
> swap) regardless of the vm.swappiness sysctl setting.
>
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 15 ++++++-
>  include/linux/swap.h                    |  3 +-
>  mm/memcontrol.c                         | 55 ++++++++++++++++++++-----
>  mm/vmscan.c                             | 13 +++++-
>  4 files changed, 70 insertions(+), 16 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index 3f85254f3cef..fc2b379dbd0f 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1282,8 +1282,8 @@ PAGE_SIZE multiple when read back.
>         This is a simple interface to trigger memory reclaim in the
>         target cgroup.
>
> -       This file accepts a single key, the number of bytes to reclaim.
> -       No nested keys are currently supported.
> +       This file accepts a string which containers thhe number of bytes
Just as Yosry points out, there is some typo here.

"contains the"

> +       to reclaim.
>
>         Example::
>
> @@ -1304,6 +1304,17 @@ PAGE_SIZE multiple when read back.
>         This means that the networking layer will not adapt based on
>         reclaim induced by memory.reclaim.
>
> +       This file also allows the user to specify the swappiness value
> +       to be used for the reclaim. For example:
> +
> +         echo "1G swappiness=3D60" > memory.reclaim
> +
> +       The above instructs the kernel to perform the reclaim with
> +       a swappiness value of 60. Note that this has the same semantics
> +       as the vm.swappiness sysctl - it sets the relative IO cost of
> +       reclaiming anon vs file memory but does not allow for reclaiming
> +       specific amounts of anon or file memory.
> +
>    memory.peak
>         A read-only single value file which exists on non-root
>         cgroups.
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index f6dd6575b905..ebc20d094609 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -410,7 +410,8 @@ extern unsigned long try_to_free_pages(struct zonelis=
t *zonelist, int order,
>  extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *mem=
cg,
>                                                   unsigned long nr_pages,
>                                                   gfp_t gfp_mask,
> -                                                 unsigned int reclaim_op=
tions);
> +                                                 unsigned int reclaim_op=
tions,
> +                                                 int swappiness);
>  extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
>                                                 gfp_t gfp_mask, bool nosw=
ap,
>                                                 pg_data_t *pgdat,
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 1c1061df9cd1..74598c17d3cc 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -63,6 +63,7 @@
>  #include <linux/resume_user_mode.h>
>  #include <linux/psi.h>
>  #include <linux/seq_buf.h>
> +#include <linux/parser.h>
>  #include <linux/sched/isolation.h>
>  #include "internal.h"
>  #include <net/sock.h>
> @@ -2449,7 +2450,7 @@ static unsigned long reclaim_high(struct mem_cgroup=
 *memcg,
>                 psi_memstall_enter(&pflags);
>                 nr_reclaimed +=3D try_to_free_mem_cgroup_pages(memcg, nr_=
pages,
>                                                         gfp_mask,
> -                                                       MEMCG_RECLAIM_MAY=
_SWAP);
> +                                                       MEMCG_RECLAIM_MAY=
_SWAP, -1);

Instead of passing -1, maybe we can use mem_cgroup_swappiness(memcg);

And maybe remove the -1 test from the get_scan_count().

""
static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
   unsigned long *nr)
{
struct pglist_data *pgdat =3D lruvec_pgdat(lruvec);
struct mem_cgroup *memcg =3D lruvec_memcg(lruvec);
unsigned long anon_cost, file_cost, total_cost;
int swappiness =3D sc->swappiness !=3D -1 ?
sc->swappiness : mem_cgroup_swappiness(memcg);
""

In other words, I feel it is cleaner if try_to_free_mem_cgroup_pages
accept the swappiness as it is. There is no second guessing the value
if it is -1, then the internal function gets the swappiness from
mem_cgroup_swappiness().
Maybe we can completely remove the -1 special default value?

>                 psi_memstall_leave(&pflags);
>         } while ((memcg =3D parent_mem_cgroup(memcg)) &&
>                  !mem_cgroup_is_root(memcg));
> @@ -2740,7 +2741,7 @@ static int try_charge_memcg(struct mem_cgroup *memc=
g, gfp_t gfp_mask,
>
>         psi_memstall_enter(&pflags);
>         nr_reclaimed =3D try_to_free_mem_cgroup_pages(mem_over_limit, nr_=
pages,
> -                                                   gfp_mask, reclaim_opt=
ions);
> +                                                   gfp_mask, reclaim_opt=
ions, -1);

Same here.

>         psi_memstall_leave(&pflags);
>
>         if (mem_cgroup_margin(mem_over_limit) >=3D nr_pages)
> @@ -3660,7 +3661,7 @@ static int mem_cgroup_resize_max(struct mem_cgroup =
*memcg,
>                 }
>
>                 if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
> -                                       memsw ? 0 : MEMCG_RECLAIM_MAY_SWA=
P)) {
> +                                       memsw ? 0 : MEMCG_RECLAIM_MAY_SWA=
P, -1)) {

Same here.

>                         ret =3D -EBUSY;
>                         break;
>                 }
> @@ -3774,7 +3775,7 @@ static int mem_cgroup_force_empty(struct mem_cgroup=
 *memcg)
>                         return -EINTR;
>
>                 if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
> -                                                 MEMCG_RECLAIM_MAY_SWAP)=
)
> +                                                 MEMCG_RECLAIM_MAY_SWAP,=
 -1))

Here too.

>                         nr_retries--;
>         }
>
> @@ -6720,7 +6721,7 @@ static ssize_t memory_high_write(struct kernfs_open=
_file *of,
>                 }
>
>                 reclaimed =3D try_to_free_mem_cgroup_pages(memcg, nr_page=
s - high,
> -                                       GFP_KERNEL, MEMCG_RECLAIM_MAY_SWA=
P);
> +                                       GFP_KERNEL, MEMCG_RECLAIM_MAY_SWA=
P, -1);

Here too.

>
>                 if (!reclaimed && !nr_retries--)
>                         break;
> @@ -6769,7 +6770,7 @@ static ssize_t memory_max_write(struct kernfs_open_=
file *of,
>
>                 if (nr_reclaims) {
>                         if (!try_to_free_mem_cgroup_pages(memcg, nr_pages=
 - max,
> -                                       GFP_KERNEL, MEMCG_RECLAIM_MAY_SWA=
P))
> +                                       GFP_KERNEL, MEMCG_RECLAIM_MAY_SWA=
P, -1))

Here too.

>                                 nr_reclaims--;
>                         continue;
>                 }
> @@ -6895,6 +6896,16 @@ static ssize_t memory_oom_group_write(struct kernf=
s_open_file *of,
>         return nbytes;
>  }
>
> +enum {
> +       MEMORY_RECLAIM_SWAPPINESS =3D 0,
> +       MEMORY_RECLAIM_NULL,
> +};
> +
> +static const match_table_t if_tokens =3D {

What this is called "if_tokens"? I am trying to figure out what "if" refers=
 to.

> +       { MEMORY_RECLAIM_SWAPPINESS, "swappiness=3D%d"},
> +       { MEMORY_RECLAIM_NULL, NULL },
> +};
> +

Do we foresee a lot of tunable for the try to free page? I see. You
want to use match_token() to do the keyword parsing.

>  static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
>                               size_t nbytes, loff_t off)
>  {
> @@ -6902,12 +6913,33 @@ static ssize_t memory_reclaim(struct kernfs_open_=
file *of, char *buf,
>         unsigned int nr_retries =3D MAX_RECLAIM_RETRIES;
>         unsigned long nr_to_reclaim, nr_reclaimed =3D 0;
>         unsigned int reclaim_options;
> -       int err;
> +       char *old_buf, *start;
> +       substring_t args[MAX_OPT_ARGS];
> +       int swappiness =3D -1;
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
> +               switch (match_token(start, if_tokens, args)) {
> +               case MEMORY_RECLAIM_SWAPPINESS:
> +                       if (match_int(&args[0], &swappiness))
> +                               return -EINVAL;
> +                       if (swappiness < 0 || swappiness > 200)

Agree with Yosry on the 200 magic value.

I am also wondering if there is an easier way to just parse one
keyword. Will using strcmp("swappiness=3D") be a bad idea? I haven't
tried it myself though.

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
> @@ -6926,7 +6958,8 @@ static ssize_t memory_reclaim(struct kernfs_open_fi=
le *of, char *buf,
>
>                 reclaimed =3D try_to_free_mem_cgroup_pages(memcg,
>                                         min(nr_to_reclaim - nr_reclaimed,=
 SWAP_CLUSTER_MAX),
> -                                       GFP_KERNEL, reclaim_options);
> +                                       GFP_KERNEL, reclaim_options,
> +                                       swappiness);
>
>                 if (!reclaimed && !nr_retries--)
>                         return -EAGAIN;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 506f8220c5fe..a20965b20177 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -136,6 +136,9 @@ struct scan_control {
>         /* Always discard instead of demoting to lower tier memory */
>         unsigned int no_demotion:1;
>
> +       /* Swappiness value for reclaim, if -1 use memcg/global value */
> +       int swappiness;
> +

It would be great if we can get rid of the -1 case.

>         /* Allocation order */
>         s8 order;
>
> @@ -2327,7 +2330,8 @@ static void get_scan_count(struct lruvec *lruvec, s=
truct scan_control *sc,
>         struct pglist_data *pgdat =3D lruvec_pgdat(lruvec);
>         struct mem_cgroup *memcg =3D lruvec_memcg(lruvec);
>         unsigned long anon_cost, file_cost, total_cost;
> -       int swappiness =3D mem_cgroup_swappiness(memcg);
> +       int swappiness =3D sc->swappiness !=3D -1 ?
> +               sc->swappiness : mem_cgroup_swappiness(memcg);

Let's see if we can get rid of the -1. Now I see the -1 is actually
introduced by this patch, should be doable.

>         u64 fraction[ANON_AND_FILE];
>         u64 denominator =3D 0;    /* gcc */
>         enum scan_balance scan_balance;
> @@ -2608,6 +2612,9 @@ static int get_swappiness(struct lruvec *lruvec, st=
ruct scan_control *sc)
>             mem_cgroup_get_nr_swap_pages(memcg) < MIN_LRU_BATCH)
>                 return 0;
>
> +       if (sc->swappiness !=3D -1)
> +               return sc->swappiness;
> +

Get rid of that too.

Thank you.

Chris


>         return mem_cgroup_swappiness(memcg);
>  }
>
> @@ -6433,7 +6440,8 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgr=
oup *memcg,
>  unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>                                            unsigned long nr_pages,
>                                            gfp_t gfp_mask,
> -                                          unsigned int reclaim_options)
> +                                          unsigned int reclaim_options,
> +                                          int swappiness)
>  {
>         unsigned long nr_reclaimed;
>         unsigned int noreclaim_flag;
> @@ -6448,6 +6456,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct m=
em_cgroup *memcg,
>                 .may_unmap =3D 1,
>                 .may_swap =3D !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP=
),
>                 .proactive =3D !!(reclaim_options & MEMCG_RECLAIM_PROACTI=
VE),
> +               .swappiness =3D swappiness,
>         };
>         /*
>          * Traverse the ZONELIST_FALLBACK zonelist of the current node to=
 put
> --
> 2.34.1
>
>

