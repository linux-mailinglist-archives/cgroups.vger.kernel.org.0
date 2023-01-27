Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459D067DE11
	for <lists+cgroups@lfdr.de>; Fri, 27 Jan 2023 07:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjA0G7k (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Jan 2023 01:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjA0G7d (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Jan 2023 01:59:33 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2176829E3A;
        Thu, 26 Jan 2023 22:59:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A8578200D9;
        Fri, 27 Jan 2023 06:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674802763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SLT9CjpwUzvWOcEZLv9zytJzCJGpAe8NLiJP8y0cIzA=;
        b=Loka0f/lOTAOKetC36RiUPXf8LKkgEV8RKNWurxl8EXsFRV+1STEi8WnNo2DYHGcDq1B/P
        lZfypDW21xT+8FiHpkr79HVWbdB/O0L3R3iPskcQa9blJ5HWipqZZr/fhEpkeI0JnW2CK/
        Huy2VSWEi1oMETy5kQh0OPK7B2BJScQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674802763;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SLT9CjpwUzvWOcEZLv9zytJzCJGpAe8NLiJP8y0cIzA=;
        b=Jkf/KBwpbKNvyVKMeIIKyN5EinnlU/ebIN6HYt5eOZHu0aC2vhBvuAKdv2mdpPJo/mskWm
        o+P/iBouYlF34gDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 86BF71336F;
        Fri, 27 Jan 2023 06:59:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FKU5IEt202PuUAAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 27 Jan 2023 06:59:23 +0000
Message-ID: <b4622942-67e7-969b-4439-0aea7c5bd165@suse.de>
Date:   Fri, 27 Jan 2023 07:59:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 01/15] blk-cgroup: don't defer blkg_free to a workqueue
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org
References: <20230117081257.3089859-1-hch@lst.de>
 <20230117081257.3089859-2-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230117081257.3089859-2-hch@lst.de>
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
> Now that blk_put_queue can be called from process context, ther is no
> need for the asynchronous execution.
> 
Can you clarify 'now'?
IE point to the commit introducing the change?

> This effectively reverts commit d578c770c85233af592e54537f93f3831bde7e9a.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-cgroup.c | 32 ++++++++++----------------------
>   block/blk-cgroup.h |  5 +----
>   2 files changed, 11 insertions(+), 26 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

