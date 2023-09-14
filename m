Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5596779F80A
	for <lists+cgroups@lfdr.de>; Thu, 14 Sep 2023 04:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbjINCa2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 22:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjINCa1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 22:30:27 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F02A196;
        Wed, 13 Sep 2023 19:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QJxYibQmjq+Pbg/cA03aH9CORAW2km8XuLC8t21WRo0=; b=OhhyqIHCwHStb3YKeZZHm1zzhR
        U7O739LtvvKuHLAPD7ckbdBOFedy6E2v7i0Tfx1DmJVsyfhRU/Vf9CdQ98YAdW3hZj1GxnkaSUSC+
        f1GSWOIBvcn4DK3Ykh6+6pr5SEpqGerIj8wRKOY/SA9QQVjCllxI1qUJgW45jMDU6uUBo+xCxf0Y4
        k5s+4wc/rQVH8gvkzFdaFjW08BguRZWF58BlkNDZ78YNFfr4eRqta88fWJjbQjSxNMTHF0eZxfoc0
        alUzUlwddMgPH2Kc6JNmW0oLYbwh7FNCzEfhcmU0j2uid7Appi7wlg5hDG2mY+jkRK2sVhnOnNWGZ
        dH9DMfLg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qgc7A-005tq0-0T;
        Thu, 14 Sep 2023 02:29:56 +0000
Date:   Thu, 14 Sep 2023 03:29:56 +0100
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
Subject: Re: [PATCH 13/19] fs: convert kill_block_super to block_free_sb
Message-ID: <20230914022956.GG800259@ZenIV>
References: <20230913111013.77623-1-hch@lst.de>
 <20230913111013.77623-14-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913111013.77623-14-hch@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 13, 2023 at 08:10:07AM -0300, Christoph Hellwig wrote:

> -static void affs_kill_sb(struct super_block *sb)
> +static void affs_free_sb(struct super_block *sb)
>  {
>  	struct affs_sb_info *sbi = AFFS_SB(sb);
> -	kill_block_super(sb);
> +
> +	block_free_sb(sb);
>  	if (sbi) {
>  		affs_free_bitmap(sb);
>  		affs_brelse(sbi->s_root_bh);

<checks>

Yep, that's printk + brelse()...  Could we have that
block_free_sb() (an awful name aside) done after the
if (sbi) { ... } there?
