Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6726E053D
	for <lists+cgroups@lfdr.de>; Thu, 13 Apr 2023 05:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjDMDcK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Apr 2023 23:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjDMDcI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Apr 2023 23:32:08 -0400
X-Greylist: delayed 484 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Apr 2023 20:32:06 PDT
Received: from out-48.mta1.migadu.com (out-48.mta1.migadu.com [IPv6:2001:41d0:203:375::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC00810C0
        for <cgroups@vger.kernel.org>; Wed, 12 Apr 2023 20:32:05 -0700 (PDT)
Message-ID: <2c5d4e9b-ec7d-dbfc-7e95-e75b66b68d3c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1681356237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SZZA5T91TnAzL69LK031bioqqsWD859qJR93vJBrvfE=;
        b=Fu7DtGRKCCChMSJx7TqN/FEyNOi14o8+joZ1seqjSZVe2hGT5OtJ+o9uXSBXWpzlZTNcij
        jI6GZAFr7dXw11Dq3ayXX9WnqPXFqb5zxhbbcXXbNMgApmabNiRidO2XjEbnqSRZ8HnAq7
        2DqudkmbITa57FLXnmUaOOiPhfdYVps=
Date:   Thu, 13 Apr 2023 11:23:21 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] blk-stat: fix QUEUE_FLAG_STATS clear
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20230412160754.1981705-1-chengming.zhou@linux.dev>
 <ZDbmlYIrRpkWRZla@slm.duckdns.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <ZDbmlYIrRpkWRZla@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2023/4/13 01:12, Tejun Heo wrote:
> On Thu, Apr 13, 2023 at 12:07:53AM +0800, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> We need to set QUEUE_FLAG_STATS for two cases:
>> 1. blk_stat_enable_accounting()
>> 2. blk_stat_add_callback()
>>
>> So we should clear it only when ((q->stats->accounting == 0) &&
>> list_empty(&q->stats->callbacks)).
>>
>> blk_stat_disable_accounting() only check if q->stats->accounting
>> is 0 before clear the flag, this patch fix it.
>>
>> Also add list_empty(&q->stats->callbacks)) check when enable, or
>> the flag is already set.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> It'd be useful to explicitly illustrate the buggy behavior in the
> description (e.g. if you do X, Y and then Z, then X incorrectly loses

Yes, I will add below buggy behavior in the next version:

This bug can be reproduced as below on kernel without BLK_DEV_THROTTLING
(since it will unconditionally enable accounting, see the second patch).

# cat /sys/block/sr0/queue/scheduler
none mq-deadline [bfq]

# cat /sys/kernel/debug/block/sr0/state
SAME_COMP|IO_STAT|INIT_DONE|STATS|REGISTERED|NOWAIT|30

# echo none > /sys/block/sr0/queue/scheduler

# cat /sys/kernel/debug/block/sr0/state
SAME_COMP|IO_STAT|INIT_DONE|REGISTERED|NOWAIT

# cat /sys/block/sr0/queue/wbt_lat_usec
75000

We can see that after changing elevator from "bfq" to "none", "STATS" flag
is lost even though WBT callback still need it.


> accounting). Can you also please add the appropriate stable cc?

Ok, will do.

Thanks.

> 
> Thanks.
> 
