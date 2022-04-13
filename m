Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FBC4FF558
	for <lists+cgroups@lfdr.de>; Wed, 13 Apr 2022 12:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiDMLCJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Apr 2022 07:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbiDMLCC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Apr 2022 07:02:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D784A37007;
        Wed, 13 Apr 2022 03:59:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 425D41F38D;
        Wed, 13 Apr 2022 10:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649847576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wDpLcKcoO1WwDvcdrmwFpkecci9vWrSlucy8QFrOTss=;
        b=mDyZRhCYWckG34SjMe4g6nPNZgJ55QHWnwI7oaEaQ2mn+HPboP3GACBBQgPZ6JxJfPy3kk
        yL9ukSF/0fSeA9MPsbDFWwEg/Hb1KT1nQtr2yHolzPARxlpn62Jitnu2bFWMe/OrtcvFI7
        bQexwGq8kbq1kvzjPqgXH/2aVTJvTJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649847576;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wDpLcKcoO1WwDvcdrmwFpkecci9vWrSlucy8QFrOTss=;
        b=PcqCmKSoxxi3NkJNbdqh24qCyooy9yqTpSkUBxpJ1j2dVGgMUQH9ODIEqBs7qC0MMB5x9H
        1sBvjUMgBxxjyxAA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2326AA3B92;
        Wed, 13 Apr 2022 10:59:35 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 698F4A0615; Wed, 13 Apr 2022 12:59:32 +0200 (CEST)
Date:   Wed, 13 Apr 2022 12:59:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     tj@kernel.org, axboe@kernel.dk, paolo.valente@linaro.org,
        jack@suse.cz, cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH -next 02/11] block, bfq: apply news apis where root group
 is not expected
Message-ID: <20220413105932.lzvlafeilinuqcw3@quack3.lan>
References: <20220305091205.4188398-1-yukuai3@huawei.com>
 <20220305091205.4188398-3-yukuai3@huawei.com>
 <20220413095044.uwxeqli2ytcdanem@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413095044.uwxeqli2ytcdanem@quack3.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 13-04-22 11:50:44, Jan Kara wrote:
> On Sat 05-03-22 17:11:56, Yu Kuai wrote:
> > 'entity->sched_data' is set to parent group's sched_data, thus it's NULL
> > for root group. And for_each_entity() is used widely to access
> > 'entity->sched_data', thus aplly news apis if root group is not
>                              ^^ apply
> 
> > expected. Prepare to count root group into 'num_groups_with_pending_reqs'.
> > 
> > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > ---
> >  block/bfq-iosched.c |  2 +-
> >  block/bfq-iosched.h | 22 ++++++++--------------
> >  block/bfq-wf2q.c    | 10 +++++-----
> >  3 files changed, 14 insertions(+), 20 deletions(-)
> > 
> > diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> > index 69ddf6b0f01d..3bc7a7686aad 100644
> > --- a/block/bfq-iosched.c
> > +++ b/block/bfq-iosched.c
> > @@ -4393,7 +4393,7 @@ void bfq_bfqq_expire(struct bfq_data *bfqd,
> >  	 * service with the same budget.
> >  	 */
> >  	entity = entity->parent;
> > -	for_each_entity(entity)
> > +	for_each_entity_not_root(entity)
> >  		entity->service = 0;
> >  }
> 
> So why is it a problem to clear the service for root cgroup here?
> 
> > diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> > index f8eb340381cf..c4cb935a615a 100644
> > --- a/block/bfq-wf2q.c
> > +++ b/block/bfq-wf2q.c
> > @@ -815,7 +815,7 @@ void bfq_bfqq_served(struct bfq_queue *bfqq, int served)
> >  		bfqq->service_from_wr += served;
> >  
> >  	bfqq->service_from_backlogged += served;
> > -	for_each_entity(entity) {
> > +	for_each_entity_not_root(entity) {
> >  		st = bfq_entity_service_tree(entity);
> 
> Hum, right so how come this was not crashing? Because entity->sched_data is
> indeed NULL for bfqd->root_group->entity and so bfq_entity_service_tree()
> returned some bogus pointer? Similarly for the cases you are changing
> below?

Oh, I see now. Because for_each_entity() currently does not iterate through
root cgroup because it has root_group->my_entity set to NULL and thus as a
result immediate children of root_group will have their parent set to NULL
as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
