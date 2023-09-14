Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D20D79F79D
	for <lists+cgroups@lfdr.de>; Thu, 14 Sep 2023 04:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbjINCJ0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 22:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbjINCJM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 22:09:12 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB792709;
        Wed, 13 Sep 2023 19:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zukjnbI0ncupAzDuzJlDSnQOCr1VCHsYHxFZu9nHeVo=; b=TMwdwl4gsfFqIQ2Hr49QNfqGNw
        H0N2CpxgS8iu2zTuvH1gYOE/Aelnyu6DKJr/WIH/H8WywHdkpZtIK/6qkmYkAyGBl6A9wXgV8T7Hx
        F4R28vv9+Mr1bcGPPgBjvg3RLPP2CAaYJXGfz3qdr49MpFrVSdt4ee2yS4kxJze4s4kg5Tx6hCkSs
        iYY8Hrj3pSUx121HWeGVaX6tW4g52qOyRMw3/rqJItAIWRJXkFLku/61pna1AC+a2u6HwxHv5llpA
        V02VS6bWXBIAn6AjiLfGFx4WsKED6hEtdOasjzUyHrM0rqnWh6KuSDARvsYQSe7TsNT/MVtxFgbix
        yshJCcGA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qgblQ-005tcd-36;
        Thu, 14 Sep 2023 02:07:29 +0000
Date:   Thu, 14 Sep 2023 03:07:28 +0100
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
Subject: Re: [PATCH 11/19] fs: add new shutdown_sb and free_sb methods
Message-ID: <20230914020728.GF800259@ZenIV>
References: <20230913111013.77623-1-hch@lst.de>
 <20230913111013.77623-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913111013.77623-12-hch@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 13, 2023 at 08:10:05AM -0300, Christoph Hellwig wrote:
> Currently super_blocks are shut down using the ->kill_sb method, which
> must call generic_shutdown_super, but allows the file system to
> add extra work before or after the call to generic_shutdown_super.
> 
> File systems tend to get rather confused by this, so add an alternative
> shutdown sequence where generic_shutdown_super is called by the core
> code, and there are extra ->shutdown_sb and ->free_sb hooks before and
> after it.  To remove the amount of boilerplate code ->shutdown_sb is only
> called if the super has finished initialization and ->d_root is set.

The last sentence doesn't match the patchset.  That aside, there
is an issue with method names.

->shutdown_sb() is... odd.  ->begin_shutdown_sb(), perhaps?  For the
majority of filesystems it's NULL, after all...

Worse, ->free_sb() is seriously misguiding - the name implies that
we are, well, freeing a superblock passed to it.  Which is not what is
happening here - superblock itself is freed only when all passive
references go away.  It's asking for trouble down the road.

We already have more than enough confusion in the area.  Note, BTW,
that there's a delicate issue around RCU accesses and freeing stuff -
->d_compare() can bloody well be called when superblock is getting
shut down.  For anything that might be needed by it (or by other
RCU'd methods) we must arrange for RCU-delayed destruction.
E.g. in case of fatfs we have sbi freeing done via call_rcu() (from
fat_put_super(), called by generic_shutdown_super()).

<checks the current tree>

Oh, bugger...  AFAICS, exfat has a problem - exfat_free_sbi() is called
directly from exfat_kill_sb(), without any concern for this:
static int exfat_utf8_d_cmp(const struct dentry *dentry, unsigned int len,
                const char *str, const struct qstr *name)
{
        struct super_block *sb = dentry->d_sb;
        unsigned int alen = exfat_striptail_len(name->len, name->name,
                                EXFAT_SB(sb)->options.keep_last_dots);

That kfree() needs to be RCU-delayed...  While we are at it, there's
this:
static int exfat_d_hash(const struct dentry *dentry, struct qstr *qstr)
{
        struct super_block *sb = dentry->d_sb;
        struct nls_table *t = EXFAT_SB(sb)->nls_io;
and we need this
        unload_nls(sbi->nls_io);
in exfat_put_super() RCU-delayed as well.  And I suspect that
        exfat_free_upcase_table(sbi);
right after it needs the same treatment.

AFFS: similar problem, wants ->s_fs_info freeing RCU-delayed.

hfsplus: similar, including non-delayed unlock_nls() calls.

ntfs3:
        /*
         * Try slow way with current upcase table
         */
        sbi = dentry->d_sb->s_fs_info;
        uni1 = __getname();
        if (!uni1)
                return -ENOMEM;
__getname().  "Give me a page and you might block, while you are
at it".  Done from ->d_compare().  Called under dentry->d_lock
and rcu_read_lock().  OK, any further investigation of that
one is... probably not worth bothering with at that point.

Other in-tree instances appear to be correct.  I'll push fixes for
those (well, ntfs3 aside) out tomorrow.
