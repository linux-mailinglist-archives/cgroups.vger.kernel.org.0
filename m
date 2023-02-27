Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5161E6A457E
	for <lists+cgroups@lfdr.de>; Mon, 27 Feb 2023 16:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjB0PC2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Feb 2023 10:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjB0PC1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Feb 2023 10:02:27 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0458555BE;
        Mon, 27 Feb 2023 07:02:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7AA48219FB;
        Mon, 27 Feb 2023 15:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677510144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gQdlZOcHYNl5XRcWKHNMj/kCNmWBN/fJPu/xDdRs1kc=;
        b=MuOFW8HlHEK8azDxmhRDJhV5hwinNYrmK4nKpsf9WVDIZzds9W9IQn/s3uHbfRbvyKHbrH
        V9X/4BR4XycqMMXkIe/QJ7cXYM+KlE8/KyncZlvdIgwIrZkp75iDVcaG/aK1zBQDKV8C/z
        c2XEWUo5OCpZnLqG3aSu1U4cBY2takw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677510144;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gQdlZOcHYNl5XRcWKHNMj/kCNmWBN/fJPu/xDdRs1kc=;
        b=+5JdXbctffs1QjnpI1Z5DvF5Nfr5Hb27YR2JhzIncsyffP9hNKgiYRyB/X6OuBsp75Ch6I
        MZUNPq4bphQuz9Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6404D13A43;
        Mon, 27 Feb 2023 15:02:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JvRPGADG/GNyGwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 27 Feb 2023 15:02:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BE2B8A06F2; Mon, 27 Feb 2023 16:02:23 +0100 (CET)
Date:   Mon, 27 Feb 2023 16:02:23 +0100
From:   Jan Kara <jack@suse.cz>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, houtao1@huawei.com
Subject: Re: [PATCH v2] blk-ioprio: Introduce promote-to-rt policy
Message-ID: <20230227150223.vvjvhiesgnbfea5z@quack3>
References: <20230220135428.2632906-1-houtao@huaweicloud.com>
 <20230227130305.2idxwmz2kdnacolc@quack3>
 <05eafc4f-2d60-b7e6-1d5d-9a08709916e8@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05eafc4f-2d60-b7e6-1d5d-9a08709916e8@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 27-02-23 21:56:25, Hou Tao wrote:
> Hi
> 
> On 2/27/2023 9:03 PM, Jan Kara wrote:
> > On Mon 20-02-23 21:54:28, Hou Tao wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >>
> >> Since commit a78418e6a04c ("block: Always initialize bio IO priority on
> >> submit"), bio->bi_ioprio will never be IOPRIO_CLASS_NONE when calling
> >> blkcg_set_ioprio(), so there will be no way to promote the io-priority
> >> of one cgroup to IOPRIO_CLASS_RT, because bi_ioprio will always be
> >> greater than or equals to IOPRIO_CLASS_RT.
> >>
> >> It seems possible to call blkcg_set_ioprio() first then try to
> >> initialize bi_ioprio later in bio_set_ioprio(), but this doesn't work
> >> for bio in which bi_ioprio is already initialized (e.g., direct-io), so
> >> introduce a new ioprio policy to promote the iopriority of bio to
> >> IOPRIO_CLASS_RT if the ioprio is not already RT.
> >>
> >> So introduce a new promote-to-rt policy to achieve this. For none-to-rt
> >> policy, although it doesn't work now, but considering that its purpose
> >> was also to override the io-priority to RT and allow for a smoother
> >> transition, just keep it and treat it as an alias of the promote-to-rt
> >> policy.
> >>
> >> Signed-off-by: Hou Tao <houtao1@huawei.com>
> > Looks good to me. Feel free to add:
> >
> > Reviewed-by: Jan Kara <jack@suse.cz>
> Thanks for the review.
> >
> > Just one question regarding doc below:
> >
> >> ++----------------+---+
> >> +| no-change      | 0 |
> >> ++----------------+---+
> >> +| rt-to-be       | 2 |
> >> ++----------------+---+
> >> +| all-to-idle    | 3 |
> >> ++----------------+---+
> > Shouldn't there be preempt-to-rt somewhere in this table as well? Or why
> > this this in the doc at all? I'd consider the numbers to be kernel internal
> > thing?
> These numbers are used in the algorithm paragraph below to explain how the final
> ioprio is calculated. For prompt-to-rt policy, the algorithm is different and
> the number is unnecessary.

I see, thanks for explanation.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
