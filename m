Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF90E79E5D2
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 13:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239638AbjIMLKv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 07:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbjIMLKv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 07:10:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C4E1726;
        Wed, 13 Sep 2023 04:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=nwxvhePSI4O3hJwwz1qJAPg+IxcEp7hp7V2ZuemGbT4=; b=AxvCDTSZiE0Xs+Htfm3g3JBFdP
        BiXj2qFvqlimvBej4GlcseaIKcISfQQm3r1+fph44LmkcH3SSNrkSm3jcxRCTpnIdkvfI3cEhF6Z5
        OZY2BHrY4f4GZNrrgS0wb1V1aEXFrE2qXsjXvhKTNKOiF1VSJun5nLN2qTNLcHqUtsfrf9EnhO4YT
        wMrAuotcOn1ddny7PmlgocHsySDM7QMLWvQQ6esNDALBMlPELnr26IVsauM2prws467TV8n7OKbtx
        yjYkLTDNTHKdb19eIlw08sACGrLc0oFg/w/A4qCErgSvHhzfb2b6w7DIHtNV1apb5NBU4W4dlR3sg
        xlndN3KQ==;
Received: from [190.210.221.22] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgNlG-005huq-0U;
        Wed, 13 Sep 2023 11:10:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
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
Subject: split up ->kill_sb
Date:   Wed, 13 Sep 2023 08:09:54 -0300
Message-Id: <20230913111013.77623-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Al and Christian,

this series splits ->kill_sb into separate ->shutdown_sb and ->free_sb
methods and then calls generic_shutdown_super from common code to clean
up the file system shutdown interface.

As a first step towards that it moves allocating and freeing the
anonymous block device dev_t into common code. As every super_block must
have a valid s_dev it makes sense to just do that if the file system
didn't set one by itself, and we can also detect if one was assigned
easily when shutting down.

A git tree is available here:

    git://git.infradead.org/users/hch/misc.git fs-kill_sb

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/fs-kill_sb

