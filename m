Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151396751AE
	for <lists+cgroups@lfdr.de>; Fri, 20 Jan 2023 10:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjATJxq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Jan 2023 04:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjATJxq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Jan 2023 04:53:46 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7484C530CA;
        Fri, 20 Jan 2023 01:53:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 247B35F7CD;
        Fri, 20 Jan 2023 09:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674208423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uXVzDiTot3JJgTFSqL8EctuMD29LyEcgGrsRrohd/RQ=;
        b=pPgzM6tRrV7kD23VB/GFh7aKLKf68lj98tl16sn2pGye0ijVx8LNpAEG768LHxDZMLSWPb
        3NQUeNjhHRXHf5oFfT9L+UOX2c5G3asbEUblys1o8eY+NEUK+QFPt9QwDWTxR6beWWq/RO
        aUJ7mny9oTtyWL6CFm1CTbxfcKFs5Ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674208423;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uXVzDiTot3JJgTFSqL8EctuMD29LyEcgGrsRrohd/RQ=;
        b=ZT8AatXNfYXq3COtPQuqVf/JTX2sGvstaXW5qDVs7Lovt2wavfUuuwinq8ceIdEVA7eLRs
        jurN1N0VHPhoiVDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A071A1390C;
        Fri, 20 Jan 2023 09:53:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jakjJKZkymPOQAAAMHmgww
        (envelope-from <aherrmann@suse.de>); Fri, 20 Jan 2023 09:53:42 +0000
Date:   Fri, 20 Jan 2023 10:53:40 +0100
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 07/15] blk-wbt: pass a gendisk to wbt_init
Message-ID: <Y8pkpDn9hdy5giUk@suselix>
References: <20230117081257.3089859-1-hch@lst.de>
 <20230117081257.3089859-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230117081257.3089859-8-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 17, 2023 at 09:12:49AM +0100, Christoph Hellwig wrote:
> Pass a gendisk to wbt_init to prepare for phasing out usage of the
> request_queue in the blk-cgroup code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-sysfs.c | 2 +-
>  block/blk-wbt.c   | 5 +++--
>  block/blk-wbt.h   | 4 ++--
>  3 files changed, 6 insertions(+), 5 deletions(-)

Looks good to me. Feel free to add
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 2074103865f45b..c2adf640e5c816 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -500,7 +500,7 @@ static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
>  
>  	rqos = wbt_rq_qos(q);
>  	if (!rqos) {
> -		ret = wbt_init(q);
> +		ret = wbt_init(q->disk);
>  		if (ret)
>  			return ret;
>  	}
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index 8f9302134339c5..542271fa99e8f7 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -671,7 +671,7 @@ void wbt_enable_default(struct gendisk *disk)
>  		return;
>  
>  	if (queue_is_mq(q) && !disable_flag)
> -		wbt_init(q);
> +		wbt_init(disk);
>  }
>  EXPORT_SYMBOL_GPL(wbt_enable_default);
>  
> @@ -835,8 +835,9 @@ static struct rq_qos_ops wbt_rqos_ops = {
>  #endif
>  };
>  
> -int wbt_init(struct request_queue *q)
> +int wbt_init(struct gendisk *disk)
>  {
> +	struct request_queue *q = disk->queue;
>  	struct rq_wb *rwb;
>  	int i;
>  	int ret;
> diff --git a/block/blk-wbt.h b/block/blk-wbt.h
> index 7ab1cba55c25f7..b673da41a867d3 100644
> --- a/block/blk-wbt.h
> +++ b/block/blk-wbt.h
> @@ -90,7 +90,7 @@ static inline unsigned int wbt_inflight(struct rq_wb *rwb)
>  
>  #ifdef CONFIG_BLK_WBT
>  
> -int wbt_init(struct request_queue *);
> +int wbt_init(struct gendisk *disk);
>  void wbt_disable_default(struct gendisk *disk);
>  void wbt_enable_default(struct gendisk *disk);
>  
> @@ -104,7 +104,7 @@ u64 wbt_default_latency_nsec(struct request_queue *);
>  
>  #else
>  
> -static inline int wbt_init(struct request_queue *q)
> +static inline int wbt_init(struct gendisk *disk)
>  {
>  	return -EINVAL;
>  }
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
