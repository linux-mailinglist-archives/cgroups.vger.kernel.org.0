Return-Path: <cgroups+bounces-13577-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LH4OEouJfmnAaQIAu9opvQ
	(envelope-from <cgroups+bounces-13577-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 01 Feb 2026 00:00:27 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D71C44E6
	for <lists+cgroups@lfdr.de>; Sun, 01 Feb 2026 00:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B7A9301DACF
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 23:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A812838B9A2;
	Sat, 31 Jan 2026 23:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1ntcLEh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/L3ge/s"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58BB38B7CE
	for <cgroups@vger.kernel.org>; Sat, 31 Jan 2026 23:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769900410; cv=none; b=uNA+qO+Xy2BRmiTclH6UmpSfxkfYgTFLmpoMdZ757XFbepFMi2MhPccxFUN/hNQX7zHZIxY3fR6IPb2Xy33xExmcduoQG8brcc0xZD+it3E5vTDg+Xig/0Iyog11+myIg4CJE5VRMKST/EY9qFsp8Liu7FAEalVwcy9MGBLGEXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769900410; c=relaxed/simple;
	bh=zqFfqRfaiOQhLC9XWHh23Mob6UtnqTRofBiGNrZEtqA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uE3edlh4FWm9Tqa5UymwwsbUN0OwU+B6idflY1fsqXElVhN5lq4tzXCvySv8hnVF4KBzK8V6LJVy53bVDTwsVKCm/pw3IIbiuXVjuhWMDlS60wwMhiPg/dbJJ/gg62btFnxTKPyJWz2jfPkhwN6g0ITXhgzlojWGL3msqeK9VCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X1ntcLEh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D/L3ge/s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769900407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w7MECkaQfZwsqsjhzRDYSRqCA7UmF7Toyzwg6Umbbs0=;
	b=X1ntcLEhFAUfSn14MMesms2N9pbIIDFgRHSjtqkTY7iZS7eaU7UwUgIMR6O+ThkEkzwKKU
	O8ClRZy7sqOyRwKRJVx0R7WjY0Bx2nLozH1Jl69qDkDgmVHuL3WsfoIrC0IvqU5AFOt4Pn
	9rk++r1OZDY0o/2coveJbQ3nLQyeHOw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-oTByLtunN-G0ksKDISmtLw-1; Sat, 31 Jan 2026 18:00:05 -0500
X-MC-Unique: oTByLtunN-G0ksKDISmtLw-1
X-Mimecast-MFC-AGG-ID: oTByLtunN-G0ksKDISmtLw_1769900405
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-502b155a742so92827351cf.1
        for <cgroups@vger.kernel.org>; Sat, 31 Jan 2026 15:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769900405; x=1770505205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w7MECkaQfZwsqsjhzRDYSRqCA7UmF7Toyzwg6Umbbs0=;
        b=D/L3ge/slIusNnd08CPAoRS5FzNnhVXXUopfJZP0y78Zz//BKhkYTae9BLK/voEEMu
         txTryoXoTHMZyHkvGNZ+DnL1im+fwsOPgExtGAG/o/bwH5YxvtQ/PA0pJFjLGE/D+CGl
         2H+BMZNbIDoBRsSKNnfqaXhbArAqTyfNr6+wOWL5arIt80Hm0OgWRjx1Kp5spez+9hZ3
         REcP9enrs6zXcXzdWNOiCKvQtToJjsGbhqbbQc+5B0hj0HakSmvc5cOsHS9l2Knv+xMF
         PnJn8H6rnRrp21Zww6wHHRumFNxB6qdN+exMkb6esnEA5zqavwpwQTCcUNyaOOv2MwiZ
         eiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769900405; x=1770505205;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w7MECkaQfZwsqsjhzRDYSRqCA7UmF7Toyzwg6Umbbs0=;
        b=topIlRdP8x44M8XwREUq5SGASc7fyDp+h5mJ2IdiAoocc11dYn6gcreJ0xrig6sGjO
         USBbYRs/yh8GENDr9urFL6i6PYuKMfcm/FxSx2+hKqgJIDz8lA+M0zqrZt1FEwn2btyI
         RmC5wXc+Nxa8hKRjXSu5ovzjAvonaE5P6VgJ1D2fFcP1UIoqFnGrSgTl1q4/xFuhr3Id
         eDLwb8oYaVSCC7I1ZZ7aAu6AkkzdL4qtfXL4AEpL0f5oabFNilv14r6nFvWtS1kPCV+M
         scw7S2ryrg1ZoTd3FfVIhjcT2XrHQ73m69od3ZrNTq1pN/Qr0A9pmSnA5pnH2GyyARvG
         IgTg==
X-Gm-Message-State: AOJu0Yzr6y/pEmvAsPPuDY77wA208c3ZkHNDWF8qEju8eRUntgvqJBAf
	W8J7R10CNQUm57u2C7J6NQF3ttktuqquhgpi1iw53kd5l22aNP2M0NIbbQMPz3Sfkndds9QSj/4
	Bc6WI4zb4OcrM6x9oKadHrdK1WQMN+d8fXOrHgzUe0LFxuv7wVq+07rQCRys=
X-Gm-Gg: AZuq6aISxRZTFcQUu13gyijNAFuurmIpqii/IcSg/DTdtOrud8tbmaKMjDatbIEad9q
	5xGSzjHUv0cnZVaij8bgk4bbiHinsDMYzjrzqu/TNy2A2x4a0NLgHeB1/AP+RfhhWT6lbRiPUj+
	rPOvXAy6yMcZ2OS3BI1lR5FLzcNu+6dnkbMVS8B+YwqxIHP2r7gNgWNssqAbhDizUYGMKoGMGyb
	ZK9sBCx5czd5RP36mMkv/sMbBlsyVKFNJsdPTHW+IwhogPpjQxpA39soytLrEOJhloDMZ2GGtdZ
	B7BAVhDnMr+1L0OFBir56OkdxZyswWJ5//y7yq+62at7qFIlosqR0bFrdl9S2YRIt9JmQSzH4ap
	9jE/WrYL/9HbUEyxqk+XZweUG9p/AYPU78XR0Xoryx/rl7bXvYgSWhbQO
X-Received: by 2002:ac8:5a82:0:b0:4f4:c104:9519 with SMTP id d75a77b69052e-505d223ead5mr100366921cf.42.1769900404735;
        Sat, 31 Jan 2026 15:00:04 -0800 (PST)
X-Received: by 2002:ac8:5a82:0:b0:4f4:c104:9519 with SMTP id d75a77b69052e-505d223ead5mr100366511cf.42.1769900404214;
        Sat, 31 Jan 2026 15:00:04 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50337cc19d7sm81065561cf.35.2026.01.31.15.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 15:00:03 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <2bd82e80-564b-4ec7-a97a-4722248a1a4a@redhat.com>
Date: Sat, 31 Jan 2026 18:00:02 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next v2 1/2] cgroup/cpuset: Defer
 housekeeping_update() call from CPU hotplug to workqueue
