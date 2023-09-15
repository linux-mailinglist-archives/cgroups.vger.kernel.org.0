Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15837A1B2D
	for <lists+cgroups@lfdr.de>; Fri, 15 Sep 2023 11:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbjIOJtU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Sep 2023 05:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbjIOJtQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Sep 2023 05:49:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DC32721;
        Fri, 15 Sep 2023 02:45:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69430C433BC;
        Fri, 15 Sep 2023 09:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694771103;
        bh=S1BwYDOPxFQM2OWQ2AqApQaGICqwuhOVxXD8qmxE9S4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mURAPfRa9T3jtCGyciJ8MEx6GxAXXErYK/nk44LIiNuhQs4hAslmdKcbJGnwNr9yr
         khjb/5RMcscuYstsLOI6NvWil24K0+ArclzY0efQjxn9PUH99SSUAaSmkq9xXRww33
         D/cJpPY6TQqbwxENu6oH38/2UMU7Iwfy2g28OUoDDGr/wtOISoK8VDOzHT3yuzXToy
         FJN0vch/sUeVsu8AlKNt4MAYtCuBryfyrHC1PPfKKoq3NDzwvQ6be1KBhyl8BCnp5T
         nXMCa9awTrv7+HcgRXW454HBbFjCW3+Jd6AjiAAKeJDz/1GJ9aQ9+yAN7I9Dxewp8z
         TkuylnV+nQKEg==
Date:   Fri, 15 Sep 2023 11:44:55 +0200
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
Message-ID: <20230915-elstern-etatplanung-906c6780af19@brauner>
References: <20230913111013.77623-1-hch@lst.de>
 <20230913111013.77623-4-hch@lst.de>
 <20230913232712.GC800259@ZenIV>
 <20230914023705.GH800259@ZenIV>
 <20230914053843.GI800259@ZenIV>
 <20230914-munkeln-pelzmantel-3e3a761acb72@brauner>
 <20230914165805.GJ800259@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230914165805.GJ800259@ZenIV>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 14, 2023 at 05:58:05PM +0100, Al Viro wrote:
> On Thu, Sep 14, 2023 at 04:02:25PM +0200, Christian Brauner wrote:
> 
> > Yes, you're right that making the superblock and not the filesytem type
> > the bd_holder changes the logic and we are aware of that of course. And
> > it requires changes such as moving additional block device closing from
> > where some callers currently do it.
> 
> Details, please?

Filesystems like xfs and ext4 that closed additional block devices (For
example, the logdev= mount option for xfs.) in put_super() could go
through stuff like:

blkdev_put()
-> bdev->bd_disk->fops->release() == lo_release()
   -> __loop_clr_fd()
      -> disk_force_media_change()
         -> __invalidate_device()
            -> get_super()

which wouldn't have been a problem before because get_super() matched on
sb->s_bdev which obviously doesn't work because a log device or rt
device or whatever isn't the main block device. So we couldn't have
deadlocked.

But the fact that it is called in that manner from that place in the
first place is wildly adventurous especially considering that there
isn't __a single comment__ in that code why that is safe. So good luck
figuring this all out.

Now that we don't have to do that s_bdev matching thing anymore because
we directly associate the superblock with the block device we can go
straight from block device to superblock. But now calling blkdev_put()
under put_super() which holds s_umount could deadlock. So it's moved to
kill_sb where it should've always been called. Even without the
potential deadlock in the new scheme that's cleaner and easier to
understand imho and it just works for any block device.

> Note that Christoph's series has mashed (2) and (3) together, resulting
> in UAF in a bunch of places.  And I'm dead serious about

Yes, that I did fix as far as I'm aware. If the rules would've been
written down where when something was freed we would've had an easier
time figuring this out though. But they weren't so we missed it.

> Documentation/filesystems/porting being the right place; any development

Yes, agreed. I'll write a document for Christoph's next version.

I know that what you're saying is roughly that we shouldn't make the
same mistake as were done before but the fact that the old lifetime
rules weren't documented in any meaningful way and now we get grumbled
at in turn makes me grumble a bit. :) But overall point duly taken.

> tree of any filesystem (in-tree one or not) will have to go through the
> changes and figure out WTF to do with their existing code.  We are
> going to play whack-a-mole for at least several years as development
> branches get rebased and merged.

Let me write something up.

> 
> Incidentally, I'm going to add a (belated by 10 years) chunk in porting.rst
> re making sure that anything in superblock that might be needed by methods
> called in RCU mode should *not* be freed without an RCU delay...  Should've
> done that back in 3.12 merge window when RCU'd vfsmounts went in; as it
> is, today we have several filesystems with exact same kind of breakage.
> hfsplus and affs breakage had been there in 3.13 (missed those two), exfat
> and ntfs3 - introduced later, by initial merges of filesystems in question.
> Missed on review...

Cool, thanks for adding that.
