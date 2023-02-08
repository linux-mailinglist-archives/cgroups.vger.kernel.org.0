Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6D468E862
	for <lists+cgroups@lfdr.de>; Wed,  8 Feb 2023 07:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjBHGf5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Feb 2023 01:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjBHGf4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Feb 2023 01:35:56 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CDC442C0;
        Tue,  7 Feb 2023 22:35:56 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6DFDB68BFE; Wed,  8 Feb 2023 07:35:52 +0100 (CET)
Date:   Wed, 8 Feb 2023 07:35:52 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: Re: [PATCH 02/19] blk-cgroup: delay blk-cgroup initialization
 until add_disk
Message-ID: <20230208063552.GA15030@lst.de>
References: <20230201134123.2656505-1-hch@lst.de> <20230201134123.2656505-3-hch@lst.de> <Y+Ji4NL/WkTR8vml@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+Ji4NL/WkTR8vml@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 07, 2023 at 10:40:32PM +0800, Ming Lei wrote:
> because disk->root_blkg is freed & set as NULL in del_gendisk().
> 
> by the following script:
> 
> 	modprobe -r scsi_debug
> 	modprobe scsi_debug dev_size_mb=1024
> 	
> 	mkfs.xfs -f /dev/sdc	#suppose sdc is the scsi debug disk
> 	mount /dev/sdc /mnt
> 	echo 1 > /sys/block/sdc/device/delete
> 	sleep 1
> 	umount /mnt

Thank,

I've sent a fix.  Can you wire up your reproducer in blktests?
