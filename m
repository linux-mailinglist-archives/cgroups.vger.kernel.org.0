Return-Path: <cgroups+bounces-13802-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJ84IXFZiWlk7QQAu9opvQ
	(envelope-from <cgroups+bounces-13802-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 09 Feb 2026 04:50:09 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B71A210B76F
	for <lists+cgroups@lfdr.de>; Mon, 09 Feb 2026 04:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43E8530053F6
	for <lists+cgroups@lfdr.de>; Mon,  9 Feb 2026 03:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2602E27FD4B;
	Mon,  9 Feb 2026 03:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AHdaa4Km"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6741E1A3B;
	Mon,  9 Feb 2026 03:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770609005; cv=none; b=jjxXed1MNG4BaxsdRgbJ42BcOCwD0O4Z+q09eeqq5d8fiqZW8mMTt/r1/p7AXtyrel3a5kfSwtsE4H0KPwS8EuhYU72h+lM7HIw1W+/+JL/eCwv9cR2+1k7BLN024LoeHeVisG4Wo3XDan1AM7CspUp6kdRluvrO3kNGjbo2EQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770609005; c=relaxed/simple;
	bh=3IuW/607sUaHRMDHolaQCTZoHITumhSd9cfSDGSAhYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tTRsZU3aZlXwcKRPbTwp8QTxGwKd2DLQ7FZP46VMqCZyCIX+yWIVLsb3tN2z3ieLnYGrgtN9RwEpb5cdaocxqX8lKnMYkFbwGwXmpxcLuHHP9TYHMg7BXkL083zqNzGpkfRj9+PhUjMdu0V8ER86q+6phVBpPhHoYSh7vi8IJc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AHdaa4Km; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2a0e4ae2-457b-4d16-a7b9-7372fd665337@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770609002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUEvjV24W4taMCJI79PwPAm96gzGFacZTZhUwE8Scdw=;
	b=AHdaa4KmJv0DVYbZg2OETQenH+i0unZQZKmxwtvZguQZPX0Z3ACaDjJDpeJbB65N60qqHY
	dRVVsXNsFHEXwd/IfzXfcPLnHCh69Sd0TQlJ1CpeaBHIqt1CMrNe8grlG0RbwoKvWbZwIT
	XurKQaHuQceIlzO7x+59wMkxJ0iYw+E=
Date: Mon, 9 Feb 2026 11:49:43 +0800
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
 <aYe1R2MMcXbPVYUW@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aYe1R2MMcXbPVYUW@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13802-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: B71A210B76F
X-Rspamd-Action: no action



On 2/8/26 6:25 AM, Shakeel Butt wrote:
> On Thu, Feb 05, 2026 at 05:01:49PM +0800, Qi Zheng wrote:
>> From: Muchun Song <songmuchun@bytedance.com>
>>
>> Now that everything is set up, switch folio->memcg_data pointers to
>> objcgs, update the accessors, and execute reparenting on cgroup death.
>>
>> Finally, folio->memcg_data of LRU folios and kmem folios will always
>> point to an object cgroup pointer. The folio->memcg_data of slab
>> folios will point to an vector of object cgroups.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>   
>>   /*
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index e7d4e4ff411b6..0e0efaa511d3d 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -247,11 +247,25 @@ static inline void reparent_state_local(struct mem_cgroup *memcg, struct mem_cgr
>>   
>>   static inline void reparent_locks(struct mem_cgroup *memcg, struct mem_cgroup *parent)
>>   {
>> +	int nid, nest = 0;
>> +
>>   	spin_lock_irq(&objcg_lock);
>> +	for_each_node(nid) {
>> +		spin_lock_nested(&mem_cgroup_lruvec(memcg,
>> +				 NODE_DATA(nid))->lru_lock, nest++);
>> +		spin_lock_nested(&mem_cgroup_lruvec(parent,
>> +				 NODE_DATA(nid))->lru_lock, nest++);
> 
> Is there a reason to acquire locks for all the node together? Why not do
> the for_each_node(nid) in memcg_reparent_objcgs() and then reparent the
> LRUs for each node one by one and taking and releasing lock
> individually. Though the lock for the offlining memcg might not be

To do this, we first need to convert objcg from per-memcg to per-memcg
per-node. In this way, we can hold the lru lock and objcg lock for
each node to reparent the folio and the corresponding objcg together.

Otherwise, the folio might have been moved to the parent lruvec, but
objcg hasn't been reparent. In that case, it might be holding the lock
of child lruvec to operate on the folio on the parent lruvec.

> contentious but the parent's lock might be if a lot of memory has been
> reparented.
> 
>> +	}
>>   }
>>   
>>   static inline void reparent_unlocks(struct mem_cgroup *memcg, struct mem_cgroup *parent)
>>   {
>> +	int nid;
>> +
>> +	for_each_node(nid) {
>> +		spin_unlock(&mem_cgroup_lruvec(parent, NODE_DATA(nid))->lru_lock);
>> +		spin_unlock(&mem_cgroup_lruvec(memcg, NODE_DATA(nid))->lru_lock);
>> +	}
>>   	spin_unlock_irq(&objcg_lock);
>>   }
>>   
>> @@ -260,12 +274,28 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
>>   	struct obj_cgroup *objcg;
>>   	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
>>   
>> +retry:
>> +	if (lru_gen_enabled())
>> +		max_lru_gen_memcg(parent);
>> +
>>   	reparent_locks(memcg, parent);
>> +	if (lru_gen_enabled()) {
>> +		if (!recheck_lru_gen_max_memcg(parent)) {
>> +			reparent_unlocks(memcg, parent);
>> +			cond_resched();
>> +			goto retry;
>> +		}
>> +		lru_gen_reparent_memcg(memcg, parent);
>> +	} else {
>> +		lru_reparent_memcg(memcg, parent);
>> +	}
>>   
>>   	objcg = __memcg_reparent_objcgs(memcg, parent);
> 
> The above does not need lru locks. With the per-node refactor, it will
> be out of lru lock.
> 
>>   
>>   	reparent_unlocks(memcg, parent);
>>   
>> +	reparent_state_local(memcg, parent);
>> +
>>   	percpu_ref_kill(&objcg->refcnt);
>>   }
>>   
>>   
> 
> [...]
> 
>>   static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
>>   			gfp_t gfp)
>>   {
>> -	int ret;
>> -
>> -	ret = try_charge(memcg, gfp, folio_nr_pages(folio));
>> -	if (ret)
>> -		goto out;
>> +	int ret = 0;
>> +	struct obj_cgroup *objcg;
>>   
>> -	css_get(&memcg->css);
>> -	commit_charge(folio, memcg);
>> +	objcg = get_obj_cgroup_from_memcg(memcg);
>> +	/* Do not account at the root objcg level. */
>> +	if (!obj_cgroup_is_root(objcg))
>> +		ret = try_charge(memcg, gfp, folio_nr_pages(folio));
> 
> Use try_charge_memcg() directly and then this will remove the last user
> of try_charge, so remove try_charge completely.
> 
>> +	if (ret) {
>> +		obj_cgroup_put(objcg);
>> +		return ret;
>> +	}
>> +	commit_charge(folio, objcg);
>>   	memcg1_commit_charge(folio, memcg);
>> -out:
>> +
>>   	return ret;
>>   }
>>   


