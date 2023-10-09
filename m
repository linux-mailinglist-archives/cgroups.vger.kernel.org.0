Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429887BEDA2
	for <lists+cgroups@lfdr.de>; Mon,  9 Oct 2023 23:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378790AbjJIV6V (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Oct 2023 17:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378789AbjJIV6U (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Oct 2023 17:58:20 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B5499;
        Mon,  9 Oct 2023 14:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Uo1EiyojZdAoskTvMvtwCcjNoSWtdzYtyhDVJ0XRCLA=; b=tQPA9yIqHmqNSbhOVvxiucllWR
        l2tso1BLwh5CGWav21hSNoCV18PYO+IsxWdqSb/pXzM2cPknMXd9P7ke0zHb6UliQGYi6gLyRpPKv
        U7hiFaveQ7mceuNDQ8jXcyNC9Wn3AkdirOyK8p0NOTO/Oj6yURkgBAyy5W9y7bWeLSH/O6DDIkmyl
        WCp+Xw1NcUBfI4VrenMtUjHlxEHqjrSYPedcuoxv/CrT5Nzph7SfGqANRPJyxErt/tMNNVW/JgwXK
        fM0gVUEdTnwkyob+53dTu2ypbGyfYDxKYT5I9ypDKvQN6UcsFeM5PE4elD0hso579aRXCVJbRT5mn
        T7zz5aAw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qpyGA-00HK0m-1f;
        Mon, 09 Oct 2023 21:57:54 +0000
Date:   Mon, 9 Oct 2023 22:57:54 +0100
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
Message-ID: <20231009215754.GL800259@ZenIV>
References: <20230913111013.77623-1-hch@lst.de>
 <20230913111013.77623-4-hch@lst.de>
 <20230913232712.GC800259@ZenIV>
 <20230926093834.GB13806@lst.de>
 <20230926212515.GN800259@ZenIV>
 <20231002064646.GA1799@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002064646.GA1799@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 02, 2023 at 08:46:46AM +0200, Christoph Hellwig wrote:
> On Tue, Sep 26, 2023 at 10:25:15PM +0100, Al Viro wrote:
> > Before your patch: foo_kill_super() calls kill_anon_super(),
> > which calls kill_super_notify(), which removes the sucker from
> > the list, then frees ->s_fs_info.  After your patch:
> > removal from the lists happens via the call of kill_super_notify()
> > *after* both of your methods had been called, while freeing
> > ->s_fs_info happens from the method call.  IOW, you've restored
> > the situation prior to "super: ensure valid info".  The whole
> > point of that commit had been to make sure that we have nothing
> > in the lists with ->s_fs_info pointing to a freed object.
> > 
> > It's not about free_anon_bdev(); that part is fine - it's the
> > "we can drop the weird second call site of kill_super_notify()"
> > thing that is broken.
> 
> The point has been to only release the anon dev_t after
> kill_super_notify, to prevent two of them beeing reused.
> 
> Which we do as the free_anon_bdev is done directly in
> deactivate_locked_super.  The new ->free_sb for non-block file systems
> frees resources, but none of them matter for sget.

We keep talking past each other...  Let me try again:
at the tip of your branch you have

static struct file_system_type ubifs_fs_type = {
        .name    = "ubifs",
	.owner   = THIS_MODULE,
	.mount   = ubifs_mount,
	.free_sb = ubifs_free_sb,
};

static void ubifs_free_sb(struct super_block *s)
{
        kfree(s->s_fs_info);
}

static struct dentry *ubifs_mount(struct file_system_type *fs_type, int flags,
                        const char *name, void *data)
{
	...
        sb = sget(fs_type, sb_test, sb_set, flags, c);
	...
}

static int sb_test(struct super_block *sb, void *data)
{
        struct ubifs_info *c1 = data;
        struct ubifs_info *c = sb->s_fs_info;

        return c->vi.cdev == c1->vi.cdev;
}

See the problem?  Mainline has

static void kill_ubifs_super(struct super_block *s)
{
        struct ubifs_info *c = s->s_fs_info;
        kill_anon_super(s);
        kfree(c);
}
and
void kill_anon_super(struct super_block *sb)
{
        dev_t dev = sb->s_dev;
        generic_shutdown_super(sb);
        kill_super_notify(sb);
        free_anon_bdev(dev);
}

That removes the superblock from the list of instances before its
->s_fs_info is freed.  In your branch removal happens here:

        if (fs->shutdown_sb)
                fs->shutdown_sb(s);
        generic_shutdown_super(s);
        if (fs->free_sb)
                fs->free_sb(s);

        kill_super_notify(s);

That comes *after* ubifs_free_sb() has freed ->s_fs_info.  And there's
nothing to stop ubifs_mount() (on a completely unrelated device) to get
called right at that moment.  Doing the sget() call quoted above.  Now,
in sget() we have
                hlist_for_each_entry(old, &type->fs_supers, s_instances) {
                        if (!test(old, data))
and that will hit sb_test(old, data), with old being a superblock still
in ->fs_supers, but with ->s_fs_info already freed.  So in sb_test()
we have c equal to old->s_fs_info and
        return c->vi.cdev == c1->vi.cdev;
is a bloody use after free.

Here we are unlikely to get fucked over - it's a plain fetch from freed
object.  If you look at e.g. nfs, you'll see a lot more than that -
pointer chasing from freed (and possibly reused) object.  The only
difference is that there you have sget_fc() instead of sget() - same
loop anyway.

The bottom line: in the form it is posted, your series reintroduces the
class of UAF that had been added by taking removal from the instances
list out of generic_shutdown_super() and then papered over by adding
that kill_super_notify() into kill_anon_super().

And frankly, I believe that the root cause is the insistence that
list removal should happen after generic_shutdown_super().  Sure, you
want the superblock to serve as bdev holder, which leads to fun
with -EBUSY if mount comes while umount still hadn't closed the
device.  I suspect that it would make a lot more sense to
introduce an intermediate state - "held, but will be released
in a short while".  You already have something similar, but
only for the entire disk ->bd_claiming stuff.

Add a new primitive (will_release_bdev()), so that attempts to
claim the sucker will wait until it gets released instead of
failing with -EBUSY.  And do *that* before generic_shutdown_super()
when unmounting something that is block-based.  Allows to bring
the list removal back where it used to be, no UAF at all...

IMO that direction is a lot more promising.
