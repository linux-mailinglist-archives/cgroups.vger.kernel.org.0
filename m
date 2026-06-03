Return-Path: <cgroups+bounces-16626-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HZ5XEpp6IGp04AAAu9opvQ
	(envelope-from <cgroups+bounces-16626-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 21:03:54 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B62DE63ABC3
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 21:03:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FGsrNp4V;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16626-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16626-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 224CB305AD2A
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 18:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5BC48123A;
	Wed,  3 Jun 2026 18:58:55 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A20D175A86;
	Wed,  3 Jun 2026 18:58:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780513135; cv=none; b=nON8L3rxZad4TkihF6bwdNjBzL3XOJo0S0lFowY0EaKFIm2LZOAymyxTn1/nzyreMn/IdjQJZmtG7zu0QguAdKZbj2Btvf8mhW1CJh+AOu6SiSZLaJJJMg97+sw4sUCeUw4x8vYzaFXFAR/pS9ZBiuwBAg5Q7Q8I+7b+59qkkv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780513135; c=relaxed/simple;
	bh=J+TlwXD7dOlvOSdHXvi7ugjYUf2PrQZJf8lyb1a9oPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0d+z7IHDAZ/f1jkq1PGvEOqE1FXjOkdBqZ0nThnyd5OB4K57PfdbTwV9SRXNvcvgUcvN6gLhzecffmA0uMEztuznD7O6DCJ1E7Z16VODYqSG3Z6NmODQr1R3Fg1GijNjXi9k7i1t6E23f/Jo6pJ+RCzzXxoRmnnjizIHdwHN24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGsrNp4V; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E559A1F00893;
	Wed,  3 Jun 2026 18:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780513133;
	bh=U7NW7GBbndKKy+0XI/JSnMfnKxb8c9R/OkuZ5OvLGXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FGsrNp4Vc2QMRZcccyTX2RnTiuRZ0l5wgp2+kPbOnGRkZHVclJobF4pcYjuyt4H0J
	 Q+8jplS7HCL/TPG/UEWSqpFougpcC07AxrW4FNJEgy8Wuw0YVNVJIp9D06lIhl/xBL
	 7oV2LJZRP/i54zmx+8j5y0I5EdINUQh89qMMotviHkrYDGrsCiir9khVNVlvat+f5c
	 8Iw5tjqYi2zGEy4tEDKkpBZ+eY55Ce+aT/Sz8qzZGqj4QBBe13WSI8yLMualo2KMhs
	 stVjTHlcVqE58+WKekHjLX0IVOb0nCE2lgVOg1tik7I5u+c/5WrcUtCl28scHSAfM2
	 Ac+upOUDWzP4w==
Date: Wed, 3 Jun 2026 18:58:50 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: kasong@tencent.com, Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	apopple@nvidia.com, axelrasmussen@google.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, bhe@redhat.com, byungchul@sk.com, cgroups@vger.kernel.org, 
	chengming.zhou@linux.dev, chrisl@kernel.org, corbet@lwn.net, david@kernel.org, 
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, 
	jannh@google.com, joshua.hahnjy@gmail.com, lance.yang@linux.dev, lenb@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, matthew.brost@intel.com, 
	mhocko@suse.com, muchun.song@linux.dev, npache@redhat.com, pavel@kernel.org, 
	peterx@redhat.com, peterz@infradead.org, pfalcato@suse.de, rafael@kernel.org, 
	rakie.kim@sk.com, roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com, 
	shakeel.butt@linux.dev, shikemeng@huaweicloud.com, surenb@google.com, tglx@kernel.org, 
	vbabka@suse.cz, weixugc@google.com, ying.huang@linux.alibaba.com, 
	yosry.ahmed@linux.dev, yuanchu@google.com, zhengqi.arch@bytedance.com, ziy@nvidia.com, 
	kernel-team@meta.com, riel@surriel.com, haowenchao22@gmail.com
Subject: Re: [RFC PATCH 0/5] mm, swap: Virtual Swap Space (Swap Table Edition)
Message-ID: <aiB2sHqxcBAJrTkP@google.com>
References: <20260528212955.1912856-1-nphamcs@gmail.com>
 <ah-A2gQ0GPgerXop@google.com>
 <CAKEwX=MWX9KkSFAoN4xEMg3b+gZUN9=yd7rirAWG5NOBf26eAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKEwX=MWX9KkSFAoN4xEMg3b+gZUN9=yd7rirAWG5NOBf26eAg@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16626-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nphamcs@gmail.com,m:kasong@tencent.com,m:Liam.Howlett@oracle.com,m:akpm@linux-foundation.org,m:apopple@nvidia.com,m:axelrasmussen@google.com,m:baohua@kernel.org,m:baolin.wang@linux.alibaba.com,m:bhe@redhat.com,m:byungchul@sk.com,m:cgroups@vger.kernel.org,m:chengming.zhou@linux.dev,m:chrisl@kernel.org,m:corbet@lwn.net,m:david@kernel.org,m:dev.jain@arm.com,m:gourry@gourry.net,m:hannes@cmpxchg.org,m:hughd@google.com,m:jannh@google.com,m:joshua.hahnjy@gmail.com,m:lance.yang@linux.dev,m:lenb@kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-pm@vger.kernel.org,m:lorenzo.stoakes@oracle.com,m:matthew.brost@intel.com,m:mhocko@suse.com,m:muchun.song@linux.dev,m:npache@redhat.com,m:pavel@kernel.org,m:peterx@redhat.com,m:peterz@infradead.org,m:pfalcato@suse.de,m:rafael@kernel.org,m:rakie.kim@sk.com,m:roman.gushchin@linux.dev,m:rppt@kernel.org,m:ryan.roberts@arm.com,m:shakeel.butt@linux.dev,m:shikemeng@huaweicloud.com,m:s
 urenb@google.com,m:tglx@kernel.org,m:vbabka@suse.cz,m:weixugc@google.com,m:ying.huang@linux.alibaba.com,m:yosry.ahmed@linux.dev,m:yuanchu@google.com,m:zhengqi.arch@bytedance.com,m:ziy@nvidia.com,m:kernel-team@meta.com,m:riel@surriel.com,m:haowenchao22@gmail.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[tencent.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_GT_50(0.00)[55];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B62DE63ABC3

> > I assume the main reason here is to avoid the extra overhead if
> > everything uses vswap, which would mainly be the reverse mapping
> > overhead? I guess there's also some simplicity that comes from reusing
> > the swap info infra as a whole, including the swap table.
> 
> Yeah it helps a lot that we don't have to rewrite the whole allocator
> and swap entry reference counting logic again :)

I specifically meant using a full swap info thing for the physical swap
device even when it's behind vswap. That seems like an overkill, and we
don't need things like the swap entry reference coutning. We probably
just need a bitmap and a reverse mapping.

So I am assuming the main reason why we are not doing that (at least for
now) is simplicity?

> >
> > I don't like that the code bifurcates for vswap vs. normal swap entries
> > though. Not sure if this is an issue that can be fixed with proper
> > abstractions to hide it, or if the design needs modifications. I was
> > honestly really hoping we don't end up with this. I was hoping that the
> > physical swap device no longer uses a full swap table and all, and
> > everything goes through vswap.
> >
> > I hoping that if redirection isn't needed (e.g. zswap is disabled),
> > vswap can directly encode the physical swap slot so that the reverse
> > mapping isn't needed -- so we avoid the overhead without keeping the
> > physical swap device using a fully-fledged swap table.
> 
> Can you expand on "vswap can directly encode the physical swap slot"?
> I'm not sure I follow here.

I meant that if redirection is not needed (e.g. zswap is disabled), then
instead of having a vswap device pointing at a physical swap device, we
can just the data (e.g. phyiscal swap slot) in the vswap device
directly. Then we don't need a full swap info thing and swap table for
the physical swap device.

This directly ties into my question above, about why we have a
fully-fledged swap info thing for the physical swap device when using
vswap.

> >
> > All that being said, perhaps I am too out of touch with the code to
> > realize it's simply not possible.
> >
> > Honestly, if the main reason we can't have a single swap table for vswap
> > is saving 8 bytes on the reverse mapping, it sounds like a weak-ish
> > argument, even if we can't optimize the reverse mapping away. But maybe
> > I am also out of touch with RAM prices :)
> 
> In terms of the space overhead I do agree, FWIW :)
> 
> I think the other concern is the indirection overhead with going
> through the xarray for every swap operation, hence the per-CPU vswap
> cluster lookup caching idea:
> 
> https://lore.kernel.org/all/20260505153854.1612033-23-nphamcs@gmail.com/

