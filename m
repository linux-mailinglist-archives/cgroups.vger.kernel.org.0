Return-Path: <cgroups+bounces-16520-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NHCHYavHWpfdAkAu9opvQ
	(envelope-from <cgroups+bounces-16520-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 18:12:54 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AB1622627
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 18:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 829D931133BF
	for <lists+cgroups@lfdr.de>; Mon,  1 Jun 2026 15:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF9A37DAA9;
	Mon,  1 Jun 2026 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUvHj8x4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A273A7D7A
	for <cgroups@vger.kernel.org>; Mon,  1 Jun 2026 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780329425; cv=pass; b=LahQuA8cFHN+nUiISqNQyocNx5v/rsb7fuLgzsbosaxFgwM75yRDPNP8Pw2hZpACF5e7QYSY54EYVROVLeizQOiFaRtVcilRQ6Xh4g6HDaO252SkU6+ARvtNuPR2nzFVx9gShHQ+t1ys8s/AxPHlQGEHPs/WOTlzI6bmclVEAC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780329425; c=relaxed/simple;
	bh=r01Fse1TA8eY/GHFveDbT6GZ8QHZl1jtxKArizu3gG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/JK+smbGff/pvgzD6dO/TlM/NjorvDNhoQzJN15bFDAv0lAcUU18tdo+0Um1EEnQBmGCM1IsRaYcigoeWzRB02xxPvaZqA+Djs4a5otD+md6yPFy6CRQwUPkYKXc8kFY57hiBVHhRYNGHxN2Y6+ZBW9QDKCtkFX7NWFOMlTz58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUvHj8x4; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45ef616daf6so2893121f8f.3
        for <cgroups@vger.kernel.org>; Mon, 01 Jun 2026 08:57:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780329422; cv=none;
        d=google.com; s=arc-20240605;
        b=l1KvTV3CvX4aeBV/FSX29sIECI4ZFkRmH8P5IiuxL2JdHrZNudY1L60xatwk+QeguC
         vilx9XQM3Jx/T4IynjBpuXTA1v8ncN1dBldYkU8v65zV2C67v7cv4MP7LJlPwRprTOcx
         KEbJLxP1Mcd+q7K5zE40mT7VZs59t/CH9Aol2dA0dX0Jb9L9QS0JhtxfYin0muZ8ItGR
         Gfq13bhsjR/cCiV6c0y2czO1Rt0crVc1A6guK6vQdtobadvUXh94DJRqnZQpLubT4w2d
         ehj8G9CdUKjZ3T0u/0XxkfxarFeeDt593r4h2stJVuTVvSVHW2+p+RrDteQNOX9+vnxh
         0v9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WY4YPDieV37EdMYLsPozHBfblk0U6F7cKbbQOcc8GXs=;
        fh=Ye4nXs0xFMNsHLfnn/gdNvelmq7quUVEhqkM7nFZd64=;
        b=DLNl+6wFat+waACHnbfju34I6BMizb99jpR5XxlrrgueVHfVgOEfbpiXOUMgAyy7NS
         7cxkuuLeu/6FQGIWpUhahavigoLABisJI7MEW9yDO8shGXw+jfjmQAMLqnO2rF8QSy7I
         Gzq6DNnxdBHp+CPhhWgTjanXU/ZqNGEOCGlF2Kjryew8Ee3ypykOhacAqLAvx318AJBa
         7SY0QBcgwJrhxPlIjzaSuepTqbM3qBNd0SzobZbbNmxLijlmEHCJcPkZQBfquMj/mZet
         OaR9f/Mx1msqEGFY66BNeBHZ/W28d0wTC9QSDQF7IKqds2V1F2cnYcdNYoC8rk5vO8qG
         Zo5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780329422; x=1780934222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WY4YPDieV37EdMYLsPozHBfblk0U6F7cKbbQOcc8GXs=;
        b=NUvHj8x4DHNTrpDAY2hIoUi59Z9M2YuIafnFHmtzD6vjL586wOajow4y/GKoldHp7Z
         oZepAqsxacXEHhnvexZNltUsRVZlSWTSgZ579FcHMBEr4Cx4ytutI1bySYtOytZWvEvn
         vr6qhFKG8NUUHixma4Jl787DMQ/gsmp7TxnphNHy9EcdFzK0CP3qIXRwQUEHJ75NhiXG
         3JCyrglqz+X9r0TFAlLEKqUR+JgbdUXA78yR3h9D+nJpk0gn+BBeAd9WJWcIY7frdLIE
         8eGz/sogb1CEdRNGx2XNfowsx/L6EdoCys8bN/ufcJd+AgrxwXtC1lh7vP4LYt0f1idV
         Fd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780329422; x=1780934222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WY4YPDieV37EdMYLsPozHBfblk0U6F7cKbbQOcc8GXs=;
        b=WSo+5SwLbn2WLBxkN+1F9A9ictLSx0mlJHnTOTMpXCIXX/Fdx2Al16SOgcmtsZ677G
         9C9TTtk+fk6T6cxjDb6xap6KdF942G7JMGGq+Ek22mcsoxYkNMaRP32umvHg9/WmkWry
         WM/RGqUSWMB9IcjDLgLajcfFsqeJy0AlppNcZyPhu2TJrNporcKe9jhh+niSJA7e2qXw
         HrBruSB2l+0gppcBpEfotDqhwdZYLZM3NPPuH08ospW6cJhOQw2rKpui5lKY/0qiYoiE
         SgNaG3QVaQCBWQ2xjg51mJ+fm6+1YzbX4X28oYt0r7KKMf992vjeAJ1Xi9nGlOp2KpiE
         Sbag==
X-Forwarded-Encrypted: i=1; AFNElJ9sPsejBbiTRhpZfjbBmpfHq3383+Zn1K6EjELKaXiVWbUDw2lAInvLWXtP2TrYPy7M4t4xfZMP@vger.kernel.org
X-Gm-Message-State: AOJu0YwXYTFr/PGq8BfIIUC2EMsG5F4B8Ic6iNhjXSOsWCB3oIm+zqSE
	H763AIZQwN3dZqKBsHv7pgO/MilpsjQ9HU+CmUuRmWUeV5hdP5LARBGxLn0oaByMpSpMj/c/0Ks
	yjeDDP9KN0ANDrhePha+mNg67beCVlWE=
X-Gm-Gg: Acq92OHmNqT3bqgCWIluV4Q5/zdLsGoof9+O92v+8DUol8/qpBuc0Y4dbn08JxDRFyS
	fiDkRIGlcxmLPC6dWFgJTcOR/6ofMD/ICVnsTiBWxuHVjVcBoMd4mrh1Z/o0/9JoExg9KRV7ayO
	2vlyUNbRcWZWcPQh5Mc4U9ySMvU/xmBeNIJi2ey8Dxv54UKiNpzhN5QuGhvwTyhqzzfc1v/u1/7
	SOu3YELow3hOkX2IoBFMXayBA+5IuUpdhlmYcMOjZyyLe61TVl9Z9YtTGU5BfvCOEo0U4tjDMSS
	lQLyCNxaYIRatX54pobt/PAakuMsOEOXmwh1WGHJsnAbKtDLDQ==
X-Received: by 2002:a5d:64ed:0:b0:460:1233:ecf2 with SMTP id
 ffacd0b85a97d-4601233eee5mr6740014f8f.30.1780329421236; Mon, 01 Jun 2026
 08:57:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528212955.1912856-1-nphamcs@gmail.com> <ahz_iYG4lqWL4g-J@KASONG-MC4>
In-Reply-To: <ahz_iYG4lqWL4g-J@KASONG-MC4>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 1 Jun 2026 08:56:49 -0700
X-Gm-Features: AVHnY4J3CWVnqj31twB-X3G7CKmr0QCOZt19FSIp451FrmL-DXJf8H_pV0_U-ho
Message-ID: <CAKEwX=PzMwXXgq=ULAkFD9UqMz+ewLqhKt+xdGxkV7OmA2QG6w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] mm, swap: Virtual Swap Space (Swap Table Edition)
To: Kairui Song <ryncsn@gmail.com>
Cc: kasong@tencent.com, Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	apopple@nvidia.com, axelrasmussen@google.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, bhe@redhat.com, byungchul@sk.com, 
	cgroups@vger.kernel.org, chengming.zhou@linux.dev, chrisl@kernel.org, 
	corbet@lwn.net, david@kernel.org, dev.jain@arm.com, gourry@gourry.net, 
	hannes@cmpxchg.org, hughd@google.com, jannh@google.com, 
	joshua.hahnjy@gmail.com, lance.yang@linux.dev, lenb@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, matthew.brost@intel.com, 
	mhocko@suse.com, muchun.song@linux.dev, npache@redhat.com, pavel@kernel.org, 
	peterx@redhat.com, peterz@infradead.org, pfalcato@suse.de, rafael@kernel.org, 
	rakie.kim@sk.com, roman.gushchin@linux.dev, rppt@kernel.org, 
	ryan.roberts@arm.com, shakeel.butt@linux.dev, shikemeng@huaweicloud.com, 
	surenb@google.com, tglx@kernel.org, vbabka@suse.cz, weixugc@google.com, 
	ying.huang@linux.alibaba.com, yosry.ahmed@linux.dev, yuanchu@google.com, 
	zhengqi.arch@bytedance.com, ziy@nvidia.com, kernel-team@meta.com, 
	riel@surriel.com, haowenchao22@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16520-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[tencent.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_GT_50(0.00)[55];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E7AB1622627
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 1, 2026 at 12:34=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Thu, May 28, 2026 at 02:29:24PM +0800, Nhat Pham wrote:
> > Based on: mm-unstable @ 444fc9435e57 + swap-table phase IV v5 [2].
> >
> > I manually adapted Kairui's ghost device implementation (from [4])
> > for my vswap device. I've credited him as Co-developed-by on Patch I
> > since a substantial portion of the dynamic-cluster infrastructure is
> > his (I did propose the idea of using xarray/radix tree for dynamic
> > swap clusters allocation and management though :P).
> >
> > >From here on out, for simplicity, I will refer to swap table phase IV
> > as "P4", and the older v6 virtual swap space implementation as "v6".
> >
>
> ...
>
> >
> > This series reimplements the virtual swap space concept (see [1])
> > on top of Kairui Song's swap table infrastructure, on top of [2]
> > and in accordance with his proposal in [3]. The proposal's idea
> > is interesting, so I decided to give it a shot myself. I'm still not
> > 100% sure that this is bug-proof, but hey, it compiles, and has
> > not crashed in my simple stress testing :)
> >
> > The prototype here is feature-complete relative to the swap-table P4
> > baseline =E2=80=94 swapout, swapin, freeing, swapoff, zswap writeback, =
zswap
> > shrinker, memcg charging, and THP swapin all work for
> > both vswap and direct-physical entries =E2=80=94 and satisfies all thre=
e
> > requirements above: no backend coupling (zswap/zero entries hold no
> > physical slot), dynamic swap space (clusters allocated on demand via
> > xarray, no static provisioning), and efficient backend transfer
> > (in-place vtable updates, no PTE/rmap walking).
> >
> > II. Design
> >
> > With vswap, pages are assigned virtual swap entries on a ghost device
> > with no backing storage. These entries are backed by zswap, zero pages,
> > or (lazily) physical swap slots. Physical backing is allocated only
> > when needed =E2=80=94 on zswap writeback or reclaim writeout, after the=
 rmap
