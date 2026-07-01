Return-Path: <cgroups+bounces-17427-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jelZNn55RWo8AwsAu9opvQ
	(envelope-from <cgroups+bounces-17427-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 01 Jul 2026 22:33:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4042B6F17AF
	for <lists+cgroups@lfdr.de>; Wed, 01 Jul 2026 22:33:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=TCg4vsWY;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17427-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17427-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC818303EF5C
	for <lists+cgroups@lfdr.de>; Wed,  1 Jul 2026 20:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF1E2D0605;
	Wed,  1 Jul 2026 20:30:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E0E347514
	for <cgroups@vger.kernel.org>; Wed,  1 Jul 2026 20:30:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782937848; cv=none; b=efY18nslvhAoDeR6k6euG1c/QnXc9rdeNm0tJNX08WcrqQiNsI0KElcMnAuQ0WZR7UPds4o1R5goGQLJRTUMhJV4xfekf9Frpgi9cRo4pqQZ3OZGAcY+N6qDPQoO2jP+Mlg+9JZtIbwB+pSBELAUHLTbe3A+21sy0DH5XTSBuU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782937848; c=relaxed/simple;
	bh=wKpkyg2rj5Bbgk6AEbRgRm8ERuS54oR0GxIAL83Q7U4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Avp8e0imtx0gAH5636qxbRVX+ne/0kH4VKmwb3TYOgaTHmSJkvwV4XMCavo10g6Ae9pJd/wdM24Rb0vujrYhzkTPnJ6+2UUFYdI4kIaPBfjm9U8n4+/kzNOeNmTCFn+UXH1aQBvvSO9yIGmZu/ICZsG9zk4p9bFs2NoGdZx6i6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TCg4vsWY; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782937846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X/tArGLFi8BdH+snXh7UUnvSHk84IWILjNGqMvVoWlU=;
	b=TCg4vsWYYISIfpVLkcIeqAIGAOdKwUJXPZXgb/Bk5S0VeUDquiIonTMczPiG9ksy8vyoNe
	3RMDC8gOT7YXkzWw1ONQs1gfohLlHKxqjZZaPnLgMm78a0nptJ6w9wddKErM4chil5EIKG
	aAsyw1+QsaMl5QvjyUe2qPAj02l/L/4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-dc30iPoUNP-CKPzFP4s-MQ-1; Wed,
 01 Jul 2026 16:30:42 -0400
X-MC-Unique: dc30iPoUNP-CKPzFP4s-MQ-1
X-Mimecast-MFC-AGG-ID: dc30iPoUNP-CKPzFP4s-MQ_1782937840
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20B131933358;
	Wed,  1 Jul 2026 20:30:40 +0000 (UTC)
Received: from [10.2.16.170] (unknown [10.2.16.170])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EFE5218007E7;
	Wed,  1 Jul 2026 20:30:36 +0000 (UTC)
Message-ID: <eef00e6d-8947-4028-addd-ebfe82036445@redhat.com>
Date: Wed, 1 Jul 2026 16:30:35 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-next v9 08/11] cgroup/cpuset: Move
 mpol_rebind_mm/cpuset_migrate_mm() calls inside cpuset_attach_task()
To: Ridong Chen <ridong.chen@linux.dev>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Aaron Tomlin <atomlin@atomlin.com>,
 Guopeng Zhang <guopeng.zhang@linux.dev>
References: <20260630033344.352702-1-longman@redhat.com>
 <20260630033344.352702-9-longman@redhat.com>
 <33151a98-3d3d-4a11-9919-2bf38aa83f76@linux.dev>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <33151a98-3d3d-4a11-9919-2bf38aa83f76@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:juri.lelli@redhat.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-17427-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4042B6F17AF

On 6/30/26 10:14 PM, Ridong Chen wrote:
>> @@ -3203,28 +3208,60 @@ static void cpuset_attach_task(struct cpuset 
>> *cs, struct task_struct *task)
>>        */
>>       WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
>>   +    if (cpuset_v2() && !attach_ctx.mems_updated)
>> +        return;
>> +
>>       cpuset_change_task_nodemask(task, &attach_ctx.nodemask_to);
>>       cpuset1_update_task_spread_flags(cs, task);
>> +
>> +    if ((task != task->group_leader) ||
>> +        (!is_memory_migrate(cs) && !attach_ctx.mems_updated))
>> +        return;
>> +
>
> Nit.
>
> IIUC, the !is_memory_migrate(cs) check may be unnecessary. Previously, 
> placing this condition outside could prevent an unnecessary loop, but 
> in its current position, it appears redundant.
>
>     if (task != task->group_leader ||
>         !attach_ctx.mems_updated)

You are right. The is_memory_migrate(cs) check is unnecessary. Will 
remove it in the next version.

Cheers,
Longman


