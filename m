Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DDF7AF676
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 00:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjIZWwB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Sep 2023 18:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjIZWuA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Sep 2023 18:50:00 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76A2900F;
        Tue, 26 Sep 2023 14:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WccGIMN5Qv0lQD3hgxuM1vcIL4JfsNLSXHYfA6JcKbA=; b=OsDkrrtpZVXrV5cPooFVpQ+DsW
        efu7lcfWUFBZQaHC0VFHyjjlC9IDm/yz/ZSlLHkS56BIBF1rqS35BSa4iOCFAMWKpcXpAAhZiLrpb
        /5MwxV8qJttJgFtRzaN+w6Z85LOr7HVhGxkZL88Sv5A/SkYZv7JMKEyrCWFeL2Yf9rWDNOyHisFva
        qNGTFJp2isj0JVlKyHCS19X3cR12y4OMvncSwP7i60r/thlVuHEHxR25fZSDXn83II/AWC7INUFn6
        8+uAPErM2QG6BrRdCCZ6OQ8tCEmDrSMgrY6TSaupVewWlaEaPlhNXIhz6JXLVcFKp8/OKJhckJeHZ
        DAUjL3zQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qlFYR-00Bljq-2w;
        Tue, 26 Sep 2023 21:25:16 +0000
Date:   Tue, 26 Sep 2023 22:25:15 +0100
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
Message-ID: <20230926212515.GN800259@ZenIV>
References: <20230913111013.77623-1-hch@lst.de>
 <20230913111013.77623-4-hch@lst.de>
 <20230913232712.GC800259@ZenIV>
 <20230926093834.GB13806@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926093834.GB13806@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 26, 2023 at 11:38:34AM +0200, Christoph Hellwig wrote:

> How?
> 
> Old sequence before his patch:
> 
> 	deactivate_locked_super()
> 	  -> kill_anon_super()
> 	    -> generic_shutdown_super()
> 	    -> kill_super_notify()
> 	    -> free_anon_bdev()
> 	  -> kill_super_notify()
> 
> New sequence with this patch:
> 
> 	deactivate_locked_super()
> 	  -> generic_shutdown_super()
> 	    -> kill_super_notify()
> 	    -> free_anon_bdev()
> 

Before your patch: foo_kill_super() calls kill_anon_super(),
which calls kill_super_notify(), which removes the sucker from
the list, then frees ->s_fs_info.  After your patch:
removal from the lists happens via the call of kill_super_notify()
*after* both of your methods had been called, while freeing
->s_fs_info happens from the method call.  IOW, you've restored
the situation prior to "super: ensure valid info".  The whole
point of that commit had been to make sure that we have nothing
in the lists with ->s_fs_info pointing to a freed object.

It's not about free_anon_bdev(); that part is fine - it's the
"we can drop the weird second call site of kill_super_notify()"
thing that is broken.

Al, still slogging through the rcu pathwalk races in the methods...
The latest catch: nfs_set_verifier() can get called on a dentry
that had just been seen to have positive parent, but is not
pinned down.
	grab ->d_lock; OK, we know that dentry won't get freed under us
	fetch ->d_parent->d_inode
	pass that to nfs_verify_change_attribute()
... which assumes that inode it's been given is not NULL.  Normally it
would've been - ->d_lock stabilizes ->d_parent, and negative dentries
obviously have no children.  Except that we might've been just hit
by dentry_kill() due to eviction on memory pressure, got ->d_lock
right after that and proceeded to play with ->d_parent, just as
that parent is going through dentry_kill() from the same eviction on
memory pressure...  If it gets to dentry_unlink_inode() before we get to
fetching ->d_parent->d_inode, nfs_verify_change_attribute(NULL, whatever)
is going to oops...
