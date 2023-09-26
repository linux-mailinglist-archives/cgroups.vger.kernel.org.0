Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343EB7AE943
	for <lists+cgroups@lfdr.de>; Tue, 26 Sep 2023 11:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjIZJbl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Sep 2023 05:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbjIZJbk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Sep 2023 05:31:40 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D50BE;
        Tue, 26 Sep 2023 02:31:34 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1A2D668AA6; Tue, 26 Sep 2023 11:31:30 +0200 (CEST)
Date:   Tue, 26 Sep 2023 11:31:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20230926093129.GA13806@lst.de>
References: <20230913111013.77623-1-hch@lst.de> <20230913111013.77623-4-hch@lst.de> <20230913232712.GC800259@ZenIV> <20230914023705.GH800259@ZenIV> <20230914053843.GI800259@ZenIV> <20230914-zielt-einzog-00389009b293@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914-zielt-einzog-00389009b293@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 14, 2023 at 09:56:57AM +0200, Christian Brauner wrote:
> > BTW, this part of commit message in 2c18a63b760a is rather confused:
> >     Recent rework moved block device closing out of sb->put_super() and into
> >     sb->kill_sb() to avoid deadlocks as s_umount is held in put_super() and
> >     blkdev_put() can end up taking s_umount again.
> > 
> > That was *NOT* what a recent rework had done.  Block device closing had never
> > been inside ->put_super() - at no point since that (closing, that is) had been
> > introduced back in 0.97 ;-)  ->put_super() predates it (0.95c+).
> 
> I think the commit message probably just isn't clear enough. The main
> block device of a superblock isn't closed in sb->put_super(). That's
> always been closed in kill_block_super() after generic_shutdown_super().

Yes.

> But afaict filesystem like ext4 and xfs may have additional block
> devices open exclusively and closed them in sb->put_super():
> 
> xfs_fs_put_super()
> -> xfs_close_devices()
>    -> xfs_blkdev_put()
>       -> blkdev_put()
> 
> ext4_put_super()
> -> ext4_blkdev_remove()
>    -> blkdev_put()

Yes.
