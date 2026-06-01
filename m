Return-Path: <cgroups+bounces-16522-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOyZHjy0HWqkdAkAu9opvQ
	(envelope-from <cgroups+bounces-16522-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 18:33:00 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C966229AD
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 18:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D62530D1325
	for <lists+cgroups@lfdr.de>; Mon,  1 Jun 2026 16:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2D63019D6;
	Mon,  1 Jun 2026 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfX+r+JO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38362EC081
	for <cgroups@vger.kernel.org>; Mon,  1 Jun 2026 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330945; cv=pass; b=RkKWtnRnovOBx9CvDaTd8+b/66l99b24ut0J+Mp36Oif/OoWsTZNDUEphBZ1TtKh49B+U3kbeEY67CtTg+ZBNTda7spOl01Y9PJFeCEhr6ABT9Xl9kCbRSH3owG3559se/zBMFKiFLnZiF4XCWjwlpnFCbCesKc7gOrvq5BFdnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330945; c=relaxed/simple;
	bh=/Fi30s2ufSVmNT3STVyPDyIcEBwKewau9ptWSY5xCfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sz/rKhxiAvBVu1PPeFA+XKcusrVIVZH2fZyhINf3tJb/fFawMDYTUi4esBO3DejQT+Rl54Zu2w0+k4U+VTyImfM/kdG65E++B9DZ41sZdmRKqmOtYWcrLc6XAcrL9paz5CIPmsZb/rV/tw8FIg9QGLvEfUJwCs1HZsNaXCyiIbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfX+r+JO; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45fe59255beso898636f8f.1
        for <cgroups@vger.kernel.org>; Mon, 01 Jun 2026 09:22:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780330942; cv=none;
        d=google.com; s=arc-20240605;
        b=fQumCoYdvYVNoxyCgXU/eM3nBvsbFkjwKRIORDRf0oobbcyUxVHenJd3VNyJg//OPX
         d4cpQPptf8p9e2e5ZfSiOTqtim3/h6ejUGCZu6qG8RXxR3VeFidUkVNMJzMT5tqC3hTQ
         PtGGF6YgEtlAwLb4R5Y1gaWaWjlrJVKq2yA1j8qoomZ81+aGZMWV3yprilaz1gzRmJPU
         c8R2YMh3DTHhV0W0Jo/q5XOa12hIRUwNhEb445iAjt53gHJLNfUxRt1NPiZ0lED0FBki
         xf0OgNTeyw+2eNUXt0Bh22RKrq+B5KpNCW//4kigiLOBUaXR4XYGjIdpOO3txF7IJpCv
         Z2Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NIJLBXqk7z3zxdRemjxiJJ4oIzR7i1a+F8x00il1qyw=;
        fh=NYeS+D5pxHlceX3RGGokKJd5hzmKX33FYxfypo1pKXo=;
        b=F/EcTF6pNL7YwXlx6YjEcZ9DVdEKwu2cm2jpgTTTKdH91KVlIBzDOKO4jebhbk8YN5
         RZgzfx54rCz2iOTS1zSq9mEeBBZ5HwEnvQhPe9W6EjUzkScpZkJzxwvpvcNEvUmv4Dne
         0cRmiz5x0pSx+mBFHkK4a2feB8TXMwZbBP51gM3fSaBBKvRt4swwDgSmoj4NCB65V5g/
         Rh9WD8IKjmDzYaumMvq18r8X7nylovjylYPRd714B6xKrTHq4bBbQUGyBMGfsenoXwHY
         RXGveA1pxm1RiMag+BI7O11reGzxsyJPqUm9o4gmQVQkLsWPhNJ22hIAICsnfYZz/a7g
         DtGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780330942; x=1780935742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIJLBXqk7z3zxdRemjxiJJ4oIzR7i1a+F8x00il1qyw=;
        b=OfX+r+JO2GfNsPNbwL5NOSLKoL3br4Ub1ZTmSd79LaGOnRxWtDgwaa6a+Ggzuhl+3n
         v35D6cuf+OUjdynp4qgS/yc4DUmBJQA56xpUfHTdpMNGgep4/T78hlXhNlkTwhQwW2nE
         ksqZJE7HV4e6UZjLLrJrxHBGrMhkAmNGydezUqbFT+iWBCyF1SC9KPJWgGoDXFPBy98W
         5vK0Tpw+rdDqYDYGa3iQT3TgL/V17ZxVkAzia/f8t5rb4fW0OAvb1QF41ufoRiXINaSg
         ejU6AJcXNUKVbVOnZJsR80/1TXsw0hkC+9pS3VuLRHwqXRSQdUgZPxeT8osYYYL+DGW2
         JiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780330942; x=1780935742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NIJLBXqk7z3zxdRemjxiJJ4oIzR7i1a+F8x00il1qyw=;
        b=Naho9X8Yx7GyhGzta9acdIyQSgszE18nq4PqpwVMkCcfy65tzEn+qVN/An7fMXWhyi
         tBHhRUKa22TSppjyoASMlZOP6S7ds940H0IrPTATW3sXNMMVNmMR9In8ysk40y3tAMlw
         4GLX7a8MTCdgbvsDLAJ0Ull6oFxiookVcMnq7OQ3bf5ZgM6F3jHjqEi/16d+axAszSEi
         68WbsiBPw527z3A2WRLFIXtpAXblUPTWhJfP1GRPmFtYwppZyXOH/NnltBuSU2gUZCMZ
         TU1nZSEcen92wgIXp0SGNWc02OMvCYxM9XXyvnhsMFXjT4V0b7JbfiQU9DzTnFEOYb0j
         EZ8Q==
X-Forwarded-Encrypted: i=1; AFNElJ/2zJKsmJ1bg/EXfB/4iWvU1YsJ6awAwXKpewpG/93wksST+5Er4etTJTSepX0MpX9A2oE/KPTo@vger.kernel.org
X-Gm-Message-State: AOJu0YyWD6XSZFq3i/QWNspNAMdProFb2UynchIaIXlpP3IMCW26Zdzx
	dXLK96H7ODXTlxXeaP2tSchJn+mo2GvAmGB4AiG+qLN9MYA6lNU9nta2MAOgq18DYTuxtw+Y+75
	dDu61DAGKAU3een1b4VWw3EI8RUAxVTZs73O5XSk=
X-Gm-Gg: Acq92OFpIegO7HO8h5pbc6J9Lj8XcP6v9wrYCSPHlcHUMSWZebUwCB2KMrUrGdcMNO3
	A6N68sMORIi0fCTgp5Fl0KAzsqR4+bJ1nYZZMgG76JolqvM0xeBCCgYeJ6ucuFQjK6PUQdP3r7K
	3tSaq+ZJcpy3I/Y06K0C7EEkK7cqdPsJcUa/J8pXON2nHlDgG1BcgvF61NSjlQlk/9wWsSsqv8N
	UZqmUfCwMdu+hgC5j48ECFLLaFHEA9CpmoNfxFZ4A6wCVsMgr2mT0/oFAwzcBlTaUQRCM9q98AA
	2vbzAK1YAp0StAxONvkd+l485a9YO4+CbuXk3iB9jkiHLThUhA==
X-Received: by 2002:a05:6000:4606:b0:45e:da57:be33 with SMTP id
 ffacd0b85a97d-45ef6b7fc88mr21958786f8f.23.1780330941755; Mon, 01 Jun 2026
 09:22:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528212955.1912856-1-nphamcs@gmail.com> <ahz_iYG4lqWL4g-J@KASONG-MC4>
 <CAKEwX=PzMwXXgq=ULAkFD9UqMz+ewLqhKt+xdGxkV7OmA2QG6w@mail.gmail.com>
In-Reply-To: <CAKEwX=PzMwXXgq=ULAkFD9UqMz+ewLqhKt+xdGxkV7OmA2QG6w@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 1 Jun 2026 09:22:09 -0700
X-Gm-Features: AVHnY4JTa-fR_5tUyRZOpBI2CAX77bPy73iuDZGeYtyu2utS9mSBpebHo1xGb-U
Message-ID: <CAKEwX=NNNf0KCZC0ph7VRW0gjnbXd4W5NKEaHM4XzPdN03Ek3A@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16522-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D5C966229AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 1, 2026 at 8:56=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Mon, Jun 1, 2026 at 12:34=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > On Thu, May 28, 2026 at 02:29:24PM +0800, Nhat Pham wrote:
> > > Based on: mm-unstable @ 444fc9435e57 + swap-table phase IV v5 [2].
> > >
> > > I manually adapted Kairui's ghost device implementation (from [4])
> > > for my vswap device. I've credited him as Co-developed-by on Patch I
> > > since a substantial portion of the dynamic-cluster infrastructure is
> > > his (I did propose the idea of using xarray/radix tree for dynamic
> > > swap clusters allocation and management though :P).
> > >
> > > >From here on out, for simplicity, I will refer to swap table phase I=
V
> > > as "P4", and the older v6 virtual swap space implementation as "v6".
> > >
> >
> > ...
> >
> > >
> > > This series reimplements the virtual swap space concept (see [1])
> > > on top of Kairui Song's swap table infrastructure, on top of [2]
> > > and in accordance with his proposal in [3]. The proposal's idea
> > > is interesting, so I decided to give it a shot myself. I'm still not
> > > 100% sure that this is bug-proof, but hey, it compiles, and has
> > > not crashed in my simple stress testing :)
> > >
> > > The prototype here is feature-complete relative to the swap-table P4
> > > baseline =E2=80=94 swapout, swapin, freeing, swapoff, zswap writeback=
, zswap
> > > shrinker, memcg charging, and THP swapin all work for
> > > both vswap and direct-physical entries =E2=80=94 and satisfies all th=
ree
> > > requirements above: no backend coupling (zswap/zero entries hold no
> > > physical slot), dynamic swap space (clusters allocated on demand via
> > > xarray, no static provisioning), and efficient backend transfer
> > > (in-place vtable updates, no PTE/rmap walking).
> > >
> > > II. Design
> > >
> > > With vswap, pages are assigned virtual swap entries on a ghost device
> > > with no backing storage. These entries are backed by zswap, zero page=
s,
> > > or (lazily) physical swap slots. Physical backing is allocated only
> > > when needed =E2=80=94 on zswap writeback or reclaim writeout, after t=
he rmap
> > > step.
> > >
> > > Compared to the standalone v6 implementation [1], which introduces a
> > > 24-byte per-entry swap descriptor and its own cluster allocator, this
> > > edition uses swap_table infrastructure, and share a lot of the alloca=
tor
> > > logic. Per-slot metadata is stored in a tag-encoded virtual_table
> > > (atomic_long_t, 8 bytes per slot), and physical clusters store
> > > Pointer-tagged rmap entries in the swap_table for reverse lookup back=
 to
