Return-Path: <cgroups+bounces-14485-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLoyOgllomnI2gQAu9opvQ
	(envelope-from <cgroups+bounces-14485-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 28 Feb 2026 04:46:17 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9251C0324
	for <lists+cgroups@lfdr.de>; Sat, 28 Feb 2026 04:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 258C43004F72
	for <lists+cgroups@lfdr.de>; Sat, 28 Feb 2026 03:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6832D2381;
	Sat, 28 Feb 2026 03:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SWuS4p0a"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057712D0C82
	for <cgroups@vger.kernel.org>; Sat, 28 Feb 2026 03:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772250095; cv=none; b=buDTtfx1C8FBaowxxwzzN8wX9n4SKMlHaL5CzQhK2WXSDrL2jMfSI7RsZxw9UwnWqM85ul6SG0QYsDoS7X5i+WEzWdVtke4GRbUrFgNBUrGvCpX++YBE9C+EpFcIKAyzmWnVtVo9OHmnS6iRKwsCsnn7vAP7jhnCjp6lLroNVvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772250095; c=relaxed/simple;
	bh=zUEouOCUxs1h0Fqdi1kLzelsJ7E80sSVekgFA08Ybt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/dWoj40RwE9RewGgMN13tnxEVdbD2UbCxoRxRB35c0WcFTYTN1n01jXCh3EKYPrGEFYzawcaDbgqxcKLBgiA2j06jdsQMsV13K+tIdpQ/DTkUp3kD7uVQ9bQJDSWvksQawd32pyiK/dCLp1GmuEqDdzWLvL5291fxFkfszZP3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SWuS4p0a; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8f230f3d-4005-433e-b91a-885d2a1cdc84@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772250081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C4heYZ2tE4N42LcNTwv/w/mLqT1Jp6f8zKyKbYhkIGg=;
	b=SWuS4p0a6o8LfHm6WUSteK8eCJ1R5+EemwAlJ0ubROwRHhF30Y3+j616kbWvcgMEMUUjSh
	P+hDK83K0ulySPL1tIA/G2VsGVgeWZqb6mdsty7dqxuQOfp0mlhU+0mrmFp5YxhG/KhM1h
	twirmqYmZ6XTYzXteXwii3uHdj3okII=
Date: Sat, 28 Feb 2026 11:40:57 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 29/32] mm: memcontrol: prepare for reparenting
 non-hierarchical stats
To: Yosry Ahmed <yosry@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, hannes@cmpxchg.org,
 hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
 muchun.song@linux.dev, david@kernel.org, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, harry.yoo@oracle.com, yosry.ahmed@linux.dev,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
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
 <CAO9r8zPmgytmGHAbueFKXcZWY5SJaEwD3Pqk99ws4XeO2_hnKw@mail.gmail.com>
 <97e296ed-ef73-44b7-ab68-3d79749caa47@linux.dev>
 <e15c2304-4874-4adc-bbe5-58ba78b3b84f@linux.dev>
 <CAO9r8zP-peywvtq-3HF2-PjCx9X_ABHEQF2vMO3OFoGfVOHTAg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <CAO9r8zP-peywvtq-3HF2-PjCx9X_ABHEQF2vMO3OFoGfVOHTAg@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-14485-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,cmpxchg.org,google.com,suse.com,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
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
X-Rspamd-Queue-Id: 5A9251C0324
X-Rspamd-Action: no action



On 2/28/26 2:18 AM, Yosry Ahmed wrote:
> [..]
>>>> @@ -506,12 +517,10 @@ void reparent_memcg_lruvec_state_local(struct
>>>> mem_cgroup *memcg,
>>>>           for_each_node(nid) {
>>>>                   struct lruvec *child_lruvec = mem_cgroup_lruvec(memcg,
>>>> NODE_DATA(nid));
>>>>                   struct lruvec *parent_lruvec =
>>>> mem_cgroup_lruvec(parent, NODE_DATA(nid));
>>>> -               struct mem_cgroup_per_node *parent_pn;
>>>>                   unsigned long value =
>>>> lruvec_page_state_local(child_lruvec, idx);
>>>>
>>>> -               parent_pn = container_of(parent_lruvec, struct
>>>> mem_cgroup_per_node, lruvec);
>>>> -
>>>> -               atomic_long_add(value,
>>>> &(parent_pn->lruvec_stats->state_local[i]));
>>>> +               mod_memcg_lruvec_state(child_lruvec, idx, -value);
>>>
>>> We can't use mod_memcg_lruvec_state() here, because child memcg has
>>> already been set CSS_DYING. So in mod_memcg_lruvec_state(), we will
>>> get parent memcg.
>>>
>>> It seems we need to reimplement a function or add a parameter to
>>> mod_memcg_lruvec_state() to solve the problem. What do you think?
>>
>> Since child memcg is about to disappear, perhaps we can just add value
>> to parent memcg without handling the child memcg. Make sense?
> 
> Ugh yes, I missed that, thanks.
> 
> I don't think we can just leave the child's memcg wrong. Aside from
> the fact that I would be nervous if access to those stats is still
> possible after it's offlined (e.g. can userspace already have the
> stats file open, or maybe some in-kernel code uses it), there's a
> bigger issue.
> 
> When the child cgroup is released, css_release_work_fn() will flush
> its stats and then it will be double counted at the parent.
> 
> Maybe refactor the part sof mod_memcg_lruvec_state() and
> mod_memcg_state () without get_non_dying_memcg_{start/end}() into
> helpers, and call that directly from the reparenting functions? Adding

OK, will do.

> a boolean argument to mod_memcg_lruvec_state() and mod_memcg_state()
> will add a lot of churn, and naked boolean arguments are not ideal.


