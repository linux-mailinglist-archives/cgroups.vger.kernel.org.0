Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB12F60C528
	for <lists+cgroups@lfdr.de>; Tue, 25 Oct 2022 09:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiJYHbO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Oct 2022 03:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiJYHbN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Oct 2022 03:31:13 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F86127CEE;
        Tue, 25 Oct 2022 00:31:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MxNpg1W4bz6S2lC;
        Tue, 25 Oct 2022 15:28:43 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgA3Ree7kFdjS_OoAA--.14841S3;
        Tue, 25 Oct 2022 15:31:09 +0800 (CST)
Subject: Re: [patch v11 0/6] support concurrent sync io for bfq on a specail
 occasion
To:     Paolo VALENTE <paolo.valente@unimore.it>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, cgroups@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20220916071942.214222-1-yukuai1@huaweicloud.com>
 <29348B39-94AE-4D76-BD2E-B759056264B6@linaro.org>
 <011d479f-644f-0013-40bf-664b62f93bec@huaweicloud.com>
 <A9D22DB6-6481-46BA-9D4C-5A828D19CB61@linaro.org>
 <bcd07062-5a3b-563e-fb2d-2fa8e4c8bba5@huaweicloud.com>
 <82f1e969-742d-d3c3-63ca-961c755b5c35@huaweicloud.com>
 <A1E2F76F-2D27-4DCE-9B97-C8011CBE2A9E@unimore.it>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <69485939-d874-0201-e7ed-b3f49dbbb9c9@huaweicloud.com>
Date:   Tue, 25 Oct 2022 15:31:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <A1E2F76F-2D27-4DCE-9B97-C8011CBE2A9E@unimore.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3Ree7kFdjS_OoAA--.14841S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw1UGrWkAw17Cr1DCF17Jrb_yoWfCFg_Ka
        48ta47Ka1UtFnFyFnYqr18JrWrGF42qrW8Zry5Xw4fJry7Gr1jgF43WrsrXwnFgr45G3WU
        Xr1UXw4UAryaqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
        3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIda
        VFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

在 2022/10/25 14:34, Paolo VALENTE 写道:

>>
>> I rerun the manually test for 5 times, here is the average result:
>>
>> without this patchset / with this patchset:
>>
>> | --------------- | ------------- | ------------ | -------------- | ------------- | -------------- |
>> | cg1 weight      | 10            | 20           | 30             | 40          | 50             |
>> | cg2 weight      | 90            | 80           | 70             | 60          | 50             |
>> | cg1 bw MiB/s    | 21.4 / 21.74  | 42.72 / 46.6 | 63.82 / 61.52  | 94.74 / 90.92 | 140 / 138.2    |
>> | cg2 bw MiB/s    | 197.2 / 197.4 | 182 / 181.2  | 171.2 / 173.44 | 162 / 156.8   | 138.6 / 137.04 |
>> | cg2 bw / cg1 bw | 9.22 / 9.08   | 4.26 / 3.89  | 2.68 / 2.82    | 1.71 / 1.72   | 0.99 / 0.99    |
> 
> Great!  Results are (statistically) the same, with and without your
> patchset.  For me your patches are ok.  Thank you very much for this
> contribution, and sorry again for my delay.
> 
> Acked-by: Paolo Valente <paolo.valente@linaro.org>

Thanks for the review, it's nice to get this done finally!
> 
> Thanks,
> Paolo

