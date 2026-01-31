Return-Path: <cgroups+bounces-13556-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJJABrdVfWn9RQIAu9opvQ
	(envelope-from <cgroups+bounces-13556-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 02:07:03 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FA0BFDC0
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 02:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C2933013A50
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 01:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A015531AF2C;
	Sat, 31 Jan 2026 01:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RyAx58Dm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+37nhW4"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE643164BB
	for <cgroups@vger.kernel.org>; Sat, 31 Jan 2026 01:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769821600; cv=none; b=t7m0pKJORQW3zhF0h+sjK2F4GejPgmBYNVbSOLHWGK04R5oyuU/K4VK4J7i2PRAROhvLkBtcsK1+KoR39DQpDBb9xWmyIOxI1I1cYKRx3WfVUuvUnNEs7Wh1OK+V+9N1yLzCsHeKkWvNMZDXpx8ujTo/UFwTT0d3ABxHFY7xHyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769821600; c=relaxed/simple;
	bh=hjkJO9AF/LXMyOiJVDONfSzEwUsiDo4mFqbrrwjp2UA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OnpHD2+ZeVCUgNnrLS52fVlrxB0/cicN/IXUxNGJxYmU8GiXQBgVnH5H1Hu+8sqXbu1t974A4TOsV51bFv/TvwLeZVR/weLJd1AwxLBDrWbikRwfchuhsD4hyFJoFuK7+kk/E3sOS045RaVVx9IsCzY/f8aAnQumLgbJ6llpbw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RyAx58Dm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+37nhW4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769821597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UfiEsrEnIyZn47cTgetgAoM39/5k7SlYmbXzGHOjknE=;
	b=RyAx58Dm8Pd40X9voO+/YkqE9PqreAQXyKF5VuNnUKsqxV0s1iQ+7V1ykwglvQTVjDRonR
	yiiCkl1NQ6O4sCPM4tAC17YcLIDEfIwREtTivPYvkJHBYLY6aikwzZqMLzSgcRfMwxF9Sg
	jHc82lopBzKXgvriiEJMDs68Yi8cQTY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-vF5TO8BDPOaDdeBrP7szug-1; Fri, 30 Jan 2026 20:06:36 -0500
X-MC-Unique: vF5TO8BDPOaDdeBrP7szug-1
X-Mimecast-MFC-AGG-ID: vF5TO8BDPOaDdeBrP7szug_1769821596
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5014c9ee70bso76507961cf.1
        for <cgroups@vger.kernel.org>; Fri, 30 Jan 2026 17:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769821596; x=1770426396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UfiEsrEnIyZn47cTgetgAoM39/5k7SlYmbXzGHOjknE=;
        b=J+37nhW43kxW5Onq4pBuIq93dKVjMcju5C1H77w7dlTGDdO4sZS+ogdgF+Cool9MY3
         RWq++qLxsLGBvycjEYJsj0SoZI2bzAVaGqZiw7f/9KZPtB/EUjrTHLHWMtuvus25NAA2
         Z3EyouqN9ThspjYHrLQfYVph1OIkXjW68udlz2cm0r3112b+lZY1uAuayO3BpE1JwET1
         TcHYEHOd4qfYYqHOqa+zgvld2z1qBklvrmzCNYqxnmXj3pg2b4y0PD1GlSTZThkSWZBz
         WZKCV+DwmnzUAGv/ZuHztLyJRDyQRjpFLaFjmikfuwNGJDUdSIy5JiQZ13QNN339eBSk
         ROKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769821596; x=1770426396;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UfiEsrEnIyZn47cTgetgAoM39/5k7SlYmbXzGHOjknE=;
        b=ARwCeAb68fujqdo5I7x0hFjABR0TLvI5e72kIyWze+cf2x0qLyMsH4t8Hs35Dup5DC
         RE0c2GEcBimkSnLxQNkh03y0O1cpYsShyhKz7xShfcRsal/Ge1b5GY/toML1dWAMMtSc
         /usIuDJD5PeruatVyQu0o42MEON9DdM+KpbPIv9q5FC8pTY4PghlnC9zNDgRpppKmKTZ
         J8AnJnpmX4kLMBg9MSnytP+vcEsLtQL59tjuaBRMG8O34zv0tjHZ6Mxss898h8sXYA4S
         Xa4HYVg7fKtkJJoUH6fA4jLBxzG9pJX61sV+4hIUK2R5ajAHeGuj6gnxhPUCccAgzIh6
         z//A==
X-Gm-Message-State: AOJu0YzhFbNfvlu7au2stohza4ru3Lzc5Xcj50klzRv21gePnNrRdWIv
	Wr8AYcgRuG7u3fpCCuL2g80hcxWmOKVY+Jd0qnN0TuNwMBv5rxfzEIHGGuj6yypNlJpUBqSAJ/8
	WmogkTXr9MEWWNfWKlFE/izPqybMtVu42GyVM1G0Il5TxuzsqlWBYBvbd8Rc=
X-Gm-Gg: AZuq6aJYt6XO0VSfJ5C144iG80il9a1pQ71JYMbNZ7YAHhU2fDW+rzhP5CHHXFel+qg
	MNM1tx+7iRm+N/7xK2fbiJltWKreowYwwDt2YTYJ5ViIt92v5vUeJmnqezYQ66H/PPLXeKJ0K/v
	2m/7nn6IyvxuXI7e+FbhiR6IU929sAJiz57e+n5tjtO5Jtiu/zOOTYu9MCZhmsGgWldyanh4ZGr
	JEshjFyiNCoqje5Tqku5p16eMfyp9lihjfL02+2kdchxD4OQf4F2EHZB+bavbRBA/E6WBPzUFdr
	aebWEksaUuba2M4n1p50Du7V7aP51QXkuhMQu8I8dR4q5Tu6iggnmMOZcmkd70MtG6FsPPhaZPu
	uSf5BMQ9IQ6qNeVIiKUSXq02XJUlePQmb7NCYZxeQbq80QbVGwyG6HIkO
X-Received: by 2002:a05:622a:1aa4:b0:4ee:1563:2837 with SMTP id d75a77b69052e-505d22b37edmr55615491cf.67.1769821595985;
        Fri, 30 Jan 2026 17:06:35 -0800 (PST)
X-Received: by 2002:a05:622a:1aa4:b0:4ee:1563:2837 with SMTP id d75a77b69052e-505d22b37edmr55615151cf.67.1769821595544;
        Fri, 30 Jan 2026 17:06:35 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d3740d73sm69079846d6.27.2026.01.30.17.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 17:06:35 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <fb95620d-1178-4452-a837-297e71f68599@redhat.com>
Date: Fri, 30 Jan 2026 20:06:33 -0500
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
 <647ad3d2-364c-4e83-b46d-49a2a30b8f94@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <647ad3d2-364c-4e83-b46d-49a2a30b8f94@huaweicloud.com>
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
	TAGGED_FROM(0.00)[bounces-13556-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 69FA0BFDC0
X-Rspamd-Action: no action


On 1/30/26 7:47 PM, Chen Ridong wrote:
>
> On 2026/1/30 23:42, Waiman Long wrote:
>> The update_isolation_cpumasks() function can be called either directly
>> from regular cpuset control file write with cpuset_full_lock() called
>> or via the CPU hotplug path with cpus_write_lock and cpuset_mutex held.
Note this statement.
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
> Can this happen?
>
> cpu0					cpu1
> [...]
>
> isolated_cpus_updating = true;
> ...
> // 'full_lock' is not acquired
> update_isolation_cpumasks
That is not true. Either cpus_read_lock or cpus_write_lock and 
cpuset_mutex are held when update_isolation_cpumasks() is called. So 
there is mutual exclusion.
> 					// exec worker concurrently
> 					isolcpus_workfn
> 					cpuset_full_lock
> 					isolated_cpus_updating = false;
> 					cpuset_full_unlock();
> // This returns uncorrectly
> if (!isolated_cpus_updating)
> 	return;
>
Cheers,
Longman


