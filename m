Return-Path: <cgroups+bounces-15907-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AMzA5jKBGp2OwIAu9opvQ
	(envelope-from <cgroups+bounces-15907-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 21:01:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFD05397B3
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 21:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BC6830B3A40
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 18:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C833B19C4;
	Wed, 13 May 2026 18:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDWMEh+2"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1863AEF53
	for <cgroups@vger.kernel.org>; Wed, 13 May 2026 18:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698500; cv=none; b=RfsDj+Vg00/FE17VE6QubdzdrDBW7FIbdztEk36aRqxtoGdr4YWr78e0QtAzMzCZI16SX1wyslIbPj5P+n5VEoZKvhuqXt2XKeEGLzB8QvMVRsiK4mAQfl9mYEwLbRFQcRrZDmocrlpK1VgHwONkJ4sZznlny3TjOfusZp5/F2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698500; c=relaxed/simple;
	bh=oy48rSFgn/Urnek9HoSvpEF/u10r5XtDsuRkhJs2+R0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5GaODRpNuI4MvpWw6C4uOBGnksGbX58D/vLf+eAtRxsBT2+ZqXDH5DGvYWlD/6+RBY5aWzQ+zhRXFIOp1x11JXORUkT9txvCM9O1kcjiUyVMxa0s6E3yVeT+Shd5FI71CkQSrMa33Vnf8HSCaAAD+s9UZgC6qr7HZy49BCPfLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDWMEh+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89359C2BCFC
	for <cgroups@vger.kernel.org>; Wed, 13 May 2026 18:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778698500;
	bh=oy48rSFgn/Urnek9HoSvpEF/u10r5XtDsuRkhJs2+R0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LDWMEh+2qLNLseuxA7u9PZiJrS7UJ995evm7L/D696Qwxo0ZjKQEGE/RFTjLDMM1K
	 lGCnPsySEh6nsjfqHIQN6bxN4ckE4lRX0mWjbBwKj7xFkmwZWD58ocq4J7NWnrmsvX
	 x32rdYJ1W5uKsuZGYA63Fvsn+AF0es+pD/VzZ8ftNzfGPsH8a8NjOAO3M3rebSKaKh
	 bqNQ1sA8Hni390pTaPHLv+x+T7twymy+0+vUdIYgRAlSO3SzQzw+fnJ07J/t1QRgNH
	 1lkm9W8U9OVJ9QWlmPPs+NGNP6KnJaDaO+Uznev9F8tOEs0o8E92LYrhBMpoCWq651
	 WPjpbtB5w2veg==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bd1caeba6beso317252566b.3
        for <cgroups@vger.kernel.org>; Wed, 13 May 2026 11:55:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9deC7NKuVWTNJrLFF+tNVy67sn5pGkBNii3rKYhanWwCn0ZJJrgJm+5VivI/Jl5AqD+9CQpdl8@vger.kernel.org
X-Gm-Message-State: AOJu0YwYg2QQrrbH42oUFoq85cM9Q7fSsRy817OkeGU2ZrmRAiYMTWiw
	3j7RIYbWDYt5DRWsEu4STIp7JLGyNVfyZNqVwZBkTwuwqeLdMJ+eFBkfr3+vuoPAEKMtHyt9uXZ
	uEFtAetpIXN2T40+iMdhJ8hM99U/rK84=
X-Received: by 2002:a17:907:a808:b0:bad:f032:fc78 with SMTP id
 a640c23a62f3a-bd3bf5810admr316310866b.1.1778698499361; Wed, 13 May 2026
 11:54:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511105149.75584-1-jiahao.kernel@gmail.com>
 <20260511105149.75584-3-jiahao.kernel@gmail.com> <CAKEwX=PLFRkfUvZyaYfwBv0QJ-8KAktvZvGA02Hod04H-RsS-Q@mail.gmail.com>
 <CAO9r8zNOPdpJuTmccvQ6ZAVS+tXxp-_ofA765DbnfaUZOPPO-g@mail.gmail.com>
 <12e4784e-2add-d849-7e54-bde8abfa6e78@gmail.com> <CAKEwX=MOixJAUGiwUcMQa0Stvg-mR-MvpDRD8WA4YMtRvnUYTg@mail.gmail.com>
 <6fc7fdf0-368c-5129-038e-623f9db2aa88@gmail.com>
In-Reply-To: <6fc7fdf0-368c-5129-038e-623f9db2aa88@gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 13 May 2026 11:54:46 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPvgB-MG2ufmdn4HoS+QEPBAehU9u7fQmYs+47NF-C9aw@mail.gmail.com>
X-Gm-Features: AVHnY4LWBpgK05hIM_DR0y0RJ9IQwojHb2pGG4Y0yyBRaatpgBUHNNyaBPv-4Bg
Message-ID: <CAO9r8zPvgB-MG2ufmdn4HoS+QEPBAehU9u7fQmYs+47NF-C9aw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/zswap: Implement proactive writeback
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, tj@kernel.org, 
	hannes@cmpxchg.org, shakeel.butt@linux.dev, mhocko@kernel.org, 
	mkoutny@suse.com, chengming.zhou@linux.dev, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Hao Jia <jiahao1@lixiang.com>, Alexandre Ghiti <alex@ghiti.fr>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 5BFD05397B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15907-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,vger.kernel.org,kvack.org,lixiang.com,ghiti.fr];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> > Zswap objects are organized into LRU and exposed to the shrinker
