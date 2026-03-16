Return-Path: <cgroups+bounces-14826-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFQuFmN9t2muRgEAu9opvQ
	(envelope-from <cgroups+bounces-14826-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 16 Mar 2026 04:47:47 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43818294764
	for <lists+cgroups@lfdr.de>; Mon, 16 Mar 2026 04:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0879C3012C54
	for <lists+cgroups@lfdr.de>; Mon, 16 Mar 2026 03:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589532C375A;
	Mon, 16 Mar 2026 03:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CqdAeQ8x"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463632836E
	for <cgroups@vger.kernel.org>; Mon, 16 Mar 2026 03:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773632864; cv=none; b=ICGKLqB6SB6jLbiv9qUhmRyWdk8XU2lb1dfL4wkfRnHyYNezYps3o89YXVTWvH9Gx9Bs87Kss/encZ0q8NoYN9LbBNw0KQm8GnHWK1eFfl5Nct75Oq1g9HqTrPhwb3fhVyViquKg3rdDnaepjsLTD3So1F3/T+EUnSXjgWXXiR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773632864; c=relaxed/simple;
	bh=WOfrTdOdu/x4/wGth2qMAUuJTbObQXADe3tE7SPlL9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PFJ5RZNirjY4U+ZWGZTmYW9DOW7fhkVNW2002kJWx0H7jdtfhzR7BbvR808USt/N37SLW2J5b08lCaF4S+kH8yWkX8GWqecnenoBGkxXqNprYZBiYONTaYMC+Qc3qheWkFgTdng7kNGSipJH05d5rrVncWFkpsp1+Syg9B9KuwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CqdAeQ8x; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d07a0787-dd00-402c-b8bd-3a6380608c0d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773632859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BC/9VRvnBx2Fbj7AWhZPfEGKyE+15so5XBYMY8jq8jw=;
	b=CqdAeQ8xg8xe5XJljnNCPre7futB6K0k00xwmOjFkgULmZSHb4opCfSw2vsPa5wzqNXcWO
	fzFYYPFQ/K3WUWO6OY3euHKDMdSWVovLrYZEHR1esnICG4oK6qmP5mqeRgiuCt1q4tsrG1
	NU7ZpkPh03uzkBJfquOm246sapaN1/8=
Date: Mon, 16 Mar 2026 11:47:06 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 30/33] mm: memcontrol: prepare for reparenting
 non-hierarchical stats
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 harry.yoo@oracle.com, yosry.ahmed@linux.dev, imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, chenridong@huaweicloud.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, bhe@redhat.com, usamaarif642@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, Yosry Ahmed <yosry@kernel.org>
References: <cover.1772711148.git.zhengqi.arch@bytedance.com>
 <e862995c45a7101a541284b6ebee5e5c32c89066.1772711148.git.zhengqi.arch@bytedance.com>
 <hwcqvplnn2knclpivgagctmcaiutyv2qprgoqmwp7suzj6fqb2@diq6grkwo33b>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <hwcqvplnn2knclpivgagctmcaiutyv2qprgoqmwp7suzj6fqb2@diq6grkwo33b>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14826-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 43818294764
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Michal,

On 3/14/26 12:22 AM, Michal Koutný wrote:
> Hello Qi.
> 
> On Thu, Mar 05, 2026 at 07:52:48PM +0800, Qi Zheng <qi.zheng@linux.dev> wrote:
>> To ensure that these non-hierarchical stats work properly, we need to
>> reparent these non-hierarchical stats after reparenting LRU folios. To
>> this end, this commit makes the following preparations:
>>
>> 1. implement reparent_state_local() to reparent non-hierarchical stats
>> 2. make css_killed_work_fn() to be called in rcu work, and implement
>>     get_non_dying_memcg_start() and get_non_dying_memcg_end() to avoid race
>>     between mod_memcg_state()/mod_memcg_lruvec_state()
>>     and reparent_state_local()
> 
> 
> css_free_rwork_fn has() already RCU deferal but we discussed some
> reasons why stats reparenting cannot be done from there. IIUC something
> like:
> 
> | reparent_state_local() must be already at css_killed_work_fn() because
> | waiting until css_free_rwork_fn() would mean the non-hierarchical
> | stats of the surrogate ancestor are outdated, e.g. underflown.
> | And the waiting until css_free_rwork_fn() may still be indefinite due
> | to non-folio references to the offlined memcg.

We need to ensure that when reparent_state_local() is called, no writer
modifies the non-hierarchical stats of child memcg, otherwise these
stats modifications may be missed.

In the v3, we used synchronize_rcu() in reparent_state_local() to ensure
this, but this could cause blocking, so in this version we changed to
this asynchronous approach.

> 
> Could this be captured in the commit (if it's correct)?
> 
> 
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
>> @@ -6044,8 +6044,9 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
>>    */
>>   static void css_killed_work_fn(struct work_struct *work)
>>   {
>> -	struct cgroup_subsys_state *css =
>> -		container_of(work, struct cgroup_subsys_state, destroy_work);
>> +	struct cgroup_subsys_state *css;
>> +
>> +	css = container_of(to_rcu_work(work), struct cgroup_subsys_state, destroy_rwork);
>>   
>>   	cgroup_lock();
>>   
>> @@ -6066,8 +6067,8 @@ static void css_killed_ref_fn(struct percpu_ref *ref)
>>   		container_of(ref, struct cgroup_subsys_state, refcnt);
>>   
>>   	if (atomic_dec_and_test(&css->online_cnt)) {
>> -		INIT_WORK(&css->destroy_work, css_killed_work_fn);
>> -		queue_work(cgroup_offline_wq, &css->destroy_work);
>> +		INIT_RCU_WORK(&css->destroy_rwork, css_killed_work_fn);
>> +		queue_rcu_work(cgroup_offline_wq, &css->destroy_rwork);
>>   	}
>>   }
>>
> 
> Could this be
> 
> #ifdef CONFIG_MEMCG_V1
> 		/* See get_non_dying_memcg_start, get_non_dying_memcg_end
> 		INIT_RCU_WORK(&css->destroy_rwork, css_killed_work_fn);
> 		queue_rcu_work(cgroup_offline_wq, &css->destroy_rwork);
> #else
> 		INIT_WORK(&css->destroy_work, css_killed_work_fn);
> 		queue_work(cgroup_offline_wq, &css->destroy_work);
> #endif
> 
> ?
> 
> IOW there's no need to make the cgroup release path even more
> asynchronous without CONFIG_MEMCG_V1 (all this seems CONFIG_MEMCG_V1
> specific).

Right. But I'm wondering if it's necessary to use ifdefing, since
asynchronous methods shouldn't cause any significant drawbacks?

> 
> (+not so beautiful css_killed_work_fn ifdefing but given there are the
> variants of _start, _end)
> 
>> +#ifdef CONFIG_MEMCG_V1
>> +/*
>> + * Used in mod_memcg_state() and mod_memcg_lruvec_state() to avoid race with
>> + * reparenting of non-hierarchical state_locals.
>> + */
>> +static inline struct mem_cgroup *get_non_dying_memcg_start(struct mem_cgroup *memcg)
> 
> Nit: I think the idiomatic names are begin + end (in the meaning of
> paired parenthesis, don't look at css_task_iter_start ;-).

Both are fine for me, but changing the name requires changing
[PACTH v6 30/33] and [PACTH v6 32/33], if we need to update to v7,
I can include them.

Thanks,
Qi




