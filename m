Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C2D5A24FA
	for <lists+cgroups@lfdr.de>; Fri, 26 Aug 2022 11:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245555AbiHZJvB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 Aug 2022 05:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245408AbiHZJvA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 Aug 2022 05:51:00 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50117B1E5;
        Fri, 26 Aug 2022 02:50:58 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MDZkM73dzz19VdR;
        Fri, 26 Aug 2022 17:47:23 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 17:50:56 +0800
Received: from [10.67.109.150] (10.67.109.150) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 17:50:55 +0800
Subject: Re: [RFC 0/2] Introduce cgroup.top interface
To:     Tejun Heo <tj@kernel.org>
CC:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20220826011503.103894-1-lujialin4@huawei.com>
 <Ywg7NcHtfjDKjwXR@slm.duckdns.org>
From:   "lujialin (A)" <lujialin4@huawei.com>
Message-ID: <e6deb22b-506d-d4f6-1a75-58dda4b58bcc@huawei.com>
Date:   Fri, 26 Aug 2022 17:50:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <Ywg7NcHtfjDKjwXR@slm.duckdns.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.150]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Ok, I got it, thanks

ÔÚ 2022/8/26 11:17, Tejun Heo Ð´µÀ:
> Hello,
>
> On Fri, Aug 26, 2022 at 09:15:01AM +0800, Lu Jialin wrote:
>> Cgroup is used to organize and manage resource available processes.
>> Currently there are no handy tool for gathering reousrce usage
>> information for each and every child cgroups, makes it hard to detect
>> resource outage and debug resource issues.
>>
>> To overcome this, we present the cgroup.top interface. Just like the
>> top command, user is able to easily gather resource usage information
>> , allowing user to detect and respond to resource outage in child
>> cgroups
> I don't think this is something we want build into the kernel. Maybe what
> you want is something similar to below?
>
>    https://github.com/facebookincubator/below
>
> Thanks.
>
