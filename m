Return-Path: <cgroups+bounces-14233-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PGOCckenml+TgQAu9opvQ
	(envelope-from <cgroups+bounces-14233-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 22:57:29 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A9C18CFA5
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 22:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 430293015460
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 21:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49EF343216;
	Tue, 24 Feb 2026 21:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5ljW0hV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0577F2C11DD
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 21:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771970227; cv=pass; b=sjvoxxhVusqSZPd5KGv+JY5fNiQOS1pjNiMfzwk4AqZme7wXSmWOiNpZaBSbrf5S2vzzQpDVffUtebI1yZL3qBcQdeisnbxcM+9G5Mgug2t1p7ZBsgBLLziHbLj9ZmQ2tNynUV4HTjdBXOqYICTRB3/brtky3bH3xd7A6eCRPkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771970227; c=relaxed/simple;
	bh=UuP0cAge2bziaWSDZNuWSwkyo6GgfH0izSI5UkiJOK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sxh8zfwDSfmn/LRAeq/J8W8eAAjI+9m18alnIu6UtG+6SveIxpzm3VSunnMW/YAF+n1Hlc0jewGwfGkjnGLkqEBUEyhI68ZFVzUHdIZ8CtnVGTrfJa5Oy8XDNDeunp//k15yJL6aZ6zLVP0q+GS53nsT0jD2A3RMomFZhQkk5Bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5ljW0hV; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43945763558so3806967f8f.3
        for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 13:57:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771970224; cv=none;
        d=google.com; s=arc-20240605;
        b=eu2H4W15h7ple2lRsLOhxms+JLnTMUBv3zg5nHNnXf7T7QDLBjwNw4ZSBS5+YET3kD
         y2meI6BryxJ8vcHTQ3sxyDDGga3beyrw8ftyrr6sV/w8EoH/5KweNWyDGCHBW4dpCaSs
         7qWCnuWaWDBUDnTNbhiXEsj4PWDeG35Eaa9McVYF2Br2qrHe11GKde8CxbZcMW99zLQq
         WLdHEhaLwbKYnnMV8sL0G8GADtLZKCvitldGLYJri1pAmSIMvTw3Odcw/4o5tXKPihsZ
         mWgEIxxoPRbrCmtNPNcDAu70n8x2oN674tZqbtTvgIl5LV10dL6ZeIjiIuk2MphqaCkQ
         iR2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ddGmIXOQS4WxUyRIColh1lekBcQxaYW9LRSLHl/Pl/w=;
        fh=erV50IpHFDiL0UQaEaQLk15rffnIYF7/UoEVzA6aI4k=;
        b=jUcicuWUI+Yo05x4EC3Y6b/+iQfsbbpCgRb0BmES1J3YO8cSXLXBSq8v4VABXRDaxO
         yNc/9j/9Lhisv3mUd/aCPkcFNTzX71fNeIMq0KCyFMq+Q/N3eEYHUORz03MyG3wiSOSS
         UySe8DURBcV+PrsjDE7wGlM6YAGgE2klQgFkaPF/Opb5WS2C6p7bVROLcEF03M93Qa7+
         x5faJOuIP/3SE0k2JrZ5lbMpIoF8Mmj4/PinwlukgIllvg5UYae5H2DeeaXYg6rSkdxD
         d4cBmfNl1THeJ89RW5JLLHp7auLBPDLeLEGtJRWsGRS1bienOgfqaPdxAiLuhL5rUJo2
         dWrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771970224; x=1772575024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddGmIXOQS4WxUyRIColh1lekBcQxaYW9LRSLHl/Pl/w=;
        b=F5ljW0hVI2/0QzfESM1ZEXri+WTjFtjjRdBQDz+3ALwEjhW8j6ve7Gs1ccwrmit5dv
         9fuJxJH6rKW4G7Ed6cmUyAss5k5hLlj0tBt4G9kXTAJqXGzi6TFGXvtAVNmwsdNHSVaz
         mfyvaecgMvtzdhnqL4OVq8UakUI7LIEOyiRyzQaGMJgrt9flqXhI/uVh9y3+Uyp/F5fR
         jitNDIpv/ieYlKd0XFaH/1hHXfwBJmQRXdPe7962pCu6qkE2F5s2FO08V0nKWvUgmS9n
         eZXZakmlUiyxP3N2aRFe7yNaHoNnbWh1hs6kvvFu0UeD2/E+Ogj115gw7o2wipjyhsaL
         BMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771970224; x=1772575024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ddGmIXOQS4WxUyRIColh1lekBcQxaYW9LRSLHl/Pl/w=;
        b=Xip4abYRghfUJMRNiHwOboxHNZonGo+VIDTgsg5PhxlylLA+1SwdMO21tgNwnXafMo
         N57t2f/nN1G4k1HmaWPaHfoLdeB7IuQb5on4kTs3WU0JmEahKr5PtlyS/jLG7poinHy5
         GFZipiUOLO/04cS2GIIKrp4v/YmutxP1YVDpUjuw7z9/D0qHsXn3QcM8YhYxaFlTTt4a
         wFIXSn5YZdUeQkXIuD++6P1qC4x9CDnTLPkxmVfFUpKsHqpQTfsGITARocvbgH1KPbOw
         yzmJ8nar06EmG09IcLPrdZ9U+Zg1rFvsaV98G3OPC7USXsTpnO/5vS1iqnbcd+MSA0Gv
         IUng==
X-Forwarded-Encrypted: i=1; AJvYcCXNZt41AHFpHLcKiHTq0qup/I1qXMsncCpib4wpp79CnT3Jjr705OwypQNTT1TSk5+UzYEqrf4j@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4LS4Ab4mWQoZiaqWUoZ4C3NGqoyf0jlVSZNd5405VCg1G6Ses
	pJOkuQHdmfpeAJ2Dw6WDyg501Menp34HME57FB5VYxgvknzrrou00wyDb7GoteOs3DrvyEUNaNi
	AA3JUkhsLITyyhDI7MpaeAlRoEnl+b58=
X-Gm-Gg: ATEYQzwbGwqPfZcNqhJ0PRe6m7FYPWEE80YLfoq/RmKB9MWB3mEgGS3y3mHXOPaf6fZ
	Hkmv4qdUlTpPHuM4+EBxd451ko25L6TN9x5DyE+aiXBoNu6BwXO9rH9ZT3Ye8C005GVLzkRLGjy
	Gz+WnEdtV1CkghWqMIWvJ5i0MPVC2AV4v/QAuUpHR8N0mKaVm4vu4+mfSe2Jze/HlSqqaq3m5b7
	nzWhTRu1QbW1JW2Wi1//jXggq+CLGUnCXrxtS/V3Ci2VuH9KuQY4lL2qxZoZSr1NVrFHOsI23WB
	UV8BiLi5tKOmTE3flZULTZYR37/uvJmymtwvikzED7WY1SHoHp39yx0=
X-Received: by 2002:a05:6000:2086:b0:439:8c7a:247e with SMTP id
 ffacd0b85a97d-4398c7a24e0mr3553389f8f.36.1771970223993; Tue, 24 Feb 2026
 13:57:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-swap-table-p4-v1-0-104795d19815@tencent.com>
 <CAKEwX=OaDKQwanaYm=Mt+mWAKjaqXPdiScF6NB=TZYx1B-Xo8w@mail.gmail.com> <CAMgjq7D6n0H2=di0SrMQbJ48cVeKhGeQMH_mY0y-au4OJbE2GQ@mail.gmail.com>
In-Reply-To: <CAMgjq7D6n0H2=di0SrMQbJ48cVeKhGeQMH_mY0y-au4OJbE2GQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 24 Feb 2026 13:56:52 -0800
X-Gm-Features: AaiRm50Ta_rou9OyJpASA6p0OEDH6ol87emnfUMH-qXSb2kAWVnEHM7JVmtlFIs
Message-ID: <CAKEwX=NjRGxjQuvAnRoom=Ac_YptspMk1pwoq-2on46f1meuyw@mail.gmail.com>
Subject: Re: [PATCH RFC 00/15] mm, swap: swap table phase IV with dynamic
 ghost swapfile
To: Kairui Song <ryncsn@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-14233-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 47A9C18CFA5
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 7:35=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Tue, Feb 24, 2026 at 2:22=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wro=
te:
> >
> > On Thu, Feb 19, 2026 at 3:42=E2=80=AFPM Kairui Song via B4 Relay
> > <devnull+kasong.tencent.com@kernel.org> wrote:
> > > Huge thanks to Chris Li for the layered swap table and ghost swapfile
> > > idea, without whom the work here can't be archived. Also, thanks to N=
hat
> > > for pushing and suggesting using an Xarray for the swapfile [11] for
> > > dynamic size. I was originally planning to use a dynamic cluster
> > > array, which requires a bit more adaptation, cleanup, and convention
> > > changes. But during the discussion there, I got the inspiration that
> > > Xarray can be used as the intermediate step, making this approach
> > > doable with minimal changes. Just keep using it in the future, it
> > > might not hurt too, as Xarray is only limited to ghost / virtual
> > > files, so plain swaps won't have any extra overhead for lookup or hig=
h
> > > risk of swapout allocation failure.
> >
> > Thanks for your effort. Dynamic swap space is a very important
> > consideration anyone deploying compressed swapping backend on large
> > memory systems in general. And yeah, I think using a radix tree/xarray
> > is easiest out-of-the-box solution for this - thanks for citing me :P
>
> Thanks for the discussion :)
>
> >
> > I still have some confusion and concerns though. Johannes already made
> > some good points - I'll just add some thoughts from my point of view,
> > having gone back and forth with virtual swap designs:
> >
> > 1. At which layer should the metadata (swap count, swap cgroup, etc.) l=
ive?
> >
> > I remember that in your LSFMMBPF presentation (time flies), your
> > proposal was to store a redirection entry in the top layer, and keep
> > all the metadata at the bottom (i.e backend) layer? This has problems
> > - for once, you might not know suitable backend at swap allocation
> > time, but only at writeout time. For e.g, in certain zswap setups, we
> > reject the incompressible page and cycle it back to the active LRU, so
> > we have no space in zswap layer to store swap entry metadata (note
> > that at this point the swap entry cannot be freed, because we have
> > already unmapped the page from the PTEs (and would require a page
> > table walk to undo this a la swapoff). Similarly, when we
> > exclusive-load a page from zswap, we invalidate the zswap metadata
> > struct, so we will no longer have a space for the swap entry metadata.
> >
> > The zero-filled (or same-filled) swap entry case is an even more
> > egregious example :) It really shouldn't be a state in any backend -
> > it should be a completely independent backend.
> >
> > The only design that makes sense is to store metadata in the top layer
> > as well. It's what I'm doing for my virtual swap patch series, but if
> > we're pursuing this opt-in swapfile direction we are going to
> > duplicate metadata :)
>
> It's already doing that, storing metadata at the top layer, only a
> reverse mapping in the lower layer.
>
> So none of these issues are still there. Don't worry, I do remember
> that conversation and kept that in mind :)
>
> > > And if you consider these ops are too complex to set up and maintain,=
 we
