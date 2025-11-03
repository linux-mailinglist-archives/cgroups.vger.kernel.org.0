Return-Path: <cgroups+bounces-11485-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BB5C29F7C
	for <lists+cgroups@lfdr.de>; Mon, 03 Nov 2025 04:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03FCA4EA1EC
	for <lists+cgroups@lfdr.de>; Mon,  3 Nov 2025 03:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D682C1C6FE8;
	Mon,  3 Nov 2025 03:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f1GN3GoF"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2641C14A4F9
	for <cgroups@vger.kernel.org>; Mon,  3 Nov 2025 03:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762140835; cv=none; b=rjQFaCff8cbuLqLQlWRUNt1NNeE4usQgE7PWmGro5DoDALCYGfLgRKwMaP3+7kwkxrZ4UyLvfnxyyG6H/dOgwhNOmZFrHQbgKf/f/+Vykpb2T0TKPpgg2Uk/cz0c4RCjVxfTc/EmDj9SPQvtEVRhbWhD2gaSm+sil9mpZJmVJVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762140835; c=relaxed/simple;
	bh=Iv5n6JgKV74s1bA+dqSTVjN31fde/U68dLHF88pXAv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jNTJMj50/tG1BiRX4RR2+7ZjaqZv+fFGCgGPUMGm6Q551Bif/QTPe/r6ElCGcGBmw0mybsOAH7jb8aBO6facURRHj9czqR9RvE9hx9zA3T9YEPqMm+zHlfnLv5LGqS/fr/8kX5CFo6LVII7LauJUbXWi5cVpXBtGVhityxZCylY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f1GN3GoF; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6893294b-41bf-44a1-baae-1bb3a6034777@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762140818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=07ypOvsfQH+I/btG1VSjUxVXQmcWpU4TWlpvVvH8A8s=;
	b=f1GN3GoFEkv8j01/V6a0IpuPCpZ44/TmH9s5oyNcHNEU0McpLPw7qgMdJdCN2H1e6dJZAl
	WEw34ysi508mSirjzIDBngFc0Mpsqi+Q6pIeipZU5yExbK4ZPWBnrMusXfYREDpBas2RRB
	p1lzvBuF7cy/FDYh0kyo/Ch+pELHpOY=
Date: Mon, 3 Nov 2025 11:33:08 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 00/26] Eliminate Dying Memory Cgroup
To: Michal Hocko <mhocko@suse.com>
Cc: hannes@cmpxchg.org, hughd@google.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, david@redhat.com,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <aQHIDWDx3puT5XZd@tiehlicka> <8edf2f49-54f6-4604-8d01-42751234bee9@linux.dev>
 <aQSRBjdhdMR8iD6n@tiehlicka>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aQSRBjdhdMR8iD6n@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Michal,

