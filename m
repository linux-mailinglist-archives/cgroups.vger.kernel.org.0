Return-Path: <cgroups+bounces-14692-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NmVC47nq2mKhwEAu9opvQ
	(envelope-from <cgroups+bounces-14692-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 07 Mar 2026 09:53:34 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A044122AC23
	for <lists+cgroups@lfdr.de>; Sat, 07 Mar 2026 09:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBE183029C19
	for <lists+cgroups@lfdr.de>; Sat,  7 Mar 2026 08:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88407355803;
	Sat,  7 Mar 2026 08:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CawqzaEc"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F59D2EBBA1
	for <cgroups@vger.kernel.org>; Sat,  7 Mar 2026 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772873601; cv=none; b=dIGtIcgv+8M8p1y+8hVGgQa6DzLn8Ck8BxUb5iUyRh/C9Iopsv0RB0BSIQiOBZZ6SSM668+jISXKBygbJFTA+I4Y9DEzILvsU0K4tY8k6B4uBSnJ/XU4f52gCYOUiSRBnJWAopYRfuLvfHhHOuJBoIfju+wNzVPRTPS5AYUOCZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772873601; c=relaxed/simple;
	bh=FYyP8ZpTDEbn360Vm8yQAAs5kfBZBkodLImqHzZTVpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c/tv/9WniNhIiv1f9ZDAvL6d+WbCzxu5kJ30JK0QbCnDOORbk5Fb7OEUrWKB0am9UcF7cB4XTC/dozfjWEWF/4Uj5Pdt7Mu9UmEmuARMkivR/XkNQwILXH1dDd0O2wUDDE130JtbOZg1jUkFqweiNmOMDQu8qGyR5ghpfUY0/EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CawqzaEc; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b77bd438-3420-4569-a461-7b1b7afbc0a3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772873587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BTpdDjrX0wTiL0fAhrePIJwxDS9K/k1k3ZXc5DUWgFA=;
	b=CawqzaEcU9hO9vJW+5g8ONlJ2RUwoSXjBsrHnHWghOAHhDNG5ovYnEL5GkizH5j+vQLW/u
	Smfzz/V5alCB0t6HJYZvtsS7YbVIFnMwRLlmk2UdFl5qh6hb18+cZxpoAZZ6kVemODYg/j
	1uIpWYQGZmSj/3ji+7RQAzkA8EgqoCY=
Date: Sat, 7 Mar 2026 16:51:58 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 31/33] mm: memcontrol: convert objcg to be per-memcg
 per-node type
To: Usama Arif <usama.arif@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 harry.yoo@oracle.com, yosry.ahmed@linux.dev, imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com,
 akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
 apais@linux.microsoft.com, lance.yang@linux.dev, bhe@redhat.com,
 usamaarif642@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <20260306202931.3878822-1-usama.arif@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260306202931.3878822-1-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: A044122AC23
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14692-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Action: no action

Hi Usama,

On 3/7/26 4:29 AM, Usama Arif wrote:
> On Thu,  5 Mar 2026 19:52:49 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:
> 
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> Convert objcg to be per-memcg per-node type, so that when reparent LRU
>> folios later, we can hold the lru lock at the node level, thus avoiding
>> holding too many lru locks at once.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
>> ---
>>   include/linux/memcontrol.h | 23 +++++------
>>   include/linux/sched.h      |  2 +-
>>   mm/memcontrol.c            | 79 +++++++++++++++++++++++---------------
>>   3 files changed, 62 insertions(+), 42 deletions(-)
>>
> 
> [...]
> 
>> @@ -4087,7 +4100,13 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
>>   	xa_store(&mem_cgroup_private_ids, memcg->id.id, memcg, GFP_KERNEL);
>>   
>>   	return 0;
>> -free_shrinker:
>> +free_objcg:
>> +	for_each_node(nid) {
>> +		struct mem_cgroup_per_node *pn = memcg->nodeinfo[nid];
>> +
>> +		if (pn && pn->orig_objcg)
>> +			obj_cgroup_put(pn->orig_objcg);
> 
> Is it possible that you might call obj_cgroup_put twice on the same cgroup?

Oh, I think you are right. Here pn->orig_objcg was not reset to NULL, so
obj_cgroup_put() will be called in __mem_cgroup_free() again.

> 
> If css_create fails, css_free_rwork_fn is queued, which ends up calling
> mem_cgroup_css_free which calls obj_cgroup_put again?
> 
> Maybe adding pn->orig_objcg = NULL overhere after obj_cgroup_put
> is enough to prevent the double put from causing issues?

Agree.

Like this?

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 992a3f5caa62b..e0795aec4356b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4140,8 +4140,10 @@ static int mem_cgroup_css_online(struct 
cgroup_subsys_state *css)
         for_each_node(nid) {
                 struct mem_cgroup_per_node *pn = memcg->nodeinfo[nid];

-               if (pn && pn->orig_objcg)
+               if (pn && pn->orig_objcg) {
                         obj_cgroup_put(pn->orig_objcg);
+                       pn->orig_objcg = NULL;
+               }
         }
         free_shrinker_info(memcg);
  offline_kmem:

If there are no problems, I will send a fix patch later.

Thanks,
Qi

> 
>> +	}
>>   	free_shrinker_info(memcg);
>>   offline_kmem:
>>   	memcg_offline_kmem(memcg);
>> -- 
>> 2.20.1
>>
>>


