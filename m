Return-Path: <cgroups+bounces-13558-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KbqBPxefWnpRgIAu9opvQ
	(envelope-from <cgroups+bounces-13558-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 02:46:36 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 811ABC0162
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 02:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2124D303A26F
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 01:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C652321434;
	Sat, 31 Jan 2026 01:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QXE7QsvA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eagm5Xtk"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1342224249
	for <cgroups@vger.kernel.org>; Sat, 31 Jan 2026 01:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769823959; cv=none; b=bBxtDFZ2sOZkInB6ci95WTz211Y8iwIR9vQ5WoXYAhJ1PspRa0e0u3oY7LfNviYro0DQ96aEy/Y52duJsEhUH37N32ylf8zAA1u5t7xTtKx+amj7xhMeI1d5PfzvXKOqr9EipnoLSy3Zg6bhxiQaHY9+PaCqbEw0xPd68vq9wWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769823959; c=relaxed/simple;
	bh=veyRaNBdT52I+KrbgnljEcWxt4d4uAQdbZD8S2huDNg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=P6+Zzs1/Aj+mVVI4iQr45zS91WOlMj8dFhhvLwjEqOshesqH5heby1DMcURlIJNvlhL1a24LAjQCtXF9avOclLvnBkcF/WC90YGlP5KMeatGfunBugdOMiVKbmbfamYYxXvl0q6QY3FRR2xa/AykXDXEChut4cFWLN3aT3R5vNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QXE7QsvA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eagm5Xtk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769823956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHzb7M9IdDSSpP/nfFEDbWxCVCDaS7Gd3BWeUwItZpM=;
	b=QXE7QsvASl7O4LoLuPQ4FU57tOxFpYEhoZ2c9Jqi/JHh8fSxa5tK/LwYqCtH8B50Jqnd9f
	rGllr9yi7B4uCSU5SL2gBjO6SM9C61ExMdWCWUN5z74wevfQTxcdMioX8xa46Pns73DIp5
	gIL8fvtvYOxKQl/7Gedhq544GevSDLA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-oMM2CEN-Me-Tupa0m8AKcw-1; Fri, 30 Jan 2026 20:45:54 -0500
X-MC-Unique: oMM2CEN-Me-Tupa0m8AKcw-1
X-Mimecast-MFC-AGG-ID: oMM2CEN-Me-Tupa0m8AKcw_1769823954
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8946b186018so95552956d6.1
        for <cgroups@vger.kernel.org>; Fri, 30 Jan 2026 17:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769823954; x=1770428754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WHzb7M9IdDSSpP/nfFEDbWxCVCDaS7Gd3BWeUwItZpM=;
        b=Eagm5XtkfzhPohTMjU1ePKD4s0GFaYhKs2+J+zavT/qjmjzwR2A9+/aN3nxtoAw1cM
         mZdrwjiY0eVNtkCfONr3iHMSY/Nvt6h4HT13AdIILRu4fI7T3XMMHwwZSqltI4qO1OwQ
         TpmOUWf9PfvifKQRMJWJIDsdequaSpGxKh1gg2+VF+HDax4lRg9PAqGTJcDn4owbCnpI
         lyLADW2Y2k4Qj5GpTFS4MidoJ3HpgLKDu2h8jKM2BecnkfoG3vbUbbO6N2o7pNi9KQ5C
         qFJCMAOxpr4tC+XlqV5SyWjlMv1u0ekWQtl8XkcRbZSlAU6UWtnHGdsoteuvN4UqXO5A
         BprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769823954; x=1770428754;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WHzb7M9IdDSSpP/nfFEDbWxCVCDaS7Gd3BWeUwItZpM=;
        b=FgxBte1VHTEsqBEL8Gq92PaN5oRDUMo8pyxcwziXId1+U64lyRhmuDK850NfTBI52o
         f66VScYDNd4eqavriCufC1vLgLQI87IeuACEyJZqIrLaJqQ/LLvrJe3jVW1VwGm9oyfd
         HoIt+cDC6Zrpz+AhochZ6KePrWAr1LLCz4iWhBH7t9XD1IsSlMTGC0GEYU4L0zqlm/Sg
         pcnG9b+2G9vANHWoLb0dYTCvw2B6QNVd0MCSZGEuUDt0D9gQUMCO6+ulVr+4ROVpRyEt
         C5zzdcOLsZPh1GvWnpP9k+KoNENPR0ewvVG8AaV3zgVVDTncuy9tsFWiyuuaIxqPkLJF
         htHw==
X-Gm-Message-State: AOJu0YzxlA98pewyfhC+hwtW2U9mywQ1eS+cV1QlUSyIphBvi09I9+NL
	5N85fV5TLgZO11D10bsdLbgeHQUFmlOjEeuz5jKmNZ3qnhmCbBrist4+8yp/P1wDiBBmc2tRawA
	p3K6vGAlnMyiBCN+bdZiF7z5QpH4IJVgzkEfouSFC/A5FG3+1fB37euNEtTA=
X-Gm-Gg: AZuq6aLdVJZJ44L87T2k2BzZqa0k4nnWXkvMvBm02ikftmoYVVSld2WnAyVrOwdzWGU
	hllOkJmq0YgN8VKx9Oj0BwIT4d7T/gBRyU3irkJjLN4zWc4S/j2sFl6j2QmDohw8foIg67RYi6r
	PgOFt8q/FXXMu+2+tRgNeJ/FhcI9iojrYQGHSpm1oeE9ljfw8AMbqZf6fqyi31Yljsq0YbOZzxA
	mrAxpo7TI4ZSQPR/FNDnzt2lDTUkvLfAF1EVJf3dT1XssDMRPtHc+Sgu8908nYp6F/6swS1tFqT
	At67DketOP/F0e5EwuWVQBAPnpg+dm9LZg2Vx6ri2SA3MAUk/zxGeZ2ekP9Ps3fmCXb53+gNxhY
	2PM2OKuWIM4CmrW9iD1pqQIPIe+lQYCfUErq6LPlUhzlyDvFe7VyniiQE
X-Received: by 2002:ad4:5d48:0:b0:882:437d:282d with SMTP id 6a1803df08f44-894e9fb26f0mr63707736d6.30.1769823954312;
        Fri, 30 Jan 2026 17:45:54 -0800 (PST)
X-Received: by 2002:ad4:5d48:0:b0:882:437d:282d with SMTP id 6a1803df08f44-894e9fb26f0mr63707546d6.30.1769823953931;
        Fri, 30 Jan 2026 17:45:53 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d376e53esm69274166d6.54.2026.01.30.17.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 17:45:53 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <781c0d8e-7cb6-4f3e-913a-b2a6b0bfed5e@redhat.com>
Date: Fri, 30 Jan 2026 20:45:52 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next v2 1/2] cgroup/cpuset: Defer
 housekeeping_update() call from CPU hotplug to workqueue