Diffstat:
 Documentation/filesystems/locking.rst     |    9 -
 Documentation/filesystems/vfs.rst         |   15 ++
 arch/powerpc/platforms/cell/spufs/inode.c |   10 -
 arch/s390/hypfs/inode.c                   |   43 --------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |    7 -
 block/bdev.c                              |    1 
 drivers/android/binderfs.c                |   12 --
 drivers/base/devtmpfs.c                   |    8 -
 drivers/dax/super.c                       |    1 
 drivers/dma-buf/dma-buf.c                 |    1 
 drivers/gpu/drm/drm_drv.c                 |    1 
 drivers/infiniband/hw/qib/qib.h           |    4 
 drivers/infiniband/hw/qib/qib_fs.c        |  105 ++++---------------
 drivers/infiniband/hw/qib/qib_init.c      |   32 ++----
 drivers/misc/cxl/api.c                    |    1 
 drivers/misc/ibmasm/ibmasmfs.c            |    8 -
 drivers/mtd/mtdsuper.c                    |   12 --
 drivers/scsi/cxlflash/ocxl_hw.c           |    1 
 drivers/usb/gadget/function/f_fs.c        |    6 -
 drivers/usb/gadget/legacy/inode.c         |   18 +--
 drivers/xen/xenfs/super.c                 |    8 -
 fs/9p/vfs_super.c                         |   16 ---
 fs/adfs/super.c                           |    2 
 fs/affs/super.c                           |    7 -
 fs/afs/super.c                            |   27 ++---
 fs/aio.c                                  |    1 
 fs/anon_inodes.c                          |    1 
 fs/autofs/autofs_i.h                      |    3 
 fs/autofs/init.c                          |    3 
 fs/autofs/inode.c                         |   24 ++--
 fs/befs/linuxvfs.c                        |    2 
 fs/bfs/inode.c                            |    2 
 fs/binfmt_misc.c                          |    8 -
 fs/btrfs/super.c                          |   16 +--
 fs/btrfs/tests/btrfs-tests.c              |    1 
 fs/ceph/super.c                           |   20 +--
 fs/coda/inode.c                           |    1 
 fs/configfs/mount.c                       |    8 -
 fs/cramfs/inode.c                         |    6 -
 fs/debugfs/inode.c                        |    8 -
 fs/devpts/inode.c                         |    6 -
 fs/ecryptfs/main.c                        |   14 --
 fs/efivarfs/super.c                       |   13 +-
 fs/efs/super.c                            |    7 -
 fs/erofs/super.c                          |   25 +---
 fs/exfat/super.c                          |    6 -
 fs/ext2/super.c                           |    2 
 fs/ext4/super.c                           |   12 +-
 fs/f2fs/super.c                           |    6 -
 fs/fat/namei_msdos.c                      |    2 
 fs/fat/namei_vfat.c                       |    2 
 fs/freevxfs/vxfs_super.c                  |    2 
 fs/fuse/control.c                         |   12 +-
 fs/fuse/inode.c                           |   19 +--
 fs/fuse/virtio_fs.c                       |   21 ++-
 fs/gfs2/ops_fstype.c                      |   11 --
 fs/hfs/super.c                            |    2 
 fs/hfsplus/super.c                        |    2 
 fs/hostfs/hostfs_kern.c                   |    5 
 fs/hpfs/super.c                           |    2 
 fs/hugetlbfs/inode.c                      |    2 
 fs/isofs/inode.c                          |    2 
 fs/jffs2/super.c                          |   22 ++--
 fs/jfs/super.c                            |    2 
 fs/kernfs/mount.c                         |   20 +--
 fs/minix/inode.c                          |    2 
 fs/nfs/client.c                           |    2 
 fs/nfs/fs_context.c                       |   19 +++
 fs/nfs/internal.h                         |    1 
 fs/nfs/nfs4proc.c                         |    8 -
 fs/nfs/nfs4trace.h                        |    6 -
 fs/nfs/nfs4xdr.c                          |    2 
 fs/nfs/super.c                            |   26 ----
 fs/nfs/sysfs.h                            |    2 
 fs/nfsd/nfsctl.c                          |   22 ++--
 fs/nilfs2/super.c                         |    2 
 fs/nsfs.c                                 |    1 
 fs/ntfs/super.c                           |    2 
 fs/ntfs3/super.c                          |    6 -
 fs/ocfs2/dlmfs/dlmfs.c                    |    2 
 fs/ocfs2/super.c                          |    2 
 fs/omfs/inode.c                           |    2 
 fs/openpromfs/inode.c                     |    1 
 fs/orangefs/orangefs-kernel.h             |    2 
 fs/orangefs/orangefs-mod.c                |    2 
 fs/orangefs/super.c                       |   13 --
 fs/overlayfs/super.c                      |    1 
 fs/pipe.c                                 |    1 
 fs/proc/root.c                            |   16 +--
 fs/pstore/inode.c                         |    8 -
 fs/qnx4/inode.c                           |    7 -
 fs/qnx6/inode.c                           |    2 
 fs/ramfs/inode.c                          |    6 -
 fs/reiserfs/super.c                       |    7 -
 fs/romfs/super.c                          |    6 -
 fs/smb/client/cifsfs.c                    |   17 ++-
 fs/squashfs/super.c                       |    2 
 fs/super.c                                |  159 ++++++++++++++++--------------
 fs/sysfs/mount.c                          |    7 -
 fs/sysv/super.c                           |    4 
 fs/tracefs/inode.c                        |    2 
 fs/ubifs/super.c                          |   10 -
 fs/udf/super.c                            |    2 
 fs/ufs/super.c                            |    2 
 fs/vboxsf/super.c                         |    1 
 fs/xfs/xfs_buf.c                          |    2 
 fs/xfs/xfs_super.c                        |    6 -
 fs/zonefs/super.c                         |   34 ++----
 include/linux/fs.h                        |   11 --
 include/linux/kernfs.h                    |    5 
 include/linux/mtd/super.h                 |    2 
 include/linux/nfs_fs_sb.h                 |    1 
 include/linux/ramfs.h                     |    2 
 init/do_mounts.c                          |    6 -
 ipc/mqueue.c                              |    2 
 kernel/bpf/inode.c                        |    2 
 kernel/cgroup/cgroup.c                    |   10 +
 kernel/resource.c                         |    1 
 mm/secretmem.c                            |    1 
 mm/shmem.c                                |    5 
 net/socket.c                              |    1 
 net/sunrpc/rpc_pipe.c                     |   19 ++-
 security/apparmor/apparmorfs.c            |    1 
 security/inode.c                          |    8 -
 security/selinux/selinuxfs.c              |   15 --
 security/smack/smackfs.c                  |    6 -
 126 files changed, 524 insertions(+), 679 deletions(-)
