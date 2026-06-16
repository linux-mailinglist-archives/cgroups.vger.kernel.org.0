Return-Path: <cgroups+bounces-16990-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DGZ5AnDGMGoRXQUAu9opvQ
	(envelope-from <cgroups+bounces-16990-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 05:43:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EB868BBA8
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 05:43:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=QR45GNRz;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16990-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16990-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15F623059903
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 03:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B3A3C4572;
	Tue, 16 Jun 2026 03:43:41 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15267258EE9
	for <cgroups@vger.kernel.org>; Tue, 16 Jun 2026 03:43:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781581421; cv=none; b=rb6RNsgA1pjkbWltVwrK4itJuO7+Q0oMJnsszJvIVjMLPKyE9KaS9xXoUD6n80WlP6dYTPKjU4Le6skoLo4iEDDTGMSwSL1hBlCDkEC3LzNKIUUGHp6+fFgl2pQu+QTT07MWeRihZuta/M/cQBiKeoOl0yBC03x8YrZX1A+nqig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781581421; c=relaxed/simple;
	bh=BTDFS4gTaHVWoh6hwS/AQaRpOJQVHiGArGDKeBKLm50=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=odamlp8fwgPtcqjSwVpgt2+jCNMm21ak9ODDSxBw0c8/8NbOTYDlnTbFc8Z61Ll8ZrsAT90Xjg0EtzfTiTYMAD0+84TNZxOGCKp5b99y0qibBVbSHcUhTRB5WuTPGVfBnNRgXcPZH79bU2ZLqX6CkH3f6brYVs29kCET3h7l7Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QR45GNRz; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781581417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LmtNVQPuL89Pr71FqVptC4fXxzFFeWwBvfXAYcEAgjQ=;
	b=QR45GNRzzQSz39wL3sxE7796iwlHJ/lej79YYpvtOfKMnW0yBKG1vOh7OO24XugKGiexsh
	yYb6YUwoNNNOi+UjXDMBfQRYXxr0tuHrWPEdHS11brQEIq+RGyzbAXS3DxUPDvED4jTs4H
	UoS/nzYurNatazjXgaxTbN4zHml7Jko=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-u_4hzlSgOOONoVCrChthMQ-1; Mon,
 15 Jun 2026 23:43:34 -0400
X-MC-Unique: u_4hzlSgOOONoVCrChthMQ-1
X-Mimecast-MFC-AGG-ID: u_4hzlSgOOONoVCrChthMQ_1781581411
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D69C91955DE3;
	Tue, 16 Jun 2026 03:43:30 +0000 (UTC)
Received: from [10.22.89.117] (unknown [10.22.89.117])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2A51C19560AB;
	Tue, 16 Jun 2026 03:43:26 +0000 (UTC)
Message-ID: <c1495b1b-9dee-4cd5-ac8e-eeb7a2d968ed@redhat.com>
Date: Mon, 15 Jun 2026 23:43:26 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cgroup/cpuset: rebind mm mempolicy to effective_mems,
 not mems_allowed
From: Waiman Long <longman@redhat.com>
To: Gregory Price <gourry@gourry.net>,
 "David Hildenbrand (Arm)" <david@kernel.org>
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
Content-Language: en-US
In-Reply-To: <70f486ce-5ef6-4d72-8cc3-7086f4eea930@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16990-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gourry@gourry.net,m:david@kernel.org,m:farhad.alemi@berkeley.edu,m:akpm@linux-foundation.org,m:falemi@asu.edu,m:ynorov@nvidia.com,m:joshua.hahnjy@gmail.com,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:ying.huang@linux.alibaba.com,m:apopple@nvidia.com,m:linux@rasmusvillemoes.dk,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:stable@vger.kernel.org,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 45EB868BBA8

On 6/15/26 10:26 PM, Waiman Long wrote:
>
> On 6/15/26 5:38 AM, Gregory Price wrote:
>> On Mon, Jun 15, 2026 at 10:08:51AM +0200, David Hildenbrand (Arm) wrote:
>>> On 6/14/26 15:25, Farhad Alemi wrote:
>>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>>> --- a/kernel/cgroup/cpuset.c
>>>> +++ b/kernel/cgroup/cpuset.c
>>>> @@ -2649,7 +2649,7 @@ void cpuset_update_tasks_nodemask(struct 
>>>> cpuset *cs)
>>>>
>>>>           migrate = is_memory_migrate(cs);
>>>>
>>>> -        mpol_rebind_mm(mm, &cs->mems_allowed);
>>>> +        mpol_rebind_mm(mm, &cs->effective_mems);
>>> God this is confusing.
>>>
>> All interactions between mempolicy and cpuset are horrible and
>> confusing.  Much like Lorenzo's anon_vma work, I have to keep
>> notes on how this whole thing doesn't just spew SIGBUS constantly.
>>
>> The short answer is: mempolicy is advisory and cpuset is strictly
>> followed - in a dispute cpuset wins... except for file backed memory,
>> then everyon loses and nothing is consistent.
>
> That is what I believe why mpol_rebind_mm() a bit differently from the 
> others and it is historically done this way a long time ago before 
> cgroup v2.
>
> For cgroup v1, mems_allowed can't be empty or you can't put any task 
> into the cpuset. Also effective_mems is the same as mems_allowed. 
> cgroup v2 is quite different in how it handles memory nodes and CPUs. 
> Users can isn't forced to set mems_allowed and cpus_allowed as 
> effective_mems and effective_cpus will inherit parent version if 
> mems_allowed and cpus_allowed are not set. IOW, effective_mems will 
> never be empty. Yes, it is a bug with the introduction of cpuset v2 
> that we should have replaced mems_allowed by effective_mems at that 
> time. With v2, effective_mems should contain only online nodes. The 
> only exception is during the short transition period when a memory 
> node hotunplug operation is in progress when a write to cpuset.mems is 
> happening at the same time. With v1, it is theoretically possible that 
> none of the nodes in mems_allowed is online.
>
> The reason why I am suggesting to use cs->effective_mems to keep the 
> old cgroup v1 behavior. If the consensus is to use the output of 
> guarantee_online_mems() for mpol_rebind_mm(), I will not be against 
> that but it will be a slight change in user-visible behavior. 

BTW, I still prefer the v2 patch. If it is decided we should use the 
guarantee_online_mems() value instead, it will have to be a separate 
patch with changes in the relevant documentation like 
Documentation/admin-guide/cgroup-v1/cpuset.rst.

Cheers,
Longman


