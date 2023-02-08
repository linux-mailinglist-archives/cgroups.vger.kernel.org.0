Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D358568F012
	for <lists+cgroups@lfdr.de>; Wed,  8 Feb 2023 14:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjBHNoe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Feb 2023 08:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBHNoB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Feb 2023 08:44:01 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9CB3E0BC;
        Wed,  8 Feb 2023 05:43:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 670021F8B4;
        Wed,  8 Feb 2023 13:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675863826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WXjM/s4PhtaTVW4aiVsTAUAHDUvK2wieBkKbPD6AkWk=;
        b=2D010aeo1gILwXKexBL/H6YeET0ts/vT4M7BCnWuKvynMFw5ep7OJ0Xa25MaH/hW5tWE1+
        xa+9zp/k13p2fvffFznXRS+HNe8kUteOBo0xNsodoVXkiaeo4cU3FYezFAf/GWmkQtOF8Z
        UIhQ36DDm0ysHsF12At4bZ6c/bpL/hI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675863826;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WXjM/s4PhtaTVW4aiVsTAUAHDUvK2wieBkKbPD6AkWk=;
        b=HYuwSpnsyaTUN5uRxgrezcT+Rs0EYLoKxKybHs0UMdQxjwcVFJPGjarxi1zBkQ9ciulsX7
        2Ek8luOYzvi3URBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 56F441358A;
        Wed,  8 Feb 2023 13:43:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Jq0bFRKn42OaDgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 08 Feb 2023 13:43:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A287EA06D5; Wed,  8 Feb 2023 14:43:45 +0100 (CET)
Date:   Wed, 8 Feb 2023 14:43:45 +0100
From:   Jan Kara <jack@suse.cz>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Hou Tao <houtao@huaweicloud.com>, linux-block@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, houtao1@huawei.com
Subject: Re: [PATCH] blk-ioprio: Introduce promote-to-rt policy
Message-ID: <20230208134345.77bdep3kzp52haxu@quack3>
References: <20230201045227.2203123-1-houtao@huaweicloud.com>
 <8c068af3-7199-11cf-5c69-a523c7c22d9a@acm.org>
 <4f7dcb3e-2d5a-cae3-0e1c-a82bcc3d2217@huaweicloud.com>
 <b6b3c498-e90b-7d1f-6ad5-a31334e433ae@acm.org>
 <beb7782e-72a4-c350-3750-23a767c88753@huaweicloud.com>
 <aedc240d-7c9e-248a-52d2-c9775f3e8ca1@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aedc240d-7c9e-248a-52d2-c9775f3e8ca1@acm.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 03-02-23 11:45:32, Bart Van Assche wrote:
> On 2/2/23 17:48, Hou Tao wrote:
> > I don't get it on how to remove IOPRIO_POL_PROMOTION when calculating the final
> > ioprio for bio. IOPRIO_POL_PROMOTION is not used for IOPRIO_CLASS values but
> > used to determinate on how to calculate the final ioprio for bio: choosing the
> > maximum or minimum between blkcg ioprio and original bio bi_ioprio.
> 
> Do the block layer code changes shown below implement the functionality
> that you need?

Just one question guys: So with my a78418e6a04c ("block: Always initialize
bio IO priority on submit") none-to-rt policy became effectively a noop as
Hou properly noticed. Are we aware of any users that were broken by this?
Shouldn't we rather fix the code so that none-to-rt starts to operate
correctly again? Or maybe change the none-to-rt meaning to be actually
promote-to-rt?

I have to admit I'm wondering a bit what was the intended usecase behind
the introduction of none-to-rt policy. Can someone elaborate? promote-to-rt 
makes some sense to me - we have a priviledged cgroup we want to provide
low latency access to IO but none-to-rt just does not make much sense to
me...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
