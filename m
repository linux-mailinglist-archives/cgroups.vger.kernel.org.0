Return-Path: <cgroups+bounces-16629-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wQ5DEZCCIGoH4gAAu9opvQ
	(envelope-from <cgroups+bounces-16629-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 21:37:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F5063AE6D
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 21:37:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OgFHQ493;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16629-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16629-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 744F63002D27
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 19:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA84648C3EB;
	Wed,  3 Jun 2026 19:35:40 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F5D48BD21
	for <cgroups@vger.kernel.org>; Wed,  3 Jun 2026 19:35:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780515340; cv=none; b=m52XrayU8/yOvgyLZK4MIy7qgjoEip6kgGID55TEEnr/7ZwWTxkR0aTXZb9tXJyoT3A/2SJ8noHOGOqXQNlnZtgkM0KCWOmWMDoZxe9BauACGo7G0Q7kh6BFsvp/1A07zUamxpQkeeh+M/8h54H0Xd1dMgTkHDiLpkP2Cm8Kr/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780515340; c=relaxed/simple;
	bh=u07LQCZrZCzeOi68gImmUZITUxsNpQXTkBl3ocL8ckA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKtzkQGkArtI1WxPasDiM52Z2YmEdNP+sTV5mz3GYHEm4eEf+5jnWu7Bplhu8xVKiuRb68LyMAur+F6mX36uJKHNp/vdtTUQIBfFMxRU+ul/PdYXu6mMyjva+PhIGOSzw5yE+u7/abccuvKQqCSzblol3n4bjs0eWrvfUgcEkck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgFHQ493; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312171F008A2
	for <cgroups@vger.kernel.org>; Wed,  3 Jun 2026 19:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780515339;
	bh=u07LQCZrZCzeOi68gImmUZITUxsNpQXTkBl3ocL8ckA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OgFHQ493hTJ63/qV3zKt0iFy8gG6gnwdqpUoqFL/HL8Ocgwi+S9/T1lbbDR8GnBnw
	 A7r0O+1PebrP/DXacX+3BZugw8Q29FvXNApWlxLHOWPCpspM5IvbGcS+6kpq+r1WGM
	 UqZ5lbK4mMRvmVmaBEplCrwgyEq8ZASi94zgXTCBl8VlW3xh0ZGGAiwtUBNVM03qiP
	 7xBkH4K4jY+nOqf9V8cw8uHmxhKKrINKUvkVaLEScqd0gTyr9PyhGwAW8oBqdI+b0p
	 jx7yh7GmV1LtqAMma4Jr1ObhZP2xLUH/C5yY+fVzZn/0VRdaY3pIS/Jeomvjl5JWKx
	 pwv9+JcPBrz+w==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bebbc325000so565173066b.0
        for <cgroups@vger.kernel.org>; Wed, 03 Jun 2026 12:35:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/aXheOLZFgMMUKhivwRHexELSWLh4rTOSBEOBrwZ8m/F5ODBR1VIY4dLuH8fljqPbEEy71avLy@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0cZnVns6QrvB5kOc3jPxdFpkYBTLUxJ14Q8nTHBgQ+S7AFJn3
	SLwiFYht+zAVvJCsCEqX9SgsUUNUxzl8B6M+RvGZZXKc1Ej4dUx7I4k6rxjM8Ias0dJSL5mT3VG
	0iDUOp0lg++krIV1Zl612Cbq/paTo37A=
X-Received: by 2002:a17:907:1de8:b0:bee:bcf6:6a22 with SMTP id
 a640c23a62f3a-bf0b3ab6000mr194330866b.44.1780515337855; Wed, 03 Jun 2026
 12:35:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528212955.1912856-1-nphamcs@gmail.com> <ah-A2gQ0GPgerXop@google.com>
 <CAKEwX=MWX9KkSFAoN4xEMg3b+gZUN9=yd7rirAWG5NOBf26eAg@mail.gmail.com>
 <aiB2sHqxcBAJrTkP@google.com> <CAKEwX=P95D7wNpWhEAXQpeNPM6eQa2mEZE8Srzfpct=-=Q40tg@mail.gmail.com>
In-Reply-To: <CAKEwX=P95D7wNpWhEAXQpeNPM6eQa2mEZE8Srzfpct=-=Q40tg@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 3 Jun 2026 12:35:26 -0700
X-Gmail-Original-Message-ID: <CAO9r8zP+PkgRzXJcFv+3i2pKFQdLt78Ax1s1DY0qNaiUo7ySqA@mail.gmail.com>
X-Gm-Features: AVHnY4L0m0RhGOnZt-UIR2Jm32pDGFi3b0zgu6vy44XckaL7GIMQMtilhMhRPjY
Message-ID: <CAO9r8zP+PkgRzXJcFv+3i2pKFQdLt78Ax1s1DY0qNaiUo7ySqA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] mm, swap: Virtual Swap Space (Swap Table Edition)
To: Nhat Pham <nphamcs@gmail.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16629-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[tencent.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:nphamcs@gmail.com,m:kasong@tencent.com,m:Liam.Howlett@oracle.com,m:akpm@linux-foundation.org,m:apopple@nvidia.com,m:axelrasmussen@google.com,m:baohua@kernel.org,m:baolin.wang@linux.alibaba.com,m:bhe@redhat.com,m:byungchul@sk.com,m:cgroups@vger.kernel.org,m:chengming.zhou@linux.dev,m:chrisl@kernel.org,m:corbet@lwn.net,m:david@kernel.org,m:dev.jain@arm.com,m:gourry@gourry.net,m:hannes@cmpxchg.org,m:hughd@google.com,m:jannh@google.com,m:joshua.hahnjy@gmail.com,m:lance.yang@linux.dev,m:lenb@kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-pm@vger.kernel.org,m:lorenzo.stoakes@oracle.com,m:matthew.brost@intel.com,m:mhocko@suse.com,m:muchun.song@linux.dev,m:npache@redhat.com,m:pavel@kernel.org,m:peterx@redhat.com,m:peterz@infradead.org,m:pfalcato@suse.de,m:rafael@kernel.org,m:rakie.kim@sk.com,m:roman.gushchin@linux.dev,m:rppt@kernel.org,m:ryan.roberts@arm.com,m:shakeel.butt@linux.dev,m:shikemeng@huaweicloud.com,m:s
 urenb@google.com,m:tglx@kernel.org,m:vbabka@suse.cz,m:weixugc@google.com,m:ying.huang@linux.alibaba.com,m:yosry.ahmed@linux.dev,m:yuanchu@google.com,m:zhengqi.arch@bytedance.com,m:ziy@nvidia.com,m:kernel-team@meta.com,m:riel@surriel.com,m:haowenchao22@gmail.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[55];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 41F5063AE6D

On Wed, Jun 3, 2026 at 12:26=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Wed, Jun 3, 2026 at 11:58=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > > > I assume the main reason here is to avoid the extra overhead if
> > > > everything uses vswap, which would mainly be the reverse mapping
> > > > overhead? I guess there's also some simplicity that comes from reus=
ing
> > > > the swap info infra as a whole, including the swap table.
> > >
> > > Yeah it helps a lot that we don't have to rewrite the whole allocator
> > > and swap entry reference counting logic again :)
> >
> > I specifically meant using a full swap info thing for the physical swap
> > device even when it's behind vswap. That seems like an overkill, and we
> > don't need things like the swap entry reference coutning. We probably
> > just need a bitmap and a reverse mapping.
> >
> > So I am assuming the main reason why we are not doing that (at least fo=
r
> > now) is simplicity?
>
> Mostly.
>
> FWIW, we're pretty close to full deduplication. Right now, physical
> swap clusters have a couple of fields that are not needed when they're
> backing a vswap cluster:
>
> 1. The main swap table (which houses swap cache, swap shadow, and
> reference counting): I repurpose it for the rmap :) It's an array of
> unsigned long, which works for rmap.
>
> 2. memcg_table: still duplicated, but I think I can make sure this is
> not allocated if physical swap clusters only back vswap entries. I
> have a prototype that I'm testing for this.
>
> 3. The zeromap field: this is actually not allocated in 64 bit
> architecture, IIUC, which is what I'm gating CONFIG_VSWAP on. If we
> extend vswap to supporting 32 bits, this can also be dynamically
> allocated.
>
> 4. Extend table - this is for the swap count overfills, and already
> dynamically allocated.

