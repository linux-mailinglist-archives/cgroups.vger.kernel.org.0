Return-Path: <cgroups+bounces-8782-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A58B0AD68
	for <lists+cgroups@lfdr.de>; Sat, 19 Jul 2025 04:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628525882C6
	for <lists+cgroups@lfdr.de>; Sat, 19 Jul 2025 02:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520E7170A2B;
	Sat, 19 Jul 2025 02:01:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B373D69;
	Sat, 19 Jul 2025 02:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752890475; cv=none; b=j9fVtU6V0kGusNZUnE3wsy7zaOMNFNliu3MNjI6KFsDwgdsP9ld9vLgwddWkCYsl1kVOJo2duUaL5kGSPLODJjJ0FJPIfcTVNJUInkrDUxpSfYifGJk/mNqEG3J2towiK+92l/7BsN/ZSBVZRLZeYIAGBelB01SMHAQxKwpV+GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752890475; c=relaxed/simple;
	bh=WU3V6n9zjOV8QZlhkLTRsU7KI/Ut9psItFf+2W0jSEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e0ZkZsMTxJHQp7C+P//HK0uUJbuT6S5reYHtYcD5YyTHsumAo+Olum5iXDC3FlcoZtHEYXWxUJwF4ENqM9wf8eMWlxv7F6cEKDtdpttpP9MjbK6nBMPMVcP4G22OvY1Yr4A6xqsVQV8Zjrb9dXGN3D2/3aDbrq4Unh1kjkYW4+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bkVJ65s6PzKHN2c;
	Sat, 19 Jul 2025 10:01:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 739D11A0874;
	Sat, 19 Jul 2025 10:01:09 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgCncBFj_Hpo34H2Ag--.17554S2;
	Sat, 19 Jul 2025 10:01:09 +0800 (CST)
Message-ID: <e065b8da-9e7c-4214-9122-83d83700a729@huaweicloud.com>
Date: Sat, 19 Jul 2025 10:01:07 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cpu.stat in core or cpu controller (was Re: [RFC PATCH v2]
 cgroup: Track time in cgroup v2 freezer)
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Tiffany Yang <ynaffit@google.com>,
 linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Chen Ridong <chenridong@huawei.com>, kernel-team@android.com,
 Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20250714050008.2167786-2-ynaffit@google.com>
 <5rm53pnhpdeqljxqywh26gffh6vlyb5j5s6pzxhv52odhkl4fm@o6p7daoponsn>
 <aHktSgmh-9dyB7bz@slm.duckdns.org>
 <mknvbcalyaheobnfeeyyldytcoyturmeuq3twcrri5gaxtjojs@bbyqhshtjfab>
 <180b4c3f-9ea2-4124-b014-226ff8a97877@huaweicloud.com>
 <jyvlpm6whamo5ge533xdsvqnsjsxdonpvdjbtt5gqvcw5fjp56@q4ej7gy5frj7>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <jyvlpm6whamo5ge533xdsvqnsjsxdonpvdjbtt5gqvcw5fjp56@q4ej7gy5frj7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCncBFj_Hpo34H2Ag--.17554S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFykKr1DGrykJrWUWF4kJFb_yoW5XF13pF
	n8Gw4fK3WDGFyxAFn29a1IgryF9w10k34Utrs8uw10ya17Zr97ur4Sya45XFy7Ar97Wr12
	vr429F9rua9FkrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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



On 2025/7/18 21:58, Michal Koutný wrote:
> On Fri, Jul 18, 2025 at 05:26:54PM +0800, Chen Ridong <chenridong@huaweicloud.com> wrote:
>> With the recent merge of the series "cgroup: separate rstat trees," the rstat are not bound to CPU
>> system. This makes me wonder: should we consider moving the cpu.stat and cpu.stat.local interfaces
>> to the CPU subsystem?
> 
> Note that fields printed in cpu.stat are combination of "core" and cpu
> controller values.
> 

Do you mean the "core" values are shown as below:
- usage_usec
- user_usec
- system_usec
- nice_usec

In the legacy cgroup, these values are in the cpuacct subsystem.

>> The CPU subsystem could then align more closely with other resource controllers like memory or I/O
>> subsystems. By decoupling these CPU-specific statistics from the cgroup core, it could help keep
>> both cgroup and rstat implementations more focused.
> 
> In my eyes, cpu controller is stuff encapsulated by cpu_cgrp_subsys. I'm
> not sure I understand what you refer to as the CPU subsystem.
> 
> One thing is how it is presented to users (filenames and content)
> another one is how it is implemented. The latter surely can be
> refactored but it's not obvious to me from the short description, sorry.
> 

What I'm considering is moving the implementation of cpu.stat from cgroup_base_files to
cpu_cgrp_subsys—without changing the user-facing interface (filenames and content remain the same).
However, the interface would only appear if the CPU subsystem is enabled.

Currently, cpu.stat and cpu.stat.local are visible in every cgroup, even when the CPU subsystem is
disabled. The only populated fields in such cases are:

- usage_usec
- user_usec
- system_usec
- nice_usec

I’m unsure whether this change would be acceptable?

>> Is there any particular reason why the CPU subsystem must remain bound
>> to the cgroup core?
> 
> The stuff that's bound to the core is essentially not "control" but only
> accounting, so with this association, the accounting can have fine
> granularity while control (which incurs higher overhead in principle)
> may remain coarse. I find it thus quite fitting that CPU stats build on
> top of rstat.

The implementation would still rely on rstat, similar to memory.stat and io.stat. The goal is to
decouple it from the cgroup core (cgroup.c and rstat.c) while preserving accounting granularity.

Best regards,
Ridong

> (Naturally, my previous claim about overhead is only rough and it's the
> reason for existence of adjustments like in the commit 34f26a15611af
> ("sched/psi: Per-cgroup PSI accounting disable/re-enable interface").)
> 
> Thats how I see it, happy to discuss possible problems you see with
> this.
> 
> Michal


