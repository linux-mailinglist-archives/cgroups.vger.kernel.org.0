Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CBF5B838F
	for <lists+cgroups@lfdr.de>; Wed, 14 Sep 2022 11:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiINJBO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Sep 2022 05:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiINJAs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 14 Sep 2022 05:00:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52445F8E;
        Wed, 14 Sep 2022 02:00:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 487A35CD35;
        Wed, 14 Sep 2022 09:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663146037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=++TRGvwUmp+i5nL8+2zUUfPddCZzIMndHJUJU3TWquc=;
        b=0pJVoKCAJ3FBW3e1gyMtWHemmHz7UDLUu0VEFMGTyY8gaY1LTEGZoiWQKG28goN5FloqPb
        i4JmEYtwjE841exwbCpLmSljMeNbOm/4wnOGVdQSq6yKGqBb6dq3i90rvP1Mp55rIv5CNw
        CemMlwLK4kon39piQkntcYtMAqdtqLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663146037;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=++TRGvwUmp+i5nL8+2zUUfPddCZzIMndHJUJU3TWquc=;
        b=W/FlRVx3EDd2iGJRcFy5GRKA4ZOATIqe2iAtwQV9BRa+RvcyfvK7ZIdxemUiG7eJjZO/V6
        IA9o7fdI47wKyZDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3925813494;
        Wed, 14 Sep 2022 09:00:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o8fzDTWYIWOKHQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 14 Sep 2022 09:00:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C8E99A0680; Wed, 14 Sep 2022 11:00:36 +0200 (CEST)
Date:   Wed, 14 Sep 2022 11:00:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Paolo VALENTE <paolo.valente@unimore.it>, Jan Kara <jack@suse.cz>,
        cgroups@vger.kernel.org, linux-block <linux-block@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH -next v10 3/4] block, bfq: refactor the counting of
 'num_groups_with_pending_reqs'
Message-ID: <20220914090036.46zsrj2l23ubvvk6@quack3>
References: <2f94f241-445f-1beb-c4a8-73f6efce5af2@huaweicloud.com>
 <55A07102-BE55-4606-9E32-64E884064FB9@unimore.it>
 <5cb0e5bc-feec-86d6-6f60-3c28ee625efd@huaweicloud.com>
 <D89DCF20-27D8-4F8F-B8B0-FD193FC4F18D@unimore.it>
 <e6b53794-f93f-92b2-1f45-35ae81a28a5c@huaweicloud.com>
 <F758A356-EE6B-4B7B-95E2-6414616C77E4@unimore.it>
 <5e0b44b4-46cc-b3c6-1d93-00a0a683eda8@huaweicloud.com>
 <f89eb61b-7912-5916-1a12-039e32bebe70@huaweicloud.com>
 <BF3909EA-4659-48CB-917A-639DC3318916@unimore.it>
 <97534773-484f-5c2c-a371-446cc0680b73@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97534773-484f-5c2c-a371-446cc0680b73@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi guys!

