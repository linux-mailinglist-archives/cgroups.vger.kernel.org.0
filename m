Return-Path: <cgroups+bounces-15371-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHaXCPkn5mnesgEAu9opvQ
	(envelope-from <cgroups+bounces-15371-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 15:19:53 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 844D042B8E4
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 15:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6852302D0B9
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 13:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E06C37EFED;
	Mon, 20 Apr 2026 13:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5q0wc1Y"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F0133C532
	for <cgroups@vger.kernel.org>; Mon, 20 Apr 2026 13:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690928; cv=none; b=nWep3IUNbqvVbqCJIb17WVJ0FQn6MnGobiiDKIOBZOeApDcy29/oJSqE4NrNMtK/5c7QVJbH3+YJLlUspSJOPCf7PpbYev3PKVu+Hn8fbeYnag4w0FQNWt6OY05JdQEVRDCoC5Qx+iwTW4F6CIIxIgju+5TA20T843HesdmmrTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690928; c=relaxed/simple;
	bh=ucTjGzMhw1V6mWoiooVi5/UfrwhZRLARgvL0ka9xZRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TeSz50OM+Zf3waorOd6+mLPRE7FW68GF/fYO638U3rFvgIBPy3KtDRrGRIAuR8qBvKkrr/Oc7YV5YlajFpRdeGMAhGWX/Pb8zRnDpYSFxDQImZmMq/6ak63vhKGGpoH6vVap+BdZ3Vj44q+3SDfGmeadMAfhoPR0KtoNYzpC6oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M5q0wc1Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776690925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jOu+46Glg68JCjkOj1rb6F9jQYHETkMBqrdXvpHIl2M=;
	b=M5q0wc1YViWLK10H5T4IkmSk1eELtaTkW6OTPAabIKicPsVbn0ToPcc3QqAN8mBOpyKipS
	3/r3Grb1sZqJuP+zTlX4YScdiynEKUKFY5ZWrdR4iwReVLmcIGrxmSLf4QdGgKAnYubm/v
	pcYCdAYM9EKPgcql69JHGFj3BUKzjdo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-66KRyUnfNa6LngdfR8GzTw-1; Mon,
 20 Apr 2026 09:15:23 -0400
X-MC-Unique: 66KRyUnfNa6LngdfR8GzTw-1
X-Mimecast-MFC-AGG-ID: 66KRyUnfNa6LngdfR8GzTw_1776690922
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 672FC19560B8;
	Mon, 20 Apr 2026 13:15:22 +0000 (UTC)
Received: from [10.22.65.81] (unknown [10.22.65.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0CDEC19560AB;
	Mon, 20 Apr 2026 13:15:20 +0000 (UTC)
Message-ID: <24785938-a7e3-4a76-9dcb-665e81b82cee@redhat.com>
Date: Mon, 20 Apr 2026 09:15:20 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Skip cpuset_top_mutex for cpuset.mems
 writes
To: Julian Sun <sunjunchao@bytedance.com>,
 Chen Ridong <chenridong@huaweicloud.com>, cgroups@vger.kernel.org
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
References: <20260418100220.3717207-1-sunjunchao@bytedance.com>
 <7249e345-8218-4232-9fc1-4109039a9aad@huaweicloud.com>
 <53e18c70-a670-47cd-ba17-2d6f1adde1c8@bytedance.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <53e18c70-a670-47cd-ba17-2d6f1adde1c8@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-15371-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bytedance.com:email]
X-Rspamd-Queue-Id: 844D042B8E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/26 12:24 AM, Julian Sun wrote:
> On 4/20/26 9:24 AM, Chen Ridong wrote:
>>
>>
>> On 2026/4/18 18:02, Julian Sun wrote:
>>> cpuset_top_mutex serializes regular cpuset writes against the
>>> housekeeping_update() path. That path has to drop cpus_read_lock() and
>>> cpuset_mutex before calling housekeeping_update(), while keeping the
>>> housekeeping cpumask update ordered against other cpuset writes.
>>>
>>> cpuset_write_resmask() currently takes cpuset_top_mutex for all
>>> resource-mask writes. This is broader than needed for cpuset.mems. The
>>> mems path updates nodemasks, task mems_allowed and mempolicy state, and
>>> may queue page migration work, but it does not change isolated CPUs,
>>> scheduler domains or housekeeping cpumasks.
>>>
>>
>> Hello,
>
> Hi, Thanks for your review.
>>
>> Has any regression been observed that prompted you to make this change?
>
> No regression has been observed.
>
> I sent this patch because I recently noticed the global 
> cpuset_top_mutex while looking at the cpuset locking. After checking 
> what it is used for, it looked like the cpuset.mems path does not need 
> to take it.

That change does introduce more complexity into the locking scheme. As 
cpuset code are not performance critical, we should only make this kind 
of change if there is some benefit other than a slight decrease in 
execution time by skipping a lock.

Cheers,
Longman

>
>>
>>> Add cpuset_mems_lock()/cpuset_mems_unlock() for FILE_MEMLIST. The new
>>> lock helper still takes cpus_read_lock() and cpuset_mutex because
>>> update_nodemask() can reach check_insane_mems_config(), which calls
>>> static_branch_enable_cpuslocked(). CPU mask writes keep using
>>> cpuset_full_lock().
>>>
>>> Record update_housekeeping and force_sd_rebuild on entry and warn if
>>> FILE_MEMLIST changes either value. If that warning ever fires, the mems
>>> path has gained a sched-domain or housekeeping side effect and must 
>>> stop
>>> using the lighter lock path.
>>>
>>> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
>>> ---
>>>   kernel/cgroup/cpuset.c | 40 ++++++++++++++++++++++++++++++++++++----
>>>   1 file changed, 36 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index 1335e437098e..5e0927ea71a9 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -331,6 +331,28 @@ void cpuset_full_unlock(void)
>>>       mutex_unlock(&cpuset_top_mutex);
>>>   }
>>>   +/*
>>> + * cpuset.mems writes cannot change isolated CPUs or sched domains. 
>>> Skip
>>> + * cpuset_top_mutex, but verify that the path leaves finalizer 
>>> state unchanged.
>>> + */
>>> +static void cpuset_mems_lock(bool *hk_update, bool *sd_rebuild)
>>> +{
>>> +    cpus_read_lock();
>>> +    mutex_lock(&cpuset_mutex);
>>> +
>>> +    *hk_update = update_housekeeping;
>>> +    *sd_rebuild = force_sd_rebuild;
>>> +}
>>> +
>>> +static void cpuset_mems_unlock(bool hk_update, bool sd_rebuild)
>>> +{
>>> +    WARN_ON_ONCE(update_housekeeping != hk_update);
>>> +    WARN_ON_ONCE(force_sd_rebuild != sd_rebuild);
>>> +
>>> +    mutex_unlock(&cpuset_mutex);
>>> +    cpus_read_unlock();
>>> +}
>>> +
>>>   #ifdef CONFIG_LOCKDEP
>>>   bool lockdep_is_cpuset_held(void)
>>>   {
>>> @@ -3209,6 +3231,10 @@ ssize_t cpuset_write_resmask(struct 
>>> kernfs_open_file *of,
>>>   {
>>>       struct cpuset *cs = css_cs(of_css(of));
>>>       struct cpuset *trialcs;
>>> +    cpuset_filetype_t type = of_cft(of)->private;
>>> +    bool mems = type == FILE_MEMLIST;
>>> +    bool hk_update = false;
>>> +    bool sd_rebuild = false;
>>>       int retval = -ENODEV;
>>>         /* root is read-only */
>>> @@ -3216,7 +3242,10 @@ ssize_t cpuset_write_resmask(struct 
>>> kernfs_open_file *of,
>>>           return -EACCES;
>>>         buf = strstrip(buf);
>>> -    cpuset_full_lock();
>>> +    if (mems)
>>> +        cpuset_mems_lock(&hk_update, &sd_rebuild);
>>> +    else
>>> +        cpuset_full_lock();
>>>       if (!is_cpuset_online(cs))
>>>           goto out_unlock;
>>>   @@ -3226,7 +3255,7 @@ ssize_t cpuset_write_resmask(struct 
>>> kernfs_open_file *of,
>>>           goto out_unlock;
>>>       }
>>>   -    switch (of_cft(of)->private) {
>>> +    switch (type) {
>>>       case FILE_CPULIST:
>>>           retval = update_cpumask(cs, trialcs, buf);
>>>           break;
>>> @@ -3243,9 +3272,12 @@ ssize_t cpuset_write_resmask(struct 
>>> kernfs_open_file *of,
>>>         free_cpuset(trialcs);
>>>   out_unlock:
>>> -    cpuset_update_sd_hk_unlock();
>>> -    if (of_cft(of)->private == FILE_MEMLIST)
>>> +    if (mems) {
>>> +        cpuset_mems_unlock(hk_update, sd_rebuild);
>>>           schedule_flush_migrate_mm();
>>> +    } else {
>>> +        cpuset_update_sd_hk_unlock();
>>> +    }
>>>       return retval ?: nbytes;
>>>   }
>>
>
> Thanks,


