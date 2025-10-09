Return-Path: <cgroups+bounces-10619-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D705EBC9995
	for <lists+cgroups@lfdr.de>; Thu, 09 Oct 2025 16:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8439C4FDDB1
	for <lists+cgroups@lfdr.de>; Thu,  9 Oct 2025 14:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643FB2EA46F;
	Thu,  9 Oct 2025 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b="4Sa3zM8D"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-internal.sh.cz (mail-internal.sh.cz [95.168.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AA32EB847;
	Thu,  9 Oct 2025 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.168.196.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760021058; cv=none; b=BXBY/2lFc/ZA+jLGsVthixP4Xk3V1miNwL9vliqm5R8QPGh+Qp4M5FfIARNVNrIsg5QCSV74ZmBLf5T9jd0hXRrEMrgbdcoc8AWusE0eVpkA8iEPhju5d0SlcT2LhtSFK9oIttvMICg1eqZcOhA9YRdLVt/jl0m8Oyhhfv3kUXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760021058; c=relaxed/simple;
	bh=GJwJeFIPpG620HviwBNcU+VoSoiv+7fzEEmZ0FS2P48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WW1FoV5047cfUyQuIcygagDmmiPXs6WHJXpjV43h7SHZAKFWi6nknRiEwmZratxyjWu3MnkSMdSzH3Xkrq8loZDCqWPlbpAL9M554gD0ksWfgZse0VN9eawqa/jdxhxLzi3i9f7AmiQCHFOj45iX4REO9wHwNaErMz/YvPqB4ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com; spf=pass smtp.mailfrom=cdn77.com; dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b=4Sa3zM8D; arc=none smtp.client-ip=95.168.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdn77.com
DKIM-Signature: a=rsa-sha256; t=1760021046; x=1760625846; s=dkim2019; d=cdn77.com; c=relaxed/relaxed; v=1; bh=ToT0NvhlqFGtmHqtaoOHWloSTlf7psIb/sdAF5TIfxc=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
   b=4Sa3zM8DcUS5rZ3SLc/w5A+CEPjq7es5HLlbIW2+08+b4NY32YTRJyokfqJFtHcRpGJ6HiIZYCZ16+lP9nsssmpXcE4ZS5JvB23bxUOFfZfAMujFDMIipf9jCXfpedIp3Z+FZQ/4AdsdVi8bwTbVFdKCt0yPZYbgvateGqvTEXs=
Received: from [10.26.3.35] ([80.250.18.198])
        by mail.sh.cz (14.1.0 build 17 ) with ASMTP (SSL) id 202510091644051992;
        Thu, 09 Oct 2025 16:44:05 +0200
Message-ID: <13b5aeb6-ee0a-4b5b-a33a-e1d1d6f7f60e@cdn77.com>
Date: Thu, 9 Oct 2025 16:44:04 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] memcg: expose socket memory pressure in a cgroup
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>,
 linux-mm@kvack.org, netdev@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Matyas Hurtik <matyas.hurtik@cdn77.com>
References: <20251007125056.115379-1-daniel.sedlak@cdn77.com>
 <87qzvdqkyh.fsf@linux.dev>
Content-Language: en-US
From: Daniel Sedlak <daniel.sedlak@cdn77.com>
In-Reply-To: <87qzvdqkyh.fsf@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CTCH: RefID="str=0001.0A2D0305.68E7CA35.0040,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

Hi Roman,

On 10/8/25 8:58 PM, Roman Gushchin wrote:
>> This patch exposes a new file for each cgroup in sysfs which is a
>> read-only single value file showing how many microseconds this cgroup
>> contributed to throttling the throughput of network sockets. The file is
>> accessible in the following path.
>>
>>    /sys/fs/cgroup/**/<cgroup name>/memory.net.throttled_usec
> 
> Hi Daniel!
> 
> How this value is going to be used? In other words, do you need an
> exact number or something like memory.events::net_throttled would be
> enough for your case?

Just incrementing a counter each time the vmpressure() happens IMO 
provides bad semantics of what is actually happening, because it can 
hide important details, mainly the _time_ for how long the network 
traffic was slowed down.

For example, when memory.events::net_throttled=1000, it can mean that 
the network was slowed down for 1 second or 1000 seconds or something 
between, and the memory.net.throttled_usec proposed by this patch 
disambiguates it.

In addition, v1/v2 of this series started that way, then from v3 we 
rewrote it to calculate the duration instead, which proved to be better 
information for debugging, as it is easier to understand implications.

Thanks!
Daniel



