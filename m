Return-Path: <cgroups+bounces-16738-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4QmNIDb1JmoZowIAu9opvQ
	(envelope-from <cgroups+bounces-16738-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 19:00:38 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8165265906B
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 19:00:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Miu2Kz90;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16738-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-16738-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 72BF2301B1FE
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 16:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470C732B111;
	Mon,  8 Jun 2026 16:45:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF8A3D1CA8
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 16:45:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780937113; cv=none; b=jwkLhOr1U7Cebb/SZU+K3I47G3n3hGuTp9D6cfVd13GmkIvxCAZyPi75zV1D7n6L90ZDrU2mIVOij2uKVw1MccB4uDvSPqzVepdPRHxi15dYFNqcwhlGoYxiDcZKGrL1CmYDdHrEE1AzH98W/8BrFF6HAykL1Vzs7HifR1sNb/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780937113; c=relaxed/simple;
	bh=QiFBO39fqklCf3WvERRFz7vznjsjuDzK8VZZICxlheQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=haIjFwhjhftUG2rmogjScQaSiNdGEeJMCX3vdFFMgny8+NP2BGHmPJYPy9jZHO7jX73cckdMt8lACHouf3eDkzWOkN7fS9wX91BvNw6+wmu/cu2yQQ30KS41ANR55pOKbjYWmcWmikTNffi3ouWC8UV8g6L+GT4ruWwhZUU8K8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Miu2Kz90; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDD61F008A1
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 16:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780937109;
	bh=ipGCjwv9gnvMRM7h8JLTQKxUYjkO3bCbc7n0K+vTvyc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Miu2Kz90Sss0hHyz/wczZwHMiEB9E26wOqbsVFZgOkgv1IPFGKTzsaEVNQvfKPvY0
	 8vqvXXAcCzeGKTMMXTBzmOW3/oHllpQx+HOGKHXdrfui97+PfCeyROjBi0Ag3W0CWu
	 5lQmGvOkEswsPiN8vDVO14jpkwHAHMt0jjfPHwnvrsqfLsa9c+Fq7QQJJUe9UbylMu
	 6RMnDzCc3xTmzxlzzpKZ/MTk7SWYNesDMJyCsyr7ZiOhbaJgLTQsuN+XudkhjtCFoT
	 x7l8v3gdlR3KEXRNeL/b1LVRuymGkZZFePKigytY3xTQEiz6kiJYYMl6nlLG099isl
	 rk7D1e9SU84aQ==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-68c19f1f3ceso7073928a12.2
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 09:45:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/SDpc2l6Sfr4VOY54iDWJoaM8NtJjhtc4GK6Y5oxBYAYHe2eNp+2UWuA7XdVguArObtw43Qsl2@vger.kernel.org
X-Gm-Message-State: AOJu0YzEiFTVtUO5Yrx8N6dd+Fkb4YPYJn1x4oCN6n/LmtXJ9z8xqITB
	NqGo3VLjqARhpcZ7BARVuFs1jwFGGQTqzCeXRdsf7w8KBfVXnFPMQ6eQyjj8YT7M96a8Cc36v4I
	bBdzNtoR/GAdaFEtkC57Ps2SvDB1Khvc=
X-Received: by 2002:a17:906:8a46:b0:bd6:4d8c:bbff with SMTP id
 a640c23a62f3a-bf37234bcccmr523737466b.22.1780937108568; Mon, 08 Jun 2026
 09:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526114601.67041-1-jiahao.kernel@gmail.com>
 <20260526114601.67041-2-jiahao.kernel@gmail.com> <aho7nepN5jZtKmef@google.com>
 <8c0e60e1-5713-69f0-a687-088c87e75764@gmail.com> <ah4ZZGl7GYJf54Wz@google.com>
 <ff344c9f-51da-8b3a-e7a9-c4a7f4702ef8@gmail.com> <ah9i3uhh3PFiS0Uk@google.com>
 <c7870fe2-3588-79db-cbfb-bd6a2b78f594@gmail.com> <aiBpibRNi0BcM1Zu@google.com>
 <9898f83d-fae9-e284-6b85-c7f4089840a0@gmail.com> <CAO9r8zPBH6-0SQ6-_ZOhTQeyu=rz4F=ugikCrU-JR_skm6fEWA@mail.gmail.com>
 <a60eedb6-f3fd-4092-b726-04a17a695ace@gmail.com> <CAKEwX=MQ3xXBAY-2H8vA+XSX5GHNBubJ2GCYAXGD+Hra++ZM7A@mail.gmail.com>
 <90730fa7-62e7-d5f4-b638-23b22a8509f2@gmail.com> <CAKEwX=PF9hfERC_QMq+rjkSc-BsJyawMgTe+EhwR_86HiQKm=Q@mail.gmail.com>
In-Reply-To: <CAKEwX=PF9hfERC_QMq+rjkSc-BsJyawMgTe+EhwR_86HiQKm=Q@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 8 Jun 2026 09:44:56 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMmFuR-==D2NhjzjRr3f0TzCK0woSWaX1JBjJhM=_NOSg@mail.gmail.com>
X-Gm-Features: AVVi8CeITmeIMmAsTo-NaZ6aU_2FnPB84tu3aV4hStlh0vvIQtZippyM4K4eWRs
Message-ID: <CAO9r8zMmFuR-==D2NhjzjRr3f0TzCK0woSWaX1JBjJhM=_NOSg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] mm/zswap: Make shrink_worker writeback cursor per-memcg
To: Nhat Pham <nphamcs@gmail.com>
Cc: Hao Jia <jiahao.kernel@gmail.com>, akpm@linux-foundation.org, tj@kernel.org, 
	hannes@cmpxchg.org, shakeel.butt@linux.dev, mhocko@kernel.org, 
	mkoutny@suse.com, chengming.zhou@linux.dev, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Hao Jia <jiahao1@lixiang.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16738-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nphamcs@gmail.com,m:jiahao.kernel@gmail.com,m:akpm@linux-foundation.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:mkoutny@suse.com,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,m:jiahaokernel@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,vger.kernel.org,kvack.org,lixiang.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8165265906B

