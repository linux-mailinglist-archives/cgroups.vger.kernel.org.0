Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBF0512889
	for <lists+cgroups@lfdr.de>; Thu, 28 Apr 2022 03:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240177AbiD1BMy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Apr 2022 21:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240191AbiD1BMw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Apr 2022 21:12:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C40728DA;
        Wed, 27 Apr 2022 18:09:39 -0700 (PDT)
Received: from kwepemi500011.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KpcvG4fm7zfb9q;
        Thu, 28 Apr 2022 09:08:42 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500011.china.huawei.com (7.221.188.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 09:09:37 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 09:09:36 +0800
Subject: Re: [PATCH -next v3 2/3] block, bfq: refactor the counting of
 'num_groups_with_pending_reqs'
To:     Jan Kara <jack@suse.cz>
CC:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>,
        <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220427124722.48465-1-yukuai3@huawei.com>
 <20220427124722.48465-3-yukuai3@huawei.com>
 <20220427124908.o3cl72h2uflmufso@quack3.lan>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <d36b4904-3db8-537c-5040-b496272ccf70@huawei.com>
Date:   Thu, 28 Apr 2022 09:09:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220427124908.o3cl72h2uflmufso@quack3.lan>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ÔÚ 2022/04/27 20:49, Jan Kara Ð´µÀ:
> On Wed 27-04-22 20:47:21, Yu Kuai wrote:
>> Currently, bfq can't handle sync io concurrently as long as they
>> are not issued from root group. This is because
>> 'bfqd->num_groups_with_pending_reqs > 0' is always true in
>> bfq_asymmetric_scenario().
>>
>> The way that bfqg is counted into 'num_groups_with_pending_reqs':
>>
>> Before this patch:
>>   1) root group will never be counted.
>>   2) Count if bfqg or it's child bfqgs have pending requests.
>>   3) Don't count if bfqg and it's child bfqgs complete all the requests.
>>
>> After this patch:
>>   1) root group is counted.
>>   2) Count if bfqg have at least one bfqq that is marked busy.
>>   3) Don't count if bfqg doesn't have any busy bfqqs.
>>
>> With this change, the occasion that only one group is activated can be
>> detected, and next patch will support concurrent sync io in the
>> occasion.
>>
>> This patch also rename 'num_groups_with_pending_reqs' to
>> 'num_groups_with_busy_queues'.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> Looks good. Just I think you forgot to remove in_groups_with_pending_reqs,
> which is now unused, from bfq_entity.

Will remove it in the next iteration.

Thanks,
Kuai
