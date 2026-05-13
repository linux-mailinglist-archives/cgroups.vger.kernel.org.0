Return-Path: <cgroups+bounces-15867-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AXtHtLdA2qA/gEAu9opvQ
	(envelope-from <cgroups+bounces-15867-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 04:11:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD0552C280
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 04:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73F223046CC8
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 02:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9649C385D62;
	Wed, 13 May 2026 02:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wqU8qVBO"
X-Original-To: cgroups@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2EB3859D9
	for <cgroups@vger.kernel.org>; Wed, 13 May 2026 02:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778638287; cv=none; b=qgabrrGOUwGORclkH8EloqroPWjFwEVURDuBLOnAiddw1jn/6hhU7T3vG2vcqbG5xaC9aThL9pomS//wHhVT7vtS7fY7i40Y1OsnMh4cKAnRH+GncRWsqCnOLSw6j4MW5oTunn4VnD3VnKifKNBPiPd/nT7WkfhWw8IVoFknSec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778638287; c=relaxed/simple;
	bh=Hm/lAQiIy+pVefFWoYgSJPXdCymAZxPad21Ew7EoX6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSkcGhXQE9UOxxx0vAZkP9ky914JzW501aY1gfKK6wpSuoWMZEWJEGjeo9w/RewtdQIkXr/MLaxDgtaPZUzo0jDpQb0pc5inwRtQGQRI0tgTfm7LVHOlX9H12jv2+gnockO+SR3q+Fyi4sOQ4U5ws0WPh9Ad82BGtBDp1gRKv/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wqU8qVBO; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0e1b8994-944d-4dda-8966-3cd43661796d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778638273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iq7jnY+N0UwU1xXxCmM5jCZ1Y+zQ9eUrIz+WkKBogEQ=;
	b=wqU8qVBOB6nPI8tTv2ruSJGtw0S5kRmu9mGb+a0X62ASIwBhuC7sNYjp1hEHRGS3fv0Jke
	/+WG6c1jYbL7dgRhevSmu4bdBQDFFOeMTTgqN5ZN6GRhpq6xKym1chF7TeMNfq3QClKzpJ
	vwBwUHJpWeAQoQn7wwGJ/t8kSeSRdOE=
Date: Wed, 13 May 2026 10:10:34 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [linus:master] [mm] 01b9da291c: stress-ng.switch.ops_per_sec
 67.7% regression
To: Shakeel Butt <shakeel.butt@linux.dev>,
 kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, David Carlier
 <devnexen@gmail.com>, Allen Pais <apais@linux.microsoft.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Baoquan He <bhe@redhat.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Chen Ridong <chenridong@huawei.com>, David Hildenbrand <david@kernel.org>,
 Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
 Harry Yoo <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>,
 Imran Khan <imran.f.khan@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Kamalesh Babulal <kamalesh.babulal@oracle.com>,
 Lance Yang <lance.yang@linux.dev>, Liam Howlett <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 Muchun Song <songmuchun@bytedance.com>, Nhat Pham <nphamcs@gmail.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>, Usama Arif <usamaarif642@gmail.com>,
 Vlastimil Babka <vbabka@kernel.org>, Wei Xu <weixugc@google.com>,
 Yosry Ahmed <yosry@kernel.org>, Yuanchu Xie <yuanchu@google.com>,
 Zi Yan <ziy@nvidia.com>, Usama Arif <usama.arif@linux.dev>,
 cgroups@vger.kernel.org, linux-mm@kvack.org
References: <202605121641.b6a60cb0-lkp@intel.com> <agNO8G8tPnPuVrGq@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <agNO8G8tPnPuVrGq@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 0CD0552C280
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15867-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,intel.com,vger.kernel.org,linux-foundation.org,gmail.com,linux.microsoft.com,google.com,redhat.com,linux.dev,huawei.com,kernel.org,oracle.com,cmpxchg.org,suse.com,bytedance.com,nvidia.com,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim]
X-Rspamd-Action: no action



On 5/13/26 12:03 AM, Shakeel Butt wrote:
> On Tue, May 12, 2026 at 08:56:52PM +0800, kernel test robot wrote:
>>
>>
>> Hello,
>>
>> kernel test robot noticed a 67.7% regression of stress-ng.switch.ops_per_sec on:
>>
>>
>> commit: 01b9da291c4969354807b52956f4aae1f41b4924 ("mm: memcontrol: convert objcg to be per-memcg per-node type")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> This is most probably due to shuffling of struct mem_cgroup and struct
> mem_cgroup_per_node members.

Another possibility is that after objcg was split into per-node, the
slab accounting fast path is still designed assuming only one current
objcg per CPU:

struct obj_stock_pcp {
     struct obj_cgroup *cached_objcg;
};

So it's may cause the following thrashing:

  CPU stock cached = memcg/node0 objcg
  free object tagged = memcg/node1 objcg
  => __refill_obj_stock --> objcg mismatch
      => drain_obj_stock()
      => cache switches to node1 objcg

  next local allocation tagged = node0 objcg
  => mismatch again
      => drain_obj_stock()


> 
> I will try to reproduce and will followup on this.

Thanks! I'll also try to reproduce it locally and work on a fix.