> > > can then only allow one ghost / virtual file, make it infinitely larg=
e,
> > > and be the default one and top tier, then it achieves the identical t=
hing
> > > to virtual swap space, but with much fewer LOC changed and being runt=
ime
> > > optional.
> >
> > 2. I think the "fewer LOC changed" claim here is misleading ;)
> >
> > A lot of the behaviors that is required in a virtual swap setup is
> > missing from this patch series. You are essentially just implementing
> > a swapfile with a dynamic allocator. You still need a bunch more logic
> > to support a proper multi-tier virtual swap setup - just on top of my
> > mind:
>
> I left that part undone kind of on purpose, since it's only RFC, and
> in hope that there could be collaboration.
>
> And the dynamic allocator is only ~200 LOC now. Other parts of this
> series are not only for virtual swap. For example the unified folio
> alloc for swapin, which gives us 15% performance gain in real
> workloads, can still get merged and benifit all of us without
> involving the virtual swap or memcg part.
>
> And meanwhile, with the later patches, we don't have to re-implement
> the whole infrastructure to have a virtual table. And future plans
> like data compaction should benifit every layer naturally (same
> infra).
>
> > a. Charging: virtual swap usage not be charged the same as the
> > physical swap usage, especially when you have a zswap + disk swap
> > setup, powered by virtual swap. For once, I don't believe in sizing
> > virtual swap, but also a latency-sensitive cgroup allowe to use only
> > zswap (backed by virtual swap) is using and competing for resources
> > very differently from a cgroup whose memory is incompressible and only
> > allowed to use disk swap.
>
> Ah, now as you mention it, I see in the beginning of this series I
> added: "Swap table P4 is stable and good to merge if we are OK with a
> few memcg reparent behavior (there is also a solution if we don't)".
> The "other solution" also fits your different charge idea here. Just
> have a ci->memcg_table, then each layer can have their own charge
> design, and the shadow is still only used for refault check. That
> gives us 10 bytes per slot overhead though, but still lower than
> before and stays completely dynamic.
>
> Also, no duplicated memcg, since the upper layer and lower layer
> should be charged differently. If they don't, then just let
> ci->memcg_table stay NULL.
>
> >
> > b. Backend decision making and efficient backend transfer - as you
> > said, "folio_realloc_swap" is yet to be implemented :) And as I
> > mention earlier, we CANNOT determine swap backend before PTE unmap
>
> And we are not doing that at all. folio_alloc_swap happens before
> unmap, but realloc happens after that. VSS does the same thing.
>
> > time, because backend suitability is content-dependent. You will have
> > to add extra logic to handle this nuanced swap allocation behavior.
> >
> > c. Virtual swap freeing - it requires more work, as you have to free
> > both the virtual swap entry itself, as well as digging into the
> > physical backend layer.
> >
> > d. Swapoff - now you have to both page tables and virtual swap table.
>
> Swapoff is actually easy here... If it sees a reverse map slot, read
> into the upper layer. Else goto the old logic. Then it's done. If
> ghost swap is the layer with highest priority, then every slot is a
> reverse map slot.
>
> >
> > By the time you implement all of this, I think it will be MORE
> > complex, especially since you want to maintain BOTH the new setup and
> > the old non-virtual swap setup. You'll have to litter the codes with a
> > bunch of ifs (or ifdefs) to check - hey do we have a virtual swapfile?
> > Hey is this a virtual swap slot? Etc. Etc. everywhere, from the PTE
> > infra (zapping, page fault, etc.), to cgroup infra, to physical swap
> > architecture.
>
> It is using the same infrastructure, which means a lot of things are
> reused and unified. Isn't that a good sign? And again we don't need to
> re-implement the whole infra.
>
> And if you need multiple layers then there will be more "if"s and
> overhead however you implement it. But with unified infra, each layer
> can stay optional. And checking "si->flags & GHOST / VIRTUAL" really
> shouldn't be costly or trouble some at all, compared to a mandatory
> layer with layers of Xarray walk.
>
> And we can move, maintain the virt part in a separate place.

