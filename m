Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A86306A7A
	for <lists+cgroups@lfdr.de>; Thu, 28 Jan 2021 02:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhA1Bgc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Jan 2021 20:36:32 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:50690 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231181AbhA1BgW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Jan 2021 20:36:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UN56c69_1611797735;
Received: from 30.21.164.7(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UN56c69_1611797735)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 28 Jan 2021 09:35:35 +0800
Subject: Re: [PATCH] blk-cgroup: Use cond_resched() when destroy blkgs
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, joseph.qi@linux.alibaba.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <8f4fb91ced02e58ef425189c83214086f1154a0c.1611664710.git.baolin.wang@linux.alibaba.com>
 <YBF6uiFcU8k4u0Da@slm.duckdns.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <ace471fc-4ba9-c16a-65af-102a5425e4e4@linux.alibaba.com>
Date:   Thu, 28 Jan 2021 09:35:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YBF6uiFcU8k4u0Da@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Tejun,

> Hello, Baolin.
> 
> On Tue, Jan 26, 2021 at 09:33:25PM +0800, Baolin Wang wrote:
>> On !PREEMPT kernel, we can get below softlockup when doing stress
>> testing with creating and destroying block cgroup repeatly. The
>> reason is it may take a long time to acquire the queue's lock in
>> the loop of blkcg_destroy_blkgs(), thus we can use cond_resched()
>> instead of cpu_relax() to avoid this issue, since the
>> blkcg_destroy_blkgs() is not called from atomic contexts.
>>
>> [ 4757.010308] watchdog: BUG: soft lockup - CPU#11 stuck for 94s!
>> [ 4757.010698] Call trace:
>> [ 4757.010700]  blkcg_destroy_blkgs+0x68/0x150
>> [ 4757.010701]  cgwb_release_workfn+0x104/0x158
>> [ 4757.010702]  process_one_work+0x1bc/0x3f0
>> [ 4757.010704]  worker_thread+0x164/0x468
>> [ 4757.010705]  kthread+0x108/0x138
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> * Can you please add might_sleep() at the top of the function?

Sure.

> 
> * Given that the system can accumulate a huge number of blkgs in
>    pathological cases, I wonder whether a better way to go about it is
>    explicitly testing need_resched() on each loop and release locks and do
>    cond_resched() if true?

Yes, sound better to to me and will update in next version. Thanks for 
your sugestion.
