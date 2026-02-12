Return-Path: <cgroups+bounces-13915-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMGuD9hEjmmPBQEAu9opvQ
	(envelope-from <cgroups+bounces-13915-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 22:23:36 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE59C1313B3
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 22:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1EFC306CDCE
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 21:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5AE33EB19;
	Thu, 12 Feb 2026 21:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ic0Q94xB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C434298CC9
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 21:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770931403; cv=none; b=M7l27j5uC01eIqq9othW1SfZmFGusepIirAaUQ1FxKgRGkI/ubz2gT9C/r09/wquessZAB6LvYPa2R11FCdbMYx0kw48zHAspBWE6b+kx/M8hOx5U1KJRh1PCA1RVPFT65FoY4ojJYxvjWe9e0uJ8j8MYGAlFuWFPjb4q6ItOPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770931403; c=relaxed/simple;
	bh=M+bfuEN1su7NmxM1Tw6CX2qOcOTwn0Rv3r5GE2+cibk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lzf87oQbjha9XZoEr/MuCkkEt17neaHGTog0E3dh6kkvbsjkIzilPRm1nY/LtzqdxOcxCr++kTGqp8ZPTbFa764HVVf+I6ONnDuLoULVypnuiQEil6+B8C0D/dPCthhzTp0KS6iseDhKVgka4EEvvn/A+6GvJOuLkXsl2FVaDsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ic0Q94xB; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2baaceb4613so561055eec.0
        for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 13:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770931400; x=1771536200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k+9lU8ttHS0Y3rUeACRp1GPu77nMoViWOTfYZGCx7ag=;
        b=Ic0Q94xBHrwNgil4kVe/9wSEKfwAoPGIVvkhys7iGxMd1TM27KTxQsGGGO8mRGmWXG
         j9Whl0Qk4BdkXwltD1b/b8RYNgUMy7so5cB2ctuzwcicFRSHxFoOeRKEeSeQdcTEs9tx
         qfylPEbiUS/v+vO0KsE+XepAv4mXWre8IA8SkknJ5ZgLeGwNcHMlGVaXxwaG9WI8lgEa
         kx1AcvvxkTfLqQTs1P5xibA4woxPCrOygbhb2od/1cmiwFrLPogtaIUTv02P982JjZwc
         gu0UDw8obQuBsZquw8VXYTe2kqLHN4ihxksu6a52WOG0yyJEK2xjy4Z8b2pM1cSSXX8e
         ncgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770931400; x=1771536200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+9lU8ttHS0Y3rUeACRp1GPu77nMoViWOTfYZGCx7ag=;
        b=DoSFGZL7bMEzPHpMmp0oP3uP5WLcT4cCkJtP3hZtYfIQdBqGIZ5kM9bzNUvAp5kwGV
         34atijJ1TpITuF9FSHsWegL0YYExQOG1iWI7Z1pK1aZM3zc07IP8WuexBuS0SZsI2qUa
         GEu2zw3998h4rU84mpdf98fDKwYx1Dk5nr83oLD8cPvZezPbxaLqpZ06EF2B0UE8SeYC
         UBiYOUcfIIaNv0iizRIP+mSSGZ3Q24GAocGT5fcpB41geY5HvKjRmoNbUdDrzrclcs1p
         r5RtszLpykerx6OBBNpZLn+fUjtNQCq2dcuirDWFGQrQ7xNqH3ap2t8JFgDJCt3B33zI
         A82Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZxo47/bq/fmq6vQXVkAakWlT9MQAqCAeBXHOHBg8kxAYy/iITmy/uFMI/cNy3foeSePBdtFyA@vger.kernel.org
X-Gm-Message-State: AOJu0YwWxcL6Z/RZ5P7Ng5k7Ve3wgbDn3blsIcsJI60r9gX/EJXPrePy
	VJVKc9sR+TfNIJmPosyCwzT5Ht6KLU4eo2LihJ5J+UJw5hmtBrCwDQ4G
X-Gm-Gg: AZuq6aJFV6S02klsf21NIPg8lT3DbpdwN/GdN6YvmMJOlb1VR/Cy5IAIlGkNThLbcdX
	i2qZoG8drd0uxvRwc1IQM/4/qknfw9YcaskK0t8r9H/r5z3GD7QbFBNHh15rMCf8GDp05dND8O6
	xw2Bd3wCQNxSHFG/Hvo3KxVirJ5EYjkNSq07+6RC4Zq7zE3ID5iHPo435mLM2vF21YVVHm4Y3ex
	Rr9fL2CpU3r1kfDIlkt+uQzRjCB4u/n1JOxLZXjkOE8njjHXXZYCuA9ZGZrJdRSNU7QkZ3Uqigp
	pb/TIK/aPldlPVgdD/s5CR7nCUrG1rwv0Y0oOvUzKP5EDOOeLR7SkQtSx35oeby4uTxOJbqHvmJ
	slJaAAWz5xscrmtXc8Sg8PwtIIYmfp3GMRjLVD8xoSf9uCYLMy3qeXU/AKyD9RWqBIt2aT8547x
	V4SkZCaVc4elbOazP+Z/2wAz0ZmSf3bSbLFpU3GmvHi9U=
X-Received: by 2002:a05:7301:4449:b0:2a4:701a:b9ba with SMTP id 5a478bee46e88-2baba1b8829mr112653eec.14.1770931400275;
        Thu, 12 Feb 2026 13:23:20 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dba2aadsm4282884eec.1.2026.02.12.13.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 13:23:19 -0800 (PST)
Message-ID: <905f5ee5-53f7-428f-9560-13d9aa1d1b19@gmail.com>
Date: Thu, 12 Feb 2026 13:23:17 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/mempolicy: track page allocations per mempolicy
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org, apopple@nvidia.com, akpm@linux-foundation.org,
 axelrasmussen@google.com, byungchul@sk.com, cgroups@vger.kernel.org,
 david@kernel.org, eperezma@redhat.com, gourry@gourry.net,
 jasowang@redhat.com, hannes@cmpxchg.org, joshua.hahnjy@gmail.com,
 Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com, matthew.brost@intel.com, mst@redhat.com,
 mhocko@suse.com, rppt@kernel.org, muchun.song@linux.dev,
 zhengqi.arch@bytedance.com, rakie.kim@sk.com, roman.gushchin@linux.dev,
 surenb@google.com, virtualization@lists.linux.dev, vbabka@suse.cz,
 weixugc@google.com, xuanzhuo@linux.alibaba.com,
 ying.huang@linux.alibaba.com, yuanchu@google.com, ziy@nvidia.com,
 kernel-team@meta.com
References: <20260212045109.255391-1-inwardvessel@gmail.com>
 <20260212045109.255391-2-inwardvessel@gmail.com> <aY3r75eewxbArKVu@linux.dev>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <aY3r75eewxbArKVu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13915-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,nvidia.com,linux-foundation.org,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,suse.com,linux.dev,bytedance.com,lists.linux.dev,suse.cz,linux.alibaba.com,meta.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inwardvessel@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cmpxchg.org:email]