The point is not that it's hard to do. That's the whole sale pitch of
vswap - once you have it all the use case is neatly facilitated ;)

I'm just pointing out that "minimal LoC" is not exactly fair here, as
we still have (in my estimate) quite a sizable amount of work.

>
> > Comparing this line of work by itself with the vswap series, which
> > already comes with all of these included, is a bit apples-to-oranges
> > (and especially with the fact that vswap simplifies logic and removes
> > LoCs in a lot of places too, such as in swapoff. The delta LoC is only
> > 300-400 IIRC?).
>
> One thing I want to highlight here is that the old swapoff really
> shouldn't just die. That gives us no chance to clear up the swap cache
> at all (vss holding swap data in RAM is also just swap cache). Pages
> still in swap cache means minor page faults will still trigger. If the
> workload is opaque but we knows a high load of traffic is coming and
> wants to get rid of any performance bottleneck by reading all folios
> into the right place, swapoff gives the guarantee that no anon fault
> will be ever triggered, that happens a lot in multiple tenant cloud
> environments, and these workload are opaque so madvise doesn't apply.

I somewhat agree with Johannes that the problem is quite academic in
nature here, but I will think more about it.

>
> > > The size of the swapfile (si->max) is now just a number, which could =
be
> > > changeable at runtime if we have a proper idea how to expose that and
> > > might need some audit of a few remaining users. But right now, we can
> > > already easily have a huge swap device with no overhead, for example:
> > >
> > > free -m
> > >                total        used        free      shared  buff/cache =
  available
> > > Mem:            1465         250         927           1         356 =
       1215
> > > Swap:       15269887           0    15269887
> > >
> >
> > 3. I don't think we should expose virtual swap state to users (in this
> > case, in the swapfile summary view i.e in free). It is just confusing,
> > as it poorly reflects the physical state (be it compressed memory
> > footprint, or actual disk usage). We obviously should expose a bunch
> > of sysfs debug counters for troubleshootings, but for average users,
> > it should be all transparent.
>
> Using sysfs can also be a choice, that's really just a demonstration
> interface. But I do think it's worse if the user has no idea what is
> actually going on.

I think the users should know that virtual swap is enabled or not, and
some diagnostics stats - allocated, used, rejected/failure etc.

But from users perspective, the other traditional swapfile states
don't seem that useful, and might give users misconceptions. When you
see swapfile stats, you know that you are occupying a limited physical
resource, and how much of it is left. I don't think there's even a
good reason to statically size virtual swap space - it's just a
facility to enable use cases, not an actual resource in the same way
as memory, or disk drive, and is dynamic (on-demand) in nature.

