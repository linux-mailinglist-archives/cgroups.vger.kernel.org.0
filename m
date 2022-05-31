Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75635538D6C
	for <lists+cgroups@lfdr.de>; Tue, 31 May 2022 11:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245065AbiEaJHD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 May 2022 05:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbiEaJHB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 May 2022 05:07:01 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132031A071;
        Tue, 31 May 2022 02:06:55 -0700 (PDT)
Received: from kwepemi100010.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LC5vv4X22z1JCW9;
        Tue, 31 May 2022 17:05:15 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100010.china.huawei.com (7.221.188.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 31 May 2022 17:06:53 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 31 May 2022 17:06:52 +0800
Subject: Re: [PATCH -next v7 2/3] block, bfq: refactor the counting of
 'num_groups_with_pending_reqs'
To:     Paolo VALENTE <paolo.valente@unimore.it>
CC:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, <cgroups@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220528095020.186970-1-yukuai3@huawei.com>
 <20220528095020.186970-3-yukuai3@huawei.com>
 <0D9355CE-F85B-4B1A-AEC3-F63DFC4B3A54@linaro.org>
 <b9a4ea60-28e5-b7aa-0154-ad7481eafbd3@huawei.com>
 <efe01dd1-0f99-dadf-956d-b0e80e1e602c@huawei.com>
 <1803FD7E-9FB1-4A1E-BD6D-D6657006589A@unimore.it>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <a0d8452c-e421-45d3-b012-5355207fc0e1@huawei.com>
Date:   Tue, 31 May 2022 17:06:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1803FD7E-9FB1-4A1E-BD6D-D6657006589A@unimore.it>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

在 2022/05/31 16:36, Paolo VALENTE 写道:
> 
> 
>> Il giorno 30 mag 2022, alle ore 10:40, Yu Kuai <yukuai3@huawei.com> ha scritto:
>>
>> 在 2022/05/30 16:34, Yu Kuai 写道:
>>> 在 2022/05/30 16:10, Paolo Valente 写道:
>>>>
>>>>
>>>>> Il giorno 28 mag 2022, alle ore 11:50, Yu Kuai <yukuai3@huawei.com> ha scritto:
>>>>>
>>>>> Currently, bfq can't handle sync io concurrently as long as they
>>>>> are not issued from root group. This is because
>>>>> 'bfqd->num_groups_with_pending_reqs > 0' is always true in
>>>>> bfq_asymmetric_scenario().
>>>>>
>>>>> The way that bfqg is counted into 'num_groups_with_pending_reqs':
>>>>>
>>>>> Before this patch:
>>>>> 1) root group will never be counted.
>>>>> 2) Count if bfqg or it's child bfqgs have pending requests.
>>>>> 3) Don't count if bfqg and it's child bfqgs complete all the requests.
>>>>>
>>>>> After this patch:
>>>>> 1) root group is counted.
>>>>> 2) Count if bfqg have at least one bfqq that is marked busy.
>>>>> 3) Don't count if bfqg doesn't have any busy bfqqs.
>>>>
>>>> Unfortunately, I see a last problem here. I see a double change:
>>>> (1) a bfqg is now counted only as a function of the state of its child
>>>>       queues, and not of also its child bfqgs
>>>> (2) the state considered for counting a bfqg moves from having pending
>>>>       requests to having busy queues
>>>>
>>>> I'm ok with with (1), which is a good catch (you are lady explained
>>>> the idea to me some time ago IIRC).
>>>>
>>>> Yet I fear that (2) is not ok.  A bfqq can become non busy even if it
>>>> still has in-flight I/O, i.e.  I/O being served in the drive.  The
>>>> weight of such a bfqq must still be considered in the weights_tree,
>>>> and the group containing such a queue must still be counted when
>>>> checking whether the scenario is asymmetric.  Otherwise service
>>>> guarantees are broken.  The reason is that, if a scenario is deemed as
>>>> symmetric because in-flight I/O is not taken into account, then idling
>>>> will not be performed to protect some bfqq, and in-flight I/O may
>>>> steal bandwidth to that bfqq in an uncontrolled way.
>>> Hi, Paolo
>>> Thanks for your explanation.
>>> My orginal thoughts was using weights_tree insertion/removal, however,
>>> Jan convinced me that using bfq_add/del_bfqq_busy() is ok.
>>>  From what I see, when bfqq dispatch the last request,
>>> bfq_del_bfqq_busy() will not be called from __bfq_bfqq_expire() if
>>> idling is needed, and it will delayed to when such bfqq get scheduled as
>>> in-service queue again. Which means the weight of such bfqq should still
>>> be considered in the weights_tree.
>>> I also run some tests on null_blk with "irqmode=2
>>> completion_nsec=100000000(100ms) hw_queue_depth=1", and tests show
>>> that service guarantees are still preserved on slow device.
>>> Do you this is strong enough to cover your concern?
> 
> Unfortunately it is not.  Your very argument is what made be believe
> that considering busy queues was enough, in the first place.  But, as
> I found out, the problem is caused by the queues that do not enjoy
> idling.  With your patch (as well as in my initial version) they are
> not counted when they remain without requests queued.  And this makes
> asymmetric scenarios be considered erroneously as symmetric.  The
> consequence is that idling gets switched off when it had to be kept
> on, and control on bandwidth is lost for the victim in-service queues.

Hi，Paolo

Thanks for your explanation, are you thinking that if bfqq doesn't enjoy
idling, then such bfqq will clear busy after dispatching the last
request?

Please kindly correct me if I'm wrong in the following process:

If there are more than one bfqg that is activatied, then bfqqs that are
not enjoying idle are still left busy after dispatching the last
request.

details in __bfq_bfqq_expire:

         if (RB_EMPTY_ROOT(&bfqq->sort_list) &&
         ┊   !(reason == BFQQE_PREEMPTED &&
         ┊     idling_needed_for_service_guarantees(bfqd, bfqq))) {
-> idling_needed_for_service_guarantees will always return true,
bfqq(whether or not enjoy idling) will stay busy.
                 if (bfqq->dispatched == 0)
                         /*
                         ┊* Overloading budget_timeout field to store
                         ┊* the time at which the queue remains with no
                         ┊* backlog and no outstanding request; used by
                         ┊* the weight-raising mechanism.
                         ┊*/
                         bfqq->budget_timeout = jiffies;

                 bfq_del_bfqq_busy(bfqd, bfqq, true);

Thanks,
Kuai
