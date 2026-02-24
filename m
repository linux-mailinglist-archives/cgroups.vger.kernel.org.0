Return-Path: <cgroups+bounces-14199-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMerAXAcnWmPMwQAu9opvQ
	(envelope-from <cgroups+bounces-14199-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 04:35:12 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AC418169D
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 04:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A1B7303AB5D
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 03:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D69F2571DD;
	Tue, 24 Feb 2026 03:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUrR+gqT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EC31E8823
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 03:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771904107; cv=pass; b=OOl/KG38XumryTayaSG4aGzsdS4pmEb+MUYJcS34AR5zssAUuQIFac3UMcMwH5tT3KNRWOihE/Ehz+tpH+ldyB6P6E/vhX4082jRDTU6MUJlY0snxdWz6h1EQ1m3tu6CaRakhzlcEeE6DN4kdGaBOL8J3TC2M+W1gjwqZ4LQduE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771904107; c=relaxed/simple;
	bh=B8ofdhItcgvN4Iz40blzcPKIP5RRme/D6mzPbzVWtPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLXRwaaWvg7/NiPVfk507gkPBAsZ+brcPtcT2GxmUIAfxoc+AxBr6b98cxiQg3kWgiWYwP1yhuaJ3f9NBFhZmVny73VB41ydAvWRM/AXhjIGmxL/IQSUsrFrStyhtaM7MddrrTnycMpplwPhJbTHZhnixR3tsw0xExK+d3NJ9pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUrR+gqT; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8871718b00so812102466b.3
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 19:35:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771904104; cv=none;
        d=google.com; s=arc-20240605;
        b=eIO5+Q+6atv/eeAQb2oco2acAJ4SLvbC0qqjNft1jlsr9KKYGsC3Fxz0F4DRPRFx7/
         wcPdFXvIyimoZDSDqDS05UgfH+mQCnvHEtVIHPVinOpLsxLavbeGuubbp4gk5MDLv2/c
         w5ugbZM/DZM4yDPwJcEzzeLEJ9KBYQ1RFaMWFfL0ej6bZgxvqZkj9/kRcHkVqJ0M7QTI
         6VhKPaeJL+cqO2nYGQjoBsE8e59DIX2LsGW2bpo699CUdxUn13sAZXNUlxcwn4rBCvQr
         5mbV+Zs3PZkyBvmkmz9R/1M/l6eD4pFfJLSxytv/4WKYzqqp16jh9CUp2zN+yjk8JQDl
         Rimg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pzOdDteQ7ZLurHZwTqbft5SWZRf804LGh7Y3eqQaNZU=;
        fh=6tpJou8RSx5tzDY2V5yxaI+ENG2SslwG8i039nwhAsY=;
        b=Dbg6M85nLwxE4uLKLCjD4mRrinOecrkx5DkVAqz6luD0TL/CfS2SDtXFIcY2hUgycU
         x9kqq0umHNSD11S8XG4n6VydfpR2V1V1HaijZhjoVnzbPFjgjQ88v6TplSaf1pga8+OT
         knc9QpGYn3IzNv7uzDYm9aM8EFv4U3ws2uVHl79dWYQy0oiEtTMSTek0qrKRBVAtsyze
         FhILrmJTajci4m/fPhItSoYOa0AVYRY2TB1uTw2nCFAro6RszJW8bBXUdiv4nq/xqH1d
         ofjAQYZ1Ke5G06FVCAWpULBxrTT0jkag7U11LOMBN41vS164aT5HfOu2lCwoUiMvsjQa
         Q6Kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771904104; x=1772508904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzOdDteQ7ZLurHZwTqbft5SWZRf804LGh7Y3eqQaNZU=;
        b=AUrR+gqTz1RqyYK9O1czcdDoxFGJ4Cy1XFHnkxsCOhYzECsDJFqxV3aSwTsW0Qfnv7
         jwlWGaRIf4caKu9yzJWnnY+wqmLuMbGxOKyEpf29N86tO+9Y4lu/9O13Ee048m/nXv0m
         OzgvjtasL9ymHs/04Mcz5gJkyr0KBYiIXEmuT2FApyjfKOA74O05xqlLK1ypr1PWYiRs
         Y+RsW9wPRypVaNCTCYvFolRZiGToUhFJuE6UOJaXZuv2mayBR49F9/bFNqRUE6c8TraM
         gwtxY2zBu8FUVlyj5qwxkQmCRwy93eDUjfWPz97B/QbZOcI/xMB5EQQTZQUBYi5fus6z
         nKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771904104; x=1772508904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pzOdDteQ7ZLurHZwTqbft5SWZRf804LGh7Y3eqQaNZU=;
        b=mRNlxzafduBIK6BMQQlhTmRSRcTCNeoU71cx7lxkxPj/rJSBMiQA+vrnjBmPSCAy3n
         LQPA4evO7ddnPm7ED4ITfdKzOadEJTLi0ALWPE4iK2uf/Sqnz52acWzRPM5kDJg5dwtC
         gK8uPklZnpEdbDWBT18sjneoV2uwAtbftYLAiCTjy51g+CSsouVcLohMVslBcWiG5wMj
         libhiW/H7aOXkH/VzoalFyp7C9URrFeYaxwWtMn8D/lusmiyB/ZBIn18u8If6fbscovR
         UzD8XS+sytBewI8d6ZtacFfmtNzBsMws2Vzb0IuvhpEAwQgNKc/e9+nF7TSfDsRZRK6n
         F53Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9S34jZeKr+Qgsc0Ri1b/W7qPnktSWW77O47YaUQLK5dhgyxgpDpeOzchUXNN3XmWkwlNssQ12@vger.kernel.org
X-Gm-Message-State: AOJu0YyYuySOL1OoQVI7G/a5kvUCo2Be9UiEC6Ib8Aj4It41Im5ohYmn
	FPGfjgnFzMNkE8fY9UX9IV9yyG94+cdkDZx8jXxPtYrQE5VD4j+SFhY2jd5GJ/OrENvqgkFQq2i
	14SvluVs2JC1qXCwBA9w6PKFfJ7tlOd4=
X-Gm-Gg: AZuq6aJRT1grxIOQTxNRROhLwvpI1NW2Sy54yXCI9VlaqHO6YIFqXSO753g79reje9o
	PeiW3YuPRRxYo5IiCg6/5P1PEyfTljua4RE8agfrH3f/hcrji8bijUBRmu8Nrbezr8XSm06T54+
	x0jRXDsN6K4wq/ockue/MTCjGA1bBDOoqKxWv6GAJ2zVnpI2zdIAnHV6efG/pZkoPPFLcQyFKEi
	nre9xOz8JL/iQl3s7+EeAbf/ea2H5d+6WK+dBw29XLRTwYmz3U9CekKOkdZUV+aGHqfeP0c8d5M
	EQ+RQbEj+VpIoLdmS00hnSzzL1KLm7tChIoiy10F
X-Received: by 2002:a17:906:7311:b0:b88:7093:3ca3 with SMTP id
 a640c23a62f3a-b9081a48372mr712577366b.23.1771904103707; Mon, 23 Feb 2026
 19:35:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-swap-table-p4-v1-0-104795d19815@tencent.com> <CAKEwX=OaDKQwanaYm=Mt+mWAKjaqXPdiScF6NB=TZYx1B-Xo8w@mail.gmail.com>
In-Reply-To: <CAKEwX=OaDKQwanaYm=Mt+mWAKjaqXPdiScF6NB=TZYx1B-Xo8w@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 24 Feb 2026 11:34:27 +0800
X-Gm-Features: AaiRm52VHlOYalauge877tmnh-TeDdpT4IyzWYAbnMeFhaf0i8dbmK7dBzdlJ7Q
Message-ID: <CAMgjq7D6n0H2=di0SrMQbJ48cVeKhGeQMH_mY0y-au4OJbE2GQ@mail.gmail.com>
Subject: Re: [PATCH RFC 00/15] mm, swap: swap table phase IV with dynamic
 ghost swapfile
To: Nhat Pham <nphamcs@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baoquan He <bhe@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Youngjun Park <youngjun.park@lge.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14199-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 53AC418169D
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 2:22=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Thu, Feb 19, 2026 at 3:42=E2=80=AFPM Kairui Song via B4 Relay
> <devnull+kasong.tencent.com@kernel.org> wrote:
> > Huge thanks to Chris Li for the layered swap table and ghost swapfile
> > idea, without whom the work here can't be archived. Also, thanks to Nha=
t
> > for pushing and suggesting using an Xarray for the swapfile [11] for
> > dynamic size. I was originally planning to use a dynamic cluster
> > array, which requires a bit more adaptation, cleanup, and convention
> > changes. But during the discussion there, I got the inspiration that
> > Xarray can be used as the intermediate step, making this approach
> > doable with minimal changes. Just keep using it in the future, it
> > might not hurt too, as Xarray is only limited to ghost / virtual
> > files, so plain swaps won't have any extra overhead for lookup or high
> > risk of swapout allocation failure.
>
> Thanks for your effort. Dynamic swap space is a very important
> consideration anyone deploying compressed swapping backend on large
> memory systems in general. And yeah, I think using a radix tree/xarray
> is easiest out-of-the-box solution for this - thanks for citing me :P

Thanks for the discussion :)

