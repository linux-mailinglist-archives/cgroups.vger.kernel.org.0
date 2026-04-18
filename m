Return-Path: <cgroups+bounces-15355-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id y/v6L56I42ndIAEAu9opvQ
	(envelope-from <cgroups+bounces-15355-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 18 Apr 2026 15:35:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1166C421351
	for <lists+cgroups@lfdr.de>; Sat, 18 Apr 2026 15:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 209CB30265AC
	for <lists+cgroups@lfdr.de>; Sat, 18 Apr 2026 13:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2109937CD40;
	Sat, 18 Apr 2026 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGV/yGNI"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829FF318139
	for <cgroups@vger.kernel.org>; Sat, 18 Apr 2026 13:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776519314; cv=pass; b=oNOXqYoB2GtvglB7xnWITdGJAVn2w2t5ktVsI+7eJ9vJq4dDu7xviBtWj4rgszoHnkfR09BhQdmAhI0BXnS9du7edkzp2XSBPf0fPAOu9itRxy2qH8bgdBxVCHBZggKmXjzOgXnLd46/bYHTizHXcHu/YjFCW9cFT6QlDe9603Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776519314; c=relaxed/simple;
	bh=LVb3q7/UdhdCW91YqXnzoN7xHitd0ii1iqEm00Cfjs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EZVCHrVUoj7yDiefi57/xI4EAxE/PwFDuSPtefQzTdGR1FOMH5HVpbsXg8Cckdqs/3T3lxmWNunEKlDIMqWFKqDQmfykOCUE5WVwyLQ+BMSBnEOvJVPhDNxohHHz3fQbe3zvFndNqry8oAzDnM/yxIUNZ9ikfH0A/09TSguOIfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGV/yGNI; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-672bd7d00bdso2461800a12.1
        for <cgroups@vger.kernel.org>; Sat, 18 Apr 2026 06:35:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776519312; cv=none;
        d=google.com; s=arc-20240605;
        b=HwrV18velRrJcjIwlGj78x4PYJut+uCfRz+2w0VZhxtpf/xvRYhyZNmXD3BM4rT7Wa
         iBa+S3Xro7SjsnG+jWBhesHL6tokgRE9ksa/GlP/C7S2Oj7rtEgtb9NGxzvMZHlu8CZK
         Y99i6jfGSvfWCGmYR95zsLBpsIJFkhkQZRPyG21PK9MPGX/1lJl5RYb1I+LSL/tPbJ0z
         zXOefocE8KLGw0CKiTpVwkD9hWBew+2QvpxjuhZ+trXCF/GQnEAh8DyVQCJff5jY9uKm
         MhFVuKTTXnhOe849vrD9/WkSISEgMrQAhyfV+GjprnMlw5ZBMcYygF2jA7DYwg39+Fwq
         FVNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d2GMCJikAytNydeTS30qIgVdQwpmLTzn01CKLn0VA/c=;
        fh=ZVVYarFdFlqlv3GybtqaH+9T+1BxthcT26Dd03VpCvM=;
        b=jDXwgrK9w5y8DTPLfcJ+61FUBkZSoxiNgU7hAW+mJ9pbfPpdS2c185Gxzcu5frv/0c
         9YB/UL54UhwkROpzDep4ps+1S5QzcORPeRupYIpGAbcxN7f2J2sJV7B4JHo8Z/Tw+j8Y
         XWDV1stg30tgTAwcxIuDgsgLZr2cV26uP4Axc+ckl0zsmxYwn/DMuGLlymypE/Anqllq
         qu8wKIVtHTGEToIrjVbn8IOtY8KyVXTuUZqXAn1s5eX8TDqEBMPv2vw2wo7drJLxMx4o
         3SmlCdhEy7rnGNvHJnQ0j3a77iqTdBqVcRMkhng/+LwxADBpTfmPQ7yKduXM4dD6Bo22
         ByNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776519312; x=1777124112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2GMCJikAytNydeTS30qIgVdQwpmLTzn01CKLn0VA/c=;
        b=YGV/yGNINl/Y+4GUnHEmqBKv5zfO1HNs+gD2M1R9EatAykHzRguV7ydcbLfz7KdX8H
         hFb5YKA8k9fofhTFRfMfr2rs9RIXGJ189i0rV4sIculheZE3eDFyqpXAyHcDqnzGMHCO
         uF1TUNDz7iNtRI2eZTrctWBhgvThJjMHKCPvid1H2ZnqYhyX+XT74Gp8dB0W+z2iD9Ty
         pYvOf7cHULAkzB8F8a35wgn+myQeWxM23+kRFnd7V+GAGo3NBWtCrpfRGRf5SBfvP6PZ
         fMTfyVbr6ltfQ4Orxw9RkWNaGBpcNjtpyfMARRdEUTWZW1S6tYV2G/z0ZKYWkR9rTKwz
         KSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776519312; x=1777124112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d2GMCJikAytNydeTS30qIgVdQwpmLTzn01CKLn0VA/c=;
        b=j0ZpbMFY0yPxIAqA/w6xc/17ozLzjaqDjHU3bfvs2EwVskWrt7Tef9BWiKyPWCesY/
         QUcfjxax7vLFwS0HiB5Je3sV9gE2iYajP6s+xoZyJO2tjsWzeL7opq4dR8blbD8Fb8En
         VW7fjjNFqSo+7uEF7m3pT8nq3fDsdTI06/Fcso1imnEy3ECSIeUPojBiykl9dIWGQlcE
         y7aIH0HabhjHPGeDZhEBsHF8R4DahtTuO0KuqtLw1cENTJrsQ1H1ntyOzqzx9ihVPGZx
         QBQKddRT0BdPHxJ/FPH//E0zhpGh7A50SWbAs/BKjiObPF3NlH6QuXSWyDO7UZM+DDJ2
         zIWQ==
X-Forwarded-Encrypted: i=1; AFNElJ8hgw4VTyU43O6wFs9J3o4JFlKBtfHYEBrBocYktiLwQpJHmeDnG6ico7P/GcDJAvRgxQSTi9oJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwrU5q4NC9lP1lvXgc8fjlwxJvLaUmoltV5Db1px4m4UNoBYFM6
	Y0Y/zJ9p/0s91/JD/IrhIByA6qUuPTSDhjoSirTQ0LUFi9RrqTnwX8MhAVrRvnd6hEBsCdNL+QG
	V3u0QYrm/PNQHD+9k//ky3qV6MU6NOUo=
X-Gm-Gg: AeBDievIrXs4x2SSxipzKxvGIKKilnV4mm0g2Zn1tNfTKMGDzBDEzTHwVHL521YbnYj
	V/IQWEpBVJbAyKqfv9sSJmrSpxszDBrQpq10nb4O57Pw40K/NscHIeCVttBhb7z/gU3/1ASJFvH
	5kxxYDZblTadjUTesOvmZAoDIn3A7Ej6zC3ZBRVYAqCLnq6NUOV2zuj0vYN+lICWCwJolzE9LJz
	JcT99YrOAsu83ceqiM4NH3U2Bxcox9jAhMjGRx0ueBh0ZVNZh/gLScqwKiPxB+Oa7s46vaiDAJS
	SDcJ+xZ2cREG2ML1N7bWffSylTEsegNKBXZ/oWCJpltBgB2fVDU=
X-Received: by 2002:a17:907:da7:b0:ba6:4e0f:e396 with SMTP id
 a640c23a62f3a-ba64e0fe8fdmr25209766b.12.1776519311494; Sat, 18 Apr 2026
 06:35:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417-swap-table-p4-v2-0-17f5d1015428@tencent.com>
 <20260417-swap-table-p4-v2-11-17f5d1015428@tencent.com> <aeN4qzqfyFpWJXYZ@yjaykim-PowerEdge-T330>
In-Reply-To: <aeN4qzqfyFpWJXYZ@yjaykim-PowerEdge-T330>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 18 Apr 2026 21:34:35 +0800
X-Gm-Features: AQROBzBd8__QB5UpYNjFkpdRdW1dt7xUjPlCpJkWJoR2NS3IE_II9VBSPRxgaVQ
Message-ID: <CAMgjq7CwaKWP_2yxorK88ZLZ-hRRpaLVm76jJE5mLNcX5eCg=w@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] mm, swap: merge zeromap into swap table
To: YoungJun Park <youngjun.park@lge.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15355-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,linux.dev,bytedance.com,vger.kernel.org,arm.com,suse.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lge.com:email]
X-Rspamd-Queue-Id: 1166C421351
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 18, 2026 at 8:28=E2=80=AFPM YoungJun Park <youngjun.park@lge.co=
m> wrote:
>
> On Fri, Apr 17, 2026 at 02:34:41AM +0800, Kairui Song via B4 Relay wrote:
>
> >   *
> >   * Usages:
> >   *
> > @@ -74,17 +76,22 @@ struct swap_memcg_table {
> >  #define SWP_TB_PFN_MARK_BITS 2
> >  #define SWP_TB_PFN_MARK_MASK (BIT(SWP_TB_PFN_MARK_BITS) - 1)
> >
> > -/* SWAP_COUNT part for PFN or shadow, the width can be shrunk or exten=
ded */
> > -#define SWP_TB_COUNT_BITS      min(4, BITS_PER_LONG - SWP_TB_PFN_BITS)
> > +/* SWAP_COUNT and flags for PFN or shadow, width can be shrunk or exte=
nded */
> > +#define SWP_TB_FLAGS_BITS    min(5, BITS_PER_LONG - SWP_TB_PFN_BITS)
> > +#define SWP_TB_COUNT_BITS    (SWP_TB_FLAGS_BITS - 1)
>
> Hi Kairui :)
>
> Would this break the build on 32-bit arches with 40-bit phys
> addrs (MAX_POSSIBLE_PHYSMEM_BITS =3D 40)?
>
> Architectures I checked.
>   - ARM LPAE   (CONFIG_ARM_LPAE=3Dy)
>   - ARC PAE40  (CONFIG_ARC_HAS_PAE40=3Dy)
>   - MIPS XPA   (CONFIG_XPA=3Dy)
>
> Calculations.
>
>   SWP_TB_PFN_BITS   =3D 28 + 2 =3D 30
>   SWP_TB_FLAGS_BITS =3D min(5, 32 - 30) =3D 2
>   SWP_TB_COUNT_BITS =3D 2 - 1 =3D 1
>
> The BUILD_BUG_ON looks like the real problem. it needs at
> least 3 count values (free/used/overflow).
>
>   BUILD_BUG_ON(SWP_TB_COUNT_MAX < 2 || SWP_TB_COUNT_BITS < 2);
>
> Confirmed with a cross build (multi_v7_defconfig + lpae.config).
>
>   error: BUILD_BUG_ON failed: SWP_TB_COUNT_MAX < 2 || SWP_TB_COUNT_BITS <=
 2
