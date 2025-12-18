Return-Path: <cgroups+bounces-12477-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0AECCA918
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 08:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDDA6301357D
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 06:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B27329C35A;
	Thu, 18 Dec 2025 06:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TWv4oTjP"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFAD2153E7
	for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 06:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766041044; cv=none; b=jXmw7EBvTmPeKm9ZpLHyu5WdNolYOeGMW0lKbc4o706tFt5Mu36SeefOQOe+0WD/fuD30/7FT6ViRvlFTUK1ILm0Rrn7Zl2nbhOSSs546OeIwFfztAdHGkneIAIIaB2J7r+REfYyjiZbXUsEkk/XWUy+23Zxx74kBaqmQVS+VFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766041044; c=relaxed/simple;
	bh=VDgfGzmAp0AKrKydBEMulyW/Su4/QsVo146vUQKAiaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DbVSPiCXf8/RjW0kZFBi7EShC3RBHuVv+HfrhGulGI+RGWBsO3+uPQp+il9gEe+9+xsAeZxprJE5/Q5NqLaOPe0KkJcQqGi/klqvllvzUPWbIXbMZ9IIB0fp9zeBeEj2OB0fT+yqruOlHOZCFRwI2tKtkPj0L+8BXCCPcsSZMZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TWv4oTjP; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <70b14272-10b8-4dbb-9f49-40ea9f9103bd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766041033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O7LHGOObDxQ6+ffkFn25DV4aolNfjtd27M0DUDjwyfQ=;
	b=TWv4oTjPJDFW3GWSWAE2CTFAB2w7bMvVrBZAKAQd0wNkVnhQNYV0ELz5ER2fk9sg1Dh7tm
	qubtcgDe6rvX5iIfmFoMBdKWfK2+Gcfp1DKI4G2yrr3RvSZneSn95MulWswjF3LGRuuzEi
	+LVxv2CRm5qdggtALoWWN/ToKjTP/Zo=
Date: Thu, 18 Dec 2025 14:57:05 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 19/28] mm: workingset: prevent lruvec release in
 workingset_refault()
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, david@kernel.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <1b6ad26b5199b8134de37506b669ad4e3c0b6356.1765956026.git.zhengqi.arch@bytedance.com>
 <aUMvIDRJegSVSicB@cmpxchg.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aUMvIDRJegSVSicB@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/18/25 6:30 AM, Johannes Weiner wrote:
> On Wed, Dec 17, 2025 at 03:27:43PM +0800, Qi Zheng wrote:
>> From: Muchun Song <songmuchun@bytedance.com>
>>
>> In the near future, a folio will no longer pin its corresponding
>> memory cgroup. So an lruvec returned by folio_lruvec() could be
>> released without the rcu read lock or a reference to its memory
>> cgroup.
>>
>> In the current patch, the rcu read lock is employed to safeguard
>> against the release of the lruvec in workingset_refault().
>>
>> This serves as a preparatory measure for the reparenting of the
>> LRU pages.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
>> ---
>>   mm/workingset.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/workingset.c b/mm/workingset.c
>> index 445fc634196d8..427ca1a5625e8 100644
>> --- a/mm/workingset.c
>> +++ b/mm/workingset.c
>> @@ -560,11 +560,12 @@ void workingset_refault(struct folio *folio, void *shadow)
>>   	 * locked to guarantee folio_memcg() stability throughout.
>>   	 */
>>   	nr = folio_nr_pages(folio);
>> +	rcu_read_lock();
>>   	lruvec = folio_lruvec(folio);
>>   	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
>>   
>>   	if (!workingset_test_recent(shadow, file, &workingset, true))
> 
> This might sleep. You have to get a reference here and unlock RCU.

Indeed, this may sleep in css_rstat_flush().

Will do the following:

get_mem_cgroup_from_folio(folio);
lruvec = mem_cgroup_lruvec(memcg, folio_pgdat(folio));

/* xxx */

mem_cgroup_put(memcg);




