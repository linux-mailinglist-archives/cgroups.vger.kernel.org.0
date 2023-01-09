Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B26B661EBB
	for <lists+cgroups@lfdr.de>; Mon,  9 Jan 2023 07:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbjAIGh4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Jan 2023 01:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbjAIGhz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Jan 2023 01:37:55 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF92FAC8;
        Sun,  8 Jan 2023 22:37:52 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Nr44n2dKWz4f41pg;
        Mon,  9 Jan 2023 14:37:45 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7M6trtjzDiGBQ--.21789S3;
        Mon, 09 Jan 2023 14:37:48 +0800 (CST)
Subject: Re: [PATCH -next 3/4] block/rq_qos: use a global mutex to protect
 rq_qos apis
To:     Yu Kuai <yukuai1@huaweicloud.com>, Tejun Heo <tj@kernel.org>
Cc:     hch@infradead.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230104085354.2343590-1-yukuai1@huaweicloud.com>
 <20230104085354.2343590-4-yukuai1@huaweicloud.com>
 <Y7XyIzGptuqO8EAt@slm.duckdns.org> <Y7YZnM/nqb0gxOei@slm.duckdns.org>
 <df2f7a60-467f-08ce-2a3e-1dc7853424aa@huaweicloud.com>
 <Y7cYKdOwSlfHtj7t@slm.duckdns.org>
 <ef55a0f1-d3c2-3979-963e-2fa10ba3c2ff@huaweicloud.com>
 <Y7hnH9GT6D469Vuu@slm.duckdns.org>
 <31e57528-39a5-84ed-8ea0-5c61bab00541@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <5633d865-8a8a-ef34-82e6-a2eacf943253@huaweicloud.com>
Date:   Mon, 9 Jan 2023 14:37:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <31e57528-39a5-84ed-8ea0-5c61bab00541@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnD7M6trtjzDiGBQ--.21789S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJr43WFWxurWUGw1UKF1DAwb_yoW8Gry3pr
        W3Ww1rAr4kAr10k34DAFy8Wryrtws3Jay5GF1UWrn2vr43Ar18Xr40gr4FvFy8A395Kw4j
        vr1xKw1ruw4UCaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

ÔÚ 2023/01/09 9:38, Yu Kuai Ð´µÀ:
>> So, it's not sysfs_lock but sysfs file deletion. When a kernfs, which 
>> backs
>> sysfs, file is removed, it disables future operations and drains all
>> inflight ones before returning, so you remove the interface files before
>> cleaning up the object that it interacts with, you don't have to worry 
>> about
>> racing against file operations as none can be in flight at that point.
> 

I understand this know, kernfs_fop_write_iter() will grab
kernfs_node->active, and kobject_del() will wait for active to be
dropped in kernfs_drain().

>> Sorry that I've been asking you to go round and round but block device
>> add/remove paths have always been really tricky and we wanna avoid adding
>> more complications if at all possible. Can you see why the device is 
>> being
>> destroyed before the queue attr is removed?
> 

Sorry that I actually tested with patch 4 applied, and this is a bug
introduced by patch 4, my apologies. It set rqos to ERR_PTR() in
rq_qos_exit, and follow up rq_qos_issue() just check if rqos is NULL.

I'll wait for your patchset to be apllied, and then send a new version.
Just one thing to confirm, do you think it's better to use a global
mutex rather than a disk level mutex? I'm not sure because this will
cause different cgroup configurations from different disk can't
concurrent.

Thanks,
Kuai