>     at __count_to_swp_tb (mm/swap_table.h:227)

Hi YoungJun

Nice catch! Thanks a lot :)

> I think the right fix is widening swap_tb to 64 bits
> unconditionally (atomic64_t).

I'm a bit concerned that memory usage on 32 bits will bloat up...

>
> (Or, uglier, these arches could always route counts through the
> extend table.)
>

Seems not ugly with a ci->zero_bitmap, looks clean to me, the
definition will be:

SWP_TABLE_USE_INLINE_ZEROMAP is true when BITS_PER_LONG is not enough
for SWP_TB_FLAGS_BITS, then:

struct swap_cluster_info {
...
#ifndef SWP_TABLE_USE_INLINE_ZEROMAP
        unsigned long *zero_bitmap;
#endif
        ...
};

And helpers will be:
static inline void __swap_table_set_zero(struct swap_cluster_info *ci,
          unsigned int ci_off)
{
        unsigned long swp_tb;

#ifdef SWP_TABLE_USE_INLINE_ZEROMAP
        return bitmap_set(&ci->zeromap);
#else

        swp_tb =3D __swap_table_get(ci, ci_off);
        VM_WARN_ON(!swp_tb_is_countable(swp_tb));
        swp_tb |=3D SWP_TB_ZERO_MARK;
        __swap_table_set(ci, ci_off, swp_tb);
}

There are only three helpers in total, looks fine. Allocation part is
just like the memcg_table. Compared to this version only it seems
onlys needs a few dozen lines change (A few #ifdef
SWP_TABLE_USE_INLINE_ZEROMAP) and not hard to understand. How do you
think?

