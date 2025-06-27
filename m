Return-Path: <cgroups+bounces-8639-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA02AEB19A
	for <lists+cgroups@lfdr.de>; Fri, 27 Jun 2025 10:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E053B5B5F
	for <lists+cgroups@lfdr.de>; Fri, 27 Jun 2025 08:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD76227E1C0;
	Fri, 27 Jun 2025 08:50:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E84521A458;
	Fri, 27 Jun 2025 08:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751014235; cv=none; b=qk0vVF1zSnC/OhvsvY3zKHsO0Jl9opjSGK0i/iuqP7AT1pmp7ixpfJs10fMxr1BZZQXGHyB0fUZdi2i6GH7JTcTUq94MHrsujl3sxWis4lJtMjX+aa8eq5Ga0YzRAdQ3G9R2QEsy4FCJjwYyazBhaPB1tW8w10sB0x6K6f8slZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751014235; c=relaxed/simple;
	bh=LIzae4XlfOmtLYCqC62tgUz4RsGxzf2PJrT4q4Upc3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pqzocH6oL1c2JE5cvS42IaN5OgNPNQELso4f73abyr6vue4fjgnc6JnDGZnhU1u6+jHENCFpoNdBW+DLTUykXz7M8vOpxbAHZR1kW9APi0CiDuA7XyAiVQJE0s1215zkkLRwuY7AUThE8u2fFnFg4zyY4L359M6LuHtMVcpnRkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bT8QV590XzKHLyk;
	Fri, 27 Jun 2025 16:50:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1A3681A0899;
	Fri, 27 Jun 2025 16:50:25 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgD3pltPW15oY6k2Qw--.2149S2;
	Fri, 27 Jun 2025 16:50:24 +0800 (CST)
Message-ID: <1b6cb2c2-9aed-456e-a803-afad9731cb42@huaweicloud.com>
Date: Fri, 27 Jun 2025 16:50:23 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/28] Eliminate Dying Memory Cgroup
To: Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <ryncsn@gmail.com>
Cc: Muchun Song <muchun.song@linux.dev>,
 Muchun Song <songmuchun@bytedance.com>, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, akpm@linux-foundation.org,
 david@fromorbit.com, zhengqi.arch@bytedance.com, yosry.ahmed@linux.dev,
 nphamcs@gmail.com, chengming.zhou@linux.dev, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 yuzhao@google.com
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <CAMgjq7BAfh-op06++LEgXf4UM47Pp1=ER+1WvdOn3-6YYQHYmw@mail.gmail.com>
 <F9BDE357-C7DA-4860-A167-201B01A274FC@linux.dev>
 <CAMgjq7D+GXce=nTzxPyR+t6YZSLWf-8eByo+0NpprQf61gXjPA@mail.gmail.com>
 <20250417190404.GA205562@cmpxchg.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20250417190404.GA205562@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3pltPW15oY6k2Qw--.2149S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF45XrWxGr4fGr4fWry5XFb_yoW8ur17pF
	WFyr90yrsYyFW5Xws2ywn29ry5Awn3ZrW3Gr45Gwn5JrnxX3W8tFyIyF45ZF9rur1xAw12
	vr4jg34DC3WYyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/4/18 3:04, Johannes Weiner wrote:
> On Fri, Apr 18, 2025 at 02:22:12AM +0800, Kairui Song wrote:
>> On Tue, Apr 15, 2025 at 4:02 PM Muchun Song <muchun.song@linux.dev> wrote:
>> We currently have some workloads running with `nokmem` due to objcg
>> performance issues. I know there are efforts to improve them, but so
>> far it's still not painless to have. So I'm a bit worried about
>> this...
> 
> That's presumably more about the size and corresponding rate of slab
> allocations. The objcg path has the same percpu cached charging and
> uncharging, direct task pointer etc. as the direct memcg path. Not
> sure the additional objcg->memcg indirection in the slowpath would be
> noticable among hierarchical page counter atomics...
> 

We have encountered the same memory accounting performance issue with
kmem in our environment running cgroup v1 on Linux kernel v6.6. We have
observed significant performance overhead in the following critical path:

alloc_pages
  __alloc_pages
    __memcg_kmem_charge_page
      memcg_account_kmem
        page_counter_charge

Our profiling shows this call chain accounts for over 23% . This
bottleneck occurs because multiple Docker containers simultaneously
charge to their common parent's page_counter, creating contention on the
atomic operations.

While cgroup v1 is being deprecated, many production systems still rely
on it. To mitigate this issue, I'm considering implementing a per-CPU
stock mechanism specifically for memcg_account_kmem (limited to v1
usage). Would this approach be acceptable?

Best regard,
Ridong


>> This is a problem indeed, but isn't reparenting a rather rare
>> operation? So a slow async worker might be just fine?
> 
> That could be millions of pages that need updating. rmdir is no fast
> path, but that's a lot of work compared to flipping objcg->memcg and
> doing a list_splice().
> 
> We used to do this in the past, if you check the git history. That's
> not a desirable direction to take again, certainly not without hard
> data showing that objcg is an absolute no go.


