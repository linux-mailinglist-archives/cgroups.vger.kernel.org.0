Return-Path: <cgroups+bounces-9308-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 613B9B3023C
	for <lists+cgroups@lfdr.de>; Thu, 21 Aug 2025 20:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C00417D80E
	for <lists+cgroups@lfdr.de>; Thu, 21 Aug 2025 18:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105C8343D87;
	Thu, 21 Aug 2025 18:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b="CbHGaVTf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-internal.sh.cz (mail-internal.sh.cz [95.168.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12574335BAB;
	Thu, 21 Aug 2025 18:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.168.196.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755801859; cv=none; b=CH2VfETyQ7jK99Aw8jrMYvuThlX21VYKU5p14tiP93i7ZHE3I8UpOxchQuGcujob8Mi4DlzMBFjs9Rgtq5O0SPJ5IBRFKQZHQz8tvPIgUdsSPIzmmSXNQTAB0ViiCC01e6ZlRZG/iHZPuYojLDmrq93njSCZk4TSmREaQGnJn3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755801859; c=relaxed/simple;
	bh=D16jsCHVy/Ic2lQz9AmOdHJYWR4N/nlfoWFCTmcu/oM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vCM7P/ecEYsM3e8wWTRZ9sHPlyjUiPTGiDJ/yVDpsOuLMCCriAwluaNuTqNwXSl7fdMLXZOLEMHxSza3XGdEakBeMlvzN14jy1kDfbI/uKDoMo3a6Zt8+0KtJk8r0KJPqunpZHAi27J5MNfF1Ef/IeXAUC7LiLMmHEtydttUJWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com; spf=pass smtp.mailfrom=cdn77.com; dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b=CbHGaVTf; arc=none smtp.client-ip=95.168.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdn77.com
DKIM-Signature: a=rsa-sha256; t=1755801849; x=1756406649; s=dkim2019; d=cdn77.com; c=relaxed/relaxed; v=1; bh=bjBzbYOJlLNoEFfSNXFlpKexNeNZRAUPsNyoE1U3vUI=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
   b=CbHGaVTf3If/ptzjPsO+GpjYx0DXlemHfrAiFMy0U7WTbRDbxZp2J6MO/2+YuOhAKa/Y9Exp0OxEZU4i/3lovvcwdy+E+8L0FaLtBu+1VCjDfb9PtfikwJKsZiQTtpCGJQhEXl8uMauNzHdJ96PEmE8AEhKBoLwn7KF7BCAsoHw=
Received: from [192.168.0.206] ([78.44.198.142])
        by mail.sh.cz (14.1.0 build 16 ) with ASMTP (SSL) id 202508212044088574;
        Thu, 21 Aug 2025 20:44:08 +0200
Message-ID: <29defc2f-1dd4-4269-8677-34bb1ce44a55@cdn77.com>
Date: Thu, 21 Aug 2025 20:44:07 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] memcg: expose socket memory pressure in a cgroup
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Daniel Sedlak <daniel.sedlak@cdn77.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 David Ahern <dsahern@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org,
 netdev@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org
References: <20250805064429.77876-1-daniel.sedlak@cdn77.com>
 <aJeUNqwzRuc8N08y@slm.duckdns.org>
 <gqeq3trayjsylgylrl5wdcrrp7r5yorvfxc6puzuplzfvrqwjg@j4rr5vl5dnak>
 <aJzTeyRTu_sfm-9R@slm.duckdns.org>
 <e65222c1-83f9-4d23-b9af-16db7e6e8a42@cdn77.com>
 <aKYb7_xshbtFbXjb@slm.duckdns.org>
 <fa039702-3d60-4dc0-803a-b094b41fd2b9@cdn77.com>
 <kyy6mxg4g6aer2mht3xawiq56ytveg7vllg7o6f7dgivkoh52z@ccinqivomtyl>
Content-Language: en-US, cs
From: Matyas Hurtik <matyas.hurtik@cdn77.com>
In-Reply-To: <kyy6mxg4g6aer2mht3xawiq56ytveg7vllg7o6f7dgivkoh52z@ccinqivomtyl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A002101.68A768F9.0008,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

Hello,

On 8/20/25 11:34 PM, Shakeel Butt wrote:
> On Wed, Aug 20, 2025 at 10:37:49PM +0200, Matyas Hurtik wrote:
>> Result of mem_cgroup_under_socket_pressure() depends on whether self 
>> or any ancestors have had socket_pressure set. So any duration of an 
>> ancestor being throttled would also mean the child was being 
>> throttled. By summing our and our ancestors socket_pressure_duration 
>> we should get our total time being throttled (possibly more because 
>> of overlaps). 
> This is not how memcg stats (and their semantics) work and maybe that 
> is not what you want. In the memcg stats semactics for a given memcg 
> the socket_pressure_duration metric is not the stall duration faced by 
> sockets in memcg but instead it will be stall duration caused by the 
> memcg and its descendants. If that is not what we want, we need to do 
> something different and orthogonal to memcg stats.

By memcg stats, do you mean only the contents of the memory.stat file?

Would it be semantically consistent if we were to put it into
a separate file (like memory.net.throttled) instead?

Just to summarize the proposals of different methods of hierarchical 
propagation:

1) None - keeping the reported duration local to that cgroup:

    value = self

    Would not be too out of place, since memory.events.local
    already does not accumulate hierarchically.
    To determine whether sockets in a memcg were throttled,
    we would traverse the /sys/fs/cgroup/ hierarchy from root to
    the cgroup of interest and sum those local durations.

2) Propagating the duration upwards (using rstat or simple iteration
    towards root memcg during write):

    value = self + sum of children

    Most semantically consistent with other exposed stat files.
    Could be added as an entry into memory.stat.
    Since the pressure gets applied from ancestors to children
    (see mem_cgroup_under_socket_pressure()), determining the duration of
    throttling for sockets in some cgroup would be hardest in this variant.

    It would involve iterating from the root to the examined cgroup and
    at each node subtracting the values of its children from that nodes 
value,
    then the sum of that would correspond to the total duration throttled.

3) Propagating the duration downwards (write only locally,
    read traversing hierarchy upwards):

    value = self + sum of ancestors

    Mirrors the logic used in mem_cgroup_under_socket_pressure(),
    increase in the reported value for a memcg would coincide with more
    throttling being done to the sockets of that memcg.

I think that variant 3 would be the most useful for diagnosing
when this socket throttling happens in a certain memcg.

I'm not sure if I understand the use case of variant 2.

Thanks,
Matyas


