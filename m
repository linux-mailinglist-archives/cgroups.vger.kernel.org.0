Return-Path: <cgroups+bounces-14775-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJRQOLfRsWnQFQAAu9opvQ
	(envelope-from <cgroups+bounces-14775-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 21:33:59 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF74269FBC
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 21:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E92B8307094B
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 20:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68014375AA1;
	Wed, 11 Mar 2026 20:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFFLnIuy"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EEB2C0274
	for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 20:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261230; cv=pass; b=gIyRnCK3qG2EawBxlY0KKtyhXpZGOQb/d2TIBuC2RBHyoVpSeC7vigGAG7X1+fP5J7LiKk/8Vo1kvCB334EMSDLAgkVjCKwaV2eahICSAt9+YOO6xF8AuFt9+VCaa8X6TMawvNNKMNDX7y/eDhZTy50cnHaXpTBWX7TUQC6aZWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261230; c=relaxed/simple;
	bh=Dp3rcUMqGQ1Nz9vSwLge75Ms4n8gxJ63+gf9f0lHYFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLo7lb6YXbefY4B1nYLzrWJBEPHNjZh0VD/CYGcUuyFl6Owvi274rlM67DTbQak3Jlyb6qUDP38T9toMqu0xXPm6Hu43db0Ad5rbJebmqRvPxFLaoMBk9ZcEWfe8mR4zN5c9MvpPd9GftBQxT6BLTxUNJ8i7aa5WnHSPa7AD6n4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFFLnIuy; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439b7a87fb5so207859f8f.3
        for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 13:33:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773261226; cv=none;
        d=google.com; s=arc-20240605;
        b=Qpdqv4N8naYvBHfiMXH4ui0vjISJ1LHaf6ahiG325dXbZTTmu3ydy+GQyxfgUrakeP
         GR01/zsCh12K8lfkTOwIBzoIPyqIWmDXIg5EHoQDO4+AQ3ssg8goWh8BE/H6RYYB/+zT
         zONY6/ObsfdovkOQSE9RiNUxM4Mtle6SLDi/kqxsBjy2dPMolvxRvo04Uvzoid3o280k
         wME+BKEpDt4mIo0d10gNa0QnGQVYFenUZcR9iow2Cz15TYqSmM1Jobok7t1HBnCaALM5
         zaHxcbrcCV6FSajX9rRJTyh/GCoPNClvHnCOb30I4Q70WX1aMtqDnYLY0BMdZdlVemWk
         AtkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YHI7l1WCAEY4m4EuY554pKNgGWPa5e1fuqNEJbOzcgo=;
        fh=nzIN25DYgVqN7sES0XBaXDuWuR4t2yZ9Fcqa5fSXLj8=;
        b=AKYWnZj78DMXd9m/Y6+6NRurrv4AHjeOTGc5LHR/t2ha1PnLj+fFEci7EZMJrqSxDY
         OziAxQeDJ4g8I1h8cMnhz3d/4VLqFkqnjR/Y9dx1H759KM+jkFgfc9p1rxXr8tRJ+xtZ
         7/MEQA3TNDIyx99H1QsYO++toFZLg3k8qdHE/G66n9or+lmAJB4hup0bnnACDyqtSbTm
         8UfhwY8rUxGqHs41iEgRFWGdpGrM7mRtkZaKk+/Mkgj1Ekq77HUc0jvyphrXOi4395rv
         eUwKt20qmF8Npeve+g2jYyvEi99ejE1feAEtt692Fx+yTPJvg9wKUrHqMO6bdrI2r/bT
         a/uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773261226; x=1773866026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHI7l1WCAEY4m4EuY554pKNgGWPa5e1fuqNEJbOzcgo=;
        b=WFFLnIuyp/YUz/d5YRAa4JQJiYwE1EMggbX5H1lgpLqpWzmvVU19+kxOqCazhMyDz/
         +ZtLRF/1XOlkFysID+SxNxJfipxp1mvpHlY+oFgrJDEEmzKwQ/8TQKeSaO+32Ug41exE
         DiEI3Eup2PgCfF1w7lJsGKOSCJR8eHyxSAZBn4eEhb2i1IepFNoqPuTGCefXXaEz9Edt
         B6kg+7fJGp/tqrxcCzOTkidkiiqFRn57weXj6fIvgn7CaAjkDGf3RMrQlLofqYrmOPkC
         ks/0MM3BWaGdF9SOE2kuFXWJwOpQ+DvuFOIT3aj+ChwOGyxJHYKFrzx7/z4SD8VZh4aG
         E3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773261226; x=1773866026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YHI7l1WCAEY4m4EuY554pKNgGWPa5e1fuqNEJbOzcgo=;
        b=QRAQb3rbV0bpS0BJG4XxBKtV5d36/t//R+ESijDcE3TIqnnJ7q9wU1PJaYp5ncabjR
         +elu1jz0PaAm2vLQHzbHJjQyD/ogzxAfXAgacw8/wJEveYM31BLf4Uh97O27bzUEeHH7
         gfwDtUNbXGb6Q75E9j4QuK2oukhRUt6uCSUHsBfpVoMnJZ4Tt+Ofa4gVEjhOdoUbcdNb
         kYpJhMOcHqKWivdL1T2gv5Y9xLVkHFCAbH3+i6Fyq6dN2QLz9uFn+0b1R3zG4qzoYeU2
         R1HTfrOp05beWQghGuLn0awLWnp8fdmq20YG3hTj/uCoxSPuL/V4d3Lya2fL9J0WOV0f
         kmzw==
X-Forwarded-Encrypted: i=1; AJvYcCW52K3BvI3dbV5ztTxPmmIEztaGUy+i9o7CcKrnj2xc8XYYx4/91NW2P9ejUVFrfLPGfcS/4dvz@vger.kernel.org
X-Gm-Message-State: AOJu0YzxHVV3avJGoIT3z60b+wM9X+KJKfyIXuhS/yYLWTorAWLZpsVs
	uFjIEcCo2efoJzJROALqhEbvDjTpebaqZ/Ujg8vFMGJv+AaPN54pyrEoSAUx/Qi+gF69gBPKAC9
	9PQPk4M5DUtWprte8lCXk3QSkQIJfOcU=
X-Gm-Gg: ATEYQzwHcrvd1njpZsAuiVm9HkA+cGlhQixAKWUD2tm68TnqG8xDdAuO6JjjX0QBN9c
	vUI6khKmt2coGLyTjKJy45X4hHfz95t2w9FPr3TLLs4s5ShcA0/Pz48il4HH26Q1iXdSiNQ5Zst
	F8F3T7cATNWdv02edCRBOM1lNcWGkXDW9aXRNj5x3Jq8n371PD/FW5W+eieZsruFENT/V98idUP
	F0fXgtFrNlv3QcUf9w89rKJbLkAra9FRnMyS59MbeK10zmWVrYrYsn4nrdZfT0gwM8IZ7sljTtM
	8PKYdHwmv96KBCMFc9HV5OcvG3HwuQKenFqvEOA=
X-Received: by 2002:a05:6000:2c03:b0:439:b539:787 with SMTP id
 ffacd0b85a97d-439f843cc76mr7457063f8f.53.1773261226227; Wed, 11 Mar 2026
 13:33:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311195153.4013476-1-joshua.hahnjy@gmail.com> <20260311195153.4013476-9-joshua.hahnjy@gmail.com>
In-Reply-To: <20260311195153.4013476-9-joshua.hahnjy@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 11 Mar 2026 13:33:34 -0700
X-Gm-Features: AaiRm50IIEY3RVV7LzpuXvXj-0-MT8KAtiVfjsqVQKB09RLupSJJBknv2VPETzs
Message-ID: <CAKEwX=OySmc1SnnzYBjL7vn4o9bf2BiSzUUHtx+6hpU4oCu93Q@mail.gmail.com>
Subject: Re: [PATCH 08/11] mm/memcontrol: Track MEMCG_ZSWAPPED in bytes
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Nhat Pham <hoangnhat.pham@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14775-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4CF74269FBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 12:52=E2=80=AFPM Joshua Hahn <joshua.hahnjy@gmail.c=
om> wrote:
>
> Zswap compresses and uncompresses in PAGE_SIZE units, which simplifies
> the accounting for how much memory it has compressed. However, when a
> compressed object is stored at the boundary of two zspages, accounting
> at a PAGE_SIZE granularity makes it difficult to fractionally charge
> each backing zspage with the ratio of memory it backs for the
> compressed object.
>
> To make sub-PAGE_SIZE granularity charging possible for MEMCG_ZSWAPPED,
> track the value in bytes and adjust its accounting accordingly.
>
> No functional changes intended.
>
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

LGTM.
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

> ---
>  include/linux/memcontrol.h | 2 +-
>  mm/memcontrol.c            | 5 +++--
>  mm/zsmalloc.c              | 4 ++--
>  mm/zswap.c                 | 8 +++++---
>  4 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 701d9ab6fef1..ce2e598b5963 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -38,7 +38,7 @@ enum memcg_stat_item {
>         MEMCG_VMALLOC,
>         MEMCG_KMEM,
>         MEMCG_ZSWAP_B,
> -       MEMCG_ZSWAPPED,
> +       MEMCG_ZSWAPPED_B,
>         MEMCG_NR_STAT,
>  };
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 68139be66a4f..1cb02d2febe8 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -342,7 +342,7 @@ static const unsigned int memcg_stat_items[] =3D {
>         MEMCG_VMALLOC,
>         MEMCG_KMEM,
>         MEMCG_ZSWAP_B,
> -       MEMCG_ZSWAPPED,
> +       MEMCG_ZSWAPPED_B,
>  };
>
>  #define NR_MEMCG_NODE_STAT_ITEMS ARRAY_SIZE(memcg_node_stat_items)
> @@ -1364,7 +1364,7 @@ static const struct memory_stat memory_stats[] =3D =
{
>         { "shmem",                      NR_SHMEM                        }=
,
>  #ifdef CONFIG_ZSWAP
>         { "zswap",                      MEMCG_ZSWAP_B                   }=
,
> -       { "zswapped",                   MEMCG_ZSWAPPED                  }=
,
> +       { "zswapped",                   MEMCG_ZSWAPPED_B                }=
,
>  #endif
>         { "file_mapped",                NR_FILE_MAPPED                  }=
,
>         { "file_dirty",                 NR_FILE_DIRTY                   }=
,
> @@ -1412,6 +1412,7 @@ static int memcg_page_state_unit(int item)
>         switch (item) {
>         case MEMCG_PERCPU_B:
>         case MEMCG_ZSWAP_B:
> +       case MEMCG_ZSWAPPED_B:
>         case NR_SLAB_RECLAIMABLE_B:
>         case NR_SLAB_UNRECLAIMABLE_B:
>                 return 1;
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 291194572a09..24665d7cd4a9 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -1047,7 +1047,7 @@ static void zs_charge_objcg(struct zs_pool *pool, s=
truct obj_cgroup *objcg,
>         rcu_read_lock();
>         memcg =3D obj_cgroup_memcg(objcg);
>         mod_memcg_state(memcg, pool->compressed_stat, size);
> -       mod_memcg_state(memcg, pool->uncompressed_stat, 1);
> +       mod_memcg_state(memcg, pool->uncompressed_stat, PAGE_SIZE);
>         rcu_read_unlock();
>  }
>
> @@ -1066,7 +1066,7 @@ static void zs_uncharge_objcg(struct zs_pool *pool,=
 struct obj_cgroup *objcg,
>         rcu_read_lock();
>         memcg =3D obj_cgroup_memcg(objcg);
>         mod_memcg_state(memcg, pool->compressed_stat, -size);
> -       mod_memcg_state(memcg, pool->uncompressed_stat, -1);
> +       mod_memcg_state(memcg, pool->uncompressed_stat, -(int)PAGE_SIZE);

nit: seems a bit awkward lol?

