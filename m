Return-Path: <cgroups+bounces-14541-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEfbBuxQpmmxNwAAu9opvQ
	(envelope-from <cgroups+bounces-14541-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 04:09:32 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F57B1E8553
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 04:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF0DB30A7A50
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 03:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A770C37CD32;
	Tue,  3 Mar 2026 03:08:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EF91A6810;
	Tue,  3 Mar 2026 03:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772507294; cv=none; b=WBmjBZfSg3KTtHFIL78Hw223KmWDVA/bRktBSDZKfE5m1HaFYvDTTmr1SBKZo5W/E2QdqwSkCi4iYCQdSX5bzq1EAKzU2aC2WlVEPw7MUIPsuQuw9fN0tWXMTYfxSYXAc3/fUbHbEc1uHfHyMhmZnw0p3AE+SdnTq22K5P0wjK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772507294; c=relaxed/simple;
	bh=fq6lGRuk4vbotXrNf1S/WwF5IykOhcBaxmdcw2erxK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Je1KmQ5A8PNxDvoM7qFtIHjerezhRRZsh/9158F7qdoEX9hdyci+IgjfWtnBDLXN+KgVOwp8DOeCd5tT26m19Q7cGWh5cIVTEs9mnzUvEmianwxsFepNo7cQx0BgHpJp1FJHZWlfPerH+H7Se66vcsChC5hjqUdpd0GfBJN5tcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fQ11v1HR2zYQtwr;
	Tue,  3 Mar 2026 11:07:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 625254058F;
	Tue,  3 Mar 2026 11:08:04 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgAHtPSTUKZpZsOGJQ--.57459S2;
	Tue, 03 Mar 2026 11:08:04 +0800 (CST)
Message-ID: <17c72eb9-deac-44aa-a055-b3ed9c455498@huaweicloud.com>
Date: Tue, 3 Mar 2026 11:08:02 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] cgroup: add lockless fast-path checks to
 cgroup_file_notify()
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Daniel Sedlak <daniel.sedlak@cdn77.com>,
 Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org,
 netdev@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
References: <20260228142018.3178529-1-shakeel.butt@linux.dev>
 <20260228142018.3178529-3-shakeel.butt@linux.dev>
 <40c77bba-0862-4422-b23e-2a10cd01c728@huaweicloud.com>
 <aaW2feETIF7I65i1@linux.dev>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <aaW2feETIF7I65i1@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAHtPSTUKZpZsOGJQ--.57459S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF17WrW7XrykKFWktrW5Wrg_yoW5trWkpa
	98CF9Yka15GFyUCwn2q34Y9FyFg3yxGrW7XrW7X340yF9rt3WIqFW29r1UWFy8Ars7Gr42
	vr4YqrW3Cr1jyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Queue-Id: 6F57B1E8553
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-0.912];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14541-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huaweicloud.com:mid]
X-Rspamd-Action: no action



On 2026/3/3 0:14, Shakeel Butt wrote:
> Hi Chen, thanks for taking a look.
> 
> On Mon, Mar 02, 2026 at 09:50:53AM +0800, Chen Ridong wrote:
>>
>> Hi Shakeel,
>>
>> Good series to move away from the global lock.
>>
>> On 2026/2/28 22:20, Shakeel Butt wrote:
>>> Add two lockless checks before acquiring the lock:
>>>
>>> 1. READ_ONCE(cfile->kn) NULL check to skip torn-down files.
>>> 2. READ_ONCE(cfile->notified_at) check to skip when within the
>>>    rate-limit window (~10ms).
>>>
>>> Both checks have safe error directions -- a stale read can only cause
>>> unnecessary lock acquisition, never a missed notification.  Annotate
>>> all write sites with WRITE_ONCE() to pair with the lockless readers.
>>>
>>> The trade-off is that trailing timer_reduce() calls during bursts are
>>> skipped, so the deferred notification that delivers the final state
>>> may be lost.  This is acceptable for the primary callers like
>>> __memcg_memory_event() where events keep arriving.
>>>
>>> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
>>> Reported-by: Jakub Kicinski <kuba@kernel.org>
>>> ---
>>>  kernel/cgroup/cgroup.c | 21 ++++++++++++++-------
>>>  1 file changed, 14 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>>> index 33282c7d71e4..5473ebd0f6c1 100644
>>> --- a/kernel/cgroup/cgroup.c
>>> +++ b/kernel/cgroup/cgroup.c
>>> @@ -1749,7 +1749,7 @@ static void cgroup_rm_file(struct cgroup *cgrp, const struct cftype *cft)
>>>  		struct cgroup_file *cfile = (void *)css + cft->file_offset;
>>>  
>>>  		spin_lock_irq(&cgroup_file_kn_lock);
>>> -		cfile->kn = NULL;
>>> +		WRITE_ONCE(cfile->kn, NULL);
>>>  		spin_unlock_irq(&cgroup_file_kn_lock);
>>>  
>>>  		timer_delete_sync(&cfile->notify_timer);
>>> @@ -4430,7 +4430,7 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
>>>  		timer_setup(&cfile->notify_timer, cgroup_file_notify_timer, 0);
>>>  
>>>  		spin_lock_irq(&cgroup_file_kn_lock);
>>> -		cfile->kn = kn;
>>> +		WRITE_ONCE(cfile->kn, kn);
>>>  		spin_unlock_irq(&cgroup_file_kn_lock);
>>>  	}
>>>  
>>> @@ -4686,20 +4686,27 @@ int cgroup_add_legacy_cftypes(struct cgroup_subsys *ss, struct cftype *cfts)
>>>   */
>>>  void cgroup_file_notify(struct cgroup_file *cfile)
>>>  {
>>> -	unsigned long flags;
>>> +	unsigned long flags, last, next;
>>>  	struct kernfs_node *kn = NULL;
>>>  
>>> +	if (!READ_ONCE(cfile->kn))
>>> +		return;
>>> +
>>> +	last = READ_ONCE(cfile->notified_at);
>>> +	if (time_before_eq(jiffies, last + CGROUP_FILE_NOTIFY_MIN_INTV))
>>> +		return;
>>> +
>>
>> Previously, if a notification arrived within the rate-limit window, we would
>> still call timer_reduce(&cfile->notify_timer, next) to schedule a deferred
>> notification.
>>
>> With this change, returning early here bypasses that timer scheduling entirely.
>> Does this risk missing notifications that would have been delivered by the timer?
>>
> 
> You are indeed right that this can cause missed notifications. After giving some
> thought I think the lockless check-and-return can be pretty much simplified to
> timer_pending() check. If timer is active, just do nothing and the notification
> will be delivered eventually.
> 
> I will send the updated version soon. Any comments on the other two patches?
> 

The other two patches are fine to me.

-- 
Best regards,
Ridong


