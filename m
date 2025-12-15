Return-Path: <cgroups+bounces-12355-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7EDCBCF65
	for <lists+cgroups@lfdr.de>; Mon, 15 Dec 2025 09:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 065C33006737
	for <lists+cgroups@lfdr.de>; Mon, 15 Dec 2025 08:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA30930C36B;
	Mon, 15 Dec 2025 08:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apngKUST"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E384C23D7CF
	for <cgroups@vger.kernel.org>; Mon, 15 Dec 2025 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765787384; cv=none; b=nvB+rY7laeOvTllG20I/s9raa0qlhqUClsQ07gYsVIlbon4HCYt7juQ0Yh+E1BNHs/NxaX/FFYCTfAhDuV2W399kY4nTfN/doZAjwq24xkw9YhI0IAhjfGdxb5fAimB33F/Ko7Q/bmT8fRCUeDjeS/31O+avI8gavbMrT62vg+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765787384; c=relaxed/simple;
	bh=8+Rae6Tnr4feXWnwHZ1+C9t7FYdcdoho4X2n1jA93Ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oPKmmyDdhxpUlAABaFUMd5m8fuLj/K5A/ewmeiVYcpG1e+nj3OBNMS6gjBWTtHZ819ZiKc5x44Op3alxZoRDNkqr5OL1w21AEA8p1wqdl63W0B5q+2TJN4aLRa0O+XyRd6K5QQy5aMsQD8yCgUFkqCN7Ea/XFrhGVEQ13HGQYZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apngKUST; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6419b7b4b80so4774652a12.2
        for <cgroups@vger.kernel.org>; Mon, 15 Dec 2025 00:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765787381; x=1766392181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+Rae6Tnr4feXWnwHZ1+C9t7FYdcdoho4X2n1jA93Ws=;
        b=apngKUST5fwxpvTXrBxqjfv0fMcZjzLAqSefJDl/gnyaVXDoKlSrK+yE23Darnu5nm
         AGYnhkiridTJCx1T5emYVTsOMgBsLMMWiNh0Q1xG2+D1gxSnzRM3hVEI3UvwX3+YkLH/
         WKcFeaYKq0yhLA/did60G6XPaADD9SUyCEKgrNcJ57j0OnQjSwUFDi2ZWFoiYwii2cqd
         4IHGCpWbsrQow/wQADnjx0jt/gwgZJwBBnYih24lP0/C9/31qBvlboeBObqDgUvaCX5+
         oILGgV1+zuubAPYUBVLx3oHFQiCgAF6UbrXrONAPHmJewy+cfRkRvpUsWcbUpEj4tjVA
         ZpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765787381; x=1766392181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8+Rae6Tnr4feXWnwHZ1+C9t7FYdcdoho4X2n1jA93Ws=;
        b=LKsBpH7H1Bsowp5RoIAYXWcobE//9Urb0y0Kd8dRZ/P1rTpla3zMlADYYLk+OBY/O7
         Rhk3Ds6qW2TCdp8cGRTI/u56YZYz51FkPSh+TaLECvMAP7UGudTQW7lLFl/FrrNbfp2T
         fWpk2BuuzRl9iliyXetfDTO/jd4xs0V42iyP1qrU+QRoXYlnWwNPZskTvRQEQWF4KCXX
         deFJ8z+RkVhnN4fCz0Qtlqs0paG9byFyVcbE7lKjtSy5af8HR9QTdC+rowjXuq11LEMI
         LlnwSwMS4mjhHJTWFeTWwWXwBt//ELdZKrLQVnTNJ2sFM5rgMFOJ6ch/v6tW8e4U+Tr1
         BCYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbrvisll6RcxhzkY62292P6a/H/1CWq2NPvthxypvjXtlnDW+x0nH831q+cFBUD+mpmdeXpb2t@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0EQPobLkgCbMNSYjFlpmgj9Il1ZCjkLXMJJDHJiPBv+BWJ0QS
	mjioHmqN+V0vQSyBHoCATooyWa1lLiMwVOndYXjV40+Ga3JnMhGf+8DOkQzydHBw8Falx+DCVt0
	xGQEKpYMIMo3Quh6hfn8GQ51QBl3QO0A=
