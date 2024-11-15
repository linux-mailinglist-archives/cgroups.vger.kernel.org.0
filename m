Return-Path: <cgroups+bounces-5569-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43229CD4E6
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2024 02:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5E3AB2342A
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2024 01:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCB554769;
	Fri, 15 Nov 2024 01:14:41 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FD22629D;
	Fri, 15 Nov 2024 01:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731633281; cv=none; b=h2qjMBPUjV9wVUQMfujn+QySv1/NbpIU4oe2ZdA5pZDovFCCgG56Ja9I/VRx2tmLJ7/382ILw3KwP7lVXjj7rJ6Hv97OiyoMOWaVKgwRInH1tFtq9gDgqpB4bCAjtB2atCiRHpJAhR1nEo4rkfIvQ6b0YDWkKbIB77fnGK86p8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731633281; c=relaxed/simple;
	bh=ahzNLmvMNb/cOjUYom6iAdTIYn9HWcDKXlYNbiV3aoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d7XZ1vsUSWJCL7yuZ/V44okLwNiw306eK4ogvujB2a1DLtsf2718ujhmyXHkUrGOODzZFkFFaYdAQjrWuwRRXQXd44qLnzNGAewwvgLMuacyvZhHPlDaR3+aPsX52pBmQSrAz6/8SwQoKi4qJPV3BQcGpCS5aPOQG5a7Ry3phq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XqJvW1YL4z4f3nT9;
	Fri, 15 Nov 2024 09:14:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6673C1A0359;
	Fri, 15 Nov 2024 09:14:34 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP1 (Coremail) with SMTP id cCh0CgB3bK54oDZnQ0EVBw--.17204S2;
	Fri, 15 Nov 2024 09:14:34 +0800 (CST)
Message-ID: <2f755161-ec7e-4785-b0ca-ea68c01785a2@huaweicloud.com>
Date: Fri, 15 Nov 2024 09:14:32 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] freezer, sched: report the frozen task stat as 'D'
To: Tejun Heo <tj@kernel.org>
Cc: Valentin Schneider <vschneid@redhat.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, =?UTF-8?Q?mkoutny=40suse=2Ecom_=3E=3E_Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, linux-kernel@vger.kernel.org, wangweiyang2@huawei.com,
 cgroups@vger.kernel.org
References: <20241111135431.1813729-1-chenridong@huaweicloud.com>
 <xhsmhv7wrb3sc.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <4f78d752-52ab-493d-8bf5-f12dc4f554c8@huaweicloud.com>
 <ZzYo19k9ZvkC7V-1@slm.duckdns.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <ZzYo19k9ZvkC7V-1@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgB3bK54oDZnQ0EVBw--.17204S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1xXw4DXrWxKw4xurWfZrb_yoW8Xw1rpF
	ZYk3Z8t3Z7KryqkrnFv3Z7WFyUtrs2qry5XFykGFWxGFnxXrn09ryIvryYgan0krWSyFyU
	Za1Ygas7ZrW7ArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2024/11/15 0:44, Tejun Heo wrote:
> Hello,
> 
> On Thu, Nov 14, 2024 at 03:47:58PM +0800, Chen Ridong wrote:
>> On 2024/11/13 22:34, Valentin Schneider wrote:
>>> On 11/11/24 13:54, Chen Ridong wrote:
>>>> From: Chen Ridong <chenridong@huawei.com>
>>>>
>>>> Before the commit f5d39b020809 ("freezer,sched: Rewrite core freezer
>>>> logic"), the frozen task stat was reported as 'D' in cgroup v1.
>>>> However, after rewriting core freezer logic, the frozen task stat is
>>>> reported as 'R'. This is confusing, especially when a task with stat of
>>>> 'S' is frozen.
>>>>
>>>> This can be reproduced as bellow step:
>>>> cd /sys/fs/cgroup/freezer/
>>>> mkdir test
>>>> sleep 1000 &
>>>> [1] 739         // task whose stat is 'S'
>>>> echo 739 > test/cgroup.procs
>>>> echo FROZEN > test/freezer.state
>>>> ps -aux | grep 739
>>>> root     739  0.1  0.0   8376  1812 pts/0    R    10:56   0:00 sleep 1000
>>>>
>>>> As shown above, a task whose stat is 'S' was changed to 'R' when it was
>>>> frozen. To solve this issue, simply maintain the same reported state as
>>>> before the rewrite.
> 
> The whole point of the freezer rewrite was preventing userspace from causing
> arbitrary and indefinite D states which leads to all sorts of problems. The
> tasks in cgroup2 freezer are *not* in uninterruptible sleeps. They are in
> task stop loops and thus can be killed, ptraced and so on. It *should*
> report S.
> 
> Thanks.
> 

Hi, Tj, There is no ambiguity what cgroup v2 shows. However, in cgroup
v1, the frozen tasks are reported as 'R'.  Do you think this is reseanable?

Thanks,
Ridong


