Return-Path: <cgroups+bounces-10776-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8457BBDEDEF
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 15:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44B974FDD8C
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 13:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5AF23B604;
	Wed, 15 Oct 2025 13:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b="GTRNRPra"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-internal.sh.cz (mail-internal.sh.cz [95.168.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192DD2459C6;
	Wed, 15 Oct 2025 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.168.196.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536664; cv=none; b=QEXCIigXYBQV4fdFzr0DwVXLvl2ZkK61LejRrAaSDZu+LYvRUuoEJlo5QjeBCUnHa0L0y9G4qbvj3OVk6Bvcy+Qgpo4o+afNPIQihg8Xx6NTNJU8On/qFVRrzJxwFYDfVEi/SVfAQ4Taa7kacVHcFsH3gvEDW5/rf1guZozJYFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536664; c=relaxed/simple;
	bh=IC/A2xrVn0KsZs6cTMAvZegDyu//Z94Lb+/v2uVh0tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GRsXtYBsmfRdRzRhaxSqWXjVqUQd0oNB9tJadeSxR3ejsi9yzUYXpOUphbbNVpP5lOJ65Z6Uvg9ABtohEQVs2AFSP/7yMt45gkG5WCT4ECjgbE9UsCsDv6x5woPMHWSDtF25Zv8l87/PIyRAaVCXn0v9UCvCsy2b5MSXac4jHLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com; spf=pass smtp.mailfrom=cdn77.com; dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b=GTRNRPra; arc=none smtp.client-ip=95.168.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdn77.com
DKIM-Signature: a=rsa-sha256; t=1760536651; x=1761141451; s=dkim2019; d=cdn77.com; c=relaxed/relaxed; v=1; bh=UoCSU4XyYx59fD12dxoPWCIwk1oQ2hfxBjxFdeb3MWY=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
   b=GTRNRPra9zCnXGizQYbz/tnpG+eEpB/eReNgN4avTVOY25rovQ4/A57OZYw69x3YXXqieJC6zgIOzGJ+sjAxmIGpDsp8/5iLWU64ArpDNbyBC7z1gQ0X3IspmfhNYeN72xRF65U1keYTDEYYgXqqjvNkB8WBk3bHHXkw4oUeZ6Q=
Received: from [10.0.5.28] ([95.168.203.222])
        by mail.sh.cz (14.1.0 build 17 ) with ASMTP (SSL) id 202510151557309450;
        Wed, 15 Oct 2025 15:57:30 +0200
Message-ID: <5e603850-2cfc-4eb6-a5cc-da5282525b0d@cdn77.com>
Date: Wed, 15 Oct 2025 15:57:29 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] memcg: expose socket memory pressure in a cgroup
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 David Ahern <dsahern@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org,
 netdev@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Matyas Hurtik <matyas.hurtik@cdn77.com>
References: <20251007125056.115379-1-daniel.sedlak@cdn77.com>
 <87qzvdqkyh.fsf@linux.dev> <13b5aeb6-ee0a-4b5b-a33a-e1d1d6f7f60e@cdn77.com>
 <87o6qgnl9w.fsf@linux.dev>
 <tr7hsmxqqwpwconofyr2a6czorimltte5zp34sp6tasept3t4j@ij7acnr6dpjp>
 <87a5205544.fsf@linux.dev>
 <qdblzbalf3xqohvw2az3iogevzvgn3c3k64nsmyv2hsxyhw7r4@oo7yrgsume2h>
 <875xcn526v.fsf@linux.dev> <89618dcb-7fe3-4f15-931b-17929287c323@cdn77.com>
 <6ras4hgv32qkkbh6e6btnnwfh2xnpmoftanw4xlbfrekhskpkk@frz4uyuh64eq>
Content-Language: en-US
From: Daniel Sedlak <daniel.sedlak@cdn77.com>
In-Reply-To: <6ras4hgv32qkkbh6e6btnnwfh2xnpmoftanw4xlbfrekhskpkk@frz4uyuh64eq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CTCH: RefID="str=0001.0A2D031F.68EFA84A.007C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

On 10/14/25 10:32 PM, Shakeel Butt wrote:
> On Mon, Oct 13, 2025 at 04:30:53PM +0200, Daniel Sedlak wrote:
> [...]
>>>>>> How about we track the actions taken by the callers of
>>>>>> mem_cgroup_sk_under_memory_pressure()? Basically if network stack
>>>>>> reduces the buffer size or whatever the other actions it may take when
>>>>>> mem_cgroup_sk_under_memory_pressure() returns, tracking those actions
>>>>>> is what I think is needed here, at least for the debugging use-case.
>>
>> I am not against it, but I feel that conveying those tracked actions (or how
>> to represent them) to the user will be much harder. Are there already
>> existing APIs to push this information to the user?
>>
> 
> I discussed with Wei Wang and she suggested we should start tracking the
> calls to tcp_adjust_rcv_ssthresh() first. So, something like the
> following. I would like feedback frm networking folks as well:

Looks like a good start. Are you planning on sending this patch 
separately, or can we include it in our v6 (with maybe slight 
modifications)?
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 873e510d6f8d..5fe254813123 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -52,6 +52,7 @@ enum memcg_memory_event {
>   	MEMCG_SWAP_HIGH,
>   	MEMCG_SWAP_MAX,
>   	MEMCG_SWAP_FAIL,
> +	MEMCG_SOCK_THROTTLED,

This probably should be MEMCG_TCP_SOCK_THROTTLED, because it checks only 
tcp_under_memory_pressure, however there is also the 
sk_under_memory_pressure used in net/sctp/sm_statefuns.c:6597 to also 
reduce the sending rate. Or also add the counter there and keep the name?

Thanks!
Daniel