>
> I still have some confusion and concerns though. Johannes already made
> some good points - I'll just add some thoughts from my point of view,
> having gone back and forth with virtual swap designs:
>
> 1. At which layer should the metadata (swap count, swap cgroup, etc.) liv=
e?
>
> I remember that in your LSFMMBPF presentation (time flies), your
> proposal was to store a redirection entry in the top layer, and keep
> all the metadata at the bottom (i.e backend) layer? This has problems
> - for once, you might not know suitable backend at swap allocation
> time, but only at writeout time. For e.g, in certain zswap setups, we
> reject the incompressible page and cycle it back to the active LRU, so
> we have no space in zswap layer to store swap entry metadata (note
> that at this point the swap entry cannot be freed, because we have
> already unmapped the page from the PTEs (and would require a page
> table walk to undo this a la swapoff). Similarly, when we
> exclusive-load a page from zswap, we invalidate the zswap metadata
> struct, so we will no longer have a space for the swap entry metadata.
>
> The zero-filled (or same-filled) swap entry case is an even more
> egregious example :) It really shouldn't be a state in any backend -
> it should be a completely independent backend.
>
> The only design that makes sense is to store metadata in the top layer
> as well. It's what I'm doing for my virtual swap patch series, but if
> we're pursuing this opt-in swapfile direction we are going to
> duplicate metadata :)

