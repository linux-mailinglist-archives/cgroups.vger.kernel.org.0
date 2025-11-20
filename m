Return-Path: <cgroups+bounces-12133-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C923BC746C1
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 15:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F0B54EABC4
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 13:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB9B343D90;
	Thu, 20 Nov 2025 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KZQyoVQE"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364D92DCF61
	for <cgroups@vger.kernel.org>; Thu, 20 Nov 2025 13:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763646333; cv=none; b=CVuo8FEvzECWqB+WEAWvuKFk14zZnxLid810L3HqRF4i2Wap9zk5veJKW70AGMHD5ivo4Tp2q5nDyExTcFbjp73x3YguvAZN1r8pSWwRI0xHDc9aLuApP5/hlinygD6eyihy0DGBi2nxGefsNqiLxK6NJHxv1TuzMmykj3PZosQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763646333; c=relaxed/simple;
	bh=YMDJg6Qpkx1+NdWyiE4Ba9nP2PX29bxOtpZrdoUsdYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RfRx4lXLW+cKLE4Yi8p1AQco8p6VORzmvZLqQnEA+uB5eA3uyQSbghRSGqtClWywdmLQAWf5EfE+KA3fJJCF9StmPsocRfiLJJjtfdzWWmmdU5LaYhFZ+c8jZDV42MXdbJyeR48ZWfPOBuQ8vZeqmw9RahIbC7ebhndMYtdyTGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KZQyoVQE; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cf600d82-82f5-414c-b880-71133379d5d4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763646329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0F1vo22ZFTmKf8sXE42d1ovwkd4h2/GmeH0WirLVGeg=;
	b=KZQyoVQEqYe/9XPzLslzGEobTzkXAQWLBhUuaENdHn2JcZkTs3FEHl89i4TBmDv3Q4l6WK
	dJciw1xTfr0yhYuoDDpR3VaSo5HBt+gc9UF2D2kvkmuBMPvmRBDtIW/ul/1iL+G1qsqO34
	F/b9KKIJiTm3UsMXcB4XXtOz6iniLEU=
Date: Thu, 20 Nov 2025 21:45:19 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 25/26] mm: memcontrol: eliminate the problem of dying
 memory cgroup for LRU folios
To: Chen Ridong <chenridong@huaweicloud.com>, hannes@cmpxchg.org,
 hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, david@redhat.com,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <44fd54721dfa74941e65a82e03c23d9c0bff9feb.1761658311.git.zhengqi.arch@bytedance.com>
 <a7e55445-20ee-4133-8455-b6c5f7a45ff3@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <a7e55445-20ee-4133-8455-b6c5f7a45ff3@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 11/20/25 7:56 PM, Chen Ridong wrote:
> 
> 
> On 2025/10/28 21:58, Qi Zheng wrote:
>>   static void reparent_locks(struct mem_cgroup *src, struct mem_cgroup *dst)
>>   {
>> +	int nid, nest = 0;
>> +
>>   	spin_lock_irq(&objcg_lock);
>> +	for_each_node(nid) {
>> +		spin_lock_nested(&mem_cgroup_lruvec(src,
>> +				 NODE_DATA(nid))->lru_lock, nest++);
>> +		spin_lock_nested(&mem_cgroup_lruvec(dst,
>> +				 NODE_DATA(nid))->lru_lock, nest++);
>> +	}
>>   }
>>   
>>   static void reparent_unlocks(struct mem_cgroup *src, struct mem_cgroup *dst)
>>   {
>> +	int nid;
>> +
>> +	for_each_node(nid) {
>> +		spin_unlock(&mem_cgroup_lruvec(dst, NODE_DATA(nid))->lru_lock);
>> +		spin_unlock(&mem_cgroup_lruvec(src, NODE_DATA(nid))->lru_lock);
>> +	}
>>   	spin_unlock_irq(&objcg_lock);
>>   }
>>   
> 
> The lock order follows S0→D0→S1→D1→…, and the correct unlock sequence should be Dn→Sn→…→D1→S0
> 
> However, the current unlock implementation uses D0→S0→D1→S1→…
> 
> I’m not certain whether this unlock order will cause any issues—could this lead to potential
> problems like deadlocks or lock state inconsistencies?

As long as the order in which the locks are held is consistent, there 
should be no deadlock problem?

> 


