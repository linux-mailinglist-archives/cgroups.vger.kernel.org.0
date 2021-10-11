Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5028429312
	for <lists+cgroups@lfdr.de>; Mon, 11 Oct 2021 17:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbhJKPZW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Oct 2021 11:25:22 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45270 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbhJKPZV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Oct 2021 11:25:21 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 361FF2017B;
        Mon, 11 Oct 2021 15:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633965800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7c/NrmzTGTsgOvKn52EsTSKmzoG1TlQJCZXKhAlpBfA=;
        b=hO7xF03Ts64S2p90ng+KaDHXFlaWeJQbfgY0oz5i8Z4FH2+GtaHZr5w66bllhb3wztRKmm
        XaD8fXn7yC/jL8x/f+4DTJsSIVZCFPGD5xFoo8QO82SHqf6J62kCRtfiPELGQqmK5rwdJ8
        /YGKVXaRserLrG2N0N67Fz8pFYZLkA0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1532113BC5;
        Mon, 11 Oct 2021 15:23:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NQQUBOhWZGFSTwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 11 Oct 2021 15:23:20 +0000
Date:   Mon, 11 Oct 2021 17:23:18 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     tj@kernel.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH] blk-cgroup: check blkcg policy is enabled in
 blkg_create()
Message-ID: <20211011152318.GA61605@blackbody.suse.cz>
References: <20211008072720.797814-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008072720.797814-1-yukuai3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello.

On Fri, Oct 08, 2021 at 03:27:20PM +0800, Yu Kuai <yukuai3@huawei.com> wrote:
> This is because blkg_alloc() is called from blkg_conf_prep() without
> holding 'q->queue_lock', and elevator is exited before blkg_create():
 
IIUC the problematic interleaving is this one (I've noticed `blkg->pd[i]
= NULL` to thread 2 call trace):

> thread 1                            thread 2
> blkg_conf_prep
>  spin_lock_irq(&q->queue_lock);
>  blkg_lookup_check -> return NULL
>  spin_unlock_irq(&q->queue_lock);
> 
>  blkg_alloc
>   blkcg_policy_enabled -> true
>   pd = ->pd_alloc_fn
>                                    blk_mq_exit_sched
>                                     bfq_exit_queue
>                                      blkcg_deactivate_policy
>                                       spin_lock_irq(&q->queue_lock);
>                                       __clear_bit(pol->plid, q->blkcg_pols);
>
                                        pol->pd_free_fn(blkg->pd[i]);
                                        blkg->pd[i] = NULL;
>
>                                       spin_unlock_irq(&q->queue_lock);
>                                     q->elevator = NULL;
    blkg->pd[i] = pd
>   spin_lock_irq(&q->queue_lock);
>    blkg_create
>     if (blkg->pd[i])
>      ->pd_init_fn -> q->elevator is NULL
>   spin_unlock_irq(&q->queue_lock);

In high-level terms, is this a race between (blk)io controller attribute
write and a device scheduler (elevator) switch?
If so, I'd add it to the commit message.

> Fix the problem by checking that policy is still enabled in
> blkg_create().

Is this sufficient wrt some other q->elevator users later?

> @@ -252,6 +266,9 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
>  		goto err_free_blkg;
>  	}
>  

I'd add a comment here like:

> Re-check policies are still enabled, since the caller blkg_conf_prep()
> temporarily drops q->queue_lock and we can race with
> blk_mq_exit_sched() removing policies.

> +	if (new_blkg)
> +		blkg_check_pd(q, new_blkg);
> +

Thanks,
Michal
