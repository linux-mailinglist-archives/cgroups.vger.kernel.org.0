Return-Path: <cgroups+bounces-16988-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dyR5H+S0MGriWQUAu9opvQ
	(envelope-from <cgroups+bounces-16988-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 04:28:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBAA68B797
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 04:28:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=A9eP23dR;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16988-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16988-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02AB4315729E
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 02:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012D13C1986;
	Tue, 16 Jun 2026 02:26:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9323C0A17
	for <cgroups@vger.kernel.org>; Tue, 16 Jun 2026 02:26:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781576787; cv=none; b=H4L3gDd9D7sheiXyW0U1ESvKY7hnpNJq2sV7XqqWwFpinCiToQLW/4KKL+aDgEWFxRCY2qkdXv5V4/fsNjOyyyxDWPXtIgY8yWvED4SEU1o4ok/lb5hQ7tdY1+ncAsmofgk/e2oo+hjIhW9n3sBLykDaJil+l4cg3uTr3qWVSIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781576787; c=relaxed/simple;
	bh=rXDiLHONRdX5xgJKk59Q2h6sS+qsbt8Lalr/InWKZS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c0cwJ+PR4kCZCfB3ftOXC2Yjt44o559ZNjqLmJRe0l4nkJ2csCIdp03QA5M1OatIQlFoiRQ+wX7ZNvRbU+mAOnN/GZ19fWHa9KPrYQ6WO78un55RxRH86SPNuU2u/zzEPTe+aUZ0tvX4LXMu2uilrylRx4mW7sal7AAEPImtsPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A9eP23dR; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781576783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eb9pUs+M+9+MDnB/3Yt1uwyfMWxmUaDhKWEfbwTi46Y=;
	b=A9eP23dRjlccSEUtrvX+WTPxP2Cy4NDvrynd8DcdI23arEgD8lw49Jcwc0D/S7VlAuQ4xI
	dqIhwP5/jGEvrhQckr+Fqz1uvkiDKEcndwUxE1Bal1WRCL6vA8Ppydka07x1jHd2BVFl/O
	kSrWt/BjRd8ZuJq0ZlZXftSebfgBix0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-5arF6-6bNoeyheyT1mfSjg-1; Mon,
 15 Jun 2026 22:26:16 -0400
X-MC-Unique: 5arF6-6bNoeyheyT1mfSjg-1
X-Mimecast-MFC-AGG-ID: 5arF6-6bNoeyheyT1mfSjg_1781576774
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C9B71800655;
	Tue, 16 Jun 2026 02:26:13 +0000 (UTC)
Received: from [10.22.89.117] (unknown [10.22.89.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5920C1800347;
	Tue, 16 Jun 2026 02:26:10 +0000 (UTC)
Message-ID: <70f486ce-5ef6-4d72-8cc3-7086f4eea930@redhat.com>
Date: Mon, 15 Jun 2026 22:26:09 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cgroup/cpuset: rebind mm mempolicy to effective_mems,
 not mems_allowed
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
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ai_IHvyptWPcTD0y@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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
	TAGGED_FROM(0.00)[bounces-16988-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: DBBAA68B797


On 6/15/26 5:38 AM, Gregory Price wrote:
> On Mon, Jun 15, 2026 at 10:08:51AM +0200, David Hildenbrand (Arm) wrote:
>> On 6/14/26 15:25, Farhad Alemi wrote:
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -2649,7 +2649,7 @@ void cpuset_update_tasks_nodemask(struct cpuset *cs)
>>>
>>>   		migrate = is_memory_migrate(cs);
>>>
>>> -		mpol_rebind_mm(mm, &cs->mems_allowed);
>>> +		mpol_rebind_mm(mm, &cs->effective_mems);
>> God this is confusing.
>>
> All interactions between mempolicy and cpuset are horrible and
> confusing.  Much like Lorenzo's anon_vma work, I have to keep
> notes on how this whole thing doesn't just spew SIGBUS constantly.
>
> The short answer is: mempolicy is advisory and cpuset is strictly
> followed - in a dispute cpuset wins... except for file backed memory,
> then everyon loses and nothing is consistent.

That is what I believe why mpol_rebind_mm() a bit differently from the 
others and it is historically done this way a long time ago before 
cgroup v2.

For cgroup v1, mems_allowed can't be empty or you can't put any task 
into the cpuset. Also effective_mems is the same as mems_allowed. cgroup 
v2 is quite different in how it handles memory nodes and CPUs. Users can 
isn't forced to set mems_allowed and cpus_allowed as effective_mems and 
effective_cpus will inherit parent version if mems_allowed and 
cpus_allowed are not set. IOW, effective_mems will never be empty. Yes, 
it is a bug with the introduction of cpuset v2 that we should have 
replaced mems_allowed by effective_mems at that time. With v2, 
effective_mems should contain only online nodes. The only exception is 
during the short transition period when a memory node hotunplug 
operation is in progress when a write to cpuset.mems is happening at the 
same time. With v1, it is theoretically possible that none of the nodes 
in mems_allowed is online.

The reason why I am suggesting to use cs->effective_mems to keep the old 
cgroup v1 behavior. If the consensus is to use the output of 
guarantee_online_mems() for mpol_rebind_mm(), I will not be against that 
but it will be a slight change in user-visible behavior.

Cheers, Longman

>> Naturally I wonder: Why are we not using "task->mems_allowed" (maybe cs vs. tsk
>> was the original bug?), which is effectively just newmems?
>>
> Short answer: task->mems_allowed is protected by the task lock and we
> don't hold the task lock for a foreign task (not-current) over mm
> operations.
>
> Long answer: Reasons and "Stop looking at the spaghetti, it's going to
> break"
>
> ~Gregory
>


