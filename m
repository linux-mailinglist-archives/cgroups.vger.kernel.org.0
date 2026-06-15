Return-Path: <cgroups+bounces-16928-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7pY0Os5lL2rr/gQAu9opvQ
	(envelope-from <cgroups+bounces-16928-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 04:39:10 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E39DB682E88
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 04:39:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CqETO93q;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16928-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16928-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D305330015AC
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 02:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82D82472B6;
	Mon, 15 Jun 2026 02:39:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C1D23A562
	for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 02:39:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781491143; cv=pass; b=dM/1vTSCoefDQTqoG6f1LenmFuwXfuvdyG1wnN0FN/ybf+NsU325e+BCSCDIn2iIsBIInPEvKTZuJEYLa+4hWarxOwlPBUKjKWJbnQA9lIDZxtjm3uK/QpNZE+LI9hVdJ2JhOelkjXipi1hRhrzZO/ohxVpoYewZVTDXJR65ppA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781491143; c=relaxed/simple;
	bh=+xkvswWssXAT8denUuRCSRjfQGkLxmmDf6B7hcwxK1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RrnGe265ljGYU07Y09Zll3Ay/QOtdAthJZDQjaKJOX7bDuTWA+3vdmRauVq9ME4HIkJFx5uQbwTEW7l52uLKxCHIFpY3OjSfYJj7VLavyQnNOBC3x3lRl/akHSohmnlITTTF2FS43DHniGF+SMy27jSXHPab81hIGNRVG1OH4rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqETO93q; arc=pass smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490ac10e337so18719915e9.3
        for <cgroups@vger.kernel.org>; Sun, 14 Jun 2026 19:39:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781491140; cv=none;
        d=google.com; s=arc-20240605;
        b=bETT9sbHv/M8ekXipCZSLN6QooO7GU4wCNb48GRUcDTQY6ejLg4Q4W7tuUlf5lazDC
         aEs/lPljQrR4eh5sIkTxBDsdCpWJCcHiq8/Hg6i+7FOf7IxdaHiv+TJ90hWoRo/Fu+xa
         DZem1c8GaCQdQ9Hx/7KQ3uH52OIpZrnfH1hHP9JHvEVoAlwuFU5Lj2hr7isTTBNB43km
         39J4MZg7fypM2VVvEC6Jtdjr47Gai3bcS8m4Ojf5Ali2Ca+yKaHBp8wctwJVCsHPZx0p
         M1J/CTAn3ytvqCNSQ4cLqUttIo1Ckpr8pCGbRW9ANL1qyjkoOof29Zs6oLI9I1VWkjUr
         Ojlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OM0sP7wWVTQptCkIXgFOHkZiGuvJwwRHDUE5S5OI/2g=;
        fh=hL5e/4xiN4CcQCA63EpM97adm+3nDPs0bNL/1Pz/fdA=;
        b=c4Q9XRZurEcyPBMy0C4fbc7ghN7FzL1jWfLjnoY3rdHaSBZlZ98/gAr7iui5WURebJ
         Y3cG1hH7HWTaXY+XJW/6JRD7wNh+1pD71SfufQ5xfWpWgfMmd2R+J9E2MIJC3eS245I5
         z1DY7gPW6litTHdGrovkKKM0XZY4Zg2GezbZG+6QRqDgHUy8xgLgl85qi2M97BuTDPhM
         gFCrZixmaXw2WRgSbEF2AlShOD4ScgBYMVc6q9T8FAiTf3Jt3wy0G3OuoqM6vI4ZcZnE
         dEAFNePfBlA2Hz/CSoMY6l1XOY/uq2lH1j/lN9+eqXM88k/fpLKTkbgz+9J+YUsrEm+B
         E+pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781491140; x=1782095940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OM0sP7wWVTQptCkIXgFOHkZiGuvJwwRHDUE5S5OI/2g=;
        b=CqETO93qwDSTGM5cFLxxBW5AnqFZuzSr0ANjlxvYGoIcfgh0BQp8vsFmCyKVZkICkt
         X10sPalFNsDNGaK2u+WAe3mkUgvpOpCSsnGBm4P2UGEeR5Xr2cBgZ6k/E8QJK2PI63nw
         nQBQzFLntAafhc/gzSZwAPMb3XfI822JB1eqnEPRYMnCed4ocdSIgRhj4FoiMHHzCH1d
         YbxUpq49JbY6JqqVchKH/GkovnpO7Pv7ga3cgYwLJtluKB6FsblXNRHUJCvvjYgWfM50
         m7HXphH0bHE/HyY+GbhSnbqTBK2Falq4hrbiqePRiXA7ugfREoj1jD87RDnZZyAv5iYY
         tUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781491140; x=1782095940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OM0sP7wWVTQptCkIXgFOHkZiGuvJwwRHDUE5S5OI/2g=;
        b=LiFrYVPgOE/j9IQV0kCGrsSxtxgX41zJofHVmoOCYW0t6PgIC8bvWFayOT8O/cIIK2
         uI1mwk3x6AGksSXWte7n2SSNbN0Os6zxQFn1lBZ0fBeA5ONx+HU/MfWWHOYx5gU4nPvK
         gT5ovFtC6PXbhra+vUORMNovv/OfGSrMX4SfxBPxX2CywVhUctlAHD2twKniH7HvSjV7
         63G/RWP0KDrptokxHZGlv9b82rFbnU+WEokmgMuOYjVTyGXRhrOUGkp5qf34iCz4rzgM
         BIxix1MGFZUA2XflZ5zwzNn8h1Nf9kN1ZSeWXKdbkdJ1tBprTORxQh2R9tQdl7RusUcH
         zrxg==
X-Forwarded-Encrypted: i=1; AFNElJ/lVdfmGZkqna9IAcAG/56PAIcj/OjgYVz8tRv0XNPxxHoZ2cIrl7oj+LtG4j0UbNPR5HaLqQMC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3A2aIm0QHDui7K0e36fn+Wx0hyED8smoeBtkex0D/e2NwaBXl
	pN/4UpRYePlTpBaAbYop1gdzYJHGCTZf9dRf7wQKvDcJDO0eMqjvzcAWUuRBmzUgnJAO5SNJRDE
	VFvz6VsUdT+5uqelOwP2xTWUJdMdFo10=
X-Gm-Gg: Acq92OEgnOv4VzVql7kReIbZoqUg+JQG4LiNctIn+uHfBjvf9ZgM76psWClBM4uRjxq
	Qca8JwvX79tXLmlfog9E7+7ncRI2LFKE+OocpwbQe4tLejuhQJEeX4jak8d8OCn9lzO2b/3i+oR
	zCA1cT2WzFAh7pyMxTIKj5gGwV4YLv+/Dh2Jbus5E0vQC1C9GWQYXZtNNu+e6aGrL9/7uYS9uWt
	bQ0HjOIg7po2+H5wJ8Z7MJwkuTEeVfK4AreB9nAL/c1y7BiRxq+n2MkPmu1pjtQ08NgZ0kyZmYB
	n3RzWvyVyLWl6YlJI0AGcrxzdNK4rDpw7KFuYQ==
X-Received: by 2002:a05:600c:1d06:b0:490:b8e6:be40 with SMTP id
 5b1f17b1804b1-492200c01c2mr118630585e9.21.1781491140502; Sun, 14 Jun 2026
 19:39:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612193738.2183968-1-nphamcs@gmail.com> <ai5kOOmR1LPTWs1J@yjaykim-PowerEdge-T330>
In-Reply-To: <ai5kOOmR1LPTWs1J@yjaykim-PowerEdge-T330>
From: Nhat Pham <nphamcs@gmail.com>
Date: Sun, 14 Jun 2026 22:38:49 -0400
X-Gm-Features: AVVi8CdL1KZfURrMHERaHUdEggMOH7tTPmf0sRtg1e0zJOWDwYMtBzIdo0u3nJk
Message-ID: <CAKEwX=O23a4iWBZoewKVb8QqODte6r3Xijckw3_oCJNoiO9M5A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/7] mm, swap: Virtual Swap Space (Swap Table Edition)
To: YoungJun Park <youngjun.park@lge.com>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, kasong@tencent.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, yosry@kernel.org, david@kernel.org, 
	muchun.song@linux.dev, shikemeng@huaweicloud.com, baoquan.he@linux.dev, 
	baohua@kernel.org, chengming.zhou@linux.dev, ljs@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	qi.zheng@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, riel@surriel.com, gourry@gourry.net, 
	haowenchao22@gmail.com, kernel-team@meta.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16928-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:youngjun.park@lge.com,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:yosry@kernel.org,m:david@kernel.org,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:chengming.zhou@linux.dev,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:qi.zheng@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:riel@surriel.com,m:gourry@gourry.net,m:haowenchao22@gmail.com,m:kernel-team@meta.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,infradead.org,google.com,surriel.com,gourry.net,gmail.com,meta.com,kvack.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E39DB682E88

