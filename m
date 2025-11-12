Return-Path: <cgroups+bounces-11869-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0A5C5314D
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 16:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E2A095422BC
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 14:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980C433B6E0;
	Wed, 12 Nov 2025 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdhQNqJp"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5730433859B
	for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958675; cv=none; b=ZDlcQzqAqhIDJNdbI0TJB8noJUBimydSqj/IfBXCYB37S53/x8n2YGR3WOEGHb3kSK05/Re4jybdfHirCD692hjghv+X5gsxslH+ta14/vWfT7uMqBTV2LLIB6t58jHyyvTmPcRBW6VkUb/ASJ8IHT4AtJWqBQnixkHZOkt1ndc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958675; c=relaxed/simple;
	bh=PDnwftZCtKItMvQXS6vPJzVdQydGaJntJOyOabcBAHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftYleQ1xdX8B20ATUsW7sTRFwbu9qDDo1jM3+pkC1KPEsNKRhmQW7OI10LRAp44fe0nQ1pqPwzbf9Oxl0SXmWmMYgitbbiukz+FXdxtS1PbYYAdE+eUIvpyxq9TC484qeme3+P+6BQiaqMDU0UOmhmIepa6o+wN/QnqyYDZNsM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdhQNqJp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A2FC113D0
	for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 14:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762958674;
	bh=PDnwftZCtKItMvQXS6vPJzVdQydGaJntJOyOabcBAHo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UdhQNqJpzGM12bAJBrl1zL1HiOVmK9VOBoGKSOzPa7Z6D9DuGeTKQ5C4EWa6DNhSU
	 IllmkZ09BdR27zC76WST7GKpHcab9cK1FSzs8nL5eN41i2tPsNEVa9Ys6gwQ6t8tZM
	 f1YNvwTxqLkxzrRL7RUFKSWXaJ1i4raM38wWQvIjUorcGlU21zkIQjZdVHTZVxbHmr
	 4eRqI74xye27+4EswEuZEgDtA/q5i0AYma870hgnLJhNag2aTmU+Uvf8ziblqI6H+9
	 IxOY/zUUvahsbiMhEUUhGXT4ZX/JfPIioW8G6NiteSlR5ah/sS6BCHonIJwgfhA9rR
	 nS/00zeHmHhAg==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d71bcab6fso8756497b3.0
        for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 06:44:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUiOecCfvQIylLDTjN8Qg77kSrE/YuEEDjt1DFDSHPHNUhZbb95BgpjgsjeUiD5ZXpEwuEbXVIv@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg/6kHpTYT9pHan6KWPPuwa4D0A7EGfyj+AytSoIYOGcbiBEPW
	K0TEIUQzEgtBMvqA2qbwVQYQlBFwK0/vcCbv4tepM5vjEvjiDJptdbuWU8cuQzIIG2BfwPgJStB
	g9ON+I4pL0gfOZ/cW5FJUdkM2+LYu42BLm8hfnXnUyg==
X-Google-Smtp-Source: AGHT+IG5JeTs0/2jzgHnGQg6hAHz8vnJj97AKy982sF7acTacZdbTAFqicgdDUf8Z5OFDVpjMi1dXerlN4/1YJlDLLQ=
X-Received: by 2002:a05:690c:6805:b0:786:9be4:749c with SMTP id
 00721157ae682-78813666b4fmr29760027b3.31.1762958674170; Wed, 12 Nov 2025
 06:44:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109124947.1101520-1-youngjun.park@lge.com> <20251109124947.1101520-4-youngjun.park@lge.com>
In-Reply-To: <20251109124947.1101520-4-youngjun.park@lge.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 12 Nov 2025 06:44:23 -0800
X-Gmail-Original-Message-ID: <CACePvbU+NviPmpXQAJUrY4rTqmY_rvYy2JvDBAfT290GmQmfZg@mail.gmail.com>
X-Gm-Features: AWmQ_bn2uFL5WDija3FNTBnu9eTA0Dq7KEi83tdS-oW7tHAdZkh7qgGbpcQOn8o
Message-ID: <CACePvbU+NviPmpXQAJUrY4rTqmY_rvYy2JvDBAfT290GmQmfZg@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm/swap: integrate swap tier infrastructure into swap subsystem
To: Youngjun Park <youngjun.park@lge.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kasong@tencent.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	bhe@redhat.com, baohua@kernel.org, gunho.lee@lge.com, taejoon.song@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It seems you should introduce the tiers first. Allow users to define tiers.
Then the follow up patches use tiers defined here.

The patch order seems reversed to me.

See some feedback below, to be continued.

Chhris


