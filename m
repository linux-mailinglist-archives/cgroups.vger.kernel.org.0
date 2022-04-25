Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66DF50E5C7
	for <lists+cgroups@lfdr.de>; Mon, 25 Apr 2022 18:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiDYQap (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Apr 2022 12:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243567AbiDYQaa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Apr 2022 12:30:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC5A8A315;
        Mon, 25 Apr 2022 09:26:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9FD96210E4;
        Mon, 25 Apr 2022 16:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650903968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VUB+heCNyeRFdPDI1DhMrxZcGuxVYUwZDE80GwpHJU8=;
        b=pdXu4C9WWm9PwhxJ4kncFBH/N6LpW+See8N92WAtqIGuzAwMFB2MW2lwZkGZStmGNMJT/S
        Oql8ZjWpYrf8ogzL8VQ3cIPkfW8AWk8h4BuJHKGZWzp0ignZcWNfNucjWTl9vFEEoDD+tN
        dJo8wa5/oF7v9fgW10I9mAzX1xSkm/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650903968;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VUB+heCNyeRFdPDI1DhMrxZcGuxVYUwZDE80GwpHJU8=;
        b=kj1ovTZoxRmdmq25y5rwYeLhZBg+ACRAbP3a30Yt/bDVvCkDIQOoWuoBrgv7Mip8r98v41
        2lUqmZqKseXVKkDg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8E7412C141;
        Mon, 25 Apr 2022 16:26:08 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3825DA0620; Mon, 25 Apr 2022 18:26:08 +0200 (CEST)
Date:   Mon, 25 Apr 2022 18:26:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, paolo.valente@linaro.org, axboe@kernel.dk,
        tj@kernel.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next v2 2/5] block, bfq: add fake weight_counter for
 weight-raised queue
Message-ID: <20220425162608.feya66a5amdnsr4e@quack3.lan>
References: <20220416093753.3054696-1-yukuai3@huawei.com>
 <20220416093753.3054696-3-yukuai3@huawei.com>
 <20220425094856.qgkhba2klguduxot@quack3.lan>
 <a27b8c79-867f-9253-84db-1d39c964b3ed@huawei.com>
 <4048cc0c-adc8-8097-4a40-762137c4c282@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4048cc0c-adc8-8097-4a40-762137c4c282@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 25-04-22 21:55:46, yukuai (C) wrote:
> 在 2022/04/25 21:34, yukuai (C) 写道:
> > 在 2022/04/25 17:48, Jan Kara 写道:
> > > On Sat 16-04-22 17:37:50, Yu Kuai wrote:
> > > > Weight-raised queue is not inserted to weights_tree, which makes it
> > > > impossible to track how many queues have pending requests through
> > > > weights_tree insertion and removel. This patch add fake weight_counter
> > > > for weight-raised queue to do that.
> > > > 
> > > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > > 
> > > This is a bit hacky. I was looking into a better place where to hook to
> > > count entities in a bfq_group with requests and I think
> > > bfq_add_bfqq_busy()
> > > and bfq_del_bfqq_busy() are ideal for this. It also makes better sense
> > > conceptually than hooking into weights tree handling.
> > > 
> > Hi,
> > 
> > bfq_del_bfqq_busy() will be called when all the reqs in the bfqq are
> > dispatched, however there might still some reqs are't completed yet.
> > 
> > Here what we want to track is how many bfqqs have pending reqs,
> > specifically if the bfqq have reqs are't complted.
> > 
> > Thus I think bfq_del_bfqq_busy() is not the right place to do that.
> 
> BTW, there is a counter 'dispatched' in bfqq, how about we rename it
> to 'inflight', and inc when adding req to bfqq, dec the same as
> 'dispatched' ?
> 
> This way we can count bfqq when adding 'inflight' from 0 to 1, and
> stop when decreasing 'inflight' from 1 to 0.

Well, but 'dispatched' is used in quite a few places and it would require
quite some thinking to decide which impact using 'inflight' has there...
But we also have 'bfqq->entity.allocated' which is number of requests in
some state associated with bfqq and we could use that. But as I wrote in my
previous email, I'm not convinced it is really necessary...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
