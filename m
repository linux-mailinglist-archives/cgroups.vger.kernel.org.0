Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F685695D9A
	for <lists+cgroups@lfdr.de>; Tue, 14 Feb 2023 09:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjBNIwo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Feb 2023 03:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjBNIwm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Feb 2023 03:52:42 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D26C23658;
        Tue, 14 Feb 2023 00:52:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2173B21963;
        Tue, 14 Feb 2023 08:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676364757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FCM5fUI30hk/CWQ2CgtHO8OXcYicjnlXfEi2o9EEJgU=;
        b=T/Cq0T41wLhDEtRbo9/P3oUnDXSjS/ZP5vtU5NKZsWcmEiJEv8lD8Fabi8f8A8HfN4UIxM
        HEc75jRkl476RycFowuGXkA9gUqSAAebQGliI5pOu11P9aL8MaCRzFt4TZHdphjFsp67jI
        a3EuFPBm746wYdJsL478LWzWk5euQJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676364757;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FCM5fUI30hk/CWQ2CgtHO8OXcYicjnlXfEi2o9EEJgU=;
        b=2dBOVRGS4GK4ZtQ5IRwjk/ufawSnkfTjTwXhUnGFsURa02ld52b2sLAvBZZijQ5FCLz+vx
        uwBLWlJq4F7lz3DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 14B6B138E3;
        Tue, 14 Feb 2023 08:52:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LB8EBdVL62O0NAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 14 Feb 2023 08:52:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9F851A06D8; Tue, 14 Feb 2023 09:52:36 +0100 (CET)
Date:   Tue, 14 Feb 2023 09:52:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Hou Tao <houtao@huaweicloud.com>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, houtao1@huawei.com
Subject: Re: [PATCH] blk-ioprio: Introduce promote-to-rt policy
Message-ID: <20230214085236.vamd2yuflnyljyid@quack3>
References: <b6b3c498-e90b-7d1f-6ad5-a31334e433ae@acm.org>
 <beb7782e-72a4-c350-3750-23a767c88753@huaweicloud.com>
 <aedc240d-7c9e-248a-52d2-c9775f3e8ca1@acm.org>
 <20230208134345.77bdep3kzp52haxu@quack3>
 <7fcd4c38-ccbe-6411-e424-a57595ad9c0b@acm.org>
 <20230209085603.dzqfcc3pp4hacqlz@quack3>
 <55a065e7-7d86-d58f-15ba-c631a427843e@acm.org>
 <20230210101244.zsmtmsoo4xjx7suj@quack3>
 <48620099-0311-e752-ba3b-cbb4351cf81e@huaweicloud.com>
 <0290f608-6ddf-ecb7-4c05-55b0f7dbfbea@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0290f608-6ddf-ecb7-4c05-55b0f7dbfbea@acm.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 13-02-23 09:10:26, Bart Van Assche wrote:
> On 2/13/23 04:51, Hou Tao wrote:
> > Should I keep "none-to-rt" and make it work just like "promote-to-rt" or should
> > I just remove "none-to-rt" and add "promote-to-rt" ? I think the latter will be
> > more appropriate.
> 
> Removing none-to-rt would break existing systems that use this policy. I
> prefer the former solution.

Agreed. I also think that keeping none-to-rt as an alias for promote-to-rt
allows for a smoother transition. However I'm all for documenting that
none-to-rt is deprecated and works as promote-to-rt.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