To: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260130154254.1422113-1-longman@redhat.com>
 <20260130154254.1422113-2-longman@redhat.com>
 <7c7fddf5-9d32-415b-a1c4-3b9402e78d72@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <7c7fddf5-9d32-415b-a1c4-3b9402e78d72@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-13558-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[llong@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,test_cpuset_prs.sh:url]
X-Rspamd-Queue-Id: 811ABC0162
X-Rspamd-Action: no action

On 1/30/26 7:58 PM, Chen Ridong wrote:
>
> On 2026/1/30 23:42, Waiman Long wrote:
>> The update_isolation_cpumasks() function can be called either directly
>> from regular cpuset control file write with cpuset_full_lock() called
>> or via the CPU hotplug path with cpus_write_lock and cpuset_mutex held.
>>
>> As we are going to enable dynamic update to the nozh_full housekeeping
>> cpumask (HK_TYPE_KERNEL_NOISE) soon with the help of CPU hotplug,
>> allowing the CPU hotplug path to call into housekeeping_update() directly
>> from update_isolation_cpumasks() will likely cause deadlock. So we
>> have to defer any call to housekeeping_update() after the CPU hotplug
>> operation has finished. This is now done via the workqueue where
>> the actual housekeeping_update() call, if needed, will happen after
>> cpus_write_lock is released.
>>
>> We can't use the synchronous task_work API as call from CPU hotplug
>> path happen in the per-cpu kthread of the CPU that is being shut down
>> or brought up. Because of the asynchronous nature of workqueue, the
>> HK_TYPE_DOMAIN housekeeping cpumask will be updated a bit later than the
>> "cpuset.cpus.isolated" control file in this case.
>>
>> Also add a check in test_cpuset_prs.sh and modify some existing
>> test cases to confirm that "cpuset.cpus.isolated" and HK_TYPE_DOMAIN
>> housekeeping cpumask will both be updated.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c                        | 37 +++++++++++++++++--
>>   .../selftests/cgroup/test_cpuset_prs.sh       | 13 +++++--
>>   2 files changed, 44 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 7b7d12ab1006..0b0eb1df09d5 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -84,6 +84,9 @@ static cpumask_var_t	isolated_cpus;
>>    */
>>   static bool isolated_cpus_updating;
>>   
>> +/* Both cpuset_mutex and cpus_read_locked acquired */
>> +static bool cpuset_locked;
>> +
>>   /*
>>    * A flag to force sched domain rebuild at the end of an operation.
>>    * It can be set in
>> @@ -285,10 +288,12 @@ void cpuset_full_lock(void)
>>   {
>>   	cpus_read_lock();
>>   	mutex_lock(&cpuset_mutex);
>> +	cpuset_locked = true;
>>   }
>>   
>>   void cpuset_full_unlock(void)
>>   {
>> +	cpuset_locked = false;
>>   	mutex_unlock(&cpuset_mutex);
>>   	cpus_read_unlock();
>>   }
>> @@ -1285,6 +1290,16 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
>>   	return false;
>>   }
>>   
>> +static void isolcpus_workfn(struct work_struct *work)
>> +{
>> +	cpuset_full_lock();
>> +	if (isolated_cpus_updating) {
>> +		WARN_ON_ONCE(housekeeping_update(isolated_cpus) < 0);
>> +		isolated_cpus_updating = false;
>> +	}
>> +	cpuset_full_unlock();
>> +}
>> +
>>   /*
>>    * update_isolation_cpumasks - Update external isolation related CPU masks
>>    *
>> @@ -1293,14 +1308,30 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
>>    */
>>   static void update_isolation_cpumasks(void)
>>   {
>> -	int ret;
>> +	static DECLARE_WORK(isolcpus_work, isolcpus_workfn);
>>   
>>   	if (!isolated_cpus_updating)
>>   		return;
>>   
>> -	ret = housekeeping_update(isolated_cpus);
>> -	WARN_ON_ONCE(ret < 0);
>> +	/*
>> +	 * This function can be reached either directly from regular cpuset
>> +	 * control file write (cpuset_locked) or via hotplug (cpus_write_lock
>> +	 * && cpuset_mutex held). In the later case, we defer the
>> +	 * housekeeping_update() call to the system_unbound_wq to avoid the
>> +	 * possibility of deadlock. This also means that there will be a short
>> +	 * period of time where HK_TYPE_DOMAIN housekeeping cpumask will lag
>> +	 * behind isolated_cpus.
>> +	 */
>> +	if (!cpuset_locked) {
> Adding a global variable makes this difficult to handle, especially in
> concurrent scenarios, since we could read it outside of a critical region.
No, cpuset_locked is always read from or written into inside a critical 
section. It is under cpuset_mutex up to this point and then with the 
cpuset_top_mutex with the next patch.
>
> I suggest removing cpuset_locked and adding async_update_isolation_cpumasks
> instead, which can indicate to the caller it should call without holding the
> full lock.

The point of this global variable is to distinguish between calling from 
CPU hotplug and the other regular cpuset code paths. The only difference 
between these two are having cpus_read_lock or cpus_write_lock held. 
That is why I think adding a global variable in cpuset_full_lock() is 
the easy way. Otherwise, we will to add extra argument to some of the 
functions to distinguish these two cases.

Cheers,
Longman


