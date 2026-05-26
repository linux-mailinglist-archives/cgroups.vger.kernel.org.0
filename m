Return-Path: <cgroups+bounces-16322-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG9rCqHsFWogfAcAu9opvQ
	(envelope-from <cgroups+bounces-16322-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 20:55:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 906CA5DB9C1
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 20:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9B393034A3E
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 18:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9C63C060E;
	Tue, 26 May 2026 18:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHnIvnhR"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4793C0624
	for <cgroups@vger.kernel.org>; Tue, 26 May 2026 18:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779821721; cv=none; b=Nf4Ue0mUBltyu88U2AY9GA1UKUHTnesAFWIRL5oMUOF2vJk5nlKNLb5TifSS/MxDw1yzaA47ugwsFgV9k3Wmbb5LaGXCxQysadWxDY9AgapNps58prIJeOLzYvcaADKXPrSayIkTMrpHbu2y5X3zGOhN57UYFcRM10HS9tJ99qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779821721; c=relaxed/simple;
	bh=8+FwsiYbTLidaOQnE2uFrRvMyfohje7jhcb8w6PK6TY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPDzk7bE3illxtgUFaWuvzjPzxAWBpgg8NsN1AV2HzBKOMigGVB9bdQSIXIumZPo8v0jaYj3YvLpm+F/ghdttNWiAiM/YrnFisa4lz7qW5UiKZBCoKICryCt/AOSix0HmaWpS+SRV91QSv5wJkIhEo05klRDs0okerd7M51pq1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHnIvnhR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F021F00ADB
	for <cgroups@vger.kernel.org>; Tue, 26 May 2026 18:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779821720;
	bh=HXgROzGmAJcCsVgExpV6y9lWb3jWbK1tedmMBM0VEbA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RHnIvnhRM1W6mbTga0AJ2W18mdbHTBIUsfWktHzxkzabHOXx6HhV3bom4Z3JB+sfq
	 H7IoxkMH4PyD2oyO4F8xcw+M1RMdjljhyvX3yT4BrZTbTfAba90x7bur4hZh2Mlsx1
	 ILNMnysvZgiLl+k6WSrNFe72sc7sDMNzKkXdQpWNVbshRLcWbLb+4HrATTQvpOtyFN
	 XdBfoWD6Sr/SSKcDmCzWCw4LYhvPRwbBteT+f97ymjR9TTIsxfdSAByk3K4m7GI2TY
	 rIZ3niXDNm+9n2Cfoex4Nb4cAWTk7+aekvP+4VE4nC1s3f2hFX55Fo9T4cn00HF4JJ
	 TO+9UOCPKu72A==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bd4d7f4fa02so1841032266b.3
        for <cgroups@vger.kernel.org>; Tue, 26 May 2026 11:55:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9f6erCY77pYSvUcII+cUidDbLB91lddruoLLtq3roRo9kXANY5ohDCuKPriCpC1ukfIuwZK8Nv@vger.kernel.org
X-Gm-Message-State: AOJu0YyR3NCrdR6Nwm+PI9RiUWW6AtYl8Xnd/8CQU7p+8pyPHXOOJx2E
	PMb8tXBKAFHj4coIEQf7dFVRb4iDh8AgOvyiVVosO1t/aRlb6RAs9tzaFNOK6qf0jesahU92RCg
	Wi/laxe5eE4CzDfQAeEYOGt/gfOUoqbE=
X-Received: by 2002:a17:907:d01:b0:bd4:f3e5:b0f6 with SMTP id
 a640c23a62f3a-bdd26cd21dbmr1255792266b.28.1779821718891; Tue, 26 May 2026
 11:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525122242.36127-1-jiahao.kernel@gmail.com>
 <20260525122424.3b2818f06832d9d55da8d69b@linux-foundation.org> <9b2ac88c-a67f-2512-d898-3dadd50ec03e@gmail.com>
In-Reply-To: <9b2ac88c-a67f-2512-d898-3dadd50ec03e@gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 26 May 2026 11:55:06 -0700
X-Gmail-Original-Message-ID: <CAO9r8zO1+brQroYufMZ2K=ZH_PBBpzYPsdYm-DT3K2GxoKJs9A@mail.gmail.com>
X-Gm-Features: AVHnY4LLc2VbUgRMQJCSwM_5Avx8xJ-cNYKTtyXz3u-0Ot15a8J2I4eMGnrIBmI
Message-ID: <CAO9r8zO1+brQroYufMZ2K=ZH_PBBpzYPsdYm-DT3K2GxoKJs9A@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] mm/zswap: Implement per-cgroup proactive writeback
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, tj@kernel.org, hannes@cmpxchg.org, 
	shakeel.butt@linux.dev, mhocko@kernel.org, mkoutny@suse.com, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Hao Jia <jiahao1@lixiang.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16322-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,gmail.com,vger.kernel.org,kvack.org,lixiang.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 906CA5DB9C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 4:56=E2=80=AFAM Hao Jia <jiahao.kernel@gmail.com> w=
rote:
>
>
>
> On 2026/5/26 03:24, Andrew Morton wrote:
> > On Mon, 25 May 2026 20:22:38 +0800 Hao Jia <jiahao.kernel@gmail.com> wr=
ote:
> >
> >> Zswap currently writes back pages to backing swap reactively, triggere=
d
> >> either by the shrinker or by the pool reaching its size limit. Althoug=
h
> >> proactive memory reclaim can automatically write back a portion of zsw=
ap
> >> pages via the shrinker, it cannot explicitly control the amount of
> >> writeback for a specific memory cgroup. Moreover, proactive memory rec=
laim
> >> may not always be triggered during a steady state.
> >>
> >> In certain scenarios, it is desirable to trigger writeback in advance =
to
> >> free up memory. For example, users may want to prepare for an upcoming
> >> memory-intensive workload by flushing cold memory to the backing stora=
ge
> >> when the system is relatively idle.
> >>
> >> This patch series introduces a "zswap_writeback_only" key to memory.re=
claim
> >> cgroup interface, allowing users to proactively write back cold compre=
ssed
> >> pages from zswap to the backing swap device. When specified, this key
> >> bypasses standard memory reclaim and exclusively performs proactive zs=
wap
> >> writeback up to the requested budget. If omitted, the default reclaim
> >> behavior remains unchanged.
> >
> > Thanks.  AI review found a few things to complain about, one of them
> > described as "preexisting".
> >
>
> Thanks Andrew.  I have replied to the AI's review comments in a separate
> email and posted v3.
> https://lore.kernel.org/all/20260526114601.67041-1-jiahao.kernel@gmail.co=
m

Generally speaking, please give time for reviewers to take a look
before sending a new version. Less than a day is usually too fast
(unless you're iterating super fast with the reviewers). Review
feedback does not have to be addressed immediately, usually wait for a
bit to collect as much feedback as possible before spinning a new
version.

I will take a look at v3 soon, thank you.

