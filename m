Return-Path: <cgroups+bounces-15890-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCzzFE1mBGqXIAIAu9opvQ
	(envelope-from <cgroups+bounces-15890-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 13:53:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B82F353297D
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 13:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62DD1312C378
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 11:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAB03A16BE;
	Wed, 13 May 2026 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="En9FgXxq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DD83A63FE
	for <cgroups@vger.kernel.org>; Wed, 13 May 2026 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778673001; cv=pass; b=mhNy0GD1T1boLU8dIwA8B7iZ6+HEH5QmJ6Z74lSS/CPvGw14iabOYXl/zFzE7dVupBK7iaDa312lX2xytHis2KTmM49IRfGDr3ndhn+ZZe1WGwfigwwWcuO91mKsuF22wiIn2DRplk+k9AR2MMjN20bjTNfoysAOpveh8dc4zQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778673001; c=relaxed/simple;
	bh=/fEljrTCweX4VkWoYt2Q6DiehSFHwK+6LZzn2oOIyCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CoorcfY5KHHvrTbtXrdnojRGJrvgkhy47Lr8Wt13HhzGVd4x5J3iIc078jmeaQHYhYXhAcfLczaKgvpqNC7j2PO6Z/CfHY4pf8QW0gJ37IMjlQ7IBGwWuwknXw1jBu1saPvZjKVaOXYaK9qjio9SDMgDieB7yWxNYJNMKverGkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=En9FgXxq; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6763cc8775cso13495442a12.0
        for <cgroups@vger.kernel.org>; Wed, 13 May 2026 04:49:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778672998; cv=none;
        d=google.com; s=arc-20240605;
        b=YIKahdJ4edeDhNO5FSBttChseVNpqIJj6TcIrRMJfnfBlq2nlOtjTFdezRWgLR96Yc
         yD3b+iJJdO+7mXDrV7SVoC8DWXAXcvWN1YFxcrm+Djk5/D5dljZ1m2bRWggj6xnB6LPb
         dzshPxiYFD3c3FKKZCxtFrx1cbL0Aeb2hDY1W398/cSvGPqU7tiOeL0f4yiCf6I7U7QY
         vAiJWKx7MIAW3D9hMHciFlgj8eUj4ZrlpX3NjAu1Gg1G41kpa7FSw/oPaV40KvKv8Ykx
         ta/Ohb1ZNl4wbq/Y2toyXO9yFK1HnHXfcP42QSkURnemv9J/HT0Og2wZUVVSz+MvLgzo
         8c6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H+eyCRfvbu7d8VrqUkRV2z/MHJa96tgDU4sif/IM1p4=;
        fh=YYCMjnFBYdISE1vw1I1fdOGzmD4pHaUTcpPRm71mUHk=;
        b=jPSkwM/gRF/N6qJ1HlJWadfPw/iS7VOhueKYdtOfOWSyAWf/5B9H/GDFU7FOPwvlyw
         I7l9vqxIeszs/5u+MgGc1c9zRNIaehNMsSU0tauR0Zz4kSXt0oi9+WuTH8VW49uJkd4H
         m3tFgpMVbWm3R2JIAm7PbtBjCGuNv1tOlDNA1MbTRp26wxVeyYEPYFwja53V8zgECsor
         IK41cxdZADQng+wRkb0vSJ7Kv6Tby36NdPThyTI0dKs+WGFmo/VF4F/KLtqBwis9Ds5G
         YB/SwCzoFT5Eu1homoyAWFuQxusoOhnB4iAyujTcRYHUgRES123tTKIOJPp/kwA7c9nC
         9QvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778672998; x=1779277798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+eyCRfvbu7d8VrqUkRV2z/MHJa96tgDU4sif/IM1p4=;
        b=En9FgXxqBdB5tn3fyypfhGTnpLF8/7VkkusltG3BXXc/dbrE8RXUA7vImuGpwbdlS4
         2+xHnQi2SFl/ALkgsm6N6QmivPBmbn4v5TE/UAjegTCfmdNFFDo7yGbdpQwWHEkf21/x
         pTShVHQuL3T71tdll/5j/4pl6g1XBdF8ZeWP/aVc21CF9K4DgVpnkmnp6SyPDjKZgR/8
         oL6ZpkrE7m5OJjmsAbyv0Tk1F7HqomDJi5kgMF38yTF8kxuAOO0Fcz0GYSOFyzL36Sb3
         LP6wBokD1IfmJRmeAmAfRdw46dgTWUFpItKgZ+wk26jq2Hymfnd4iK0sdf7QZSIgu19A
         lXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778672998; x=1779277798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H+eyCRfvbu7d8VrqUkRV2z/MHJa96tgDU4sif/IM1p4=;
        b=RtFwEIKfdlq2CzboQy//bpgi35FnW4CZ4klowwhY+h1zRtVG4Kzgr2SwX3hdOgo01w
         80QTjlirG/PkWxJPS+8LPRCu+vQra6g5U5TB3EVjme79RQmxHfSJB4dbNp1Ml+kfrjf+
         V6mgOATv/2Qrc4mcNZUIonEHGvJ1pdoj36LeorcSfgtjUpDq1mNjaXxFqfoWFNPgGtbj
         V2eSK1PZfaXyLXpwyc68F7NaeHQPBGYnD95w4g23XAzwJMLtu2CZgjOAXUi2huZ5rtZI
         W8BGxbFHAHvDu/hF/wCE0LU4privYp8+gEiuaj9ljLKduzMk02sL8bGthYd1My0hBZWZ
         afuQ==
X-Forwarded-Encrypted: i=1; AFNElJ9EfhxzDA51NU4htYqmN8uQVbgGLm7W8Cic34qqb4PXPKSjfJ2GJ2VhSJ40xG5Yc272soS9tJCk@vger.kernel.org
X-Gm-Message-State: AOJu0YwnjVLzbQjIST0RZ7Ow9yWc1soX6NJBTFHGc4SLUwzbsxJLIPK4
	OuUKrfKIbnP+RQr35g6rCo5lnLb0vYAnoZ9S7nTdOEwAP67KWN6Gzt/yJaBtwNhaINjba/Sz9uD
	xlb662WIZhyhqjXjf4KN2HLnLDA7138Q=
X-Gm-Gg: Acq92OESapPk47gxZFUWKiw0mZo8DY/2UNq6n5vno3Q13jX01G+oPaoH2JbCBh99T/2
	e7kDLtadJOX0p16wI3XA40qrwnQanbwprMghvn1Pduk8KG1wTCLpdm++l0WtQtgpgOJWhCycCkP
	2MAkazFUZ2+TzeYAg9uK+Zno46zWfMPpiA2Szq7C1VW06AaXolq8ng4wodJ5I9IJJ0Pto/zNkKl
	2gLos05qhAjWeeLLCSUmIbme4newVZ8dvIxKN7gmL0ENeqTBCr+v5y4Ca4lP2ZBqjysExj5Y5C9
	b3evyoehYhCgKsUIH1Vi87hPXsN/rKsBKMXN/9c=
X-Received: by 2002:a05:6402:7d0:b0:67b:7e7a:45ed with SMTP id
 4fb4d7f45d1cf-680b2b12646mr3489347a12.6.1778672997859; Wed, 13 May 2026
 04:49:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com>
 <20260421-swap-table-p4-v3-10-2f23759a76bc@tencent.com> <CACePvbXeUv9g+pKW55hrEbwrFZaZ+XdBip9oSwT7pfztrG_7GA@mail.gmail.com>
In-Reply-To: <CACePvbXeUv9g+pKW55hrEbwrFZaZ+XdBip9oSwT7pfztrG_7GA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 13 May 2026 19:49:20 +0800
X-Gm-Features: AVHnY4Ks2BUbReMA9gs5ZJ-uwNtvfeaDihycWWUgwEm25NTeZvjq8Y_AbMswWzo
Message-ID: <CAMgjq7D_W5qQfNfjJ=j+YSfaQE_f=XEOY2TphOaBtmwnJZSrfQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/12] mm/memcg, swap: store cgroup id in cluster table directly
To: Chris Li <chrisl@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Youngjun Park <youngjun.park@lge.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Dev Jain <dev.jain@arm.com>, 
	Lance Yang <lance.yang@linux.dev>, Michal Hocko <mhocko@suse.com>, Michal Hocko <mhocko@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B82F353297D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15890-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,bytedance.com,vger.kernel.org,arm.com,suse.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,tencent.com:email]
