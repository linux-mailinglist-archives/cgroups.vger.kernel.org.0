Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600A2638727
	for <lists+cgroups@lfdr.de>; Fri, 25 Nov 2022 11:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiKYKOt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Nov 2022 05:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiKYKOt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Nov 2022 05:14:49 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AED2FC22;
        Fri, 25 Nov 2022 02:14:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 430BE21871;
        Fri, 25 Nov 2022 10:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669371287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ktt+/ZYL1xCbjfcRNgvv+Mm6BA/t+FfR0Lzt53hhHtI=;
        b=V7cYwN6zMePIafDyR97fv+1c1jMsEAutNfgvBs1R4VydI4ZqGvdSEGOuyZAz+ygMnMeudm
        Ryya9oCtbEHv8GSGL2M4e1cvFe/uAP4V6lhRy96kdF12nFtUupqgFVuD2gzCa7rxM4hCrp
        HJQlOZ+c9fbEswdA7+6hYnpOQVjs58g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669371287;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ktt+/ZYL1xCbjfcRNgvv+Mm6BA/t+FfR0Lzt53hhHtI=;
        b=3WF6NMPuqnXBsXUfc9heSPeKDZ+AIrd/O08jOtknxnXsCB5CsULsI4o7/4DTSq4IgbpBd8
        8krhfSd5ttmdn9DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A631613A08;
        Fri, 25 Nov 2022 10:14:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QRCbIpaVgGMqYwAAMHmgww
        (envelope-from <aherrmann@suse.de>); Fri, 25 Nov 2022 10:14:46 +0000
Date:   Fri, 25 Nov 2022 11:14:44 +0100
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Li Nan <linan122@huawei.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next 2/2] blk-iocost: change div64_u64 to
 DIV64_U64_ROUND_UP in ioc_refresh_params()
Message-ID: <Y4CVlCgB5eSw03yI@suselix>
References: <20221124140635.695205-1-linan122@huawei.com>
 <20221124140635.695205-2-linan122@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221124140635.695205-2-linan122@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Nov 24, 2022 at 10:06:35PM +0800, Li Nan wrote:
> vrate_min is calculated by DIV64_U64_ROUND_UP, but vrate_max is calculated
> by div64_u64. Vrate_min may be 1 greater than vrate_max if the input
> values min and max of cost.qos are equal.
> 
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>  block/blk-iocost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index a38a5324bf10..9030ad8672f3 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -926,7 +926,7 @@ static bool ioc_refresh_params(struct ioc *ioc, bool force)
>  
>  	ioc->vrate_min = DIV64_U64_ROUND_UP((u64)ioc->params.qos[QOS_MIN] *
>  					    VTIME_PER_USEC, MILLION);
> -	ioc->vrate_max = div64_u64((u64)ioc->params.qos[QOS_MAX] *
> +	ioc->vrate_max = DIV64_U64_ROUND_UP((u64)ioc->params.qos[QOS_MAX] *
>  				   VTIME_PER_USEC, MILLION);
>  
>  	return true;
> -- 
> 2.31.1
> 

-- 
Regards,
Andreas

SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nürnberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
