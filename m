Return-Path: <cgroups+bounces-9296-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96381B2E2B1
	for <lists+cgroups@lfdr.de>; Wed, 20 Aug 2025 18:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FB1916ECB1
	for <lists+cgroups@lfdr.de>; Wed, 20 Aug 2025 16:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BC53314B1;
	Wed, 20 Aug 2025 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b="fg/O2ocZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-internal.sh.cz (mail-internal.sh.cz [95.168.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111B872634;
	Wed, 20 Aug 2025 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.168.196.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755708680; cv=none; b=YH7EtU/Ble0tj8JavXu+cG0X9QrnK9UNMP4YKL0vtfeTlRfW17BoSnQAu6mz7JC/fqm4YMPPu7FaqFJ0zZ2n+k9UgJ5fni4pq43ItloZVVai6fIf/dzetb/dkQrsPCaM8o0fIG0xWam9J5GPrSf58UH0iM0SL9vRRvjM1wgm1R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755708680; c=relaxed/simple;
	bh=ba719obtLPXDjN/hMxv84tLxoFOQDoplgjt+Dh1FquE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p38ySEPJXeNWxbpDgGyzPvJZW42kgDNEhqX/T9U0mNTb4aybyT4HpxLlm7hzEGiBZTpaMgvfn0LpAR02k10n2XVI4MHt5dYekdH9a5Og2GDTuZtCu4I7dNo/wCSxvt6XNMunwm2V5f3TWezAEYAN5p58FDWmaU3e0CX61Qym4w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com; spf=pass smtp.mailfrom=cdn77.com; dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b=fg/O2ocZ; arc=none smtp.client-ip=95.168.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdn77.com
DKIM-Signature: a=rsa-sha256; t=1755708669; x=1756313469; s=dkim2019; d=cdn77.com; c=relaxed/relaxed; v=1; bh=aEvEGZgaiQng64jbfPgPU723vPCPqVeUVZPTA1jHr5w=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
   b=fg/O2ocZjuJb1khY1d9W6L5zjRL5KJ/K0LsmwHwa0y9DFWT285xTXAWuf4fbnzx+YklJOUB6jWFwMHodGpTOQGabBHo2NK9M7roc2jjsW/1PXXCJ9O1TxiqmoCgrYggOUkxlmfT/U8FO3TdiIy/04hwdCWacLsh3U0Z7ogZkeVY=
Received: from [10.26.2.104] ([80.250.18.198])
        by mail.sh.cz (14.1.0 build 16 ) with ASMTP (SSL) id 202508201851072124;
        Wed, 20 Aug 2025 18:51:07 +0200
Message-ID: <e65222c1-83f9-4d23-b9af-16db7e6e8a42@cdn77.com>
Date: Wed, 20 Aug 2025 18:51:07 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] memcg: expose socket memory pressure in a cgroup
To: Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: Daniel Sedlak <daniel.sedlak@cdn77.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 David Ahern <dsahern@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>,
 linux-mm@kvack.org, netdev@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org
References: <20250805064429.77876-1-daniel.sedlak@cdn77.com>
 <aJeUNqwzRuc8N08y@slm.duckdns.org>
 <gqeq3trayjsylgylrl5wdcrrp7r5yorvfxc6puzuplzfvrqwjg@j4rr5vl5dnak>
 <aJzTeyRTu_sfm-9R@slm.duckdns.org>
Content-Language: en-US, cs
From: Matyas Hurtik <matyas.hurtik@cdn77.com>
In-Reply-To: <aJzTeyRTu_sfm-9R@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A002116.68A5FD2E.0047,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

Hello,

On 8/13/25 8:03 PM, Tejun Heo wrote:
> On Wed, Aug 13, 2025 at 02:03:28PM +0200, Michal Koutný wrote:
> ...
>> One more point to clarify -- should the value include throttling from
>> ancestors or not. (I think both are fine but) this semantic should also
>> be described in the docs. I.e. current proposal is
>> 	value = sum_children + self
>> and if you're see that C's value is 0, it doesn't mean its sockets
>> weren't subject of throttling. It just means you need to check also
>> values in C ancestors. Does that work?
> I was more thinking that it would account for all throttled durations, but
> it's true that we only count locally originating events for e.g.
> memory.events::low or pids.events::max. Hmm... I'm unsure. So, for events, I
> think local sources make sense as it's tracking what limits are triggering
> where. However, I'm not sure that translates well to throttle duration which
> is closer to pressure metrics than event counters. We don't distinguish the
> sources of contention when presenting pressure metrics after all.

I think calculating the value using self and ancestors would better match
the logic in mem_cgroup_under_socket_pressure() and it would avoid the
issue Michal outlined without relying on an explanation in the docs -
checking a single value per cgroup to confirm whether sockets belonging
to that cgroup were being throttled looks more intuitive to me.

If we were to have the write side of the stat in vmpressure() look 
something like:
   new_socket_pressure = jiffies + HZ;
   old_socket_pressure = atomic_long_xchg(
     &memcg->socket_pressure, new_socket_pressure);

   duration_to_add = jiffies_to_usecs(
     min(new_socket_pressure - old_socket_pressure, HZ));
   atomic_long_add(duration_to_add, &memcg->socket_pressure_duration);

And the read side:
   total_duration = 0;
   for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg))
     total_duration += atomic_long_read(&memcg->socket_pressure_duration);
Would that work?

There would be an issue with the reported value possibly being larger
than the real duration of the throttling, due to overlapping
intervals of socket_pressure with some ancestor. Is that a problem?

Thanks,
Matyas

