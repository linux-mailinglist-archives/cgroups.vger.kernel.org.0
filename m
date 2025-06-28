Return-Path: <cgroups+bounces-8651-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB145AEC657
	for <lists+cgroups@lfdr.de>; Sat, 28 Jun 2025 11:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009666E1754
	for <lists+cgroups@lfdr.de>; Sat, 28 Jun 2025 09:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA6723496F;
	Sat, 28 Jun 2025 09:22:10 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B4B22D7A3;
	Sat, 28 Jun 2025 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751102530; cv=none; b=D48w+xrxNLOi02LRpmxqKqcG0aRrNTXa3V/fyTHK0vEXJWrgvJJ/r/0GOlSDkc1Mvth2RYqN1SDv9GCggPcxho21B+zAbkI+Syf73pSj8RfsJtyQqlZpXuyZCAmO4RwzKsdJlrnb8pzZb4xzciPwtYCIKd5FU0s07dyB+1S+jUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751102530; c=relaxed/simple;
	bh=QUOS+HvGyFdvKSqcqGa6OFGMDQ3aX+zKrKd2zd4y1hY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptOTGmJIzhAzSpxe+FnO87xv8ppgVpjN0PpdeBo4DgRv4Hso/OJnD1KdRNGqW3kECPph4Mt0DLwaGD6ryLpnG2nQ7zDksuTIJlwNSmrmVb+rJAFE+/bn8fy8//gtz64wRmLg8uFnOZIQ29vmgbim4yM+q6qZalraXtDw43WdV7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bTn4Q38YvzYQv9p;
	Sat, 28 Jun 2025 17:21:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 51D781A0F13;
	Sat, 28 Jun 2025 17:21:57 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgCXN8IztF9obdycQg--.62094S2;
	Sat, 28 Jun 2025 17:21:57 +0800 (CST)
Message-ID: <38e443b1-582c-44ea-a7d4-6d2135414521@huaweicloud.com>
Date: Sat, 28 Jun 2025 17:21:55 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/28] Eliminate Dying Memory Cgroup
To: Shakeel Butt <shakeel.butt@linux.dev>, Kairui Song <ryncsn@gmail.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Muchun Song <songmuchun@bytedance.com>,
 hannes@cmpxchg.org, mhocko@kernel.org, akpm@linux-foundation.org,
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
 <5f622eec-a039-4e82-9f37-3cad1692f268@huaweicloud.com>
 <CAMgjq7ASpGjJme4OwHu+=ys95W4jNZaJd3Yn9t2cL-qeCs4W-Q@mail.gmail.com>
 <lnrtyl66sz6iiw74mf6nurcm5tqmsyecnbmhrlouswp6kgfyqi@umvk6uxb3y7h>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <lnrtyl66sz6iiw74mf6nurcm5tqmsyecnbmhrlouswp6kgfyqi@umvk6uxb3y7h>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCXN8IztF9obdycQg--.62094S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZrWkGryktry8Gr4UZF4DCFg_yoW5Xr1DpF
	WrXF4jyF4kAr95A3yIy3yYgF4Utr97Wr15Zrn8Jr1Dtw1qvF1FyF47CrWruas7ur1xAr40
	vrWY9342g3WqyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/6/28 3:14, Shakeel Butt wrote:
> On Sat, Jun 28, 2025 at 02:54:10AM +0800, Kairui Song wrote:
>> On Fri, Jun 27, 2025 at 5:02 PM Chen Ridong <chenridong@huaweicloud.com> wrote:
>>> On 2025/4/28 11:43, Kairui Song wrote:
>>>> On Fri, Apr 18, 2025 at 5:45 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>>>>>
>>>>> On Fri, Apr 18, 2025 at 02:22:12AM +0800, Kairui Song wrote:
>>>>>>
>>>>>> We currently have some workloads running with `nokmem` due to objcg
>>>>>> performance issues. I know there are efforts to improve them, but so
>>>>>> far it's still not painless to have. So I'm a bit worried about
>>>>>> this...
>>>>>
>>>>> Do you mind sharing more details here?
>>>>>
>>>>> Thanks!
>>>>
>>>> Hi,
>>>>
>>>> Sorry for the late response, I was busy with another series and other works.
>>>>
>>>> It's not hard to observe such slow down, for example a simple redis
>>>> test can expose it:
>>>>
>>>> Without nokmem:
>>>> redis-benchmark -h 127.0.0.1 -q -t set,get -n 80000 -c 1
>>>> SET: 16393.44 requests per second, p50=0.055 msec
>>>> GET: 16956.34 requests per second, p50=0.055 msec
>>>>
>>>> With nokmem:
>>>> redis-benchmark -h 127.0.0.1 -q -t set,get -n 80000 -c 1
>>>> SET: 17263.70 requests per second, p50=0.055 msec
>>>> GET: 17410.23 requests per second, p50=0.055 msec
>>>>
>>>> And I'm testing with latest kernel:
>>>> uname -a
>>>> Linux localhost 6.15.0-rc2+ #1594 SMP PREEMPT_DYNAMIC Sun Apr 27
>>>> 15:13:27 CST 2025 x86_64 GNU/Linux
>>>>
>>>> This is just an example. For redis, it can be a workaround by using
>>>> things like redis pipeline, but not all workloads can be adjusted
>>>> that flexibly.
>>>>
>>>> And the slowdown could be amplified in some cases.
>>>
>>> Hi Kairui,
>>>
>>> We've also encountered this issue in our Redis scenario. May I confirm
>>> whether your testing is based on cgroup v1 or v2?
>>>
>>> In our environment using cgroup v1, we've identified memcg_account_kmem
>>> as the critical performance bottleneck function - which, as you know, is
>>> specific to the v1 implementation.
>>>
>>> Best regards,
>>> Ridong
>>
>> Hi Ridong
>>
>> I can confirm I was testing using Cgroup V2, and I can still reproduce
>> it, it seems the performance gap is smaller with the latest upstream
>> though, but still easily observable.
>>
>> My previous observation is that the performance drain behaves
>> differently with different CPUs, my current test machine is an Intel
>> 8255C. I'll do a more detailed performance analysis of this when I
>> have time to work on this. Thanks for the tips!
> 
> Please try with the latest upstream kernel i.e. 6.16 as the charging
> code has changed a lot.

Thanks, I will try.


