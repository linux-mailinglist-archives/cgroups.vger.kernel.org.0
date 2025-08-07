Return-Path: <cgroups+bounces-9018-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC60B1D5EF
	for <lists+cgroups@lfdr.de>; Thu,  7 Aug 2025 12:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F244C188B873
	for <lists+cgroups@lfdr.de>; Thu,  7 Aug 2025 10:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E0626561E;
	Thu,  7 Aug 2025 10:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b="XuYOyLEo"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-internal.sh.cz (mail-internal.sh.cz [95.168.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D85642AA5;
	Thu,  7 Aug 2025 10:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.168.196.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754563356; cv=none; b=kD7SOm4Tv/HrRKULr59yBBTwZBMx7rRs/uoXPDxXYm9DT1x9ljVy54XYXAeK79z3pIblrqP2Cbd3PuwzMxqoyw5J68FaDSMcoZzYkPVEOaf+CtnqyAWg22sjkJlYwMHcvXTLbh4Slyfu6b/ZIIAbASCHkFJb/4mkqJowAwO67I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754563356; c=relaxed/simple;
	bh=uEClY7LPz0ZQz892ElwPiZ0st3AddHCFOuMtw3NJP2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R1ddRNfe11mVQEDycsS7z+Mu0h7UxrSKMvmaQ3EvLTQ/zWaYPtgeJryT4P5C6S0/GIiqaH2h+Dzk0/RgxzM46CPa1qllMAHS8gzH1lzFOwyTyr/uxIusheWWBbeEKIY7uuQe/9WllnMB1AGyDRFFPcug2WqPY1KY3H8wtZnRC3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com; spf=pass smtp.mailfrom=cdn77.com; dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b=XuYOyLEo; arc=none smtp.client-ip=95.168.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdn77.com
DKIM-Signature: a=rsa-sha256; t=1754563352; x=1755168152; s=dkim2019; d=cdn77.com; c=relaxed/relaxed; v=1; bh=t/+/mrODyNw9MXZjsQrkLISHSqDimQvNJ/N4aXmdAMc=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
   b=XuYOyLEof/yR5Zigu2Yo4wxAWely2P7euLKqPrM8XmzwNIIvYr/gXj/bEhITTxfUjJq20CDRtCBQiGhkrskF1qyy2KHxWL++0IcvEA/n5GvW3IIBGGfhIoR4pddJnbqLOZ/jfPZD23Jq2QVGlxDKrgZdXCNZBe9B9fTXLGpU6nQ=
Received: from [10.0.5.28] ([95.168.203.222])
        by mail.sh.cz (14.1.0 build 16 ) with ASMTP (SSL) id 202508071242243634;
        Thu, 07 Aug 2025 12:42:24 +0200
Message-ID: <5e32aded-bcff-40d2-aef1-20a1cf6f4f8e@cdn77.com>
Date: Thu, 7 Aug 2025 12:42:23 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] memcg: expose socket memory pressure in a cgroup
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org,
 netdev@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Matyas Hurtik <matyas.hurtik@cdn77.com>
References: <20250805064429.77876-1-daniel.sedlak@cdn77.com>
 <fcnlbvljynxu5qlzmnjeagll7nf5mje7rwkimbqok6doso37gl@lwepk3ztjga7>
Content-Language: en-US
From: Daniel Sedlak <daniel.sedlak@cdn77.com>
In-Reply-To: <fcnlbvljynxu5qlzmnjeagll7nf5mje7rwkimbqok6doso37gl@lwepk3ztjga7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CTCH: RefID="str=0001.0A00210C.689482D2.0077,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

On 8/6/25 1:02 AM, Shakeel Butt wrote:
> On Tue, Aug 05, 2025 at 08:44:29AM +0200, Daniel Sedlak wrote:
>> This patch is a result of our long-standing debug sessions, where it all
>> started as "networking is slow", and TCP network throughput suddenly
>> dropped from tens of Gbps to few Mbps, and we could not see anything in
>> the kernel log or netstat counters.
>>
>> Currently, we have two memory pressure counters for TCP sockets [1],
>> which we manipulate only when the memory pressure is signalled through
>> the proto struct [2]. However, the memory pressure can also be signaled
>> through the cgroup memory subsystem, which we do not reflect in the
>> netstat counters. In the end, when the cgroup memory subsystem signals
>> that it is under pressure, we silently reduce the advertised TCP window
>> with tcp_adjust_rcv_ssthresh() to 4*advmss, which causes a significant
>> throughput reduction.
>>
>> Keep in mind that when the cgroup memory subsystem signals the socket
>> memory pressure, it affects all sockets used in that cgroup.
>>
>> This patch exposes a new file for each cgroup in sysfs which signals
>> the cgroup socket memory pressure. The file is accessible in
>> the following path.
>>
>>    /sys/fs/cgroup/**/<cgroup name>/memory.net.socket_pressure
> 
> let's keep the name concise. Maybe memory.net.pressure?
> 

Sure, I can rename it for v5.

Thanks!
Daniel