On Sun, Nov 9, 2025 at 4:50=E2=80=AFAM Youngjun Park <youngjun.park@lge.com=
> wrote:
>
> Integrate the swap tier infrastructure into the existing swap subsystem
> to enable selective swap device usage based on tier configuration.
>
> Signed-off-by: Youngjun Park <youngjun.park@lge.com>
> ---
>  mm/memcontrol.c | 69 ++++++++++++++++++++++++++++++++++++
>  mm/page_io.c    | 21 ++++++++++-
>  mm/swap_state.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++++
>  mm/swapfile.c   | 15 ++++++--
>  4 files changed, 194 insertions(+), 4 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index bfc986da3289..33c7cc069754 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -68,6 +68,7 @@
>  #include <net/ip.h>
>  #include "slab.h"
>  #include "memcontrol-v1.h"
> +#include "swap_tier.h"
>
>  #include <linux/uaccess.h>
>
> @@ -3730,6 +3731,7 @@ static void mem_cgroup_free(struct mem_cgroup *memc=
g)
>  {
>         lru_gen_exit_memcg(memcg);
>         memcg_wb_domain_exit(memcg);
> +       swap_tiers_put_mask(memcg);
>         __mem_cgroup_free(memcg);
>  }
>
> @@ -3842,6 +3844,11 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *p=
arent_css)
>                 page_counter_init(&memcg->kmem, &parent->kmem, false);
>                 page_counter_init(&memcg->tcpmem, &parent->tcpmem, false)=
;
>  #endif
> +#ifdef CONFIG_SWAP_TIER
> +               memcg->tiers_mask =3D 0;
> +               memcg->tiers_onoff =3D 0;
> +#endif
> +
>         } else {
>                 init_memcg_stats();
>                 init_memcg_events();
> @@ -3850,6 +3857,10 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *p=
arent_css)
>  #ifdef CONFIG_MEMCG_V1
>                 page_counter_init(&memcg->kmem, NULL, false);
>                 page_counter_init(&memcg->tcpmem, NULL, false);
> +#endif
> +#ifdef CONFIG_SWAP_TIER
Again, don't need this config.

> +               memcg->tiers_mask =3D DEFAULT_FULL_MASK;

Is this  memcg->tiers_mask a cached value after evaluating the
swap.tiers onoff list by looking up the parent?

I was thinking of starting with always evaluating the tiers_mask. Then
we don't need to store it here. How do you indicate the tiers_mask is
out of date?