To: Chen Ridong <chenridong@huaweicloud.com>, Waiman Long <llong@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
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
 <781c0d8e-7cb6-4f3e-913a-b2a6b0bfed5e@redhat.com>
 <444c73fd-bd24-41d9-8642-597a546de781@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <444c73fd-bd24-41d9-8642-597a546de781@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-13577-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[test_cpuset_prs.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 25D71C44E6
X-Rspamd-Action: no action

On 1/30/26 9:05 PM, Chen Ridong wrote:
>
> On 2026/1/31 9:45, Waiman Long wrote:
>> On 1/30/26 7:58 PM, Chen Ridong wrote:
>>> On 2026/1/30 23:42, Waiman Long wrote:
>>>> The update_isolation_cpumasks() function can be called either directly
>>>> from regular cpuset control file write with cpuset_full_lock() called
>>>> or via the CPU hotplug path with cpus_write_lock and cpuset_mutex held.
>>>>
>>>> As we are going to enable dynamic update to the nozh_full housekeeping
>>>> cpumask (HK_TYPE_KERNEL_NOISE) soon with the help of CPU hotplug,
>>>> allowing the CPU hotplug path to call into housekeeping_update() directly
>>>> from update_isolation_cpumasks() will likely cause deadlock. So we
>>>> have to defer any call to housekeeping_update() after the CPU hotplug
>>>> operation has finished. This is now done via the workqueue where
>>>> the actual housekeeping_update() call, if needed, will happen after
>>>> cpus_write_lock is released.
>>>>
>>>> We can't use the synchronous task_work API as call from CPU hotplug
>>>> path happen in the per-cpu kthread of the CPU that is being shut down
>>>> or brought up. Because of the asynchronous nature of workqueue, the
>>>> HK_TYPE_DOMAIN housekeeping cpumask will be updated a bit later than the
>>>> "cpuset.cpus.isolated" control file in this case.
>>>>
>>>> Also add a check in test_cpuset_prs.sh and modify some existing
>>>> test cases to confirm that "cpuset.cpus.isolated" and HK_TYPE_DOMAIN
>>>> housekeeping cpumask will both be updated.
>>>>
>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>> ---
>>>>    kernel/cgroup/cpuset.c                        | 37 +++++++++++++++++--
>>>>    .../selftests/cgroup/test_cpuset_prs.sh       | 13 +++++--
>>>>    2 files changed, 44 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>>> index 7b7d12ab1006..0b0eb1df09d5 100644
>>>> --- a/kernel/cgroup/cpuset.c
>>>> +++ b/kernel/cgroup/cpuset.c
>>>> @@ -84,6 +84,9 @@ static cpumask_var_t    isolated_cpus;
>>>>     */
>>>>    static bool isolated_cpus_updating;
>>>>    +/* Both cpuset_mutex and cpus_read_locked acquired */
>>>> +static bool cpuset_locked;
>>>> +
>>>>    /*
>>>>     * A flag to force sched domain rebuild at the end of an operation.
>>>>     * It can be set in
>>>> @@ -285,10 +288,12 @@ void cpuset_full_lock(void)
>>>>    {
>>>>        cpus_read_lock();
>>>>        mutex_lock(&cpuset_mutex);
>>>> +    cpuset_locked = true;
>>>>    }
>>>>      void cpuset_full_unlock(void)
>>>>    {
>>>> +    cpuset_locked = false;
>>>>        mutex_unlock(&cpuset_mutex);
>>>>        cpus_read_unlock();
>>>>    }
>>>> @@ -1285,6 +1290,16 @@ static bool prstate_housekeeping_conflict(int prstate,
>>>> struct cpumask *new_cpus)
>>>>        return false;
>>>>    }
>>>>    +static void isolcpus_workfn(struct work_struct *work)
>>>> +{
>>>> +    cpuset_full_lock();
>>>> +    if (isolated_cpus_updating) {
>>>> +        WARN_ON_ONCE(housekeeping_update(isolated_cpus) < 0);
>>>> +        isolated_cpus_updating = false;
>>>> +    }
>>>> +    cpuset_full_unlock();
>>>> +}
>>>> +
>>>>    /*
>>>>     * update_isolation_cpumasks - Update external isolation related CPU masks
>>>>     *
>>>> @@ -1293,14 +1308,30 @@ static bool prstate_housekeeping_conflict(int
>>>> prstate, struct cpumask *new_cpus)
>>>>     */
>>>>    static void update_isolation_cpumasks(void)
>>>>    {
>>>> -    int ret;
>>>> +    static DECLARE_WORK(isolcpus_work, isolcpus_workfn);
>>>>          if (!isolated_cpus_updating)
>>>>            return;
>>>>    -    ret = housekeeping_update(isolated_cpus);
>>>> -    WARN_ON_ONCE(ret < 0);
>>>> +    /*
>>>> +     * This function can be reached either directly from regular cpuset
>>>> +     * control file write (cpuset_locked) or via hotplug (cpus_write_lock
>>>> +     * && cpuset_mutex held). In the later case, we defer the
>>>> +     * housekeeping_update() call to the system_unbound_wq to avoid the
>>>> +     * possibility of deadlock. This also means that there will be a short
>>>> +     * period of time where HK_TYPE_DOMAIN housekeeping cpumask will lag
>>>> +     * behind isolated_cpus.
>>>> +     */
>>>> +    if (!cpuset_locked) {
>>> Adding a global variable makes this difficult to handle, especially in
>>> concurrent scenarios, since we could read it outside of a critical region.
>> No, cpuset_locked is always read from or written into inside a critical section.
>> It is under cpuset_mutex up to this point and then with the cpuset_top_mutex
>> with the next patch.
> This is somewhat confusing. cpuset_locked is only set to true when the "full
> lock" has been acquired. If cpuset_locked is false, that should mean we are
> outside of any critical region. Conversely, if we are inside a critical region,
> cpuset_locked should be true.
>
> The situation is a bit messy, it’s not clearly which lock protects which global
> variable.

There is a comment above "cpuset_locked" which state which lock protect 
it. The locking situation is becoming more complicated. I think I will 
add a new patch to more clearly document what each global variable is 
being protected by.

Cheers,
Longman

>
>>> I suggest removing cpuset_locked and adding async_update_isolation_cpumasks
>>> instead, which can indicate to the caller it should call without holding the
>>> full lock.
>> The point of this global variable is to distinguish between calling from CPU
>> hotplug and the other regular cpuset code paths. The only difference between
>> these two are having cpus_read_lock or cpus_write_lock held. That is why I think
>> adding a global variable in cpuset_full_lock() is the easy way. Otherwise, we
>> will to add extra argument to some of the functions to distinguish these two cases.
>>
>> Cheers,
>> Longman
>>