X-Rspamd-Queue-Id: AE59C1313B3
X-Rspamd-Action: no action

On 2/12/26 7:07 AM, Shakeel Butt wrote:
> On Wed, Feb 11, 2026 at 08:51:08PM -0800, JP Kobryn wrote:
>> It would be useful to see a breakdown of allocations to understand which
>> NUMA policies are driving them. For example, when investigating memory
>> pressure, having policy-specific counts could show that allocations were
>> bound to the affected node (via MPOL_BIND).
>>
>> Add per-policy page allocation counters as new node stat items. These
>> counters can provide correlation between a mempolicy and pressure on a
>> given node.
>>
>> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
>> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> [...]
> 
>>   int mempolicy_set_node_perf(unsigned int node, struct access_coordinate *coords)
>>   {
>>   	struct weighted_interleave_state *new_wi_state, *old_wi_state = NULL;
>> @@ -2446,8 +2461,14 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
>>   
>>   	nodemask = policy_nodemask(gfp, pol, ilx, &nid);
>>   
>> -	if (pol->mode == MPOL_PREFERRED_MANY)
>> -		return alloc_pages_preferred_many(gfp, order, nid, nodemask);
>> +	if (pol->mode == MPOL_PREFERRED_MANY) {
>> +		page = alloc_pages_preferred_many(gfp, order, nid, nodemask);
>> +		if (page)
>> +			__mod_node_page_state(page_pgdat(page),
>> +					mpol_node_stat(MPOL_PREFERRED_MANY), 1 << order);
> 
> Here and two places below, please use mod_node_page_state() instead of
> __mod_node_page_state() as __foo() requires preempt disable or if the
> given stat can be updated in IRQ, then IRQ disable. This code path does
> not do either of that.

Thanks, I also see syzbot flagged this as well. I can make this change
in v2.