> > > the virtual cluster.
> > >
> > > Here are some data layout diagrams:
> > >
> > >   Case 1: vswap entry (virtualized)
> > >
> > >   PTE                  swap_cluster_info_dynamic
> > >   vswap_entry          +-------------------------+
> > >   (swp_entry_t) ------>| swap_cluster_info (ci)  |
> > >                        | +--------------------+  |
> > >                        | | swap_table         |  |
> > >                        | |   PFN / Shadow     |  |
> > >                        | | memcg_table        |  |
> > >                        | | count,flags,order  |  |
> > >                        | | lock, list         |  |
> > >                        | +--------------------+  |
> > >                        |                         |
> > >                        | virtual_table           |
> > >                        | +--------------------+  |
> > >                        | | NONE               |  |
> > >                        | | PHYS               |  |
> > >                        | | ZERO               |  |
> > >                        | | ZSWAP(entry*)      |  |
> > >                        | | FOLIO(folio*)      |  |
> > >                        | +--------------------+  |
> > >                        +-------------------------+
> > >                               |
> > >                               | PHYS resolves to
> > >                               v
> > >                        PHYSICAL CLUSTER (swap_cluster_info)
> > >                        +--------------------------+
> > >                        | swap_table per-slot:     |
> > >                        |   NULL   - free          |
> > >                        |   PFN    - cached folio  |
> > >                        |   Shadow - swapped out   |
> > >                        |   Pointer- vswap rmap    |
> > >                        |   Bad    - unusable      |
> > >                        |                          |
> > >                        | Vswap-backing slot:      |
> > >                        |   Pointer(C|swp_entry_t) |
> > >                        |     rmap back to vswap   |
> > >                        +--------------------------+
> > >
> > >   Case 2: direct-mapped physical entry (no vswap)
> > >
> > >   PTE                  PHYSICAL CLUSTER (swap_cluster_info)
> > >   phys_entry           +--------------------------+
> > >   (swp_entry_t) ------>| swap_table per-slot:     |
> > >                        |   NULL   - free          |
> > >                        |   PFN    - cached folio  |
> > >                        |   Shadow - swapped out   |
> > >                        |   Bad    - unusable      |
> > >                        +--------------------------+
> > >
> > > struct swap_cluster_info_dynamic {
> > >     struct swap_cluster_info ci;       /* swap_table, lock, etc. */
> > >     unsigned int index;                /* position in xarray */
> > >     struct rcu_head rcu;               /* kfree_rcu deferred free */
> > >     atomic_long_t *virtual_table;      /* backend info, 8 B/slot */
> > > };
> > >
> > > Each vswap cluster (swap_cluster_info_dynamic) extends the classic
> > > swap_cluster_info struct with a virtual_table array that stores the
> > > backend information for each virtual swap entry in the cluster. Each
> > > entry is tag-encoded in the low 3 bits to indicate backend types:
> > >
> > >   NONE:   |----- 0000 ------|000|  free / unbacked
> > >   PHYS:   |-- (type:5,off:N)|001|  on a physical swapfile (shifted)
> > >   ZERO:   |----- 0000 ------|010|  zero-filled page
> > >   ZSWAP:  |--- zswap_entry* |011|  compressed in zswap
> > >   FOLIO:  |--- folio* ------|100|  in-memory folio
> >
> > Thanks for trying this approach!
>
> Thanks for the suggestions. I hope going forward we have sth concrete
> to tinker with, rather than abstractions :P
>
> >
> > For the format part, PHYS don't need that much bits I think,
> > so by slightly adjust the format vswap device could be share
> > mostly the same format with ordinary device.
> >
> > For example typical modern system don't have a address space larger
> > than 52 bit. (Even with full 64 bits used for addressing, shift it
> > by 12 we get 52). Plus 5 for type, you get 57, so you can have a
> > marker that should work as long as it shorter than 1000000 for PHYS,
> > and shared for all table format since it's not in conflict with
> > anything. You have also use a few extra bits so a single swap space
> > can be 8 times larger than RAM space, and since we can help
> > multiple swap type I think that should be far than enough?
> >
> > Then you have Shadow back at 001, and zero bit in shadow. The only
> > special one is Zswap, which will be 100 now, and that's exactly the
> > reserved pointer format in current swap table format, on seeing
> > si->flags & VSWAP && is_pointer(swp_tb) you know that's zswap :)
>
> Are you suggesting we merge the virtual table with main swap table?
>
> Man, I'd love to do this. There is a problem though - we have a case
> where we occupy both backing physical swap AND swap cache. Do you
> think we can fit both the physical swap slot handle and the swap cache
> PFN into the same slot in virtual table? Maybe with some expanding...?
>
> Another option is we can be a bit smart about it - if a virtual swap
> entry is in swap cache AND occupies physical swap slot, then put the
> folio at the physical swap's table, use folio->swap as the rmap.
>
> (I think you recommend this approach somewhere but for the life of me
> I can't find the reference - apologies if I'm putting words into your
> mouth :))
>
> But this is a bit more complicated - extra care is needed for rmap
> handling at the physical swap layer, and swap cache handling at the
> virtual swap layer. Maybe a follow-up? :)
>
> >
> > Folio / PFN can still be 010 as in the current swap table format.
> >
> > Then everything seems clean and aligned, no more special handling
> > for vswap needed, there are detailed to sort out, but it should work.
> >
> > > - Pointer-tagged swap_table on physical clusters for rmap (physical
> > >   -> virtual) lookup.
> >
> > Or reuse the PHYS format (rename it maybe) since point back to vswap
> > is also pointing to a si.
>
> Noted. I'm just doing the simplest thing right now - working
> prototype. I mean, we have enough bits :)
>
> >
> > > III. Follow-ups:
> > >
> > > In no particular order (and most of which can be done as follow-up
> > > patch series rather than shoving everything in the initial landing):
> > >
> > > - More thorough stress testing is very much needed.
> > >
> > > - Performance benchmarks to make sure I don't accidentally regress
> > >   the vswap-less case, and that the vswap's case performance is
> > >   good. I suspect I will have to port a lot of the
> > >   optimizations I implemented in v6 over here - some of the
> > >   inefficiencies are inherent in any swap virtualization, and
> > >   would require the same fix (for e.g the MRU cluster caching
> > >   for faster cluster lookup - see [8] and [9]).
> >
> > This could be imporved by per-si percpu cluster. Both YoungJun's
> > tiering and Baoquan's previous swap ops mentioned this is needed,
> > and now vswap also need that. If the vswap is also a si, then it will
> > make use of this too.

Oh and the MRU cluster caching I mentioned here is not the allocation
caching. It's the lookup caching, basically to avoid doing the
xa_load() to look up clusters for consecutive swap operations on the
same vswap cluster (which is the common case with vswap). For v6, it
massively reduces this indirection lookup overhead. Performance-wise
it's an absolute winner, just more complexity (because I need to
handle reference counting carefully).

I also just realized we'll induce the indirection overhead on
allocation here too, even if the cached cluster still have slots for
allocation, because we look up the cluster (which is basically free
for static swap device, but not free for vswap devices). Might need to
take care of that to maintain vswap performance (but it will then
diverge from your existing code...).

