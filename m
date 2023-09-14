Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B2E7A06C8
	for <lists+cgroups@lfdr.de>; Thu, 14 Sep 2023 16:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239348AbjINOCi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Sep 2023 10:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjINOCh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Sep 2023 10:02:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AA2DF;
        Thu, 14 Sep 2023 07:02:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC42C433C7;
        Thu, 14 Sep 2023 14:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694700153;
        bh=UbILtaDX6YaX9dgq96QTqXtymCmpeldgjR+T2oK3xaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PNO+aHUgNDxHMtKVOjlzcOL7tLf+z9y1Iq9XnBkmWBc2p/Apxp3ZmIFvKQ7+UYpIj
         vGqVGuRuqwz0WOI8F1gzCKpdQPNfFHmxOHmz3dSp8GqSj3cE46pwgm94yOyHfEGDiv
         t9y7eUZSydl/+7e2w+r2yGmTZg5C3zcJTsLzrZROns45s7RhKOT5/mOoOYhEY9tIY0
         aW5X29QrkwlJ6PisxRbW4j8ftjNKzQ2NS5JZkV/8+DbW86yP6ME2DQBOHUELgyT2nn
         rGGSMchIIOuzQfCiLakKwcTxGR0UeiFBwERYJSLsssW7J/ySM61igFF7UL6hlSMHj2
         OLKep8D3SXHCA==
Date:   Thu, 14 Sep 2023 16:02:25 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Tejun Heo <tj@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-hardening@vger.kernel.org,
        cgroups@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 03/19] fs: release anon dev_t in deactivate_locked_super
Message-ID: <20230914-munkeln-pelzmantel-3e3a761acb72@brauner>
References: <20230913111013.77623-1-hch@lst.de>
 <20230913111013.77623-4-hch@lst.de>
 <20230913232712.GC800259@ZenIV>
 <20230914023705.GH800259@ZenIV>
 <20230914053843.GI800259@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230914053843.GI800259@ZenIV>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> Christoph, could you explain what the hell do we need that for?  It does
> create the race in question and AFAICS 2c18a63b760a (and followups trying
> to plug holes in it) had been nothing but headache.
> 
> Old logics: if mount attempt with a different fs type happens, -EBUSY
> is precisely corrent - we would've gotten just that if mount() came
> before umount().  If the type matches, we might
> 	1) come before deactivate_locked_super() by umount(2).
> No problem, we succeed.
> 	2) come after the beginning of shutdown, but before the
> removal from the list; fine, we'll wait for the sucker to be
> unlocked (which happens in the end of generic_shutdown_super()),
> notice it's dead and create a new superblock.  Since the only
> part left on the umount side is closing the device, we are
> just fine.
> 	3) come after the removal from the list.  So we won't
> wait for the old superblock to be unlocked, other than that
> it's exactly the same as (2).  It doesn't matter whether we
> open the device before or after close by umount - same owner
> anyway, no -EBUSY.
> 
> Your "owner shall be the superblock" breaks that...
> 
> If you want to mess with _three_-way split of ->kill_sb(),
> please start with writing down the rules re what should
> go into each of those parts; such writeup should go into
> Documentation/filesystems/porting anyway, even if the
> split is a two-way one, BTW.

Hm, I think that characterization of Christoph's changes is a bit harsh.

Yes, you're right that making the superblock and not the filesytem type
the bd_holder changes the logic and we are aware of that of course. And
it requires changes such as moving additional block device closing from
where some callers currently do it.

But the filesytem type is not a very useful holder itself and has other
drawbacks. The obvious one being that it requires us to wade through all
superblocks on the system trying to find the superblock associated with
a given block device continously grabbing and dropping sb_lock and
s_umount. None of that is very pleasant nor elegant and it is for sure
not very easy to understand (Plus, it's broken for btrfs freezing and
syncing via block level ioctls.).

Using the superblock as holder makes this go away and is overall a lot
more useful and intuitive and can be extended to filesystems with
multiple devices (Of which we apparently are bound to get more.).

So I think this change is worth the pain.

It's a fair point that these lifetime rules should be documented in
Documentation/filesystems/. The old lifetime documentation is too sparse
to be useful though.