X-Rspamd-Action: no action

On Sat, May 9, 2026 at 6:46=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> On Tue, Apr 21, 2026 at 2:16=E2=80=AFAM Kairui Song via B4 Relay
> <devnull+kasong.tencent.com@kernel.org> wrote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > Drop the usage of the swap_cgroup_ctrl, and use the dynamic cluster
> > table instead.
>
> Nice! It takes so many steps to finally drop the static allocated swap
> cgroup ctrl array. Thank you for making it happen.
>
> >
> > The per-cluster memcg table is 1024 / 512 bytes on most archs, and does
> > not need RCU protection: the cgroup data is only read and written under
> > the cluster lock. That keeps things simple, lets the allocation use
> > plain kmalloc with immediate kfree (no deferred free), and keeps
> > fragmentation acceptable.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
>
> Overall looks good, with some nitpick and question follows.
>
> Acked-by: Chris Li <chrisl@kernel.org>
>
> > ---
> >  include/linux/memcontrol.h |  6 ++++--
> >  include/linux/swap.h       |  8 +++----
> >  mm/memcontrol-v1.c         | 42 +++++++++++++++++++++++-------------
> >  mm/memcontrol.c            | 14 +++++++-----
> >  mm/swap.h                  |  4 ++++
> >  mm/swap_state.c            |  6 ++----
> >  mm/swap_table.h            | 54 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  mm/swapfile.c              | 35 +++++++++++++++++++-----------
> >  mm/vmscan.c                |  2 +-
> >  9 files changed, 128 insertions(+), 43 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index a013f37f24aa..bf1a6e131eca 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -29,6 +29,7 @@ struct obj_cgroup;
> >  struct page;
> >  struct mm_struct;
> >  struct kmem_cache;
> > +struct swap_cluster_info;
> >
> >  /* Cgroup-specific page state, on top of universal node page state */
> >  enum memcg_stat_item {
> > @@ -1899,7 +1900,7 @@ static inline void mem_cgroup_exit_user_fault(voi=
d)
> >         current->in_user_fault =3D 0;
> >  }
> >
> > -void __memcg1_swapout(struct folio *folio);
> > +void __memcg1_swapout(struct folio *folio, struct swap_cluster_info *c=
i);
> >  void memcg1_swapin(struct folio *folio);
> >
> >  #else /* CONFIG_MEMCG_V1 */
> > @@ -1929,7 +1930,8 @@ static inline void mem_cgroup_exit_user_fault(voi=
d)
> >  {
> >  }
> >
> > -static inline void __memcg1_swapout(struct folio *folio)
> > +static inline void __memcg1_swapout(struct folio *folio,
> > +               struct swap_cluster_info *ci)
> >  {
> >  }
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index f2949f5844a6..57af4647d432 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -582,12 +582,12 @@ static inline int mem_cgroup_try_charge_swap(stru=
ct folio *folio)
> >         return __mem_cgroup_try_charge_swap(folio);
> >  }
> >
> > -extern void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int=
 nr_pages);
