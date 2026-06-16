Return-Path: <cgroups+bounces-17002-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0MaDOq1sMWr0iwUAu9opvQ
	(envelope-from <cgroups+bounces-17002-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 17:33:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74479691213
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 17:33:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=YeOwEJxk;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17002-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17002-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EBA3311249A
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 15:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB73144BC94;
	Tue, 16 Jun 2026 15:23:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729B044BC82
	for <cgroups@vger.kernel.org>; Tue, 16 Jun 2026 15:23:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623411; cv=none; b=Q4mqgKx6PDu9OhkXAKv9aKSYdwhvfrYv8I0LBIDq2mYuVgJ9BHSZB70xCeu2VdCucB3azXQ+5wi7XFGHQpbMg22phZBH3qp1sMjp3LmrZMnfxlDxcq0BzyY6CPIzxv8+WB/nbAvgBSt0CSxc2cMytJHD37gMFI5Dlzzd+8ZRZVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623411; c=relaxed/simple;
	bh=8i4twbSNDv02zgD1VY8jsEZ9u0TWwzEkJYMF1EplDoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OmgBcoOEzY6qIt7OUC7XkpzwQhZPOrEKbMOsA1ZJh4FU1kmlToBF6XcHD7PhE7kUrpTmBgWqoistBg6i74D8u3vh5NSpvCZQcBjtUNr8bQ/TOJ+ut6C29/3JsFNNwvgyoH3a45n/6mUId5gx+TJf7AvU4WyqGq9tPwa1CqCsTKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YeOwEJxk; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781623409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r1AASZfTRVbzLt5I/0GBJdZ/bjP6ci4PfAYJuRBn4WE=;
	b=YeOwEJxks2Y+yzoR8Zm/EULHkAO6LLedGfg+8LgjeMxsAr1SaxgAyECDY79tvGOiYIapQX
	IFItW53Y5F2Anxln/QiHQuw5tZ9a5c8IBfQCZEEgl54gV8RNwe7jjj22GniMEIwECyO9NX
	qN2qVyBQTRf9yYqi5LLPHEzhVGlvY6c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-YOZ8QqoZNdCi67PK60bP_g-1; Tue,
 16 Jun 2026 11:23:22 -0400
X-MC-Unique: YOZ8QqoZNdCi67PK60bP_g-1
X-Mimecast-MFC-AGG-ID: YOZ8QqoZNdCi67PK60bP_g_1781623400
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42A251954B17;
	Tue, 16 Jun 2026 15:23:19 +0000 (UTC)
Received: from [10.22.81.159] (unknown [10.22.81.159])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 12209180059C;
	Tue, 16 Jun 2026 15:23:14 +0000 (UTC)
Message-ID: <c61c7925-b9e7-4a6f-82e2-398849ad9f27@redhat.com>
Date: Tue, 16 Jun 2026 11:23:14 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cgroup/cpuset: rebind mm mempolicy to effective_mems,
 not mems_allowed
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Gregory Price <gourry@gourry.net>
Cc: Farhad Alemi <farhad.alemi@berkeley.edu>,
 Andrew Morton <akpm@linux-foundation.org>, Farhad Alemi <falemi@asu.edu>,
 Yury Norov <ynorov@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, stable@vger.kernel.org
References: <CA+0ovCg05rUk1-3k2ysdxmbcER8aG-wVh9SSTrrbp6LPWpPHYA@mail.gmail.com>
 <CA+0ovCgfHJHv5d1mzapWWvF-LhjppzDX8NPPLvCPZxPKg8RiYw@mail.gmail.com>
 <8d3b4561-92cd-4ebc-8462-5fb0fd659e8a@kernel.org>
 <ai_IHvyptWPcTD0y@gourry-fedora-PF4VCD3F>
 <70f486ce-5ef6-4d72-8cc3-7086f4eea930@redhat.com>
 <c1495b1b-9dee-4cd5-ac8e-eeb7a2d968ed@redhat.com>
 <51eafe6c-6622-479b-b391-6d3ff9350e75@kernel.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <51eafe6c-6622-479b-b391-6d3ff9350e75@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17002-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david@kernel.org,m:gourry@gourry.net,m:farhad.alemi@berkeley.edu,m:akpm@linux-foundation.org,m:falemi@asu.edu,m:ynorov@nvidia.com,m:joshua.hahnjy@gmail.com,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:ying.huang@linux.alibaba.com,m:apopple@nvidia.com,m:linux@rasmusvillemoes.dk,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:stable@vger.kernel.org,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[berkeley.edu,linux-foundation.org,asu.edu,nvidia.com,gmail.com,intel.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,kvack.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 74479691213

On 6/16/26 2:59 AM, David Hildenbrand (Arm) wrote:
> On 6/16/26 05:43, Waiman Long wrote:
>> On 6/15/26 10:26 PM, Waiman Long wrote:
>>> On 6/15/26 5:38 AM, Gregory Price wrote:
>>>> All interactions between mempolicy and cpuset are horrible and
>>>> confusing.  Much like Lorenzo's anon_vma work, I have to keep
>>>> notes on how this whole thing doesn't just spew SIGBUS constantly.
>>>>
>>>> The short answer is: mempolicy is advisory and cpuset is strictly
>>>> followed - in a dispute cpuset wins... except for file backed memory,
>>>> then everyon loses and nothing is consistent.
>>> That is what I believe why mpol_rebind_mm() a bit differently from the others
>>> and it is historically done this way a long time ago before cgroup v2.
>>>
>>> For cgroup v1, mems_allowed can't be empty or you can't put any task into the
>>> cpuset. Also effective_mems is the same as mems_allowed. cgroup v2 is quite
>>> different in how it handles memory nodes and CPUs. Users can isn't forced to
>>> set mems_allowed and cpus_allowed as effective_mems and effective_cpus will
>>> inherit parent version if mems_allowed and cpus_allowed are not set. IOW,
>>> effective_mems will never be empty. Yes, it is a bug with the introduction of
>>> cpuset v2 that we should have replaced mems_allowed by effective_mems at that
>>> time. With v2, effective_mems should contain only online nodes. The only
>>> exception is during the short transition period when a memory node hotunplug
>>> operation is in progress when a write to cpuset.mems is happening at the same
>>> time. With v1, it is theoretically possible that none of the nodes in
>>> mems_allowed is online.
>>>
>>> The reason why I am suggesting to use cs->effective_mems to keep the old
>>> cgroup v1 behavior. If the consensus is to use the output of
>>> guarantee_online_mems() for mpol_rebind_mm(), I will not be against that but
>>> it will be a slight change in user-visible behavior.
>> BTW, I still prefer the v2 patch. If it is decided we should use the
>> guarantee_online_mems() value instead, it will have to be a separate patch with
>> changes in the relevant documentation like Documentation/admin-guide/cgroup-v1/
>> cpuset.rst.
> newmems is "obviously" correct, so I really don't see why we should add
> something that needs half a page of text to explain why it is fine -- if newmems
> just does the trick?
>
> Please enlighten me.

Yes, taking newmems is a reasonable choice and there are pros and cons 
with each options. My focus is more on not changing how v1 cpuset 
behaves as it is well defined in the v1 cpusets.rst file:

     Requests by a task, using the sched_setaffinity(2) system call to
     include CPUs in its CPU affinity mask, and using the mbind(2) and
     set_mempolicy(2) system calls to include Memory Nodes in its memory
     policy, are both filtered through that task's cpuset, filtering out any
     CPUs or Memory Nodes not in that cpuset.  The scheduler will not
     schedule a task on a CPU that is not allowed in its cpus_allowed
     vector, and the kernel page allocator will not allocate a page on a
     node that is not allowed in the requesting task's mems_allowed vector.

v2, OTOH, is more vague as to what setting cpuset.mems will mean and we 
generally follow what v1 is doing, but we have more leeway of what we 
can do.

Using newmems will make the above text not totally correct. At least the 
offline memory nodes will be filtered out which will not be utilized by 
the task when the offline node becomes online. That is why I am saying 
that we will have to correct the documentation if we want to make this 
change.

Cheers,
Longman