On Sun, Jun 14, 2026 at 4:20=E2=80=AFAM YoungJun Park <youngjun.park@lge.co=
m> wrote:
>
> ...
> > * Integration with swap.tier by Youngjun (see [12]). For now, I'm
> >   leaning towards opting out the vswap device from swap.tier entirely, =
and
> >   treat it as a special device. Integrating it with swap.tiers will
> >   benefit the cases where you want some cgroups to skip vswap for fast
> >   swap devices (pmem), whereas other should go through zswap first. But
> >   most other use cases, either the overhead of vswap will be acceptable
> >   (or not the bottleneck), or we can just disable CONFIG_VSWAP entirely=
 :)
> >
> >   Youngjun, may I ask for your thoughts on this?
>
> Hi Nhat,
>
> Tier 1: VSWAP, Tier 2: ZSWAP ...
>
> I don't see any problem applying the desired functionality with the
> currently proposed mechanism and interface. With this, a user would be
> assigned the default Virtual -> RAM swap tier, and the overall picture
> becomes one where swap tiers are composed according to the priority
> setting.

It's more - is there a strong argument to let vswap be a tier (which
is not supported by just turning of vswap altogether).

Because right now I'm not exposing vswap device to userspace in any
manner, pretty much. It's abstract and transparent, and minimizes
complexity (no vswap and swap.tier interaction) and surfaces for
issues.

But if you have a strong use case in mind please let me know :)

Worst case scenario if we're wrong, we can always do it as a follow-up
down the line.

>
> A few more thoughts came to mind.
>
> Shakeel also proposed a per-tier max for the swap tier interface.
>
> https://lore.kernel.org/linux-mm/aiw2p5ANjsQUCIHA@linux.dev/
>
> However, for vswap, rather than treating it as a case for limiting the
> amount via such a per-tier max, I think the current interface is the
> better fit. (But, as Shakeel mentioned, if we only allow the limit
> to be set to 0 or max, the usage could end up being the same. I'm still
> thinking this part through.)
>
> I have a few other thoughts as well, but I plan to raise those points in
> the swap tier discussion thread instead. Please take a look at the
> related thread, and let me know if you have any opinions. :)

I'm following that thread too. I'm still thinking about it - will let
you know when I have a more definitive opinion.

