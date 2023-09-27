Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573FD7B0EE5
	for <lists+cgroups@lfdr.de>; Thu, 28 Sep 2023 00:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjI0W3d (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 18:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjI0W3d (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 18:29:33 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8632102;
        Wed, 27 Sep 2023 15:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y5BdNredrDHTYUunP3kApqKLWcDG2AzXoWP37/0LaLo=; b=ndvyW/v5AnnTWjFcOaHmQtJ2tQ
        BC/6lzWxYgmdgHXT3PvPZcC090LQrp5ml02Ae1GnoSZckoSqvjoU59jpnfAR30t9sQc4/Tr/mYnNI
        X6fsO3Ipq3PoKVycIJsEvT0+99hFr4CUSn/aQRGG2eC0g6Iw2svNRD/I3rMzmeTP9B1nb7c4dqeqA
        JN6364DWbEtruq3HNM0pL9YLgknS628sDSI3CSoX5x4axSRNWXVW2YPZpfLHfh77TVYhq6vn6Ypxd
        WcP/K9r5N10De0XaKEEw5J4cGIg6JXFmGw4wiy5LDY2ZiUC1DhwwA6Vw2c8s4Kjh2Vk+HNoezE5u+
        4u/hMT3A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qld1m-00CP4N-2B;
        Wed, 27 Sep 2023 22:29:07 +0000
Date:   Wed, 27 Sep 2023 23:29:06 +0100
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
Message-ID: <20230927222906.GO800259@ZenIV>
References: <20230913111013.77623-1-hch@lst.de>
 <20230913111013.77623-4-hch@lst.de>
 <20230913232712.GC800259@ZenIV>
 <20230926093834.GB13806@lst.de>
 <20230926212515.GN800259@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926212515.GN800259@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 26, 2023 at 10:25:15PM +0100, Al Viro wrote:

> Before your patch: foo_kill_super() calls kill_anon_super(),
> which calls kill_super_notify(), which removes the sucker from
> the list, then frees ->s_fs_info.  After your patch:
> removal from the lists happens via the call of kill_super_notify()
> *after* both of your methods had been called, while freeing
> ->s_fs_info happens from the method call.  IOW, you've restored
> the situation prior to "super: ensure valid info".  The whole
> point of that commit had been to make sure that we have nothing
> in the lists with ->s_fs_info pointing to a freed object.

More detailed example: take a look at NFS.  We have ->get_tree() there
call sget_fc() with nfs_compare_super() as possible 'test' callback.
It does look at ->s_fs_info of the superblocks found on the list
of instances for fs type in question.  Moreover, it proceeds to
call nfs_compare_mount_options(), which chases pointers from that
(at the very least fetch ->client in nfs_server instance ->s_fs_info
points to and dereferences that).

We really, really do not want nfs_free_server() happen while the
superblock is visible in the instances list.  Now, in your tree
nfs_free_sb() call nfs_free_server().  *Without* having called
kill_super_notify() first - you do that only after the call of
->free_sb().

So with this series applied we have UAF on race between mount and
umount.  For NFS.  No block devices involved.

Old logics had been "after generic_shutdown_super() the private
parts of superblock belong to filesystem alone; they might be
accessed by methods called from RCU pathwalk, but that's it".

I still don't see any clear rules for the new one.  And the more
I'm looking, the more sceptical I get about the approach you've
taken, TBH...
