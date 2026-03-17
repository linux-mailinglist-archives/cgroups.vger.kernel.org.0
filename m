Return-Path: <cgroups+bounces-14835-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKAACRD5uGkumgEAu9opvQ
	(envelope-from <cgroups+bounces-14835-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 07:47:44 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 794092A46E1
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 07:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 464383038529
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 06:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA6E33260F;
	Tue, 17 Mar 2026 06:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NodgPK+6"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7C514D719;
	Tue, 17 Mar 2026 06:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773729913; cv=none; b=BzLtoH3CDEspw3BbJlWhXFojbeFqvmT19dMO0JZxP8mdSa0wHA/nqLxCboQ7Xf2Fq1W7j54oBBbpTY4fSwul5Ze3uiKKt+7ygvgsxS7a6RCuXtJexFI3EFpC2PNx8FGT26k1zcfOHRphM1VHP9kvFVW3XNrc7uLmjlGRapl4S08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773729913; c=relaxed/simple;
	bh=8ghl4Tyasnsz0ekbvIT4f5knJlPJmBDwa+JdA1ozBxQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qPJ6VfJ7rVjMWV1bE4SVPPfU7n/2XqpsFi5Gs0+l+YLDxLgToAi6IIQCx1B0prOXNgxYqmb01cIt0impIM1cPWysb0N2y76pEZQlaD8XCBjRIBtu2fXK8kMLnkS0F7WrYLxy4FdW183D+m576mWgORqfpsJhzGOdxzofqGMFebw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NodgPK+6; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773729909; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=d9m8AenGNBSpK6f9o8GrCon857vC2vFuEB2dcmCEqmU=;
	b=NodgPK+6dMbsoNxKCOUFABB5sTnX/b91O4OB0qArN11uTlAl/bU7IXw2m2OH0Cz1YYXvuSwT0Q36PXu4OKZ2WJ1n004RV+/mGSlDRbS6XW2W3Zzd+C0j12V0f5nOGpF/VzpzExUl003vx4UMQQyd8ktXORCLXZO1mihya3Hrydw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=ying.huang@linux.alibaba.com;NM=1;PH=DS;RN=33;SR=0;TI=SMTPD_---0X.9ya0W_1773729894;
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0X.9ya0W_1773729894 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Mar 2026 14:45:07 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,  linux-mm@kvack.org,
  akpm@linux-foundation.org,  mhocko@suse.com,  apopple@nvidia.com,
  axelrasmussen@google.com,  byungchul@sk.com,  cgroups@vger.kernel.org,
  david@kernel.org,  eperezma@redhat.com,  gourry@gourry.net,
  jasowang@redhat.com,  hannes@cmpxchg.org,  joshua.hahnjy@gmail.com,
  Liam.Howlett@oracle.com,  linux-kernel@vger.kernel.org,
  lorenzo.stoakes@oracle.com,  matthew.brost@intel.com,  mst@redhat.com,
  rppt@kernel.org,  muchun.song@linux.dev,  zhengqi.arch@bytedance.com,
  rakie.kim@sk.com,  roman.gushchin@linux.dev,  shakeel.butt@linux.dev,
  surenb@google.com,  virtualization@lists.linux.dev,  weixugc@google.com,
  xuanzhuo@linux.alibaba.com,  yuanchu@google.com,  ziy@nvidia.com,
  kernel-team@meta.com
Subject: Re: [PATCH v2] mm/mempolicy: track page allocations per mempolicy
In-Reply-To: <0d66401f-9874-4047-971b-632723b0b7ee@linux.dev> (JP Kobryn's
	message of "Mon, 16 Mar 2026 21:37:01 -0700")
References: <20260307045520.247998-1-jp.kobryn@linux.dev>
	<3a42463b-9ddd-4d64-b64c-6c2e6e4fc75d@kernel.org>
	<343bbd5b-67a0-46c4-8ec4-69158bf26b3f@linux.dev>
	<874imkpba1.fsf@DESKTOP-5N7EMDA>
	<cd3d7e2c-79fa-4c00-89ad-83beddf98bae@linux.dev>
	<60f71f4c-71d9-4751-8c6b-10179b98bef0@kernel.org>
	<c4e5cc3c-5daa-404e-8c55-cface8aa969d@linux.dev>
	<87sea0o55p.fsf@DESKTOP-5N7EMDA>
	<0d66401f-9874-4047-971b-632723b0b7ee@linux.dev>
Date: Tue, 17 Mar 2026 14:44:59 +0800
Message-ID: <87a4w7x8d0.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14835-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ying.huang@linux.alibaba.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,kvack.org,linux-foundation.org,suse.com,nvidia.com,google.com,sk.com,vger.kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,linux.dev,bytedance.com,lists.linux.dev,linux.alibaba.com,meta.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 794092A46E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

"JP Kobryn (Meta)" <jp.kobryn@linux.dev> writes:

> On 3/15/26 7:54 PM, Huang, Ying wrote:
>> "JP Kobryn (Meta)" <jp.kobryn@linux.dev> writes:
>> 
>>> On 3/13/26 12:34 AM, Vlastimil Babka (SUSE) wrote:
>>>> On 3/13/26 07:14, JP Kobryn (Meta) wrote:
>>>>> On 3/12/26 10:07 PM, Huang, Ying wrote:
>>>>>> "JP Kobryn (Meta)" <jp.kobryn@linux.dev> writes:
>>>>>>
>>>>>>> On 3/12/26 6:40 AM, Vlastimil Babka (SUSE) wrote:
>>>>>>>
>>>>>>> How about I change from per-policy hit/miss/foreign triplets to a single
>>>>>>> aggregated policy triplet (i.e. just 3 new counters which account for
>>>>>>> all policies)? They would follow the same hit/miss/foreign semantics
>>>>>>> already proposed (visible in quoted text above). This would still
>>>>>>> provide the otherwise missing signal of whether policy-driven
>>>>>>> allocations to a node are intentional or fallback.
>>>>>>>
>>>>>>> Note that I am also planning on moving the stats off of the memcg so the
>>>>>>> 3 new counters will be global per-node in response to similar feedback.
>>>>>>
>>>>>> Emm, what's the difference between these newly added counters and the
>>>>>> existing numa_hit/miss/foreign counters?
>>>>>
>>>>> The existing counters don't account for node masks in the policies that
>>>>> make use of them. An allocation can land on a node in the mask and still
>>>>> be considered a miss because it wasn't the preferred node.
>>>> That sounds like we could just a new counter e.g. numa_hit_preferred
>>>> and
>>>> adjust definitions accordingly? Or some other variant that fills the gap?
>>>
>>> It's an interesting thought. Looking into these existing counters more,
>>> the in-kernel direct node allocations, which don't fall under any
>>> mempolicy, are also included in these stats. One good example might be
>>> include/linux/skbuff.h, where __dev_alloc_pages() calls
>>> alloc_pages_node_noprof(NUMA_NO_NODE, ...) which eventually reaches
>>> zone_statistics() and increments the stats.
>> IIUC, the default memory policy is used here, that is, MPOL_LOCAL.
>
> I'm not seeing that. zone_statistics() is eventually reached.
> alloc_pages_mpol() is not.

Yes.  The page isn't allocated through alloc_pages_mpol().  For example,
if we want to allocate pages for the kernel instead of user space
applications.  However, IMHO, the equivalent memory policy is
MPOL_LOCAL, that is, allocate from local node firstly, then fallback to
other nodes.  I don't think that alloc_pages_mpol() is so special.

---
Best Regards,
Huang, Ying

