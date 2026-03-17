Return-Path: <cgroups+bounces-14850-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KRjLemYuWn5KwIAu9opvQ
	(envelope-from <cgroups+bounces-14850-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 19:09:45 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF2C2B0A7E
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 19:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05A3531886DC
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 17:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1587937B002;
	Tue, 17 Mar 2026 17:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pjaAZX31"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5282D7393
	for <cgroups@vger.kernel.org>; Tue, 17 Mar 2026 17:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770150; cv=none; b=k6eWb3MFiMh45jKKA/lkjgACzLscEiLk+pML+m0fF0yWG0+KH7xE7lJGycXUvlipT3BWcT5fI6gAkNKqgZsSjm6iYUvB0K0lmq0wCbHq6NcT770gi4Kh7JIcHSEXwUDw8h1hjVtLgFoMSpgwUT6n0kVCWIae8q2WufF7JUSbqaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770150; c=relaxed/simple;
	bh=kOVU8iJwnYx0FdEkjEXpzP0JhkgJQiE7YpSMZimGrwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+Ik99SbWSl+4N9JnJBErYzISy+cE4oEQJ9wl/XrOyJ+l5ah0id0vjH0M1IJIh/2IFjYH5y3oh+9Jb/BBefodl4LYvpHuWcTfMHGcm8CgTu+9F8rXbHZVAYf4t3w2aYEoXVg71pMxI/u68ymI2LSL7MvfJ3CPF/ql4tyG0strTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pjaAZX31; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ae4ea01d-a30e-4085-ab4a-578dcfcba82c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773770136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTYVKV5nb5ayCDEY32vWKZpQOz0lpO2L66vO5Fes22w=;
	b=pjaAZX31HfPv0EqxBir1wrcOT4ZRPxKDxntVvAAZnr7TtTsyDgri1szGW/0d/+Frj9Xeuk
	t7xO1e8UeWMQMiTSIl9JwrugHVnaKhHQL+RxC/k1YCPYhdeKUYjy/J7ZJURqccLLxMt+mv
	oj2tZq7fy2Z2lQJEQ91Eaz9CEFmhq2c=
Date: Tue, 17 Mar 2026 10:55:26 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm/mempolicy: track page allocations per mempolicy
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, linux-mm@kvack.org,
 akpm@linux-foundation.org, mhocko@suse.com, apopple@nvidia.com,
 axelrasmussen@google.com, byungchul@sk.com, cgroups@vger.kernel.org,
 david@kernel.org, eperezma@redhat.com, gourry@gourry.net,
 jasowang@redhat.com, hannes@cmpxchg.org, joshua.hahnjy@gmail.com,
 Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com, matthew.brost@intel.com, mst@redhat.com,
 rppt@kernel.org, muchun.song@linux.dev, zhengqi.arch@bytedance.com,
 rakie.kim@sk.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 surenb@google.com, virtualization@lists.linux.dev, weixugc@google.com,
 xuanzhuo@linux.alibaba.com, yuanchu@google.com, ziy@nvidia.com,
 kernel-team@meta.com
References: <20260307045520.247998-1-jp.kobryn@linux.dev>
 <3a42463b-9ddd-4d64-b64c-6c2e6e4fc75d@kernel.org>
 <343bbd5b-67a0-46c4-8ec4-69158bf26b3f@linux.dev>
 <874imkpba1.fsf@DESKTOP-5N7EMDA>
 <cd3d7e2c-79fa-4c00-89ad-83beddf98bae@linux.dev>
 <60f71f4c-71d9-4751-8c6b-10179b98bef0@kernel.org>
 <c4e5cc3c-5daa-404e-8c55-cface8aa969d@linux.dev>
 <87sea0o55p.fsf@DESKTOP-5N7EMDA>
 <0d66401f-9874-4047-971b-632723b0b7ee@linux.dev>
 <87a4w7x8d0.fsf@DESKTOP-5N7EMDA>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
In-Reply-To: <87a4w7x8d0.fsf@DESKTOP-5N7EMDA>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14850-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kvack.org,linux-foundation.org,suse.com,nvidia.com,google.com,sk.com,vger.kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,linux.dev,bytedance.com,lists.linux.dev,linux.alibaba.com,meta.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jp.kobryn@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 1EF2C2B0A7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/16/26 11:44 PM, Huang, Ying wrote:
> "JP Kobryn (Meta)" <jp.kobryn@linux.dev> writes:
> 
>> On 3/15/26 7:54 PM, Huang, Ying wrote:
>>> "JP Kobryn (Meta)" <jp.kobryn@linux.dev> writes:
>>>
>>>> On 3/13/26 12:34 AM, Vlastimil Babka (SUSE) wrote:
>>>>> On 3/13/26 07:14, JP Kobryn (Meta) wrote:
>>>>>> On 3/12/26 10:07 PM, Huang, Ying wrote:
>>>>>>> "JP Kobryn (Meta)" <jp.kobryn@linux.dev> writes:
>>>>>>>
>>>>>>>> On 3/12/26 6:40 AM, Vlastimil Babka (SUSE) wrote:
>>>>>>>>
>>>>>>>> How about I change from per-policy hit/miss/foreign triplets to a single
>>>>>>>> aggregated policy triplet (i.e. just 3 new counters which account for
>>>>>>>> all policies)? They would follow the same hit/miss/foreign semantics
>>>>>>>> already proposed (visible in quoted text above). This would still
>>>>>>>> provide the otherwise missing signal of whether policy-driven
>>>>>>>> allocations to a node are intentional or fallback.
>>>>>>>>
>>>>>>>> Note that I am also planning on moving the stats off of the memcg so the
>>>>>>>> 3 new counters will be global per-node in response to similar feedback.
>>>>>>>
>>>>>>> Emm, what's the difference between these newly added counters and the
>>>>>>> existing numa_hit/miss/foreign counters?
>>>>>>
>>>>>> The existing counters don't account for node masks in the policies that
>>>>>> make use of them. An allocation can land on a node in the mask and still
>>>>>> be considered a miss because it wasn't the preferred node.
>>>>> That sounds like we could just a new counter e.g. numa_hit_preferred
>>>>> and
>>>>> adjust definitions accordingly? Or some other variant that fills the gap?
>>>>
>>>> It's an interesting thought. Looking into these existing counters more,
>>>> the in-kernel direct node allocations, which don't fall under any
>>>> mempolicy, are also included in these stats. One good example might be
>>>> include/linux/skbuff.h, where __dev_alloc_pages() calls
>>>> alloc_pages_node_noprof(NUMA_NO_NODE, ...) which eventually reaches
>>>> zone_statistics() and increments the stats.
>>> IIUC, the default memory policy is used here, that is, MPOL_LOCAL.
>>
>> I'm not seeing that. zone_statistics() is eventually reached.
>> alloc_pages_mpol() is not.
> 
> Yes.  The page isn't allocated through alloc_pages_mpol().  For example,
> if we want to allocate pages for the kernel instead of user space
> applications.  However, IMHO, the equivalent memory policy is
> MPOL_LOCAL, that is, allocate from local node firstly, then fallback to
> other nodes.  I don't think that alloc_pages_mpol() is so special.

Sure. My response was based on how you said, "the default memory policy
is used here". I took that literally. I agree on the behavioral
equivalence, but the important point is that no mempolicy is set. In the
v3 patch which was recently sent out, I'm using that aspect to
distinguish between allocations with a user-defined mempolicy and
allocations without one.