> > step.
> >
> > Compared to the standalone v6 implementation [1], which introduces a
> > 24-byte per-entry swap descriptor and its own cluster allocator, this
> > edition uses swap_table infrastructure, and share a lot of the allocato=
r
> > logic. Per-slot metadata is stored in a tag-encoded virtual_table
> > (atomic_long_t, 8 bytes per slot), and physical clusters store
> > Pointer-tagged rmap entries in the swap_table for reverse lookup back t=
o
> > the virtual cluster.
> >
> > Here are some data layout diagrams:
> >
> >   Case 1: vswap entry (virtualized)
> >
> >   PTE                  swap_cluster_info_dynamic
> >   vswap_entry          +-------------------------+
> >   (swp_entry_t) ------>| swap_cluster_info (ci)  |
> >                        | +--------------------+  |
> >                        | | swap_table         |  |
> >                        | |   PFN / Shadow     |  |
> >                        | | memcg_table        |  |
> >                        | | count,flags,order  |  |
> >                        | | lock, list         |  |
> >                        | +--------------------+  |
> >                        |                         |
> >                        | virtual_table           |
> >                        | +--------------------+  |
> >                        | | NONE               |  |
> >                        | | PHYS               |  |
> >                        | | ZERO               |  |
> >                        | | ZSWAP(entry*)      |  |
> >                        | | FOLIO(folio*)      |  |
> >                        | +--------------------+  |
> >                        +-------------------------+
> >                               |
> >                               | PHYS resolves to
> >                               v
> >                        PHYSICAL CLUSTER (swap_cluster_info)
> >                        +--------------------------+
> >                        | swap_table per-slot:     |
> >                        |   NULL   - free          |
> >                        |   PFN    - cached folio  |
> >                        |   Shadow - swapped out   |
> >                        |   Pointer- vswap rmap    |
> >                        |   Bad    - unusable      |
> >                        |                          |
> >                        | Vswap-backing slot:      |
> >                        |   Pointer(C|swp_entry_t) |
> >                        |     rmap back to vswap   |
> >                        +--------------------------+
> >
> >   Case 2: direct-mapped physical entry (no vswap)
> >
> >   PTE                  PHYSICAL CLUSTER (swap_cluster_info)
> >   phys_entry           +--------------------------+
> >   (swp_entry_t) ------>| swap_table per-slot:     |
> >                        |   NULL   - free          |
> >                        |   PFN    - cached folio  |
> >                        |   Shadow - swapped out   |
> >                        |   Bad    - unusable      |
> >                        +--------------------------+
> >
> > struct swap_cluster_info_dynamic {
> >     struct swap_cluster_info ci;       /* swap_table, lock, etc. */
> >     unsigned int index;                /* position in xarray */
> >     struct rcu_head rcu;               /* kfree_rcu deferred free */
> >     atomic_long_t *virtual_table;      /* backend info, 8 B/slot */
> > };
> >
> > Each vswap cluster (swap_cluster_info_dynamic) extends the classic
> > swap_cluster_info struct with a virtual_table array that stores the
> > backend information for each virtual swap entry in the cluster. Each
> > entry is tag-encoded in the low 3 bits to indicate backend types:
> >
> >   NONE:   |----- 0000 ------|000|  free / unbacked
> >   PHYS:   |-- (type:5,off:N)|001|  on a physical swapfile (shifted)
> >   ZERO:   |----- 0000 ------|010|  zero-filled page
> >   ZSWAP:  |--- zswap_entry* |011|  compressed in zswap
> >   FOLIO:  |--- folio* ------|100|  in-memory folio
>
> Thanks for trying this approach!

