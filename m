Return-Path: <cgroups+bounces-13368-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGDnOkQkcmnhdgAAu9opvQ
	(envelope-from <cgroups+bounces-13368-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 14:21:08 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 979E56732B
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 14:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3540842C086
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 12:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5764A3BB9EE;
	Thu, 22 Jan 2026 12:04:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E0435E529;
	Thu, 22 Jan 2026 12:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083445; cv=none; b=muiaDV2ObB8X+SufP2kyiPEYTtmmzAN9ZKuMMK/APodY+4vM3TmRXPsHOwJO3VU37XZarVvq9WMHkycmDBMEtBg7902sxVAUrJkP17AIO9phOcMpThJHJTL/dICiWKU9dXfG1AftbEpd1aD0Idz1P9QCLzJCGwnmSqK6d9H9TSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083445; c=relaxed/simple;
	bh=oQwPM1RfwSR94M20hKA20qPTWNQ/lKXRDqOmQoWaWGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C6IHvYS6b+aB/jlTj05WJIJ5UMx2u9r4BoNA9jRF5l+K7Axg2yTyxufPeTn9tn9HOBvlYkHPfQd+xy+ARa26cFi+JzgYkuyuywpgrubGHyspKOdI/5UsMNlhYU3DEglcbQEh/+lSfBn4HwFxOPYgEVPk+jU42HrQA33nR3de9lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dxfqH6d38zKHMWf;
	Thu, 22 Jan 2026 20:03:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 282534056E;
	Thu, 22 Jan 2026 20:03:59 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP1 (Coremail) with SMTP id cCh0CgAnlOktEnJpRsyUEg--.62192S2;
	Thu, 22 Jan 2026 20:03:58 +0800 (CST)
Message-ID: <c01767cc-9f8b-4331-8928-9de97b430cf4@huaweicloud.com>
Date: Thu, 22 Jan 2026 20:03:56 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] sched/isolation: Use
 static_branch_enable_cpuslocked() on housekeeping_update
To: Frederic Weisbecker <frederic@kernel.org>
Cc: longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com
References: <20260122080902.2312721-1-chenridong@huaweicloud.com>
 <aXIN45kR5_PQgtK2@localhost.localdomain>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <aXIN45kR5_PQgtK2@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAnlOktEnJpRsyUEg--.62192S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1kKr1fWr4DZr43ZFyDGFg_yoW5Xr13pF
	y3K3W2vr48Wry0ka9Fva129FW0ya9rGF1UXr97Gw109Fya9F10vFWIgryFqr909r97GF15
	Za4UKa9Iyr4DA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spamd-Result: default: False [-1.26 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MID_RHS_MATCH_FROM(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-13368-lists,cgroups=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:mid,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 979E56732B
X-Rspamd-Action: no action



On 2026/1/22 19:45, Frederic Weisbecker wrote:
> Le Thu, Jan 22, 2026 at 08:09:02AM +0000, Chen Ridong a écrit :
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> The warning is observed:
>>
>>  WARNING: possible recursive locking detected
>>  6.19.0-rc6-next-20260121 #1046 Not tainted
>>  --------------------------------------------
>>  test_cpuset_prs/686 is trying to acquire lock:
>>  (cpu_hotplug_lock){++++}-{0:0}, at: static_key_enable+0xd/0x20
>>
>>  but task is already holding lock:
>>  (cpu_hotplug_lock){++++}-{0:0}, at: cpuset_partition_write+0x72/0x10
>>
>>  other info that might help us debug this:
>>   Possible unsafe locking scenario:
>>
>>         CPU0
>>         ----
>>    lock(cpu_hotplug_lock);
>>    lock(cpu_hotplug_lock);
>>
>>   *** DEADLOCK ***
>>
>>   May be due to missing lock nesting notation
>>
>>  stack backtrace:
>>  CPU: 11 UID: 0 PID: 686 Comm: test_cpuset_prs  6.19.0-rc6-next-20260121 #1
>>  Call Trace:
>>   <TASK>
>>   dump_stack_lvl+0x82/0xd0
>>   print_deadlock_bug+0x288/0x3c0
>>   __lock_acquire+0x1506/0x27f0
>>   lock_acquire+0xc8/0x2d0
>>   ? static_key_enable+0xd/0x20
>>   cpus_read_lock+0x3b/0xd0
>>   ? static_key_enable+0xd/0x20
>>   static_key_enable+0xd/0x20
>>   housekeeping_update+0xe7/0x1b0
>>   update_prstate+0x3f2/0x580
>>   cpuset_partition_write+0x98/0x100
>>   kernfs_fop_write_iter+0x14e/0x200
>>   vfs_write+0x367/0x510
>>   ksys_write+0x66/0xe0
>>   do_syscall_64+0x6b/0x390
>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>  RIP: 0033:0x7f824cf8c887
>>
>> The commit 7109b22e6581 ("cpuset: Update HK_TYPE_DOMAIN cpumask from
>> cpuset") introduced housekeeping_update, which calls static_branch_enable
>> while cpu_read_lock() is held. Since static_key_enable itself also acquires
>> cpu_read_lock, this leads to a lockdep warning. To resolve this issue,
>> replace the call to static_key_enable with static_branch_enable_cpuslocked.
>>
>> Fixes: 7109b22e6581 ("cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset")
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> 
> Thanks for spotting that! Funny that it didn't deadlock when I tested it.
> Ah probably because I always booted with isolcpus= filled.
> 
> So ideally I should add your change as a fixup within
> 7109b22e6581 ("cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset") in order
> not to break bisection.
> 
> Do you mind if I do that? I'll still add your Signed-off-by to the commit.
> 
> Thanks.
> 

I'm not entirely clear on the specifics of "breaking bisection", never mind, I
trust your judgment. Please go ahead and fix it in the way that you like.

-- 
Best regards,
Ridong