On Wed 14-09-22 16:15:26, Yu Kuai wrote:
> 在 2022/09/14 15:50, Paolo VALENTE 写道:
> > 
> > 
> > > Il giorno 14 set 2022, alle ore 03:55, Yu Kuai <yukuai1@huaweicloud.com> ha scritto:
> > > 
> > > 
> > > 
> > > 在 2022/09/07 9:16, Yu Kuai 写道:
> > > > Hi, Paolo!
> > > > 在 2022/09/06 17:37, Paolo Valente 写道:
> > > > > 
> > > > > 
> > > > > > Il giorno 26 ago 2022, alle ore 04:34, Yu Kuai <yukuai1@huaweicloud.com> ha scritto:
> > > > > > 
> > > > > > Hi, Paolo!
> > > > > > 
> > > > > > 在 2022/08/25 22:59, Paolo Valente 写道:
> > > > > > > > Il giorno 11 ago 2022, alle ore 03:19, Yu Kuai <yukuai1@huaweicloud.com <mailto:yukuai1@huaweicloud.com>> ha scritto:
> > > > > > > > 
> > > > > > > > Hi, Paolo
> > > > > > > > 
> > > > > > > > 在 2022/08/10 18:49, Paolo Valente 写道:
> > > > > > > > > > Il giorno 27 lug 2022, alle ore 14:11, Yu Kuai <yukuai1@huaweicloud.com <mailto:yukuai1@huaweicloud.com>> ha scritto:
> > > > > > > > > > 
> > > > > > > > > > Hi, Paolo
> > > > > > > > > > 
> > > > > > > > > hi
> > > > > > > > > > Are you still interested in this patchset?
> > > > > > > > > > 
> > > > > > > > > Yes. Sorry for replying very late again.
> > > > > > > > > Probably the last fix that you suggest is enough, but I'm a little bit
> > > > > > > > > concerned that it may be a little hasty.  In fact, before this fix, we
> > > > > > > > > exchanged several messages, and I didn't seem to be very good at
> > > > > > > > > convincing you about the need to keep into account also in-service
> > > > > > > > > I/O.  So, my question is: are you sure that now you have a
> > > > > > > > 
> > > > > > > > I'm confused here, I'm pretty aware that in-service I/O(as said pending
> > > > > > > > requests is the patchset) should be counted, as you suggested in v7, are
> > > > > > > > you still thinking that the way in this patchset is problematic?
> > > > > > > > 
> > > > > > > > I'll try to explain again that how to track is bfqq has pending pending
> > > > > > > > requests, please let me know if you still think there are some problems:
> > > > > > > > 
> > > > > > > > patch 1 support to track if bfqq has pending requests, it's
> > > > > > > > done by setting the flag 'entity->in_groups_with_pending_reqs' when the
> > > > > > > > first request is inserted to bfqq, and it's cleared when the last
> > > > > > > > request is completed. specifically the flag is set in
> > > > > > > > bfq_add_bfqq_busy() when 'bfqq->dispatched' if false, and it's cleared
> > > > > > > > both in bfq_completed_request() and bfq_del_bfqq_busy() when
> > > > > > > > 'bfqq->diapatched' is false.
> > > > > > > > 
> > > > > > > This general description seems correct to me. Have you already sent a new version of your patchset?
> > > > > > 
> > > > > > It's glad that we finially on the same page here.
> > > > > > 
> > > > > 
> > > > > Yep. Sorry for my chronicle delay.
> > > > Better late than never 😁
> > > > > 
> > > > > > Please take a look at patch 1, which already impelement the above
> > > > > > descriptions, it seems to me there is no need to send a new version
> > > > > > for now. If you think there are still some other problems, please let
> > > > > > me know.
> > > > > > 
> > > > > 
> > > > > Patch 1 seems ok to me. I seem to have only one pending comment on this patch (3/4) instead. Let me paste previous stuff here for your convenience:
> > > > That sounds good.
> > > > > 
> > > > > > > 
> > > > > > > -    /*
> > > > > > > -     * Next function is invoked last, because it causes bfqq to be
> > > > > > > -     * freed if the following holds: bfqq is not in service and
> > > > > > > -     * has no dispatched request. DO NOT use bfqq after the next
> > > > > > > -     * function invocation.
> > > > > > > -     */
> > > > > > I would really love it if you leave this comment.  I added it after
> > > > > > suffering a lot for a nasty UAF.  Of course the first sentence may
> > > > > > need to be adjusted if the code that precedes it is to be removed.
> > > > > > Same as above, if this patch is applied, this function will be gone.
> > > 
> > > Hi, I'm curious while I'm trying to add the comment, before this
> > > patchset, can bfqq be freed when bfq_weights_tree_remove is called?
> > > 
> > > bfq_completed_request
> > > bfqq->dispatched--
> > > if (!bfqq->dispatched && !bfq_bfqq_busy(bfqq))
> > >   bfq_weights_tree_remove(bfqd, bfqq);
> > > 
> > > // continue to use bfqq
> > > 
> > > It seems to me this is problematic if so, because bfqq is used after
> > > bfq_weights_tree_remove() is called.
> > > 
> > 
> > It is.  Yet, IIRC, I verified that bfqq was not used after that free,
> > and I added that comment as a heads-up.  What is a scenario (before
> > your pending modifications) where this use-after-free happens?
> > 
> 
> No, it never happens, I just notice it because it'll be weird if I
> place the comment where bfq_weights_tree_remove() is called, since bfqq
> will still be accessed.
> 
> If the suituation that the comment says is possible, perhaps we should
> move bfq_weights_tree_remove() to the last of bfq_completed_request().
> However, it seems that we haven't meet the problem for quite a long
> time...

I'm bit confused which comment you are speaking about but
bfq_completed_request() gets called only from bfq_finish_requeue_request()
and the request itself still holds a reference to bfqq. Only later in
bfq_finish_requeue_request() when we do:

	bfqq_request_freed(bfqq);
	bfq_put_queue(bfqq);

bfqq can get freed.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
