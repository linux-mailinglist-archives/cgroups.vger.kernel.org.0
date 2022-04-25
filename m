Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2939850E567
	for <lists+cgroups@lfdr.de>; Mon, 25 Apr 2022 18:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243294AbiDYQUB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Apr 2022 12:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243305AbiDYQUA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Apr 2022 12:20:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906AF23156;
        Mon, 25 Apr 2022 09:16:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3AD571F38C;
        Mon, 25 Apr 2022 16:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650903414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bIwwrsg+enqFDb2rJvlESBhPlFgt7kfPl8/6sFp+bG0=;
        b=sRbvsAnizf/F9KDooxHTNKtEJdyzQweIGyZFUYzrUiq8lmNDWR+lpPsZ/WzeO1WaWHnynU
        zBnkzUIxj19/+T4lfeXdhwvEsQZLKD/33Ql1asGVI/ouknhpEZiKhRYQSWDLtVzxV9npQ1
        dyFWVN2J5JY76LQDzc0A0QJK4XFj/Kg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650903414;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bIwwrsg+enqFDb2rJvlESBhPlFgt7kfPl8/6sFp+bG0=;
        b=iisCUOPk+a+/hBsTd7hc2OaQug+soVsBQbHZ3K0t659HMN/3Lfu7KeZpOgtBNKGjUOv8RQ
        JSoNQMoza/SVSNBg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 22F0B2C143;
        Mon, 25 Apr 2022 16:16:53 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8D187A0620; Mon, 25 Apr 2022 18:16:50 +0200 (CEST)
Date:   Mon, 25 Apr 2022 18:16:50 +0200
From:   Jan Kara <jack@suse.cz>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, paolo.valente@linaro.org, axboe@kernel.dk,
        tj@kernel.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next v2 2/5] block, bfq: add fake weight_counter for
 weight-raised queue
Message-ID: <20220425161650.xzyijgkb5yzviea3@quack3.lan>
References: <20220416093753.3054696-1-yukuai3@huawei.com>
 <20220416093753.3054696-3-yukuai3@huawei.com>
 <20220425094856.qgkhba2klguduxot@quack3.lan>
 <a27b8c79-867f-9253-84db-1d39c964b3ed@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a27b8c79-867f-9253-84db-1d39c964b3ed@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello!

On Mon 25-04-22 21:34:16, yukuai (C) wrote:
> 在 2022/04/25 17:48, Jan Kara 写道:
> > On Sat 16-04-22 17:37:50, Yu Kuai wrote:
> > > Weight-raised queue is not inserted to weights_tree, which makes it
> > > impossible to track how many queues have pending requests through
> > > weights_tree insertion and removel. This patch add fake weight_counter
> > > for weight-raised queue to do that.
> > > 
> > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > 
> > This is a bit hacky. I was looking into a better place where to hook to
> > count entities in a bfq_group with requests and I think bfq_add_bfqq_busy()
> > and bfq_del_bfqq_busy() are ideal for this. It also makes better sense
> > conceptually than hooking into weights tree handling.
> 
> bfq_del_bfqq_busy() will be called when all the reqs in the bfqq are
> dispatched, however there might still some reqs are't completed yet.
> 
> Here what we want to track is how many bfqqs have pending reqs,
> specifically if the bfqq have reqs are't complted.
> 
> Thus I think bfq_del_bfqq_busy() is not the right place to do that.

Yes, I'm aware there will be a difference. But note that bfqq can stay busy
with only dispatched requests because the logic in __bfq_bfqq_expire() will
not call bfq_del_bfqq_busy() if idling is needed for service guarantees. So
I think using bfq_add/del_bfqq_busy() would work OK. 

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
