Return-Path: <cgroups+bounces-15093-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOi6DW1iyWlXxwUAu9opvQ
	(envelope-from <cgroups+bounces-15093-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 29 Mar 2026 19:33:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAE935359D
	for <lists+cgroups@lfdr.de>; Sun, 29 Mar 2026 19:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03A04303FAC4
	for <lists+cgroups@lfdr.de>; Sun, 29 Mar 2026 17:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA2037646C;
	Sun, 29 Mar 2026 17:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JgX4Irbr"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C29637CD53
	for <cgroups@vger.kernel.org>; Sun, 29 Mar 2026 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774805284; cv=none; b=EGMt4eKVukunbGVazvSFq8xDjz7XJ0ERDxksDYoqpFPJIlmDmb2jWMMDXolVH9slQk8YPtMnbMBOJbIyEqLFK9kwXoO39mJzQIlCJZeuEwXcy9Vpa7W5VTFhri1GkP7imqdM+UjgThb3BjoXVzCpcPRmbk0u16SWGKJ03r4z7M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774805284; c=relaxed/simple;
	bh=FBK16IFbceRoUPVqR007h8YWl7ntSE2Sz/VaT1hYlAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDaommzok8nvNYZ/cBR5uFHHWUHD5hnIW459HBvLd0axnzbHsDF0DceYlcccyfP9z9MXXxDdMdU9Z+VHiqZldNeJSF+KDQ+Ac8OvF40Nz/0cX7TSRedyY5QZOtyP022txpwXz9roOOebp2+MSRV+3Z32sJkkYLyRSGR2CR8QE+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JgX4Irbr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774805282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ai8AsVLXijVWDN/d10Bl+3Vl9B1BnDDB1K/ob97G5vc=;
	b=JgX4IrbrYRIM33FbEZdO+ynDMAuYwtkBKD8uAl7+JKLs1SB7+bfyS59S3fru2MsOcBY1/P
	cPvlAqScSasmfLXCcXoPmia9l8NLEaBVeBssRL6QZDGTOOEk2DSAQPz7Ukb+9KgiOhDTrs
	t1g8DbjLZgN9VNep2A73PeVma41m7Kg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-rFMsIPzqMO6rV2UZsusW9w-1; Sun,
 29 Mar 2026 13:27:56 -0400
X-MC-Unique: rFMsIPzqMO6rV2UZsusW9w-1
X-Mimecast-MFC-AGG-ID: rFMsIPzqMO6rV2UZsusW9w_1774805275
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B90FC1800344;
	Sun, 29 Mar 2026 17:27:54 +0000 (UTC)
Received: from [10.22.80.75] (unknown [10.22.80.75])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3376630001A1;
	Sun, 29 Mar 2026 17:27:52 +0000 (UTC)
Message-ID: <cc4caa18-b136-46da-aa8d-0820930b7868@redhat.com>
Date: Sun, 29 Mar 2026 13:27:52 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Skip security check for hotplug induced v1
 task migration
To: Chen Ridong <chenridong@huaweicloud.com>,
 Chen Ridong <chenridong@huawei.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260327201546.2463644-1-longman@redhat.com>
 <d3c226f3-dd92-40a3-95a4-3e9e5f0adeb4@huaweicloud.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <d3c226f3-dd92-40a3-95a4-3e9e5f0adeb4@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15093-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cpuset_hotplug_test.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8BAE935359D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/27/26 9:39 PM, Chen Ridong wrote:
>
> On 2026/3/28 4:15, Waiman Long wrote:
>> When a CPU hot removal causes a v1 cpuset to lose all its CPUs, the
>> cpuset hotplug handler will schedule a work function to migrate tasks
>> in that cpuset with no CPU to its parent to enable those tasks to
>> continue running.
>>
>> If a strict security policy is in place, however, the task migration
>> may fail when security_task_setscheduler() call in cpuset_can_attach()
>> returns a -EACCESS error. That will mean that those tasks will have
>> no CPU to run on. The system administrators will have to explicitly
>> intervene to either add CPUs to that cpuset or move the tasks elsewhere
>> if they are aware of it.
>>
>> This problem was found by a reported test failure in the LTP's
>> cpuset_hotplug_test.sh. Fix this problem by treating this special case
>> as an exception to skip the setsched security check as it is initated
>> internally within the kernel itself instead of from user input. With that
>> patch applied, the cpuset_hotplug_test.sh test can be run successfully
>> without failure.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Should we add a Fixes tag?

The call to security_task_setscheduler() was added a long time ago and 
the cpuset v1 task migration is more like a corner case that shouldn't 
normally happen. So I don't want to put a fixes tag that will force a 
backport to earlier stable releases.

Cheers,
Longman


