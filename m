Return-Path: <cgroups+bounces-8753-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF93B08E8D
	for <lists+cgroups@lfdr.de>; Thu, 17 Jul 2025 15:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361311C24751
	for <lists+cgroups@lfdr.de>; Thu, 17 Jul 2025 13:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E6F2F5C52;
	Thu, 17 Jul 2025 13:52:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4019A21ABA4;
	Thu, 17 Jul 2025 13:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752760367; cv=none; b=pnv4ocFUYyABgtlS4Op6defC4+fWvhJ8NAD1ZqOMij3jK4q+iD/MxnrTpmSDh+PBMkhbMfU1L5L2+Ce7HVrVjmYm7TxDpQj3eEWlgv8y5tk0W3z6A+b+n5vuFItPCcT9KbUDcTLjhcCXJHUgTFcVJ/ODK044BwTXrtRtQewumcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752760367; c=relaxed/simple;
	bh=bFNihrOLLu/4+hQ4kY2JMlkTZlhpew4K7aJMJzZ5jI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJrMn5io2IfntiM2cCguXkcvz4CiJ+hFOJm/Ito0pstA9RHbKRW6yyUXNICADqkmTjXgvQyhrWkES/8VodNZQXez7cpKa3xi6jENhhSjr6vrhFsvxS6o/Gg0RL00TyKpZ8xf0svrstzFDyMW5YeEBIeYms+zcossAD8voOSGjMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bjZB24PjDzKHMWS;
	Thu, 17 Jul 2025 21:52:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 37B6C1A18E3;
	Thu, 17 Jul 2025 21:52:41 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP1 (Coremail) with SMTP id cCh0CgCXCLQnAHloMAxFAg--.40108S2;
	Thu, 17 Jul 2025 21:52:40 +0800 (CST)
Message-ID: <6c9278b7-4eb4-4b47-b61a-a5bcc7e558b0@huaweicloud.com>
Date: Thu, 17 Jul 2025 21:52:38 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] cgroup: Track time in cgroup v2 freezer
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Chen Ridong <chenridong@huawei.com>, kernel-team@android.com,
 Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20250714050008.2167786-2-ynaffit@google.com>
 <5rm53pnhpdeqljxqywh26gffh6vlyb5j5s6pzxhv52odhkl4fm@o6p7daoponsn>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <5rm53pnhpdeqljxqywh26gffh6vlyb5j5s6pzxhv52odhkl4fm@o6p7daoponsn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXCLQnAHloMAxFAg--.40108S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGw47JF1UZry5AF48ury7trb_yoWrGr1fpF
	Z8KrW5K3Z5tw1kur1kt3sFvr4Fgw4ktr4UGr95JayIyF9xZ3ZYyF1Ikr1Y93W3CFZ7t342
	v3yYvr95Cw4qyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/7/17 20:56, Michal Koutný wrote:
> Hello Tiffany.
> 
> On Sun, Jul 13, 2025 at 10:00:09PM -0700, Tiffany Yang <ynaffit@google.com> wrote:
>  
>> Other sources of delay can cause similar issues, but this change focuses
>> on allowing frozen time to be accounted for in particular because of how
>> large it can grow and how unevenly it can affect applications running on
>> the system.
> 
> I'd like to incorporate the reason from your other mail:
> | Since there isn't yet a clear way to identify a set of "lost" time
> | that everyone (or at least a wider group of users) cares about, it
> | seems like iterating over components of interest is the best way 
> into this commit message (because that's a stronger ponit that your use
> case alone).
> 
> 
>> Any feedback would be much appreciated!
> 
> I can see benefits of this new stat field conceptually, I have some
> remarks to implementation and suggestions to conventions below.
> 
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -1018,6 +1018,14 @@ All cgroup core files are prefixed with "cgroup."
>>  	it's possible to delete a frozen (and empty) cgroup, as well as
>>  	create new sub-cgroups.
>>  
>> +  cgroup.freeze.stat
> 
> With the given implementation (and use scenario), this'd better exposed
> in
>   cgroup.freeze.stat.local
> 

Would it be possible to add this field to either cgroup.event or cgroup.stat?
Since the frozen status is already tracked in cgroup.event, this placement would maintain better
cohesion with existing metrics.

This is just a suggestion.

Best regards,
Ridong

> I grok the hierarchical summing would make little sense and it'd make
> implementaion more complex. With that I'm thinking about formulation:
> 
> 	Cumulative time that cgroup has spent between freezing and
> 	thawing, regardless of whether by self or ancestor cgroups. NB
> 	(not) reaching "frozen" state is not accounted here.
> 
>> +	A read-only flat-keyed file which exists in non-root cgroups.
>> +	The following entry is defined:
>> +
>> +	  freeze_time_total_ns
>> +		Cumulative time that this cgroup has spent in the freezing
>> +		state, regardless of whether or not it reaches "frozen".
>> +
> 
> Rather use microseconds, it's the cgroup API convention and I'm not
> sure nanosecods exposed here are the needed precision.
> 
>        1    _____
> frozen 0 __/     \__
>           ab    cd
> 
> Yeah, I find the mesurent between a and c the sanest.
> 
> 
>> +static int cgroup_freeze_stat_show(struct seq_file *seq, void *v)
>> +{
>> +	struct cgroup *cgrp = seq_css(seq)->cgroup;
>> +	u64 freeze_time = 0;
>> +
>> +	spin_lock_irq(&css_set_lock);
>> +	if (test_bit(CGRP_FREEZE, &cgrp->flags))
>> +		freeze_time = ktime_get_ns() - cgrp->freezer.freeze_time_start_ns;
>> +
>> +	freeze_time += cgrp->freezer.freeze_time_total_ns;
>> +	spin_unlock_irq(&css_set_lock);
> 
> I don't like taking this spinlock only for the matter of reading this
> attribute. The intention should be to keep the (un)freezeing mostly
> unaffected at the expense of these readers (seqcount or u64 stats?).
> 
> Alternative approach: either there's outer watcher who can be notified
> by cgroup.events:frozen or it's an inner watcher who couldn't actively
> read the field anyway. So the field could only show completed
> freeze/thaw cycles from the past (i.e. not substitute clock_gettime(2)
> when the cgroup is frozen), which could simplify querying the flag too.
> 
>> @@ -5758,6 +5780,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
>>  	 * if the parent has to be frozen, the child has too.
>>  	 */
>>  	cgrp->freezer.e_freeze = parent->freezer.e_freeze;
>> +	cgrp->freezer.freeze_time_total_ns = 0;
> 
> struct cgroup is kzalloc'd, this is unnecessary
> 