X-Gm-Gg: AY/fxX4ysGJaky+O4VjlQVMT9J/OmFSkau5XgYvCagosLHkOSHQe2jplrr03zmsk6Xd
	d7sC016c0xBgAyUx2F10Tn37yr28/lq8Wn5VOFhHAtyrNUDG2at6O43ZGXa6mqaAPB73kZbmpnM
	jIDbexvMcF0O8a6AsESlIEYU1cbGr42h9k7u0H31RjXRM1yoP6XPwMrkC0ulfxsP8xuPTTumpsw
	kidiC1VFXlzdDPQ3ls28tWpnpHl7SHwAZzGcHYN9gpUxuZGNfaZVs+2K0RP9lKYP2npke/Qj/4y
	ocyageWH/xOydBb58MP/zSk6zZo=
X-Google-Smtp-Source: AGHT+IGRqBc8I0NflOBy3oliVc/I9u/bSrqvpBXQ6UEvCCiezx0ILL3u1RZnZngtw+U69waTs51EIwa6S1lhHAPjrOk=
X-Received: by 2002:a05:6402:4407:b0:645:d34b:8166 with SMTP id
 4fb4d7f45d1cf-6499b3009abmr9662602a12.26.1765787381139; Mon, 15 Dec 2025
 00:29:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215-mz-lru-size-cleanup-v1-1-95deb4d5e90f@tencent.com> <3edf7d6a-5e32-45f1-a6fc-ca5ca786551b@huaweicloud.com>
In-Reply-To: <3edf7d6a-5e32-45f1-a6fc-ca5ca786551b@huaweicloud.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 15 Dec 2025 16:29:04 +0800
X-Gm-Features: AQt7F2pC9l-pkB50oh7wNbFDZA--Sp8cR3PR99yyO6YmYauKOUVymRwEZdki-V0
Message-ID: <CAMgjq7DVcpdBskYTRMz1U_k9qt4b0Vgrz3Qt5V7kzdj=GJ7CQg@mail.gmail.com>
Subject: Re: [PATCH RFC] mm/memcontrol: make lru_zone_size atomic and simplify
 sanity check
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>, Hugh Dickins <hughd@google.com>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 3:38=E2=80=AFPM Chen Ridong <chenridong@huaweicloud=
.com> wrote:
>
> On 2025/12/15 14:45, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > commit ca707239e8a7 ("mm: update_lru_size warn and reset bad lru_size")
> > introduced a sanity check to catch memcg counter underflow, which is
> > more like a workaround for another bug: lru_zone_size is unsigned, so
> > underflow will wrap it around and return an enormously large number,
> > then the memcg shrinker will loop almost forever as the calculated
> > number of folios to shrink is huge. That commit also checks if a zero
> > value matches the empty LRU list, so we have to hold the LRU lock, and
> > do the counter adding differently depending on whether the nr_pages is
> > negative.
> >
> > But later commit b4536f0c829c ("mm, memcg: fix the active list aging fo=
r
> > lowmem requests when memcg is enabled") already removed the LRU
> > emptiness check, doing the adding differently is meaningless now. And i=
f
>
> Agree.
>
> I did submit a patch to address that, but it was not accepted.
>
> For reference, here is the link to the discussion:
> https://lore.kernel.org/lkml/CAOUHufbCCkOBGcSPZqNY+FXcrH8+U7_nRvftzOzKUBS=
4hn+kuQ@mail.gmail.com/
>

Thanks for letting me know, I wasn't aware that you noticed this too.

From my side I'm noticing that, lru_zone_size has only one reader:
shrink_lruvec -> get_scan_count -> lruvec_lru_size, while the updater
is every folio on LRU.

The oldest commit introduced this was trying to catch an underflow,
with extra sanity check to catch LRU emptiness mis-match. A later
commit removed the LRU emptiness mis-match, and the only thing left
here is the underflow check.

LRU counter leak (if there are) may happen anytime due to different
reasons, and I think the time an updater sees an underflowed value is
not unlikely to be the time the actual leak happens. (e.g. A folio was
removed without updating the counter minutes ago while there are other
folios still on the LRU, then an updater will trigger the WARN much
later). So the major issue here is the underflow mitigation.

Turning it into an atomic long should help mitigate both underflow,
and race (e.g. forgot to put the counter update inside LRU lock).
Overflow is really unlikely to happen IMO, and if that's corruption,
corruption could happen anywhere.

The reason I sent this patch is trying to move
mem_cgroup_update_lru_size out of lru lock scope in another series for
some other feature, just to gather some comments for this particular
sanity check, it seems a valid clean up and micro optimization on its
own.

