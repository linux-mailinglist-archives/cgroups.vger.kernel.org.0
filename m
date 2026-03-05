Return-Path: <cgroups+bounces-14631-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLoNNGgqqWkE2wAAu9opvQ
	(envelope-from <cgroups+bounces-14631-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 08:02:00 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EFD20C15E
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 08:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7AA833016146
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2026 07:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1AE3101B2;
	Thu,  5 Mar 2026 07:01:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8354F307AD5;
	Thu,  5 Mar 2026 07:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772694111; cv=none; b=VRF7OfbdUszorS5TNd3Z7XUhKptVWWDgt0PTaVQgOUf/UKWwJZX7hW/7Hbs1bWSmwG/Fpe84Abz+AcnCqtMklFI6xVtV40Hoci6vtK9+r3fbdfWC6rwkuDo+BvQDqaak8KtuaaYMM7ZHnLV5ok5NnMEEG46rcSfUDaxlbSRlu1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772694111; c=relaxed/simple;
	bh=H0teOXC23+MR0iQWshjHv2QsrQTep16HEgi8Ac898y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TlwQRkq20DFNzl+7cfIwbRHD5Kxs1BHaedCBvK5yOwgyJg11cnIHON7WdGN5l6Sm6e4JecOf24W2TRScQSzNLJV+8cT5GhahwIG3NvL6ftffv9wFD4PuuvcbONZg89fWs722er7XgVxPcmciqnqFhtbKHYpQWqkyd5tyA1tplow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fRL6W3CPdzYQtvx;
	Thu,  5 Mar 2026 15:01:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4D37840575;
	Thu,  5 Mar 2026 15:01:44 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgCXQ_RWKqlpLaSPJg--.31504S2;
	Thu, 05 Mar 2026 15:01:44 +0800 (CST)
Message-ID: <7018d437-a132-4a26-9c46-e61c96775fb4@huaweicloud.com>
Date: Thu, 5 Mar 2026 15:01:42 +0800
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
 <372e0d67-ab3f-427f-970d-5d1c7cb68c92@huaweicloud.com>
 <aaZbz6FWxJ97kdNu@linux.dev>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <aaZbz6FWxJ97kdNu@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCXQ_RWKqlpLaSPJg--.31504S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1rXr43tw48Gw17WFW8Xrb_yoW8Gry5pa
	yqy3Zaka1qgrWYgr109as0q3sY934xtF47ZFW0vryktrZrZFyftF47AF1UuF47ArZ7G3yx
	Zr1Yqr9xC398Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Rspamd-Queue-Id: C0EFD20C15E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-0.990];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	TAGGED_FROM(0.00)[bounces-14631-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,huaweicloud.com:mid]
X-Rspamd-Action: no action



On 2026/3/3 12:01, Shakeel Butt wrote:
> On Tue, Mar 03, 2026 at 11:18:17AM +0800, Chen Ridong wrote:
>>
>>
> [...]
>>> @@ -4689,6 +4689,12 @@ void cgroup_file_notify(struct cgroup_file *cfile)
>>>  	unsigned long flags;
>>>  	struct kernfs_node *kn = NULL;
>>>  
>>> +	if (!READ_ONCE(cfile->kn))
>>> +		return;
>>> +
>>> +	if (timer_pending(&cfile->notify_timer))
>>> +		return;
>>> +
>>
>> The added timer_pending() check seems problematic. According to the function's
>> comment, callers must ensure serialization with other timer operations. Here
>> we're checking timer_pending() locklessly, which means we might:
>>
> 
> That comment seems outdated. Check the commit 90c018942c2ba ("timer: Use
> hlist_unhashed_lockless() in timer_pending()").
> 

Maybe we should update the comment.

>> 1. See an inconsistent state if another CPU is concurrently modifying the timer
>>
> 
> It will not see inconsistent state but it can see stale state which is totally
> fine. At worst we will take the lock and recheck but we will never miss the
> notifications.
> 

You are right. Thank you for explanation.


>> 2. Race with del_timer() or mod_timer() from other contexts
>>
>>>  	spin_lock_irqsave(&cgroup_file_kn_lock, flags);
>>>  	if (cfile->kn) {
>>>  		unsigned long last = cfile->notified_at;
>>
>> -- 
>> Best regards,
>> Ridong
>>

-- 
Best regards,
Ridong


