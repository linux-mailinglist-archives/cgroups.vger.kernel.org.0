Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE83487982
	for <lists+cgroups@lfdr.de>; Fri,  7 Jan 2022 16:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348047AbiAGPFY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 Jan 2022 10:05:24 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59288 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348018AbiAGPFW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 7 Jan 2022 10:05:22 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C15D4212C6;
        Fri,  7 Jan 2022 15:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641567920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bfQ8dZ9iOK4ZLIWBef694BJBh3Yngy+CFp1E53a7Fws=;
        b=TRUs8e0/wDCB4ZYfNA5EzrqFuAGe6CqZ/UVofHtzCN9TPfzt/deK6cukXraObSOV6GYD14
        TZiq2nFdtxCgiNm7Aw5xZoCJo60ZOZv5uMKTkB9IZ4CrrU+Kw6L77ORM6Qa7UV2hGz/LNx
        xbA/xsvyOMr1DxCxspQocSbeLORPUdo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B25A13D0F;
        Fri,  7 Jan 2022 15:05:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +NTDJLBW2GHtCgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 07 Jan 2022 15:05:20 +0000
Date:   Fri, 7 Jan 2022 16:05:19 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     tj@kernel.org, hch@infradead.org, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH v5 2/2] block: cancel all throttled bios in del_gendisk()
Message-ID: <20220107150519.GA26824@blackbody.suse.cz>
References: <20211210083143.3181535-1-yukuai3@huawei.com>
 <20211210083143.3181535-3-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210083143.3181535-3-yukuai3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Dec 10, 2021 at 04:31:43PM +0800, Yu Kuai <yukuai3@huawei.com> wrote:
> +	 * queue_lock is held, rcu lock is not needed here.
> +	 */
> +	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg)
> +		tg_drain_bios(&blkg_to_tg(blkg)->service_queue);

FTR, I acknowledge this can work due to RCU peculiarities, however, I
don't understand why is it preferred against more robust explict
rcu_read_lock().

(All in all, this isn't a deal breaker and I'm not confident evaluating
the rest of the patch.)

Michal
