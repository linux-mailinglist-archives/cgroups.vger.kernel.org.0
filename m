Return-Path: <cgroups+bounces-11479-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D69C29DD1
	for <lists+cgroups@lfdr.de>; Mon, 03 Nov 2025 03:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6DBEE3480DC
	for <lists+cgroups@lfdr.de>; Mon,  3 Nov 2025 02:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65DC283FF9;
	Mon,  3 Nov 2025 02:32:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D73283686;
	Mon,  3 Nov 2025 02:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762137132; cv=none; b=JjPCYp879mOJoeWeGQMEGycS9jjniL/EndR2IAXaLj6Eb6f1FdIC+JZQyLJLKvvWk4KxJs+MlqvPcT+BzyG/QJpfmI2sL2ImjkZ2xeKXhCfl9v2rQiNpmbGnk2/RPiIlgCkk3zMPaw4bJF7sUd4CTUBbqMfksms4DzbyJLFeKW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762137132; c=relaxed/simple;
	bh=VnBBYLunQzYKbo73WqVJBPX3RlrHr7fLVQ0+GI0Sv3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hPYHbmph26An2xqHiP0jPOaY20HCW4OuOIZKpCmSZYfWHGBf/qART2A29z3TVWC+gkrLcDLJ2KICZ67Ri5xLR04paNbTFWNyyLPwUttOSh6tyfr7pYYopeKFVhuZ645aUQM/S19SYnjplLY16/vhrCtoFgwmhqka4kGv5/Jcz1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d0FwL2HNCzKHMVY;
	Mon,  3 Nov 2025 10:32:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 032E71A18D1;
	Mon,  3 Nov 2025 10:32:06 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP1 (Coremail) with SMTP id cCh0CgDHN0slFAhpPKf4CQ--.38631S2;
	Mon, 03 Nov 2025 10:32:05 +0800 (CST)
Message-ID: <400165fe-18d5-4a78-b4bd-4e5b55de0c04@huaweicloud.com>
Date: Mon, 3 Nov 2025 10:32:04 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/33] cpuset: Provide lockdep check for cpuset lock held
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Danilo Krummrich
 <dakr@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
 Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, netdev@vger.kernel.org
References: <20251013203146.10162-1-frederic@kernel.org>
 <20251013203146.10162-12-frederic@kernel.org>
 <b94f6159-a280-4890-a02a-f19ff808de5b@huaweicloud.com>
 <aQTe6X5XXSp8_3z5@localhost.localdomain>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <aQTe6X5XXSp8_3z5@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHN0slFAhpPKf4CQ--.38631S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tryxCw1kAF1UJrWfKw4DJwb_yoW5Jr1rpF
	yDKFyrCF4rZr4UuFy2qw17uF1vqw4kWF1UGFn5tr18XasFvFn2vF1v9r1Ygr1F9rs7Gw40
	vF17Wa9I9FWqyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8
	Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUsPfHUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/1 0:08, Frederic Weisbecker wrote:
> Le Tue, Oct 14, 2025 at 09:29:25PM +0800, Chen Ridong a écrit :
>>
>>
>> On 2025/10/14 4:31, Frederic Weisbecker wrote:
>>> cpuset modifies partitions, including isolated, while holding the cpuset
>>> mutex.
>>>
>>> This means that holding the cpuset mutex is safe to synchronize against
>>> housekeeping cpumask changes.
>>>
>>> Provide a lockdep check to validate that.
>>>
>>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>>> ---
>>>  include/linux/cpuset.h | 2 ++
>>>  kernel/cgroup/cpuset.c | 7 +++++++
>>>  2 files changed, 9 insertions(+)
>>>
>>> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
>>> index 2ddb256187b5..051d36fec578 100644
>>> --- a/include/linux/cpuset.h
>>> +++ b/include/linux/cpuset.h
>>> @@ -18,6 +18,8 @@
>>>  #include <linux/mmu_context.h>
>>>  #include <linux/jump_label.h>
>>>  
>>> +extern bool lockdep_is_cpuset_held(void);
>>> +
>>>  #ifdef CONFIG_CPUSETS
>>>  
>>>  /*
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index 8595f1eadf23..aa1ac7bcf2ea 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -279,6 +279,13 @@ void cpuset_full_unlock(void)
>>>  	cpus_read_unlock();
>>>  }
>>>  
>>> +#ifdef CONFIG_LOCKDEP
>>> +bool lockdep_is_cpuset_held(void)
>>> +{
>>> +	return lockdep_is_held(&cpuset_mutex);
>>> +}
>>> +#endif
>>> +
>>>  static DEFINE_SPINLOCK(callback_lock);
>>>  
>>>  void cpuset_callback_lock_irq(void)
>>
>> Is the lockdep_is_cpuset_held function actually being used?
>> If CONFIG_LOCKDEP is disabled, compilation would fail with an "undefined reference to
>> lockdep_is_cpuset_held" error.
> 
> Although counter-intuitive, this is how the lockdep_is_held() functions family
> do work.
> 
> This allows this kind of trick:
> 
> if (IS_ENABLED(CONFIG_LOCKDEP))
>    WARN_ON_ONCE(!lockdep_is_held(&some_lock))
> 
> This works during the compilation because the prototype of lockdep_is_held()
> is declared. And since the IS_ENABLED() is resolved during compilation as well,
> the conditional code is wiped out and therefore not linked. As a result the
> linker doesn't even look for the definition of lockdep_is_held() and we don't
> need to define an off case that would return a wrong assumption.
> 
> Thanks.
> 

Thank you for your explanation

-- 
Best regards,
Ridong


