Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D19279EE03
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 18:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjIMQLC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 12:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjIMQLC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 12:11:02 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id EC9E519BF
        for <cgroups@vger.kernel.org>; Wed, 13 Sep 2023 09:10:57 -0700 (PDT)
Received: (qmail 960084 invoked by uid 1000); 13 Sep 2023 12:10:56 -0400
Date:   Wed, 13 Sep 2023 12:10:56 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
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
Subject: Re: [PATCH 10/19] USB: gadget/legacy: remove sb_mutex
Message-ID: <7f839be1-4898-41ad-8eda-10d5a0350bdf@rowland.harvard.edu>
References: <20230913111013.77623-1-hch@lst.de>
 <20230913111013.77623-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913111013.77623-11-hch@lst.de>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 13, 2023 at 08:10:04AM -0300, Christoph Hellwig wrote:
> Creating new a new super_block vs freeing the old one for single instance
> file systems is serialized by the wait for SB_DEAD.
> 
> Remove the superfluous sb_mutex.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

You might mention that this is essentially a reversion of commit 
d18dcfe9860e ("USB: gadgetfs: Fix race between mounting and 
unmounting").

Alan Stern

>  drivers/usb/gadget/legacy/inode.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
> index ce9e31f3d26bcc..a203266bc0dc82 100644
> --- a/drivers/usb/gadget/legacy/inode.c
> +++ b/drivers/usb/gadget/legacy/inode.c
> @@ -229,7 +229,6 @@ static void put_ep (struct ep_data *data)
>   */
>  
>  static const char *CHIP;
> -static DEFINE_MUTEX(sb_mutex);		/* Serialize superblock operations */
>  
>  /*----------------------------------------------------------------------*/
>  
> @@ -2012,8 +2011,6 @@ gadgetfs_fill_super (struct super_block *sb, struct fs_context *fc)
>  	struct dev_data	*dev;
>  	int		rc;
>  
> -	mutex_lock(&sb_mutex);
> -
>  	if (the_device) {
>  		rc = -ESRCH;
>  		goto Done;
> @@ -2069,7 +2066,6 @@ gadgetfs_fill_super (struct super_block *sb, struct fs_context *fc)
>  	rc = -ENOMEM;
>  
>   Done:
> -	mutex_unlock(&sb_mutex);
>  	return rc;
>  }
>  
> @@ -2092,7 +2088,6 @@ static int gadgetfs_init_fs_context(struct fs_context *fc)
>  static void
>  gadgetfs_kill_sb (struct super_block *sb)
>  {
> -	mutex_lock(&sb_mutex);
>  	kill_litter_super (sb);
>  	if (the_device) {
>  		put_dev (the_device);
> @@ -2100,7 +2095,6 @@ gadgetfs_kill_sb (struct super_block *sb)
>  	}
>  	kfree(CHIP);
>  	CHIP = NULL;
> -	mutex_unlock(&sb_mutex);
>  }
>  
>  /*----------------------------------------------------------------------*/
> -- 
> 2.39.2
> 