I see.

> > > > All that being said, perhaps I am too out of touch with the code to
> > > > realize it's simply not possible.
> > > >
> > > > Honestly, if the main reason we can't have a single swap table for =
vswap
> > > > is saving 8 bytes on the reverse mapping, it sounds like a weak-ish
> > > > argument, even if we can't optimize the reverse mapping away. But m=
aybe
> > > > I am also out of touch with RAM prices :)
> > >
> > > In terms of the space overhead I do agree, FWIW :)
> > >
> > > I think the other concern is the indirection overhead with going
> > > through the xarray for every swap operation, hence the per-CPU vswap
> > > cluster lookup caching idea:
> > >
> > > https://lore.kernel.org/all/20260505153854.1612033-23-nphamcs@gmail.c=
om/
> >
> > Right, but we should already avoid the xarray with the swap table
> > design, right? We just have one swap table pointing to another
> > essentially?
>
> Hmmm, I don't quite follow your suggestion here.
>
> For normal swap devices, we organize the space into clusters, and
> maintain them in various lists (free, nonfull, full etc.). The only
> difference with a vswap device is we do not have a free list, and have
> the clusters themselves dynamically allocated.
>
> If we're using vswap, we will incur the xarray overhead. There's no
> avoiding that if we want a dynamic indirection layer. We can of course
> revisit this data structure design later.
>
> So yes, it will be one swap table (vswap cluster) pointing to another
> swap table (pswap cluster). But to get to the first swap table, you
> will have to go through xarray still.

