Return-Path: <cgroups+bounces-9299-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0735AB2E6BE
	for <lists+cgroups@lfdr.de>; Wed, 20 Aug 2025 22:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7088E7AA0B0
	for <lists+cgroups@lfdr.de>; Wed, 20 Aug 2025 20:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFEC2D2494;
	Wed, 20 Aug 2025 20:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b="3mmZCMJ4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-internal.sh.cz (mail-internal.sh.cz [95.168.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF379295DBD;
	Wed, 20 Aug 2025 20:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.168.196.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755722278; cv=none; b=Lsty+Uuy4khL/0z5KQCUZ410u85xUehzjz1O8HNPOWSmseLH23rJV1Qp4J2YNG8Enh0QlzeB1z4/j8uKwwQiHNvJ/YYOLOa6t/yV7NnsQyaBZ0aGw23WVpPNzPdCik0yGL89/pkzh/Mg8a//Y9HYIOBFiJNZuxGpXRcR3yOMEdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755722278; c=relaxed/simple;
	bh=OSOp8Yh92wxfDZNfy0wpSvutl0RdqprLliCEgmiXFLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IveIVR5Wp6fHJbC84fgzNpyWtJEwErg0SHAhS2qcAKhY6e9I+kMjB2k8XOfwwqqBAooK3uMn+epMczAC94gMg0dhdmRk8oQuN3g32THDWtvaCnKW/G1k8UawqPkIpj4EVlZjgT4a2vEHPiL6G9AFi7+rOio4ArRCYK4n7RMvw3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com; spf=pass smtp.mailfrom=cdn77.com; dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b=3mmZCMJ4; arc=none smtp.client-ip=95.168.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdn77.com
DKIM-Signature: a=rsa-sha256; t=1755722273; x=1756327073; s=dkim2019; d=cdn77.com; c=relaxed/relaxed; v=1; bh=rVaPb/FC4PHKTD/XuKegsQ+CXxMYcycndmhjeELweqg=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
   b=3mmZCMJ4umanZdA6PxqH/ZZlzjZl6Hr2mtn5c6R7MuYhwg/XAG2QoM7qHXQFRDPtBdrOUvXSjXK7yaBA2gWzRNnJUdSzHEs1dvIDIqVNxS1oZ2pVwNRF6geOPaJRDQ/tiek2GIWsc2ccpfjIc1PclkXH/C0vqyedMpAjBmjUzSM=
Received: from [192.168.0.206] ([78.44.198.142])
        by mail.sh.cz (14.1.0 build 16 ) with ASMTP (SSL) id 202508202237494479;
        Wed, 20 Aug 2025 22:37:49 +0200
Message-ID: <fa039702-3d60-4dc0-803a-b094b41fd2b9@cdn77.com>
Date: Wed, 20 Aug 2025 22:37:49 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] memcg: expose socket memory pressure in a cgroup
To: Tejun Heo <tj@kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Daniel Sedlak <daniel.sedlak@cdn77.com>,
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
 <e65222c1-83f9-4d23-b9af-16db7e6e8a42@cdn77.com>
 <aKYb7_xshbtFbXjb@slm.duckdns.org>
Content-Language: en-US, cs
From: Matyas Hurtik <matyas.hurtik@cdn77.com>
In-Reply-To: <aKYb7_xshbtFbXjb@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A002118.68A631CC.007B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

Hello,

On 8/20/25 9:03 PM, Tejun Heo wrote:
> On Wed, Aug 20, 2025 at 06:51:07PM +0200, Matyas Hurtik wrote:
>> And the read side:   total_duration = 0;   for (; 
>> !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg))     
>> total_duration += atomic_long_read(&memcg->socket_pressure_duration); 
>> Would that work? 
> This doesn't make sense to me. Why would a child report the numbers 
> from its ancestors?

Result of mem_cgroup_under_socket_pressure() depends on
whether self or any ancestors have had socket_pressure set.

So any duration of an ancestor being throttled would also
mean the child was being throttled.

By summing our and our ancestors socket_pressure_duration
we should get our total time being throttled
(possibly more because of overlaps).

Thanks,
Matyas

