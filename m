Return-Path: <cgroups+bounces-15337-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJUBIeWm4WknwQAAu9opvQ
	(envelope-from <cgroups+bounces-15337-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 05:20:05 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49761416887
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 05:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A9972300E2B7
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 03:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFC1359A9A;
	Fri, 17 Apr 2026 03:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hU5pHhsV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162E633A9D6
	for <cgroups@vger.kernel.org>; Fri, 17 Apr 2026 03:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776395996; cv=pass; b=seHPbYc7m34bmdK7L+TRWzvF4lwRT1aRODCxj4Bw0g+W0fKKfwxb17Go3YtYsnVtjC34uJWtmHm+RZE2ONCZapvjs2LabMg1powSyo1AD/3uH0Lao4gaVgzv9ZC8cZoo/atffiQMXlhDWgaMi55rXKtAM4W+pRJfYO/BGYBuiiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776395996; c=relaxed/simple;
	bh=MBi8Txh6sbhY07r+2rIFRifoqMAtiXmhDhHamvp2K2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vDYCI2lWQWc9CGDo0Xg3N51Xo0Kh8WxEAp+sCKHwtIIaHXkTv/RMtcpTIVmHHjpS8THcCaSV9kjaUK3e6K556CkWRCPKt/2cmgiwzO94JWyLfu8/y5QTtRyWNqtT5vq02ZUxz6jFJNwbyb1XADpP3AXUiRqVW74KtqOOQfR9Vvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hU5pHhsV; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66b2d49ffb0so226881a12.3
        for <cgroups@vger.kernel.org>; Thu, 16 Apr 2026 20:19:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776395987; cv=none;
        d=google.com; s=arc-20240605;
        b=GbaO6DrhQEhKd8D2m1YY8Hnq2SRSnPgGRCRHWAsi9etFDb6HpZHOjeX9K/OFaz6Jsf
         Ei/N9QJyWx0oM+HOl2fplWX7sopFk4MeVyAZeyazPLAMti9iOniHReydapsk5lOtTFxa
         KQz5O7l5BfX7xgkFl3cCCRmGGBDF/RNs5+XSRzGv12syC2+pkssBe5xCtozp6oMuP89d
         VFtCkIRmi905izqd50wZxmE1BD8tUR1Z6eNJNsz8j89+PGQOmrgQJkUTnqCmbNzN/7mj
         Rnih1wWDA9yqcJpt23rP64Gmezm9Kb9P/GlWURwig/R5HdeWlZbbCZLPoqgIAuNLh272
         L3Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yM18Ak5+kMBmVuDR0UbI8yoR0xCl6Hm9vDklobqY31M=;
        fh=+DZTSfZPI31YI9cl+DmyRRwOzw+G80kx98s04HBZPxY=;
        b=gthiYTZItSmfU9V7uCcr6RGZc8vCwpwDTo6gYS/Dn0eDpKNqR0zJz+Y3VpTuX8YTsI
         B6w44pZwHyCnNEaDtHOa/AcYq6uC3+rkEeKkJhamcO9Wf03uSJ9Uc5u5mfQ4fsIvyWkQ
         y04zV4xNly7lO7RdDIil1bgQQSs8SxvcOWf9r4w5OxfrL7nYBc7X7LSEyHgLJ073A3Or
         i9EIVqHGjZCXWT+5EsfZyz9w2MvASSNh5WUvhZFxdApEGPIUDC8odk9tSq0nEeojjERl
         LkernXC61s05BnzB2mN4BMGoA3uISLtStpdN8RPSiebHIEO9TEtEqMcQJtOpUWVNsyfI
         anKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776395987; x=1777000787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yM18Ak5+kMBmVuDR0UbI8yoR0xCl6Hm9vDklobqY31M=;
        b=hU5pHhsV4Ih9HqaTSyf+NFcqaYVMpSNHUzXCEHKNP1D14+DHtItz8CtDbEDM74PY2l
         Yza5xcfnp9S4GRXcGRUxbQXN1MwFTlZwCynGxv4w2Ir37E4nOMPgzcLQUJgQ57nCDNL2
         PAhNkFYX1fnIbIcTIbrEMF3gqUA8d8G8c2WJde8bEBJH2g6X+o2d9UfQStxZgIju73Xj
         DJroR6MP9pRsvbISphGaCkWOVftA7riCkmDkKQYChJf90YQTN7gWh/eRHdBMHbWywJUP
         CBmf3AKBZQ8bIduLxUH63MkG1W6rSdoslrsiykjllbAYBCvbMSZ0xGN+yhU1XCscouPu
         czYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776395987; x=1777000787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yM18Ak5+kMBmVuDR0UbI8yoR0xCl6Hm9vDklobqY31M=;
        b=fww0LMPgnLAcmfRMOVfocYIONSC5EmyftO/MORVYiQIp4GgzkbDe1bt+TMFw/Iq0vV
         37XE8Y4C/qxKH0fqvUvB3FOqwKNG8pEjFjuuOGlbGpl8bhv/FV5LyIF0OoN8JnY7cYJY
         jIJqH8XM9W6ewihn1BfgSMSyh5Wuz7+l/y4tWd67t7wIK9pStOWI87VHndhSJeNl4a2h
         Ot+x5yMVxKNKMnif2m5YzyjwJSDYqMdp+sX+MZHUXTNTsomvdQdDR5Mfl4OrYgRZR6PK
         zGl6DeEinRwTp5yColCg5zrcEt/2OAaBdIVEdCyJEqWJFcbhvM0rlpSd3mikl+0ibsKA
         z4PA==
X-Forwarded-Encrypted: i=1; AFNElJ/AIBMt7Usf5NK55B7kwDqHVaj0PLRIK7BSltlheSg3lA24/iZnRm4X1qnrb+bMbvFby/hQCJS5@vger.kernel.org
X-Gm-Message-State: AOJu0Yztv8eoVHrFRDPMyr4yqAZpdnUZyn/SJDU4XCQ++JTrN69cs+Lq
	dA8zSdglmwPVWlOOVvRuSqeALFG2xoOpFYn3Uael5aSXYbNi3V4mfSKRYMphEC6lzSsH/htKUkm
	Uf692SJo1Yx9LJM3yB0pQF+mvTkcjld0=
X-Gm-Gg: AeBDies8+rClF9RuFfHsg6Db0HT4d3uEBfrM7dvTV0PutNz010Fml/yE8zKyMe33u4y
	Xcf6LZmhjkkDp3CnVTokBejWtIjsE4/uilyRxQisf9MmkI5nLND8/l/I7uYxXdke7dh0gFWUOB0
	+wlJ5dghd9uRuRjpUT0ov1OW4XArDpX1i5XXArGupL+FAW2+wqI9YraCcH38TyTLdgfq2sg5kcA
	nqnlwtbsv1hm2ENNZgOTZV/CDOm7ddsJiQltQ0RuZtANsKUtarJmM257LuyQ/fTOG8X075NRO0m
	fVcmjfGkwN9pCNklFvy6azY3HHMDpF/AzXhQViq47wwiVCEasOM=
X-Received: by 2002:a05:6402:530e:b0:670:a2a9:fe59 with SMTP id
 4fb4d7f45d1cf-672bfed7667mr512994a12.25.1776395986572; Thu, 16 Apr 2026
 20:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417-swap-table-p4-v2-0-17f5d1015428@tencent.com> <20260417-swap-table-p4-v2-4-17f5d1015428@tencent.com>
In-Reply-To: <20260417-swap-table-p4-v2-4-17f5d1015428@tencent.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 17 Apr 2026 11:19:09 +0800
X-Gm-Features: AQROBzDC1qIzgjTfCrL0QSfj2b-Fvn7EnI1uFbve34YiphupQbw1nZbSmw9Wqt4
Message-ID: <CAMgjq7ANih7u7SJB8uWcQHS8XRJySNRc3ti9V-SVey0nGE3gLQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] mm, swap: add support for stable large
 allocation in swap cache directly
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Youngjun Park <youngjun.park@lge.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Dev Jain <dev.jain@arm.com>, 
	Lance Yang <lance.yang@linux.dev>, Michal Hocko <mhocko@suse.com>, Michal Hocko <mhocko@kernel.org>, 
	Qi Zheng <qi.zheng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15337-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49761416887
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 2:38=E2=80=AFAM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
> +/*
> + * Try to allocate a folio of given order in the swap cache.
> + *
> + * This helper resolves the potential races of swap allocation
> + * and prepares a folio to be used for swap IO. May return following
> + * value:
> + *
> + * -ENOMEM / -EBUSY: Order is too large or in conflict with sub slot,
> + *                   caller should shrink the order and retry.
> + * -ENOENT / -EEXIST: Target swap entry is unavailable or already cached=
,
> + *                    caller should abort or try use that folio instead.
> + */
> +static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
> +                                       swp_entry_t targ_entry, gfp_t gfp=
,
> +                                       unsigned int order, struct vm_fau=
lt *vmf,
> +                                       struct mempolicy *mpol, pgoff_t i=
lx)
> +{
> +       int err;
> +       swp_entry_t entry;
> +       struct folio *folio;
> +       void *shadow =3D NULL;
> +       unsigned long address, nr_pages =3D 1 << order;
> +       struct vm_area_struct *vma =3D vmf ? vmf->vma : NULL;
> +
> +       entry.val =3D round_down(targ_entry.val, nr_pages);
> +
> +       /* Check if the slot and range are available, skip allocation if =
not */
> +       spin_lock(&ci->lock);
> +       err =3D __swap_cache_add_check(ci, targ_entry, nr_pages, NULL);
> +       spin_unlock(&ci->lock);
> +       if (unlikely(err))
> +               return ERR_PTR(err);
> +
> +       /*
> +        * Limit THP gfp. The limitation is a no-op for typical
> +        * GFP_HIGHUSER_MOVABLE but matters for shmem.
> +        */
> +       if (order)
> +               gfp =3D thp_limit_gfp_mask(vma_thp_gfp_mask(vma), gfp);
> +
> +       if (mpol) {
> +               folio =3D folio_alloc_mpol(gfp, order, mpol, ilx, numa_no=
de_id());
> +       } else if (vmf) {
> +               address =3D round_down(vmf->address, PAGE_SIZE << order);
> +               folio =3D vma_alloc_folio(gfp, order, vmf->vma, address);
> +       } else {
> +               WARN_ON_ONCE(1);
> +               return ERR_PTR(-EINVAL);
> +       }

Checking sashiko's review, most are false positives but this part need
an update indeed, this part should be:

if (mpol || !vmf) {
        folio =3D folio_alloc_mpol(gfp, order, mpol, ilx, numa_node_id());
} else {
        address =3D round_down(vmf->address, PAGE_SIZE << order);
        folio =3D vma_alloc_folio(gfp, order, vmf->vma, address);
}

