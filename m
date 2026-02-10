Return-Path: <cgroups+bounces-13831-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDAEFbc6i2lIRwAAu9opvQ
	(envelope-from <cgroups+bounces-13831-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 15:03:35 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DC111BAE5
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 15:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BB7730177BA
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 14:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB5D36607A;
	Tue, 10 Feb 2026 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQ7zG47c";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGAt55st"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D19366075
	for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770732098; cv=none; b=Aezuida0N63wV7ThTnbwXFI3XpEM5pWmTHjUfX+L2jd6hCCUfmWKHbqN98uh5t4MRdMhF2OQCX8Tx/MaMCar2sGB4AHFjO6IUCi5x4en0UzPzi3sKfsOO7k2HOoALlrghDz0ZyCdfbhCyveVZZkHcajl9KOghB6uBMCi7bX20no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770732098; c=relaxed/simple;
	bh=8jtpoSXYbybLE/xY+++ZpfTrLk7i+XgUcjmGEmd16hk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SYByAGnIMrfDx/oiR390op6GjtVBqCvcv2+RjffCdxbTqYShtEVQ/deOcRuhngf8jZfPH0rO+3Un7O9/AlAwgs5WKlM3xlYEo4Uefi1Wzjw41RHtKLu1oiHa7oVYWs2cCpADmo0RGM+EcnQj2BtSDViiJWYcXxQb/uZYQQn7lgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bQ7zG47c; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EGAt55st; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770732096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4inRA1URPkZFbtOlGH7PVCQZlyxkjMU1G2/KzimKDM=;
	b=bQ7zG47cxy0sb+oKXIkQYdvrEvbolkq/by+JtbtTZHyqdPhVJUtxHkpSOKMT9lHidom6vM
	wezOvbmfRQ60oke7EsIaKnLVWmTcB+lT2pN7dCjnSawfCSsRCobHNxjITHFTnrdPJMtzmM
	dgDhOGqwJEB3GGZl7N5HetgXV6SqIR4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-7p_7--n9Nr6HRASvlW3dQg-1; Tue, 10 Feb 2026 09:01:35 -0500
X-MC-Unique: 7p_7--n9Nr6HRASvlW3dQg-1
X-Mimecast-MFC-AGG-ID: 7p_7--n9Nr6HRASvlW3dQg_1770732094
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c6b315185aso1963454185a.2
        for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 06:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770732094; x=1771336894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z4inRA1URPkZFbtOlGH7PVCQZlyxkjMU1G2/KzimKDM=;
        b=EGAt55stvuzxJLnWnG9qId/vP4iNR3vbl/fqeJsdJuj8i3qlPfgHC+Kzu1nguqpFd/
         yvEMd2n4um+VTiEyUohWgTaYvjVYid5nYXobEmGV3wrF1+SM0oShbZNGfSJ3OVOd2doa
         zBCyLP6eFblSOhF42PTMNmMTxQ2IyobCgu07OTb+jtUb0A6wXMPNHqpOGAgMNHZGTtr6
         RRXw+3Q5CT7I3oIIGC3CdmULw7g0LdZMDILLn1y1/aJ3jY0LY8WaGe2sOWWN+Co3ZxN/
         LRNonOlZsXt1LAYweb86Ns8Q2Gr79tgTDoLWuqM1dZ1GTXGN41gKSO1u3i5XRJD99eC9
         AS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770732094; x=1771336894;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4inRA1URPkZFbtOlGH7PVCQZlyxkjMU1G2/KzimKDM=;
        b=DkGgKNlydBr7HRwNDh/GurWeAbuY/qjfJW/4Lrukb5XL4QDmLzzjvRjYnFD+Ox00Bt
         bfMQOipeesThjr1LJ1jJeWLCoZBVt0h+/jTTdM3QKVK9tprAd+Vm0druOi2ek5noQ4vS
         faBspL1ytDIyrsE5mDFYLhsC07jlC+dtsTUv93mQgozqQ65WgQ8Q+oqgD9iR76L67QGp
         803cUGmz4h1I6lxmgKOH4cXRJjSkodwpUYNoUq+tqqIkQ3s6q5k3K9rxFyURIkp/UIlp
         5hSZnTYscGrDif9HtQZGeM0dbT70ZtU5Mmalx/JTGeQAni94sslVnG7rY638/7TJcY+i
         YZWQ==
X-Gm-Message-State: AOJu0YxOStp/dS4bCMMOoXUdS002pZ8P3Z5Ai+9rkt+0+1zpZNwCdTsz
	h+/3KTtRGK+sXrRyynPvLVsQENYtNRcWvP2ItWnHDXRFEoK5Z1CD+VSZrdBHed5uBCi34AiJiD4
	kBH1BtidBpicvImARLuUPTokvYURz+xeDiLSBJNLG4c8tVVAsb8xT/40LpPY=
X-Gm-Gg: AZuq6aIZA0vH5SLEEoFLebXqI0gfXlGZP5UGBTQZhgZ+bPpEn9C7nz5YTba3K2Gjqbr
	rK1hWfGdy7nI97hYVzTiKt7x/eopBKan0Ftt2x/6ocG7t5Ew70d1w5FIKW10fVcXiLr14u7d5zr
	5mSfES6RTSs3g/+eNXdMAhJJJn5EFQYY7Wz35r7QhP45SmHjKIRjER7skT2dqhTQhVIip/PqIRL
	PtTlmWwo09lahnmLfW429x/CjviYQCdXHHRpQKLN1cUrBlN51BoDUZiZMvpzZMpDLdpCQSd9V6g
	/6iz413TxQLFcu3lzSfHOEChk2tYSYKkIhgNde6iZjNHp4YzTwMs+sVOtpsNDJ2AIRltbddgX0t
	+ufnp+e6tKhhfIrhy2feazzs0V3Fv9YNZeO+WfCEEtXkfvbZnOhC1/DpO/BAdkwlSVLpM
X-Received: by 2002:a05:620a:bc5:b0:8bb:26db:e22f with SMTP id af79cd13be357-8caef7e1ca2mr1823856385a.30.1770732093707;
        Tue, 10 Feb 2026 06:01:33 -0800 (PST)
X-Received: by 2002:a05:620a:bc5:b0:8bb:26db:e22f with SMTP id af79cd13be357-8caef7e1ca2mr1823851485a.30.1770732093249;
        Tue, 10 Feb 2026 06:01:33 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9a15a4dsm1023079185a.25.2026.02.10.06.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 06:01:32 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6552b863-6d2b-4537-8155-d87985e77628@redhat.com>
Date: Tue, 10 Feb 2026 09:01:30 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next v4 3/4] cgroup/cpuset: Call housekeeping_update()
 without holding cpus_read_lock
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
References: <20260206203712.1989610-1-longman@redhat.com>
 <20260206203712.1989610-4-longman@redhat.com>
 <e9c4aae2-44ed-42f5-9b4b-b63d59915143@huaweicloud.com>
 <eee7862c-45ac-4acc-b8a7-a560fc21d9b4@redhat.com>
 <f1c47301-58a6-425b-b248-913a2a7dbaf9@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <f1c47301-58a6-425b-b248-913a2a7dbaf9@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13831-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[llong@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8DC111BAE5
X-Rspamd-Action: no action

On 2/9/26 8:29 PM, Chen Ridong wrote:
>
> On 2026/2/10 4:29, Waiman Long wrote:
>> On 2/9/26 2:12 AM, Chen Ridong wrote:
>>>>            return;
>>>>        }
>>>>    -    WARN_ON_ONCE(housekeeping_update(isolated_cpus) < 0);
>>>> -    isolated_cpus_updating = false;
>>>> +    /*
>>>> +     * update_isolation_cpumasks() may be called more than once in the
>>>> +     * same cpuset_mutex critical section.
>>>> +     */
>>>> +    lockdep_assert_held(&cpuset_top_mutex);
>>>> +    if (isolcpus_twork_queued)
>>>> +        return;
>>>> +
>>>> +    init_task_work(&twork_cb, isolcpus_tworkfn);
>>>> +    if (!task_work_add(current, &twork_cb, TWA_RESUME))
>>>> +        isolcpus_twork_queued = true;
>>>> +    else
>>>> +        WARN_ON_ONCE(1);    /* Current task shouldn't be exiting */
>>>>    }
>>>>    
>>> Timeline:
>>>
>>> user A            user B
>>> write isolated cpus    write isolated cpus
>>> isolated_cpus_update
>>> update_isolation_cpumasks
>>> task_work_add
>>> isolcpus_twork_queued =true
>>>
>>> // before returning userspace
>>> // waiting for worker
>>>              isolated_cpus_update
>>>              if (isolcpus_twork_queued)
>>>                  return // Early exit
>>>              // return to userspace
>>>
>>> // workqueue finishes
>>> // return to userspace
>>>
>>> For User B, the isolated_cpus value appears to be set and the syscall returns
>>> successfully to userspace. However, because isolcpus_twork_queued was already
>>> true (set by User A), User B's call skipped the actual mask update
>>> (update_isolation_cpumasks).
>>> Thus, the new isolated_cpus value is not yet effective in the kernel, even
>>> though User B's write operation returned without error.
>>>
>>> Is this a valid issue? Should User B's write be blocked?
>> It is perfectly possible that isolated_cpus can be modified more than one time
>> from different tasks before a work or task_work function is executed. When that
>> function is invoked, isolated_cpus should contain changes for both. It will copy
>> isolated_cpus to isolated_hk_cpus and pass it to housekeeping_update(). When the
> It is clear about isolated_hk_cpus and isolated_cpus.
>
>> 2nd work or task_work function is invoked, it will see that isolated_cpus match
>> isolated_hk_cpus and skip the housekeeping_update() action. There is no need to
>> block user B's write as only one task can update isolated_cpus at any time.
>>
> The main question remains: user B receives a success return even though
> isolated_hk_cpus has not yet taken effect (i.e.,
> /sys/devices/system/cpu/isolated does not reflect the change). In that case, how
> can user B confirm whether their configuration is actually applied?

task_work function is synchronous. IOW, if a user writes to a cpuset 
control file to modify an isolated partition, when control is passed 
back to userspace, it is guaranteed that the task_work function, if 
queued, would have been executed.

wq work function, OTOH, is asynchronous. So if a user brings down an 
isolated CPU to make an isolated partition invalid, the supposed changes 
to the sched domains may not be completed by the time the offline 
operation returns. However this is an operation that normal users 
shouldn't do in a production system anyway and they are taking their own 
risk if they try to do it.

Cheers,
Longman


