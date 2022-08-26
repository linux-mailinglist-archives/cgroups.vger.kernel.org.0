Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562185A1DF2
	for <lists+cgroups@lfdr.de>; Fri, 26 Aug 2022 03:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243799AbiHZBHd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Aug 2022 21:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243798AbiHZBHd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Aug 2022 21:07:33 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713AEC926B;
        Thu, 25 Aug 2022 18:07:31 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MDM8v2LDyzl7l4;
        Fri, 26 Aug 2022 09:06:07 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgA3POnPHAhjtyA7Aw--.53022S3;
        Fri, 26 Aug 2022 09:07:29 +0800 (CST)
Subject: Re: [PATCH v8 1/4] blk-throttle: fix that io throttle can only work
 for single bio
To:     Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, mkoutny@suse.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20220823033130.874230-1-yukuai1@huaweicloud.com>
 <20220823033130.874230-2-yukuai1@huaweicloud.com>
 <YwUXTL+8E/sPcEUB@slm.duckdns.org>
 <73c72914-e27d-b261-e040-2dd31e8a6b9f@huaweicloud.com>
 <Ywe8Uz4Gy6j/EsUg@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <de0466d4-f501-da13-c3ee-0798c2761d9f@huaweicloud.com>
Date:   Fri, 26 Aug 2022 09:07:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Ywe8Uz4Gy6j/EsUg@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgA3POnPHAhjtyA7Aw--.53022S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZrWxtryUZF4xWFWxKw47twb_yoWfJrb_AF
        4IvayxJwn8Z3Z2yF13ta18u39xWFWrX3yxZ34UJrWaqayrX3Z8uF4rtws8Aa4rWw4F9r9I
        9w1agw45C3ya9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, Tejun

ÔÚ 2022/08/26 2:15, Tejun Heo Ð´µÀ:
> On Wed, Aug 24, 2022 at 09:15:32AM +0800, Yu Kuai wrote:
>> This patch actually set two flags when bio is throttled and
>> dispatched, and only iops flag is cleared after the original bio is
>> split. If only one flag can be used, the way that I come up with is
>> that let iops limit become default, which means bio is always counted
>> for iops limit each time blk_throtl_bio() is called. I'm not quite
>> sure yet if iops limit can be counted excessively this way in some
>> special scenario...
> 
> I don't think we have a path where we clone and re-submit other than
> splitting. What do you think about renaming the flag to BIO_BPS_THROTTLED
> and just assuming that IOPS is always applied?

Yes, I didn't found such path myself, this way sounds good. I'll send a
new version soon.

Thanks,
Kuai
> 
> Thanks.
> 

