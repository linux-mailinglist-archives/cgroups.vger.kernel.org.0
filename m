Return-Path: <cgroups+bounces-15334-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHnACcIu4WkdqQAAu9opvQ
	(envelope-from <cgroups+bounces-15334-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 20:47:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E60413D91
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 20:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ACF113019398
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 18:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E10C348452;
	Thu, 16 Apr 2026 18:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AS2JxY6A"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637F8291C10
	for <cgroups@vger.kernel.org>; Thu, 16 Apr 2026 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776365243; cv=pass; b=A9JHHga3jmtzkQ0U8d2qk8HzV5eG06YPXbs8ZS4vnfpc6Lgd0Em9YZSMAljFibZBlaR4J8rSC+fC65wwjbKj5OeoyftKRC9rNKceEs9dlNjpA4bxQt2sEKHtYYol2t7g9dgHA1QXXRZeSaj5Kv5HwVwoedgKzpF1JcUCAvGKOz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776365243; c=relaxed/simple;
	bh=fV2yQdpPdBSM0JKi/3hIXKAc4W3UmbJU7CKjv7sEIcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ORxLBKIVjHSlFMzae/rPR4GQq139C9u1di9JZT7KtK/w96Ot3E4dR+xaioIHkQ+3zjs6O8E7DAjmWFqasL/LNX5LsvtmYXwlCE9xXVumGyJDBrFkgEWadlU6pYXUR3FwUhmQiKEkjmlDO7AB5iL1hSmHvtWevJsljfO5LwnWnUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AS2JxY6A; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-671ab90fc1fso7744640a12.0
        for <cgroups@vger.kernel.org>; Thu, 16 Apr 2026 11:47:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776365241; cv=none;
        d=google.com; s=arc-20240605;
        b=WdB+Krv4hVavk/78L8bbLixwUg4LU9ZZSXgQMH3yqKcKij2ndAxCOGA0y3GemHZ2te
         4msOf7s+6dGZm/4nwKSJ4PY3WpYyPIoZLG1OxKMvmWdX5T8XfEzedzsB+iMafYVWK6ks
         aZh1svnw+wE8NWHJShWIrZI/23sNz8lTIdhe02WoBKpTlGnNP7zBJLUCgfgxW2u7TWqT
         IgtG7wBYKfUDRYDU7CBpP1uygwbk4GPS1ds8lja4xXCrJyAbFGHSK8k0EMSYhv15xVjN
         e+wxC6aOgb+DuYa+S2Oe9YiJtcY62VQiTdzzlBX48SJfhY28XfMwi7v7kI3QsZeZrXTA
         Qceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fV2yQdpPdBSM0JKi/3hIXKAc4W3UmbJU7CKjv7sEIcs=;
        fh=Nb1WZlP9iiIlaJuFJ4cpy8L4e92p7uVZ8R/F88fSnV4=;
        b=UkBYk7IXow22Jzcbp9rwPDwPSbRbqNTMEifvRvHTP4d0dA+mOCScILNSYGVDRMPbnU
         TkjxqrhiWMitjW+/U5CRtGbfQ9MnxMDN0pbRrKhhV5LhIbSglcNPJNx+yMkDaaeE7H0Z
         lW1MVvExV7AgA2wWyeB/0dyeAG1UT1kE3dgUhkZ7pCH0Gy10HUTHuMVpvbkbjz/9NZVC
         xgiInydvGWAbMXYicD7FpJEg09raASM/9Aiw+nGEEN/kQEzIzmjj5M/EjNf6h8fJ5ndc
         IktGS3fLc5SG4ECcHH5NtV0zwalI0FAQIWWWNXyhSoyQ5xJOSGIDIUWitWTIgHr3zxPU
         4i6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776365241; x=1776970041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fV2yQdpPdBSM0JKi/3hIXKAc4W3UmbJU7CKjv7sEIcs=;
        b=AS2JxY6AqH78LVAAiyxMbMhBYBAA1WfWIdagz413k3sjQv5uvHoY4/I1fOx6K5kVRS
         iki/0jo/s2DQdF36k1ouFk7Izut/dxJWqN3ggoej+VZzeaNphDL9FDZaKbywTHh7o3r+
         8+KBoNbUiMjsgoAN/6YPbSKxrqEsvwhww2otklYuyN367Z9ZJUtTvBQpNTmxJaa4Jlck
         Nq3HJ7J4VGcRkRsfFWabc247+Z8RLhbOJMG3a/NqXM/b0jvsLekYYIdtaKJEwyyPkPoq
         Q2KqFTFDZXgUSoqvrfM2jMYJQTVzql2nYM+ee0C4dk1D9XT1oQBkiCO/OusfKEDnb5i9
         VvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776365241; x=1776970041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fV2yQdpPdBSM0JKi/3hIXKAc4W3UmbJU7CKjv7sEIcs=;
        b=bztEyCnT1XrzzmyKitcV/9TCxhhcktkShFfhMB2VdoneecrToBgCn7xUhb7dgLWA4K
         bJpkymceps07NDIIyFgbBIhlJOFE0MbauWB+ICRK+0n/phLTawwB4KD3t92kxLlw5aO/
         iiLP++65eIcSDTH6RmgW+H5nxpvTWSbAxtc0LeXK50BUnFXIV9xZuFDThPwmmZnZtYD0
         iH6MnIIRlEwz9rPf8qIZGtIXaftmzVfJwEN59m5PiKWkNy+uAKzPJqChZhXbHkdRfflm
         z9xMuaLxvAoIMl6Kwh8gMM5d9RPfGhgQ9TauBr8cZcDxNg/L9odbVU4Q18ms2cvNVUIo
         0Q2Q==
X-Forwarded-Encrypted: i=1; AFNElJ/NqybDZMgg28oKpR+Ica+5HVUWE0sIXmryFECKz6qu4KhEO6VpJkyeRXRWzy01f2efT4VPyWlD@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhl06keeWN3e184ktF2tlVqoGpCDpaBvci5r4ag7HNjTuLdz7V
	2zUaKBABvjjRIMjEBxpZeBbgukjUlIeV6YCMGL5eCN64LF3crg+H2mmF2wyP02QORJiYoP5hEMz
	2ov0bXYX2JPQf45yYJfzLiOSyTJ4RwYU=
X-Gm-Gg: AeBDieunigSqjvAV+Jc+sWmYCjmpoResPZR21LjzL8LO2lsBB3Gy+B6fAXXmol677UM
	DHB6hgXCGNr9XO3r7V8KdV58cfPWGK9ueGb5rmT/B4SZklGK2zzzKJuX6b8VSKn5oH0qnC3yDfL
	tAeBepTARkqVcaoZLeKZcBNdN1EiUxAsxNo4pRPaDCiX3It5SF0czYSFzbLCrUX51OeyYPfYZqm
	qx5ljRp6BGE3pyRpg/mzyt6QVp7L5xTXSs4J8yD/7kiHrkEmiK2eGAiOk6OJ9jWO2vglNQhw8q9
	O4eiIg+8F3BI8RUbjKeqpqScldNJZSSI2dHxg5FOG/NoEA+6HDE=
X-Received: by 2002:a05:6402:3513:b0:670:8b30:a8a7 with SMTP id
 4fb4d7f45d1cf-672bd216aefmr183464a12.0.1776365240497; Thu, 16 Apr 2026
 11:47:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320192735.748051-1-nphamcs@gmail.com> <CAMgjq7AiUr_Ntj51qoqvV+=XbEATjr7S4MH+rgD32T5pHfF7mg@mail.gmail.com>
 <CAKEwX=PBjMVfMvKkNfqbgiw7o10NFyZBSB62ODzsqogv-WDYKQ@mail.gmail.com>
 <CAMgjq7AzySv801qDxfc8mEkEsFDv4P=_qw0rNOTe0n+qy7Fz6A@mail.gmail.com>
 <CAKEwX=P4syV38jAVCWq198r2OHXXc=xA-fx1dk6+qYef6yzxWQ@mail.gmail.com> <CAKEwX=NrUhUrAFx+8BYJEfaVKpCm-H9JhBzYSrqOQb-NW7QRug@mail.gmail.com>
In-Reply-To: <CAKEwX=NrUhUrAFx+8BYJEfaVKpCm-H9JhBzYSrqOQb-NW7QRug@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 17 Apr 2026 02:46:42 +0800
X-Gm-Features: AQROBzCEgUiZi2O6FzTs1ms_GwJiz6hkD3Or1x7kVqF5Vc65bqWpNQK9z7Fsc8M
Message-ID: <CAMgjq7DJrtE-jARik849kCufd0qNnZQs7C8fcyzVOKE14-O+Dw@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
To: Nhat Pham <nphamcs@gmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, apopple@nvidia.com, 
	axelrasmussen@google.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	bhe@redhat.com, byungchul@sk.com, cgroups@vger.kernel.org, 
	chengming.zhou@linux.dev, chrisl@kernel.org, corbet@lwn.net, david@kernel.org, 
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, 
	jannh@google.com, joshua.hahnjy@gmail.com, lance.yang@linux.dev, 
	lenb@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	matthew.brost@intel.com, mhocko@suse.com, muchun.song@linux.dev, 
	npache@redhat.com, pavel@kernel.org, peterx@redhat.com, peterz@infradead.org, 
	pfalcato@suse.de, rafael@kernel.org, rakie.kim@sk.com, 
	roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com, 
	shakeel.butt@linux.dev, shikemeng@huaweicloud.com, surenb@google.com, 
	tglx@kernel.org, vbabka@suse.cz, weixugc@google.com, 
	ying.huang@linux.alibaba.com, yosry.ahmed@linux.dev, yuanchu@google.com, 
	zhengqi.arch@bytedance.com, ziy@nvidia.com, kernel-team@meta.com, 
	riel@surriel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15334-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_GT_50(0.00)[53];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E6E60413D91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 1:23=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
> Hi Kairui,
>
> My apologies if I missed your response, but could you share with me
> your full benchmark suite? It would be hugely useful, not just for
> this series, but for all swap contributions in the future :) We should
> do as much homework ourselves as possible :P
>
> And apologies for the delayed response. I kept having to back and
> forth between regression investigating, and figuring out what was
> going on with the build setups (I missed some of the CONFIGs you had
> originally), reducing variance on hosts, etc.
>

