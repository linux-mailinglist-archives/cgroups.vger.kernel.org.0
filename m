Return-Path: <cgroups+bounces-17821-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZW+SAAFFV2qMIQEAu9opvQ
	(envelope-from <cgroups+bounces-17821-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 10:29:53 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C9075BE29
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 10:29:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=FRUJElK8;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17821-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17821-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5819A30182AA
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 08:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06903CC9E8;
	Wed, 15 Jul 2026 08:28:32 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472A43AD51A
	for <cgroups@vger.kernel.org>; Wed, 15 Jul 2026 08:28:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104112; cv=none; b=qHnFp+lIfOo9XOUsKj3lzW9OCllI55pKoO+rGI4iAQkY0kdSYUiccl8OGmXF///CCagpeOVtbp4Auw+GUUPPSdWT9D+aPPECG0+rByTXMvGh96yXQY8lfUEPOQE7d4Sd7q2yB++dsgzGFhIDwRoMMsQf5Sr7aU11Ocl7KvidjdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104112; c=relaxed/simple;
	bh=3cK/hdA+KmShv1b5t2wupekU05qRjUP2fy2Qsp/AljI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ex4MSzOeIVJlFQAIHWyT8pZnk/W5dpU9IlY8b4sf4CqVNNhGr1UFIxFXkM+epHGEuTZgINpo640kQMNJfzVvtP1guyR9i+BXe9zUaRB2UkSzw967F95ZADGOm71ixXcmmk6XKksqL7wz0v0ZCk44WK81WwUdwzGgrisXdyTiEq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FRUJElK8; arc=none smtp.client-ip=91.218.175.183
Message-ID: <a28e5f32-6b33-465d-8c62-a155f1f61ca8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784104098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S7GAdy7BzpH1mY1l3xxBJ7jnUWvRdOJWdWyYoP9VmOo=;
	b=FRUJElK8nJYnUa4z0EhRgh9pD4xudbHVG3EKKJQ9g0U+5ekiB4AaVTzUiDhJzu5yXkV09b
	m4Qq3bCA8Dx2hgQRlhUB1y35ui00PREwKAYGVnsbdExx+jHbEUkfLQ72XPj2Sr9CTPpiG8
	oHPr5rTYCpbKDSkbrAbbhwRu+SS7YHk=
Date: Wed, 15 Jul 2026 16:28:04 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] memcg: move mem_cgroup_swappiness to memcontrol.h
To: Barry Song <baohua@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 David Hildenbrand <david@kernel.org>, Yuanchu Xie <yuanchu@google.com>,
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ridong Chen <chenridong@xiaomi.com>
References: <20260711091157.306070-1-ridong.chen@linux.dev>
 <20260711091157.306070-2-ridong.chen@linux.dev>
 <CAGsJ_4y39eSYqYwSPzqcZPk1wcJEYN3HZr83MPv8pMgN8Nct5A@mail.gmail.com>
 <87dc4105-b98b-4541-bafe-c0adfbf58836@linux.dev>
 <CAGsJ_4wDMrdvGksTJ1SMGE=aHY3CMY529ceKDD68cXLsHQCjtQ@mail.gmail.com>
 <CAGsJ_4zcgURKZKBAc6i0Y5g7u2OXjENDE7A=nqYcQ9TTVuR=Hg@mail.gmail.com>
 <0545ee70-b0a0-4a93-ac2c-3e84ff504e5a@linux.dev>
 <CAGsJ_4x7cg-L_OzCdyZy+8zoKptVi-Jh18k1HRkvTBTbn-EQRA@mail.gmail.com>
 <bfb1cfa1-691a-4bac-beb6-caef9b3ac4e8@linux.dev>
 <CAGsJ_4w8P8ERoXJY70wXf71MYEA16vX+JMAaE4sfB4=OqzN_Pg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <CAGsJ_4w8P8ERoXJY70wXf71MYEA16vX+JMAaE4sfB4=OqzN_Pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:baohua@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:chrisl@kernel.org,m:kasong@tencent.com,m:david@kernel.org,m:yuanchu@google.com,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:chenridong@xiaomi.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-17821-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:mid,linux.dev:email,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56C9075BE29



On 7/14/2026 9:46 PM, Barry Song wrote:
> On Tue, Jul 14, 2026 at 7:31 PM Ridong Chen <ridong.chen@linux.dev> wrote:
> 
> [...]
>>>>>>
>>>>>> If this is the case, it still seems better to keep
>>>>>> extern int vm_swappiness in include/linux/swap.h.
>>>>>>
>>>>>> Then we don't need the comment:
>>>>>> /* Defined in mm/vmscan.c; used by mem_cgroup_swappiness(). */
>>>>>>
>>>>>> It also makes it clearer that vm_swappiness is an extern variable
>>>>>> belonging to the swap module, rather than the memcontrol module.
>>>>>
>>>>> BTW, if mem_c_group_swappiness() and vm_swappiness are only used
>>>>> within mm/, could all of these be moved to mm/swap.h and
>>>>> mm/internal.h instead?
>>>>>
>>>>> We are making a big effort to move many unrelated things out of
>>>>> include/linux/swap.h recently. Could you check?
>>>>>
>>>>> https://lore.kernel.org/linux-mm/20260708-ch-swap-series-plus-folio-lru-cleanup-v9-0-2bc72b4f8730@gmail.com/
>>>>
>>>> Good suggestion. Moving them to mm/internal.h makes sense. Will update
>>>> in the next version.
>>>
>>> Either mm/swap.h or mm/internal.h.
>>> vm_swappiness probably belongs in mm/swap.h rather than
>>> mm/internal.h, right?
>>>
>>> BTW, I am not particularly eager about this cleanup;
>>> it could be done later as a separate patch.
>>>
>>> If you decide not to do the cleanup, I think it would be better to
>>> leave "extern int vm_swappiness" in include/linux/swap.h rather than
>>> declaring it in include/linux/memcontrol.h?
>> I noticed that some swap-related macros are already defined in
>> mm/internal.h, so I'm planning to place the code right after them for
>> better grouping. Does that work for you?
> 
> We also have mm/swap.h, which is dedicated to exporting
> swap-related things. Is it a better place than mm/internal.h?
> 

Placing it in mm/swap.h is fine with me. Will update.

```
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -4,6 +4,7 @@

  #include <linux/atomic.h> /* for atomic_long_t */
  #include <linux/mm.h> /* for PAGE_SHIFT */
+#include <linux/memcontrol.h>
  struct mempolicy;
  struct swap_iocb;
  struct swap_memcg_table;
@@ -76,6 +77,25 @@ enum swap_cluster_flags {
         CLUSTER_FLAG_MAX,
  };

+extern int vm_swappiness;
+
+static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
+{
+#ifdef CONFIG_MEMCG_V1
+       /* Cgroup2 doesn't have per-cgroup swappiness */
+       if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
+               return READ_ONCE(vm_swappiness);
+
+       /* root ? */
+       if (mem_cgroup_disabled() || mem_cgroup_is_root(memcg))
+               return READ_ONCE(vm_swappiness);
+
+       return READ_ONCE(memcg->swappiness);
+#else
+       return READ_ONCE(vm_swappiness);
+#endif
+}
+
```

-- 
Best regards
Ridong


