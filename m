Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137EF5326F9
	for <lists+cgroups@lfdr.de>; Tue, 24 May 2022 11:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbiEXJ7k (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 May 2022 05:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbiEXJ7k (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 May 2022 05:59:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80401719FA;
        Tue, 24 May 2022 02:59:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 39D491F8A8;
        Tue, 24 May 2022 09:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653386378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JTKEB4NmoJkwSXk1U6EYZKEevt7IEvr3Nwq93kINHr0=;
        b=l4HC7B+JUhcVWwqVWAvAIxcfrLeo5n86Jld5BGNuZAJ8Ox9RFNXaio2R37Na4fcLy1/S8s
        UtqoZFBOj9zArT9tgp7woC06z+Y3Y3SCJjbk3nW9ljusVgVtr4rmV6nWuMmMrq4pRLw/P5
        aqBVkDC/8EejSzuqd3aC687vr7pcPWY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C92513ADF;
        Tue, 24 May 2022 09:59:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5rcPAoqsjGKIEwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 24 May 2022 09:59:38 +0000
Date:   Tue, 24 May 2022 11:59:36 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     tj@kernel.org, axboe@kernel.dk, ming.lei@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH -next v4 4/4] blk-throttle: fix io hung due to config
 updates
Message-ID: <20220524095936.GB2434@blackbody.suse.cz>
References: <20220523082633.2324980-1-yukuai3@huawei.com>
 <20220523082633.2324980-5-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220523082633.2324980-5-yukuai3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 23, 2022 at 04:26:33PM +0800, Yu Kuai <yukuai3@huawei.com> wrote:
> Fix the problem by respecting the time that throttled bio aready waited.
> In order to do that, add new fields to record how many bytes/io already
> waited, and use it to calculate wait time for throttled bio under new
> configuration.

This new approach is correctly conserving the bandwidth upon changes.
(Looking and BPS paths.)

> 
> Some simple test:
> 1)
> cd /sys/fs/cgroup/blkio/
> echo $$ > cgroup.procs
> echo "8:0 2048" > blkio.throttle.write_bps_device
> {
>         sleep 3
>         echo "8:0 1024" > blkio.throttle.write_bps_device
> } &
> sleep 1
> dd if=/dev/zero of=/dev/sda bs=8k count=1 oflag=direct
> 
> 2)
> cd /sys/fs/cgroup/blkio/
> echo $$ > cgroup.procs
> echo "8:0 1024" > blkio.throttle.write_bps_device
> {
>         sleep 5
>         echo "8:0 2048" > blkio.throttle.write_bps_device
> } &
> sleep 1
> dd if=/dev/zero of=/dev/sda bs=8k count=1 oflag=direct
> 

It's interesting that you're getting these numbers (w/patch)

> test results: io finish time
> 	before this patch	with this patch
> 1)	10s			6s
> 2)	8s			6s

wait := (disp + bio - Δt*l_old) / l_new

1)
wait = (0k + 8k - 3s*2k/s) / 1k/s = 2s -> i.e. 5s absolute

2)
wait = (0k + 8k - 5s*1k/s) / 2k/s = 2.5s -> i.e. 6.5s absolute

Are you numbers noisy+rounded or do I still mis anything?

(Also isn't it worth having this more permanent in tools/testing/selftest?)

> +static void tg_update_skipped(struct throtl_grp *tg)
> +{
> +	if (tg->service_queue.nr_queued[READ])
> +		__tg_update_skipped(tg, READ);
> +	if (tg->service_queue.nr_queued[WRITE])
> +		__tg_update_skipped(tg, WRITE);

On one hand, the callers of tg_update_skipped() know whether R/W limit
is changed, so only the respective variant could be called.
On the other hand, this conditions look implied by tg->flags &
THROTL_TG_PENDING.
(Just noting, it's likely still not possibly to pass the skipped value
only via stack.)


> @@ -115,6 +115,10 @@ struct throtl_grp {
>  	uint64_t bytes_disp[2];
>  	/* Number of bio's dispatched in current slice */
>  	unsigned int io_disp[2];
> +	/* Number of bytes will be skipped in current slice */
> +	uint64_t bytes_skipped[2];
> +	/* Number of bio's will be skipped in current slice */
> +	unsigned int io_skipped[2];

Please add a comment these fields exists to facilitate config updates
(the bytes to be skipped is sort of obvious from the name :-).

Thanks,
Michal