Thanks for the suggestions. I hope going forward we have sth concrete
to tinker with, rather than abstractions :P

>
> For the format part, PHYS don't need that much bits I think,
> so by slightly adjust the format vswap device could be share
> mostly the same format with ordinary device.
>
> For example typical modern system don't have a address space larger
> than 52 bit. (Even with full 64 bits used for addressing, shift it
> by 12 we get 52). Plus 5 for type, you get 57, so you can have a
> marker that should work as long as it shorter than 1000000 for PHYS,
> and shared for all table format since it's not in conflict with
> anything. You have also use a few extra bits so a single swap space
> can be 8 times larger than RAM space, and since we can help
> multiple swap type I think that should be far than enough?
>
> Then you have Shadow back at 001, and zero bit in shadow. The only
> special one is Zswap, which will be 100 now, and that's exactly the
> reserved pointer format in current swap table format, on seeing
> si->flags & VSWAP && is_pointer(swp_tb) you know that's zswap :)

Are you suggesting we merge the virtual table with main swap table?

Man, I'd love to do this. There is a problem though - we have a case
where we occupy both backing physical swap AND swap cache. Do you
think we can fit both the physical swap slot handle and the swap cache
PFN into the same slot in virtual table? Maybe with some expanding...?

Another option is we can be a bit smart about it - if a virtual swap
entry is in swap cache AND occupies physical swap slot, then put the
folio at the physical swap's table, use folio->swap as the rmap.

