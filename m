Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D56583C19
	for <lists+cgroups@lfdr.de>; Thu, 28 Jul 2022 12:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbiG1Kev (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Jul 2022 06:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbiG1Keu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Jul 2022 06:34:50 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10895422E6;
        Thu, 28 Jul 2022 03:34:47 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ltn7D3MLXzl64L;
        Thu, 28 Jul 2022 18:33:44 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgDn79NEZuJi4m8mBQ--.43697S3;
        Thu, 28 Jul 2022 18:34:45 +0800 (CST)
Subject: Re: [PATCH RESEND v6 4/8] blk-throttle: fix io hung due to config
 updates
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
        ming.lei@redhat.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20220701093441.885741-1-yukuai1@huaweicloud.com>
 <20220701093441.885741-5-yukuai1@huaweicloud.com>
 <YuGGVxdlOVk/eF2l@slm.duckdns.org> <20220728093346.GA2281@blackbody.suse.cz>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <0bbf3d0c-88c4-8120-3df3-960dda041864@huaweicloud.com>
Date:   Thu, 28 Jul 2022 18:34:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220728093346.GA2281@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDn79NEZuJi4m8mBQ--.43697S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtF4fZw43GF48Jr47uw43trb_yoWkJrb_ur
        yFya1jyw15CFW0kanFga15Jry3Jw4UJrZ8Gw1Fyw4Ut34ftFs8Xa98K34Ivr1rJa1ayr1Y
        qrZ5Xa1Iyw12gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUba8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3
        Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VU1a9aPUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi

在 2022/07/28 17:33, Michal Koutný 写道:
> On Wed, Jul 27, 2022 at 08:39:19AM -1000, Tejun Heo <tj@kernel.org> wrote:
>> I'm not quiet sure this is correct. What if the limit keeps changing across
>> different values? Then we'd be calculating the skipped amount based on the
>> last configuration only which would be incorrect.
> 
> When one change of configuration is correct, then all changes must be
> correct by induction. It's sufficient to take into account only the one
> old config and the new one.
> 
> This __tg_update_skipped() calculates bytes_skipped with the limit
> before the change and bytes_skipped are used (divided by) the new limit
> in tg_with_in_bps_limit().
> The accumulation of bytes_skipped across multiple changes (until slice
> properly ends) is proportional to how bytes_allowed would grow over
> time.
> That's why I find this correct (I admit I had to look back into my
> notes when this was first discussed).
> 
> HTH,
> Michal
> 

Hi, Tejun

Michal already explain it very well, please let me know if you still
thinks there are better ways.

Thanks,
Kuai

