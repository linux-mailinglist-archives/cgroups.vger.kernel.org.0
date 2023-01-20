Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CF5675113
	for <lists+cgroups@lfdr.de>; Fri, 20 Jan 2023 10:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjATJ2N (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Jan 2023 04:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjATJ2L (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Jan 2023 04:28:11 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00C428D3B;
        Fri, 20 Jan 2023 01:27:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4DBFD21EAC;
        Fri, 20 Jan 2023 09:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674206509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8DUEI+/9ZHTe402IQZx5GdLdzfOs7lN387guOhnS35U=;
        b=p7xCq1QgziS2jPdK++PkEz4kRl/t9CrdMkOHbbd9RGQQoMpgS5HRSB/EVpRMqWtMhXHJ1G
        6LDGAZzdbuMfgeGFQ5smgRQFHlgv25vogecUsHNbkve2lgFampGT0HaDHXkxSDzFujHCEl
        5B+iCOf04G6T5EuURqAcEaEBfPp8/cw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674206509;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8DUEI+/9ZHTe402IQZx5GdLdzfOs7lN387guOhnS35U=;
        b=d2pV8G7fXa3UCM2L70v/X5fOXSEGlLyMSH8fql5FitqtWs59qZ07x9qHeOG6xCA1JzGfJX
        vmFJYMlRf9kWvlCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA4331390C;
        Fri, 20 Jan 2023 09:21:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rO8FLyxdymMVLwAAMHmgww
        (envelope-from <aherrmann@suse.de>); Fri, 20 Jan 2023 09:21:48 +0000
Date:   Fri, 20 Jan 2023 10:21:46 +0100
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 08/15] blk-wbt: open code wbt_queue_depth_changed in
 wbt_update_limits
Message-ID: <Y8pdKiV4s7rvOMF5@suselix>
References: <20230117081257.3089859-1-hch@lst.de>
 <20230117081257.3089859-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230117081257.3089859-9-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 17, 2023 at 09:12:50AM +0100, Christoph Hellwig wrote:
> No real need to all the method here, so open code to it to prepare
> for some paramter passing changes.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-wbt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Looks good to me. Feel free to add
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index 542271fa99e8f7..473ae72befaf1a 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -863,9 +863,9 @@ int wbt_init(struct gendisk *disk)
>  	rwb->enable_state = WBT_STATE_ON_DEFAULT;
>  	rwb->wc = test_bit(QUEUE_FLAG_WC, &q->queue_flags);
>  	rwb->rq_depth.default_depth = RWB_DEF_DEPTH;
> +	rwb->rq_depth.queue_depth = blk_queue_depth(q);
>  	rwb->min_lat_nsec = wbt_default_latency_nsec(q);
> -
> -	wbt_queue_depth_changed(&rwb->rqos);
> +	wbt_update_limits(rwb);
>  
>  	/*
>  	 * Assign rwb and add the stats callback.
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
