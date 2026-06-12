Return-Path: <cgroups+bounces-16914-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4hpJNc16LGqcRQQAu9opvQ
	(envelope-from <cgroups+bounces-16914-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 23:31:57 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6219867C89D
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 23:31:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=d2C9aLsH;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16914-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16914-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21BA3314690F
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 21:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0B4369219;
	Fri, 12 Jun 2026 21:31:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0D9306764
	for <cgroups@vger.kernel.org>; Fri, 12 Jun 2026 21:31:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781299914; cv=none; b=ekjEgvzc8g+CnnU+ZYOxravbS6rkOcKrAIWKgWATJum2jUcP3QJ71jfNkPkqh2QhNyd6CkpycM6XlKZOUfsow9AdKtpzsFf5rXW6QZUGwWRoVhCd8jNklofFyWpSPNUGd3DzHGxCi3emXSSQqLvIqVn+zfhPOYrzak1jIlIdDJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781299914; c=relaxed/simple;
	bh=b8PD9i0sOIQmZK1FI66pR0cqwDLEgrFW+rulxA1LOvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AgbtGknKD3hDZMKUo/DIBn1oXiX5ck1fY+ZA4xV2Gl6587a1ceIqM2+g4ioC5ZX0TO/H1N99Yx8qmedaPBMuR+vM4kxtymwqTIOdPoB7AW8hxo274EsYPr3cCvmZF8qSVKZfMxnPr211oCQjI7GaJOKIChW1aK+FumCWXFW5YMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2C9aLsH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98851F00A3F
	for <cgroups@vger.kernel.org>; Fri, 12 Jun 2026 21:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781299912;
	bh=b8PD9i0sOIQmZK1FI66pR0cqwDLEgrFW+rulxA1LOvE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=d2C9aLsHpl2K7U/kj2lmpOhu7UxHqUtJWjFxMsV4jzRnjD4dDsd6DM8L5D8aMxjzD
	 HKUussFsE2Aj2dF67WLXQK2lKQMI+epPQZsCkS4q/hZlaSqaMWRwImwEQ0HhyFfzBb
	 KHN1WdwnSCg5InR0RuLVVXj12FurveOnrpJeoW/qnmA1/bgUfmFDO16OdAxDq/sv6a
	 ke1GlUnZiCNe7gy8LJ/P8ZYl75dWiKQPsS7D6pneZN0cay9wdmAkDUDu4/sglNktFH
	 eSIMmRPluyUZswmvuOoFwvdRKouZQA5zQUU0mdOopTRxqbjPMA0IgoMPK7i7aNNBdq
	 SI2JWlVnF6qWQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-693c69b97e7so316090a12.2
        for <cgroups@vger.kernel.org>; Fri, 12 Jun 2026 14:31:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+XtHfEr5BQAjuxBJJsvG63FC8W/U5/jELyL/VI5e3LgexsGwni7Zda+tmQ9eZVvv3qj3X6eDNq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0alfphTHm/+Nuu+6b5wgNwyKrqpo5ehOnKnXAQ4k8BM3I1My9
	eIvp/2GCSicNWlAPRtxKdU+Qq+JHz2EXNuh7CuOH8FsYry+kBari5GYbonk4tQAZDClH+w24yU+
	uJYQFVof1IoEHsykTaTTM7RaOeUm7uWo=
X-Received: by 2002:a17:907:e143:b0:bfe:ed16:2841 with SMTP id
 a640c23a62f3a-bfeed1638f4mr80835566b.53.1781299911645; Fri, 12 Jun 2026
 14:31:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO9r8zM4SDdTgz9L2s1VfXL8K2VBjMD9ej2BTDxaGge1t2+quA@mail.gmail.com>
 <aicJBVT4pBvmyooT@linux.dev> <aicZ-5GX9De3MAU7@linux.dev> <CAO9r8zNBJ-BsXyKFveA92jbwMu63uFVTY5CuT4fRHTBVcOjhPw@mail.gmail.com>
 <aictKA0XWMWbxFdN@linux.dev> <CAO9r8zPvCaCqvoUhPdAN5Oi_Sj0mK-t7DJhOOz3Xf1DT-Wrgcw@mail.gmail.com>
 <aieUQUBHI+E3uNPW@yjaykim-PowerEdge-T330> <airzE7jD9UtyR17J@google.com>
 <aisEWnb3pzmVC4dl@linux.dev> <aiu06fbV7rWqY0Bm@yjaykim-PowerEdge-T330> <aiw2p5ANjsQUCIHA@linux.dev>
In-Reply-To: <aiw2p5ANjsQUCIHA@linux.dev>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 12 Jun 2026 14:31:40 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNi4-QC4sUi=xXWHt9WMeG39mbyoSf8kON9vLOZ=cbCmw@mail.gmail.com>
X-Gm-Features: AVVi8CcO7wY2xTke3qmgBmUl7EfCwgtSKSiK31KON1wLQrtykLxRuXz4sDM4eoU
Message-ID: <CAO9r8zNi4-QC4sUi=xXWHt9WMeG39mbyoSf8kON9vLOZ=cbCmw@mail.gmail.com>
Subject: Re: [swap tier discussion] Re: [PATCH v3 2/4] mm/zswap: Implement
 proactive writeback
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: YoungJun Park <youngjun.park@lge.com>, Hao Jia <jiahao.kernel@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, mhocko@kernel.org, tj@kernel.org, mkoutny@suse.com, 
	roman.gushchin@linux.dev, Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, 
	chengming.zhou@linux.dev, muchun.song@linux.dev, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Hao Jia <jiahao1@lixiang.com>, chrisl@kernel.org, kasong@tencent.com, 
	baoquan.he@linux.dev, joshua.hahnjy@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16914-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:shakeel.butt@linux.dev,m:youngjun.park@lge.com,m:jiahao.kernel@gmail.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:tj@kernel.org,m:mkoutny@suse.com,m:roman.gushchin@linux.dev,m:nphamcs@gmail.com,m:akpm@linux-foundation.org,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,m:chrisl@kernel.org,m:kasong@tencent.com,m:baoquan.he@linux.dev,m:joshua.hahnjy@gmail.com,m:jiahaokernel@gmail.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[lge.com,gmail.com,cmpxchg.org,kernel.org,suse.com,linux.dev,linux-foundation.org,vger.kernel.org,kvack.org,lixiang.com,tencent.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6219867C89D

> > > Is Hao's work needed for some followup work/development? The earliest Hao's
> > > work can is 7.3, so if we aim to figure out swap tiering interfaces in next
> > > couple of weeks then option 3 is the way to go. If swap tiers take more time
> > > then we can discuss other options as well.
> > > However I would need zswap folks (Yosry & Nhat) help in figuring out swap tiers
> > > interfaces. Zswap is the current top tier swap usage in real world. I want
> > > zswap users to eaily (and hopefully transparently) migrate to swap tiers.
> >
> > I am looking forward to the discussion on this interface!
> >
> > To help boost the discussion and progress, I would like to share a few of my thoughts.
> > We could either introduce a new interface to trigger demotion/promotion,
> > or we could reuse the existing one (using tier just internally)
> >
> > Based on the memcg interface currently proposed in swap_tier
> > (memory.swap.tiers, memory.swap.tiers.effective), I think it aligns well
> > with the current direction. It provides a foundation for selectively
> > targeting devices in tier order.
>
> Here instead of cpuset like interface, we may want more zswap like interface
> where you can put limit on the usage i.e. memory.swap.tier*.max. We can start
> with allowing only two values i.e. 0 and max which effectively will be the
> same as what you need.
>
> I will respond to your other points later when I have time.

If we will have one interface for all the tiers for memory tiering,
I'd rather we do the swap for swap tiering. So maybe
memory.swap.tiers.max or memory.swap.tiered max?

The file can show the limits for all tiers when read, and maybe write
something like "echo 'tierX max' > memory.swap.tiers.max" to it to set
a new limit. We can support only 0/max for now to enable/disable
tiers. In the future, we can also allow something like "auto" to
automatically scale the limit based on the swapfile size and
memory.swap.max, similar to the direction memory tiering is heading
in.

I think we can start with just this interface for now, and expand
incrementally. For proactive zswap writeback, we can add
memory.swap.tiers.demote or something, and only support zswap
initially?

