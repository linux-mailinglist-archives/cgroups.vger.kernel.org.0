Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BB468E8FD
	for <lists+cgroups@lfdr.de>; Wed,  8 Feb 2023 08:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjBHHd4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Feb 2023 02:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjBHHdz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Feb 2023 02:33:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646E837547
        for <cgroups@vger.kernel.org>; Tue,  7 Feb 2023 23:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675841591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=73aglTPUHS/85OtfenzciioO7I/A4+2ffz4/jBMkCu0=;
        b=ENujYjCVQlz9DhsBeBHsAWeqTvMQVrAgUH9d8rkyGKky/pnUNNuE9BJl0apWIx5hUB2DDv
        cAvicXYgSvbuxEI49AvfCTceCO96ydCsG9cy98n9O9N1F0vPlmDWjZQLonbTjEoBtqD641
        yS+0fOw42I0zjIP/dLG1QdHiol88FPE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-481-OxgCnEtoPTuqiZKfvXON_g-1; Wed, 08 Feb 2023 02:33:08 -0500
X-MC-Unique: OxgCnEtoPTuqiZKfvXON_g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC5DB85A5B1;
        Wed,  8 Feb 2023 07:33:07 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5697F18EC5;
        Wed,  8 Feb 2023 07:33:02 +0000 (UTC)
Date:   Wed, 8 Feb 2023 15:32:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: Re: [PATCH 02/19] blk-cgroup: delay blk-cgroup initialization until
 add_disk
Message-ID: <Y+NQKABK682e/30a@T590>
References: <20230201134123.2656505-1-hch@lst.de>
 <20230201134123.2656505-3-hch@lst.de>
 <Y+Ji4NL/WkTR8vml@T590>
 <20230208063552.GA15030@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208063552.GA15030@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 08, 2023 at 07:35:52AM +0100, Christoph Hellwig wrote:
> On Tue, Feb 07, 2023 at 10:40:32PM +0800, Ming Lei wrote:
> > because disk->root_blkg is freed & set as NULL in del_gendisk().
> > 
> > by the following script:
> > 
> > 	modprobe -r scsi_debug
> > 	modprobe scsi_debug dev_size_mb=1024
> > 	
> > 	mkfs.xfs -f /dev/sdc	#suppose sdc is the scsi debug disk
> > 	mount /dev/sdc /mnt
> > 	echo 1 > /sys/block/sdc/device/delete
> > 	sleep 1
> > 	umount /mnt
> 
> Thank,
> 
> I've sent a fix.  Can you wire up your reproducer in blktests?

Yeah, it is already sent out:

https://lore.kernel.org/linux-block/20230208010235.553252-1-ming.lei@redhat.com/T/#u



Thanks,
Ming

