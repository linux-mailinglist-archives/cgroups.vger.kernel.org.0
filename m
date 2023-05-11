Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD996FF5B0
	for <lists+cgroups@lfdr.de>; Thu, 11 May 2023 17:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237939AbjEKPT1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 11 May 2023 11:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237687AbjEKPT1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 11 May 2023 11:19:27 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2A7F7;
        Thu, 11 May 2023 08:19:23 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6366168D08; Thu, 11 May 2023 17:19:19 +0200 (CEST)
Date:   Thu, 11 May 2023 17:19:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next 1/6] blk-wbt: fix that wbt can't be disabled by
 default
Message-ID: <20230511151919.GA7880@lst.de>
References: <20230511014509.679482-1-yukuai1@huaweicloud.com> <20230511014509.679482-2-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511014509.679482-2-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 11, 2023 at 09:45:04AM +0800, Yu Kuai wrote:
> @@ -730,8 +730,9 @@ void wbt_enable_default(struct gendisk *disk)
>  {
>  	struct request_queue *q = disk->queue;
>  	struct rq_qos *rqos;
> -	bool disable_flag = q->elevator &&
> -		    test_bit(ELEVATOR_FLAG_DISABLE_WBT, &q->elevator->flags);
> +	bool disable_flag = (q->elevator &&
> +		    test_bit(ELEVATOR_FLAG_DISABLE_WBT, &q->elevator->flags)) ||
> +		    !IS_ENABLED(CONFIG_BLK_WBT_MQ);

Not really new in your patch, but I find the logic here very confusing.
First the disable_flag really should be enable instead, as that's how
it's actually checked, and then spelling out the conditions a bit more
would really help readability.  E.g.

	bool enabled = IS_ENABLED(CONFIG_BLK_WBT_MQ);

	if (q->elevator &&
	    test_bit(ELEVATOR_FLAG_DISABLE_WBT, &q->elevator->flags))
		enable = false;

