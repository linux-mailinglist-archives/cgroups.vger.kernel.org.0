Return-Path: <cgroups+bounces-13821-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAniHhqKimnxLgAAu9opvQ
	(envelope-from <cgroups+bounces-13821-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 02:30:02 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5665F115FE7
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 02:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C1189300CA09
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 01:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32B826B2D3;
	Tue, 10 Feb 2026 01:29:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4181126A0DD;
	Tue, 10 Feb 2026 01:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770686998; cv=none; b=dtbBF0hU9CrnNawOU6bYQ1ChoOUELvjCoq8WqY0iGkbxtSbaoLBZ6zyQaFLiFrlulMhdnQvapZEAV3ED2NuFL/1CMOExjqIES2XqOxoQQWumbMmZZij56ujhNmACVxQ5r2i8BsxL+gIzRDOMyiajp0eyugfw2RSqB8iSQu6Rtqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770686998; c=relaxed/simple;
	bh=3H3C8SX6zuSKTkEIkX5qnSRxqZ7hAHzg6oezaxaYMA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c/p+BU3RRj8rMFhT8HIWY4X+EF0Sy4j754XJgL+fgb1UFBTpTiG55szaydf0lPKdE6B6PFkJGerZyeOzurCLsC1tqTAw0iO4kmPyZEMoXk1hPuGvhfwAQG6Vo9OSf3GXagyV4A7sZHMmTiUKchNokzvkNm3PrARsZDzQU/I7S/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f93qp0wYkzYQtl8;
	Tue, 10 Feb 2026 09:28:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 803AC4058A;
	Tue, 10 Feb 2026 09:29:52 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgBnEvMOioppj7eLGw--.14S2;
	Tue, 10 Feb 2026 09:29:52 +0800 (CST)
Message-ID: <f1c47301-58a6-425b-b248-913a2a7dbaf9@huaweicloud.com>
Date: Tue, 10 Feb 2026 09:29:50 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next v4 3/4] cgroup/cpuset: Call housekeeping_update()
 without holding cpus_read_lock
To: Waiman Long <llong@redhat.com>, Tejun Heo <tj@kernel.org>,
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
References: <20260206203712.1989610-1-longman@redhat.com>
 <20260206203712.1989610-4-longman@redhat.com>
 <e9c4aae2-44ed-42f5-9b4b-b63d59915143@huaweicloud.com>
 <eee7862c-45ac-4acc-b8a7-a560fc21d9b4@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <eee7862c-45ac-4acc-b8a7-a560fc21d9b4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnEvMOioppj7eLGw--.14S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZFyDAFy7Kw45tF1UXFy3XFb_yoW5WF15pr
	yrKFWxJryUtr1ft345Jr1xJryjgw4kJ3W7Grn5JFyUZF47XFn2gryjgrn09FW8Kr4kGry8
	ZryDWrZ3uFyUArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13821-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5665F115FE7
X-Rspamd-Action: no action



On 2026/2/10 4:29, Waiman Long wrote:
> On 2/9/26 2:12 AM, Chen Ridong wrote:
>>>           return;
>>>       }
>>>   -    WARN_ON_ONCE(housekeeping_update(isolated_cpus) < 0);
>>> -    isolated_cpus_updating = false;
>>> +    /*
>>> +     * update_isolation_cpumasks() may be called more than once in the
>>> +     * same cpuset_mutex critical section.
>>> +     */
>>> +    lockdep_assert_held(&cpuset_top_mutex);
>>> +    if (isolcpus_twork_queued)
>>> +        return;
>>> +
>>> +    init_task_work(&twork_cb, isolcpus_tworkfn);
>>> +    if (!task_work_add(current, &twork_cb, TWA_RESUME))
>>> +        isolcpus_twork_queued = true;
>>> +    else
>>> +        WARN_ON_ONCE(1);    /* Current task shouldn't be exiting */
>>>   }
>>>   
>> Timeline:
>>
>> user A            user B
>> write isolated cpus    write isolated cpus
>> isolated_cpus_update
>> update_isolation_cpumasks
>> task_work_add
>> isolcpus_twork_queued =true
>>
>> // before returning userspace
>> // waiting for worker
>>             isolated_cpus_update
>>             if (isolcpus_twork_queued)
>>                 return // Early exit
>>             // return to userspace
>>
>> // workqueue finishes
>> // return to userspace
>>
>> For User B, the isolated_cpus value appears to be set and the syscall returns
>> successfully to userspace. However, because isolcpus_twork_queued was already
>> true (set by User A), User B's call skipped the actual mask update
>> (update_isolation_cpumasks).
>> Thus, the new isolated_cpus value is not yet effective in the kernel, even
>> though User B's write operation returned without error.
>>
>> Is this a valid issue? Should User B's write be blocked?
> 
> It is perfectly possible that isolated_cpus can be modified more than one time
> from different tasks before a work or task_work function is executed. When that
> function is invoked, isolated_cpus should contain changes for both. It will copy
> isolated_cpus to isolated_hk_cpus and pass it to housekeeping_update(). When the

It is clear about isolated_hk_cpus and isolated_cpus.

> 2nd work or task_work function is invoked, it will see that isolated_cpus match
> isolated_hk_cpus and skip the housekeeping_update() action. There is no need to
> block user B's write as only one task can update isolated_cpus at any time.
> 

The main question remains: user B receives a success return even though
isolated_hk_cpus has not yet taken effect (i.e.,
/sys/devices/system/cpu/isolated does not reflect the change). In that case, how
can user B confirm whether their configuration is actually applied?

-- 
Best regards,
Ridong