On Mon, Jun 8, 2026 at 9:23=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Mon, Jun 8, 2026 at 5:50=E2=80=AFAM Hao Jia <jiahao.kernel@gmail.com> =
wrote:
> > On 2026/6/5 01:23, Nhat Pham wrote:
> > >
> >
> > Thanks for the suggestion!
> >
> > I ran some tests and found that neither the per-memcg cursor nor
> > different batch sizes have a significant impact on proactive writeback
> > performance. However, exactly as we suspected, without the per-memcg
> > cursor, the writeback distribution among child memcgs is highly unfair.
> >
> > Test Setup:
> >
> >    zswap config: 18G capacity, LZ4 compression.
> >    cgroup hierarchy: 1 parent test memcg with 10 child memcgs.
> >    Allocation: Allocated 1600MB of anonymous pages in each child memcg.
> > To ensure compressibility, the first half of each page was filled with
> > random data and the second half with zeros.
> >    Force to zswap: Ran echo "1600M" > memory.reclaim on each child memc=
g
> > to squeeze all their memory into zswap.
> >    Trigger writeback: Ran echo "<size> zswap_writeback_only" >
> > memory.reclaim on the parent cgroup 200 times, with a 2-second interval
> > between each run.
> >    Metric: Monitored the zswpwb_proactive metric in memory.stat to
> > observe the writeback volume.
> >    **Note**: The size here refers to the uncompressed memory size. Also=
,
> > since the second-chance algorithm would cause many writebacks to fall
> > short of the target size, I **bypassed** it during these tests to avoid
> > interference.
> >
> > Without cursor (size: 1M, batch: 32)
> >    child        wb_pages        wb_MB     share%
> >    child0           6368        24.88      12.50
> >    child1           6368        24.88      12.50
> >    child2           6368        24.88      12.50
> >    child3           6368        24.88      12.50
> >    child4           6368        24.88      12.50
> >    child5           6368        24.88      12.50
> >    child6           6368        24.88      12.50
> >    child7           6368        24.88      12.50
> >    child8              0         0.00       0.00
> >    child9              0         0.00       0.00
> > Without cursor (size: 1M, batch: 128)
> >    child        wb_pages        wb_MB     share%
> >    child0          25472        99.50      50.00
> >    child1          25472        99.50      50.00
> >    child2              0         0.00       0.00
> >    child3              0         0.00       0.00
> >    child4              0         0.00       0.00
> >    child5              0         0.00       0.00
> >    child6              0         0.00       0.00
> >    child7              0         0.00       0.00
> >    child8              0         0.00       0.00
> >    child9              0         0.00       0.00
> > Without cursor (size: 6M, batch: 128)
> >    child        wb_pages        wb_MB     share%
> >    child0          51200       200.00      16.67
> >    child1          51200       200.00      16.67
> >    child2          25600       100.00       8.33
> >    child3          25600       100.00       8.33
> >    child4          25600       100.00       8.33
> >    child5          25600       100.00       8.33
> >    child6          25600       100.00       8.33
> >    child7          25600       100.00       8.33
> >    child8          25600       100.00       8.33
> >    child9          25600       100.00       8.33
> >
> >
> > With cursor (size: 1M, batch: 32)
> >    child        wb_pages        wb_MB     share%
> >    child0           5120        20.00      10.00
> >    child1           5120        20.00      10.00
> >    child2           5120        20.00      10.00
> >    child3           5120        20.00      10.00
> >    child4           5120        20.00      10.00
> >    child5           5120        20.00      10.00
> >    child6           5120        20.00      10.00
> >    child7           5120        20.00      10.00
> >    child8           5120        20.00      10.00
> >    child9           5120        20.00      10.00
> > With cursor (size: 1M, batch: 128)
> >    child        wb_pages        wb_MB     share%
> >    child0           5120        20.00      10.00
> >    child1           5120        20.00      10.00
> >    child2           5120        20.00      10.00
> >    child3           5120        20.00      10.00
> >    child4           5120        20.00      10.00
> >    child5           5120        20.00      10.00
> >    child6           5120        20.00      10.00
> >    child7           5120        20.00      10.00
> >    child8           5120        20.00      10.00
> >    child9           5120        20.00      10.00