(I think you recommend this approach somewhere but for the life of me
I can't find the reference - apologies if I'm putting words into your
mouth :))

But this is a bit more complicated - extra care is needed for rmap
handling at the physical swap layer, and swap cache handling at the
virtual swap layer. Maybe a follow-up? :)

>
> Folio / PFN can still be 010 as in the current swap table format.
>
> Then everything seems clean and aligned, no more special handling
> for vswap needed, there are detailed to sort out, but it should work.
>
> > - Pointer-tagged swap_table on physical clusters for rmap (physical
> >   -> virtual) lookup.
>
> Or reuse the PHYS format (rename it maybe) since point back to vswap
> is also pointing to a si.

Noted. I'm just doing the simplest thing right now - working
prototype. I mean, we have enough bits :)

>
> > III. Follow-ups:
> >
> > In no particular order (and most of which can be done as follow-up
> > patch series rather than shoving everything in the initial landing):
> >
> > - More thorough stress testing is very much needed.
> >
> > - Performance benchmarks to make sure I don't accidentally regress
> >   the vswap-less case, and that the vswap's case performance is
> >   good. I suspect I will have to port a lot of the
> >   optimizations I implemented in v6 over here - some of the
> >   inefficiencies are inherent in any swap virtualization, and
> >   would require the same fix (for e.g the MRU cluster caching
> >   for faster cluster lookup - see [8] and [9]).
>
> This could be imporved by per-si percpu cluster. Both YoungJun's
> tiering and Baoquan's previous swap ops mentioned this is needed,
> and now vswap also need that. If the vswap is also a si, then it will
> make use of this too.

