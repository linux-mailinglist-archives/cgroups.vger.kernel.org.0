Return-Path: <cgroups+bounces-16449-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOFdLCjWGWqjzQgAu9opvQ
	(envelope-from <cgroups+bounces-16449-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 20:08:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D814607103
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 20:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9DFE304BCCD
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 18:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DA33FE34D;
	Fri, 29 May 2026 18:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0yUu76Q"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4F53FE376
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 18:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780078031; cv=pass; b=K+cpCWlLhsZImSj8p63n3QqsJ91WfxhudpPloH69aXB6wgqXS8qq/jkKfIKcmG7vSPISAMGDsG7Nd3UXOEhFFXwKN4MUjn7ieVrJkEyEdf4zh1XVSUzz1Ebt824btHmEn9s50wbyIBziCe+1a6rvEOE4A7uNyieaK5dRwvEE0aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780078031; c=relaxed/simple;
	bh=lsc3C4shfleaR6oKZVK66+m18Hexd+/Lpt5HL95/ABg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bapQg5+6EadDmDQVJDqn1Ghs6YUWLd4I2/2O6yrfu3bk89x3N6GHkDSqDkUushfHQfxhjDFutvlZ5ih9Y/OXrBmhD8nP0lOX29GFrXDxlu/tuN1OBvt9Eqzyts5+uzF+Wp5rF4M+edKfYzGUwDHh/Iy5gHMWj7OZP+p2l/nHTwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0yUu76Q; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ef1198766so611276f8f.0
        for <cgroups@vger.kernel.org>; Fri, 29 May 2026 11:07:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780078028; cv=none;
        d=google.com; s=arc-20240605;
        b=MJIVy8wpptsGM3JcBBxx1zxBB4rSxzSpX90DxsfV1Yi1hshxb+/LH1Meg3HlKt96Kk
         Z5/ODpfC8Lka3SuMGXsKmkIkvHwe4+NHVOH3h9H3kxugTSoGnkkoGzaMVfkCde+E98Hp
         m0Mr25Qfr+FivgRgWmUMcx1nWxhJQQhLIaDf+1Ekne/wlcJOmBfhUSLQMyadLcio80IT
         GpTtnAo9d5m6x+LoBcnAJ+F7OLwgmaK9zos2uFVMJEkrylPFAxENH8C+F/vKEC7K76uu
         ycmxUYRHcisZESnr4pDwEW/MEgolUqSDbzAF0dxzzZ/Xx20W4E6umt4uSQaQe+6CpwNn
         9XVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MZoHrQ02OOCar3J/zEZO4IwdNcb2UEkvFMGplj3lU9g=;
        fh=ulcmLAaovTPNCNZuF6CeWNzUtjZ3Li+gMOfVClAEOPE=;
        b=SKUV7e0qlpKhAxN2Z+uqrVArGjPgZZahdQSgzpiUPnAQsVFHThbhlFNbty/5o7tcxr
         U9bs+jFkD1T+3GX/rSEQByvS2W2I4+wsbSM118KGIx7jkXWurMTMHNV8SbbaDrNsVqAN
         OCPbS6Spi/5IYhMVJ6Gg4eQboHKK8NdkE/xBJ1npX0g0wRHEQ36YyRiWSjBcExdPW5LZ
         EjGTvjEaHf9PVz34BTXYSm+1KBVXnKmXEQHf7AcF8Rz/Z9grzOBE5BNQbh+5x9c9Dm+3
         hbD4sQKbvNgDe9tfom7ptwDVt+PmpzAO9OvIrUIZN4slGbSMIhYnaqnPBjS8wTLBZlgG
         lvAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780078028; x=1780682828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZoHrQ02OOCar3J/zEZO4IwdNcb2UEkvFMGplj3lU9g=;
        b=l0yUu76QZd49ahEnb42TRZx+bQXT8MMQQgvluA+mH3Dg0bVZDY7iVZJqhXLv2J659A
         9ysvwDJmULxCLgHa4LdgAlbEs7fY5+c+H+KirLkl+SsMzbyw2cs+6iUS0lyz0sld3/oc
         fYWDZH08/m75aOMqJXYexQ9TjPl7KvLowkm4cwWqI6X0ZQsDsAkEEIiplrEiVtruhzQ+
         52OcUZUJPQjZvMnE+xbgBEcLOiY68zcqLxgyJkCaXjnxG74pN6n9czD07xpyprZY0uUP
         4S1cIrtguGSZmcmh7eZ/cGXgYYlKWxJ913cfiDOfQwtzLXcubePJsKRqVCffjjyQ19E9
         l9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780078028; x=1780682828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MZoHrQ02OOCar3J/zEZO4IwdNcb2UEkvFMGplj3lU9g=;
        b=M5hjV5TAgXiduo4h7yVqzgtJhsM+lxDtkTxjq6HahLoitLIfRl8M1/i2fahd4BNM3d
         akwyVSfgwN77DaPTZpeJbYjXQv9D8LsHvnTivC99it2lrQQR08Sce6DlfeE6MlvzbJgI
         fEbowc0DOPPinT/tVnce8tns8Yxt+CGqIl2n72kAT9nbF6PZO5EFpC+4kvUByqSdOeSg
         z9dd48REa2hUEqGq59geu3I5qYiksDB6j+9slGQf6zBfkdiuFvA75x3OgaKZzJ8bZiHZ
         /ECq8NvgTYSUdBYjHOVTx1VqEdTj3CQe9iD8Fl7/+cv+iUI+EQoqOC2osFac4XdLAcHW
         4Dbg==
X-Forwarded-Encrypted: i=1; AFNElJ9qAUGL9li8w4dlz6rUm5WT1JFii9APqrmIjUPj98yLf27ayX8Cm23z4V9rW5F0lL95TKcjGegM@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu8CmV4gTZMmHI3VsfbiJdkbSpLrJD7dEbNCG8I2eVgsV23Ujp
	4koPTW/RzypJxSoIBYu/BSq0pioPMELWVJ66yUoy6VENXnMQW6Ih3SaWKf4inpAx4NIqHv79GBf
	0OhbudW8mcDKZHJmf7sGOdn9bLj5Jjbs=
X-Gm-Gg: Acq92OFH5rNYZ0u4ChKgKlLRzw5ygjDk/2KCzlVadh/TjQsCJ70Oc9uo+tBs0tpJePE
	ofDWllb7o+Ydn2KOCgCaiv0Qnpbshxlzq5tSC9iE4keQ5RAgegecjvYVtJNgiYRN4nXSptHu6u2
	azJMzE+SQZHQwif11efqoga7TbIrjsIMvqhQTexz4ey39CNZxFGjRq+m0Mj+Ivg6mkvl53+Dt35
	shkIVNeYanzQEfnxiJauchrM5FVF7k2iGh/1IxhoYsWKh8MQq1C/FrNgFUDrk/DviOMyJaRS2LF
	/vMKi01OXDZg4jA2g8F+4mH/f7gVtgiTfvhb/qJ/hh+/DElJ8w==
X-Received: by 2002:a05:6000:1869:b0:45e:8e69:955a with SMTP id
 ffacd0b85a97d-45ef13397c2mr6590756f8f.9.1780078027311; Fri, 29 May 2026
 11:07:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_98CD9F78E48D08DC005A6471A13CFF28B60A@qq.com>
In-Reply-To: <tencent_98CD9F78E48D08DC005A6471A13CFF28B60A@qq.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 29 May 2026 11:06:56 -0700
X-Gm-Features: AVHnY4LiKS9AOV875xFexbH0858oyjx1YBqN9AQEaDywp-8XC4Ly2QmE4FmtL2E
Message-ID: <CAKEwX=PdQb2nDbFaZYuRa9_mYrMCnMEJHpxxABebKkVz+OgDHg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/9] mm: support zswap-backed large folio swapin
To: fujunjie <fujunjie1@qq.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Alexandre Ghiti <alexghiti@meta.com>, Kairui Song <kasong@tencent.com>, 
	Usama Arif <usamaarif642@gmail.com>, Chris Li <chrisl@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16449-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[qq.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[linux-foundation.org,kvack.org,meta.com,tencent.com,gmail.com,kernel.org,cmpxchg.org,google.com,linux.dev,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qq.com:email]
X-Rspamd-Queue-Id: 2D814607103
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 5:17=E2=80=AFAM fujunjie <fujunjie1@qq.com> wrote:
>
> Hi,
>
> This RFC explores large-folio swapin for ranges that are still fully back=
ed
> by zswap.
>
> Large swapin is currently disabled once zswap is in the picture. Anonymou=
s
> faults stop considering large orders after zswap has ever been enabled,
> shmem does the same, and zswap_load() refuses large swapcache folios. Tha=
t
> keeps mixed zswap/disk cases safe, but it also loses the dense case where
> every slot in an aligned 64K range is still resident in zswap.
>
> The series keeps the policy in common swapin code:
>
>   - zswap reports backend facts and provides the large-folio load helper.
>   - swapin_sync() filters candidate orders by backend range.
>   - all-disk and zeromap ranges keep the existing Kairui large-swapin pat=
h.
>   - mixed zswap/disk ranges stay order-0.
>   - all-zswap ranges may use a 64K folio after locality admission.
>   - anon provides locality evidence from VMA hints and PTE young density.
>   - shmem starts with explicit VMA-hint evidence only.
>   - swap readahead uses its existing VMA/cluster window as locality
>     evidence; it does not also run the anon PTE-young rule.
>
> The backend range probe is only a snapshot. If the backend changes after =
a
> fresh large swapcache folio is allocated, the common path drops that foli=
o
> and falls back to order-0. zswap_load() can also return -EAGAIN for the
> same retry path. If a late fault retry keeps the large folio in swapcache
> instead of deleting it, the cgroup v1 memsw swap owner is committed befor=
e
> returning.
>
> This is mTHP/large-folio swapin. The mappings installed by do_swap_page()
> are still PTE mappings, not PMD mappings. The expected win is fewer fault=
s,
> batched PTE/rmap work, and preserving the large folio across zswapin
> instead of rebuilding the working set as order-0 pages.
>
> Prior art: Usama Arif posted a related RFC on 2024-10-18:
>
>   mm: zswap: add support for zswapin of large folios
>   https://lore.kernel.org/linux-mm/20241018105026.2521366-1-usamaarif642@=
gmail.com/
>
> This RFC keeps the same broad goal, but moves admission into common swapi=
n
> code. zswap does not decide the policy. Mixed zswap/disk ranges are
> rejected before large IO, and the first cap is 64K.
>
> This is a rewrite of the RFC posted on 2026-05-08:
>
>   [RFC PATCH 0/5] mm: support zswap-backed anonymous large folio swapin
>   https://lore.kernel.org/linux-mm/tencent_8B437BE4F586C162950BF71954316C=
1EDB05@qq.com/
>
> The v1 series was anonymous-only and kept too much of the policy near the
> anon fault and zswap paths. This version is rebuilt on top of Kairui Song=
's
> common swapin infrastructure. It keeps admission in common swapin code,
> rejects mixed zswap/disk large ranges, and adds separate locality produce=
rs
> for anon, shmem and swap readahead.
>
> Performance and behavior
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The A/B tables are 10-run measurements. Elapsed values are seconds,
> shown as mean +/- sample standard deviation. "phase" or "refault" is the
> measured refault subphase. "zswpin" counts zswap loads. "pswpin" counts
> swap-ins from the real swap device; pswpin=3D0 means the refaults were se=
rved
> by zswap even when a disk swap device was configured. "RFC 64K" is the me=
an
> number of successful 64K swapins.
>
> The numbers below show where the large path is used and where it is
> rejected.
>
> zram-backed zswap microbench, 64K mTHP, 8G guest:
>
> +-----------------+----------------+----------------+--------+--------+--=
------+----------+
> | workload        | base elapsed   | RFC elapsed    | delta  | phase  | z=
swpin | RFC 64K  |
> +-----------------+----------------+----------------+--------+--------+--=
------+----------+
> | usama_1g        | 11.260+/-0.235 | 10.301+/-0.140 | -8.5%  | -22.2% | 1=
.000x | 16381.1  |
> | nohint_seq64    |  4.398+/-0.085 |  4.025+/-0.022 | -8.5%  | -21.1% | 1=
.000x |  6221.1  |
> | seqhint_seq64   |  4.283+/-0.060 |  3.948+/-0.062 | -7.8%  | -20.6% | 1=
.000x |  6223.5  |
> | stride64_sparse |  3.095+/-0.051 |  3.086+/-0.025 | -0.3%  |  +5.8% | 1=
.002x |     1.0  |
> | random64_sparse |  3.095+/-0.046 |  3.076+/-0.016 | -0.6%  |  +0.7% | 1=
.001x |     0.0  |
> | random64_full   |  4.423+/-0.067 |  4.405+/-0.018 | -0.4%  |  +0.1% | 1=
.000x |     0.0  |
> +-----------------+----------------+----------------+--------+--------+--=
------+----------+
>
> The usama_1g row follows the shape of the 2024 RFC benchmark: allocate 1G=
,
> fill it with compressible per-page data, reclaim it through memory.reclai=
m,
> then time the full integrity-check refault. The seq64 rows use a 512M
> target and 768M of pressure. "sparse" touches one 4K page per 64K region,=
 while
> "full" touches every 4K page. "seqhint" uses MADV_SEQUENTIAL; "nohint" do=
es
> not.
>
> Virtio-block swap device present, zswap enabled:
>
> +-----------------+---------------+---------------+--------+---------+---=
-----+--------+---------+
> | workload        | base elapsed  | RFC elapsed   | delta  | refault | ps=
wpin | zswpin | RFC 64K |
> +-----------------+---------------+---------------+--------+---------+---=
-----+--------+---------+
> | seq64           | 4.399+/-0.100 | 4.279+/-0.216 | -2.7%  | -10.5%  | 0 =
     | 1.000x | 3110.7  |
> | stride64_sparse | 3.103+/-0.047 | 3.119+/-0.086 | +0.5%  |  +6.2%  | 0 =
     | 0.999x |    0.0  |
> | random64_sparse | 3.142+/-0.112 | 3.097+/-0.030 | -1.4%  |  -2.2%  | 0 =
     | 0.999x |    0.1  |
> | random64_full   | 4.473+/-0.147 | 4.445+/-0.088 | -0.6%  |  +0.9%  | 0 =
     | 1.000x |    0.4  |
> +-----------------+---------------+---------------+--------+---------+---=
-----+--------+---------+
>
> This run uses a real block swap device, but the refaulted data stayed in
> zswap. It covers the all-zswap hit path with disk swap configured, not di=
sk
> read IO.
>
> Virtio-block pressure/mixed run, zswap max_pool_percent=3D1,
> low-compressibility full fill:
>
> +-------------------------------+---------------+---------------+--------=
+---------+----------------+------------+---------+----------+
> | workload                      | base elapsed  | RFC elapsed   | delta  =
| refault | pswpin base/RFC | RFC zswpin | RFC 64K | fallback |
> +-------------------------------+---------------+---------------+--------=
+---------+----------------+------------+---------+----------+
> | seq64_full_pressure           | 5.908+/-0.195 | 5.790+/-0.235 | -2.0%  =
|  +3.0%  | 90258/99038    | 20327      |   0.0   | 3730     |
> | random64_sparse_full_pressure | 5.104+/-0.069 | 5.068+/-0.090 | -0.7%  =
|  -9.1%  |  6201/6196     |  1297      |   0.0   |    0     |
> +-------------------------------+---------------+---------------+--------=
+---------+----------------+------------+---------+----------+
>
> This run reaches the disk-backed path: pswpin is non-zero in both base an=
d
> RFC. It is mainly fallback coverage. The RFC does not install 64K folios
> for these disk/mixed-heavy ranges.

Ok this results above look good. Basically, if we don't have spatial
locality in access patterns, we don't do THP zswapin. Nice.

>
> Policy matrix, virtio-block swap device present:
>
> +------------------------------+----+------+--------+--------+-------+---=
-------+
> | case                         | pc | hint | pswpin | zswpin | zswpwb| 64=
K in   |
> +------------------------------+----+------+--------+--------+-------+---=
-------+
> | pc0_seq                      | 0  | none | 0      | 99559  | 0     | 0 =
       |
> | pc3_seq                      | 3  | none | 0      | 99498  | 0     | 0 =
       |
> | pc4_seq                      | 4  | none | 0      | 99512  | 0     | 31=
09     |
> | pc5_seq                      | 5  | none | 0      | 99657  | 0     | 31=
13     |
> | hint_none_random_sparse      | 5  | none | 0      |  6265  | 0     | 0 =
       |
> | hint_random_seq              | 5  | rand | 0      | 99488  | 0     | 0 =
       |
> | mixed_seq_full               | 5  | none | 97725  | 20147  | 84    | 56=
9      |
> | mixed_random_sparse_full     | 5  | none |  6230  |  1302  | 0     | 0 =
       |
> +------------------------------+----+------+--------+--------+-------+---=
-------+
>
> The pc rows show the readahead-window gate. The hint_random_seq row shows
> the explicit random hint veto. The mixed rows use a small zswap pool to
> force disk/zswap split backing; most mixed ranges are rejected, while any
> remaining 64K successes were all-zswap at the time of the fault.
>
> Kbuild pressure, zram swap, 384M memcg:
>
> +----------------------+----------+----------+--------+--------+---------=
-+
> | setup                | base     | RFC      | delta  | zswpin | RFC 64K =
 |
> +----------------------+----------+----------+--------+--------+---------=
-+
> | zram swap, 384M memcg| 2060.323 | 2047.516 | -0.6%  | 0.991x | 2797    =
 |
> +----------------------+----------+----------+--------+--------+---------=
-+
>
> This is a single-run zram pressure smoke. It did not show Kbuild
> regression, and the RFC run installed 64K zswap-backed folios. The result
> should not be read as a tuned-performance claim.
>
> Kbuild pressure, virtio-block swap device, 512M memcg:
>
> +-------------------------+----------+----------+--------+--------+------=
----+
> | setup                   | base     | RFC      | delta  | pswpin | RFC 6=
4K  |
> +-------------------------+----------+----------+--------+--------+------=
----+
> | disk swap, 512M memcg   | 1420.671 | 1409.263 | -0.8%  | 0      | 7497 =
    |
> +-------------------------+----------+----------+--------+--------+------=
----+
>
> This is a single-run pressure smoke. The disk-swap Kbuild run also stayed
> on the all-zswap hit path, so it is pressure coverage with a disk swap de=
vice
> present rather than proof of disk-read large swapin.

Why a single-run?

>
> Shmem smoke, tmpfs huge=3Dalways, 64K shmem mTHP:
>
> +----------------------------+---------------+---------+-------------+---=
-------+
> | case                       | refault hint  | touched | 64K shmem   | 64=
K in   |
> +----------------------------+---------------+---------+-------------+---=
-------+
> | nohint_seq                 | none          | 65536   | 4096        | 0 =
       |
> | seq_refault_hint           | sequential    | 65536   | 4096        | 40=
96     |
> | random_refault_hint_sparse | random        |  4096   | 4096        | 0 =
       |
> +----------------------------+---------------+---------+-------------+---=
-------+
>
> That matches the current shmem producer: explicit sequential refault hint=
s
> allow large zswap swapin; no hint and random hints do not.
>
> What this RFC does not establish
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>
> The 64K cap is deliberate, but it is not tuned. The anon PTE-young rule i=
s
> only anon evidence. Shmem has the framework and explicit VMA hints in thi=
s
> RFC, not a page-cache locality producer. For larger orders, the anon
> producer should probably use bounded sampling instead of walking every PT=
E
> in a 1M or larger candidate range. The mixed-backend tests cover fallback
> behavior, but this series does not add mixed zswap/disk large IO.

The mixed IO can be deferred, but I think we should figure out a rule
to extend this hint to arbitrarily sized ranges, and preferrably shmem
too.

