Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E28F4E97C0
	for <lists+cgroups@lfdr.de>; Mon, 28 Mar 2022 15:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239954AbiC1NRU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Mar 2022 09:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239211AbiC1NRS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Mar 2022 09:17:18 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FEC1EC62;
        Mon, 28 Mar 2022 06:15:37 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KRtTq649QzcbYJ;
        Mon, 28 Mar 2022 21:15:11 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Mar 2022 21:15:26 +0800
Subject: Re: [PATCH] mm/memcg: remove unneeded nr_scanned
To:     Michal Hocko <mhocko@suse.com>
CC:     <hannes@cmpxchg.org>, <roman.gushchin@linux.dev>,
        <shakeelb@google.com>, <akpm@linux-foundation.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220328114144.53389-1-linmiaohe@huawei.com>
 <YkGjnAOidFD8bA3a@dhcp22.suse.cz>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <6e48acf8-bf60-bbec-5b0e-ff3e704f6fc5@huawei.com>
Date:   Mon, 28 Mar 2022 21:15:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YkGjnAOidFD8bA3a@dhcp22.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022/3/28 20:01, Michal Hocko wrote:
> On Mon 28-03-22 19:41:44, Miaohe Lin wrote:
>> The local variable nr_scanned is unneeded as mem_cgroup_soft_reclaim always
>> does *total_scanned += nr_scanned. So we can pass total_scanned directly to
>> the mem_cgroup_soft_reclaim to simplify the code and save some cpu cycles
>> of adding nr_scanned to total_scanned.
> 
> Maybe the compiler could be clever enough to generate a good code.
> mem_cgroup_soft_reclaim doesn't have other caller so it could be
> inlined. But I do agree that the change makes sense because it makes the
> code more consistent as mem_cgroup_soft_limit_reclaim already uses
> total_scanned this way.

Many thanks for your comment and Acked-by tag. :)

> 
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Thanks
> 
>> ---
>>  mm/memcontrol.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index b686ec4f42c6..79341365ec90 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -3384,7 +3384,6 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
>>  	int loop = 0;
>>  	struct mem_cgroup_tree_per_node *mctz;
>>  	unsigned long excess;
>> -	unsigned long nr_scanned;
>>  
>>  	if (order > 0)
>>  		return 0;
>> @@ -3412,11 +3411,9 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
>>  		if (!mz)
>>  			break;
>>  
>> -		nr_scanned = 0;
>>  		reclaimed = mem_cgroup_soft_reclaim(mz->memcg, pgdat,
>> -						    gfp_mask, &nr_scanned);
>> +						    gfp_mask, total_scanned);
>>  		nr_reclaimed += reclaimed;
>> -		*total_scanned += nr_scanned;
>>  		spin_lock_irq(&mctz->lock);
>>  		__mem_cgroup_remove_exceeded(mz, mctz);
>>  
>> -- 
>> 2.23.0
> 

