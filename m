Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C07506808
	for <lists+cgroups@lfdr.de>; Tue, 19 Apr 2022 11:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244818AbiDSJwr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Apr 2022 05:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350438AbiDSJwn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Apr 2022 05:52:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA5E11C08;
        Tue, 19 Apr 2022 02:49:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 703691F38D;
        Tue, 19 Apr 2022 09:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650361798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J1deqUxc9C8D6lInkd2DloHcFrHOp4GMQ6s/PLFQPqA=;
        b=19W+p5kE2JN+9TJwKovFQQHYDzGXCipmtRiqv16MxNu2WAphcZeAaEeeZd13G8/XMcOXYR
        QlLrHgV7LR3mKgXduFGrmGMKuwYsa7v/2nxukCq3s90vAPazeKwbGFGzDnTt2CCiz7Vif9
        ydCaXqQAhEqqlAsgAHKloKj1BX52vno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650361798;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J1deqUxc9C8D6lInkd2DloHcFrHOp4GMQ6s/PLFQPqA=;
        b=iO8ylqwF5TMzf4SeDvp3qCGb8/Ge2WiU2xauMHrhCLNPzzESfu1Pgcwn+dfkQ/J32faC+T
        ALuphv9JSEHACgBw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5F1552C141;
        Tue, 19 Apr 2022 09:49:58 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9AC27A0620; Tue, 19 Apr 2022 11:49:55 +0200 (CEST)
Date:   Tue, 19 Apr 2022 11:49:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, tj@kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next 10/11] block, bfq: decrease
 'num_groups_with_pending_reqs' earlier
Message-ID: <20220419094955.ucjxadnhdyonfjdo@quack3.lan>
References: <20220305091205.4188398-1-yukuai3@huawei.com>
 <20220305091205.4188398-11-yukuai3@huawei.com>
 <20220413112816.fwobg4cp6ttpnpk6@quack3.lan>
 <f3ed507a-7c85-cd69-3ad5-3e9c0e75c372@huawei.com>
 <ef7bad8c-b8dd-f625-330c-9a22e303844b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef7bad8c-b8dd-f625-330c-9a22e303844b@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 15-04-22 09:10:06, yukuai (C) wrote:
> 在 2022/04/13 19:40, yukuai (C) 写道:
> > 在 2022/04/13 19:28, Jan Kara 写道:
> > > On Sat 05-03-22 17:12:04, Yu Kuai wrote:
> > > > Currently 'num_groups_with_pending_reqs' won't be decreased when
> > > > the group doesn't have any pending requests, while some child group
> > > > still have pending requests. The decrement is delayed to when all the
> > > > child groups doesn't have any pending requests.
> > > > 
> > > > For example:
> > > > 1) t1 issue sync io on root group, t2 and t3 issue sync io on the same
> > > > child group. num_groups_with_pending_reqs is 2 now.
> > > > 2) t1 stopped, num_groups_with_pending_reqs is still 2. io from t2 and
> > > > t3 still can't be handled concurrently.
> > > > 
> > > > Fix the problem by decreasing 'num_groups_with_pending_reqs'
> > > > immediately upon the weights_tree removal of last bfqq of the group.
> > > > 
> > > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > > 
> > > So I'd find the logic easier to follow if you completely removed
> > > entity->in_groups_with_pending_reqs and did updates of
> > > bfqd->num_groups_with_pending_reqs like:
> > > 
> > >     if (!bfqg->num_entities_with_pending_reqs++)
> > >         bfqd->num_groups_with_pending_reqs++;
> > > 
> > Hi,
> > 
> > Indeed, this is an excellent idle, and much better than the way I did.
> > 
> > Thanks,
> > Kuai
> > 
> > > and similarly on the remove side. And there would we literally two places
> > > (addition & removal from weight tree) that would need to touch these
> > > counters. Pretty obvious and all can be done in patch 9.
> 
> I think with this change, we can count root_group while activating bfqqs
> that are under root_group, thus there is no need to modify
> for_each_entity(or fake bfq_sched_data) any more.

Sure, if you can make this work, it would be easier :)

> The special case is that weight racing bfqqs are not inserted into
> weights tree, and I think this can be handled by adding a fake
> bfq_weight_counter for such bfqqs.

Do you mean "weight raised bfqqs"? Yes, you are right they would need
special treatment - maybe bfq_weights_tree_add() is not the best function
to use for this and we should rather use insertion / removal from the
service tree for maintaining num_entities_with_pending_reqs counter?
I can even see we already have bfqg->active_entities so maybe we could just
somehow tweak that accounting and use it for our purposes?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
