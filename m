Return-Path: <cgroups+bounces-17243-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jRb7GI3uO2pKfggAu9opvQ
	(envelope-from <cgroups+bounces-17243-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 16:49:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A95F66BF4D1
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 16:49:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=NMYyA2Vz;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17243-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17243-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3564311C6E4
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 14:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91243CC337;
	Wed, 24 Jun 2026 14:42:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CC53CC327
	for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 14:42:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782312126; cv=none; b=pymmCWXnDaz1/sSNsL/u2qa2m5ivHfDjSKczqzM704oNdiT+482csyPDeQZjy1u13S3BYr/Msa3vinQAhMj5FpuHvr0Y/KLxUFMZhig+Fz8Q7rrqpYWSlAbkhqegP6sjKFmK4phKw56yqYqJDwRzGKDoK6igXZnFTJgg0cOMQQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782312126; c=relaxed/simple;
	bh=L3rORlljL/OA6AwItWCm0gcxHNbR6neqiv0JhQvckcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9yTQmeWbc1oegVwJysVlEQzZzgJmtV14Tw3ssqeME+X2fz4K0UT1PtOlLzCQS15sP5ZHs+UID7Sf98HelpI+my3eKIyXHMhnRWLzQm34CPPLNkheVkiZeT2uXhKSJ4nhJ/SPvGZZYgB8wbp2W3q1VXSkGlfWR06+dzBronU2N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NMYyA2Vz; arc=none smtp.client-ip=91.218.175.181
Message-ID: <9abb91a4-1990-40d6-ae36-53ee2add765d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782312120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xecAOTCurKESIMIgUzS8m+lTP6YeTvYRkWiz24CsRnc=;
	b=NMYyA2Vz3iRqg0pVeiFzkpqoEMuDTwjDkyW8yNeKWS8yXpDEC4H0JaSx2Hf5d6SaHkHvdY
	Yg92UrHTuZtAfR6YRSjNL74hOIB4GFnWvcqNEwCtrXpROidU1lyP1xGHleMB3AN5t+kmqi
	YD5k3guCfi/VHklBAFzrOYyK+UtosEo=
Date: Wed, 24 Jun 2026 22:41:18 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] memcg: bail out proactive reclaim when memcg is dying
To: Usama Arif <usama.arif@linux.dev>
Cc: linux-mm@kvack.org, yingfu.zhou@shopee.com,
 Jiayuan Chen <jiayuan.chen@shopee.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Qi Zheng <qi.zheng@linux.dev>,
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260624135839.2596358-1-usama.arif@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260624135839.2596358-1-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:usama.arif@linux.dev,m:linux-mm@kvack.org,m:yingfu.zhou@shopee.com,m:jiayuan.chen@shopee.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:david@kernel.org,m:qi.zheng@linux.dev,m:ljs@kernel.org,m:kasong@tencent.com,m:baohua@kernel.org,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-17243-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,shopee.com:email,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A95F66BF4D1


On 6/24/26 9:58 PM, Usama Arif wrote:
> On Tue, 23 Jun 2026 14:27:56 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>
>> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>>
>> Proactive reclaim via memory.reclaim can run for a long time - swap I/O
>> or thrashing again dominating the latency - and delays cgroup removal in
>> the same way.
>>
>> Mitigate this by stopping the reclaim once memcg_is_dying().
>>
>> Reported-by: Zhou Yingfu <yingfu.zhou@shopee.com>
>> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
>> ---
>>   mm/vmscan.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 8190c4abec84..1162b7f76655 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -7922,6 +7922,9 @@ int user_proactive_reclaim(char *buf,
>>   		if (memcg) {
>>   			unsigned int reclaim_options;
>>   
>> +			if (memcg_is_dying(memcg))
>> +				break;
>> +
> This exits the reclaim loop with nr_reclaimed < nr_to_reclaim, but the
> function then returns 0 and memory_reclaim() reports a successful write.
> I think you want to return -EAGAIN here?


You are right that an error should be returned instead of 0.


But since memcg is being deleted, I'm reconsidering the appropriateerror 
code.

-EAGAIN, -ENOENT, -EINTR are possible candidates



