Return-Path: <cgroups+bounces-12930-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 331DACF6F6C
	for <lists+cgroups@lfdr.de>; Tue, 06 Jan 2026 08:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 375483016BB4
	for <lists+cgroups@lfdr.de>; Tue,  6 Jan 2026 07:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DBE22127E;
	Tue,  6 Jan 2026 07:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SLjjnidY"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA7E3093CE
	for <cgroups@vger.kernel.org>; Tue,  6 Jan 2026 07:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767683367; cv=none; b=qMiSOapYEiZZ5wmE2ceSrh0BUBMDE/joWwpZzg2s3PN/nHuaM7kJ5M8OLl2MQoJKnt27WL0F3OICS/kTnFcZPsOwmxGZpih2j9r/eQnu/tgMaIqj5Cv49wB7ztCfwjGfhKwTNdn2HlIsX/mkPsFZQJbuC8VUjKW4ZhJwt2JDOnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767683367; c=relaxed/simple;
	bh=qXCcwV4PEkmz3wiAykd4pKjLxb3C0sCWhNccJuOCFW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lvMupPcHNgMdbBMT0kt1uBRNkSlXfJWcv+rMRPNR3wIVNrmNB9uNkA7HQPQoAttD8Tw/jJjfrqXQSFJHAiT1wjJBlcoxnUJmLrWjM5ZUIe2sTipL5ZjO44Rgl/srkxehkIrxhg0iZydPc89sp5b9yao8vJT++Ox3YNJtwWhykEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SLjjnidY; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d016b76d-581a-4582-920d-21f64318090a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767683352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dyFrXFN6m53klbwE3XorrFPsS5+e/WpEsvDQtjFL8jc=;
	b=SLjjnidY1VMNj49kUhsnsQ6JX6Smd0ZoabO+uSUu7r8AtpZgXelawl2acD4o71fW+O5kcA
	KgsijQ58TY08ZOku1f4lUZz81Jr4Mu4jRTEREKIt+8R9CpsCisqKjxEZ0krWuqnKgyERxT
	sxn/UJASLhjEHcz873XFe70yKO8ao5s=
Date: Tue, 6 Jan 2026 15:08:57 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 27/28] mm: memcontrol: eliminate the problem of dying
 memory cgroup for LRU folios
To: Yosry Ahmed <yosry.ahmed@linux.dev>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 harry.yoo@oracle.com, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <c08f964513f9eb6a04f80f1a900e3494a99b7e0d.1765956026.git.zhengqi.arch@bytedance.com>
 <prqhodx7wc3cbrlh7tqf632b3gpcciwmn5n22qqv7c7rbtsoy3@lsnd7rtdhfmh>
 <hrxsjzcyj2uvxi5h5edtkoc3br4ljvz7m36nczoctyyoinrz56@27gcuui7wfpw>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <hrxsjzcyj2uvxi5h5edtkoc3br4ljvz7m36nczoctyyoinrz56@27gcuui7wfpw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 1/6/26 12:14 AM, Yosry Ahmed wrote:
> On Mon, Jan 05, 2026 at 11:41:46AM +0100, Michal Koutný wrote:
>> Hi Qi.
>>
>> On Wed, Dec 17, 2025 at 03:27:51PM +0800, Qi Zheng <qi.zheng@linux.dev> wrote:
>>
>>> @@ -5200,22 +5238,27 @@ int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry)
>>>   	unsigned int nr_pages = folio_nr_pages(folio);
>>>   	struct page_counter *counter;
>>>   	struct mem_cgroup *memcg;
>>> +	struct obj_cgroup *objcg;
>>>   
>>>   	if (do_memsw_account())
>>>   		return 0;
>>>   
>>> -	memcg = folio_memcg(folio);
>>> -
>>> -	VM_WARN_ON_ONCE_FOLIO(!memcg, folio);
>>> -	if (!memcg)
>>> +	objcg = folio_objcg(folio);
>>> +	VM_WARN_ON_ONCE_FOLIO(!objcg, folio);
>>> +	if (!objcg)
>>>   		return 0;
>>>   
>>> +	rcu_read_lock();
>>> +	memcg = obj_cgroup_memcg(objcg);
>>>   	if (!entry.val) {
>>>   		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
>>> +		rcu_read_unlock();
>>>   		return 0;
>>>   	}
>>>   
>>>   	memcg = mem_cgroup_id_get_online(memcg);
>>> +	/* memcg is pined by memcg ID. */
>>> +	rcu_read_unlock();
>>>   
>>>   	if (!mem_cgroup_is_root(memcg) &&
>>>   	    !page_counter_try_charge(&memcg->swap, nr_pages, &counter)) {
>>
>> Later there is:
>> 	swap_cgroup_record(folio, mem_cgroup_id(memcg), entry);
>>
>> As per the comment memcg remains pinned by the ID which is associated
>> with a swap slot, i.e. theoretically time unbound (shmem).
>> (This was actually brought up by Yosry in stats subthread [1])
>>
>> I think that should be tackled too to eliminate the problem completely.
> 
> FWIW, I am not sure if swap entries is the last cause of pinning memcgs,
> I am pretty sure there will be others that we haven't found yet. This is

Agree.

> why I think we shouldn't assume that the time between offlining and
> releasing a memcg is short or bounded when fixing the stats problem.

If I have not misunderstood your suggestion in the other thread, I plan
to do the following in v3:

1. define a memcgv1-only function:

void memcg1_reparent_state_local(struct mem_cgroup *memcg, struct 
mem_cgroup *parent)
{
	int i;

	synchronize_rcu();

	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
		int idx = memcg1_stats[i];
		unsigned long value = memcg_page_state_local(memcg, idx);

		mod_memcg_page_state_local(parent, idx, value);
	}
}

2. call it after reparent_unlocks():

memcg_reparent_objcgs
--> objcg = __memcg_reparent_objcgs(memcg, parent);
     reparent_unlocks(memcg, parent);
     reparent_state_local(memcg, parent);
     --> memcg1_reparent_state_local()

> 
>>
>> As I look at the code, these memcg IDs (private [2]) could be converted
>> to objcg IDs so that reparenting applies also to folios that are
>> currently swapped out. (Or convert to swap_cgroup_ctrl from the vector
>> of IDs to a vector of objcg pointers, depending on space.)
> 
> I think we can do objcg IDs, but be careful to keep the same behavior as
> today and avoid overexhausting the 16 bit ID space. So we need to also
> drop the ref to the objcg ID when the memcg is offlined and the objcg is
> reparented, such that the objcg ID is deleted unless there are swapped
> out entries.
> 
> I think this can be done on top of this series, not necessarily as part
> of it.

Agree, I prefer to address this issue in a separate patchset.

Thanks,
Qi

> 
>>
>> Thanks,
>> Michal
>>
>> [1] https://lore.kernel.org/r/ebdhvcwygvnfejai5azhg3sjudsjorwmlcvmzadpkhexoeq3tb@5gj5y2exdhpn
>> [2] https://lore.kernel.org/r/20251225232116.294540-1-shakeel.butt@linux.dev
> 
> 


