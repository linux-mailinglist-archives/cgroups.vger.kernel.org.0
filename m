Return-Path: <cgroups+bounces-15364-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qD8DODCQ5WlNlgEAu9opvQ
	(envelope-from <cgroups+bounces-15364-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 04:32:16 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7584264C6
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 04:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D3233033F9B
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 02:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830AB27CB35;
	Mon, 20 Apr 2026 02:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvhQglRg"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B0E1E7C12
	for <cgroups@vger.kernel.org>; Mon, 20 Apr 2026 02:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776652304; cv=none; b=sI4JZMFAdKF1WuFSc9jeSM5sGuvOaN0p0pvEZT/GQPBrQ4nNPmkznog9bW7D9IKGJrDG1xlbDuL9WqANnjBo/MK7yYAzx1Hl4J9a+/FYZ+OGZYOZl3YLf2Cqai0ZmDVRijvooYcQjJL0hOO/s9mHAVuiY9335vs8uRvWKHolTS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776652304; c=relaxed/simple;
	bh=DoyTcXiVhC4VzaYJoR1An3TVuYGcevQxqFWrh/u+CR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DmhuILzkAUadKI3ykMrxTd6HnHRpe7TmieOHPW4JAruYEbCuRoA0N2Nj8khbnKe3ALER0yA+X5MSYIgpaXouWppXIQWejvFShywUO3NoMbr9tWV+GpGNklX98uaG6bWrVh18usaF4slqFdiVi0tz9d6axF6XJS/nDi8X5yb9zuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RvhQglRg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776652301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/kqlOzpHd/914Eoinh5TNTEwvLrAk8vIipzwkCQFsoo=;
	b=RvhQglRgRu/XfUofTWjYJBdiJJfTJGMaVyurh93jDCD5ULSWgvT0oT294Oo6H4RimzIJLP
	/gDLGX+r8kYYvq5kwGraXzEZHWA+ts04z+pDGTC8E2t9s79GTafrEbLAvAmRUaLaeoy8ar
	2WDocSy1c+4F3DhDCXjrQsZaxB3hU8Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-N5bVM-GLO02DMoiUT5V9ZQ-1; Sun,
 19 Apr 2026 22:31:37 -0400
X-MC-Unique: N5bVM-GLO02DMoiUT5V9ZQ-1
X-Mimecast-MFC-AGG-ID: N5bVM-GLO02DMoiUT5V9ZQ_1776652295
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60D461956080;
	Mon, 20 Apr 2026 02:31:34 +0000 (UTC)
Received: from [10.22.80.68] (unknown [10.22.80.68])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 081FA3000C20;
	Mon, 20 Apr 2026 02:31:30 +0000 (UTC)
Message-ID: <e0fea6ec-397c-40a6-9300-a3529a3d1167@redhat.com>
Date: Sun, 19 Apr 2026 22:31:29 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cgroup/cpuset: record DL BW alloc CPU for attach
 rollback
To: Guopeng Zhang <zhangguopeng@kylinos.cn>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
 changwoo@igalia.com, shuah@kernel.org, chenridong@huaweicloud.com,
 Juri Lelli <juri.lelli@redhat.com>, Valentin Schneider
 <vschneid@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: cgroups@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260417033742.40793-1-zhangguopeng@kylinos.cn>
 <20260417033742.40793-2-zhangguopeng@kylinos.cn>
 <fd28bea7-83bd-48b7-8c3c-ad44474b8b5b@redhat.com>
 <6aca2465-1ea7-417a-beb8-e385fa3902bf@kylinos.cn>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <6aca2465-1ea7-417a-beb8-e385fa3902bf@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-15364-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 8D7584264C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/19/26 10:21 PM, Guopeng Zhang wrote:
>
> 在 2026/4/18 2:51, Waiman Long 写道:
>> On 4/16/26 11:37 PM, Guopeng Zhang wrote:
>>> cpuset_can_attach() allocates DL bandwidth only when migrating
>>> deadline tasks to a disjoint CPU mask, but cpuset_cancel_attach()
>>> rolls back based only on nr_migrate_dl_tasks. This makes the DL
>>> bandwidth alloc/free paths asymmetric: rollback can call dl_bw_free()
>>> even when no dl_bw_alloc() was done.
>>>
>>> Rollback also needs to undo the reservation against the same CPU/root
>>> domain that was charged. Record the CPU used by dl_bw_alloc() and use
>>> that state in cpuset_cancel_attach(). If no allocation happened,
>>> dl_bw_cpu stays at -1 and rollback skips dl_bw_free(). If allocation
>>> did happen, bandwidth is returned to the same CPU/root domain.
>>>
>>> Successful attach paths are unchanged. This only fixes failed attach
>>> rollback accounting.
>>>
>>> Fixes: 2ef269ef1ac0 ("cgroup/cpuset: Free DL BW in case can_attach() fails")
>>> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
> ...
>> The patch looks correct to me.
>>
>> Reviewed-by: Waiman Long <longman@redhat.com>
> Hi Waiman,
>
> Thank you for the review and for the Reviewed-by.
>> However, I have a DL bandwidth accounting question unrelated to this patch that I would like the scheduler people to clarify. The allocation of additional DL BW is based on the condition
>>
>>          if (!cpumask_intersects(oldcs->effective_cpus, cs->effective_cpus)) {
>>
>> IOW, additional DL BW will need to be allocated when the old and new cpuset doesn't overlap. However, they could still be in the same root domain. Does that mean we will be double counting it?
> I think you are right to call this out. Looking at the
> current logic, !cpumask_intersects(oldcs->effective_cpus, cs->effective_cpus)
> does not obviously guarantee that the migration is crossing into a different
> root domain. If the old and new cpusets are disjoint but still belong to the
> same root domain, it does look possible that we reserve bandwidth on the
> destination side without a corresponding subtraction from the source side.
> I will try to reproduce that configuration and follow up with results.
>> Looking from the other side, the root domain may have enough DL BW for the task migration, but the subset of CPUs in the cpuset itself may not have enough total DL BW to host all the DL tasks to be migrated, is that a problem?
> my current understanding is that the DL bandwidth
> accounting is done at root-domain granularity, not at arbitrary cpuset-subset
> granularity.
That is my understanding too.
> That also seems consistent with
> Documentation/scheduler/sched-deadline.rst, which says that deadline tasks
> cannot have a CPU affinity mask smaller than the root domain they are created
> on, and that a restricted CPU set should be achieved by creating a restricted
> root domain with cpuset.

A root domain should be created by creating cpuset root partition for v2 
or using the cpuset.cpu_exclusive flag in v1.

What is listed in the documentation is the ideal case, but users may not 
strictly follow the rule.

Cheers,
Longman

>
> So if a cpuset is only a subset inside a larger root domain, it does not seem
> to get an independent DL bandwidth limit of its own. If that understanding is
> correct, then the smaller cpuset not having enough bandwidth by itself would
> be a limitation of that model rather than something this code checks
> separately. I'd appreciate confirmation from the scheduler folks on that
> point.
>
> Thanks,
> Guopeng
>> Cheers,
>> Longman


