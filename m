Return-Path: <cgroups+bounces-14414-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBKXK5Drn2nYewQAu9opvQ
	(envelope-from <cgroups+bounces-14414-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 07:43:28 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDAA1A1647
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 07:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 798DF3045C28
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 06:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C36D38A721;
	Thu, 26 Feb 2026 06:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HP5Ga7xy"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086F5387590
	for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 06:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772088200; cv=none; b=WDKg8yTgb78RDQTGSzeAjhEUnc/c3XZPuBlGkVHvnUiFqA5ANy0ApoX75PPevjxCvsnEZjTIJ0cAsctaAZ4n0la4C+TrOSTH2jLxdS6F17LfmaZ3V4j8Dr0uVxJTBNWNKXHdnJlfw1w+fpwOsW8DeUF/gW0nW1aWrHV0pO9JKiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772088200; c=relaxed/simple;
	bh=p8R4zmAB9V4nCQaJusrhg0BJhZnx2oFpUwWtRscukWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MA+tYX0oErRqWWPFl6xfy6WTIn9fqkBtHZf60Dlxmgx2hKt+zLKSPMm+P1lvQBCNqzeNXUGRpa1cDlUwZvCB7xGGRFIVIfxhYXkj353NNObgYOM8OB3s2pDZrrkW4gz78NnK5g3BDluk7/pj+F7Cus32v9E5ll1IINkBLeIiaI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HP5Ga7xy; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d7bc163c-7dca-4cb5-b522-a6f98ba4b16f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772088196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/gFMs3BNYCLYbp907qyYSrv7ESdIsN4oDF7h/Fu2FJY=;
	b=HP5Ga7xyX4/Ux+VNCIMWTaLmiC52BjFNZ8ZGo2ljwIaNuUW1j9m0tascLyfYdtnFd+8HtH
	Z55p50bo9TBs9IZhmfCIXUiw7Tjqv9UwPTuyH3MtGTAf/qgvQ0w8lku/YcCSGDx40MMllu
	Ogim/cLOLqJMhJFU7U1l3hlNee2bCCo=
Date: Thu, 26 Feb 2026 14:42:51 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 29/32] mm: memcontrol: prepare for reparenting
 non-hierarchical stats
To: Shakeel Butt <shakeel.butt@linux.dev>, Yosry Ahmed <yosry@kernel.org>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
 yosry.ahmed@linux.dev, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, bhe@redhat.com, usamaarif642@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1772005110.git.zhengqi.arch@bytedance.com>
 <ef13e5974343b37ae2a0e28aff03ea2d033cb888.1772005110.git.zhengqi.arch@bytedance.com>
 <CAO9r8zOhZgrym6oSrtg7b+HmNHEfWuAzZ0i8eYhm5-OEnfFLdw@mail.gmail.com>
 <aZ-R87JfacQ2gGq1@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aZ-R87JfacQ2gGq1@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14414-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0EDAA1A1647
X-Rspamd-Action: no action


On 2/26/26 8:25 AM, Shakeel Butt wrote:
> On Wed, Feb 25, 2026 at 06:58:59AM -0800, Yosry Ahmed wrote:
>>> @@ -473,6 +493,29 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
>>>          return x;
>>>   }
>>>
>>> +#ifdef CONFIG_MEMCG_V1
>>> +void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
>>> +                                      struct mem_cgroup *parent, int idx)
>>> +{
>>> +       int i = memcg_stats_index(idx);
>>> +       int nid;
>>> +
>>> +       if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
>>> +               return;
>>> +
>>> +       for_each_node(nid) {
>>> +               struct lruvec *child_lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
>>> +               struct lruvec *parent_lruvec = mem_cgroup_lruvec(parent, NODE_DATA(nid));
>>> +               struct mem_cgroup_per_node *parent_pn;
>>> +               unsigned long value = lruvec_page_state_local(child_lruvec, idx);
>>> +
>>> +               parent_pn = container_of(parent_lruvec, struct mem_cgroup_per_node, lruvec);
>>> +
>>> +               atomic_long_add(value, &(parent_pn->lruvec_stats->state_local[i]));
>>> +       }
>>> +}
>>
>> Did you measure the impact of making state_local atomic on the flush
>> path? It's a slow path but we've seen pain from it being too slow
>> before, because it extends the critical section of the rstat flush
>> lock.
> 
> Qi, please measure the impact on flushing and if no impact then no need to do

OK, will try to do it.

> anything as I don't want anymore churn in this series.

Agree.

> 



