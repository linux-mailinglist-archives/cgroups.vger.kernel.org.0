Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FCF67DE4D
	for <lists+cgroups@lfdr.de>; Fri, 27 Jan 2023 08:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjA0HMR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Jan 2023 02:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjA0HMR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Jan 2023 02:12:17 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E15D38EA9;
        Thu, 26 Jan 2023 23:12:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3B9661FEB2;
        Fri, 27 Jan 2023 07:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674803535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9A3/bx1nMGaGFX3IVqLkC1CtqNCMmaJvRrFybXqukk=;
        b=K7BWqnFKP5u322iMRCGIx6Xbfiu06lLuyEVRXFAFd+nQu5R7z5Mu5wVcrtyA5xyMhnj7m4
        PxPZq1VyYXK04ksS9U+558GQPVemo+LigZbKS8Dl92CTUEf97PTsdYZbdnIznCAUIndVMj
        rCUaNflYw76wi6939cxjyCNYeM7j4ck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674803535;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9A3/bx1nMGaGFX3IVqLkC1CtqNCMmaJvRrFybXqukk=;
        b=o28bV7RyhQiiC9h4XLWSevfMx39INl6AmgYHPykWbnoULdMzagaONbHdbW2SQBAZeiyawN
        fyDsS/E0/gLoNUCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 24D3D1336F;
        Fri, 27 Jan 2023 07:12:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0v9SCE9502PXVgAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 27 Jan 2023 07:12:15 +0000
Message-ID: <f202c9ba-23c8-9c1b-be8c-e87c94427669@suse.de>
Date:   Fri, 27 Jan 2023 08:12:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 15/15] blk-cgroup: move the cgroup information to struct
 gendisk
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org
References: <20230117081257.3089859-1-hch@lst.de>
 <20230117081257.3089859-16-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230117081257.3089859-16-hch@lst.de>
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
> cgroup information only makes sense on a live gendisk that allows
> file system I/O (which includes the raw block device).  So move over
> the cgroup related members.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/bfq-cgroup.c     |  4 ++--
>   block/blk-cgroup.c     | 48 +++++++++++++++++++++---------------------
>   block/blk-cgroup.h     |  2 +-
>   block/blk-iolatency.c  |  2 +-
>   block/blk-throttle.c   | 16 ++++++++------
>   include/linux/blkdev.h | 10 ++++-----
>   6 files changed, 43 insertions(+), 39 deletions(-)
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

