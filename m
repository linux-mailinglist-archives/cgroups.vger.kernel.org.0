Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67B2668916
	for <lists+cgroups@lfdr.de>; Fri, 13 Jan 2023 02:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240573AbjAMBZV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Jan 2023 20:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236952AbjAMBZU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Jan 2023 20:25:20 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C456B5D8B3;
        Thu, 12 Jan 2023 17:25:17 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NtNyG3g5Xz4f3nqD;
        Fri, 13 Jan 2023 09:25:10 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgDX0R_3ssBjUrLoBQ--.19657S3;
        Fri, 13 Jan 2023 09:25:13 +0800 (CST)
Subject: Re: [PATCH v2 1/2] blk-iocost: add refcounting for iocg
To:     Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@infradead.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <Y7iCId3pnEnLqY8G@slm.duckdns.org>
 <875eb43e-202d-5b81-0bff-ef0434358d99@huaweicloud.com>
 <Y7xbpidpq7+DqJan@slm.duckdns.org>
 <a71f997f-6cae-d57b-85dd-2fd499d238f6@huaweicloud.com>
 <Y72wF/b0/xNRmP7f@slm.duckdns.org>
 <53b30ac8-d608-ba0b-8b1b-7fe5cfed6d61@huaweicloud.com>
 <Y77s0f741mFfGlTO@slm.duckdns.org>
 <4aeef320-c6c8-d9b4-8826-d58f00ea6264@huaweicloud.com>
 <Y8CrloCDGhbU42OH@slm.duckdns.org>
 <efa1c73b-e94f-373f-e535-2cfc32ce2433@huaweicloud.com>
 <Y8CwwghZ0adMsHFC@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ac95dfb8-b1b6-8916-bde8-1edb573e7ca5@huaweicloud.com>
Date:   Fri, 13 Jan 2023 09:25:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y8CwwghZ0adMsHFC@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDX0R_3ssBjUrLoBQ--.19657S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XF4fCw17uF17tFWUXFWfGrg_yoWkJrX_u3
        4093WUW348GrnxCas5KF45X397KryUGry8ur40gr97GF9aq3yqkFn7Cwn3CFyUA3ykXr9I
        vr95Zw18Gry7WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUba8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
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
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

ÔÚ 2023/01/13 9:15, Tejun Heo Ð´µÀ:
> Hello,
> 
> On Fri, Jan 13, 2023 at 09:10:25AM +0800, Yu Kuai wrote:
>>> only activate the policy when the controller is actually enabled. So, idk.
>>> What's wrong with synchronizing the two removal paths? blkcg policies are
>>> combinations of cgroups and block device configurations, so having exit
>>> paths from both sides is kinda natural.
>>
>> I still can't figure out how to synchronizing them will a mutex. Maybe
>> I'm being foolish...
> 
> Hmm... can't you just use e.g. per-bdev mutex which is grabbed by both
> blkg_free_workfn() and blkcg_deactivate_policy()?
> 

I think hold the lock in blkg_free_workfn() is too late, pd_free_fn()
for parent from blkcg_deactivate_policy() can be called first.

t1: remove cgroup t1/t2
blkcg_destroy_blkgs
  blkg_destroy
   percpu_ref_kill(&blkg->refcnt)
    blkg_release
     blkg_free
      schedule_work(&blkg->free_work)
      // t1 is done

t2: handle t1 from removing device
blkcg_deactivate_policy
  pd_free_fn
  // free parent
				t3: from t1
				blkg_free_workfn
				 pd_free_fn
				 // free child

Thanks,
Kuai

