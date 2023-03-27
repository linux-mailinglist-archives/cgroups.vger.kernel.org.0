Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C605F6C9955
	for <lists+cgroups@lfdr.de>; Mon, 27 Mar 2023 03:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjC0B3m (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 26 Mar 2023 21:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0B3m (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 26 Mar 2023 21:29:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BF544BE;
        Sun, 26 Mar 2023 18:29:41 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PlFZT0mWszrX6N;
        Mon, 27 Mar 2023 09:28:33 +0800 (CST)
Received: from [10.67.109.31] (10.67.109.31) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 27 Mar
 2023 09:29:38 +0800
Message-ID: <f183b995-9ed1-db80-5f0a-493e77946886@huawei.com>
Date:   Mon, 27 Mar 2023 09:29:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/1] mm: memcontrol: fix vmstats_percpu state incorrect
 subtraction after reparent
References: <20230320030648.50663-1-caixinchen1@huawei.com>
 <20230320030648.50663-2-caixinchen1@huawei.com>
 <20230324171114.32oru5sdubfsfvgi@blackpad>
To:     <mkoutny@suse.com>
From:   Cai Xinchen <caixinchen1@huawei.com>
CC:     <songmuchun@bytedance.com>, <akpm@linux-foundation.org>,
        <hannes@cmpxchg.org>, <longman@redhat.com>, <mhocko@kernel.org>,
        <roman.gushchin@linux.dev>, <shakeelb@google.com>,
        <cgroups@vger.kernel.org>, <duanxiongchun@bytedance.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <yosryahmed@google.com>, <mpenttil@redhat.com>
In-Reply-To: <20230324171114.32oru5sdubfsfvgi@blackpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.31]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Yes, only cgroup v1.

On 2023/3/25 1:11, Michal Koutný wrote:
> Hello.
>
> On Mon, Mar 20, 2023 at 03:06:48AM +0000, Cai Xinchen <caixinchen1@huawei.com> wrote:
>> When memcg C is offllined, its pages are reparented to memcg P,
>> so far P->vmstats (hierarchical) have those pages, and
>> P->vmstats_percpu (non-hierarchical) don't. When those pages get
>> uncharged, P->vmstats (hierachical) decreases, which is correct,
>> but P->vmstats_percpu (non-hierarchical) also decreases, which
>> is wrong, as those stats were never added to P->vmstats_percpu to
>> begin with.
> I was wondering why ->vmstats_percpu matters (in the end all is summed
> in ->vmstats) -- do you mean this is a cgroup v1 only issue? As only
> that exposes the non-hieararchical stats.
>
> Thanks,
> Michal