> > interface. Echo-ing to memory.reclaim should also offload some zswap
> > entries, correct? Are there still cold zswap entries that escape this,
> > somehow?
> >
>
> Yes, the memory.reclaim path does drive some zswap writeback, but
> it is not enough for our case.
>
> 1. For a memcg that has reached steady state (a common case being
> when memory.current is below the policy target), the userspace
> reclaimer may not invoke memory.reclaim on it for a long time,
> and so no second-level offloading happens through
> memory.reclaim. In this state we want
> memory.zswap.proactive_writeback to write back entries that
> have sat in zswap past an age threshold, to further reclaim
> the DRAM still held by the compressed data.
>
> 2. Even when memory.reclaim is running, the fraction of zswap
> residency that ends up reaching the backing swap device is
> still very small for many of our workloads, and the userspace
> reclaimer has no way to participate in or control the
> granularity of zswap writeback. So in our deployment we prefer
> to leave the zswap shrinker disabled, decouple LRU -> zswap
> from zswap -> swap, and use a dedicated proactive-writeback
> interface that lifts the writeback policy into userspace where
> it can evolve independently of the kernel.

To be honest I see the point of proactively reclaiming compressed
memory in zswap. If you use memory.reclaim, you are also reclaiming
hotter memory in the process, and you are not necessarily getting as
much writeback as you want. The memory in zswap is a more conservative
choice for proactive reclaim because it's memory that's guaranteed to
be cold(ish) and not being accessed.

That being said, the interface is not great any way you cut it :/

I don't like the 'memory.zswap.proactive_writeback' name, maybe we can
stay consistent by doing 'memory.zswap.reclaim', but that just as
easily reads as "reclaim using zswap". Maybe
'memory.zswap.do_writeback' or something, idk.

I also don't like having two proactive reclaim interfaces, so a voice
in my head wants to tie this into 'memory.reclaim' somehow, but that
includes adding a pretty specific argument (e.g. 'memory.reclaim
zswap_writeback_only=1'.

I don't like any of these options, and we also need to consider what
the memcg maintainers think. I see the use case of proactive writeback
but I am struggling to come up with a clean interface.

I also think we should take the 'age' aspect out of the conversation
for now, it can be a separate discussion. Well, unless we decide to
tie it to memory.reclaim. If memory.reclaim broadly supports age-based
reclaim then zswap writeback can be a natural part of that without
requiring a specific interface.

