Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDA3690296
	for <lists+cgroups@lfdr.de>; Thu,  9 Feb 2023 09:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjBII4K (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Feb 2023 03:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjBII4I (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Feb 2023 03:56:08 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7013D552AC;
        Thu,  9 Feb 2023 00:56:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1CBAD5C4DC;
        Thu,  9 Feb 2023 08:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675932964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qVb6PkykPlUvG7xHNit73rZeHDsaX88KM/DKTpLOLzM=;
        b=ozIiNshfbavMHirWt6F0todfWfiwm5JzUcNGRJfJO6x7U3QlhVdFKzeE0SKMy7NgFn0sdk
        CzCbBbHwDWzsR4CWbg6JW41sJRihHnrmc/XiMjrs2AeKMux5Czui0ZIp00I2Brj0f3Jqhf
        kJdt48plef1rlG/ixTCbhVBo9TwGUsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675932964;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qVb6PkykPlUvG7xHNit73rZeHDsaX88KM/DKTpLOLzM=;
        b=TZTv1A2de4VTakAmG2o3Qzgf+4POcX0jgAbEfKGWqrktO53TQ1QmvEpzZxGxPQM8CT05lE
        scVPWbKyrkT8eLAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0EA4C1339E;
        Thu,  9 Feb 2023 08:56:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ad2JAyS15GNLHgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 09 Feb 2023 08:56:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6D016A06D8; Thu,  9 Feb 2023 09:56:03 +0100 (CET)
Date:   Thu, 9 Feb 2023 09:56:03 +0100
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
Message-ID: <20230209085603.dzqfcc3pp4hacqlz@quack3>
References: <20230201045227.2203123-1-houtao@huaweicloud.com>
 <8c068af3-7199-11cf-5c69-a523c7c22d9a@acm.org>
 <4f7dcb3e-2d5a-cae3-0e1c-a82bcc3d2217@huaweicloud.com>
 <b6b3c498-e90b-7d1f-6ad5-a31334e433ae@acm.org>
 <beb7782e-72a4-c350-3750-23a767c88753@huaweicloud.com>
 <aedc240d-7c9e-248a-52d2-c9775f3e8ca1@acm.org>
 <20230208134345.77bdep3kzp52haxu@quack3>
 <7fcd4c38-ccbe-6411-e424-a57595ad9c0b@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fcd4c38-ccbe-6411-e424-a57595ad9c0b@acm.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 08-02-23 09:53:41, Bart Van Assche wrote:
> On 2/8/23 05:43, Jan Kara wrote:
> > On Fri 03-02-23 11:45:32, Bart Van Assche wrote:
> > > On 2/2/23 17:48, Hou Tao wrote:
> > > > I don't get it on how to remove IOPRIO_POL_PROMOTION when calculating the final
> > > > ioprio for bio. IOPRIO_POL_PROMOTION is not used for IOPRIO_CLASS values but
> > > > used to determinate on how to calculate the final ioprio for bio: choosing the
> > > > maximum or minimum between blkcg ioprio and original bio bi_ioprio.
> > > 
> > > Do the block layer code changes shown below implement the functionality
> > > that you need?
> > 
> > Just one question guys: So with my a78418e6a04c ("block: Always initialize
> > bio IO priority on submit") none-to-rt policy became effectively a noop as
> > Hou properly noticed. Are we aware of any users that were broken by this?
> > Shouldn't we rather fix the code so that none-to-rt starts to operate
> > correctly again? Or maybe change the none-to-rt meaning to be actually
> > promote-to-rt?
> > 
> > I have to admit I'm wondering a bit what was the intended usecase behind
> > the introduction of none-to-rt policy. Can someone elaborate? promote-to-rt
> > makes some sense to me - we have a priviledged cgroup we want to provide
> > low latency access to IO but none-to-rt just does not make much sense to
> > me...
> 
> Hi Jan,
> 
> The test results I shared some time ago show that IOPRIO_CLASS_NONE was the
> default I/O priority two years ago (see also https://lore.kernel.org/linux-block/20210927220328.1410161-5-bvanassche@acm.org/).
> The none-to-rt policy increases the priority of bio's that have not been
> assigned an I/O priority to RT. Does this answer your question?

Not quite. I know that historically we didn't set bio I/O priority in some
paths (but we did set it in other paths such as some (but not all) direct
IO implementations). But that was exactly a mess because how none-to-rt
actually behaved depended on the exact details of the kernel internal IO
path.  So my question is: Was none-to-rt actually just a misnomer and the
intended behavior was "always override to RT"? Or what was exactly the
expectation around when IO priority is not set and should be overridden?

How should it interact with AIO submissions with IOCB_FLAG_IOPRIO? How
should it interact with task having its IO priority modified with
ioprio_set(2)? And what if task has its normal scheduling priority modified
but that translates into different IO priority (which happens in
__get_task_ioprio())?

So I think that none-to-rt is just poorly defined and if we can just get
rid of it (or redefine to promote-to-rt), that would be good. But maybe I'm
missing some intended usecase...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
