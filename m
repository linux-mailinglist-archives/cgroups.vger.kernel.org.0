Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7F379FAE6
	for <lists+cgroups@lfdr.de>; Thu, 14 Sep 2023 07:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbjINFj2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Sep 2023 01:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjINFj2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Sep 2023 01:39:28 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218CF8E;
        Wed, 13 Sep 2023 22:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RmUYqF8wwggq/9y9Fc7orMwmqO8RbpvM81PaCv8SZQM=; b=C6Dr0C1U8pj+4fMEBibEuICDhE
        EEkjg/MijmAsizo0zcioXNtd4W36c9mdnd0D2zVFTw1TtapnOBvqUb0vSnDBFJrCmDfpvOcOHONne
        cbQFyqeH9CCEfvuTIGraM2Hn1ukGaDmyEoVKqTlKg3th4e10i2SpPoAiTy38YK2trc+CoNIrPrQV4
        K0oeDAvm57/3q8xZeBv5OlwDsHVPFMz59m8XSYjqo9e4HqV33cx972kX4mV9uO3c30QWCKQcVDJG8
        jsGCjoM8olig+SQBNMkZp5uKci8dDFRUTLEne7SsmOttj+ApgnNyMCXaO1Qg8iqGCwTMtlWa9kvki
        ClVVewHA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qgf3r-005vkH-2N;
        Thu, 14 Sep 2023 05:38:44 +0000
Date:   Thu, 14 Sep 2023 06:38:43 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
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
        cgroups@vger.kernel.org
Subject: Re: [PATCH 03/19] fs: release anon dev_t in deactivate_locked_super
Message-ID: <20230914053843.GI800259@ZenIV>
References: <20230913111013.77623-1-hch@lst.de>
 <20230913111013.77623-4-hch@lst.de>
 <20230913232712.GC800259@ZenIV>
 <20230914023705.GH800259@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914023705.GH800259@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 14, 2023 at 03:37:05AM +0100, Al Viro wrote:
> On Thu, Sep 14, 2023 at 12:27:12AM +0100, Al Viro wrote:
> > On Wed, Sep 13, 2023 at 08:09:57AM -0300, Christoph Hellwig wrote:
> > > Releasing an anon dev_t is a very common thing when freeing a
> > > super_block, as that's done for basically any not block based file
> > > system (modulo the odd mtd special case).  So instead of requiring
> > > a special ->kill_sb helper and a lot of boilerplate in more complicated
> > > file systems, just release the anon dev_t in deactivate_locked_super if
> > > the super_block was using one.
> > > 
> > > As the freeing is done after the main call to kill_super_notify, this
> > > removes the need for having two slightly different call sites for it.
> > 
> > Huh?  At this stage in your series freeing is still in ->kill_sb()
> > instances, after the calls of kill_anon_super() you've turned into
> > the calls of generic_shutdown_super().
> > 
> > You do split it off into a separate method later in the series, but
> > at this point you are reopening the same UAF that had been dealt with
> > in dc3216b14160 "super: ensure valid info".
> > 
> > Either move the introduction of ->free_sb() before that one, or
> > split it into lifting put_anon_bdev() (left here) and getting rid
> > of kill_anon_super() (after ->free_sb() introduction).
> 
> Actually, looking at the final stage in the series, you still have
> kill_super_notify() done *AFTER* ->free_sb() call.  So the problem
> persists until the very end...

It's worse - look at the rationale for 2c18a63b760a "super: wait until
we passed kill super".  Basically, "don't remove from the lists
until after block device closing".  IOW, we have

* stuff that needs to be done before generic_shutdown_super() (things
like pinned dentries on ramfs, etc.)
* generic_shutdown_super() itself (dentry/inode eviction, optionally
->put_super())
* stuff that needs to be done before eviction from the lists (block
device closing, since 2c18a63b760a)
* eviction from the lists
* stuff that needs to be done *after* eviction from the lists.

BTW, this part of commit message in 2c18a63b760a is rather confused:
    Recent rework moved block device closing out of sb->put_super() and into
    sb->kill_sb() to avoid deadlocks as s_umount is held in put_super() and
    blkdev_put() can end up taking s_umount again.

That was *NOT* what a recent rework had done.  Block device closing had never
been inside ->put_super() - at no point since that (closing, that is) had been
introduced back in 0.97 ;-)  ->put_super() predates it (0.95c+).

The race is real, but the cause is not some kind of move of blkdev_put().
Your 2ea6f68932f7 "fs: use the super_block as holder when mounting file
systems" is where it actually came from.

Christoph, could you explain what the hell do we need that for?  It does
create the race in question and AFAICS 2c18a63b760a (and followups trying
to plug holes in it) had been nothing but headache.

Old logics: if mount attempt with a different fs type happens, -EBUSY
is precisely corrent - we would've gotten just that if mount() came
before umount().  If the type matches, we might
	1) come before deactivate_locked_super() by umount(2).
No problem, we succeed.
	2) come after the beginning of shutdown, but before the
removal from the list; fine, we'll wait for the sucker to be
unlocked (which happens in the end of generic_shutdown_super()),
notice it's dead and create a new superblock.  Since the only
part left on the umount side is closing the device, we are
just fine.
	3) come after the removal from the list.  So we won't
wait for the old superblock to be unlocked, other than that
it's exactly the same as (2).  It doesn't matter whether we
open the device before or after close by umount - same owner
anyway, no -EBUSY.

Your "owner shall be the superblock" breaks that...

If you want to mess with _three_-way split of ->kill_sb(),
please start with writing down the rules re what should
go into each of those parts; such writeup should go into
Documentation/filesystems/porting anyway, even if the
split is a two-way one, BTW.
