Return-Path: <cgroups+bounces-9344-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 012B6B32610
	for <lists+cgroups@lfdr.de>; Sat, 23 Aug 2025 02:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF27A25678
	for <lists+cgroups@lfdr.de>; Sat, 23 Aug 2025 00:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8343013AD05;
	Sat, 23 Aug 2025 00:57:17 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFD8136672
	for <cgroups@vger.kernel.org>; Sat, 23 Aug 2025 00:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755910637; cv=none; b=jT9zPFVxU9FsPZq7SyOyl3CX1CFwAA+CLM8iaqcHcgisj0755fE3OymjjkIfZwz3lSVwSGYiQG0dMfqZTn4UZWG8ibzNgzPHqXD9sQ4WQDrOq0uq1KPs+G2tkEhfM/zCiJU0spCtHdbznNb2nqjij+FbdP62nZf9JVys52/IByI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755910637; c=relaxed/simple;
	bh=iM/KgMYU/VhbkOk0wpLzXwWCxM2Bb7GflZygsMkdLnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gA8/+xc/w62IerPWi8JMIUaLjQGPgugJ4jZNV15WpEMUirhXKUC5vJx/dwPKPUmDtMhqPIdY51owGC/P6XdYHd0qArCpWqQs+Oe/HrFA4ARCOVaxrKynpuydZTJzb7HVhQBA6vZ+E+67TpyLPK+UE3rzNkfzwgQKUcRQ4cQzPgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c7zD82FZhzKHMpM
	for <cgroups@vger.kernel.org>; Sat, 23 Aug 2025 08:57:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D0E7A1A06E0
	for <cgroups@vger.kernel.org>; Sat, 23 Aug 2025 08:57:11 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP1 (Coremail) with SMTP id cCh0CgDXR7PmEaloxzsUEg--.21848S2;
	Sat, 23 Aug 2025 08:57:11 +0800 (CST)
Message-ID: <c3451e0d-694a-409e-839c-2491181f870f@huaweicloud.com>
Date: Sat, 23 Aug 2025 08:57:10 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: unexpected behaviour of cgroups v1 on 6.12 kernel
To: Chris Friesen <chris.friesen@windriver.com>, cgroups@vger.kernel.org,
 lizefan@huawei.com
References: <f5a182a3-ca68-4917-b232-721445fbc928@windriver.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <f5a182a3-ca68-4917-b232-721445fbc928@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDXR7PmEaloxzsUEg--.21848S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw15Gw15JFWfZr4rZF1kKrg_yoW5Xw1Upr
	Z2kF17GFnxJ3Z5Cw1vk3sruw1rG3WkAFWUtayFkr1vvrnxWws7G3WqyFy8Wry7urnagFW2
	yrW5Awn3uFn8ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/23 3:31, Chris Friesen wrote:
> Hi all,
> 
> I'm not subscribed to the list, so please CC me on replies.
> 
> I'm seeing some unexpected behaviour with the cpu/cpuset cgroups controllers (with cgroups v1) on
> 6.12.18 with PREEMPT_RT enabled.
> 
> I set up the following cgroup hierarchy for both cpu and cpuset cgroups:
> 
> foo:   cpu 15, shares 1024
> foo/a: cpu 15, shares 1024
> 
> bar:   cpu 15-19, shares 1024
> bar/a: cpu 15, shares 1024
> bar/b: cpu 16, shares 1024
> bar/c: cpu 17, shares 1024
> bar/d: cpu 18, shares 1024
> bar/e: cpu 19, shares 1024
> 
> I then ran a single cpu hog in each of the leaf-node cgroups in the default SCHED_OTHER class.
> 
> As expected, the tasks in bar/b, bar/c, bar/d, and bar/e each got 100% of their CPU.  What I didn't
> expect was that the task running in foo/a got 83.3%, while the task in bar/a got 16.7%.  Is this
> expected?
> 
> I guess what I'm asking here is whether the cgroups CPU share calculation is supposed to be
> performed separately per CPU, or whether it's global but somehow scaled by the number of CPUs that
> the cgroup is runnable on, so that the total CPU time of group "bar" is expected to be 5x the total
> CPU time of group "foo".
> 

Hello Chris,

First of all, cpu and cpuset are different control group (cgroup) subsystems. If I understand
correctly, the behavior you're observing is expected.

Have the CPU shares been configured as follows?
		P
	     /	   \	
 (1024:50%) foo	  bar(1024:50%)
 	    |     / \
(50%*100%)  a 	a b c d e(1024:50%*20%)

The cpu subsystem allocates CPU time proportionally based on share weights. In this case, foo and
bar are each expected to receive 50% of the total CPU time.

Within foo, subgroup a is configured to get 100% of foo's allocation, meaning it receives the full
50% of total CPU.

Within bar, the bar/a, b, c, d, and e each have a share weight of 20% relative to bar's total
allocation if they you have tasks in each cgroup. This means each would get approximately 10% of the
total CPU time (i.e., 50% × 20%).

This behavior is specific to the cpu subsystem and is independent of cpuset.

> I then killed all the tasks in bar/b, bar/c, bar/d, and bar/e.  The tasks in foo/a and bar/a
> continued for a while at 83/16, then moved to 80/20, and only about 75 seconds later finally moved
> to 50/50.    Is this long time to "rebalance" expected?  If so, can this time be modified by the
> admin user at runtime or is it inherent in the code?
> 
> As further data, if I have tasks in foo/a, bar/a, bar/b, bar/c then foo/a gets 75%, bar/a gets 25%,
> bar/b and bar/c both get 100%.
> 
> If I have tasks in foo/a, bar/a, bar/b then foo/a gets 66%, bar/a gets 33%, bar/b gets 100%.  (But
> it started out with foo/a getting 75% and switched 10s of seconds later, which seems odd.)
> 
> Thanks,
> Chris

-- 
Best regards,
Ridong


