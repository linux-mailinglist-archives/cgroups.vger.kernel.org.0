Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8054867DE38
	for <lists+cgroups@lfdr.de>; Fri, 27 Jan 2023 08:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjA0HH3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Jan 2023 02:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjA0HH2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Jan 2023 02:07:28 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF39E558C;
        Thu, 26 Jan 2023 23:07:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8BEF31FEB2;
        Fri, 27 Jan 2023 07:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674803246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6RGdD0dbpYfwJsZsZUvRLD7D/Kc7PVnGQWv53OgY25s=;
        b=EcYo8HUR67SO+Xc2VS5Ep1l/PIjKiG+x/JDyLbYgoIKYlkyuBb6St8tZGXvpc8vSR2Pick
        U/54zdrUfyEuzYrol8mSp5axGX49bfcL9FzHkVKpkZPJlhEGMBEAaI1EM8MR5Bp+H9tiJd
        CzUarE1q/jKOOaXfzUqxEq3ysutanJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674803246;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6RGdD0dbpYfwJsZsZUvRLD7D/Kc7PVnGQWv53OgY25s=;
        b=hFIs69ZKgDgDIX7GpxB7uKo2ot5TJpzCWPdyQySp/jrb1xbdhSBhpIqFpYwLUEaiO5irhy
        bEkyQaUUB+Juu0CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AEC6F1336F;
        Fri, 27 Jan 2023 07:07:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2LDpKC1402OIVAAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 27 Jan 2023 07:07:25 +0000
Message-ID: <7d70d816-ffce-2196-1de2-b30be4215ee3@suse.de>
Date:   Fri, 27 Jan 2023 08:07:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 08/15] blk-wbt: open code wbt_queue_depth_changed in
 wbt_update_limits
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org
References: <20230117081257.3089859-1-hch@lst.de>
 <20230117081257.3089859-9-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230117081257.3089859-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 1/17/23 09:12, Christoph Hellwig wrote:
> No real need to all the method here, so open code to it to prepare
> for some paramter passing changes.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-wbt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index 542271fa99e8f7..473ae72befaf1a 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -863,9 +863,9 @@ int wbt_init(struct gendisk *disk)
>   	rwb->enable_state = WBT_STATE_ON_DEFAULT;
>   	rwb->wc = test_bit(QUEUE_FLAG_WC, &q->queue_flags);
>   	rwb->rq_depth.default_depth = RWB_DEF_DEPTH;
> +	rwb->rq_depth.queue_depth = blk_queue_depth(q);
>   	rwb->min_lat_nsec = wbt_default_latency_nsec(q);
> -
> -	wbt_queue_depth_changed(&rwb->rqos);
> +	wbt_update_limits(rwb);
>   
>   	/*
>   	 * Assign rwb and add the stats callback.
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

