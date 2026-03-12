Return-Path: <cgroups+bounces-14782-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GO16IFwpsmleJQAAu9opvQ
	(envelope-from <cgroups+bounces-14782-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2026 03:47:56 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AC026C6E5
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2026 03:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02D75307670D
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2026 02:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D64337EFF5;
	Thu, 12 Mar 2026 02:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pl1wvej5"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3AB333434
	for <cgroups@vger.kernel.org>; Thu, 12 Mar 2026 02:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773283637; cv=none; b=lETm4LbnL4JJ4kl81NRHu0XVyG1g0DfNbkODK1KuYBC+w6JRlIRV4KP4MV0zxh+pGD5uH8c+5p9cqz/+8PB/soBM88jgpe5dDkNPSh8Z3lf1rFzlr6LVlYgbt4T056OZtgN8JLLMYWaeVXvM7Rv/H9ZeOD77G3z7RDkqxyLHllI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773283637; c=relaxed/simple;
	bh=bn22wJ7ckCW5LunWe8zrG07xQ/9uHxRHUmDSBAcb/oU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WP9eOXghWTJnMKysx/UclQC2h+ZEBWpvoklz1SZQTUbtU/gvSDvP0by6gegKEsWjasinQMf2njYXrGs39L4kASbLWZfJ92qYAirgo5xFF6BAG9yh+nU3TBNIYiKRljdGMnJFjI2dua2wHf0ox7gPEquzoJhUVesane+6VXtPud8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pl1wvej5; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773283623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bn22wJ7ckCW5LunWe8zrG07xQ/9uHxRHUmDSBAcb/oU=;
	b=pl1wvej5D2Yz+aDVoFPsDWCvqwPHXwNrvdxO4nqaau4RsfYAyzqGQIDN8yI6wkuerZ+X4P
	ZDGbzlOcZxxm4FS8OyTxMRh9hMr0YrKMX3KTPpuJ9UK97OYQeLMnmLqJQCRsk4iXYPnBNm
	d1zUpjd9ueHL/DhtAMgYjaQcmKsyMQ0=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [LSF/MM/BPF TOPIC] Reimagining Memory Cgroup (memcg_ext)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <abHPsCypwo7ZhqIt@linux.dev>
Date: Thu, 12 Mar 2026 10:46:10 +0800
Cc: lsf-pc@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Tejun Heo <tj@kernel.org>,
 Michal Hocko <mhocko@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Alexei Starovoitov <ast@kernel.org>,
 =?utf-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hui Zhu <hui.zhu@linux.dev>,
 JP Kobryn <inwardvessel@gmail.com>,
 Geliang Tang <geliang@kernel.org>,
 Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 David Rientjes <rientjes@google.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Meta kernel team <kernel-team@meta.com>,
 linux-mm@kvack.org,
 cgroups@vger.kernel.org,
 bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8F3593EB-9D81-4459-8675-E922426DCB1E@linux.dev>
References: <20260307182424.2889780-1-shakeel.butt@linux.dev>
 <3ECC9B38-6C1A-4F60-9C18-98B7A1A56355@linux.dev> <abHPsCypwo7ZhqIt@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14782-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,linux-foundation.org,kernel.org,suse.com,cmpxchg.org,linux.dev,gmail.com,dorminy.me,etsalapatis.com,google.com,meta.com,kvack.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,memory.events:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D3AC026C6E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> On Mar 12, 2026, at 04:39, Shakeel Butt <shakeel.butt@linux.dev> =
wrote:
>=20
> On Wed, Mar 11, 2026 at 03:19:31PM +0800, Muchun Song wrote:
>>=20
>>=20
>>> On Mar 8, 2026, at 02:24, Shakeel Butt <shakeel.butt@linux.dev> =
wrote:
>>>=20
>=20
> [...]
>=20
>>>=20
>>> Per-Memcg Background Reclaim
>>>=20
>>> In the new memcg world, with the goal of (mostly) eliminating direct =
synchronous
>>> reclaim for limit enforcement, provide per-memcg background =
reclaimers which can
>>> scale across CPUs with the allocation rate.
>>=20
>> Hi Shakeel,
>>=20
>> I'm quite interested in this. Internally, we privately maintain a set
>> of code to implement asynchronous reclamation, but we're also trying =
to
>> discard these private codes as much as possible. Therefore, we want =
to
>> implement a similar asynchronous reclamation mechanism in user space
>> through the memory.reclaim mechanism. However, currently there's a =
lack
>> of suitable policy notification mechanisms to trigger user threads to
>> proactively reclaim in advance.
>=20
> Cool, can you please share what "suitable policy notification =
mechanisms" you
> need for your use-case? This will give me more data on the comparison =
between
> memory.reclaim and the proposed approach.

If we expect the proactive reclamation to be triggered when the current
memcg's memory usage reaches a certain point, we have to continuously =
read
memory.current to determine whether it has reached our set watermark =
value
to trigger asynchronous reclamation. Perhaps we need an event that can =
notify
user-space threads when the current memory usage reaches a specific
watermark value. Currently, the events supported by memory.events may =
lack
the capability for custom watermarks.

>=20
>=20
>>=20
>>>=20
>>> Lock-Aware Throttling
>>>=20
>>> The ability to avoid throttling an allocating task that is holding =
locks, to
>>> prevent priority inversion. In Meta's fleet, we have observed lock =
holders stuck
>>> in memcg reclaim, blocking all waiters regardless of their priority =
or
>>> criticality.
>>=20
>> This is a real problem we encountered, especially with the jbd =
handler
>> resources of the ext4 file system. Our current attempt is to defer
>> memory reclamation until returning to user space, in order to solve
>> various priority inversion issues caused by the jbd handler. =
Therefore,
>> I would be interested to discuss this topic.
>=20
> Awesome, do you use memory.max and memory.high both and defer the =
reclaim for
> both? Are you deferring all the reclaims or just the ones where the =
charging
> process has the lock? (I need to look what jbd handler is).
>=20

We do not use memory.high, although it supports deferring memory =
reclamation
to user-space, it also attempts to throttle memory allocation speed, =
which
introduces significant latency. In our application's case, we would =
rather
accept an OOM under such circumstances. We previously attempted to =
address
the priority inversion issue caused by the jbd handler separately (which =
we
frequently encounter since we use the ext4 file system), and you can =
refer
to this [1]. Of course, this solution lacks generality, as it requires
calling new interfaces for various lock resources. Therefore, we =
internally
have a more aggressive idea: defer all reclamation triggered by =
kernel-space
memory allocation until just before returning to user-space. This should
resolve the vast majority of priority inversion problems. The only =
potential
issue introduced is that kernel-space memory usage may briefly exceed =
memory.max.

[1] =
https://lore.kernel.org/linux-mm/cover.1750234270.git.hezhongkun.hzk@byted=
ance.com/#r

Muchun,
Thanks.


