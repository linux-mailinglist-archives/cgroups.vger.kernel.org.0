Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514AA694653
	for <lists+cgroups@lfdr.de>; Mon, 13 Feb 2023 13:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjBMMv5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Feb 2023 07:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjBMMvz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Feb 2023 07:51:55 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BDE40C2;
        Mon, 13 Feb 2023 04:51:52 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PFkk84Rxjz4f3jHY;
        Mon, 13 Feb 2023 20:51:44 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP4 (Coremail) with SMTP id gCh0CgD3qa1dMupjSMMuDg--.19493S2;
        Mon, 13 Feb 2023 20:51:45 +0800 (CST)
Subject: Re: [PATCH] blk-ioprio: Introduce promote-to-rt policy
To:     Jan Kara <jack@suse.cz>, Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, houtao1@huawei.com
References: <20230201045227.2203123-1-houtao@huaweicloud.com>
 <8c068af3-7199-11cf-5c69-a523c7c22d9a@acm.org>
 <4f7dcb3e-2d5a-cae3-0e1c-a82bcc3d2217@huaweicloud.com>
 <b6b3c498-e90b-7d1f-6ad5-a31334e433ae@acm.org>
 <beb7782e-72a4-c350-3750-23a767c88753@huaweicloud.com>
 <aedc240d-7c9e-248a-52d2-c9775f3e8ca1@acm.org>
 <20230208134345.77bdep3kzp52haxu@quack3>
 <7fcd4c38-ccbe-6411-e424-a57595ad9c0b@acm.org>
 <20230209085603.dzqfcc3pp4hacqlz@quack3>
 <55a065e7-7d86-d58f-15ba-c631a427843e@acm.org>
 <20230210101244.zsmtmsoo4xjx7suj@quack3>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <48620099-0311-e752-ba3b-cbb4351cf81e@huaweicloud.com>
Date:   Mon, 13 Feb 2023 20:51:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230210101244.zsmtmsoo4xjx7suj@quack3>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: gCh0CgD3qa1dMupjSMMuDg--.19493S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF43Ww1DtF4xtryUCw4UJwb_yoW5CF18pF
        WxJFWqkFW8Xw1xA3WDt3WvqrWFg3s7Ja1UJrs8XFWjkFn8JF93XF4IkFWF9F17ArZ5WrnI
        y393J34j9Fy3ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jan,

On 2/10/2023 6:12 PM, Jan Kara wrote:
> On Thu 09-02-23 11:09:33, Bart Van Assche wrote:
>> On 2/9/23 00:56, Jan Kara wrote:
>>> On Wed 08-02-23 09:53:41, Bart Van Assche wrote:
>>>> The test results I shared some time ago show that IOPRIO_CLASS_NONE was the
>>>> default I/O priority two years ago (see also https://lore.kernel.org/linux-block/20210927220328.1410161-5-bvanassche@acm.org/).
>>>> The none-to-rt policy increases the priority of bio's that have not been
>>>> assigned an I/O priority to RT. Does this answer your question?
>>> Not quite. I know that historically we didn't set bio I/O priority in some
>>> paths (but we did set it in other paths such as some (but not all) direct
>>> IO implementations). But that was exactly a mess because how none-to-rt
>>> actually behaved depended on the exact details of the kernel internal IO
>>> path.  So my question is: Was none-to-rt actually just a misnomer and the
>>> intended behavior was "always override to RT"? Or what was exactly the
>>> expectation around when IO priority is not set and should be overridden?
>>>
>>> How should it interact with AIO submissions with IOCB_FLAG_IOPRIO? How
>>> should it interact with task having its IO priority modified with
>>> ioprio_set(2)? And what if task has its normal scheduling priority modified
>>> but that translates into different IO priority (which happens in
>>> __get_task_ioprio())?
>>>
>>> So I think that none-to-rt is just poorly defined and if we can just get
>>> rid of it (or redefine to promote-to-rt), that would be good. But maybe I'm
>>> missing some intended usecase...
>> Hi Jan,
>>
>> We have no plans to use the ioprio_set() system call since it only affects
>> foreground I/O and not page cache writeback.
>>
>> While Android supports io_uring, there are no plans to support libaio in the
>> Android C library (Bionic).
>>
>> Regarding __get_task_ioprio(), I haven't found any code in that function
>> that derives an I/O priority from the scheduling priority. Did I perhaps
>> overlook something?
> This condition in __get_task_ioprio():
>
>         if (IOPRIO_PRIO_CLASS(prio) == IOPRIO_CLASS_NONE)
>                 prio = IOPRIO_PRIO_VALUE(task_nice_ioclass(p),
>                                          task_nice_ioprio(p));
>
> sets task's IO priority based on scheduling priority.
>
>> Until recently "none-to-rt" meant "if no I/O priority has been assigned to a
>> task, use IOPRIO_CLASS_RT". Promoting the I/O priority to IOPRIO_CLASS_RT
>> works for us. I'm fine with changing the meaning of "none-to-rt" into
>> promoting the I/O priority class to RT. Introducing "promote-to-rt" as a
>> synonym of "none-to-rt" is also fine with me.
> OK, so it seems we are all in agreement here that "none-to-rt" behavior is
> not really needed. Hou, can you perhaps update your patches and the
> documentation to make "none-to-rt" just an alias for "promote-to-rt"?
> Thanks!
Should I keep "none-to-rt" and make it work just like "promote-to-rt" or should
I just remove "none-to-rt" and add "promote-to-rt" ? I think the latter will be
more appropriate.
>
> 								Honza