Right, but we should already avoid the xarray with the swap table
design, right? We just have one swap table pointing to another
essentially?

> >
> > I at least hope that, the current design is not painting us into a
> > corner (e.g. through userspace interfaces), and we can still achieve a
> > vswap-for-all implementation in the future (maybe that's what you have
> > in mind already?).
> 
> That's still my plan. Operationally speaking, I want to make this
> completely transparent to users, with minimal to no performance
> overhead.

So if CONFIG_VSWAP is set all swap devices are vswap by default, right?
Would it help with testing if it's controlled by a boot param?

> 
> The next action item is to optimize for vswap-on-fast-swapfile case -
> that was Kairui's main concerns regarding performance. I spent a lot
> of time perfing and fixing issues for this case in v6. The issues with
> the most egregious effects and simplest fix (vswap-less
> swap-cache-only check for e.g) are already fixed in this new design,
> and eventually I will move the rest (lookup caching) and more to here.

So is the end goal to have vswap be the default rather than a special
swap device? It would certainly help to include some details about that.

> >
> > Aside from the swap code, the only sticking point for me is the logic
> > bifurcation in zswap. Why does zswap need to handle vswap vs. not vswap?
> > I thought the point of the design is to use vswap when zswap is used,
> > and otherwise use a normal swap table. In a way, one of the goals is to
> > make zswap a first class swap citizen, but it doesn't seem like we are
> > achieving that?
> 
> We already have all the machinery to make zswap completely
> independent. Right now, if you use vswap, you'll skip the zswap's
> internal xarray entirely, and just store a zswap entry in the virtual
> swap cluster's vtable.
> 
> I just haven't removed the old code for 2 reasons:
> 
> 1. Reduce the delta on this RFC, to ease the burden for reviewers (and
> definitely not because I'm lazy :P)
> 
> 2. The only other practical reason is so that we can let users compile
> with !CONFIG_VSWAP and still uses zswap on top of the old swapfile
> setup during the transition/experimentation period for now.
> 
> But logically and conceptually speaking, there is no reason I can come
> up with to use zswap on without vswap. The CPU indirection overhead is
> already partially there (since zswap uses an xarray) and further
> optimized (cluster loopup caching etc.), as well as the space overhead
> (vswap replaces the zswap xarray). I actually wrote a whole paragraph
> about how we should always go for vswap if we're using zswap, but then
> decide to remove it since there's no code for it yet.
> 
> If folks like it, what I can do is have CONFIG_ZSWAP depends on
> CONFIG_VSWAP, removes all the non-vswap logic, and call it a day? :)
> Then, on the swap allocation side, if vswap allocation fail and zswap
> writeback is disabled, we can error out early.

Hmm maybe we can keep it around for now and do that after vswap
stabilizes? It ultimately depend on how much complexity we maintain by
allowing both.

I think another problem is 32-bit, technically zswap can be used on
32-bit now, right? So vswap not supporitng 32-bit is a problem.

General question (for both zswap and general swap code), would a boot
param make implementation simpler? Right now we seem to key off the swap
device having the "vswap" flag, would it help if it was a runtime
constant?

