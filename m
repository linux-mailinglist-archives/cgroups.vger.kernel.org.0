Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B43496AB0
	for <lists+cgroups@lfdr.de>; Sat, 22 Jan 2022 08:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiAVHhf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 22 Jan 2022 02:37:35 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:31176 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiAVHhf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 22 Jan 2022 02:37:35 -0500
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Jgp0w2JFGz8wQH;
        Sat, 22 Jan 2022 15:34:40 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 22 Jan 2022 15:37:33 +0800
Received: from [10.67.111.186] (10.67.111.186) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 22 Jan 2022 15:37:32 +0800
Message-ID: <eab13a50-463d-3d45-d58a-77dfebd3b4dd@huawei.com>
Date:   Sat, 22 Jan 2022 15:37:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] cgroup/cpuset: Fix a race between cpuset_attach() and cpu
 hotplug
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <matthltc@us.ibm.com>, <bblum@google.com>, <menage@google.com>,
        <akpm@linux-foundation.org>, <longman@redhat.com>,
        <zhaogongyi@huawei.com>
References: <20220121101210.84926-1-zhangqiao22@huawei.com>
 <20220121155705.GA2394@blackbody.suse.cz>
From:   Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <20220121155705.GA2394@blackbody.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.186]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2022/1/21 23:57, Michal Koutný 写道:
> On Fri, Jan 21, 2022 at 06:12:10PM +0800, Zhang Qiao <zhangqiao22@huawei.com> wrote:
>> Fixes: be367d099270 ("cgroups: let ss->can_attach and ss->attach do whole threadgroups at a time")
> 
> What a deep stratigraphy (not sure if it's this one but anything else
> would likely come from eras ago too).

Yes, I checked again and this bug may have existed since the tag Linux-2.6.12-rc2.
>> Reported-by: Zhao Gongyi <zhaogongyi@huawei.com>
>> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
>> ---
>>  kernel/cgroup/cpuset.c | 2 ++
>>  1 file changed, 2 insertions(+)
> 
> Feel free to include
> Reviewed-by: Michal Koutný <mkoutny@suse.com>
> 
Thanks for your review!

Regards,
Qiao
.

> .
> 
