Return-Path: <cgroups+bounces-8640-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3518FAEB1E9
	for <lists+cgroups@lfdr.de>; Fri, 27 Jun 2025 11:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507FE16711B
	for <lists+cgroups@lfdr.de>; Fri, 27 Jun 2025 09:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A52293C4B;
	Fri, 27 Jun 2025 09:02:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDB7293B55;
	Fri, 27 Jun 2025 09:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751014972; cv=none; b=EubNZ2r3AKVEew7o4Cip1zJxfrpDLZxumhTTnScH7H/Pk+dvl3HbD/uZkAWnBiyU9rUXM6udjf2y9RTletzuOH5rWTHPSReqVl1WoeAs5z0+TbEkxMtFdyPRQVbMQJdrtWauyeeIx4vTKS4SXUUqnTOAzSjwoDVWvRzijTgQGmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751014972; c=relaxed/simple;
	bh=qaBguxJ/59Y70qyBDlyzD5aimjI4J8ODIPajo/Wefvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZsdRdF2VAkSNepNq0ahuwu/hslZx+10q/INpl/6B4T0yCqDzfcGg6NAfICWAZVb2cgzxtmxvxDY08zvs6ZKOJ5xKUUAu8tSHSLl2IvAfd9aBgCPsZcAN+bHjfqiwUxabwNj0tRc+ce4XfXZy5zflt7F6Qgf8eoBj8g17NR7UXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bT8hc4FsFzYQvD3;
	Fri, 27 Jun 2025 17:02:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 78AA41A10F6;
	Fri, 27 Jun 2025 17:02:39 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgCH2MItXl5oDsw0Qg--.9912S2;
	Fri, 27 Jun 2025 17:02:39 +0800 (CST)
Message-ID: <5f622eec-a039-4e82-9f37-3cad1692f268@huaweicloud.com>
Date: Fri, 27 Jun 2025 17:02:37 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/28] Eliminate Dying Memory Cgroup
To: Kairui Song <ryncsn@gmail.com>, Roman Gushchin <roman.gushchin@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>,
 Muchun Song <songmuchun@bytedance.com>, hannes@cmpxchg.org,
 mhocko@kernel.org, shakeel.butt@linux.dev, akpm@linux-foundation.org,
 david@fromorbit.com, zhengqi.arch@bytedance.com, yosry.ahmed@linux.dev,
 nphamcs@gmail.com, chengming.zhou@linux.dev, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 yuzhao@google.com
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <CAMgjq7BAfh-op06++LEgXf4UM47Pp1=ER+1WvdOn3-6YYQHYmw@mail.gmail.com>
 <F9BDE357-C7DA-4860-A167-201B01A274FC@linux.dev>
 <CAMgjq7D+GXce=nTzxPyR+t6YZSLWf-8eByo+0NpprQf61gXjPA@mail.gmail.com>
 <aAF2eUG26_xDYIDU@google.com>
 <CAMgjq7BNUMFzsFCOt--mvTqSmgdA65PWcn57G_6-gEj0ps-jCg@mail.gmail.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <CAMgjq7BNUMFzsFCOt--mvTqSmgdA65PWcn57G_6-gEj0ps-jCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCH2MItXl5oDsw0Qg--.9912S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4xtw47CFWUWryUuFyxAFb_yoW8Ar4fpF
	WFqF42kFs5ur95A3y0y34kWFyUta97Wr15Ar1rJrn8tw1DZF1FyF47CrWF9as29r1xZ3yI
	vrWDur4UK3WDZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	bAw3UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/4/28 11:43, Kairui Song wrote:
> On Fri, Apr 18, 2025 at 5:45 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>>
>> On Fri, Apr 18, 2025 at 02:22:12AM +0800, Kairui Song wrote:
>>>
>>> We currently have some workloads running with `nokmem` due to objcg
>>> performance issues. I know there are efforts to improve them, but so
>>> far it's still not painless to have. So I'm a bit worried about
>>> this...
>>
>> Do you mind sharing more details here?
>>
>> Thanks!
> 
> Hi,
> 
> Sorry for the late response, I was busy with another series and other works.
> 
> It's not hard to observe such slow down, for example a simple redis
> test can expose it:
> 
> Without nokmem:
> redis-benchmark -h 127.0.0.1 -q -t set,get -n 80000 -c 1
> SET: 16393.44 requests per second, p50=0.055 msec
> GET: 16956.34 requests per second, p50=0.055 msec
> 
> With nokmem:
> redis-benchmark -h 127.0.0.1 -q -t set,get -n 80000 -c 1
> SET: 17263.70 requests per second, p50=0.055 msec
> GET: 17410.23 requests per second, p50=0.055 msec
> 
> And I'm testing with latest kernel:
> uname -a
> Linux localhost 6.15.0-rc2+ #1594 SMP PREEMPT_DYNAMIC Sun Apr 27
> 15:13:27 CST 2025 x86_64 GNU/Linux
> 
> This is just an example. For redis, it can be a workaround by using
> things like redis pipeline, but not all workloads can be adjusted
> that flexibly.
> 
> And the slowdown could be amplified in some cases.

Hi Kairui,

We've also encountered this issue in our Redis scenario. May I confirm
whether your testing is based on cgroup v1 or v2?

In our environment using cgroup v1, we've identified memcg_account_kmem
as the critical performance bottleneck function - which, as you know, is
specific to the v1 implementation.

Best regards,
Ridong