Why the xarray? Don't page tables (and shmem page cache) just point
directly to the vswap entry the same way they point to swap entries
today?

*looks at the code*

Oh, it's to find the actual cluster because the vswap file can be
sparse? Hmm yeah I guess we can revisit the data structure here later,
but IIRC xarrays aren't particularly good for sparse data. Maybe it's
usually not sprase in practice.

Maybe a maple tree? :)

> > > If folks like it, what I can do is have CONFIG_ZSWAP depends on
> > > CONFIG_VSWAP, removes all the non-vswap logic, and call it a day? :)
> > > Then, on the swap allocation side, if vswap allocation fail and zswap
> > > writeback is disabled, we can error out early.
> >
> > Hmm maybe we can keep it around for now and do that after vswap
> > stabilizes? It ultimately depend on how much complexity we maintain by
> > allowing both.
> >
> > I think another problem is 32-bit, technically zswap can be used on
> > 32-bit now, right? So vswap not supporitng 32-bit is a problem.
>
> Ah shoot I forgot about that. Hmmm.
>
> It's not impossible to make vswap support 32-bit. I did that for v6
> after all. It just needs extra fields because we have fewer bits to
> leverage in pointers etc., complicating the logic a bit. Follow-up
> work? :)

Yeah we can do that, but it's a blocker for zswap only using vswap.

> > General question (for both zswap and general swap code), would a boot
> > param make implementation simpler? Right now we seem to key off the swa=
p
> > device having the "vswap" flag, would it help if it was a runtime
> > constant?
>
> Hmmm, even if it's a runtime constant, both branches still have to be
> there, no? Does the boot param simplify it somehow?

Maybe it doesn't simplify the code, but if the branching causes
performance overhead we can use static keys. I guess we can still use
static keys per-swapfile, but it would be more complicated.

Anyway, not super important now.

