Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFC07A0B17
	for <lists+cgroups@lfdr.de>; Thu, 14 Sep 2023 18:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjINQ6l (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Sep 2023 12:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjINQ6l (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Sep 2023 12:58:41 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270858E;
        Thu, 14 Sep 2023 09:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OegaqNYe7r/8g+jxupTPdfeZq9KJj2OTDDvHBPIaVRM=; b=RaDan93BbmgqvP/klzEFdds2eX
        b7IkvPoHF6e1c3Qwa5SEuXQNKpqse3rk12yT18ICKdfI7a3VckJMEILdWLlbPuVYu2ikn++I4wXvt
        w+i7SX8a1a6dW7cMTedrWSnk40HFt49t9T/tHHEsDSZTulc9VAD6mfnRu95MdKXU6o+4gx8ccOYCl
        tzR3nVCHyShKKJCvDGpl2tGT/4EnlVLt+glK08TUPmS5nCJyZcU67evdh1flfJb6C4+28BCONKdlH
        o2QcR8W9m9qZ3e3/lEoYnSGID6WJVx2XavJ6wJ2qDN3BMDjs3iQqHL/hIjEVtRJN3bEfYNC532EZP
        98mkJSUw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qgpfJ-0064a2-0E;
        Thu, 14 Sep 2023 16:58:05 +0000
Date:   Thu, 14 Sep 2023 17:58:05 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <brauner@kernel.org>
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
Message-ID: <20230914165805.GJ800259@ZenIV>
References: <20230913111013.77623-1-hch@lst.de>
 <20230913111013.77623-4-hch@lst.de>
 <20230913232712.GC800259@ZenIV>
 <20230914023705.GH800259@ZenIV>
 <20230914053843.GI800259@ZenIV>
 <20230914-munkeln-pelzmantel-3e3a761acb72@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914-munkeln-pelzmantel-3e3a761acb72@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 14, 2023 at 04:02:25PM +0200, Christian Brauner wrote:

> Yes, you're right that making the superblock and not the filesytem type
> the bd_holder changes the logic and we are aware of that of course. And
> it requires changes such as moving additional block device closing from
> where some callers currently do it.

Details, please?

> But the filesytem type is not a very useful holder itself and has other
> drawbacks. The obvious one being that it requires us to wade through all
> superblocks on the system trying to find the superblock associated with
> a given block device continously grabbing and dropping sb_lock and
> s_umount. None of that is very pleasant nor elegant and it is for sure
> not very easy to understand (Plus, it's broken for btrfs freezing and
> syncing via block level ioctls.).

"Constantly" is a bit of a stretch - IIRC, we grabbed sb_lock once, then
went through the list comparing ->s_bdev (without any extra locking),
then bumped ->s_count on the found superblock, dropped sb_lock,
grabbed ->s_umount on the sucker and verified it's still alive.

Repeated grabbing of any lock happened only on a race with fs shutdown;
normal case is one spin_lock, one spin_unlock, one down_read().

Oh, well...

> Using the superblock as holder makes this go away and is overall a lot
> more useful and intuitive and can be extended to filesystems with
> multiple devices (Of which we apparently are bound to get more.).
>
> So I think this change is worth the pain.
> 
> It's a fair point that these lifetime rules should be documented in
> Documentation/filesystems/. The old lifetime documentation is too sparse
> to be useful though.

What *are* these lifetime rules?  Seriously, you have 3 chunks of
fs-dependent actions at the moment:
	* the things needed to get rid of internal references pinning
inodes/dentries + whatever else we need done before generic_shutdown_super()
	* the stuff to be done between generic_shutdown_super() and
making the sucker invisible to sget()/sget_fc()
	* the stuff that must be done after we are sure that sget
callbacks won't be looking at this instance.

Note that Christoph's series has mashed (2) and (3) together, resulting
in UAF in a bunch of places.  And I'm dead serious about
Documentation/filesystems/porting being the right place; any development
tree of any filesystem (in-tree one or not) will have to go through the
changes and figure out WTF to do with their existing code.  We are
going to play whack-a-mole for at least several years as development
branches get rebased and merged.

Incidentally, I'm going to add a (belated by 10 years) chunk in porting.rst
re making sure that anything in superblock that might be needed by methods
called in RCU mode should *not* be freed without an RCU delay...  Should've
done that back in 3.12 merge window when RCU'd vfsmounts went in; as it
is, today we have several filesystems with exact same kind of breakage.
hfsplus and affs breakage had been there in 3.13 (missed those two), exfat
and ntfs3 - introduced later, by initial merges of filesystems in question.
Missed on review...

Hell knows - perhaps Documentation/filesystems/whack-a-mole might be a good
idea...
