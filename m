Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DDF4FF5C6
	for <lists+cgroups@lfdr.de>; Wed, 13 Apr 2022 13:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbiDMLf5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Apr 2022 07:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiDMLfz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Apr 2022 07:35:55 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C422635A9C;
        Wed, 13 Apr 2022 04:33:32 -0700 (PDT)
Received: from kwepemi100005.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KdgN83X5gzBs1B;
        Wed, 13 Apr 2022 19:29:12 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100005.china.huawei.com (7.221.188.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 19:33:30 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 19:33:29 +0800
Subject: Re: [PATCH -next 00/11] support concurrent sync io for bfq on a
 specail occasion
To:     Jan Kara <jack@suse.cz>
CC:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>,
        <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220305091205.4188398-1-yukuai3@huawei.com>
 <20220413111216.npgrdzaubsvjsmy3@quack3.lan>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <36f0923c-bb9b-12f1-b3bc-cdbe0bbcca55@huawei.com>
Date:   Wed, 13 Apr 2022 19:33:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220413111216.npgrdzaubsvjsmy3@quack3.lan>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ÔÚ 2022/04/13 19:12, Jan Kara Ð´µÀ:
> On Sat 05-03-22 17:11:54, Yu Kuai wrote:
>> Currently, bfq can't handle sync io concurrently as long as they
>> are not issued from root group. This is because
>> 'bfqd->num_groups_with_pending_reqs > 0' is always true in
>> bfq_asymmetric_scenario().
>>
>> This patchset tries to support concurrent sync io if all the sync ios
>> are issued from the same cgroup:
>>
>> 1) Count root_group into 'num_groups_with_pending_reqs', patch 1-5;
> 
> Seeing the complications and special casing for root_group I wonder: Won't
> we be better off to create fake bfq_sched_data in bfq_data and point
> root_group->sched_data there? AFAICS it would simplify the code

Hi,

That sounds an good idel, in this case we only need to make sure the
fake service tree will always be empty, which means we only need to
special casing bfq_active/idle_insert to the fake service tree.

Thanks,
Kuai
> considerably as root_group would be just another bfq_group, no need to
> special case it in various places, no games with bfqg->my_entity, etc.
> Paolo, do you see any problem with that?
> 
> 								Honza
> 
