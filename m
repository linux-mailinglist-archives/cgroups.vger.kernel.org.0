Return-Path: <cgroups+bounces-17098-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RCyMDHFZN2r6MgcAu9opvQ
	(envelope-from <cgroups+bounces-17098-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 21 Jun 2026 05:24:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A26E6AA123
	for <lists+cgroups@lfdr.de>; Sun, 21 Jun 2026 05:24:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Ql0NSVmN;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17098-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17098-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B03EE3011C57
	for <lists+cgroups@lfdr.de>; Sun, 21 Jun 2026 03:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE73B2D9796;
	Sun, 21 Jun 2026 03:24:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2051B17BB21
	for <cgroups@vger.kernel.org>; Sun, 21 Jun 2026 03:24:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782012267; cv=none; b=fIQGo2hImuH6NPHNoQ8BBEbmGESum+7cgbLRI91+k8eL2Kl7YQdghnpLQwe63j7h4GPIgAoWyl5bX8/HOcxSxxTm0RunHgkQPGLQxEvXr3K4GiEzG6TNgw/JxEs0+MV7ELvBgTmTc+3TRZX/x1+6pdE8rvITwkuho03DFqRc+9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782012267; c=relaxed/simple;
	bh=Y0Ba6yPSCo9zQjmVk6P93mv40CSzFhFf9lgURZqXbgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHhINEBVISNeCbQs7WgrAyDintTDO21UuNmdR5wHdzjLmW9t2g+qSddLgeBuPw6sVYHSqkGpjTxiBS6JsurdEPRTKJ0Sfo395PjAVmHGWYMjekmzuFkw7rsXmjfa8KreVLT88/UQG91Fnmq3GGn64Ll7+sFfkqFJ27u5ds17vM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ql0NSVmN; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782012265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Yu2mki38BefPDLre6bXeAKMaOu1RLSJX8hzP70eax4=;
	b=Ql0NSVmNNSKeQlb1dmm/fN0Zt4fyvV0VdkaA5z9ZHPPt1fg8F3E2DX5yenjzU3DdMhavMs
	Tu6J1lWo6ivjp0rZHkx/Jivr6aBVixe1URlLrAuYhg4OCkdLFBGLH59pgDFv81c6JCOoXE
	nHTC3sqd32SljTuw3jv9Q9l4/tBS7xE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-HmnhANAkPfSLuV-PbR185Q-1; Sat,
 20 Jun 2026 23:24:21 -0400
X-MC-Unique: HmnhANAkPfSLuV-PbR185Q-1
X-Mimecast-MFC-AGG-ID: HmnhANAkPfSLuV-PbR185Q_1782012259
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 448821956060;
	Sun, 21 Jun 2026 03:24:18 +0000 (UTC)
Received: from [10.22.88.8] (unknown [10.22.88.8])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AE5FA1686;
	Sun, 21 Jun 2026 03:24:14 +0000 (UTC)
Message-ID: <9d8b650d-6faa-425a-8db7-1e206cb25158@redhat.com>
Date: Sat, 20 Jun 2026 23:24:13 -0400
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
 <c61c7925-b9e7-4a6f-82e2-398849ad9f27@redhat.com>
 <38578aea-61c3-4328-aee9-8e7421672647@kernel.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <38578aea-61c3-4328-aee9-8e7421672647@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17098-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A26E6AA123

On 6/18/26 4:41 AM, David Hildenbrand (Arm) wrote:
> On 6/16/26 17:23, Waiman Long wrote:
>> On 6/16/26 2:59 AM, David Hildenbrand (Arm) wrote:
>>> On 6/16/26 05:43, Waiman Long wrote:
>>>> BTW, I still prefer the v2 patch. If it is decided we should use the
>>>> guarantee_online_mems() value instead, it will have to be a separate patch with
>>>> changes in the relevant documentation like Documentation/admin-guide/cgroup-v1/
>>>> cpuset.rst.
>>> newmems is "obviously" correct, so I really don't see why we should add
>>> something that needs half a page of text to explain why it is fine -- if newmems
>>> just does the trick?
>>>
>>> Please enlighten me.
>> Yes, taking newmems is a reasonable choice and there are pros and cons with each
>> options. My focus is more on not changing how v1 cpuset behaves as it is well
>> defined in the v1 cpusets.rst file:
>>
>>      Requests by a task, using the sched_setaffinity(2) system call to
>>      include CPUs in its CPU affinity mask, and using the mbind(2) and
>>      set_mempolicy(2) system calls to include Memory Nodes in its memory
>>      policy, are both filtered through that task's cpuset, filtering out any
>>      CPUs or Memory Nodes not in that cpuset.  The scheduler will not
>>      schedule a task on a CPU that is not allowed in its cpus_allowed
>>      vector, and the kernel page allocator will not allocate a page on a
>>      node that is not allowed in the requesting task's mems_allowed vector.
>>
>> v2, OTOH, is more vague as to what setting cpuset.mems will mean and we
>> generally follow what v1 is doing, but we have more leeway of what we can do.
>>
>> Using newmems will make the above text not totally correct. At least the offline
>> memory nodes will be filtered out which will not be utilized by the task when
>> the offline node becomes online. That is why I am saying that we will have to
>> correct the documentation if we want to make this change.
> So IIUC:
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 1335e437098e..cdfc615f35a5 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2645,7 +2645,13 @@ void cpuset_update_tasks_nodemask(struct cpuset *cs)
>   
>                  migrate = is_memory_migrate(cs);
>   
> -               mpol_rebind_mm(mm, &cs->mems_allowed);
> +               /*
> +                * For v1 we can have empty effective_mems, but we cannot
> +                * attach any tasks (see cpuset_can_attach_check()). For v2,
> +                * it's guaranteed to not be empty.
> +                */
> +               VM_WARN_ON_ONCE(nodes_empty(cs->effective_mems));
> +               mpol_rebind_mm(mm, &cs->effective_mems);
>                  if (migrate)
>                          cpuset_migrate_mm(mm, &cs->old_mems_allowed, &newmems);
>                  else

That is true, but I don't think we need a VM_WARN_ON_ONCE() here.

Cheers,
Longman

>


