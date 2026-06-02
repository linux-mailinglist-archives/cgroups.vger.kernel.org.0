Return-Path: <cgroups+bounces-16580-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C56hJQojH2pNhwAAu9opvQ
	(envelope-from <cgroups+bounces-16580-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 20:38:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6FC631256
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 20:38:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=EnRBHIvZ;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16580-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-16580-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B62A63045B23
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 18:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A66395AFC;
	Tue,  2 Jun 2026 18:36:08 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECF3392C2A
	for <cgroups@vger.kernel.org>; Tue,  2 Jun 2026 18:36:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780425368; cv=none; b=YzYfwhsZescpACgohbDqP5l7KIW8K0s8Y6f+zN+Gu3+x1vYbO5TghWrVC9Zw3upfArDq5S1D5u4QKphNnUWQUjZ7jqxTfP7lxqj0oC2xRCqtIiyChr/MyZvYhdQ/jc3ba1ms9Z+61CTAhGoo1eLthuVlxFFA4tCKXj4bMSUihiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780425368; c=relaxed/simple;
	bh=WBRGJqbDuxzI1+qpaCHFv2S54mA9SK60VrABtSH0+hY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TkC9gNZhbxWAZRbmeIAb8ea/+D22eZpEo1SQmXEz1hlV93QUy7wRQ7ozEb9/bteWyne2/LZu5rPH3/0d0rE5YuLUXZl+d8vG8LzWMLARrKjBEqjedBovdivSTeQwcaCvy7OHU6nUZwExTf90j8dAo687jB6Lc77S086Qc/nhX3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EnRBHIvZ; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780425366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MwaRdfqXrI3vN3iHNQ/gRirahnbZgUMzvDHYxKX77jg=;
	b=EnRBHIvZ/xhNfqwVFG+UEJc3Bxqh5ROTjKmaxPQxRs7ZaeQZdzTN44Vu6Vm8VSQLvJdSBi
	wbnHwovYq8gtZIu3jK7NDLy5GxCN/4L86Ckdj+jkvkpzOUmn9cUdpWRV/z7JYAZheMSEox
	8mtMunoq7Bz0IjuBXqCtV/dT+nVml7U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-AwjyA7UQMpCWaZTOT43MqQ-1; Tue,
 02 Jun 2026 14:36:02 -0400
X-MC-Unique: AwjyA7UQMpCWaZTOT43MqQ-1
X-Mimecast-MFC-AGG-ID: AwjyA7UQMpCWaZTOT43MqQ_1780425361
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03B6018005BA;
	Tue,  2 Jun 2026 18:36:01 +0000 (UTC)
Received: from [10.22.80.32] (unknown [10.22.80.32])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E45F819560A7;
	Tue,  2 Jun 2026 18:35:59 +0000 (UTC)
Message-ID: <08466148-5f8d-4a0e-9d7e-eba2afea286c@redhat.com>
Date: Tue, 2 Jun 2026 14:35:59 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Remove Chen Ridong as a cpust reviewer for
 now
To: Ridong Chen <ridong.chen@linux.dev>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260602024422.249458-1-longman@redhat.com>
 <ah6LAfpMsdPLun2_@localhost.localdomain>
 <69b82f73-e89a-4271-a494-3c4d5684b7ac@linux.dev>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <69b82f73-e89a-4271-a494-3c4d5684b7ac@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16580-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[redhat.com:s=mimecast20190719];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:mkoutny@suse.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,huaweicloud.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC6FC631256


On 6/2/26 4:13 AM, Ridong Chen wrote:
>
> On 2026/6/2 15:51, Michal Koutný wrote:
>> +Cc: ridong.chen@linux.dev
>>
>> (This looks like their new address.)
>>
> Hi all,
>
> Thank you, Michal.
>
> Apologies for the email issue. I'm currently changing my company, The
> ridong.chen@linux.dev email is valid.

I am glad that you are showing up again. I was wondering where you had been.

Cheers,
Longman

>
>
>> On Mon, Jun 01, 2026 at 10:44:22PM -0400, Waiman Long <longman@redhat.com> wrote:
>>> Chen Ridong has contributed quite a lot of fixes and cleanups to the
>>> cpuset code. Unfortunately, his email address is now no longer valid. So
>>> remove him as a cpuset reviewer until he shows up again or someone else
>>> volunteers to take his place.
>>>
>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>> ---
>>>   MAINTAINERS | 1 -
>>>   1 file changed, 1 deletion(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 74c86cf9bc65..c7a7126ea406 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -6526,7 +6526,6 @@ F:	include/linux/blk-cgroup.h
>>>   
>>>   CONTROL GROUP - CPUSET
>>>   M:	Waiman Long <longman@redhat.com>
>>> -R:	Chen Ridong <chenridong@huaweicloud.com>
>>>   L:	cgroups@vger.kernel.org
>>>   S:	Maintained
>>>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
>>> -- 
>>> 2.54.0
>>>


