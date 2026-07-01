Return-Path: <cgroups+bounces-17429-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VIAeC0CFRWroBQsAu9opvQ
	(envelope-from <cgroups+bounces-17429-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 01 Jul 2026 23:23:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDDC6F1CF1
	for <lists+cgroups@lfdr.de>; Wed, 01 Jul 2026 23:23:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=RRL2BL54;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17429-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17429-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37A0C30F4A48
	for <lists+cgroups@lfdr.de>; Wed,  1 Jul 2026 21:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A94F3B895E;
	Wed,  1 Jul 2026 21:17:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFC133B6D3
	for <cgroups@vger.kernel.org>; Wed,  1 Jul 2026 21:17:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782940628; cv=none; b=NpV1vNjHlFg1/+zJxSsANhQLxWvzH+7J1CXMSzOGkmZfHTVT3kJ1wqQckDPQg5+WRvN6ov3Q+KAzwcHgo5pvH7YlczoBg3Cv9k7rNgpkoS9ufaQfo8E9iGQt+VdArco48h8HmbOjW8rUuSDovjiW+Ggaf+rHEiAXEqIZDUGc92U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782940628; c=relaxed/simple;
	bh=z7sD9qm1NrouLVBCMAJ5P949KnGJiopF5DHVhKLrWGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rB0xDkCGXmerdXlKdvRkat0XmRI9s46QbtbrwMq5PwPw2rYGTvmZDGuILtKgEM8jtraxVOOY3sdp4hdnka3s2SVJMvo/EbWAdrAHBrw5ld1TpPV4jCcgSCCcIEYfU7F/DwRgHw/q+/8Y5gJ3IeXfl3tIt4NYzAkhcGNo7gJR0Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RRL2BL54; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782940624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5rK4YoeHXeXS+tnBBON6Vk/DP3tREC5UQRlEL6C7Tas=;
	b=RRL2BL54q3Oj28hg3t2+cKb3gNtaNyDvUk5ZvW063OS3296hsZkqELyf5vIKY2M/U/AXyC
	04NLvMDac9lyaJR6jfqSKBZIV4+mYkLa+5fWpipIwYdzA3BWdtGL146bFNBaALDBsRqchP
	Vtnh0LS3eCOMLRp/xtzyTy7hQlBMJpA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-m2yWXDg5PdK8Mb4coGFcKQ-1; Wed,
 01 Jul 2026 17:17:03 -0400
X-MC-Unique: m2yWXDg5PdK8Mb4coGFcKQ-1
X-Mimecast-MFC-AGG-ID: m2yWXDg5PdK8Mb4coGFcKQ_1782940621
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 251E9188E6DA;
	Wed,  1 Jul 2026 21:17:01 +0000 (UTC)
Received: from [10.2.16.170] (unknown [10.2.16.170])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E212B195E483;
	Wed,  1 Jul 2026 21:16:57 +0000 (UTC)
Message-ID: <c5aa5b20-754d-4216-b7f3-1327b6926513@redhat.com>
Date: Wed, 1 Jul 2026 17:16:56 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-next v9 10/11] cgroup/cpuset: Support multiple destination
 cpusets for cpuset_*attach()
To: Ridong Chen <ridong.chen@linux.dev>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Aaron Tomlin <atomlin@atomlin.com>,
 Guopeng Zhang <guopeng.zhang@linux.dev>
References: <20260630033344.352702-1-longman@redhat.com>
 <20260630033344.352702-11-longman@redhat.com>
 <e4608f5d-d569-4796-b0f6-55956a6b341c@linux.dev>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <e4608f5d-d569-4796-b0f6-55956a6b341c@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17429-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:juri.lelli@redhat.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7DDDC6F1CF1

On 6/30/26 10:51 PM, Ridong Chen wrote:
>
>
> On 6/30/2026 11:33 AM, Waiman Long wrote:
>> The only case where the cgroup_taskset structure requires task migration
>> to multiple cpusets is when enabling a cpuset controller in cgroup v2
>> where the newly created child cpusets inherits the same effective CPUs
>> and memory nodes from the parent. In that case, task migration can 
>> happen
>> directly with no update to tasks' CPU and memory nodes assignment and no
>> further work needed from the cpuset side except updating 
>> nr_deadline_tasks
>> when DL tasks are involved and setting old_mems_allowed in the child
>> cpusets.
>>
>> Do that by tracking all the destination cpusets with a new dst_cs_head
>> singly linked list. The reset_migrate_dl_data() function is integrated
>> into clear_attach_data() so that it can be used for both source and
>> destination cpusets.
>>
>> It is assumed that a given cpuset cannot be both a source and a
>> destination cpuset. If such condition happens or when there are multiple
>> destination cpusets with CPU or memory nodes changes, the current code
>> will not handle it correctly. So it will print a warning and fail the
>> attach operation in these unexpected cases as we will have to enhance 
>> the
>> code to support this if such use cases are valid and not coding errors.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset-internal.h |   1 +
>>   kernel/cgroup/cpuset.c          | 115 ++++++++++++++++++++------------
>>   2 files changed, 72 insertions(+), 44 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset-internal.h 
>> b/kernel/cgroup/cpuset-internal.h
>> index e7d010661fd3..d1161b0a3d85 100644
>> --- a/kernel/cgroup/cpuset-internal.h
>> +++ b/kernel/cgroup/cpuset-internal.h
>> @@ -149,6 +149,7 @@ struct cpuset {
>>        * For linking impacted cpusets during an attach operation.
>>        */
>>       struct llist_node attach_node;
>> +    bool attach_source;
>>         /* partition root state */
>>       int partition_root_state;
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index b201f4ba18b6..1591d6dca66a 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -366,10 +366,12 @@ static struct {
>>       bool cpus_updated;
>>       bool mems_updated;
>>       bool task_work_queued;
>> +    bool many_dest_cs;    /* Have many destination cpusets */
>>       struct cpuset *old_cs;    /* Source cpuset */
>>       nodemask_t nodemask_to;
>>   } attach_ctx;
>>   static LLIST_HEAD(src_cs_head);
>> +static LLIST_HEAD(dst_cs_head);
>
> This looks a lot like the 'struct list_head mg_src_preload_node' and
> 'struct list_head mg_dst_preload_node' in struct css_set. Is there a
> better way to reuse those instead of adding a separate tracking list 
> here? 

The cgroup_mgctx is a cgroup internal data structure which is not 
exposed to individual controllers. Sharing it will have some risks if it 
is accidentally modified.

Conversion of css_set iteration to cpuset iteration is a bit more 
complicated as 2 or more css_sets may point to the same cpuset. So we 
still have to track if a cpuset has been visited before.

It is doable, but I doubt it is worth the effort.

Cheers,
Longman


