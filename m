Return-Path: <cgroups+bounces-9165-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B602BB26C98
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 18:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87CAD3BD3C4
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 16:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56FA2566E9;
	Thu, 14 Aug 2025 16:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b="j8zGTjgi"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-internal.sh.cz (mail-internal.sh.cz [95.168.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F26253B52;
	Thu, 14 Aug 2025 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.168.196.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755189162; cv=none; b=Z6hoV9lh6nQVAz5EiM+/e42xHwy1LbUqVG0LedQw9s0MpZlSzv0KxKZnGL7c//QZ1aoIFUsQLrY039oncarSbRwvXeGldyUxzaNL4/n+ZR1dbsZdjHnORuPnKy/0zuWlH5mFyl2iB5e7y8z0JO7C8FIdH8botho4mz5YqKQVAHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755189162; c=relaxed/simple;
	bh=rz6aEDvh43JPGkc3MUifcoYgIR44lhm+JeiVqlJtefY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZKxYl63ygltXyA1HyMZ3VZOWDjwNSnLAvaivpoE7p43IdDzN8ehovZ7iWb9s8HRsfK87nkmPXca3zC+o7P5twwn+rI77jcovGvWPx+tolDhzXaZNtHVva/luDieGhQdhdPTALUzVSBjFK27CTuqg/r45hDYEJEONWeVbn/uqzIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com; spf=pass smtp.mailfrom=cdn77.com; dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b=j8zGTjgi; arc=none smtp.client-ip=95.168.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdn77.com
DKIM-Signature: a=rsa-sha256; t=1755188844; x=1755793644; s=dkim2019; d=cdn77.com; c=relaxed/relaxed; v=1; bh=GKRpkbuM0/E1wsSLFsbRln4KtsFPqU6wbMr0a/aHKeA=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
   b=j8zGTjgiu1Lbnh6rbl49SMWTbww4nmtpvOx4j5K9rUFmeSWNGesTct+bV42djMrLiH/FD4mRmjhcOwc6h705IPcgywAdEGBDHgTXHReEDGwba3mM1Ce4YtaUuXxfz9/lPBiXKI4OV3qEpbU8fi7Gf531nRoGCltjXZbkwX5rNDM=
Received: from [10.26.1.187] ([80.250.18.198])
        by mail.sh.cz (14.1.0 build 16 ) with ASMTP (SSL) id 202508141827234129;
        Thu, 14 Aug 2025 18:27:23 +0200
Message-ID: <4937aca8-8ebb-47d5-986f-7bb27ddbdaba@cdn77.com>
Date: Thu, 14 Aug 2025 18:27:22 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] memcg: expose socket memory pressure in a cgroup
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Daniel Sedlak <daniel.sedlak@cdn77.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org,
 netdev@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
References: <20250805064429.77876-1-daniel.sedlak@cdn77.com>
 <fcnlbvljynxu5qlzmnjeagll7nf5mje7rwkimbqok6doso37gl@lwepk3ztjga7>
 <CAAVpQUBrNTFw34Kkh=b2bpa8aKd4XSnZUa6a18zkMjVrBqNHWw@mail.gmail.com>
 <nju55eqv56g6gkmxuavc2z2pcr26qhpmgrt76jt5dte5g4trxs@tjxld2iwdc5c>
 <CAAVpQUCCg-7kvzMeSSsKp3+Fu8pvvE5U-H5wkt=xMryNmnF5CA@mail.gmail.com>
 <chb7znbpkbsf7pftnzdzkum63gt7cajft2lqiqqfx7zol3ftre@7cdg4czr5k4j>
 <0f6a8c37-95e0-4009-a13b-99ce0e25ea47@cdn77.com>
 <qsncixzj7s7jd7f3l2erjjs7cx3fanmlbkh4auaapsvon45rx3@62o2nqwrb43e>
Content-Language: en-US
From: Matyas Hurtik <matyas.hurtik@cdn77.com>
In-Reply-To: <qsncixzj7s7jd7f3l2erjjs7cx3fanmlbkh4auaapsvon45rx3@62o2nqwrb43e>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A00210F.689E0DCE.007A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

On 8/7/25 10:52 PM, Shakeel Butt wrote:

> We definitely don't need a global lock. For memcg->net_pressure_lock, we
> need to be very clear why we need this lock. Basically we are doing RMW
> on memcg->socket_pressure and we want known 'consistently' how much
> further we are pushing memcg->socket_pressure. In other words the
> consistent value of diff. The lock is one way to get that consistent
> diff. We can also play some atomic ops trick to get the consistent value
> without lock but I don't think that complexity is worth it.

Hello,


I tried implementing the second option, making the diff consistent using 
atomics.
Would something like this work?

if (level > VMPRESSURE_LOW) {
   unsigned long new_socket_pressure;
   unsigned long old_socket_pressure;
   unsigned long duration_to_add;
   /*
     * Let the socket buffer allocator know that
     * we are having trouble reclaiming LRU pages.
     *
     * For hysteresis keep the pressure state
     * asserted for a second in which subsequent
     * pressure events can occur.
     */
   new_socket_pressure = jiffies + HZ;
   old_socket_pressure = atomic_long_xchg(
     &memcg->socket_pressure, new_socket_pressure);

   duration_to_add = jiffies_to_usecs(
     min(new_socket_pressure - old_socket_pressure, HZ));

   do {
     atomic_long_add(duration_to_add, &memcg->socket_pressure_duration);
   } while ((memcg = parent_mem_cgroup(memcg)));
}

memcg->socket_pressure would need to be changed into atomic_long_t,
but we avoid adding the memcg->net_pressure_lock.

> We don't need memcg->net_pressure_lock's protection for
> sk_pressure_duration of the memcg and its ancestors if additions to
> sk_pressure_duration are atomic.

With regards to the hierarchical propagation I noticed during testing that
vmpressure() was sometimes called with memcgs, created for systemd oneshot
services, that were at that time no longer present in the /sys/fs/cgroup 
tree.
This then made their parent counters a lot larger than just sum of the 
subtree
plus value of self. Would this behavior be correct?


Thanks,

Matyas


