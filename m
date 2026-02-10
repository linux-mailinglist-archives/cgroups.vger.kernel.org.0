Return-Path: <cgroups+bounces-13824-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QB9YG3+iimleMgAAu9opvQ
	(envelope-from <cgroups+bounces-13824-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 04:14:07 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9C1116B3A
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 04:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B24F302BEB0
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 03:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CFA2E54B3;
	Tue, 10 Feb 2026 03:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tw7AmvSd"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0342D97B4
	for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 03:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770693189; cv=none; b=q3+dl6R5DUIA56fD1ifY/2JiRD9OwRj9vL84skmKL9uzsX/vklNJmH8Jn7q5810rBg47NoYDxReOpheolUbIauZujQnmuuyXo9T9ZiZHgNZW3n75jqj00sW8XYPaRTL/dmaXcAKOGLAlauEfDwGSR2aAvlQgiw4qR+Tj+Ha4dOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770693189; c=relaxed/simple;
	bh=xuf38ePAkpsRw7Wgr6uDwnRDXSWhFYegBEQdPOYFPcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQdLV/i7He3k69ciHdqGnhVh71nHqZ37+1MQ/ANTRtIqY7HcvJJqw3QWK+XFaCJUOjpFYeX9g8nb8YIA8ndQX+JogoAX+j4/oHFSfPZHtI0Krw9FcMsckHZrzdn9G5+P6p4W18wu9cNy/kwJFt7FzdlYKm5XXYr5EYtdDM9XQ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tw7AmvSd; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <37b79f65-7de3-483a-a675-75eab94d2776@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770693176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yubXWpReL8k8hbkA3y11vW86dPL2+7IUWmPBxrke92U=;
	b=Tw7AmvSdFVwfbDs8VZgjXs2x8ddtNiTMeickGrjOWzTBV6Yh/PrtCcJVPvlHTiEQT4idPm
	PsZ5jlhuAvA8/s0ojPGTXRbI69ELL4rTgSgyXh5Cy+vx4TIoBa4afdD4iaqP/FnrhFCIUY
	OjMtGYUzjzSSOBP26w82VxQkWD8+BRw=
Date: Tue, 10 Feb 2026 11:11:47 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 30/31] mm: memcontrol: eliminate the problem of dying
 memory cgroup for LRU folios
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
 yosry.ahmed@linux.dev, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, bhe@redhat.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Muchun Song <songmuchun@bytedance.com>, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1770279888.git.zhengqi.arch@bytedance.com>
 <9e332cc8436b6092dd6ef9c2d5f69072bb38eaf6.1770279888.git.zhengqi.arch@bytedance.com>
 <aYe1R2MMcXbPVYUW@linux.dev> <2a0e4ae2-457b-4d16-a7b9-7372fd665337@linux.dev>
 <aYoezZdqL_AofUgP@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aYoezZdqL_AofUgP@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13824-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: CA9C1116B3A
X-Rspamd-Action: no action



On 2/10/26 1:53 AM, Shakeel Butt wrote:
> On Mon, Feb 09, 2026 at 11:49:43AM +0800, Qi Zheng wrote:
>>
>>
>> On 2/8/26 6:25 AM, Shakeel Butt wrote:
>>> On Thu, Feb 05, 2026 at 05:01:49PM +0800, Qi Zheng wrote:
>>>> From: Muchun Song <songmuchun@bytedance.com>
>>>>
>>>> Now that everything is set up, switch folio->memcg_data pointers to
>>>> objcgs, update the accessors, and execute reparenting on cgroup death.
>>>>
>>>> Finally, folio->memcg_data of LRU folios and kmem folios will always
>>>> point to an object cgroup pointer. The folio->memcg_data of slab
>>>> folios will point to an vector of object cgroups.
>>>>
>>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>    /*
>>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>>> index e7d4e4ff411b6..0e0efaa511d3d 100644
>>>> --- a/mm/memcontrol.c
>>>> +++ b/mm/memcontrol.c
>>>> @@ -247,11 +247,25 @@ static inline void reparent_state_local(struct mem_cgroup *memcg, struct mem_cgr
>>>>    static inline void reparent_locks(struct mem_cgroup *memcg, struct mem_cgroup *parent)
>>>>    {
>>>> +	int nid, nest = 0;
>>>> +
>>>>    	spin_lock_irq(&objcg_lock);
>>>> +	for_each_node(nid) {
>>>> +		spin_lock_nested(&mem_cgroup_lruvec(memcg,
>>>> +				 NODE_DATA(nid))->lru_lock, nest++);
>>>> +		spin_lock_nested(&mem_cgroup_lruvec(parent,
>>>> +				 NODE_DATA(nid))->lru_lock, nest++);
>>>
>>> Is there a reason to acquire locks for all the node together? Why not do
>>> the for_each_node(nid) in memcg_reparent_objcgs() and then reparent the
>>> LRUs for each node one by one and taking and releasing lock
>>> individually. Though the lock for the offlining memcg might not be
>>
>> To do this, we first need to convert objcg from per-memcg to per-memcg
>> per-node. In this way, we can hold the lru lock and objcg lock for
>> each node to reparent the folio and the corresponding objcg together.
> 
> Oh we want reparenting of both objcg and folio atomic. Let's add a

Right.

> comment here with the explanation.

OK, will do this refactoring and send v5.

Thanks,
Qi

> 


