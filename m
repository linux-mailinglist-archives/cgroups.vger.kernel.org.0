Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71714691C6E
	for <lists+cgroups@lfdr.de>; Fri, 10 Feb 2023 11:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjBJKMs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Feb 2023 05:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBJKMr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Feb 2023 05:12:47 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C6060303;
        Fri, 10 Feb 2023 02:12:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D20E95FA5E;
        Fri, 10 Feb 2023 10:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676023964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1QLhQop7MVEJVqH+irAiadIwt7myVpzIBP9m/xziqnA=;
        b=VQtbc9tEJLFJF0Pw5PjECmBuPAKFt4AvPORe5P6oZ2MzadE81h99ZIUb7KFajj63MWUyMW
        m5UgmHAg/UuvODkXLNiw9dIF1tepZSsyV+Ichh0V1iaRREj6quFohULxLUWN2gg5dMVrYA
        lEdDwq+fhNH/qSTQkitEKwWN3/sfAaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676023964;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1QLhQop7MVEJVqH+irAiadIwt7myVpzIBP9m/xziqnA=;
        b=tUf6mwNmwxBFmfkwRwvlGR/TSOGT0glc5CsHdFA2Mg008Z7jSMcUsJAZvc1DufM4+PFeXg
        6/fgtb2lJwC5aBAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD7F913206;
        Fri, 10 Feb 2023 10:12:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vIo4LpwY5mPgQQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 10 Feb 2023 10:12:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 30E0DA06D8; Fri, 10 Feb 2023 11:12:44 +0100 (CET)
Date:   Fri, 10 Feb 2023 11:12:44 +0100
From:   Jan Kara <jack@suse.cz>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jan Kara <jack@suse.cz>, Hou Tao <houtao@huaweicloud.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, houtao1@huawei.com
Subject: Re: [PATCH] blk-ioprio: Introduce promote-to-rt policy
Message-ID: <20230210101244.zsmtmsoo4xjx7suj@quack3>
References: <20230201045227.2203123-1-houtao@huaweicloud.com>
 <8c068af3-7199-11cf-5c69-a523c7c22d9a@acm.org>
 <4f7dcb3e-2d5a-cae3-0e1c-a82bcc3d2217@huaweicloud.com>
 <b6b3c498-e90b-7d1f-6ad5-a31334e433ae@acm.org>
 <beb7782e-72a4-c350-3750-23a767c88753@huaweicloud.com>
 <aedc240d-7c9e-248a-52d2-c9775f3e8ca1@acm.org>
 <20230208134345.77bdep3kzp52haxu@quack3>
 <7fcd4c38-ccbe-6411-e424-a57595ad9c0b@acm.org>
 <20230209085603.dzqfcc3pp4hacqlz@quack3>
 <55a065e7-7d86-d58f-15ba-c631a427843e@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55a065e7-7d86-d58f-15ba-c631a427843e@acm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 09-02-23 11:09:33, Bart Van Assche wrote:
> On 2/9/23 00:56, Jan Kara wrote:
> > On Wed 08-02-23 09:53:41, Bart Van Assche wrote:
> > > The test results I shared some time ago show that IOPRIO_CLASS_NONE was the
> > > default I/O priority two years ago (see also https://lore.kernel.org/linux-block/20210927220328.1410161-5-bvanassche@acm.org/).
> > > The none-to-rt policy increases the priority of bio's that have not been
> > > assigned an I/O priority to RT. Does this answer your question?
> > 
> > Not quite. I know that historically we didn't set bio I/O priority in some
> > paths (but we did set it in other paths such as some (but not all) direct
> > IO implementations). But that was exactly a mess because how none-to-rt
> > actually behaved depended on the exact details of the kernel internal IO
> > path.  So my question is: Was none-to-rt actually just a misnomer and the
> > intended behavior was "always override to RT"? Or what was exactly the
> > expectation around when IO priority is not set and should be overridden?
> > 
> > How should it interact with AIO submissions with IOCB_FLAG_IOPRIO? How
> > should it interact with task having its IO priority modified with
> > ioprio_set(2)? And what if task has its normal scheduling priority modified
> > but that translates into different IO priority (which happens in
> > __get_task_ioprio())?
> > 
> > So I think that none-to-rt is just poorly defined and if we can just get
> > rid of it (or redefine to promote-to-rt), that would be good. But maybe I'm
> > missing some intended usecase...
> 
> Hi Jan,
> 
> We have no plans to use the ioprio_set() system call since it only affects
> foreground I/O and not page cache writeback.
> 
> While Android supports io_uring, there are no plans to support libaio in the
> Android C library (Bionic).
> 
> Regarding __get_task_ioprio(), I haven't found any code in that function
> that derives an I/O priority from the scheduling priority. Did I perhaps
> overlook something?

This condition in __get_task_ioprio():

        if (IOPRIO_PRIO_CLASS(prio) == IOPRIO_CLASS_NONE)
                prio = IOPRIO_PRIO_VALUE(task_nice_ioclass(p),
                                         task_nice_ioprio(p));

sets task's IO priority based on scheduling priority.

> Until recently "none-to-rt" meant "if no I/O priority has been assigned to a
> task, use IOPRIO_CLASS_RT". Promoting the I/O priority to IOPRIO_CLASS_RT
> works for us. I'm fine with changing the meaning of "none-to-rt" into
> promoting the I/O priority class to RT. Introducing "promote-to-rt" as a
> synonym of "none-to-rt" is also fine with me.

OK, so it seems we are all in agreement here that "none-to-rt" behavior is
not really needed. Hou, can you perhaps update your patches and the
documentation to make "none-to-rt" just an alias for "promote-to-rt"?
Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