> > -static inline void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigne=
d int nr_pages)
> > +extern void __mem_cgroup_uncharge_swap(unsigned short id, unsigned int=
 nr_pages);
> > +static inline void mem_cgroup_uncharge_swap(unsigned short id, unsigne=
d int nr_pages)
> >  {
> >         if (mem_cgroup_disabled())
> >                 return;
> > -       __mem_cgroup_uncharge_swap(entry, nr_pages);
> > +       __mem_cgroup_uncharge_swap(id, nr_pages);
> >  }
> >
> >  extern long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg);
> > @@ -598,7 +598,7 @@ static inline int mem_cgroup_try_charge_swap(struct=
 folio *folio)
> >         return 0;
> >  }
> >
> > -static inline void mem_cgroup_uncharge_swap(swp_entry_t entry,
> > +static inline void mem_cgroup_uncharge_swap(unsigned short id,
> >                                             unsigned int nr_pages)
> >  {
> >  }
> > diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> > index 36c507d81dc5..494e7b9adc60 100644
> > --- a/mm/memcontrol-v1.c
> > +++ b/mm/memcontrol-v1.c
> > @@ -14,6 +14,7 @@
> >
> >  #include "internal.h"
> >  #include "swap.h"
> > +#include "swap_table.h"
> >  #include "memcontrol-v1.h"
> >
> >  /*
> > @@ -606,14 +607,15 @@ void memcg1_commit_charge(struct folio *folio, st=
ruct mem_cgroup *memcg)
> >  /**
> >   * __memcg1_swapout - transfer a memsw charge to swap
> >   * @folio: folio whose memsw charge to transfer
> > + * @ci: the locked swap cluster holding the swap entries
> >   *
> >   * Transfer the memsw charge of @folio to the swap entry stored in
> >   * folio->swap.
> >   *
> > - * Context: folio must be isolated, unmapped, locked and is just about
> > - * to be freed, and caller must disable IRQs.
> > + * Context: folio must be isolated, unmapped, locked and is just about=
 to
> > + * be freed, and caller must disable IRQs and hold the swap cluster lo=
ck.
> >   */
> > -void __memcg1_swapout(struct folio *folio)
> > +void __memcg1_swapout(struct folio *folio, struct swap_cluster_info *c=
i)
> >  {
> >         struct mem_cgroup *memcg, *swap_memcg;
> >         struct obj_cgroup *objcg;
> > @@ -646,7 +648,8 @@ void __memcg1_swapout(struct folio *folio)
> >         swap_memcg =3D mem_cgroup_private_id_get_online(memcg, nr_entri=
es);
> >         mod_memcg_state(swap_memcg, MEMCG_SWAP, nr_entries);
> >
> > -       swap_cgroup_record(folio, mem_cgroup_private_id(swap_memcg), fo=
lio->swap);
> > +       __swap_cgroup_set(ci, swp_cluster_offset(folio->swap), nr_entri=
es,
> > +                         mem_cgroup_private_id(swap_memcg));
> >
> >         folio_unqueue_deferred_split(folio);
> >         folio->memcg_data =3D 0;
> > @@ -661,8 +664,7 @@ void __memcg1_swapout(struct folio *folio)
> >         }
> >
> >         /*
> > -        * Interrupts should be disabled here because the caller holds =
the
> > -        * i_pages lock which is taken with interrupts-off. It is
> > +        * The caller must hold the swap cluster lock with IRQ off. It =
is
> >          * important here to have the interrupts disabled because it is=
 the
> >          * only synchronisation we have for updating the per-CPU variab=
les.
> >          */
> > @@ -677,7 +679,7 @@ void __memcg1_swapout(struct folio *folio)
> >  }
> >
> >  /**
> > - * memcg1_swapin - uncharge swap slot
> > + * memcg1_swapin - uncharge swap slot on swapin
> >   * @folio: folio being swapped in
> >   *
> >   * Call this function after successfully adding the charged
> > @@ -687,6 +689,10 @@ void __memcg1_swapout(struct folio *folio)
> >   */
> >  void memcg1_swapin(struct folio *folio)
> >  {
> > +       struct swap_cluster_info *ci;
> > +       unsigned long nr_pages;
> > +       unsigned short id;
> > +
> >         VM_WARN_ON_ONCE_FOLIO(!folio_test_swapcache(folio), folio);
> >         VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
> >
> > @@ -702,14 +708,20 @@ void memcg1_swapin(struct folio *folio)
> >          * correspond 1:1 to page and swap slot lifetimes: we charge th=
e
> >          * page to memory here, and uncharge swap when the slot is free=
d.
> >          */
> > -       if (do_memsw_account()) {
> > -               /*
> > -                * The swap entry might not get freed for a long time,
> > -                * let's not wait for it.  The page already received a
> > -                * memory+swap charge, drop the swap entry duplicate.
> > -                */
> > -               mem_cgroup_uncharge_swap(folio->swap, folio_nr_pages(fo=
lio));
> > -       }
> > +       if (!do_memsw_account())
> > +               return;
> > +
> > +       /*
> > +        * The swap entry might not get freed for a long time,
> > +        * let's not wait for it.  The page already received a
> > +        * memory+swap charge, drop the swap entry duplicate.
> > +        */
> > +       nr_pages =3D folio_nr_pages(folio);
> > +       ci =3D swap_cluster_get_and_lock(folio);
> > +       id =3D __swap_cgroup_clear(ci, swp_cluster_offset(folio->swap),
> > +                                nr_pages);
> > +       swap_cluster_unlock(ci);
> > +       mem_cgroup_uncharge_swap(id, nr_pages);
> >  }
> >
> >  void memcg1_uncharge_batch(struct mem_cgroup *memcg, unsigned long pgp=
gout,
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 641706fa47bf..193c8eb73be7 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -64,6 +64,8 @@
> >  #include <linux/sched/isolation.h>
> >  #include <linux/kmemleak.h>
> >  #include "internal.h"
> > +#include "swap.h"
> > +#include "swap_table.h"
> >  #include <net/sock.h>
> >  #include <net/ip.h>
> >  #include "slab.h"
> > @@ -5462,6 +5464,7 @@ int __init mem_cgroup_init(void)
> >  int __mem_cgroup_try_charge_swap(struct folio *folio)
> >  {
> >         unsigned int nr_pages =3D folio_nr_pages(folio);
> > +       struct swap_cluster_info *ci;
> >         struct page_counter *counter;
> >         struct mem_cgroup *memcg;
> >         struct obj_cgroup *objcg;
> > @@ -5495,22 +5498,23 @@ int __mem_cgroup_try_charge_swap(struct folio *=
folio)
> >         }
> >         mod_memcg_state(memcg, MEMCG_SWAP, nr_pages);
> >
> > -       swap_cgroup_record(folio, mem_cgroup_private_id(memcg), folio->=
swap);
> > +       ci =3D swap_cluster_get_and_lock(folio);
> > +       __swap_cgroup_set(ci, swp_cluster_offset(folio->swap), nr_pages=
,
> > +                         mem_cgroup_private_id(memcg));
> > +       swap_cluster_unlock(ci);
> >
> >         return 0;
> >  }
> >
> >  /**
> >   * __mem_cgroup_uncharge_swap - uncharge swap space
> > - * @entry: swap entry to uncharge
> > + * @id: cgroup id to uncharge
> >   * @nr_pages: the amount of swap space to uncharge
> >   */
> > -void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pag=
es)
> > +void __mem_cgroup_uncharge_swap(unsigned short id, unsigned int nr_pag=
es)
> >  {
> >         struct mem_cgroup *memcg;
> > -       unsigned short id;
> >
> > -       id =3D swap_cgroup_clear(entry, nr_pages);
> >         rcu_read_lock();
> >         memcg =3D mem_cgroup_from_private_id(id);
> >         if (memcg) {
> > diff --git a/mm/swap.h b/mm/swap.h
> > index 80c2f1bf7a57..e4ac7dbc1080 100644
> > --- a/mm/swap.h
> > +++ b/mm/swap.h
> > @@ -5,6 +5,7 @@
> >  #include <linux/atomic.h> /* for atomic_long_t */
> >  struct mempolicy;
> >  struct swap_iocb;
> > +struct swap_memcg_table;
> >
> >  extern int page_cluster;
> >
> > @@ -38,6 +39,9 @@ struct swap_cluster_info {
> >         u8 order;
> >         atomic_long_t __rcu *table;     /* Swap table entries, see mm/s=
wap_table.h */
> >         unsigned int *extend_table;     /* For large swap count, protec=
ted by ci->lock */
> > +#ifdef CONFIG_MEMCG
> > +       struct swap_memcg_table *memcg_table;   /* Swap table entries' =
cgroup record */
> > +#endif
> >         struct list_head list;
> >  };
> >
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index 86d517a33a55..71a3f128fcf0 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -176,21 +176,19 @@ static int __swap_cache_add_check(struct swap_clu=
ster_info *ci,
> >         if (shadowp && swp_tb_is_shadow(old_tb))
> >                 *shadowp =3D swp_tb_to_shadow(old_tb);
> >         if (memcg_id)
> > -               *memcg_id =3D lookup_swap_cgroup_id(targ_entry);
> > +               *memcg_id =3D __swap_cgroup_get(ci, ci_off);
> >
> >         if (nr =3D=3D 1)
> >                 return 0;
> >
> > -       targ_entry.val =3D round_down(targ_entry.val, nr);
> >         ci_off =3D round_down(ci_off, nr);
> >         ci_end =3D ci_off + nr;
> >         do {
> >                 old_tb =3D __swap_table_get(ci, ci_off);
> >                 if (unlikely(swp_tb_is_folio(old_tb) ||
> >                              !__swp_tb_get_count(old_tb) ||
> > -                            (memcg_id && *memcg_id !=3D lookup_swap_cg=
roup_id(targ_entry))))
> > +                            (memcg_id && *memcg_id !=3D __swap_cgroup_=
get(ci, ci_off))))
> >                         return -EBUSY;
> > -               targ_entry.val++;
> >         } while (++ci_off < ci_end);
> >
> >         return 0;
> > diff --git a/mm/swap_table.h b/mm/swap_table.h
> > index 8415ffbe2b9c..b2b02ee161b1 100644
> > --- a/mm/swap_table.h
> > +++ b/mm/swap_table.h
> > @@ -11,6 +11,11 @@ struct swap_table {
> >         atomic_long_t entries[SWAPFILE_CLUSTER];
> >  };
> >
> > +/* For storing memcg private id */
> > +struct swap_memcg_table {
> > +       unsigned short id[SWAPFILE_CLUSTER];
> > +};
> > +
> >  #define SWP_TABLE_USE_PAGE (sizeof(struct swap_table) =3D=3D PAGE_SIZE=
)
> >
> >  /*
> > @@ -247,4 +252,53 @@ static inline unsigned long swap_table_get(struct =
swap_cluster_info *ci,
> >
> >         return swp_tb;
> >  }
> > +
> > +#ifdef CONFIG_MEMCG
> > +static inline void __swap_cgroup_set(struct swap_cluster_info *ci,
> > +               unsigned int ci_off, unsigned long nr, unsigned short i=
d)
> > +{
> > +       lockdep_assert_held(&ci->lock);
> > +       VM_WARN_ON_ONCE(ci_off >=3D SWAPFILE_CLUSTER);
> > +       do {
> > +               ci->memcg_table->id[ci_off++] =3D id;
>
> Do you need to check the memcg_table is not NULL here? Because this
> function is no longer static. Another caller might invoke this when
> the cluster hasn't allocated the memcg_table. They shouldn't. We might
> want some check and complain here.

Good idea, a NULL check seems good to be defensive. I also noticed
that I should skip memcg table allocation as well if
mem_cgroup_disabled() is true to save some memory. I will update this.

