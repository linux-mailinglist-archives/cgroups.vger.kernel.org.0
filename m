Return-Path: <cgroups+bounces-15671-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id f6eWH+ZJ/WmUaAAAu9opvQ
	(envelope-from <cgroups+bounces-15671-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 08 May 2026 04:26:46 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1644F0BAB
	for <lists+cgroups@lfdr.de>; Fri, 08 May 2026 04:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0516301CFB4
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2026 02:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FC11EB5C2;
	Fri,  8 May 2026 02:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQd0BM76"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B4E2F8E97
	for <cgroups@vger.kernel.org>; Fri,  8 May 2026 02:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778207202; cv=none; b=bkGtoGzBjjZZlp8S33VPN9SyYsvmbmTWPyDIBK9rHIa8Uzf7KUpovtjoWiwu38WdLxn80FG0x8L5RWuYIRmIlHWKlFZ6d7o7+Lz7+bLeSoDJl9tg4vSUadwlzvosNlSVUicmhx6X9LMutRqufVaYReZAHxjRhwpW1JNlkZbKrTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778207202; c=relaxed/simple;
	bh=6/RSalBHI0pfI6AbtPBYxQtCmMkyokNiv6ItsHzwFg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sMWJFY0JOOxUjzrmiZ529kGNjBBDGBbr/xEsEcEzKVN11nVA9WOjMKQ3dbCsWOB9A7GHiur4OPp6XQW+BFzumlMYVvljNMqJ9OmvZpWjjhhSFIKn0/prG7OHqlAKmFucblaUfRi0FeiIxEYnpQQpyFNPrHB9ajTExA/v8fZk0+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BQd0BM76; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778207200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3U2igDBUZJtz/ZfFX4rmmix0sPx+03wNhxS/hhCrnU=;
	b=BQd0BM766YwWP+6W4R6wB7l8B2RcmCS2i+7ZykhgQDITuu/Tw401+jR87r4XSPEWxpVwV2
	9FcfbouZCu5ylDqbn24ZQ3LYfW2OmJH7TLbMWfMXT6m0/f1hLtUhnJt/yiTlVjA3qLGle5
	KVtJSzoAb5SSsGKLeP5zmuYVkNkEqQw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-oVi7TPr5NjuwY388fNUnuA-1; Thu,
 07 May 2026 22:26:36 -0400
X-MC-Unique: oVi7TPr5NjuwY388fNUnuA-1
X-Mimecast-MFC-AGG-ID: oVi7TPr5NjuwY388fNUnuA_1778207194
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99280180034C;
	Fri,  8 May 2026 02:26:33 +0000 (UTC)
Received: from [10.2.16.15] (unknown [10.2.16.15])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 803F418004A3;
	Fri,  8 May 2026 02:26:27 +0000 (UTC)
Message-ID: <ff904e7f-60bd-40ce-818e-b03b47a79e6f@redhat.com>
Date: Thu, 7 May 2026 22:26:26 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cgroup/cpuset: reset DL migration state on
 can_attach() failure
To: Chen Ridong <chenridong@huaweicloud.com>,
 Guopeng Zhang <zhangguopeng@kylinos.cn>, Tejun Heo <tj@kernel.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Gabriele Monaco <gmonaco@redhat.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20260507103310.35849-1-zhangguopeng@kylinos.cn>
 <20260507103310.35849-2-zhangguopeng@kylinos.cn>
 <6410d11c-1d8a-4e72-ac22-43058027b304@redhat.com>
 <5d69e8bb-c925-4de2-8d50-0880b23864e0@huaweicloud.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <5d69e8bb-c925-4de2-8d50-0880b23864e0@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: CD1644F0BAB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-15671-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Action: no action


On 5/7/26 10:14 PM, Chen Ridong wrote:
>
> On 2026/5/7 22:31, Waiman Long wrote:
>> On 5/7/26 6:33 AM, Guopeng Zhang wrote:
>>> cpuset_can_attach() accumulates temporary SCHED_DEADLINE migration
>>> state in the destination cpuset while walking the taskset.
>>>
>>> If a later task_can_attach() or security_task_setscheduler() check
>>> fails, cgroup_migrate_execute() treats cpuset as the failing subsystem
>>> and does not call cpuset_cancel_attach() for it. The partially
>>> accumulated state is then left behind and can be consumed by a later
>>> attach, corrupting cpuset DL task accounting and pending DL bandwidth
>>> accounting.
>>>
>>> Reset the pending DL migration state before returning from those
>>> per-task failure paths.
>>>
>>> Fixes: 2ef269ef1ac0 ("cgroup/cpuset: Free DL BW in case can_attach() fails")
>>> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
>>> ---
>>>    kernel/cgroup/cpuset.c | 8 ++++++--
>>>    1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index e3a081a07c6d..ae41736399a1 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -3029,12 +3029,12 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>>>        cgroup_taskset_for_each(task, css, tset) {
>>>            ret = task_can_attach(task);
>>>            if (ret)
>>> -            goto out_unlock;
>>> +            goto out_reset_dl_data;
>>>              if (setsched_check) {
>>>                ret = security_task_setscheduler(task);
>>>                if (ret)
>>> -                goto out_unlock;
>>> +                goto out_reset_dl_data;
>>>            }
>>>              if (dl_task(task)) {
>>> @@ -3070,6 +3070,10 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>>>         * changes which zero cpus/mems_allowed.
>>>         */
>>>        cs->attach_in_progress++;
>>> +    goto out_unlock;
>>> +
>>> +out_reset_dl_data:
>>> +    reset_migrate_dl_data(cs);
>>>    out_unlock:
>>>        mutex_unlock(&cpuset_mutex);
>>>        return ret;
>> I would prefer the likely success path be a straight line instead of doing a
>> goto. IOW, move out_reset_dl_data below return. Other than that, this patch
>> looks good to me.
>>
> I've read the code and found several places that call reset_migrate_dl_data(cs).
>
> I think it would be better to call reset_migrate_dl_data(cs) only when we
> encounter an error, for example:
>
> ```
> static int cpuset_can_attach(struct cgroup_taskset *tset)
> {
> ...
> out_unlock:
> 	if (ret)
> 		reset_migrate_dl_data(cs);
> 	mutex_unlock(&cpuset_mutex);
> 	return ret;
> }
> ```
> After that, no other places would need to call reset_migrate_dl_data(cs), right?
>
Yes, that should work too.

Cheers,
Longman


