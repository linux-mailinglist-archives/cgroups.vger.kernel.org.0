Return-Path: <cgroups+bounces-13844-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAVUAwiii2l1XQAAu9opvQ
	(envelope-from <cgroups+bounces-13844-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 22:24:24 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB1511F631
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 22:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 267143024A5C
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 21:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5EF338925;
	Tue, 10 Feb 2026 21:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ql6bLMuZ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF273328E1
	for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 21:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770758655; cv=none; b=Kti27nN9KX7sEwhSt0mV49ii9QG7hQuHsfzeDuEYHUSguEulJdgvJBdE+1LOKzzRlWFXXtUWtAb+LMHnnXyQJpAZK78yfGHJQyr/ZM5KmHAhi2APc2VjAxWWG/0F2jz8pLHC33VBlmQaWTLWSQMhtUIALVY6IuVZja4xoa/F9ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770758655; c=relaxed/simple;
	bh=XFOqVKonzJIvX2M80FEWCluKWLmbrP9Xp5QWqG/BvAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eb1K4sdyxpw9jMoHFP63TqB1eAAf6LaAHWdX4jMmR8N+IwHJ0omjTpxGPDzD7k5sWlYDYwLKfoslLNwkXZJ684o4gPltNs8KUZejFSYUGtPGRCEc6Es3ssIwmPkB8WhV/wvQHqoY4XZBVRv+ggPqxFvDcFSomy+uVzjR/n/p1kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ql6bLMuZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651F4C2BCF6
	for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 21:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770758655;
	bh=XFOqVKonzJIvX2M80FEWCluKWLmbrP9Xp5QWqG/BvAo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ql6bLMuZPJmRGsTuyEa+77lXrv1YJk9kcYvkFL67RIALVmN8bkWSfCgO7i8V/1G5J
	 5usIlHhWzUIGF9rEcGiNJ1UM7nqwNnqMZbTYP6+KKK94UGJiermuxHyyWgJnXVOGhe
	 4VMq7VPXLh+eZAuHBmyK5AZHmVqzsxWGqVoNWdRkWPPXgZlyv7L0v0lbQGzuheLYTe
	 0J7qyGwueuYZiUtK3Q9bcYnf9vN1Tw2XiZL/0HAQ9CVgMNBhRPPHXaTq6t5NVTB56t
	 05GlUoVm+xB0/asIaUG7YFjOIG1KIBGr075txHXWPj7IwpH+yVU/v8OOTG4ps0fxVo
	 gTLYs0nyMrcHg==
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79642776df7so15376167b3.0
        for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 13:24:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUD2oZJupD+IVoAhmWb5CdyUBy3ygmQdZC8BMbRYi8cXVFK860ULlqwsKTlwV7QuZ75FPsJVHYk@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8U1kUWwn0r4zCRelkBUliXRptp7S2PHbaXu9eJXdL29agDZYL
	TE3bbdvVLnxRdU3/aKEKL3Uo0Fq5ocxZ+WuA92bpNrmXZ6KhhJJrCTZKrV3weHyeQIswouwI5cD
	F3PJ7lZM7bbJriI7MFd1zfsS2jrlzQF7J6AWhrDGS8g==
X-Received: by 2002:a05:690c:55c7:20b0:787:ffc0:40c7 with SMTP id
 00721157ae682-7952ab8a9d0mr122001867b3.68.1770758654505; Tue, 10 Feb 2026
 13:24:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208215839.87595-2-nphamcs@gmail.com> <20260208223143.366416-1-nphamcs@gmail.com>
 <CACePvbXsngZmn0OrJZjvMhhHnL5FazxYX7ShEpbU9RwHSJaUuA@mail.gmail.com> <aYqZppn4yDbTP2_q@cmpxchg.org>
In-Reply-To: <aYqZppn4yDbTP2_q@cmpxchg.org>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 10 Feb 2026 13:24:03 -0800
X-Gmail-Original-Message-ID: <CACePvbWnJFkMOtX8LbL+0hm5RP6jD5nfZcYUyxrJsPNTq0vbPg@mail.gmail.com>
X-Gm-Features: AZwV_Qjcbo9saS4Hk5tJX7q1wTM6Ct_T44mYK2YA18JDo-CVVbZphMtbeIM4Ar8
Message-ID: <CACePvbWnJFkMOtX8LbL+0hm5RP6jD5nfZcYUyxrJsPNTq0vbPg@mail.gmail.com>
Subject: Re: [PATCH v3 00/20] Virtual Swap Space
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, hughd@google.com, 
	yosry.ahmed@linux.dev, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, len.brown@intel.com, 
	chengming.zhou@linux.dev, kasong@tencent.com, huang.ying.caritas@gmail.com, 
	ryan.roberts@arm.com, shikemeng@huaweicloud.com, viro@zeniv.linux.org.uk, 
	baohua@kernel.org, bhe@redhat.com, osalvador@suse.de, 
	christophe.leroy@csgroup.eu, pavel@kernel.org, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13844-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,google.com,linux.dev,kernel.org,intel.com,tencent.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,csgroup.eu,kvack.org,meta.com,vger.kernel.org,surriel.com,gourry.net,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisl@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9CB1511F631
X-Rspamd-Action: no action

Hi Johannes,

On Mon, Feb 9, 2026 at 6:36=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> Hi Chris,
>
> On Mon, Feb 09, 2026 at 04:20:21AM -0800, Chris Li wrote:
> > Is the per swap slot entry overhead 24 bytes in your implementation?
> > The current swap overhead is 3 static +8 dynamic, your 24 dynamic is a
> > big jump. You can argue that 8->24 is not a big jump . But it is an
> > unnecessary price compared to the alternatives, which is 8 dynamic +
> > 4(optional redirect).
>
> No, this is not the net overhead.

I am talking about the total metadata overhead per swap entry. Not net.

> The descriptor consolidates and eliminates several other data
> structures.

Adding members previously not there and making some members bigger
along the way. For example, the swap_map from 1 byte to a 4 byte
count.

>
> Here is the more detailed breakdown:

It seems you did not finish your sentence before sending your reply.

Anyway, I saw the total per swap entry overhead bump to 24 bytes
dynamic. Let me know what is the correct number for VS if you
disagree.

Chris

> > > The size of the virtual swap descriptor is 24 bytes. Note that this i=
s
> > > not all "new" overhead, as the swap descriptor will replace:
> > > * the swap_cgroup arrays (one per swap type) in the old design, which
> > >   is a massive source of static memory overhead. With the new design,
> > >   it is only allocated for used clusters.
> > > * the swap tables, which holds the swap cache and workingset shadows.
> > > * the zeromap bitmap, which is a bitmap of physical swap slots to
> > >   indicate whether the swapped out page is zero-filled or not.
> > > * huge chunk of the swap_map. The swap_map is now replaced by 2 bitma=
ps,
> > >   one for allocated slots, and one for bad slots, representing 3 poss=
ible
> > >   states of a slot on the swapfile: allocated, free, and bad.
> > > * the zswap tree.
> > >
> > > So, in terms of additional memory overhead:
> > > * For zswap entries, the added memory overhead is rather minimal. The
> > >   new indirection pointer neatly replaces the existing zswap tree.
> > >   We really only incur less than one word of overhead for swap count
> > >   blow up (since we no longer use swap continuation) and the swap typ=
e.
> > > * For physical swap entries, the new design will impose fewer than 3 =
words
> > >   memory overhead. However, as noted above this overhead is only for
> > >   actively used swap entries, whereas in the current design the overh=
ead is
> > >   static (including the swap cgroup array for example).
> > >
> > >   The primary victim of this overhead will be zram users. However, as
> > >   zswap now no longer takes up disk space, zram users can consider
> > >   switching to zswap (which, as a bonus, has a lot of useful features
> > >   out of the box, such as cgroup tracking, dynamic zswap pool sizing,
> > >   LRU-ordering writeback, etc.).
> > >
> > > For a more concrete example, suppose we have a 32 GB swapfile (i.e.
> > > 8,388,608 swap entries), and we use zswap.
> > >
> > > 0% usage, or 0 entries: 0.00 MB
> > > * Old design total overhead: 25.00 MB
> > > * Vswap total overhead: 0.00 MB
> > >
> > > 25% usage, or 2,097,152 entries:
> > > * Old design total overhead: 57.00 MB
> > > * Vswap total overhead: 48.25 MB
> > >
> > > 50% usage, or 4,194,304 entries:
> > > * Old design total overhead: 89.00 MB
> > > * Vswap total overhead: 96.50 MB
> > >
> > > 75% usage, or 6,291,456 entries:
> > > * Old design total overhead: 121.00 MB
> > > * Vswap total overhead: 144.75 MB
> > >
> > > 100% usage, or 8,388,608 entries:
> > > * Old design total overhead: 153.00 MB
> > > * Vswap total overhead: 193.00 MB
> > >
> > > So even in the worst case scenario for virtual swap, i.e when we
> > > somehow have an oracle to correctly size the swapfile for zswap
> > > pool to 32 GB, the added overhead is only 40 MB, which is a mere
> > > 0.12% of the total swapfile :)
> > >
> > > In practice, the overhead will be closer to the 50-75% usage case, as
> > > systems tend to leave swap headroom for pathological events or sudden
> > > spikes in memory requirements. The added overhead in these cases are
> > > practically neglible. And in deployments where swapfiles for zswap
> > > are previously sparsely used, switching over to virtual swap will
> > > actually reduce memory overhead.
> > >
> > > Doing the same math for the disk swap, which is the worst case for
> > > virtual swap in terms of swap backends:
> > >
> > > 0% usage, or 0 entries: 0.00 MB
> > > * Old design total overhead: 25.00 MB
> > > * Vswap total overhead: 2.00 MB
> > >
> > > 25% usage, or 2,097,152 entries:
> > > * Old design total overhead: 41.00 MB
> > > * Vswap total overhead: 66.25 MB
> > >
> > > 50% usage, or 4,194,304 entries:
> > > * Old design total overhead: 57.00 MB
> > > * Vswap total overhead: 130.50 MB
> > >
> > > 75% usage, or 6,291,456 entries:
> > > * Old design total overhead: 73.00 MB
> > > * Vswap total overhead: 194.75 MB
> > >
> > > 100% usage, or 8,388,608 entries:
> > > * Old design total overhead: 89.00 MB
> > > * Vswap total overhead: 259.00 MB
> > >
> > > The added overhead is 170MB, which is 0.5% of the total swapfile size=
,
> > > again in the worst case when we have a sizing oracle.