It's already doing that, storing metadata at the top layer, only a
reverse mapping in the lower layer.

So none of these issues are still there. Don't worry, I do remember
that conversation and kept that in mind :)

> > And if you consider these ops are too complex to set up and maintain, w=
e
> > can then only allow one ghost / virtual file, make it infinitely large,
> > and be the default one and top tier, then it achieves the identical thi=
ng
> > to virtual swap space, but with much fewer LOC changed and being runtim=
e
> > optional.
>
> 2. I think the "fewer LOC changed" claim here is misleading ;)
>
> A lot of the behaviors that is required in a virtual swap setup is
> missing from this patch series. You are essentially just implementing
> a swapfile with a dynamic allocator. You still need a bunch more logic
> to support a proper multi-tier virtual swap setup - just on top of my
> mind:

I left that part undone kind of on purpose, since it's only RFC, and
in hope that there could be collaboration.

And the dynamic allocator is only ~200 LOC now. Other parts of this
series are not only for virtual swap. For example the unified folio
alloc for swapin, which gives us 15% performance gain in real
workloads, can still get merged and benifit all of us without
involving the virtual swap or memcg part.

And meanwhile, with the later patches, we don't have to re-implement
the whole infrastructure to have a virtual table. And future plans
like data compaction should benifit every layer naturally (same
infra).

> a. Charging: virtual swap usage not be charged the same as the
> physical swap usage, especially when you have a zswap + disk swap
> setup, powered by virtual swap. For once, I don't believe in sizing
> virtual swap, but also a latency-sensitive cgroup allowe to use only
> zswap (backed by virtual swap) is using and competing for resources
> very differently from a cgroup whose memory is incompressible and only
> allowed to use disk swap.

