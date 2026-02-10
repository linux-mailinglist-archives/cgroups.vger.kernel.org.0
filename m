Return-Path: <cgroups+bounces-13842-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OLmKOSCi2lDVAAAu9opvQ
	(envelope-from <cgroups+bounces-13842-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 20:11:32 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F6A11E86C
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 20:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 65DA5300D0C1
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 19:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2584E38B7AE;
	Tue, 10 Feb 2026 19:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyHyKfnf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051D132E15F
	for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 19:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770750686; cv=pass; b=QhjfMrPVLaipdtD8XG9Ay+zyFKws1JSFRxnlrs8zWVBPEL55mPKvpx+IK4uG9Bt5qzyQEXADptq9sn2XH9PYzCMc4Cfst2UNC4wXsFGSHKRvSy/KvZTby3yGLdUNc5ej6DkWCbOpLvUXd49KyvhBrkruIJjCvLHk9tA+24wtYBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770750686; c=relaxed/simple;
	bh=tizEDa9qdihKrfH7YnsQNHmYf1GEpRXuwlEcHKQrBxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ms2riEJpAzxACtFRNkMBnvgp8E6EIJGizWAdmh44/ruvT5PKcrZbc92eiyEicQrHCuBdN1XQ3l1BpOqLvr978pGxygj/BMo83M8J35zOTScKPpZQ1WpzXQ/KvsBDKgsk4CL3KdiZRv12UzW5RXIhvthVCaCz7mKOVKlPYK/uLFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyHyKfnf; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4806dffc64cso52299255e9.1
        for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 11:11:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770750683; cv=none;
        d=google.com; s=arc-20240605;
        b=KagCj8sdRFxSjq/fRZSjMavVytRdvw0B4LU5d7tDXmz2GO5+EnL77va0h0NL5oKifR
         hfFTyqfOCIvmKNEAEsPEndgD5HkcTRH6NDd9oTLajoD+WODmBv/Qow9FHwuShvPLeM4/
         XLqsJuIxlKZJ9hc8s95qzffBXkL2e3Y6I4Hu4FWAwsPWWGHnysx4MTqH1UpiXcVs+txx
         VZh1mNyZVLirY1qaIdqCxCU/bF3Src5HQtktzh9Gjxoewfv1lYGvvpK2mj8sqoaj7yA/
         but/4CwLmB9Y5srZZhVEIsx20jgQa48UP4w0yQ9lIn7ZhWvsygyjE3fL+4ZTtSjmhju3
         Vp3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lg02zJ+zmG8JzV6FX7AzgYv4xtyX97EATX1939W+INc=;
        fh=lS6WsQx04SYe752J+3pOmycka77Y6Y2Lw+ZSUBbNLNM=;
        b=REfvEEIr1hSqp4kutrm9yp06cpbYMt/vkFoyLGUn9h4u71fpQlz2+zo+XwDK7N35yj
         dEeQ1Znop1frjEfS7xXrMD808xPjzCBe35+90QcQ+isUUewruJetNMo4LjxoFBxXfa1T
         +DmI3dDzR0hyyJOR4IAGvSXPuQqmiEO5yU5ujnjBJViVUaal7091zSmrvDCmy7l5/BbL
         k2QuILTRX4CwX++BQ9evlyQlEmL/90+9kZOsbfw/LD3t7fv8tt+UHwKG3sDARAwNIkzm
         upKrqUPzdRj9fjLYXhmoYncBKLvaCQjtJH9U1jn9sTsZGA4e9Wav/BeyfnNhLj2tWOGw
         jyVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770750683; x=1771355483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lg02zJ+zmG8JzV6FX7AzgYv4xtyX97EATX1939W+INc=;
        b=GyHyKfnfx8CXLGrc6e+VMkj0zOzQpARe9krjSJZTNLUEiMedId7bTrZ/KU/DXGMoTS
         eJjbnS8YewgPEJ3Hwi1CVOg6B4yKjAi9ycx42k69RnCKW5JnbNmOpT3HNWY23UNe5d66
         Hfru0J0TsyLl+WUG6QxY6cLrVtEIUVIyOQJn+woW38XRtLLscewMFZmq2urXLgaABzmY
         q7wPnAK2MlmNZiF8lgoKMbl1slzn/8VMfVkIqN+deZDSVNVzxYdcwh7FwwRhv5N728Ei
         OF3bq+vph9NBRl/3TApU5yuJR4sWAs5kuLuuvMFZdK/boFvBa6mODg1xi+rPMYUVwg7P
         u7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770750683; x=1771355483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lg02zJ+zmG8JzV6FX7AzgYv4xtyX97EATX1939W+INc=;
        b=YQw0pmD6B96nm/Tb9A1x6rRGjTfwWK7wRUDlDpYqQP/gs2KMaDhnZqm96q6jShX6KB
         mO5n3xXa0UbpdqkNsYMJs6DhIw74vtcwRu98BgED5yT01sOdC3qkLxVxOZ7N4bdgVWjE
         fhNlez9MpTwiwFY/389HDPXdeSmK+YkMO8sWJqmF8wZh7Uwd8nxvVXWyKK8UlsN7Anfk
         UlPU9tbdkNC0K8zSAQzLZPCoDk647PwHBMyXR2XMYLLRUOisgaGAfCJDSe4ReFs5axPZ
         Ns3097quWyp+aVgx7XNGx6Y4RQxHHGThrUpMY1s9ovkPvgwyYjR3ieHfCinJ/E9n/Evx
         Q05g==
X-Forwarded-Encrypted: i=1; AJvYcCUKX10Ixrnv7D4xZizGfLWmJ68Ipk4vBXt4EasgxpPanSdT3aIgr81y7LmoXEsw/bWLUxfTyk5H@vger.kernel.org
X-Gm-Message-State: AOJu0YwaRBb7ZwRve9VVWI6bW5PoPJUFqs9v1zCz77nvRpGe/I04KkwS
	Jo8ro0ilQFGeBZA8QL2ibkrRBIvaVezJNBYXSMQNY8lFAV4cLCAhuC/BpHvMl+6EpCupVl6svfP
	UL+fj1GawZRX15VXyh1jYG9nbGbya9UU=
X-Gm-Gg: AZuq6aL8zfKPS8xDVhVbwLaEG+x4fhV5pomJ6caUnw6LovEJB2sLmIfjM3TeTwwb/pw
	eezhVySVgeVx7XP8jqi7YOTpfI0foEW5iY6qdNbmlNCDh+NZciLYLe0JS5/zrHk1ltkrl0+zKKZ
	OED6D/kR/t0Hf1NtpvuvEkKL4phJUGgA3p4bEfREHHf7SAMWX35jV3PkUh/XpVQt0NSlxumYGAk
	DuVlARzfGbUgK4zzX6RWMsofO9kC+GXkadG1Q58b2PvjAswcSjxVs9nM7lKgrmtyvt9tOErBjbt
	2k7E1FKO5f3oKNUXD34U3Klql8dpRLdhlYnicRE=
X-Received: by 2002:a05:600c:348a:b0:480:3ad0:93bf with SMTP id
 5b1f17b1804b1-48320966729mr228687565e9.24.1770750682952; Tue, 10 Feb 2026
 11:11:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208215839.87595-2-nphamcs@gmail.com> <20260208222652.328284-1-nphamcs@gmail.com>
 <CAMgjq7AQNGK-a=AOgvn4-V+zGO21QMbMTVbrYSW_R2oDSLoC+A@mail.gmail.com>
In-Reply-To: <CAMgjq7AQNGK-a=AOgvn4-V+zGO21QMbMTVbrYSW_R2oDSLoC+A@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 10 Feb 2026 11:11:11 -0800
X-Gm-Features: AZwV_QjiOO6j26eMiBTeyevvXh-PkDtsFLmP_Tcm2odsndmNAGBnH1r-vL0qIJ0
Message-ID: <CAKEwX=OUni7PuUqGQUhbMDtErurFN_i=1RgzyQsNXy4LABhXoA@mail.gmail.com>
Subject: Re: [PATCH v3 00/20] Virtual Swap Space
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	hughd@google.com, yosry.ahmed@linux.dev, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	len.brown@intel.com, chengming.zhou@linux.dev, chrisl@kernel.org, 
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com, shikemeng@huaweicloud.com, 
	viro@zeniv.linux.org.uk, baohua@kernel.org, bhe@redhat.com, osalvador@suse.de, 
	christophe.leroy@csgroup.eu, pavel@kernel.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-pm@vger.kernel.org, peterx@redhat.com, riel@surriel.com, 
	joshua.hahnjy@gmail.com, npache@redhat.com, gourry@gourry.net, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	rafael@kernel.org, jannh@google.com, pfalcato@suse.de, 
	zhengqi.arch@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13842-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,cmpxchg.org,google.com,linux.dev,kernel.org,intel.com,gmail.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,csgroup.eu,meta.com,vger.kernel.org,surriel.com,gourry.net,bytedance.com];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 19F6A11E86C
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 10:00=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> On Mon, Feb 9, 2026 at 7:57=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
> >
> > Anyway, resending this (in-reply-to patch 1 of the series):
>
> Hi Nhat,
>
> > Changelog:
> > * RFC v2 -> v3:
> >     * Implement a cluster-based allocation algorithm for virtual swap
> >       slots, inspired by Kairui Song and Chris Li's implementation, as
> >       well as Johannes Weiner's suggestions. This eliminates the lock
> >           contention issues on the virtual swap layer.
> >     * Re-use swap table for the reverse mapping.
> >     * Remove CONFIG_VIRTUAL_SWAP.
>
> I really do think we better make this optional, not a replacement or
> mandatory. There are many hard to evaluate effects as this
> fundamentally changes the swap workflow with a lot of behavior changes
> at once. e.g. it seems the folio will be reactivated instead of
> splitted if the physical swap device is fragmented; slot is allocated
> at IO and not at unmap, and maybe many others. Just like zswap is
> optional. Some common workloads would see an obvious performance or
> memory usage regression following this design, see below.