Yeah I made the same recommendation when I review swap tier last week:

https://lore.kernel.org/all/CAKEwX=3DN2XcMHN1jatppOk6wnmz-Shab5XMtTtzgYOzRv=
U_6YFw@mail.gmail.com/

I like it, but yeah it will be complicated. That said, I think not
fixing the fast path for tiering/vswap will seriously restrict their
usefulness. We don't want to go back to the old swap allocator days :)

We can also revive the swap slot cache, but why do it if we can
repurpose your proven design, and just extend it a bit for multiple
tiers/swap devices? :)

>
> YoungJun posted this a few month before:
> https://lore.kernel.org/linux-mm/20260131125454.3187546-5-youngjun.park@l=
ge.com/
>
> The concern is that some locking contention could be heavier, or maybe
> that's just a hypothetical problem though.

I don't think it's hypothetical. At least with vswap, it's very easy
to get into a state where the shared per-cpu cache gets invalidated
constantly if phys swap and vswap allocation alternates (which is
actually very possible under heavy memory pressure), hammering the
slow paths...

>
> >
> > - Runtime enable/disable of the vswap device. To be honest, I don't
> >   know if there is a value in this. My preference is vswap can be
> >   optimized to the point that any overhead is negligible. Failing that,
> >   maybe we can come up with some simple heuristics that automatically
> >   decides for users?
> >
> >   In this RFC, CONFIG_VSWAP=3Dy means the vswap device is always create=
d at
> >   boot, and CONFIG_VSWAP=3Dn means the vswap device is never created. T=
his
> >   *might* be enough just on its own.
> >
> >   Is a runtime knob (sysfs or sysctl) worth the complexity beyond
> >   these heuristics? I'm not sure yet. Maintaining both cases
>
> I checked the code and I think it's not hard to do, patch 1 already
> handling the meta data dynamically, everything will still just work
> even if you remove vswap at runtime. The rest of patches need adaption
> but might not end up being complex, it other comments here
> are considered.

