Return-Path: <cgroups+bounces-16445-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xZNsDefRGWo+zQgAu9opvQ
	(envelope-from <cgroups+bounces-16445-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 19:50:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A02E1606D6B
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 19:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59C5D35E7EB7
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 16:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14623F4110;
	Fri, 29 May 2026 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iD5uPtDy"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3663ECBCD
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 16:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073659; cv=none; b=AzHijC7sdaWCGiJHzksglhByxD57aUGdGXTUbAvwCQeUyk+A8oLmfcv1xZaTgrIRRlZ+nCkVGHiJbgdguWu6NXSKdBfFjAIVocK2qPA96mMlcd5bVNeXv0x6WWa3IJK5XqPptvZkQmI3KTIFNlUayfa5EVCHrO3TmoKkWzG1j+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073659; c=relaxed/simple;
	bh=X4c1AQ/13fJA9yTH0l3vh5hsOhddV/u9kJrFo0wwLPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ys82XgFyKBE5bEcqNTzFEQ7lThfl0XKy+Q8UkJEoAMF5tqKcaGlBHmt8P81LUGewZMnjCoXbHGIcWxaUhhG+3gTyzDa1WV75C4dL6BY/KocH89ITiUt169S6/3vW44TY9jDaWxU5DToLnTIPRUjBIpdarmLHSnrW53P+3md40kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iD5uPtDy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780073657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/18byCJ8pKpRqK6FCiRZK63gTEGitO2VkGffGOE/pis=;
	b=iD5uPtDy0dVyWPFUs0D6cHQK/0a1n+Pk8FQJUcYMG8ZferFQ0vbkYC4/JfOHRd3STCGLFu
	QOuk0MzpzpvKjBXRpKy6d8+H7jZUd+7f2qH0i4YE/OL+UXu46avTFzprhQRo8R6t8HZVy+
	qECWkx6yEzmZBPPjxaYgQltGyo4en9E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-cszVQbxlN42GGg9dkSY3_Q-1; Fri,
 29 May 2026 12:54:14 -0400
X-MC-Unique: cszVQbxlN42GGg9dkSY3_Q-1
X-Mimecast-MFC-AGG-ID: cszVQbxlN42GGg9dkSY3_Q_1780073652
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F0C4195609D;
	Fri, 29 May 2026 16:54:10 +0000 (UTC)
Received: from [10.22.64.54] (unknown [10.22.64.54])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6B05C180034E;
	Fri, 29 May 2026 16:54:08 +0000 (UTC)
Message-ID: <5233706f-8a48-4893-9d04-250093363604@redhat.com>
Date: Fri, 29 May 2026 12:54:07 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-next v3 3/5] cgroup/cpuset: Made cpuset_attach_old_cs
 track task group leaders
To: Guopeng Zhang <guopeng.zhang@linux.dev>,
 Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aaron Tomlin <atomlin@atomlin.com>, Ridong Chen <ridong.chen@linux.dev>
References: <20260527153800.1557449-1-longman@redhat.com>
 <20260527153800.1557449-4-longman@redhat.com>
 <a3f84c49-96cd-4da3-838e-11c72990bc06@linux.dev>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <a3f84c49-96cd-4da3-838e-11c72990bc06@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16445-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A02E1606D6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/26 10:19 PM, Guopeng Zhang wrote:
>
> 在 2026/5/27 23:37, Waiman Long 写道:
>> There are two possible ways that migration of tasks from multiple source
>> cpusets to a target cpuset can happen. Either a multithread application
>> with threads in different cpusets is wholely moved to a new cpuset
>> or disabling of v2 cpuset controller will move all the tasks in child
>> cpusets to the parent cpuset.
>>
>> In the former case, t is the mm setting of the group leader that really
>> matters. So cpuset_attach_old_cs should track the oldcs of the thread
>> leader. In the latter case, effective_mems of child cpusets must always
>> be a subset of the parent. So no real page migration will be necessary
>> no matter which child cpuset is selected as cpuset_attach_old_cs.
>>
>> IOW, cpuset_attach_old_cs should be updated to match the latest task
>> group leader in cpuset_can_attach().
>>
>> Suggested-by: Ridong Chen <ridong.chen@linux.dev>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 4457c4f11fce..b233a71f9b7c 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -2967,6 +2967,20 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>>   /*
>>    * cpuset_can_attach() and cpuset_attach() specific internal data
>>    * Protected by cpuset_mutex
>> + *
>> + * The cpuset_attach_old_cs is used mainly by cpuset_migrate_mm() tp get the
>> + * old_mems_allowed value. There are two ways that many-to-one cpuset migration
>> + * can happen:
> Hi Waiman,
>
> I applied this series locally and ran some of my test cases. I didn't
> observe any issue so far.
>
> While doing a static/checkpatch pass, I noticed a few minor issues in
> patches 3, 4 and 5. They are all non-functional nits.
>
> For this patch, I only noticed a couple of small wording/typo nits in
> the new comment:
>
> s/tp get/to get/

Thanks for the review, will fix the typo in the next version.

Cheers,
Longman


