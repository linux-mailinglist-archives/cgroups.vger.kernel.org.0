Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590A77A208B
	for <lists+cgroups@lfdr.de>; Fri, 15 Sep 2023 16:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbjIOOMW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Sep 2023 10:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbjIOOMV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Sep 2023 10:12:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30661FCE;
        Fri, 15 Sep 2023 07:12:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717D9C433C9;
        Fri, 15 Sep 2023 14:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694787135;
        bh=/HmAzgm/+XfH2LHmsna9iSpae4XQo0btQtAdXOJ8lmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mjYxRMQNwaQHIKQyYqQlgdWqCfnn9IZcTlEUtfZyLYqAA8oxvZV68JJrPo0oh4EU4
         qE3X4RPLodL+YxmytKft3urNRQvw8EPPPH3HAwKX2yBZB3zGvHGs/+IduNDyKBBbow
         QuhJk/wvqrH3k9B90Zpu5zsZQIBgqVGR+mYFK84Gsf6pcSGVhGScXYV5+3z6xVEBf/
         oNL0GGCMG6glpSM0mBHJU/C/3ByYZIxqHkDjj7XWdyKEv5C1vsjrWl2Pv7YeHNVN0w
         3oirLCA0Aem0LuUgx4+aDtkfgK5H5gz6yC9ZH+Qq1gcUYC6xhhht/1NJ9PYsBDN6rV
         QxAi18p1Ej6Bg==
Date:   Fri, 15 Sep 2023 16:12:07 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
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
        cgroups@vger.kernel.org
Subject: Re: [PATCH 03/19] fs: release anon dev_t in deactivate_locked_super
Message-ID: <20230915-zweit-frech-0e06394208a3@brauner>
References: <20230913111013.77623-1-hch@lst.de>
 <20230913111013.77623-4-hch@lst.de>
 <20230913232712.GC800259@ZenIV>
 <20230914023705.GH800259@ZenIV>
 <20230914053843.GI800259@ZenIV>
 <20230914-munkeln-pelzmantel-3e3a761acb72@brauner>
 <20230914165805.GJ800259@ZenIV>
 <20230915-elstern-etatplanung-906c6780af19@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230915-elstern-etatplanung-906c6780af19@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> > tree of any filesystem (in-tree one or not) will have to go through the
> > changes and figure out WTF to do with their existing code.  We are
> > going to play whack-a-mole for at least several years as development
> > branches get rebased and merged.
> 
> Let me write something up.

So here I've written two porting.rst patches that aim to reflect the
current state of things (They do _not_ reflect what's in Christoph's
series here as that'ss again pretty separate and will require additional
spelling out.).

I'm adding explanation for both the old and new logic fwiw. I hope to
upstream these docs soon so we all have something to point to.

From 200666901f53db74edf309d48e3c74fd275a822a Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 15 Sep 2023 16:01:02 +0200
Subject: [PATCH 1/2] porting: document new block device opening order

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 Documentation/filesystems/porting.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index deac4e973ddc..f436b64b77bf 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -949,3 +949,27 @@ mmap_lock held.  All in-tree users have been audited and do not seem to
 depend on the mmap_lock being held, but out of tree users should verify
 for themselves.  If they do need it, they can return VM_FAULT_RETRY to
 be called with the mmap_lock held.
+
+---
+
+**mandatory**
+
+The order of opening block devices and matching or creating superblocks has
+changed.
+
+The old logic opened block devices first and then tried to find a
+suitable superblock to reuse based on the block device pointer.
+
+The new logic finds or creates a superblock first, opening block devices
+afterwards. Since opening block devices cannot happen under s_umount because of
+lock ordering requirements s_umount is now dropped while opening block
+devices and reacquired before calling fill_super().
+
+In the old logic concurrent mounters would find the superblock on the list of
+active superblock for the filesystem type. Since the first opener of the block
+device would hold s_umount they would wait until the superblock became either
+born or died prematurely due to initialization failure.
+
+Since the new logic drops s_umount concurrent mounters could grab s_umount and
+would spin. Instead they are now made to wait using an explicit wait-wake
+mechanism without having to hold s_umount.
-- 
2.34.1

