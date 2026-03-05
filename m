Return-Path: <cgroups+bounces-14634-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDA/DfZJqWm53wAAu9opvQ
	(envelope-from <cgroups+bounces-14634-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 10:16:38 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 484B520E259
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 10:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BDF130FED74
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2026 09:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87B0375F8E;
	Thu,  5 Mar 2026 09:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L7x4mezl"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE43364EA5
	for <cgroups@vger.kernel.org>; Thu,  5 Mar 2026 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772701839; cv=none; b=haSK9zKP6tBf6xDxWLem8Ex7bzsJuY8qrQmxyxfXTCgzW4uEiq2pQSVw3jCCxYpkIgg9Z6IG5r75OuhRy15EvL+OOnSfyERU/zzgDSYjVlifZnPigL7nax+I36S/woqhytaeDUvInw5dnapc5Q1L9UoeDhMmLTAiP9GtPmBzj4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772701839; c=relaxed/simple;
	bh=6ddPn5CAeywNeKr549PcEFXW+NwD0kk2WrcM8RcO4Ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eW1k2X1n51bC8f/63lqE/C02T9rMjqhvcx6MflDro8gXWxTUrJoo/YQ12oE54ip3Rhr3vSbFKc+cR3FAasWnKjFteDwZYGoutFFjCTBjgN4ZTPJ3lIW8mxeo3LAsiNorQG+D37afjloXPJJkAGb2bEshFQqZAaoC0U5+PFFephQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L7x4mezl; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d65039f7-eaa9-4fa5-b03d-e184f0eb59fc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772701834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tr1o9KhyPyLCXwJBlDrE8nwwf9NNG4p8828XvNLTvd8=;
	b=L7x4mezlG6AujZehqOM4oJ1mkz12yinb96zksZNN/IssZlPMeo22txA9u/1JGvJm0IQIZX
	knTzFQOroszSlf2YtuFByiAoYTLA3ZgsDnHx7Xob8QK6lAjuJc0iRLD0Agun4RoT41YxJa
	M/cyIE844GMBmEI/anCkSsaJEZq87i8=
Date: Thu, 5 Mar 2026 17:10:12 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 update 30/32] mm: memcontrol: convert objcg to be
 per-memcg per-node type
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
 yosry.ahmed@linux.dev, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, bhe@redhat.com, usamaarif642@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <0f915487ffc653cf6ea19335c21c01aa06004641.1772005110.git.zhengqi.arch@bytedance.com>
 <20260225094456.74145-1-qi.zheng@linux.dev> <aZ-uNV1biPYLhJ48@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aZ-uNV1biPYLhJ48@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 484B520E259
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14634-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bytedance.com:email,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Action: no action

Hi Shakeel,

On 2/26/26 10:27 AM, Shakeel Butt wrote:
> On Wed, Feb 25, 2026 at 05:44:56PM +0800, Qi Zheng wrote:
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> Convert objcg to be per-memcg per-node type, so that when reparent LRU
>> folios later, we can hold the lru lock at the node level, thus avoiding
>> holding too many lru locks at once.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>> changlog:
>>   - fix a missing root_obj_cgroup conversion and completely delete
>>     root_obj_cgroup.
>>
>>   include/linux/memcontrol.h | 23 +++++------
>>   include/linux/sched.h      |  2 +-
>>   mm/memcontrol.c            | 79 +++++++++++++++++++++++---------------
>>   3 files changed, 62 insertions(+), 42 deletions(-)
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index 45d911dd903e7..6e11552a90618 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -116,6 +116,16 @@ struct mem_cgroup_per_node {
>>   	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
>>   	struct mem_cgroup_reclaim_iter	iter;
>>   
>> +	/*
>> +	 * objcg is wiped out as a part of the objcg repaprenting process.
>> +	 * orig_objcg preserves a pointer (and a reference) to the original
>> +	 * objcg until the end of live of memcg.
>> +	 */
>> +	struct obj_cgroup __rcu	*objcg;
>> +	struct obj_cgroup	*orig_objcg;
> 
> The layout of struct mem_cgroup_per_node is very performance sensitive. Please
> couple of performance benchmarks after rearranging the fields particularly the

I ran a simple test using will-it-scale page_fault1, and the results are
as follows:

tasks    | baseline     | with-patch   | diff       | %
-------------------------------------------------------------
1        | 216394       | 217537       | +1143      | +0.53%
2        | 419895       | 421510       | +1615      | +0.38%
3        | 626275       | 629533       | +3258      | +0.52%
4        | 833146       | 830481       | -2665      | -0.32%
5        | 1037597      | 1034334      | -3263      | -0.31%
6        | 1229398      | 1231656      | +2258      | +0.18%
7        | 1425040      | 1424432      | -608       | -0.04%
8        | 1603738      | 1626028      | +22290     | +1.39%
9        | 1797881      | 1803901      | +6020      | +0.33%
10       | 1976264      | 1966342      | -9922      | -0.50%
11       | 2150073      | 2159328      | +9255      | +0.43%
12       | 2304435      | 2321128      | +16693     | +0.72%
13       | 2524668      | 2538582      | +13914     | +0.55%
14       | 2763854      | 2743098      | -20756     | -0.75%
15       | 2938939      | 2961671      | +22732     | +0.77%
16       | 3152497      | 3181420      | +28923     | +0.92%
17       | 3333936      | 3370667      | +36731     | +1.10%
18       | 3531225      | 3552907      | +21682     | +0.61%
19       | 3732347      | 3769889      | +37542     | +1.01%
20       | 3917502      | 3951226      | +33724     | +0.86%
21       | 4118040      | 4134952      | +16912     | +0.41%
22       | 4268932      | 4312343      | +43411     | +1.02%
23       | 4438411      | 4484408      | +45997     | +1.04%
24       | 4618400      | 4683531      | +65131     | +1.41%

No obvious degradation observed, so I'll keep this arrangement in v6.

> above two pointers together at the start of the struct.
> 
> Otherwise:
> 
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Thanks! I'll add this tag in v6.



