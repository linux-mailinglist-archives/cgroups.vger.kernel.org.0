Return-Path: <cgroups+bounces-14543-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPAJAz5TpmkbOAAAu9opvQ
	(envelope-from <cgroups+bounces-14543-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 04:19:26 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B6F1E870D
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 04:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 435E5301F7B4
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 03:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCEE37CD37;
	Tue,  3 Mar 2026 03:18:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBAC37B013;
	Tue,  3 Mar 2026 03:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772507904; cv=none; b=UMIRwGWbMPehe6+xVC4ulCezxv32svZpBx+mh0YwRs+yxlUTewJpLNKNy3lhBZ7X8sLfg/u5PPa5vwwmnGnZdMIBszkeGhvCyadKoGbN+5oa3eualoEHOM9H8E/9Y8z8s11YDtmw4IryGM/qqi+GXA/CZtJkdmWYhVJg+aBLK+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772507904; c=relaxed/simple;
	bh=UXVDtn0Wky6XYQn8N9zB6USKEqk2SpVSlJnWGQUwZzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PIHts8PHFQHHA/AOy8sc/VileSScyTTaf+FCU7G9AiTsJthLXB6UOD47WNG0sFia8Fh/fkc7ubwioEBAgnO68vaA9kSfGb04UgMlHFpksYnlgd82VEfo3LiBPTlcCpKJ0lR838jabhq6oGrQxsijOcHR8B5mFJO7zPHKcPiJwDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fQ1Fj5g17zYQtx5;
	Tue,  3 Mar 2026 11:17:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0363340577;
	Tue,  3 Mar 2026 11:18:19 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgBnEvP5UqZpTZ6HJQ--.7626S2;
	Tue, 03 Mar 2026 11:18:18 +0800 (CST)
Message-ID: <372e0d67-ab3f-427f-970d-5d1c7cb68c92@huaweicloud.com>
Date: Tue, 3 Mar 2026 11:18:17 +0800
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
 <aaW2feETIF7I65i1@linux.dev> <aaXB0A7eTbyZ4wA_@linux.dev>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <aaXB0A7eTbyZ4wA_@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBnEvP5UqZpTZ6HJQ--.7626S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF4DKry8JFykGF18Gr1fXrb_yoWrJF4xpa
	90kasaka15GryUJw1vv3WqgF95W3y8GrWUWrWDZ340yFZrtF10qFsFkr1UWFy7AFs7Wr42
	vr4aqry3Cw1jyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUb
	mii3UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Queue-Id: B9B6F1E870D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-0.915];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	TAGGED_FROM(0.00)[bounces-14543-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email,huaweicloud.com:mid]
X-Rspamd-Action: no action



On 2026/3/3 1:00, Shakeel Butt wrote:
> On Mon, Mar 02, 2026 at 08:14:05AM -0800, Shakeel Butt wrote:
>> Hi Chen, thanks for taking a look.
>>
>> On Mon, Mar 02, 2026 at 09:50:53AM +0800, Chen Ridong wrote:
>>>
> [...]
>>>> +	last = READ_ONCE(cfile->notified_at);
>>>> +	if (time_before_eq(jiffies, last + CGROUP_FILE_NOTIFY_MIN_INTV))
>>>> +		return;
>>>> +
>>>
>>> Previously, if a notification arrived within the rate-limit window, we would
>>> still call timer_reduce(&cfile->notify_timer, next) to schedule a deferred
>>> notification.
>>>
>>> With this change, returning early here bypasses that timer scheduling entirely.
>>> Does this risk missing notifications that would have been delivered by the timer?
>>>
>>
>> You are indeed right that this can cause missed notifications. After giving some
>> thought I think the lockless check-and-return can be pretty much simplified to
>> timer_pending() check. If timer is active, just do nothing and the notification
>> will be delivered eventually.
>>
>> I will send the updated version soon. Any comments on the other two patches?
>>
> 
> Something like the following:
> 
>>From 598199723b50813b015393122796f6775eee02d7 Mon Sep 17 00:00:00 2001
> From: Shakeel Butt <shakeel.butt@linux.dev>
> Date: Sat, 28 Feb 2026 04:01:28 -0800
> Subject: [PATCH] cgroup: add lockless fast-path checks to cgroup_file_notify()
> 
> Add two lockless checks before acquiring the lock:
> 
> 1. READ_ONCE(cfile->kn) NULL check to skip torn-down files.
> 2. timer_pending() check to skip when a deferred notification
>    timer is already armed.
> 
> Both checks have safe error directions -- a stale read can only
> cause unnecessary lock acquisition, never a missed notification.
> 
> Annotate cfile->kn write sites with WRITE_ONCE() to pair with the
> lockless reader.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  kernel/cgroup/cgroup.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 2b298a2cf206..6e816d27ee25 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -1749,7 +1749,7 @@ static void cgroup_rm_file(struct cgroup *cgrp, const struct cftype *cft)
>  		struct cgroup_file *cfile = (void *)css + cft->file_offset;
>  
>  		spin_lock_irq(&cgroup_file_kn_lock);
> -		cfile->kn = NULL;
> +		WRITE_ONCE(cfile->kn, NULL);
>  		spin_unlock_irq(&cgroup_file_kn_lock);
>  
>  		timer_delete_sync(&cfile->notify_timer);
> @@ -4430,7 +4430,7 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
>  		timer_setup(&cfile->notify_timer, cgroup_file_notify_timer, 0);
>  
>  		spin_lock_irq(&cgroup_file_kn_lock);
> -		cfile->kn = kn;
> +		WRITE_ONCE(cfile->kn, kn);
>  		spin_unlock_irq(&cgroup_file_kn_lock);
>  	}
>  
> @@ -4689,6 +4689,12 @@ void cgroup_file_notify(struct cgroup_file *cfile)
>  	unsigned long flags;
>  	struct kernfs_node *kn = NULL;
>  
> +	if (!READ_ONCE(cfile->kn))
> +		return;
> +
> +	if (timer_pending(&cfile->notify_timer))
> +		return;
> +

The added timer_pending() check seems problematic. According to the function's
comment, callers must ensure serialization with other timer operations. Here
we're checking timer_pending() locklessly, which means we might:

1. See an inconsistent state if another CPU is concurrently modifying the timer

2. Race with del_timer() or mod_timer() from other contexts

>  	spin_lock_irqsave(&cgroup_file_kn_lock, flags);
>  	if (cfile->kn) {
>  		unsigned long last = cfile->notified_at;

-- 
Best regards,
Ridong


