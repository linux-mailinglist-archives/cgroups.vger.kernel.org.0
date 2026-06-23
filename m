Return-Path: <cgroups+bounces-17174-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O9gcL6QgOmrI1wcAu9opvQ
	(envelope-from <cgroups+bounces-17174-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 07:59:00 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB196B4520
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 07:59:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=DZhzIxK1;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17174-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17174-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65524301724C
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 05:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBB43AB27B;
	Tue, 23 Jun 2026 05:58:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2D33446A7
	for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 05:58:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782194328; cv=none; b=tC+sajpMV5nAU3w+FQXwciCY3+oXP7DRywGuZizrSpf1Zo1L87EZwYJewNrJv4/PO0JtHZH6OhcAf+2jRJ1zdGF51Z9T94rOC34Xp9Qfwr3+w1N2m9qFwhtXEzHWmOr2ZUGZYIW+PfZ+cFDrT0LXpJbLYkUyjC2HuGHIjqMma+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782194328; c=relaxed/simple;
	bh=AlU4gtFEKhlfSxIcTjRL4e5qmxfg+fDinLPn8byO1XM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rG1qVqYRuN8UCNsCQxTtTp3n9+iQdZbqVXe9jB97YaiHoUDo/D6vfCkvCpjFu6NHE8oRpEdB8Jr0eLF+V33u49Z8x1I3O9Gw8sTeSd51Bluv1OiCRwcg5DUGBwE2/cmjePm+wuPQ/6BASbVYccvCw7vOAcrr/u89QOPYigpah3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DZhzIxK1; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782194325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IRi8GfAYniLHbjGZFFwKyffd57VQQpHVn1aSTa2bqtc=;
	b=DZhzIxK1s6Ee9WgNA7KnsAqoYwZjDqkTPUyiNzPap+UHQvs3t13LiRcx87zS+Fk+mBVlVB
	d4yR+Qe4KdXGLyK9El0awg7sqMJ0jUNVRju1byxjpxSl631dIHv2ErHZrWYxuvOg4w8p+Q
	cdbEWQ1/J85ms9FXC8oHf4EBcrtGkQA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-loA_pPl1MIKCMNAT0kst6g-1; Tue,
 23 Jun 2026 01:58:44 -0400
X-MC-Unique: loA_pPl1MIKCMNAT0kst6g-1
X-Mimecast-MFC-AGG-ID: loA_pPl1MIKCMNAT0kst6g_1782194322
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3E29180064A;
	Tue, 23 Jun 2026 05:58:41 +0000 (UTC)
Received: from [10.2.16.35] (unknown [10.2.16.35])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A040D1956041;
	Tue, 23 Jun 2026 05:58:39 +0000 (UTC)
Message-ID: <74bd7410-7c57-41dc-911e-99969282893e@redhat.com>
Date: Tue, 23 Jun 2026 01:58:38 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cgroup/cpuset: Avoid unnecessary cpus & mems update
 in cpuset_hotplug_update_tasks()
To: Ridong Chen <ridong.chen@linux.dev>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260622224509.1927419-1-longman@redhat.com>
 <e24b8145-7a67-4cc0-8ba0-24bd89243c04@linux.dev>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <e24b8145-7a67-4cc0-8ba0-24bd89243c04@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17174-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4EB196B4520

On 6/22/26 9:14 PM, Ridong Chen wrote:
>
>
> On 6/23/2026 6:45 AM, Waiman Long wrote:
>> As reported by sashiko [1], cpuset_hotplug_update_tasks() may perform
>> unnecessary task iteration and updating of tasks' CPU and node masks
>> when mems_allowed and/or cpus_allowed are not set in cpuset v2. It is
>> due to the fact that the temporary new_cpus and new_mems masks do not
>> inherit parent's effective_cpus/mems when they are empty which is the
>> expected behavior for cpuset v2 since commit 4ec22e9c5a90 ("cpuset:
>> Enable cpuset controller in default hierarchy").
>>
>> Fix that and avoid unnecessay work by adding the empty mask checks and
>> inheriting the parent's versions if empty.
>>
>> [1] 
>> https://sashiko.dev/#/patchset/20260621032816.1806773-1-longman%40redhat.com
>>
>> Fixes: 4ec22e9c5a90 ("cpuset: Enable cpuset controller in default 
>> hierarchy")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index aff86acea701..bc0207fd6e57 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -3925,6 +3925,14 @@ static void cpuset_hotplug_update_tasks(struct 
>> cpuset *cs, struct tmpmasks *tmp)
>>       compute_effective_cpumask(&new_cpus, cs, parent);
>>       nodes_and(new_mems, cs->mems_allowed, parent->effective_mems);
>>   +    if (is_in_v2_mode()) {
>> +        /* Inherit parent's effective_cpus/mems if empty */
>> +        if (cpumask_empty(&new_cpus))
>> +            cpumask_copy(&new_cpus, parent->effective_cpus);
>> +        if (nodes_empty(new_mems))
>> +            new_mems = parent->effective_mems;
>> +    }
>> +
>>       if (!tmp || !cs->partition_root_state)
>>           goto update_tasks;
>
> I noticed that compute_effective_cpumask(...) is called in several 
> places, so I think the logic should be consolidated into that function.
>
> ```
> static void compute_effective_cpumask(struct cpumask *new_cpus,
>                       struct cpuset *cs, struct cpuset *parent)
> {
>     cpumask_and(new_cpus, cs->cpus_allowed, parent->effective_cpus);
>     if (cpumask_empty(&new_cpus) && is_in_v2_mode())
>         cpumask_copy(&new_cpus, parent->effective_cpus);
> }
>
> ```
>
> Similarly, for new_mems, should we introduce a dedicated helper like 
> compute_effective_nodemask? The same fallback logic is needed in 
> update_nodemasks_hier:
>
>
> ```
> static void update_nodemasks_hier(struct cpuset *cs, nodemask_t 
> *new_mems)
> {
> ...
>         bool has_mems = nodes_and(*new_mems, cp->mems_allowed, 
> parent->effective_mems);
>
>         /*
>          * If it becomes empty, inherit the effective mask of the
>          * parent, which is guaranteed to have some MEMs.
>          */
>         if (is_in_v2_mode() && !has_mems)
>             *new_mems = parent->effective_mems;
> ...
> ```
>
Yes, that makes sense. Will adopt this approach in the next version.

Cheers,
Longman