> +               memcg->tiers_onoff =3D DEFAULT_ON_MASK;
>  #endif
>                 root_mem_cgroup =3D memcg;
>                 return &memcg->css;
> @@ -5390,6 +5401,56 @@ static int swap_events_show(struct seq_file *m, vo=
id *v)
>         return 0;
>  }
>
> +#ifdef CONFIG_SWAP_TIER
> +static int swap_tier_show(struct seq_file *m, void *v)
> +{
> +       struct mem_cgroup *memcg =3D mem_cgroup_from_seq(m);
> +
> +       swap_tiers_show_memcg(m, memcg);
> +       return 0;
> +}
> +
> +static ssize_t swap_tier_write(struct kernfs_open_file *of,
> +                               char *buf, size_t nbytes, loff_t off)
> +{
> +       struct mem_cgroup *memcg =3D mem_cgroup_from_css(of_css(of));
> +       struct tiers_desc desc[MAX_SWAPTIER] =3D {};
> +       char *pos =3D buf, *token;
> +       int nr =3D 0;
> +       int ret;
> +
> +       while ((token =3D strsep(&pos, " \t\n")) !=3D NULL) {

Not allowing plain space " "? Compare pointer !=3D NULL is redundant.

> +               if (!*token)
> +                       continue;
> +
> +               if (nr >=3D MAX_SWAPTIER)
> +                       return -E2BIG;
> +
> +               if (token[0] !=3D '+' && token[0] !=3D '-')
> +                       return -EINVAL;
> +
> +               desc[nr].ops =3D (token[0] =3D=3D '+') ? TIER_ON_MASK : T=
IER_OFF_MASK;
> +
> +               if (strlen(token) <=3D 1) {
> +                       strscpy(desc[nr].name, DEFAULT_TIER_NAME);
> +                       nr++;
> +                       continue;
> +               }
> +
> +               if (strscpy(desc[nr].name, token + 1, MAX_TIERNAME) < 0)
> +                       return -EINVAL;
> +
> +               nr++;
I don't think you need this nr, you will reach to the end of the
string any way. What if the user specifies the same tier more than
once? It is not optimal but the kernel should take it.

OK, I see what is going on now, this whole desc thing can be greatly
simplified. You shouldn't need to maintain the desc[nr], that desc
array is the onoff mask in my mind. You just need to keep the tier
bits in order.

Notice in the memory.swap.tiers. Except for the default tier pattern,
which always the first one if exists. The rest of the tier + - order
does not matter. You look up the tier name into the tier mask bit.
Just set the onoff bits for that tier.

> +       }
> +
> +       ret =3D swap_tiers_get_mask(desc, nr, memcg);
> +       if (ret)
> +               return ret;
> +
> +       return nbytes;
> +}
> +#endif
> +
>  static struct cftype swap_files[] =3D {
>         {
>                 .name =3D "swap.current",
> @@ -5422,6 +5483,14 @@ static struct cftype swap_files[] =3D {
>                 .file_offset =3D offsetof(struct mem_cgroup, swap_events_=
file),
>                 .seq_show =3D swap_events_show,
>         },
> +#ifdef CONFIG_SWAP_TIER
> +       {
> +               .name =3D "swap.tiers",
> +               .flags =3D CFTYPE_NOT_ON_ROOT,
> +               .seq_show =3D swap_tier_show,
> +               .write =3D swap_tier_write,
> +       },
> +#endif
>         { }     /* terminate */
>  };
>
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 3c342db77ce3..2b3b1154a169 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -26,6 +26,7 @@
>  #include <linux/delayacct.h>
>  #include <linux/zswap.h>
>  #include "swap.h"
> +#include "swap_tier.h"
>
>  static void __end_swap_bio_write(struct bio *bio)
>  {
> @@ -233,6 +234,24 @@ static void swap_zeromap_folio_clear(struct folio *f=
olio)
>         }
>  }
>
> +#if defined(CONFIG_SWAP_TIER) && defined(CONFIG_ZSWAP)
> +static bool folio_swap_tier_zswap_test_off(struct folio *folio)
> +{
> +       struct mem_cgroup *memcg;
> +
> +       memcg =3D folio_memcg(folio);
> +       if (memcg)
> +               return swap_tier_test_off(memcg->tiers_mask,
> +                       TIER_MASK(SWAP_TIER_ZSWAP, TIER_ON_MASK));
> +
> +       return false;
> +}
> +#else
> +static bool folio_swap_tier_zswap_test_off(struct folio *folio)
> +{
> +       return false;
> +}
> +#endif
>  /*
>   * We may have stale swap cache pages in memory: notice
>   * them here and get rid of the unnecessary final write.
> @@ -272,7 +291,7 @@ int swap_writeout(struct folio *folio, struct swap_io=
cb **swap_plug)
>          */
>         swap_zeromap_folio_clear(folio);
>
> -       if (zswap_store(folio)) {
> +       if (folio_swap_tier_zswap_test_off(folio) || zswap_store(folio)) =
{
>                 count_mthp_stat(folio_order(folio), MTHP_STAT_ZSWPOUT);
>                 goto out_unlock;
>         }
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 3f85a1c4cfd9..2e5f65ff2479 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -25,6 +25,7 @@
>  #include "internal.h"
>  #include "swap_table.h"
>  #include "swap.h"
> +#include "swap_tier.h"
>
>  /*
>   * swapper_space is a fiction, retained to simplify the path through
> @@ -836,8 +837,100 @@ static ssize_t vma_ra_enabled_store(struct kobject =
*kobj,
>  }
>  static struct kobj_attribute vma_ra_enabled_attr =3D __ATTR_RW(vma_ra_en=
abled);
>
> +#ifdef CONFIG_SWAP_TIER
> +static ssize_t tiers_show(struct kobject *kobj,
> +                                    struct kobj_attribute *attr, char *b=
uf)
> +{
> +       return swap_tiers_show_sysfs(buf);
> +}
> +
> +static ssize_t tiers_store(struct kobject *kobj,
> +                               struct kobj_attribute *attr,
> +                               const char *buf, size_t count)
> +{
> +       struct tiers_desc desc[MAX_SWAPTIER] =3D {};
> +       int nr =3D 0;
> +       char *data, *p, *token;
> +       int ret =3D 0;
> +       bool is_add =3D true;
> +
> +       if (!count)
> +               return -EINVAL;
> +
> +       data =3D kmemdup_nul(buf, count, GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       p =3D data;
> +
> +       if (*p =3D=3D '+')
> +               p++;
> +       else if (*p =3D=3D '-') {
> +               is_add =3D false;
> +               p++;
> +       } else
> +               return -EINVAL;
> +
> +       while ((token =3D strsep(&p, ", \t\n")) !=3D NULL) {
> +               if (!*token)
> +                       continue;
> +
> +               if (nr >=3D MAX_SWAPTIER) {
> +                       ret =3D -E2BIG;
> +                       goto out;
> +               }
> +
> +               if (is_add) {
> +                       char *name, *prio_str;
> +                       int prio;
> +
> +                       name =3D strsep(&token, ":");
> +                       prio_str =3D token;
> +
> +                       if (!name || !prio_str || !*name || !*prio_str) {
> +                               ret =3D -EINVAL;
> +                               goto out;
> +                       }
> +
> +                       if (strscpy(desc[nr].name, name, MAX_TIERNAME) < =
0) {
> +                               ret =3D -EINVAL;
> +                               goto out;
> +                       }
> +
> +                       if (kstrtoint(prio_str, 10, &prio)) {
> +                               ret =3D -EINVAL;
> +                               goto out;
> +                       }
> +
> +                       desc[nr].prio_st =3D prio;
> +               } else {
> +                       if (strscpy(desc[nr].name, token, MAX_TIERNAME) <=
 0) {
> +                               ret =3D -EINVAL;
> +                               goto out;
> +                       }
> +                       desc[nr].prio_st =3D 0;
> +               }
> +               nr++;
> +       }
> +
> +       if (is_add)
> +               ret =3D swap_tiers_add(desc, nr);
> +       else
> +               ret =3D swap_tiers_remove(desc, nr);
> +
> +out:
> +       kfree(data);
> +       return ret ? ret : count;
> +}
> +
> +static struct kobj_attribute tier_attr =3D __ATTR_RW(tiers);
> +#endif
> +
>  static struct attribute *swap_attrs[] =3D {
>         &vma_ra_enabled_attr.attr,
> +#ifdef CONFIG_SWAP_TIER
> +       &tier_attr.attr,
> +#endif
>         NULL,
>  };
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index a5c90e419ff3..8715a2d94140 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -49,6 +49,7 @@
>  #include "swap_table.h"
>  #include "internal.h"
>  #include "swap.h"
> +#include "swap_tier.h"
>
>  static bool swap_count_continued(struct swap_info_struct *, pgoff_t,
>                                  unsigned char);
> @@ -1296,7 +1297,8 @@ static bool get_swap_device_info(struct swap_info_s=
truct *si)
>
>  /* Rotate the device and switch to a new cluster */
>  static void swap_alloc_entry(swp_entry_t *entry,
> -                           int order)
> +                           int order,
> +                           int mask)
>  {
>         unsigned long offset;
>         struct swap_info_struct *si, *next;
> @@ -1304,6 +1306,8 @@ static void swap_alloc_entry(swp_entry_t *entry,
>         spin_lock(&swap_avail_lock);
>  start_over:
>         plist_for_each_entry_safe(si, next, &swap_avail_head, avail_list)=
 {
> +               if (swap_tiers_test_off(si->tier_idx, mask))
> +                       continue;
>                 /* Rotate the device and switch to a new cluster */
>                 plist_requeue(&si->avail_list, &swap_avail_head);
>                 spin_unlock(&swap_avail_lock);
> @@ -1376,6 +1380,7 @@ int folio_alloc_swap(struct folio *folio)
>  {
>         unsigned int order =3D folio_order(folio);
>         unsigned int size =3D 1 << order;
> +       int mask;
>         swp_entry_t entry =3D {};
>
>         VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> @@ -1400,8 +1405,8 @@ int folio_alloc_swap(struct folio *folio)
>         }
>
>  again:
> -       swap_alloc_entry(&entry, order);
> -
> +       mask =3D swap_tiers_collect_compare_mask(folio_memcg(folio));
> +       swap_alloc_entry(&entry, order, mask);
>         if (unlikely(!order && !entry.val)) {
>                 if (swap_sync_discard())
>                         goto again;
> @@ -2673,6 +2678,8 @@ static void _enable_swap_info(struct swap_info_stru=
ct *si)
>
>         /* Add back to available list */
>         add_to_avail_list(si, true);
> +
> +       swap_tiers_assign(si);
>  }
>
>  static void enable_swap_info(struct swap_info_struct *si, int prio,
> @@ -2840,6 +2847,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, speci=
alfile)
>         spin_lock(&swap_lock);
>         spin_lock(&p->lock);
>         drain_mmlist();
> +       swap_tiers_release(p);
>
>         swap_file =3D p->swap_file;
>         p->swap_file =3D NULL;
> @@ -4004,6 +4012,7 @@ static int __init swapfile_init(void)
>                 swap_migration_ad_supported =3D true;
>  #endif /* CONFIG_MIGRATION */
>
> +       swap_tiers_init();
>         return 0;
>  }
>  subsys_initcall(swapfile_init);
> --
> 2.34.1
>
>