Ah, now as you mention it, I see in the beginning of this series I
added: "Swap table P4 is stable and good to merge if we are OK with a
few memcg reparent behavior (there is also a solution if we don't)".
The "other solution" also fits your different charge idea here. Just
have a ci->memcg_table, then each layer can have their own charge
design, and the shadow is still only used for refault check. That
gives us 10 bytes per slot overhead though, but still lower than
before and stays completely dynamic.

Also, no duplicated memcg, since the upper layer and lower layer
should be charged differently. If they don't, then just let
ci->memcg_table stay NULL.

>
> b. Backend decision making and efficient backend transfer - as you
> said, "folio_realloc_swap" is yet to be implemented :) And as I
> mention earlier, we CANNOT determine swap backend before PTE unmap

And we are not doing that at all. folio_alloc_swap happens before
unmap, but realloc happens after that. VSS does the same thing.

> time, because backend suitability is content-dependent. You will have
> to add extra logic to handle this nuanced swap allocation behavior.
>
> c. Virtual swap freeing - it requires more work, as you have to free
> both the virtual swap entry itself, as well as digging into the
> physical backend layer.
>
> d. Swapoff - now you have to both page tables and virtual swap table.

Swapoff is actually easy here... If it sees a reverse map slot, read
into the upper layer. Else goto the old logic. Then it's done. If
ghost swap is the layer with highest priority, then every slot is a
reverse map slot.

>
> By the time you implement all of this, I think it will be MORE
> complex, especially since you want to maintain BOTH the new setup and
> the old non-virtual swap setup. You'll have to litter the codes with a
> bunch of ifs (or ifdefs) to check - hey do we have a virtual swapfile?
> Hey is this a virtual swap slot? Etc. Etc. everywhere, from the PTE
> infra (zapping, page fault, etc.), to cgroup infra, to physical swap
> architecture.

It is using the same infrastructure, which means a lot of things are
reused and unified. Isn't that a good sign? And again we don't need to
re-implement the whole infra.

And if you need multiple layers then there will be more "if"s and
overhead however you implement it. But with unified infra, each layer
can stay optional. And checking "si->flags & GHOST / VIRTUAL" really
shouldn't be costly or trouble some at all, compared to a mandatory
layer with layers of Xarray walk.

And we can move, maintain the virt part in a separate place.

> Comparing this line of work by itself with the vswap series, which
> already comes with all of these included, is a bit apples-to-oranges
> (and especially with the fact that vswap simplifies logic and removes
> LoCs in a lot of places too, such as in swapoff. The delta LoC is only
> 300-400 IIRC?).

One thing I want to highlight here is that the old swapoff really
shouldn't just die. That gives us no chance to clear up the swap cache
at all (vss holding swap data in RAM is also just swap cache). Pages
still in swap cache means minor page faults will still trigger. If the
workload is opaque but we knows a high load of traffic is coming and
wants to get rid of any performance bottleneck by reading all folios
into the right place, swapoff gives the guarantee that no anon fault
will be ever triggered, that happens a lot in multiple tenant cloud
environments, and these workload are opaque so madvise doesn't apply.

> > The size of the swapfile (si->max) is now just a number, which could be
> > changeable at runtime if we have a proper idea how to expose that and
> > might need some audit of a few remaining users. But right now, we can
> > already easily have a huge swap device with no overhead, for example:
> >
> > free -m
> >                total        used        free      shared  buff/cache   =
available
> > Mem:            1465         250         927           1         356   =
     1215
> > Swap:       15269887           0    15269887
> >
>
> 3. I don't think we should expose virtual swap state to users (in this
> case, in the swapfile summary view i.e in free). It is just confusing,
> as it poorly reflects the physical state (be it compressed memory
> footprint, or actual disk usage). We obviously should expose a bunch
> of sysfs debug counters for troubleshootings, but for average users,
> it should be all transparent.

Using sysfs can also be a choice, that's really just a demonstration
interface. But I do think it's worse if the user has no idea what is
actually going on.