Ideally, if we can close the performance gap and have only one
version, then that would be the best :)

Problem with making it optional, or maintaining effectively two swap
implementations, is that it will make the patch series unreadable and
unreviewable, and the code base unmaintanable :) You'll have x2 the
amount of code to reason about and test, much more merge conflicts at
rebase and cherry-pick time. And any improvement to one version takes
extra work to graft onto the other version.

>
> >     * Reducing the size of the swap descriptor from 48 bytes to 24
> >       bytes, i.e another 50% reduction in memory overhead from v2.
>
> Honestly if you keep reducing that you might just end up
> reimplementing the swap table format :)

There's nothing wrong with that ;)

I like the swap table format (and your cluster-based swap allocator) a
lot. This patch series does not aim to remove that design - I just
want to separate the address space of physical and virtual swaps to
enable new use cases...

>
> > This patch series is based on 6.19. There are a couple more
> > swap-related changes in the mm-stable branch that I would need to
> > coordinate with, but I would like to send this out as an update, to sho=
w
> > that the lock contention issues that plagued earlier versions have been
> > resolved and performance on the kernel build benchmark is now on-par wi=
th
> > baseline. Furthermore, memory overhead has been substantially reduced
> > compared to the last RFC version.
>
> Thanks for the effort!
>
> > * Operationally, static provisioning the swapfile for zswap pose
> >   significant challenges, because the sysadmin has to prescribe how
> >   much swap is needed a priori, for each combination of
> >   (memory size x disk space x workload usage). It is even more
> >   complicated when we take into account the variance of memory
> >   compression, which changes the reclaim dynamics (and as a result,
> >   swap space size requirement). The problem is further exarcebated for
> >   users who rely on swap utilization (and exhaustion) as an OOM signal.
>
> So I thought about it again, this one seems not to be an issue. In