From 1f09898322b4402219d8d3219d399c9e56a76bae Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 15 Sep 2023 16:01:40 +0200
Subject: [PATCH 2/2] porting: document superblock as block device holder

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 Documentation/filesystems/porting.rst | 79 +++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index f436b64b77bf..fefefaf289b4 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -973,3 +973,82 @@ born or died prematurely due to initialization failure.
 Since the new logic drops s_umount concurrent mounters could grab s_umount and
 would spin. Instead they are now made to wait using an explicit wait-wake
 mechanism without having to hold s_umount.
+
+---
+
+**mandatory**
+
+The holder of a block device is now the superblock.
+
+The holder of a block device used to be the file_system_type which wasn't
+particularly useful. It wasn't possible to go from block device to owning
+superblock without matching on the device pointer stored in the superblock.
+This mechanism would only work for a single device so the block layer couldn't
+find the owning superblock associated with additional devices.
+
+In the old mechanism reusing or creating a superblock for racing mount(2) and
+umount(2) relied on the file_system_type as the holder. This was severly
+underdocumented however:
+
+(1) If the concurrent mount(2) managed to grab an active reference before the
+    umount(2) dropped the last active reference in deactivate_locked_super()
+    the mounter would simply reuse the existing superblock.
+
+(2) If the mounter came after deactivate_locked_super() but before
+    the superblock had been removed from the list of superblocks of the
+    filesystem type the mounter would wait until the superblock was shutdown
+    and allocated a new superblock.
+
+(3) If the mounter came after deactivate_locked_super() and after
+    the superblock had been removed from the list of superblocks of the
+    filesystem type the mounter would allocate a new superblock.
+
+Because the holder of the block device was the filesystem type any concurrent
+mounter could open the block device without risking seeing EBUSY because the
+block device was still in use.
+
+Making the superblock the owner of the block device changes this as the holder
+is now a unique superblock and not shared among all superblocks of the
+filesystem type. So a concurrent mounter in (2) could suddenly see EBUSY when
+trying to open a block device whose holder was a different superblock.
+
+The new logic thus waits until the superblock and the devices are shutdown in
+->kill_sb(). Removal of the superblock from the list of superblocks of the
+filesystem type is now moved to a later point when the devices are closed:
+
+(1) Any concurrent mounter managing to grab an active reference on an existing
+    superblock is made to wait until the superblock is either ready or until
+    the superblock and all devices are shutdown in ->kill_sb().
+
+(2) If the mounter came after deactivate_locked_super() but before
+    the superblock had been removed from the list of superblocks of the
+    filesystem type the mounter is made to wait until the superblock and the
+    devices are shut down in ->kill_sb() and the superblock is removed from the
+    list of superblocks of the filesystem type.
+
+(3) This case is now collapsed into (2) as the superblock is left on the list
+    of superblocks of the filesystem type until all devices are shutdown in
+    ->kill_sb().
+
+As this is a VFS level change it has no practical consequences for filesystems
+other than that all of them must use one of the provided kill_litter_super(),
+kill_anon_super(), or kill_block_super() helpers.
+
+Filesystems that reuse superblocks based on non-static keys such as
+sb->s_fs_info must ensure that these keys remain valid across kill_*_super()
+calls. The expected pattern is::
+
+	static struct file_system_type some_fs_type = {
+		.name 		= "somefs",
+		.kill_sb 	= some_fs_kill_sb,
+	};
+
+	static void some_fs_kill_sb(struct super_block *sb)
+	{
+		struct some_fs_info *info = sb->s_fs_info;
+
+		kill_*_super(sb);
+		kfree(info);
+	}
+
+It's best practice to never deviate from this pattern.
-- 
2.34.1