Yeah, it's not terribily hard to do. I'm more wondering if it's worth
the effort, both for the implementer and the user :)

As I said here, if we want vswap, just enable it at boot time and get
a vast (but dynamic) device. We can make it optional per-cgroup
through Youngjun's interface, and that would be good enough?

>
> For patch 2, a few routines like vswap_can_swapin_thp seems not
> needed or should be moved to __swap_cache_alloc? VSWAP_FOLIO is
> same as swap cache folio check, which is already covered. Same for
> zero checking, and VSWAP_NONE which is same as swap count check
> I think. That way we not only save a lot of code, we also no
> longer need to treat vswap specially.

Unfortunately, I think a lot of this complexity is still needed. Vswap
adds a new layer, which means new complications :)

For instance, I think you still need vswap_can_swapin_thp. It
basically enforces that the backend must be something
swap_read_folio() can handle. That means:

1. No zswap.

2. No mixed backend.

3. If it's phys swap, it must be contiguous in the same device.

The vswap entries might look contiguous in the virtual address space,
but completely unsuitable for the backend.... This is a new
complication that does not previously exist for non-virtualized swap,
so it needs more code to handle it...

I use vswap_can_swapin_thp() in two places - first when we try to find
a candidate range of PTEs for swap in (swap_pte_batch). And then
double check after we've added into swap cache, as the backend can
change arbitrarily before swap cache folio is locked.

Similar for some of the other helpers. For instance,
vswap_swapfile_backed() is needed in certain optimizations or for
correctness's sake, etc.

The VSWAP_FOLIO is redundant, I agree. It's just for convenient. It
represents the state of vswap where it's still in swap (swap cache),
but only backed by the swap cache folio, and not any other backends.
Technically, you can represent it with VSWAP_NONE + a check in the
swap cache field to see if there is a folio there.

If it's not too much code in v2 I can try to remove it (while leaving
behind a comment explains the state).

>
> If you keep the format compatible with what we already have
> as the earlier comment mentions, a large portion of this part
> might be unneeded.
>
> >   at runtime also has overhead for checking as well, and some of the
> >   checks are not cheap :)
>
> I also noticed the new introduced swap_read_folio_phys in patch 3, so
> this actually can be done using Baoquan's swapops idea which is now
> part of Christoph's swap batching:

I'm actually trying to have swap_read_folio() work for both vswap and
phys swpa just with a biiit of if-else. But yeah this might be cleaner
:)

>
> https://lore.kernel.org/linux-mm/20260528124559.2566481-9-hch@lst.de/#r
>
> That series is focusing on batching and better performance but swapops
> was also proposed as a way to solve the virtual layer, makes it possible
> to have vswap as one kind of swapops which is Chris talked a lot about:
>
> https://lore.kernel.org/linux-mm/aZiFvzlBJiYBUDre@MiWiFi-R3L-srv/
>
> Following this, we could have something like:
>
> const struct swap_ops swap_vswap_ops =3D {
>         .submit_write           =3D swap_vswap_submit_write,
>         .submit_read            =3D swap_vswap_submit_read,
> };
>
> The move the folio_realloc_swap in swap_vswap_submit_write.
>
> Merge of IO might be moved to lower phyiscal level for vswap.
>
> Another gain is that the memory usage and CPU overhead will be
> lower with only one layer. As I'm recently trying to offload swap
> dataplane off CPU so the CPU won't touch the data at all, the
> overhead will be purely by swap itself, plus some mm overhead.
> Things like that and IO optimization above and could make swap
> subsystem more and more performance sensitive so we have cases
> that needs only one layer.

