Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8539365B079
	for <lists+cgroups@lfdr.de>; Mon,  2 Jan 2023 12:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjABLXi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Jan 2023 06:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbjABLXE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Jan 2023 06:23:04 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4C35FAB;
        Mon,  2 Jan 2023 03:23:00 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ECDDF3407E;
        Mon,  2 Jan 2023 11:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672658578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VqwR+u//1iVHsLjS8ecEfHM3m/I8nXvJ9KjV1eh5WXs=;
        b=QhMvVVMsVf6x5AViodhwkQFpoKLW/PYRa0Ijf7o3mskGYh6S4+61ZECF9G3TYScuIp7trv
        mK8+RjALUdvmq5ZNuTg5/Tz5jodjLfufzWzjON0Kq+iFv13oOJ9np0a2VmyjWDhzfGRKVI
        EWhorYbh0tj61v8YqB35xiUgkTRvk6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672658578;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VqwR+u//1iVHsLjS8ecEfHM3m/I8nXvJ9KjV1eh5WXs=;
        b=K0tV4Q/xIo8tj99PVm3YZoJHBPvz4Lgq/VAnMDEUg/pj96U16eNquZmpyyQjnPO+/riu1/
        l4ZdCXpQqX/S11Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9C1913427;
        Mon,  2 Jan 2023 11:22:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jt8kNZK+smOqbgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 02 Jan 2023 11:22:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4ACF3A073E; Mon,  2 Jan 2023 12:22:58 +0100 (CET)
Date:   Mon, 2 Jan 2023 12:22:58 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jack@suse.cz, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        paolo.valente@linaro.org, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH RFC] block, bfq: switch 'bfqg->ref' to use atomic
 refcount apis
Message-ID: <20230102112258.3fixhuialamu6pkd@quack3>
References: <20221227031541.2595647-1-yukuai1@huaweicloud.com>
 <ba5e74a6-b3de-844d-16b8-84eb429c7058@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba5e74a6-b3de-844d-16b8-84eb429c7058@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 27-12-22 14:09:40, Yu Kuai wrote:
> Hi, Jan!
> 
> 在 2022/12/27 11:15, Yu Kuai 写道:
> > From: Yu Kuai <yukuai3@huawei.com>
> > 
> > The updating of 'bfqg->ref' should be protected by 'bfqd->lock', however,
> > during code review, we found that bfq_pd_free() update 'bfqg->ref'
> > without holding the lock, which is problematic:
> > 
> > 1) bfq_pd_free() triggered by removing cgroup is called asynchronously;
> > 2) bfqq will grab bfqg reference, and exit bfqq will drop the reference,
> > which can concurrenty with 1).
> > 
> > Unfortunately, 'bfqd->lock' can't be held here because 'bfqd' might already
> > be freed in bfq_pd_free(). Fix the problem by using atomic refcount apis.
> > 
> > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > ---
> >   block/bfq-cgroup.c  | 8 +++-----
> >   block/bfq-iosched.h | 2 +-
> >   2 files changed, 4 insertions(+), 6 deletions(-)
> > 
> > diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> > index 1b2829e99dad..aa9c4f02e3a3 100644
> > --- a/block/bfq-cgroup.c
> > +++ b/block/bfq-cgroup.c
> > @@ -316,14 +316,12 @@ struct bfq_group *bfqq_group(struct bfq_queue *bfqq)
> >   static void bfqg_get(struct bfq_group *bfqg)
> >   {
> > -	bfqg->ref++;
> > +	refcount_inc(&bfqg->ref);
> >   }
> >   static void bfqg_put(struct bfq_group *bfqg)
> >   {
> > -	bfqg->ref--;
> > -
> > -	if (bfqg->ref == 0)
> > +	if (refcount_dec_and_test(bfqg->ref))
> Sorry that here should be '&bfqg->ref'.
> 
> Anyway, I'll wait for you, and send a new version if you think this
> patch make sense.

Yes, the patch makes sense to me so feel free to send fixed version.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
