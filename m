Return-Path: <cgroups+bounces-16745-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4/CWI6clJ2p7sgIAu9opvQ
	(envelope-from <cgroups+bounces-16745-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 22:27:19 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1A565A6D5
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 22:27:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="CCaq9/IJ";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16745-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16745-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 889F33100162
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 20:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE2D38C2C6;
	Mon,  8 Jun 2026 20:19:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31B23E7BD9
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 20:19:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949987; cv=none; b=AQkPOgeevX7iT/VYVNjrvEZOV3aijMj/3QWGmW3+fUNKpLlXqccTV8zZAgPHk62JAFSivQy87UEWfGx5U8gOIsZjFeHPqJkoE5f3qix62jWeXU3DvSTBg7JtN30Jb7XNpSUeZwylR3fe+5eAOY5kgKTQVsbEjCIRYGByw/o7Gfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949987; c=relaxed/simple;
	bh=2E8zGT5xOyDSmdwu3J6sYJf2Yq5VI7x+0ZWpD9LyuJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IxyUM8L8rDlx1MUTOE84OLym4mTtvL6jmxR+WaIaBKu2KC6qaYkQH2A8GuX8BMMWrrbaWcL4UwSa/Ix0cOgYsiR/35wOIUVIExXeZ1MAdyr2Q9fn69BN/3ssGXxfsVH3TjNMmYnEwP7K1TjQMxYup91EDB9Iz3ifIZN3nKpoiz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCaq9/IJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FCA1F00899
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 20:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780949984;
	bh=2E8zGT5xOyDSmdwu3J6sYJf2Yq5VI7x+0ZWpD9LyuJc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CCaq9/IJBxuXvV6cfEUyYGqZZ353g2VavYVoMHw1Mj4h5NVjZQEIv1MgkROtD1YJZ
	 gh0mQJlrVUQzwSufctn/wjDP1PV/3djpyJngB01kGvXnGK+OVsuLdA38arOor7pWfG
	 lTIAxSurAPDs1exx2/1WemHtIy7dgJNXs/FQx17zYEFRBP5mZRfGUw60iW27LLuTns
	 702QcNjyLcS695xsH9orvhNN8wlZl0GAlt8imcu2xZQxJRGhAbkmAdAxtWjqciUWcZ
	 qZTkoRkmnCw4O/tKRQlxWwSoR/v6D7lcoULAnhP87wZNM8C17IP1/OWHlmZUgPelis
	 1ooxkgVGXhHzA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bec449cf976so658071866b.2
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 13:19:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8F47mBy5axjlNkhddxfbfUoQTDRG9LAIZAJONWWK9lL2uKyx6PTw8yITGkF+JihCfYwdBUIbTn@vger.kernel.org
X-Gm-Message-State: AOJu0YyB9ToAgU8Lddx1/Hohzr+sHdtl4kMzYa//JTVYt7zn7cUXe9Cx
	QZt6m2GQWjxNCYzHOY5yFr5u6Ak4lDy2SzQ0MYduYpYAmO4t7v6doam0hpyPY6w0HgVgAW/OI9L
	vqtDmGyFt2lOoiFG2PTixrY7LENb3eRI=
X-Received: by 2002:a17:907:9812:b0:bec:18d5:ddec with SMTP id
 a640c23a62f3a-bf37311392cmr824666966b.41.1780949983628; Mon, 08 Jun 2026
 13:19:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526114601.67041-1-jiahao.kernel@gmail.com>
 <20260526114601.67041-3-jiahao.kernel@gmail.com> <CAKEwX=MQe_KFZe2vBXQYh0aa-x+E8AzNwmyjJGJk4tDoS9ML3A@mail.gmail.com>
 <aho_VtLCmIRsNyvO@google.com> <6deeaea7-3cd1-4403-29fc-d2dc55c297f8@gmail.com>
 <aiBqzOtEv5iAC_qC@google.com> <CAKEwX=OhxUxRCEfvZMnWzXy=Fa4jgzL3DuP-RmaVzdK65m4bew@mail.gmail.com>
 <6db27a22-cc7a-9a94-db3f-c912fd39aa32@gmail.com> <CAO9r8zM4SDdTgz9L2s1VfXL8K2VBjMD9ej2BTDxaGge1t2+quA@mail.gmail.com>
 <aicJBVT4pBvmyooT@linux.dev> <aicZ-5GX9De3MAU7@linux.dev>
In-Reply-To: <aicZ-5GX9De3MAU7@linux.dev>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 8 Jun 2026 13:19:32 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNBJ-BsXyKFveA92jbwMu63uFVTY5CuT4fRHTBVcOjhPw@mail.gmail.com>
X-Gm-Features: AVVi8CeXOXcjGUkNg7x1wCjnQhVCU2d5Mo_U0_PWWSBCHknTzqRDtrc94LmYLm8
Message-ID: <CAO9r8zNBJ-BsXyKFveA92jbwMu63uFVTY5CuT4fRHTBVcOjhPw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mm/zswap: Implement proactive writeback
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Hao Jia <jiahao.kernel@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, mhocko@kernel.org, 
	tj@kernel.org, mkoutny@suse.com, roman.gushchin@linux.dev, 
	Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, chengming.zhou@linux.dev, 
	muchun.song@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Hao Jia <jiahao1@lixiang.com>, youngjun.park@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16745-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:shakeel.butt@linux.dev,m:jiahao.kernel@gmail.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:tj@kernel.org,m:mkoutny@suse.com,m:roman.gushchin@linux.dev,m:nphamcs@gmail.com,m:akpm@linux-foundation.org,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,m:youngjun.park@lge.com,m:jiahaokernel@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,cmpxchg.org,kernel.org,suse.com,linux.dev,linux-foundation.org,vger.kernel.org,kvack.org,lixiang.com,lge.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF1A565A6D5

On Mon, Jun 8, 2026 at 12:50=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> +Youngjun
>
> On Mon, Jun 08, 2026 at 11:30:30AM -0700, Shakeel Butt wrote:
> > On Wed, Jun 03, 2026 at 10:36:07PM -0700, Yosry Ahmed wrote:
> > > > >> But doesn't it make more sense to specify the compressed size, w=
hich is
> > > > >> ultimately the amount of memory you actually want to reclaim.
> > > > >>
> > > > >
> > > > > I personally prefer compressed size to pre-compressed size. That'=
s
> > > > > kinda what user cares about, no?
> > > > >
> > > > > One thing we can do is let users prescribe a compressed size, but
> > > > > internally, we can multiply that by the average compression ratio=
.
> > > > > That gives us a guesstimate of how many pages we need to reclaim,=
 and
> > > > > you can follow the rest of your implementation as is (perhaps wit=
h
> > > > > short-circuit when we reach the goal with fewer pages reclaimed).
> > > >
> > > > Got it. I will change it to use the compressed size in the next ver=
sion.
> > > >
> > > > Yosry, Nhat, should we continue using the zswap_writeback_only key =
to
> > > > trigger proactive writeback?
> > >
> > > I *really* want the memcg maintainers to chime in here, it's
> > > ultimately their call.
> > >
> > > Michal? Johannes? Shakeel? Roman? Anyone? :D
> >
> > Between the options of having an explicit interface (i.e.
> > memory.zswap.writeback*) or a key (i.e. zswap_writeback_only) to memory=
.reclaim
> > interface, I prefer the key option. I have not looked into how much pro=
actively
> > reclaiming zswap memory or proactively triggering zswap writeback makes=
 sense
> > but from the perspective of memcg interface, I think the key option wou=
ld give a
> > more clean solution if we decide in the future that this whole thing wa=
s a bad
> > idea.
> >
> > Next regarding future proofing zswap writeback trigger, do we expect an=
y
> > potential additions/changes/new-features for this interface? For exampl=
e do we
> > expect in future we may want to trigger the zswap writeback only from a=
 specific
> > node or lowest memory tier?

The way I see it, zswap writeback is just a "special" type of
proactive reclaim, but the goal is still proactively freeing cold
memory. In that regard, I think it makes sense to have things like
node-specific reclaim. Not sure about other extensions, but Hao
initially suggested making this age-based, so I think the answer is
yes.

For both of these examples (node-specific reclaim, age-based reclaim),
I think the same semantics could apply to memory.reclaim in general,
which is why I suggested making it a part of memory.reclaim. I also
like the idea of having a single proactive reclaim interface in
general, but maybe we don't want to overload it too much.

> Youngjun is working on swap tiers. At the moment he is more interested in
> allowing a specific swap device to a memcg or not. I can imagine in futur=
e there
> will be use-cases where there will be a need to demote data on higher tie=
r swap
> to lower tier swap. What would be the appropriate interface?
>
> BTW does zswap folks think of zswap as a top swap tier or something diffe=
rent?

I haven't been following the swap tiers work closely, but personally I
do think of zswap as a top swap tier. Things will probably get more
blurry with memory tiers and compressed memory nodes though.

