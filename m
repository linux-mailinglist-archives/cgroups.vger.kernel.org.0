Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F02674FF8
	for <lists+cgroups@lfdr.de>; Fri, 20 Jan 2023 09:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjATI4p (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Jan 2023 03:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjATI4o (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Jan 2023 03:56:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7251D8B303;
        Fri, 20 Jan 2023 00:56:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 320AC228C7;
        Fri, 20 Jan 2023 08:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674204989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R+VY303Ws8dGkaDGBPNhrzJj03hZ+b198pLbrWjdjSU=;
        b=guW/Oqq+LgKF6FqmMI1h4vuCoK2WasH4opDmZbo6K9RnFJyPXUKTsaaCS6WLA9FciywVYf
        5v3edZp5Cq0A5Ake8BBI63HUOk6eMpJT1/GqI3Gmd/98nK/Hbn17MyatBRDZkZqsWAf6yX
        HZ3DRiqhUs430d4AkMySEAxd2zDiN8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674204989;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R+VY303Ws8dGkaDGBPNhrzJj03hZ+b198pLbrWjdjSU=;
        b=ur2AaTg1RaUBvo9rkdgDeoVLfowbVV5OIItnoclJ+iJ/mBF56oQYEv/KsTVMD8W2rXFFCJ
        Jk0QrfF1hB9BmACA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B432A13251;
        Fri, 20 Jan 2023 08:56:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id imy4KDxXymM2IAAAMHmgww
        (envelope-from <aherrmann@suse.de>); Fri, 20 Jan 2023 08:56:28 +0000
Date:   Fri, 20 Jan 2023 09:56:27 +0100
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 03/15] blk-cgroup: delay blk-cgroup initialization until
 add_disk
Message-ID: <Y8pXO32m7XVO+DH5@suselix>
References: <20230117081257.3089859-1-hch@lst.de>
 <20230117081257.3089859-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230117081257.3089859-4-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 17, 2023 at 09:12:45AM +0100, Christoph Hellwig wrote:
> There is no need to initialize the group code before the disk is marked
> live.  Moving the cgroup initialization earlier will help to have a
> fully initialized struct device in the gendisk for the cgroup code to
> use in the future.  Similarly tear the cgroup information down in
> del_gendisk to be symmetric and because none of the cgroup tracking is
> needed once non-passthrough I/O stops.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/genhd.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)

Looks good to me. Feel free to add
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

> diff --git a/block/genhd.c b/block/genhd.c
> index 23cf83b3331cde..705dec0800d62e 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -466,10 +466,14 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
>  	 */
>  	pm_runtime_set_memalloc_noio(ddev, true);
>  
> -	ret = blk_integrity_add(disk);
> +	ret = blkcg_init_disk(disk);
>  	if (ret)
>  		goto out_del_block_link;
>  
> +	ret = blk_integrity_add(disk);
> +	if (ret)
> +		goto out_blkcg_exit;
> +
>  	disk->part0->bd_holder_dir =
>  		kobject_create_and_add("holders", &ddev->kobj);
>  	if (!disk->part0->bd_holder_dir) {
> @@ -534,6 +538,8 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
>  	kobject_put(disk->part0->bd_holder_dir);
>  out_del_integrity:
>  	blk_integrity_del(disk);
> +out_blkcg_exit:
> +	blkcg_exit_disk(disk);
>  out_del_block_link:
>  	if (!sysfs_deprecated)
>  		sysfs_remove_link(block_depr, dev_name(ddev));
> @@ -662,6 +668,8 @@ void del_gendisk(struct gendisk *disk)
>  	rq_qos_exit(q);
>  	blk_mq_unquiesce_queue(q);
>  
> +	blkcg_exit_disk(disk);
> +
>  	/*
>  	 * If the disk does not own the queue, allow using passthrough requests
>  	 * again.  Else leave the queue frozen to fail all I/O.
> @@ -1171,8 +1179,6 @@ static void disk_release(struct device *dev)
>  	    !test_bit(GD_ADDED, &disk->state))
>  		blk_mq_exit_queue(disk->queue);
>  
> -	blkcg_exit_disk(disk);
> -
>  	bioset_exit(&disk->bio_split);
>  
>  	disk_release_events(disk);
> @@ -1385,9 +1391,6 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
>  	if (xa_insert(&disk->part_tbl, 0, disk->part0, GFP_KERNEL))
>  		goto out_destroy_part_tbl;
>  
> -	if (blkcg_init_disk(disk))
> -		goto out_erase_part0;
> -
>  	rand_initialize_disk(disk);
>  	disk_to_dev(disk)->class = &block_class;
>  	disk_to_dev(disk)->type = &disk_type;
> @@ -1400,8 +1403,6 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
>  #endif
>  	return disk;
>  
> -out_erase_part0:
> -	xa_erase(&disk->part_tbl, 0);
>  out_destroy_part_tbl:
>  	xa_destroy(&disk->part_tbl);
>  	disk->part0->bd_disk = NULL;
> -- 
> 2.39.0
> 

-- 
Regards,
Andreas

SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nürnberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
