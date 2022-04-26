Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763C150F2DB
	for <lists+cgroups@lfdr.de>; Tue, 26 Apr 2022 09:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343803AbiDZHnh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Apr 2022 03:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344273AbiDZHnc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Apr 2022 03:43:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96948198;
        Tue, 26 Apr 2022 00:40:25 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4D09D210EB;
        Tue, 26 Apr 2022 07:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650958824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TzIWVJ6EAqjRbZdTdcHexxp67XQ0RbOshNKrsYIiSGw=;
        b=HEKQn3ZNZDXr5N9BnyZVgEfdr/N/FPYgznPqSkR3gh+MssKWIATSMZQ9KQir0TwYryIgeM
        vPoVMchQ76WSLK7rnM/QEMx/dLo91F7OQwRtxhtIQZ9E/rqMEUAyIlN9JXf7ZOWJ/UqScS
        kM8uEOZOlqVJ30Rl9VGN5x8PzIVV0HE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650958824;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TzIWVJ6EAqjRbZdTdcHexxp67XQ0RbOshNKrsYIiSGw=;
        b=p5T6zNi4/s2xl8tShY9ElhnTBewZdrvUmQifOHQhh37BeTdsOAYD6X2REHk4nclxYXrlK8
        UPx9RNBM+1j+WnBQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 37FD12C142;
        Tue, 26 Apr 2022 07:40:24 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DF0CEA0620; Tue, 26 Apr 2022 09:40:23 +0200 (CEST)
Date:   Tue, 26 Apr 2022 09:40:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, paolo.valente@linaro.org, axboe@kernel.dk,
        tj@kernel.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next v2 2/5] block, bfq: add fake weight_counter for
 weight-raised queue
Message-ID: <20220426074023.5y4gwvjsjzem3vgp@quack3.lan>
References: <20220416093753.3054696-1-yukuai3@huawei.com>
 <20220416093753.3054696-3-yukuai3@huawei.com>
 <20220425094856.qgkhba2klguduxot@quack3.lan>
 <a27b8c79-867f-9253-84db-1d39c964b3ed@huawei.com>
 <20220425161650.xzyijgkb5yzviea3@quack3.lan>
 <4591d02d-1f14-c928-1c50-6e434dfbb7b2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4591d02d-1f14-c928-1c50-6e434dfbb7b2@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 26-04-22 09:49:04, yukuai (C) wrote:
> 在 2022/04/26 0:16, Jan Kara 写道:
> > Hello!
> > 
> > On Mon 25-04-22 21:34:16, yukuai (C) wrote:
> > > 在 2022/04/25 17:48, Jan Kara 写道:
> > > > On Sat 16-04-22 17:37:50, Yu Kuai wrote:
> > > > > Weight-raised queue is not inserted to weights_tree, which makes it
> > > > > impossible to track how many queues have pending requests through
> > > > > weights_tree insertion and removel. This patch add fake weight_counter
> > > > > for weight-raised queue to do that.
> > > > > 
> > > > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > > > 
> > > > This is a bit hacky. I was looking into a better place where to hook to
> > > > count entities in a bfq_group with requests and I think bfq_add_bfqq_busy()
> > > > and bfq_del_bfqq_busy() are ideal for this. It also makes better sense
> > > > conceptually than hooking into weights tree handling.
> > > 
> > > bfq_del_bfqq_busy() will be called when all the reqs in the bfqq are
> > > dispatched, however there might still some reqs are't completed yet.
> > > 
> > > Here what we want to track is how many bfqqs have pending reqs,
> > > specifically if the bfqq have reqs are't complted.
> > > 
> > > Thus I think bfq_del_bfqq_busy() is not the right place to do that.
> > 
> > Yes, I'm aware there will be a difference. But note that bfqq can stay busy
> > with only dispatched requests because the logic in __bfq_bfqq_expire() will
> > not call bfq_del_bfqq_busy() if idling is needed for service guarantees. So
> > I think using bfq_add/del_bfqq_busy() would work OK.
> Hi,
> 
> I didn't think of that before. If bfqq stay busy after dispathing all
> the requests, there are two other places that bfqq can clear busy:
> 
> 1) bfq_remove_request(), bfqq has to insert a new req while it's not in
> service.

Yes and the request then would have to be dispatched or merged. Which
generally means another bfqq from the same bfqg is currently active and
thus this should have no impact on service guarantees we are interested in.

> 2) bfq_release_process_ref(), user thread is gone / moved, or old bfqq
> is gone due to merge / ioprio change.

Yes, here there's no new IO for the bfqq so no point in maintaining any
service guarantees to it.

> I wonder, will bfq_del_bfqq_busy() be called immediately when requests
> are completed? (It seems not to me...). For example, a user thread
> issue a sync io just once, and it keep running without issuing new io,
> then when does the bfqq clears the busy state?

No, when bfqq is kept busy, it will get scheduled as in-service queue in
the future. Then what happens depends on whether it will get more requests
or not. But generally its busy state will get cleared once it is expired
for other reason than preemption.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
