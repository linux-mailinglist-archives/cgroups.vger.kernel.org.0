Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C68279F5E5
	for <lists+cgroups@lfdr.de>; Thu, 14 Sep 2023 02:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjINAdM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 20:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjINAdL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 20:33:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2391724;
        Wed, 13 Sep 2023 17:33:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADC5C433C7;
        Thu, 14 Sep 2023 00:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694651587;
        bh=78IdMo52kj5+6bJlcewfwBX0rNPqip7T68o37Qx9Yr4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fsjRpDYSulA9367EFdFAGLUTu0c9nlbpmTLnmUNUWF/Ujr/W3vhKnAVWmlRosElKt
         i4pEY8n18Q45chLu8k2MsnLto7mITLe3+uU4+oOGe0HUptveFjgJddRHFVT2qBJghq
         OW8Jj0CdSixK2KBDNQEO9ypNb/74gOs9KJjTtal3fzi9F0XVeh7th4ycIuM74sgwi/
         zWy5vQt73rtL1m+kY5KAtchyeuTeCH6tQl9STxRRsALiOOAGTLQxoEOjCnbVdYKWKs
         NdpKSg+jPtGvbF6+MTJVGOypSsPATnvfVPeTuwDr0uPOGJocHhU7pykTWe9IyJ0i6G
         WFTiSHoplUEVQ==
Message-ID: <36a333bf-4cc5-e3a6-90fd-34b362f96f83@kernel.org>
Date:   Thu, 14 Sep 2023 09:33:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 09/19] zonefs: remove duplicate cleanup in
 zonefs_fill_super
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>,
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
        Naohiro Aota <naohiro.aota@wdc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-hardening@vger.kernel.org,
        cgroups@vger.kernel.org
References: <20230913111013.77623-1-hch@lst.de>
 <20230913111013.77623-10-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230913111013.77623-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/13/23 20:10, Christoph Hellwig wrote:
> When ->fill_super fails, ->kill_sb is called which already cleans up
> the inodes and zgroups.
> 
> Drop the extra cleanup code in zonefs_fill_super.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Acked-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  fs/zonefs/super.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 9d1a9808fbbba6..35b2554ce2ac2e 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -1309,13 +1309,12 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
>  	/* Initialize the zone groups */
>  	ret = zonefs_init_zgroups(sb);
>  	if (ret)
> -		goto cleanup;
> +		return ret;
>  
>  	/* Create the root directory inode */
> -	ret = -ENOMEM;
>  	inode = new_inode(sb);
>  	if (!inode)
> -		goto cleanup;
> +		return -ENOMEM;
>  
>  	inode->i_ino = bdev_nr_zones(sb->s_bdev);
>  	inode->i_mode = S_IFDIR | 0555;
> @@ -1333,7 +1332,7 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
>  
>  	sb->s_root = d_make_root(inode);
>  	if (!sb->s_root)
> -		goto cleanup;
> +		return -ENOMEM;
>  
>  	/*
>  	 * Take a reference on the zone groups directory inodes
> @@ -1341,19 +1340,9 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
>  	 */
>  	ret = zonefs_get_zgroup_inodes(sb);
>  	if (ret)
> -		goto cleanup;
> -
> -	ret = zonefs_sysfs_register(sb);
> -	if (ret)
> -		goto cleanup;
> -
> -	return 0;
> -
> -cleanup:
> -	zonefs_release_zgroup_inodes(sb);
> -	zonefs_free_zgroups(sb);
> +		return ret;
>  
> -	return ret;
> +	return zonefs_sysfs_register(sb);
>  }
>  
>  static struct dentry *zonefs_mount(struct file_system_type *fs_type,

-- 
Damien Le Moal
Western Digital Research