I mean, it is a real production issue :) We have a variety of server
machines and services. Each of the former has its own memory and drive
size. Each of the latter has its own access characteristics,
compressibility, latency tolerance (and hence would prefer a different
swapping solutions - zswap, disk swap, zswap x disk swap). Coupled
with the fact that now multiple services can cooccur on one host, and
one services can be deployed on different kinds of hosts, statically
sizing the swapfile becomes operationally impossible and leaves a lot
of wins on the table. So swap space has to be dynamic.


> most cases, having a 1:1 virtual swap setup is enough, and very soon
> the static overhead will be really trivial. There won't even be any
> fragmentation issue either, since if the physical memory size is
> identical to swap space, then you can always find a matching part. And
> besides, dynamic growth of swap files is actually very doable and
> useful, that will make physical swap files adjustable at runtime, so
> users won't need to waste a swap type id to extend physical swap
> space.

By "dynamic growth of swap files", do you mean dynamically adjusting
the size of the swapfile? then that capacity does not exist right now,
and I don't see a good design laid out for it... At the very least,
the swap allocator needs to be dynamic in nature. I assume it's going
to look something very similar to vswap's current attempt, which
relies on a tree structure (radix tree i.e xarray). Sounds familiar?
;)

I feel like each of the problem I mention in this cover letter can be
solved partially with some amount of hacks, but none of them will
solve it all. And once you slaps all the hacks together, you just get
virtual swap, potentially shoved within specific backend codebase
(zswap or zram). That's not... ideal.

