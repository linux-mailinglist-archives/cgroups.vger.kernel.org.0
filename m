Return-Path: <cgroups+bounces-11588-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C490C34826
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 09:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921DD1898FD7
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 08:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC5328D836;
	Wed,  5 Nov 2025 08:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pyx6Ff5c"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1755421ADB7
	for <cgroups@vger.kernel.org>; Wed,  5 Nov 2025 08:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762331979; cv=none; b=EW/EvuREGoVOjWwZlXOr6dDqELDApjd94iLUzm3zCTBI9Gqke7zj0sdmgmgGoaq56YiR/KHXBAOItVZVB3yi2S2UiGQC4NNF+++JnfpRaAO3tv3dhLivMcu+3dQrsN51bwIimpAYrQUWMpdPyJhdDWnBUKGOJfEs5MdG6bUuPHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762331979; c=relaxed/simple;
	bh=4q7MWOot5oujdh0jICrS9cF5T9tqDRdkxJ6+IOJjOh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gyluwuH9QrZYo5/utKr1yzskYvzeGtXiBXTG0UKB4FmWAN9gzvNt+VQQKrMyUpBZIBiklQDfGKX3ckGIkQv/gvLmR7JKNS1yJ4pBSd01QMYri8HzYf6iVgkG19P0yhzBFJskRcJr3SnNUYhqOdSLVE2Q7hBNAI+/HqdB1YYRUjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pyx6Ff5c; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <19986584-885b-4754-b98c-948e4bf9716b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762331965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iACYjLabBUF6JiLupF4Suvn3LPuLCNXMAQpDmoncQDw=;
	b=Pyx6Ff5cbTDxh6bFMoG56H+cQ6sG/0QG4qgsZ9U/tgGmlWxDHgKBH8LRRuc/D04Dzw5pNX
	g6ZfVel4yEKJAW2CjwpU6eKy7U0KdoQjwCfCxRL/M8IrFCSUtUTNNFJd6uaN19l7qnpWJF
	MThr76Zp+1t0ReNALTjfAzsXQoS1c1Y=
Date: Wed, 5 Nov 2025 16:39:18 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new v2] mm/memcontrol: Flush stats when write stat file
Content-Language: en-US
To: Michal Hocko <mhocko@suse.com>, Leon Huang Fu <leon.huangfu@shopee.com>
Cc: linux-mm@kvack.org, hannes@cmpxchg.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org,
 joel.granados@kernel.org, jack@suse.cz, laoar.shao@gmail.com,
 mclapinski@google.com, kyle.meyer@hpe.com, corbet@lwn.net,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
References: <20251105074917.94531-1-leon.huangfu@shopee.com>
 <aQsIq_zQXMfNNo6G@tiehlicka>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <aQsIq_zQXMfNNo6G@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/11/5 16:19, Michal Hocko wrote:
> On Wed 05-11-25 15:49:16, Leon Huang Fu wrote:
>> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
>> index 6eed14bff742..8cab6b52424b 100644
>> --- a/mm/memcontrol-v1.c
>> +++ b/mm/memcontrol-v1.c
>> @@ -2040,6 +2040,7 @@ struct cftype mem_cgroup_legacy_files[] = {
>>   	{
>>   		.name = "stat",
>>   		.seq_show = memory_stat_show,
>> +		.write_u64 = memory_stat_write,
>>   	},
>>   	{
>>   		.name = "force_empty",
>> @@ -2078,6 +2079,7 @@ struct cftype mem_cgroup_legacy_files[] = {
>>   	{
>>   		.name = "numa_stat",
>>   		.seq_show = memcg_numa_stat_show,
>> +		.write_u64 = memory_stat_write,
>>   	},
> 
> Any reason you are not using .write like others? Also is there any
> reason why a specific value is required. /proc/sys/vm/stat_refresh which does
> something similar ignores the value. Also memcg.peak write handler which
> resets the peak value ignores it. It is true that a specific value
> allows for future extensions but I guess it would be better to be
> consistent with others here.
> 
> One last thing to consider is whether this should follow
> /proc/sys/vm/stat_refresh path and have a single file to flush them all
> or have a per file flushing. I do not have a strong preference but
> considering both are doing the same thing it makes sense to go
> stat_refresh path.

+1

IMHO, a dedicated file like memory.stat_refresh is a much better approach ;)

It's cleaner, simpler to use, and much more intuitive for users.

> 
> In any case, thanks for considering the explicit flushing path which is
> IMHO much better than flushing tunning which would become really hard
> for admins to wrap their heads around. Especially when dealing with
> large fleets of machines to maintain.


