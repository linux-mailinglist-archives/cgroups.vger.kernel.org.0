Return-Path: <cgroups+bounces-17295-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FMtPOpBwPWqs3AgAu9opvQ
	(envelope-from <cgroups+bounces-17295-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 20:16:48 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EED0F6C8224
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 20:16:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="aND/E+wE";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17295-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17295-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2FB3F300A679
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 18:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215FA30C168;
	Thu, 25 Jun 2026 18:16:44 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DF530C637
	for <cgroups@vger.kernel.org>; Thu, 25 Jun 2026 18:16:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782411403; cv=none; b=ICn1+VK5VtsjC+wC/LxfacRElf+GodUSjOd2lDdOSClVXRKM+lJnR5OcGuoQQFgEqtodCMVXseBOwSfYdxGYCq6hcfNSIUpJSUObeYvCB755D3QNfqlPiJNMpeS2gj29uBJwAog2T3Z82hwomlwgMCtNZr+lcX/o4nQ51uVj3XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782411403; c=relaxed/simple;
	bh=OOzYeFeHgx2NjYa2M4QmT8jR1s5xc1DsWFy6DBpy7Qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u8QJGraRuHXwdPNm/ViWrWKVS+Cba26gPAQf23ZBhITOEv2yVCNv9ayGMYM1TDyU0hMFcHiN6KOnMtK5hrLlFsCRtdV4odPFsd6EOC/P8Fy3ilfMDthrnIuZqp6gcBDam8zBmla4Dpe8phWaLvNehS9JECaK/+05dbpUvOofUPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aND/E+wE; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782411400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nezZbQ4mDiIGlaszHg3bTDzadhMguHC8uLssvhbipdQ=;
	b=aND/E+wEXx25L6KGNc2qx8pIP0Sziq99Qjz0wLNZ5Po4P3YE4+YX59WL6g1XCvStYJbiyF
	WMwKEh8jCBdefoelF91Xd3Zc0mNLbG23yNXaTTcT8lhzjy7uIznopegtxQFfaPkTB465mk
	mcJ67uFlYQTAtgireKz28mCBoEYF7/Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-wkerWP-6Plea7xxa4o-Tgg-1; Thu,
 25 Jun 2026 14:16:37 -0400
X-MC-Unique: wkerWP-6Plea7xxa4o-Tgg-1
X-Mimecast-MFC-AGG-ID: wkerWP-6Plea7xxa4o-Tgg_1782411394
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 12A1E195419B;
	Thu, 25 Jun 2026 18:16:33 +0000 (UTC)
Received: from [10.2.16.32] (unknown [10.2.16.32])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0A23231D2;
	Thu, 25 Jun 2026 18:16:28 +0000 (UTC)
Message-ID: <5ec570e1-6a4d-4fa4-8827-c586902d99d9@redhat.com>
Date: Thu, 25 Jun 2026 14:16:27 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/9] cgroup/cpuset: Prevent race between task attach
 and cpuset state change
To: Ridong Chen <ridong.chen@linux.dev>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Li Zefan <lizefan@huawei.com>,
 Farhad Alemi <farhad.alemi@berkeley.edu>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aaron Tomlin <atomlin@atomlin.com>, Guopeng Zhang <guopeng.zhang@linux.dev>,
 Gregory Price <gourry@gourry.net>, David Hildenbrand <david@kernel.org>
References: <20260621032816.1806773-1-longman@redhat.com>
 <20260621032816.1806773-4-longman@redhat.com>
 <44da924b-f3a1-4ef8-9113-37d6d11b8c1b@linux.dev>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <44da924b-f3a1-4ef8-9113-37d6d11b8c1b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17295-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:lizefan@huawei.com,m:farhad.alemi@berkeley.edu,m:akpm@linux-foundation.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,m:gourry@gourry.net,m:david@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EED0F6C8224

On 6/21/26 10:21 PM, Ridong Chen wrote:
>
>
> On 6/21/2026 11:28 AM, Waiman Long wrote:
>> Commit e44193d39e8d ("cpuset: let hotplug propagation work wait for
>> task attaching") was introduced to let hotplug operation to wait
>> until the completion of task attaching operation. However, it is
>> still possible that the states of the source or destination cpuset
>> can be changed between the cpuset_can_attach() call and the subsequent
>> cpuset_attach()/cpuset_cacnel_attach() call.
>>
>> As a result, data gathered during cpuset_can_attach() cannot be reliably
>> used in the subsequent cpuset_attach()/cpuset_cacnel_attach()
>> call at all. Make the task attach operation more robust
>> and allow the sharing of data between cpuset_can_attach() and
>> cpuset_attach()/cpuset_cacnel_attach() by making cpuset_write_resmask()
>> and cpuset_partition_write() wait for the completion of task attach
>> and set the attach_in_progress flag in the source cpuset as well.
>>
>> The comments about validate_change() are no longer valid as it won't
>> be called at all if an attach operation is in progress. So the comments
>> can be removed.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c | 28 ++++++++++++++++++++--------
>>   1 file changed, 20 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index a1c8890d3519..65d095dcada1 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -3080,11 +3080,8 @@ static int cpuset_can_attach(struct 
>> cgroup_taskset *tset)
>>       cs->dl_bw_cpu = cpu;
>>     out_success:
>> -    /*
>> -     * Mark attach is in progress.  This makes validate_change() fail
>> -     * changes which zero cpus/mems_allowed.
>> -     */
>>       cs->attach_in_progress++;
>> +    oldcs->attach_in_progress++;
>
> I only see oldcs->attach_in_progress being incremented here — the 
> matching decrement seems to land in a later patch. That makes this one 
> unbalanced on its own (the count would leak, and a later write to the 
> source cpuset would block on the new wait_event()), so it's not 
> bisect-safe.
>
> Let's either keep the patch self-contained or fold it into the patch 
> that adds the decrement.

Yes, it should have a matching decrement there. Anyway, I am going to 
revamp this patch to make attach_in_progress flag global instead of per 
cpuset. This is to make sure that a task attach operation will not race 
with any cpuset control file write operation.

Cheers,
Longman


