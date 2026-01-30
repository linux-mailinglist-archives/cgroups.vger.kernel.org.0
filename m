Return-Path: <cgroups+bounces-13528-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLCoG0X+e2lEJwIAu9opvQ
	(envelope-from <cgroups+bounces-13528-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 01:41:41 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE33B5FD4
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 01:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C125A301875E
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 00:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2E72C326B;
	Fri, 30 Jan 2026 00:41:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9C129C35A;
	Fri, 30 Jan 2026 00:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769733698; cv=none; b=mBYFGYSby4D0E00uwlSIABtheG2eY71W+XpTYvWYSTimhGINDPmY3o+uvhFRqJ5gWIGvkKXRIqOylV8D1JlcdWLnZq3KKSM+qbwvl2yKx1oa2lmDizt7g6mLVyMHBbIJ1j8zKZPhv86iKuVHHtWYXWijKNPJusrfn++kGtkQcGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769733698; c=relaxed/simple;
	bh=51cxfr91r3SiAdAdAZM7WNT9UW8ltMzOFMW/Uu0PCxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KP0icG+UWYet5fhlJoRrJLvw7aeMxP5ql/FW1RG11KP/mxfzXca+8qnpVo9WkcQHVqX8gN9M3XLoXCmZqnYuxuUBYeSsJfmdg2w1BWCeMTjExLn/36Wm4GG9+5gsSROqOQcFyGaurrpQs6NBgrHBy5rXlab1/FeV7ibNdh1gv0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4f2HHx0sXvzKHM0J;
	Fri, 30 Jan 2026 08:41:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E0BBB4056E;
	Fri, 30 Jan 2026 08:41:31 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgAHs_M6_ntpZYpgFg--.39640S2;
	Fri, 30 Jan 2026 08:41:31 +0800 (CST)
Message-ID: <ace5c0e3-84fe-469a-babd-4e460ba074dd@huaweicloud.com>
Date: Fri, 30 Jan 2026 08:41:29 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup: increase maximum subsystem count from 16 to
 32
To: Waiman Long <llong@redhat.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, inwardvessel@gmail.com,
 shakeel.butt@linux.dev, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 lujialin4@huawei.com
References: <20260129063133.209874-1-chenridong@huaweicloud.com>
 <asryf3kk6c337l33faqpeznk7d4a3rxblzmqrawxffq7sfbaf7@5yfzzdroltjq>
 <3a12eb16-3a91-4278-9dfd-6c6f424e7f9f@huaweicloud.com>
 <6fc1fb93-7010-4381-a9a9-68a9b81acf88@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <6fc1fb93-7010-4381-a9a9-68a9b81acf88@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHs_M6_ntpZYpgFg--.39640S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr15Gry3tr1rtrWUWF1rZwb_yoW5XrWDpr
	Z8G3W7KF4DJFy3Ca1vva4I9a4FqF43Kw1UXr1kGry8ArWY9ryIgr1293yj9Fy7XF4fCw47
	tFWYga4Iva4UA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,goodmis.org,efficios.com,gmail.com,linux.dev,vger.kernel.org,huawei.com];
	TAGGED_FROM(0.00)[bounces-13528-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.916];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DDE33B5FD4
X-Rspamd-Action: no action



On 2026/1/30 2:33, Waiman Long wrote:
> On 1/29/26 4:51 AM, Chen Ridong wrote:
>>
>> On 2026/1/29 17:23, Michal Koutný wrote:
>>> On Thu, Jan 29, 2026 at 06:31:33AM +0000, Chen Ridong
>>> <chenridong@huaweicloud.com> wrote:
>>>> From: Chen Ridong <chenridong@huawei.com>
>>>>
>>>> The current cgroup subsystem limit of 16 is insufficient, as the number of
>>>> subsystems has already reached this maximum.
>>> Indeed. But some of them are legacy (and some novel). Do you really need
>>> one kernel image with every subsys config enabled?
>>>
>> We compiled with 'make allmodconfig'.
>>
>>>> Attempting to add new subsystems beyond this limit results in boot
>>>> failures.
>>> That sounds like BUILD_BUG_ON(CGROUP_SUBSYS_COUNT > 16) doesn't trigger
>>> during build for you. Is the macro broken?
>>>
>> The BUILD_BUG_ON(CGROUP_SUBSYS_COUNT > 16) macro worked correctly. However, I
>> only modified the code to allow compilation to pass, and the system subsequently
>> failed to boot.
>>
>>>> This patch increases the maximum number of supported cgroup subsystems from
>>>> 16 to 32, providing adequate headroom for future subsystem additions.
>>> It may be needed one day but I'd suggest binding this change with
>>> introduction of actual new controller.
>>> (As we have some CONFIG_*_V1 options that default to N, I'm thinking
>>> about switching config's default to N as well (like:
>>> CONFIG_CGROUP_CPUACCT CONFIG_CGROUP_DEVICE CONFIG_CGROUP_FREEZER
>>> CONFIG_CGROUP_DEBGU), arch/x86/configs/x86_64_defconfig is not exactly
>>> pinnacle of freshness :-/)
>>>
>>>
>> Can I propose increasing the maximum number now? If we switch certain configs to
>> default N and then a new subsystem is added later, the default configuration may
>> work fine, but it will become a problem under allmodconfig — which some users
>> actually rely on.
>>
>> Besides, this shouldn't be a major change, right?
> 
> Yes, I agreed that it is not a major change. I count the number of SUBSYS() in
> include/linux/cgroup_subsys.h and there are exactly 16 of them. So introduction
> of a new cgroup subsystem will break the current limit. I remember that there
> was talk about adding scheduling cgroup on the GPU side. One day, a new cgroup

Thanks, Longman,

Now that dmem has been added, I believe a new subsystem for GPU scheduling will
be introduced soon.

> subsystem may be added without the awareness that the subsystem limit has to be
> extended causing issue down the line. So I support the idea of extending it now
> so that there is one less thing to worry about when a new cgroup subsystem is
> added in the future.
> 
> Acked-by: Waiman Long <longman@redhat.com>
> 
> 

-- 
Best regards,
Ridong