>
> > * Another motivation is to simplify swapoff, which is both complicated
> >   and expensive in the current design, precisely because we are storing
> >   an encoding of the backend positional information in the page table,
> >   and thus requires a full page table walk to remove these references.
>
> The swapoff here is not really a clean swapoff, minor faults will
> still be triggered afterwards, and metadata is not released. So this
> new swapoff cannot really guarantee the same performance as the old
> swapoff. And on the other hand we can already just read everything
> into the swap cache then ignore the page table walk with the older
> design too, that's just not a clean swapoff.

I don't understand your point regarding the "reading everything into
swap cache". Yes, you can do that, but you would still lock the swap
device in place, because the page table entries still refer to slots
on the physical swap device - you cannot free the swap device, nor
space on disk, not even the swapfile's metadata (especially since the
swap cache is now intertwined with the physical swap layer).

>
> > struct swp_desc {
> >         union {
> >                 swp_slot_t         slot;                 /*     0     8=
 */
> >                 struct zswap_entry * zswap_entry;        /*     0     8=
 */
> >         };                                               /*     0     8=
 */
> >         union {
> >                 struct folio *     swap_cache;           /*     8     8=
 */
> >                 void *             shadow;               /*     8     8=
 */
> >         };                                               /*     8     8=
 */
> >         unsigned int               swap_count;           /*    16     4=
 */
> >         unsigned short             memcgid:16;           /*    20: 0  2=
 */
> >         bool                       in_swapcache:1;       /*    22: 0  1=
 */
>
> A standalone bit for swapcache looks like the old SWAP_HAS_CACHE that
> causes many issues...

Yeah this was based on 6.19, which did not have your swap cache change yet =
:)

I have taken a look at your latest swap table work in mm-stable, and I
think most of that can conceptually incorporated in to this line of
work as well.

Chiefly, the new swap cache synchronization scheme (i.e whoever puts
the folio in swap cache first gets exclusive rights) still works in
virtual swap world (and hence, the removal of swap cache pin, which is
one bit in the virtual swap descriptor).

