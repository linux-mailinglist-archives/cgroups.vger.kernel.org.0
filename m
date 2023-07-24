Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AD175E9C3
	for <lists+cgroups@lfdr.de>; Mon, 24 Jul 2023 04:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjGXCbN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 23 Jul 2023 22:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjGXCbM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 23 Jul 2023 22:31:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32533BF;
        Sun, 23 Jul 2023 19:30:55 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R8NST2PnKzrRr6;
        Mon, 24 Jul 2023 09:51:53 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 09:52:43 +0800
Subject: Re: [PATCH] mm/memcg: fix obsolete function name in
 mem_cgroup_protection()
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>
References: <20230723032538.3190239-1-linmiaohe@huawei.com>
 <ZL2Ph5g05Ud5vAdT@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <e3924d13-410c-21e5-b3df-21fea0f45574@huawei.com>
Date:   Mon, 24 Jul 2023 09:52:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ZL2Ph5g05Ud5vAdT@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2023/7/24 4:37, Matthew Wilcox wrote:
> On Sun, Jul 23, 2023 at 11:25:38AM +0800, Miaohe Lin wrote:
>> @@ -582,9 +582,9 @@ static inline void mem_cgroup_protection(struct mem_cgroup *root,
>>  	/*
>>  	 * There is no reclaim protection applied to a targeted reclaim.
>>  	 * We are special casing this specific case here because
>> -	 * mem_cgroup_protected calculation is not robust enough to keep
>> -	 * the protection invariant for calculated effective values for
>> -	 * parallel reclaimers with different reclaim target. This is
>> +	 * mem_cgroup_calculate_protection calculation is not robust enough
>> +	 * to keep the protection invariant for calculated effective values
>> +	 * for parallel reclaimers with different reclaim target. This is
>>  	 * especially a problem for tail memcgs (as they have pages on LRU)
>>  	 * which would want to have effective values 0 for targeted reclaim
>>  	 * but a different value for external reclaim.
> 
> This reads a little awkwardly now.  How about:
> 
>  	 * We are special casing this specific case here because
> -	 * mem_cgroup_protected calculation is not robust enough to keep
> +	 * mem_cgroup_calculate_protection is not robust enough to keep

Sounds better. Will do it in v2.

Thanks.
