Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45ABD52B2A3
	for <lists+cgroups@lfdr.de>; Wed, 18 May 2022 08:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiERGsl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 May 2022 02:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiERGsk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 May 2022 02:48:40 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5EC19FAD;
        Tue, 17 May 2022 23:48:38 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L33Sg4bgTzgYGJ;
        Wed, 18 May 2022 14:47:15 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 14:48:36 +0800
Subject: Re: [PATCH -next] cgroup: Make cgroup_debug static
To:     Tejun Heo <tj@kernel.org>
CC:     <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220517112523.243386-1-xiujianfeng@huawei.com>
 <YoPWJZ+RJmlvBLwV@slm.duckdns.org>
From:   xiujianfeng <xiujianfeng@huawei.com>
Message-ID: <c099059c-2953-232d-3d53-e8863c221cb0@huawei.com>
Date:   Wed, 18 May 2022 14:48:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YoPWJZ+RJmlvBLwV@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


在 2022/5/18 1:06, Tejun Heo 写道:
> On Tue, May 17, 2022 at 07:25:23PM +0800, Xiu Jianfeng wrote:
>> Make cgroup_debug static since it's only used in cgroup.c
>>
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> The only thing it does is gating CFTYPE_DEBUG which isn't used anymore.
> Can you remove both CFTYPE_DEBUG and cgroup_debug() instead?

It's ok to me, but I found CFTYPE_DEBUG is still used in cpuset subsys,

   .name = "cpus.subpartitions",
   .seq_show = cpuset_common_seq_show,
   .private = FILE_SUBPARTS_CPULIST,
   .flags = CFTYPE_DEBUG,

if remove CFTYPE_DEBUG and cgroup_debug,  cpus.subpartitions will be 
showed by default,  is this ok?

>
> Thanks.
>