Similarly, do you think we cannot hold the folio lock in place of the
cluster lock in the virtual swap world? Same for a lot of the memory
overhead reduction tricks (such as using shadow for cgroup id instead
of a separate swap_cgroup unsigned short field). I think comparing the
two this way is a bit apples-to-oranges (especially given the new
features enabled by vswap).

[...]

> That 3 - 4 times more memory usage, quite a trade off. With a
> 128G device, which is not something rare, it would be 1G of memory.
> Swap table p3 / p4 is about 320M / 256M, and we do have a way to cut
> that down close to be <1 byte or 3 byte per page with swap table
> compaction, which was discussed in LSFMM last year, or even 1 bit
> which was once suggested by Baolin, that would make it much smaller
> down to <24MB (This is just an idea for now, but the compaction is
> very doable as we already have "LRU"s for swap clusters in swap
> allocator).
>
> I don't think it looks good as a mandatory overhead. We do have a huge
> user base of swap over many different kinds of devices, it was not
> long ago two new kernel bugzilla issue  or bug reported was sent to
> the maillist about swap over disk, and I'm still trying to investigate
> one of them which seems to be actually a page LRU issue and not swap
> problem..  OK a little off topic, anyway, I'm not saying that we don't
> want more features, as I mentioned above, it would be better if this
> can be optional and minimal. See more test info below.

Side note - I might have missed this. If it's still ongoing, would
love to help debug this :)

>
> > We actually see a slight improvement in systime (by 1.5%) :) This is
> > likely because we no longer have to perform swap charging for zswap
> > entries, and virtual swap allocator is simpler than that of physical
> > swap.
>
> Congrats! Yeah, I guess that's because vswap has a smaller lock scope
> than zswap with a reduced callpath?

Ah yeah that too. I neglected to mention this, but with vswap you can
merge several swap operations in zswap code path and no longer have to
release-then-reacquire the swap locks, since zswap entries live in the
same lock scope as swap cache entries.

It's more of a side note either way, because my main goal with this
patch series is to enable new features. Getting a performance win is
always nice of course :)

>
> >
> > Using SSD swap as the backend:
> >
> > Baseline:
> > real: mean: 200.3s, stdev: 2.33s
> > sys: mean: 489.88s, stdev: 9.62s
> >
> > Vswap:
> > real: mean: 201.47s, stdev: 2.98s
> > sys: mean: 487.36s, stdev: 5.53s
> >
> > The performance is neck-to-neck.
>
> Thanks for the bench, but please also test with global pressure too.

Do you mean using memory to the point where it triggered the global waterma=
rks?

> One mistake I made when working on the prototype of swap tables was
> only focusing on cgroup memory pressure, which is really not how
> everyone uses Linux, and that's why I reworked it for a long time to
> tweak the RCU allocation / freeing of swap table pages so there won't
> be any regression even for lowend and global pressure. That's kind of
> critical for devices like Android.
>
> I did an overnight bench on this with global pressure, comparing to
> mainline 6.19 and swap table p3 (I do include such test for each swap
> table serie, p2 / p3 is close so I just rebase and latest p3 on top of
> your base commit just to be fair and that's easier for me too) and it
> doesn't look that good.
>
> Test machine setup for vm-scalability:
> # lscpu | grep "Model name"
> Model name:          AMD EPYC 7K62 48-Core Processor
>
> # free -m
>               total        used        free      shared  buff/cache   ava=
ilable
> Mem:          31582         909       26388           8        4284      =
 29989
> Swap:         40959          41       40918
>
> The swap setup follows the recommendation from Huang
> (https://lore.kernel.org/linux-mm/87ed474kvx.fsf@yhuang6-desk2.ccr.corp.i=
ntel.com/).
>
> Test (average of 18 test run):
> vm-scalability/usemem --init-time -O -y -x -n 1 56G
>
> 6.19:
> Throughput: 618.49 MB/s (stdev 31.3)
> Free latency: 5754780.50us (stdev 69542.7)
>
> swap-table-p3 (3.8%, 0.5% better):
> Throughput: 642.02 MB/s (stdev 25.1)
> Free latency: 5728544.16us (stdev 48592.51)
>
> vswap (3.2%, 244% worse):
> Throughput: 598.67 MB/s (stdev 25.1)
> Free latency: 13987175.66us (stdev 125148.57)
>
> That's a huge regression with freeing. I have a vm-scatiliby test
> matrix, not every setup has such significant >200% regression, but on
> average the freeing time is about at least 15 - 50% slower (for
> example /data/vm-scalability/usemem --init-time -O -y -x -n 32 1536M
> the regression is about 2583221.62us vs 2153735.59us). Throughput is
> all lower too.
>
> Freeing is important as it was causing many problems before, it's the
> reason why we had a swap slot freeing cache years ago (and later we
> removed that since the freeing cache causes more problems and swap
> allocator already improved it better than having the cache). People
> even tried to optimize that:
> https://lore.kernel.org/linux-mm/20250909065349.574894-1-liulei.rjpt@vivo=
.com/
> (This seems a already fixed downstream issue, solved by swap allocator
> or swap table). Some workloads might amplify the free latency greatly
> and cause serious lags as shown above.
>
> Another thing I personally cares about is how swap works on my daily
> laptop :), building the kernel in a 2G test VM using NVME as swap,
> which is a very practical workload I do everyday, the result is also
> not good (average of 8 test run, make -j12):