Hello Nhat!

No worries, I was also thinking about submitting some in tree test for
that so testing will be easier, but got really busy with some other
issues, series and the incommong LSFMM, will find some time to do
that.

>
> 1. Kswapd is slower on the vswap side, which shifts work towards
> direct reclaim, and makes compaction have to run harder (which has a
> weird contention through zsmalloc - I can expand further, but this is
> not vswap-specific, just exacerbated by slower kswapd).

It might be related, e.g. could the dynamic alloc and RCU free of
vswap data cause more fragmentation hence more pressure?

> 2. Higher swap readahead (albeit with higher hit rate) - this is more
> of an artifact of the fact that zero swap pages are no longer backed
> by zram swapfile, which skipped readahead in certain paths. We can
> ignore this for now, but worth assessing this for fast swap backends
> in general (zero swap pages, zswap, so on and so forth).

Hmm... That just brought up another question, you can't tell the
backend type or properly do readahead until you look down through the
virtual layer I guess?

> I spent sometimes perf-ing kswapd, and hack the usemem binary a bit so
> that I can perf the free stage of usemem separately. Most of the
> vswap-specific overhead lies in the xarray lookups. Some big offenders
> on top of my mind:
>
> 1. Right now, in the physical swap allocator, whenever we have an
> allocated slot in the range we're checking, we check if that slot is
> swap-cache-only (i.e no swap count), and if so we try to free it (if
> swapfile is almost full etc.). This check is cheap if all swap entry
> metadata live in physical swap layer only, but more expensive when you
> have to go through another layer of indirection :)
>
> I fixed that by just taking one bit in the reverse map to track
> swap-cache-only state, which eliminates this without extra space
> overhead (on top of the existing design).

