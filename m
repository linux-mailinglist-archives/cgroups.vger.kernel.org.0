Return-Path: <cgroups+bounces-17296-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9t0sNB5xPWrD3AgAu9opvQ
	(envelope-from <cgroups+bounces-17296-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 20:19:10 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB506C825A
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 20:19:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=hEmR++Ge;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17296-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17296-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01790300CC0E
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 18:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337DC2FD69E;
	Thu, 25 Jun 2026 18:18:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1122F8E94
	for <cgroups@vger.kernel.org>; Thu, 25 Jun 2026 18:18:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782411536; cv=none; b=YvpzlXM0AUWibFUuS6LqNyMbbUcUHF47dOguHjr5WSNPP37JS0th8heeAQl4Yp4kUektDR7z2rniWUnnkVdS5LPmBRaCmBMksnOQZY8lyPfJO12jpGMtVxiqeGWjbKJ0kbV3vBUxMOZAkiuOMDWFiBtvgwytaDh2EFS1edrRdlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782411536; c=relaxed/simple;
	bh=PfNy1rle71zK0YcN6a3rkLX3su7rye4jq6ABNsd2sIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9W4Z+dLFK/maQ7l0c9npyRIaDzFiS5g2+x6xdixWaWl1vI/lQmCF81kHJpk6Qrm6RanGr6TzWYBeYbtFFT/fDO+9OUyTVYs+yeOfB3DbcnNENFEeQn0HBVNU4TQ79FFLpJNOrmOt6salAqe2290gCMTtDA/a4nUCedzVy1Gpww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hEmR++Ge; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782411533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hScmiXGWJjPZr4rujHlu/N8G+rZVXp8iM/jDPItK+l0=;
	b=hEmR++GeUxudvWuuUd04rEPwKR8OperHLut8RtqJrCebiOAJ/xFDMgdmjkJ+XIiC9LW8fF
	rXkq1nzGJePIkcTLEqtPrOM5EziUua3QJ4fPfa7556ejYJjKhVulLom4MUJSAimgAK3tBw
	+2zbK8WMPnkzh8VIrVkYAX/TdRYHyOE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-4Hrwvy78NkStwW-EcjuCzg-1; Thu,
 25 Jun 2026 14:18:49 -0400
X-MC-Unique: 4Hrwvy78NkStwW-EcjuCzg-1
X-Mimecast-MFC-AGG-ID: 4Hrwvy78NkStwW-EcjuCzg_1782411527
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39CFF1873118;
	Thu, 25 Jun 2026 18:18:47 +0000 (UTC)
Received: from [10.2.16.32] (unknown [10.2.16.32])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 52A871955F70;
	Thu, 25 Jun 2026 18:18:43 +0000 (UTC)
Message-ID: <7d0ba942-7fd7-404d-a194-82dd05051520@redhat.com>
Date: Thu, 25 Jun 2026 14:18:42 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/9] cgroup/cpuset: Move
 mpol_rebind_mm/cpuset_migrate_mm() calls inside cpuset_attach_task()
To: Ridong Chen <ridong.chen@linux.dev>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Li Zefan <lizefan@huawei.com>,
 Farhad Alemi <farhad.alemi@berkeley.edu>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aaron Tomlin <atomlin@atomlin.com>, Guopeng Zhang <guopeng.zhang@linux.dev>,
 Gregory Price <gourry@gourry.net>, David Hildenbrand <david@kernel.org>
References: <20260621032816.1806773-1-longman@redhat.com>
 <20260621032816.1806773-8-longman@redhat.com>
 <e8fb50d3-0831-4caf-b4e4-2af94ac86263@linux.dev>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <e8fb50d3-0831-4caf-b4e4-2af94ac86263@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17296-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:lizefan@huawei.com,m:farhad.alemi@berkeley.edu,m:akpm@linux-foundation.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,m:gourry@gourry.net,m:david@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2EB506C825A

On 6/21/26 10:48 PM, Ridong Chen wrote:
>
>
> On 6/21/2026 11:28 AM, Waiman Long wrote:
>> The cpuset_attach_task() was introduced in commit 42a11bf5c543
>> ("cgroup/cpuset: Make cpuset_fork() handle CLONE_INTO_CGROUP properly")
>> to enable the CLONE_INTO_CGROUP flag of clone(2) to behave more like
>> moving a task from one cpuset into another one. That commits didn't
>> move the mpol_rebind_mm() and cpuset_migrate_mm() calls for group leader
>> into cpuset_attach_task().
>>
>> When the CLONE_INTO_CGROUP flag is used without CLONE_THREAD, the new
>> task is its own group leader. So it is still not equivalent to moving
>> task between cpusets in this case. Make CLONE_INTO_CGROUP behaves
>> more close to cpuset_attach() by moving the mpol_rebind_mm() and
>> cpuset_migrate_mm() calls inside cpuset_attach_task(). As a result,
>> the following static variables will have to be updated in cpuset_fork().
>>   - cpuset_attach_old_cs
>>   - attach_cpus_updated
>>   - attach_mems_updated
>>   - queue_task_work
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c | 105 ++++++++++++++++++++++++-----------------
>>   1 file changed, 62 insertions(+), 43 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 0375dae26d0b..511afb077e2d 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -2981,8 +2981,13 @@ static int update_prstate(struct cpuset *cs, 
>> int new_prs)
>>   /*
>>    * cpuset_can_attach() and cpuset_attach() specific internal data
>>    * Protected by cpuset_mutex
>> + *
>> + * The attach_cpus_updated/attach_mems_updated flags are set in either
>> + * cpuset_attach() or cpuset_fork() and used in cpuset_attach_task().
>>    */
>>   static struct cpuset *cpuset_attach_old_cs;
>> +static bool attach_cpus_updated;
>> +static bool attach_mems_updated;
>>     /*
>>    * Check to see if a cpuset can accept a new task
>> @@ -3157,9 +3162,12 @@ static void cpuset_cancel_attach(struct 
>> cgroup_taskset *tset)
>>    */
>>   static cpumask_var_t cpus_attach;
>>   static nodemask_t cpuset_attach_nodemask_to;
>> +static bool queue_task_work;
>
> There are more and more of these standalone state variables now, and 
> it's getting harder to maintain. Could we group them into a struct and 
> manage them together rather than keep adding globals?
>
> Just like:
>
> ```
> struct cpuset_attach_ctx {
>     struct cpuset     *old_cs;
>     struct llist_head src_cs, dst_cs;
>     bool              cpus_updated, mems_updated, queue_work;
>     nodemask_t        nodemask_to;
> };
> ```

Yes, that makes sense. Will incorporate that in the next version.

Cheers,
Longman


