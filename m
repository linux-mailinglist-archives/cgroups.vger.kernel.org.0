Return-Path: <cgroups+bounces-15803-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEDTImt4AmpotQEAu9opvQ
	(envelope-from <cgroups+bounces-15803-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 02:46:35 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B78517F4E
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 02:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64C563017EC4
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 00:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A97188596;
	Tue, 12 May 2026 00:46:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36651DDC2B;
	Tue, 12 May 2026 00:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778546791; cv=none; b=ioo1CVGK5YFXxU2Mwp0Ta1xcHrUWuoogPBPD3adv1i+oB7lbm+owhQPVrfWlR0ulw6AxwwLo+4Hr08ZhqICcxfEVOhKTiBEvTLvmfdwRX4lRbuWUi0LTvFGwDPr3XBOM8yJzgP8P8dEsXFz5RoNx11AVCIE4tzNePzQ25GE5GOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778546791; c=relaxed/simple;
	bh=jYGzlquUlSh2aAKWAfipC8Nzl7gp0fIOAyZqTaaq/uU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PWeJXydHSyXKifMVHnZLVwuv/Wc4vNGO6/fmjUxF2EnxbuC0T+/JjE0+KLlTm/5KU4FhH3SNYoG2YdW6ROwC6mFfUpPmZGmg1o6tI2JeO2YNkREPPEGqKH0SfP20PT0Fn0OfYIIOaKvWM8jtibuQeERc2jQtGSGnt7ih/YO0nHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gDyYn5Gg1zKHMdP;
	Tue, 12 May 2026 08:45:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 6710C4056B;
	Tue, 12 May 2026 08:46:25 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgBHYP5geAJq0zrSBw--.46915S2;
	Tue, 12 May 2026 08:46:25 +0800 (CST)
Message-ID: <9d20f8f5-dbb4-4b39-af0d-8a4b34d77f9c@huaweicloud.com>
Date: Tue, 12 May 2026 08:46:24 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup: Keep favordynmods enabled once per-threadgroup
 rwsem is active
From: Chen Ridong <chenridong@huaweicloud.com>
To: Guopeng Zhang <zhangguopeng@kylinos.cn>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: Yi Tao <escape@linux.alibaba.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260511081607.83490-1-zhangguopeng@kylinos.cn>
 <22d91fdc-db54-4bcf-bc5a-2a496cc43057@huaweicloud.com>
 <85eaa9ae-1558-41a8-bf12-999a9b44bfa9@kylinos.cn>
 <08ab3e19-38f7-4892-b752-c3a601ed15ba@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <08ab3e19-38f7-4892-b752-c3a601ed15ba@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHYP5geAJq0zrSBw--.46915S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1UWFykJFy7KFyDur17Jrb_yoW5uFW5pa
	9rAF9xtws8GFn0yas2va4FgF10ya10qFWxXryDtw1UA3ZIkrs3tr4Iyw1UuFyjvFnrJFW7
	Aw1ayFZ3uF1jy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Queue-Id: 17B78517F4E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15803-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action



On 2026/5/11 20:08, Chen Ridong wrote:
> 
> 
> On 2026/5/11 17:53, Guopeng Zhang wrote:
>>
>>
>> 在 2026/5/11 17:05, Chen Ridong 写道:
>>>
>>>
>>> On 2026/5/11 16:16, Guopeng Zhang wrote:
>>>> cgroup_enable_per_threadgroup_rwsem is a one-way switch. Once it is
>>>> enabled, cgroup.procs writes use the per-threadgroup rwsem and
>>>> cgroup_threadgroup_change_begin()/end() use the same global state to
>>>> decide whether to take and release the per-threadgroup rwsem.
>>>>
>>>> The disable path warned that the per-threadgroup rwsem mechanism could not
>>>> be disabled but still called rcu_sync_exit() and cleared
>>>> CGRP_ROOT_FAVOR_DYNMODS. That partially disabled favordynmods while the
>>>> global per-threadgroup rwsem mode remained enabled: cgroup.procs writes
>>>> would continue to use the per-threadgroup rwsem, while
>>>> cgroup_threadgroup_change_begin()/end() could observe the exited rcu_sync
>>>> state. The root would also no longer report favordynmods.
>>>>
>>>> Make the transition match the documented one-way semantics. Call
>>>> rcu_sync_enter() only for the first favordynmods enable, and make later
>>>> disable attempts a no-op after warning once the per-threadgroup rwsem mode
>>>> has been enabled.
>>>>
>>>> Fixes: 0568f89d4fb8 ("cgroup: replace global percpu_rwsem with per threadgroup resem when writing to cgroup.procs")
>>>> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
>>>> ---
>>>> Manual AB test:
>>>>
>>>> Before this patch:
>>>>   enable favordynmods:
>>>>     cgroup2 opts: rw,relatime,favordynmods
>>>>   disable attempt:
>>>>     cgroup2 opts: rw,relatime
>>>>   dmesg:
>>>>     cgroup: cgroup favordynmods: per threadgroup rwsem mechanism can't be disabled
>>>>
>>>> After this patch:
>>>>   enable favordynmods:
>>>>     cgroup2 opts: rw,relatime,favordynmods
>>>>   disable attempt:
>>>>     cgroup2 opts: rw,relatime,favordynmods
>>>>   dmesg:
>>>>     cgroup: cgroup favordynmods: per threadgroup rwsem mechanism can't be disabled
>>>>
>>>>  kernel/cgroup/cgroup.c | 11 +++++------
>>>>  1 file changed, 5 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>>>> index 6152add0c5eb..fd10fb5b3598 100644
>>>> --- a/kernel/cgroup/cgroup.c
>>>> +++ b/kernel/cgroup/cgroup.c
>>>> @@ -1297,14 +1297,13 @@ void cgroup_favor_dynmods(struct cgroup_root *root, bool favor)
>>>>  	 */
>>>>  	percpu_down_write(&cgroup_threadgroup_rwsem);
>>>>  	if (favor && !favoring) {
>>>> -		cgroup_enable_per_threadgroup_rwsem = true;
>>>> -		rcu_sync_enter(&cgroup_threadgroup_rwsem.rss);
>>>> +		if (!cgroup_enable_per_threadgroup_rwsem) {
>>>
>>> Is this branch redundant? I think if (favor && !favoring) alone should suffice —
>>> or can the outer condition be true twice (i.e., can this block be entered
>>> multiple times)?
>>> Hi Ridong,
>>
>> Thanks for taking a look.
>>
>> I don't think the inner check is redundant. `favoring` is per-root, while
>> `cgroup_enable_per_threadgroup_rwsem` is global.
>>
>> For example, root A may have already enabled favordynmods:
>>
> 
> This functionality is only available for cgroup v2, right?
> 

Sorry for the mistake. I incorrectly recalled that it was only available for v2.
Please ignore that.

-- 
Best regards,
Ridong


