Return-Path: <cgroups+bounces-12058-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E07F0C6925A
	for <lists+cgroups@lfdr.de>; Tue, 18 Nov 2025 12:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B3D84F3305
	for <lists+cgroups@lfdr.de>; Tue, 18 Nov 2025 11:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B68355050;
	Tue, 18 Nov 2025 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dg6bJIB/"
X-Original-To: cgroups@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AE3355028
	for <cgroups@vger.kernel.org>; Tue, 18 Nov 2025 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763465537; cv=none; b=RDF2TC1LpS5jkWOEhlUnsRycqaJTXYd65A/G5lLSd9eyM2P7xIhE7j/NWf3wCNH9TKgCgZNttEwGzJe6fOzTZKHKhGVUZ0Y2cRxGBdvxoAJMQlCbhr9GRim19VA8Co/GVDvMjyU6cxLCFSJBX97JEGXrKCQycW6KsD1pErfZ6C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763465537; c=relaxed/simple;
	bh=KYEWSiZ1L9NTcaADalmQgzjpVielCVFi4RNSdgsGeqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BW8dMvjqHVfpSXM3vYSuNNlH2FnPrNiuGW0TuYLZtVGdPGub7OGAYCJq5pgSrmQ9Vs+0tdju0/uo2qER8CaTFwRV5/9nTP8D7VDjRbIj25STyrRI7Q9gJToJkLWobcXCPN9zCHEP14SfRpq774bFPw6FgYH781AJG9MAdY1BDa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dg6bJIB/; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <17ce88c0-a5d5-4315-8074-6c0a4a4e7d64@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763465532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IHki3f3cNtOnM09ovZSWhqC7IqaJsYo0WZIJZZw+RVU=;
	b=Dg6bJIB/vHPh4AVUVfpV8FwbbcIyFe4Xwg9nIM5+YFjnpsAyXDBARc+5rkdZn1e4fXNptU
	qdr+a8+t8ycFjPbfMfgPznhx+/KDzp4xgB//bQbPiiGNoxrowBo6Cz77wMcSTbdjyVcUdO
	l+Tw+0GrJLPlGpjHEHBe3/wqcra2+Kk=
Date: Tue, 18 Nov 2025 19:31:01 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 06/26] mm: memcontrol: return root object cgroup for
 root memory cgroup
To: Harry Yoo <harry.yoo@oracle.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <5e9743f291e7ca7b8f052775e993090ed66cfa80.1761658310.git.zhengqi.arch@bytedance.com>
 <aRroO9ypxvHsAjug@hyeyoo> <aRrttY5kdbbubmGs@hyeyoo>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aRrttY5kdbbubmGs@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/17/25 5:41 PM, Harry Yoo wrote:
> On Mon, Nov 17, 2025 at 06:17:47PM +0900, Harry Yoo wrote:
>> On Tue, Oct 28, 2025 at 09:58:19PM +0800, Qi Zheng wrote:
>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>> index 2afd7f99ca101..d484b632c790f 100644
>>> --- a/mm/memcontrol.c
>>> +++ b/mm/memcontrol.c
>>> @@ -2871,7 +2865,7 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
>>>   	int ret = 0;
>>>   
>>>   	objcg = current_obj_cgroup();
>>> -	if (objcg) {
>>> +	if (!obj_cgroup_is_root(objcg)) {
>>
>> Now that we support the page and slab allocators support allocating memory
>> in NMI contexts (on some archs), current_obj_cgroup() can return NULL
>> if (IS_ENABLED(CONFIG_MEMCG_NMI_UNSAFE) && in_nmi()) returns true
>> (then it leads to a NULL-pointer-deref bug).
> 
> This is a real issue, but
> 
>> But IIUC this is applied to kmem charging only (as they use this_cpu ops
>> for stats update), and we don't have to apply the same restriction to
>> charging LRU pages with objcg.
> 
> actually this should be fine for now since we use get_mem_cgroup_from_mm()
> and obj_cgroup_from_memcg() instead of current_obj_cgroup() when charging
> LRU pages.
> 
> But it is not immediately obvious that there are multiple ways to get
> an objcg, each with different restrictions depending on what you are
> going to charge :/

Perhaps some comments need to be added. :)

> 
>> Maybe Shakeel has more insight on this.
>>
>> Link: https://lore.kernel.org/all/20250519063142.111219-1-shakeel.butt@linux.dev
> 