Yes, the per-memcg cursor is more fair, and you can synthesize
scenarios that show that. However, I don't think this is a problem in
practice:

1. The unfairness is limited to the batch size per-invocation. If the
batch size is 128 pages (your highest one here), that's 0.5 MB (on
x86), which is fairly low? If the batch size is 32, it's even less.

2. Realistically, if you have a parent cgroup with with >10G of
memory, you wouldn't be reclaiming in steps of 1M. If you want to
reclaim 200MB, why are you doing it over 200 invocations? If you do it
in a single one (or over a few retries) the shares should become much
more even.

We're trying to fix a practical use case, not finding reasons why a
simple implementation won't work -- right?

More below (to Nhat's point).

>
> Yeah OTOH, we don't really make fairness an API contract here. When
> you set up a proactive reclaim scheme, if you decide to target a
> cgroup (and not its children separately), everything underneath it is
> fair game to the kernel in any split that we fancy. If you want true
> fairness or a desired split, you have to treat them as independent
> memory domains and set up proactive reclaim to hit each child cgroup
> separately (i.e one "echo > memory.reclaim" for each of them). This is
> necessary for example if each child represents a separate, isolated
> service/container/tenant. And maybe this is actually what you really
> want - hit the ancestor cgroup very lightly for the stuff it owns, but
> then dedidcate most of the reclaim effort at the leaf cgroups
> independently?

I would go a bit farther and claim that ideally fairness shouldn't
even be a factor. If you invoke proactive reclaim on a parent cgroup
with 100MB, you want to reclaim the coldest 100MB in that parent, no
matter what child they reside in. If one child cgroup has 100% hot
memory and one child cgroup has 100% cold memory, ideally you'd
reclaim all the cold memory from the second child.

However, the implementation of the LRUs and the coldness tracking
doesn't allow for doing this, so we "fallback" to reclaiming in
batches from each child because we don't really know where the coldest
pages overall are. If that changes in the future (somehow), I argue
that the correct thing to do is reclaim the absolute coldest memory at
the parent level.

If you want to reclaim evenly among the children, you can do that and
directly reclaim from the children.

>
> But OTOH, this does seem like a recipe for inefficient reclaim. We
> might exhaust hotter memory of a cgroup while sparing colder memory of
> another cgroup... But maybe if they're all cold anyway, then who
> cares, and eventually you'll get to the cold stuff of other child?
>
> Yosry, what's the concern here? Is it space overhead, or overall code
> complexity?

Mostly the complexity (e.g. the zombie memcg cleanup) and a tiny bit
the unnecessary space (8 bytes is not a lot, but these things add up).

