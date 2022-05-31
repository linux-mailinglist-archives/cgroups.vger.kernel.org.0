Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E325538A46
	for <lists+cgroups@lfdr.de>; Tue, 31 May 2022 05:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243738AbiEaDuZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 May 2022 23:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238368AbiEaDuA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 May 2022 23:50:00 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E113892D1C;
        Mon, 30 May 2022 20:49:58 -0700 (PDT)
Received: from [10.180.13.185] (unknown [10.180.13.185])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Cxn+ZhkJViHEUJAA--.42980S3;
        Tue, 31 May 2022 11:49:55 +0800 (CST)
Subject: Re: [PATCH] cgroup: wait for css offline when rmdir
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1653619158-27607-1-git-send-email-zhanghongchen@loongson.cn>
 <YpCQZ5RRnxwh7fmK@slm.duckdns.org>
 <e74e03f1-cb54-b158-a085-2965fd088d1d@loongson.cn>
 <YpVo4XiIDu68w40Z@slm.duckdns.org>
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <fbb820c5-dbcb-0f00-c365-d3c57ca27edf@loongson.cn>
Date:   Tue, 31 May 2022 11:49:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <YpVo4XiIDu68w40Z@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Cxn+ZhkJViHEUJAA--.42980S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr1DXF1DAFWDJw4rJF1xuFg_yoWDZwc_Wa
        yIkw1Duw1DCF1kua1UKr4YvrW2kFWDWa98X3saqw4aga4UJF98JF47Wr1rZw1aqF4Syrnx
        Kr95Aw1FqrnFvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbxkYjsxI4VWkCwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY
        02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8
        P5r7UUUUU==
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022/5/31 上午9:01, Tejun Heo wrote:
> Hello,
> 
> On Mon, May 30, 2022 at 09:53:51AM +0800, Hongchen Zhang wrote:
>>    When I test the LTP's memcg_test_3 testcase at 8 Node server,I get the
>> -ENOMEM error,which caused by no avaliable idr found in mem_cgroup_idr.
>> the reason is the use of idr in mem_cgroup_idr is too fast than the free.In
>> the specific case,the idr is used and freed cyclically,so when we rmdir one
>> cgroup dir, we can synchronize the idr free through wating for the memcg css
>> offlined,and then we can use it the next cycle.
> 
> This is a micro benchmark specific problem and it doesn't make sense to
> change the overall behavior for this as the suggested change is neither
> desirable or logical. Maybe you can just incur the delay only after idr
> allocation fails and then retry?
> 
> Thanks.
> 
Hi Tejun,

Yes, the problem would disappear when add some reasonable delay. But I 
think if we can increase the MEM_CGROUP_ID_MAX to INT_MAX.Thus the 
-ENOMEM error would be never occured,even if the system is out of memory.

Thanks.

