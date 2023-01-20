Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413FD674FE8
	for <lists+cgroups@lfdr.de>; Fri, 20 Jan 2023 09:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjATIzh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Jan 2023 03:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjATIzg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Jan 2023 03:55:36 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307A45B9A;
        Fri, 20 Jan 2023 00:55:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E1209228CB;
        Fri, 20 Jan 2023 08:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674204933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e4Q1VHGGcDhGS3UBPXctvtuTi2sVs/AqValPMfoWSYE=;
        b=Su6hdgzchZCXt2HTOTOjgHNxtpHGqdPLqfJJkMOHMurMPCV4yMqMCnYQAezfefQdiYvAvk
        wL8S7fl568RRar4j3Hm3zw+ZvcSwvHncGjZwdIlEuZ6x+BAvTAIT85Tk/HwB2A2H7zQmuv
        rZCDaypwyod4q5cySeYww2Zxa0g8KTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674204933;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e4Q1VHGGcDhGS3UBPXctvtuTi2sVs/AqValPMfoWSYE=;
        b=j4qsZrhR7S36Hkx+UjJnhv91ntaLtfw16raFwIR7bcP7jxeZa/787+JmWt1Yc0WjQHNstZ
        3NVG7kHoBxNc5fDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4143913251;
        Fri, 20 Jan 2023 08:55:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ff5IDQVXymOVHwAAMHmgww
        (envelope-from <aherrmann@suse.de>); Fri, 20 Jan 2023 08:55:33 +0000
Date:   Fri, 20 Jan 2023 09:55:31 +0100
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 02/15] block: don't call blk_throtl_stat_add for
 non-READ/WRITE commands
Message-ID: <Y8pXAyRs5lABGdsD@suselix>
References: <20230117081257.3089859-1-hch@lst.de>
 <20230117081257.3089859-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230117081257.3089859-3-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 17, 2023 at 09:12:44AM +0100, Christoph Hellwig wrote:
> blk_throtl_stat_add is called from blk_stat_add explicitly, unlike the
> other stats that go through q->stats->callbacks.  To prepare for cgroup
> data moving to the gendisk, ensure blk_throtl_stat_add is only called
> for the plain READ and WRITE commands that it actually handles internally,
> as blk_stat_add can also be called for passthrough commands on queues that
> do not have a genisk associated with them.
                ^^^^^^
		gendisk
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-stat.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Looks good to me. Feel free to add
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

> diff --git a/block/blk-stat.c b/block/blk-stat.c
> index 2ea01b5c1aca04..c6ca16abf911e2 100644
> --- a/block/blk-stat.c
> +++ b/block/blk-stat.c
> @@ -58,7 +58,8 @@ void blk_stat_add(struct request *rq, u64 now)
>  
>  	value = (now >= rq->io_start_time_ns) ? now - rq->io_start_time_ns : 0;
>  
> -	blk_throtl_stat_add(rq, value);
> +	if (req_op(rq) == REQ_OP_READ || req_op(rq) == REQ_OP_WRITE)
> +		blk_throtl_stat_add(rq, value);
>  
>  	rcu_read_lock();
>  	cpu = get_cpu();
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