Hmm this one I don't think I can reproduce without your laptop ;)

Jokes aside, I did try to run the kernel build with disk swapping, and
the performance is on par with baseline. Swap performance with NVME
swap tends to be dominated by IO work in my experiments. Do you think
I missed something here? Maybe it's the concurrency difference (since
I always run with -j$(nproc), i.e the number of workers =3D=3D the number
of processors).

> #free -m
>                total        used        free      shared  buff/cache   av=
ailable
> Mem:            1465         216        1026           0         300     =
   1248
> Swap:           4095          36        4059
>
> 6.19 systime:
> 109.6s
> swap-table p3:
> 108.9s
> vswap systime:
> 118.7s
>
> On a build server, it's also slower (make -j48 with 4G memory VM and
> NVME swap, average of 10 testrun):
> # free -m
>                total        used        free      shared  buff/cache   av=
ailable
> Mem:            3877        1444        2019         737        1376     =
   2432
> Swap:          32767        1886       30881
>
> # lscpu | grep "Model name"
> Model name:                              Intel(R) Xeon(R) Platinum
> 8255C CPU @ 2.50GHz
>
> 6.19 systime:
> 435.601s
> swap-table p3:
> 432.793s
> vswap systime:
> 455.652s
>
> In conclusion it's about 4.3 - 8.3% slower for common workloads under
> global pressure, and there is a up to 200% regression on freeing. ZRAM
> shows an even larger workload regression but I'll skip that part since
> your series is focusing on zswap now. Redis is also ~20% slower
> compared to mm-stable (327515.00 RPS vs 405827.81 RPS), that's mostly
> due to swap-table-p2 in mm-stable so I didn't do further comparisons.

I'll see if I can reproduce the issues! I'll start with usemem one
first, as that seems easier to reproduce...

>
> So if that's not a bug with this series, I think the double free or

It could be a non-crashing bug that subtly regresses certain swap
operations, but yeah let me study your test case first!

> decoupling of swap / underlying slots might be the problem with the
> freeing regression shown above. That's really a serious issue, and the
> global pressure might be a critical issue too as the metadata is much
> larger, and is already causing regressions for very common workloads.
> Low end users could hit the min watermark easily and could have
> serious jitters or allocation failures.
>
> That's part of the issue I've found, so I really do think we need a
> flexible way to implementa that and not have a mandatory layer. After
> swap table P4 we should be able to figure out a way to fit all needs,
> with a clean defined set of swap API, metadata and layers, as was
> discussed at LSFMM last year.

