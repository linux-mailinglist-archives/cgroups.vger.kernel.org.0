Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF27726830D
	for <lists+cgroups@lfdr.de>; Mon, 14 Sep 2020 05:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgINDS7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 13 Sep 2020 23:18:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12244 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725965AbgINDS6 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 13 Sep 2020 23:18:58 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8AAEA707EE2375575932;
        Mon, 14 Sep 2020 11:18:55 +0800 (CST)
Received: from [10.174.178.86] (10.174.178.86) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 14 Sep
 2020 11:18:53 +0800
Subject: Re: [External] Re: [PATCH v3] mm: memcontrol: Add the missing
 numa_stat interface for cgroup v2
To:     Muchun Song <songmuchun@bytedance.com>,
        Chris Down <chris@chrisdown.name>
CC:     <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Cgroups <cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel test robot <lkp@intel.com>
References: <20200913070010.44053-1-songmuchun@bytedance.com>
 <20200913170913.GB2239582@chrisdown.name>
 <CAMZfGtVBFCodKuNKzG8TxKjeuC1_hF_YKdqMTmX5ENE_FfDmzw@mail.gmail.com>
From:   Zefan Li <lizefan@huawei.com>
Message-ID: <91184891-6a12-87a2-5a82-099a637b072f@huawei.com>
Date:   Mon, 14 Sep 2020 11:18:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtVBFCodKuNKzG8TxKjeuC1_hF_YKdqMTmX5ENE_FfDmzw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.86]
X-CFilter-Loop: Reflected
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2020/9/14 11:10, Muchun Song wrote:
> On Mon, Sep 14, 2020 at 1:09 AM Chris Down <chris@chrisdown.name> wrote:
>>
>> Muchun Song writes:
>>> In the cgroup v1, we have a numa_stat interface. This is useful for
>>> providing visibility into the numa locality information within an
>>> memcg since the pages are allowed to be allocated from any physical
>>> node. One of the use cases is evaluating application performance by
>>> combining this information with the application's CPU allocation.
>>> But the cgroup v2 does not. So this patch adds the missing information.
>>>
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>> Suggested-by: Shakeel Butt <shakeelb@google.com>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> This is a feature patch, why does this have LKP's Reported-by?
> 
> In the v2 version, the kernel test robot reported a compiler error
> on the powerpc architecture. So I added that. Thanks.
> 

You should remove this reported-by, and then add v2->v3 changelog:

...original changelog...

v3:
- fixed something reported by test rebot
