Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5403A26A996
	for <lists+cgroups@lfdr.de>; Tue, 15 Sep 2020 18:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgIOQUe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Sep 2020 12:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgIOQUD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Sep 2020 12:20:03 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF67C0611BC;
        Tue, 15 Sep 2020 09:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=gtbrt8dJvKGHqvO+xWVhJDadXOXm7TXL2RE8ocfRdrU=; b=YqV8EnuDoph6ku6oHt9bx4qUwH
        KCZuDIAfFZknOwjfV+X/HK/ns4hKfz+uJoTC0Dg/MiUtHBr/U3QjAmuqYuF0IriwVx9ktkYnJtyWe
        q0U+yndgpPFNawlhOeefRJi7NmEX3tz1to/MpP8mBy6agxzAxzN5gpuwMEolreI1xu3kZICFJZ03M
        Rsz9WpOpYypQrogf3aEzzzzp4SvhUCMYp4g2YkdJn5w6Cj8mj6HjVdDZTzoVuC0AeyBFktr5xDn6v
        t/0m1BM8miYt+1+xl5yDYv5nAsskVRWIpiWdx00+BuANy7G7O6bQtgsIfTg+sXt9mpH/B/f1PEKHc
        EaY3jqbA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIDgS-0000iB-7x; Tue, 15 Sep 2020 16:19:56 +0000
Subject: Re: [External] Re: [PATCH v4] mm: memcontrol: Add the missing
 numa_stat interface for cgroup v2
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Cgroups <cgroups@vger.kernel.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <20200915055825.5279-1-songmuchun@bytedance.com>
 <a3e2a7bf-ae5a-9ca8-74f9-57af795f0380@infradead.org>
 <CAMZfGtVQtsFmU_5DVSZ1mFCnqZrPHrJFKT81Zg8TXDM7c74TDQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f2ec1c19-b86b-887e-186a-3a8c3014857d@infradead.org>
Date:   Tue, 15 Sep 2020 09:19:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtVQtsFmU_5DVSZ1mFCnqZrPHrJFKT81Zg8TXDM7c74TDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/15/20 9:01 AM, Muchun Song wrote:
> On Tue, Sep 15, 2020 at 11:45 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>

>>> +static int __init numa_stats_init(void)
>>> +{
>>> +     int i;
>>> +
>>> +     for (i = 0; i < ARRAY_SIZE(numa_stats); i++) {
>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>> +             if (numa_stats[i].idx == NR_ANON_THPS)
>>> +                     numa_stats[i].ratio = HPAGE_PMD_SIZE;
>>> +#endif
>>> +     }
>>
>> Although the loop may be needed sometime in the future due to
>> other changes.. why couldn't it be like this for now?
> 
> The compiler is so smart, so there is nothing difference between
> them. I disassemble the numa_stats_init when
> !CONFIG_TRANSPARENT_HUGEPAGE.
> 
> Dump of assembler code for function numa_stats_init:
>    0xffffffff8273b061 <+0>: callq  0xffffffff81057490 <__fentry__>
>    0xffffffff8273b066 <+5>: xor    %eax,%eax
>    0xffffffff8273b068 <+7>: retq
> 

Of course!  Thanks.

>>
>>
>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>> +     for (i = 0; i < ARRAY_SIZE(numa_stats); i++) {
>>> +             if (numa_stats[i].idx == NR_ANON_THPS)
>>> +                     numa_stats[i].ratio = HPAGE_PMD_SIZE;
>>> +     }
>>> +#endif
>>
>>
>>> +
>>> +     return 0;
>>> +}
>>> +pure_initcall(numa_stats_init);


-- 
~Randy