On 10/31/25 6:35 PM, Michal Hocko wrote:
> On Wed 29-10-25 16:05:16, Qi Zheng wrote:
>> Hi Michal,
>>
>> On 10/29/25 3:53 PM, Michal Hocko wrote:
>>> On Tue 28-10-25 21:58:13, Qi Zheng wrote:
>>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>
>>>> Hi all,
>>>>
>>>> This series aims to eliminate the problem of dying memory cgroup. It completes
>>>> the adaptation to the MGLRU scenarios based on the Muchun Song's patchset[1].
>>>
>>> I high level summary and main design decisions should be describe in the
>>> cover letter.
>>
>> Got it. Will add it in the next version.
>>
>> I've pasted the contents of Muchun Song's cover letter below:
>>
>> ```
>> ## Introduction
>>
>> This patchset is intended to transfer the LRU pages to the object cgroup
>> without holding a reference to the original memory cgroup in order to
>> address the issue of the dying memory cgroup. A consensus has already been
>> reached regarding this approach recently [1].
> 
> Could you add those referenced links as well please?

Oh, I missed that.

[1]. https://lore.kernel.org/linux-mm/Z6OkXXYDorPrBvEQ@hm-sls2/

> 
>> ## Background
>>
>> The issue of a dying memory cgroup refers to a situation where a memory
>> cgroup is no longer being used by users, but memory (the metadata
>> associated with memory cgroups) remains allocated to it. This situation
>> may potentially result in memory leaks or inefficiencies in memory
>> reclamation and has persisted as an issue for several years. Any memory
>> allocation that endures longer than the lifespan (from the users'
>> perspective) of a memory cgroup can lead to the issue of dying memory
>> cgroup. We have exerted greater efforts to tackle this problem by
>> introducing the infrastructure of object cgroup [2].

[2]. https://lwn.net/Articles/895431/

>>
>> Presently, numerous types of objects (slab objects, non-slab kernel
>> allocations, per-CPU objects) are charged to the object cgroup without
>> holding a reference to the original memory cgroup. The final allocations
>> for LRU pages (anonymous pages and file pages) are charged at allocation
>> time and continues to hold a reference to the original memory cgroup
>> until reclaimed.
>>
>> File pages are more complex than anonymous pages as they can be shared
>> among different memory cgroups and may persist beyond the lifespan of
>> the memory cgroup. The long-term pinning of file pages to memory cgroups
>> is a widespread issue that causes recurring problems in practical
>> scenarios [3]. File pages remain unreclaimed for extended periods.

[3]. https://github.com/systemd/systemd/pull/36827

>> Additionally, they are accessed by successive instances (second, third,
>> fourth, etc.) of the same job, which is restarted into a new cgroup each
>> time. As a result, unreclaimable dying memory cgroups accumulate,
>> leading to memory wastage and significantly reducing the efficiency
>> of page reclamation.
> 
> Very useful introduction to the problem. Thanks!
> 
>> ## Fundamentals
>>
>> A folio will no longer pin its corresponding memory cgroup. It is necessary
>> to ensure that the memory cgroup or the lruvec associated with the memory
>> cgroup is not released when a user obtains a pointer to the memory cgroup
>> or lruvec returned by folio_memcg() or folio_lruvec(). Users are required
>> to hold the RCU read lock or acquire a reference to the memory cgroup
>> associated with the folio to prevent its release if they are not concerned
>> about the binding stability between the folio and its corresponding memory
>> cgroup. However, some users of folio_lruvec() (i.e., the lruvec lock)
>> desire a stable binding between the folio and its corresponding memory
>> cgroup. An approach is needed to ensure the stability of the binding while
>> the lruvec lock is held, and to detect the situation of holding the
>> incorrect lruvec lock when there is a race condition during memory cgroup
>> reparenting. The following four steps are taken to achieve these goals.
>>
>> 1. The first step  to be taken is to identify all users of both functions
>>     (folio_memcg() and folio_lruvec()) who are not concerned about binding
>>     stability and implement appropriate measures (such as holding a RCU read
>>     lock or temporarily obtaining a reference to the memory cgroup for a
>>     brief period) to prevent the release of the memory cgroup.
>>
>> 2. Secondly, the following refactoring of folio_lruvec_lock() demonstrates
>>     how to ensure the binding stability from the user's perspective of
>>     folio_lruvec().
>>
>>     struct lruvec *folio_lruvec_lock(struct folio *folio)
>>     {
>>             struct lruvec *lruvec;
>>
>>             rcu_read_lock();
>>     retry:
>>             lruvec = folio_lruvec(folio);
>>             spin_lock(&lruvec->lru_lock);
>>             if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
>>                     spin_unlock(&lruvec->lru_lock);
>>                     goto retry;
>>             }
>>
>>             return lruvec;
>>     }
>>
>>     From the perspective of memory cgroup removal, the entire reparenting
>>     process (altering the binding relationship between folio and its memory
>>     cgroup and moving the LRU lists to its parental memory cgroup) should be
>>     carried out under both the lruvec lock of the memory cgroup being removed
>>     and the lruvec lock of its parent.
>>
>> 3. Thirdly, another lock that requires the same approach is the split-queue
>>     lock of THP.
>>
>> 4. Finally, transfer the LRU pages to the object cgroup without holding a
>>     reference to the original memory cgroup.
>> ```
>>
>> And the details of the adaptation are below:
>>
>> ```
>> Similar to traditional LRU folios, in order to solve the dying memcg
>> problem, we also need to reparenting MGLRU folios to the parent memcg when
>> memcg offline.
>>
>> However, there are the following challenges:
>>
>> 1. Each lruvec has between MIN_NR_GENS and MAX_NR_GENS generations, the
>>     number of generations of the parent and child memcg may be different,
>>     so we cannot simply transfer MGLRU folios in the child memcg to the
>>     parent memcg as we did for traditional LRU folios.
>> 2. The generation information is stored in folio->flags, but we cannot
>>     traverse these folios while holding the lru lock, otherwise it may
>>     cause softlockup.
>> 3. In walk_update_folio(), the gen of folio and corresponding lru size
>>     may be updated, but the folio is not immediately moved to the
>>     corresponding lru list. Therefore, there may be folios of different
>>     generations on an LRU list.
>> 4. In lru_gen_del_folio(), the generation to which the folio belongs is
>>     found based on the generation information in folio->flags, and the
>>     corresponding LRU size will be updated. Therefore, we need to update
>>     the lru size correctly during reparenting, otherwise the lru size may
>>     be updated incorrectly in lru_gen_del_folio().
>>
>> Finally, this patch chose a compromise method, which is to splice the lru
>> list in the child memcg to the lru list of the same generation in the
>> parent memcg during reparenting. And in order to ensure that the parent
>> memcg has the same generation, we need to increase the generations in the
>> parent memcg to the MAX_NR_GENS before reparenting.
>>
>> Of course, the same generation has different meanings in the parent and
>> child memcg, this will cause confusion in the hot and cold information of
>> folios. But other than that, this method is simple enough, the lru size
>> is correct, and there is no need to consider some concurrency issues (such
>> as lru_gen_del_folio()).
>> ```
> 
> Thanks you this is very useful.
> 
> A high level overview on how the patch series (of this size) would be
> appreaciate as well.

OK. Will add this to the cover letter in the next version.

Thanks,
Qi