Isn't that HAS_CACHE :) ?

> 2. On the free path, in swap_pte_batch(), we check cgroup to make sure
> that the range we pass to free_swap_and_cache_nr() belongs to the same
> cgroup, which has a per-PTE overhead for going to the vswap layer. We

This might be helpful:
https://lore.kernel.org/linux-mm/20260417-swap-table-p4-v2-8-17f5d1015428@t=
encent.com/

I observed a similar but much smaller issue with the current swap too.
Deferring the cgroup lookup to the swap-cache layer, where we already
grab the cluster (in a later commit), should reduce a lot of overhead.
It requires some unification of allocation though as shown in that
series, things will be much easier after that :)

> Anyway, still a small gap. The next idea that I have is inspired by
> TLB, which cache virtual->physical memory address translation. I added

I think this is getting over complex... You got a mandatory virtual
layer, which already comes with some cluster cache inside, and the
lower physical allocator has its own cluster cache, and then a new set
of cache on top of the virtual layer?

>
> Some final remarks:
> * I still think there's a good chance we can *significantly* close the
> gap overall between a design with virtual swap and a design without.
> It's a bit premature to commit to a vswap-optional route (which to be
> completely honest I'm still not confident is possible to satisfy all
> of our requirements).
>
> * Regardless of the direction we take, these are all pitfalls that
> will be problematic for virtual swap design, and more generally some
> of them will affect any dynamic swap design (which has to go through
> some sort of indirection or a dynamic data structure like xarray that
> will induce some amount of lookup overhead). I hope my work here can
> be useful in this sense too, outside of this specific vswap direction
> :)

Glad to know things are getting better! We can definitely work
something out. But besides the problem above, I think there are some
other concerns that need to be solved too. Good part is I think
everyone agrees that some kind of intermediate layer is needed.