Yeah I can take a look at this. This prototype purely based on your P4
and with just a bit of hackery to transfer my v6 implementation over.
Not very clean - just a PoC. If everyone is happy I can put more time
in :)

>
> >
> > - Defer per-cluster memcg_table and zeromap allocation on physical
> >   clusters. A physical swap cluster backing vswap entries only do
> >   not really need their memcg_table, but the current design forces
> >   us to allocate it anyway. This is a waste of memory, and is an
> >   overhead regression compared to my older design on the zswap-only
> >   case, which Johannes has pointed out multiple times (see [6]),
> >   and is one of the biggest reasons why I have not been satisfied
> >   with this approach thus far. It honestly is a bit of a
> >   deal-breaker...
> >
> >   That said, I think I might be able to allocate them on demand, i.e
> >   only when the first direct-mapped slot is allocated on that cluster.
> >   That will give us the best of BOTH worlds, for both the vswap and
> >   directly-mapped physical swap cases. No promises, but I will try
> >   (if this approach is good enough for all parties).
>
> Zero map is not really a problem when it's just a inlined bit I think.

Yeah no problemo indeed. I saw a zeromap field in struct phys swap
cluster, so I put this in the plan as "to remove later", but I just
took a look and realized it's only for cases where you cant fit the
bit in swap table. I'm gating vswap for 64 bit for now, so should not
be a problem.

> For memcg table allocation, on demand seems a good idea, and actually
> we are not far from there, I tried to generalize the
> alloc-then-retry-sleep-alloc in swap_alloc_table but still not generic
> enough I guess.. Good new is the allocation of the table is already
> kind of ondemand, just need to split the detection of these two kind
> of table.

I have a prototype of this, but I have not tested, so I do not want to
send it out. :)

TLDR is - I still want to record the memcg for vswap (just not charge
it towards the counter). So we still need memcg_table at both level,
generally - just not allocating until needed (basically if a physical
swap slot in the cluster is directly mapped into PTE). You can kinda
tell, since you pass the folio into the allocation path - with some
care you can distinguish between:

1. Virtual swap, or directly maped physical swap -> need memcg_table

2. Physical swap, backing vswap -> does not memcg_table.

Another alternative is you can defer this allocation until the point
where you have to do the charging action. But then you have to be
careful with failure handling, and need to backoff ya di da di da.
Funsies.

I think I did a mixed of these 2 strategies. Anyway, I'll include the
patch in v2 (if folks like this approach).

>
> Mean while I also remember we once discussed about splitting the
> accounting for vswap / physical swap? If we went that approach we
> don't need to treat memcg_table specially.

For the charging behavior, I already have a patch for it actually in
this series (just not the dynamic allocation of the memcg_table field
yet).

Basically:

1. For vswap entry, not backed by phys swap: record swap memcg, hold
reference to pin the memcg, but not charging towards swap.current.

2. For phys swap backing vswap: charging towards swap.current, but
does not record the memcg in its memcg_table, nor does it hold
reference to memcg (its vswap entry holds the reference already)

2. For phys swap directly mapped to PTE: charges, records, and holds refere=
nce.

The motivation here is I do not want vswap entry to shares the same
limit as phys swap counter. If we think of it as "infinite" or
"dynamic", it should not be capped at all, but even if it is charged,
it should be something separate.

>
> > - Widen swap_info_struct->max to unsigned long. The vswap device's
> >   max is currently clamped to ALIGN_DOWN(UINT_MAX, SWAPFILE_CLUSTER)
> >   (~16 TiB) to fit in unsigned int. 16 TiB is small for vswap,
> >   especially when we're getting increasingly big machines memory-wise.
>
> This should be very easy to do, just replace unsigned int with
> unsigned long, a lot of place to touch though :)

Agree. I'm just lazy, and this sounds like a simple patch as a
follow-up. This RFC is already 2000 LoCs - I do not want to burden
reviewers with extra useless details :)

