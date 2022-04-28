Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9C2513262
	for <lists+cgroups@lfdr.de>; Thu, 28 Apr 2022 13:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbiD1L0y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Apr 2022 07:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbiD1L0u (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Apr 2022 07:26:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D9A5D65B;
        Thu, 28 Apr 2022 04:23:36 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3B4361F88A;
        Thu, 28 Apr 2022 11:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651145015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ALSlNdnUDfGqnVDNF+XbySa5KKZiHe5nsD1aWA9cJlQ=;
        b=Qqo62OOYsyHjfh46Geys+bzp5ZZw/H7DtsEoukKYDwWaRzoQgHT9LNdSBBtAVJ35q2QG+s
        OgC57syIbets7bbDv9VpnPnulvaIZfuIZyb1SI8/AZcFN+CLkB2RY5Y7/zduhoT5A3HfZg
        drXATWWbO/gIevBcwhXuQJfpu8BlqMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651145015;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ALSlNdnUDfGqnVDNF+XbySa5KKZiHe5nsD1aWA9cJlQ=;
        b=nozySw/YbNaB4EEXbIQFKP2yluTxF6VXLonrNIQglDs3KxliUb9+ELxwZrRKp8B6L6AI9c
        Mng41wRfV4ecu5CA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 286012C141;
        Thu, 28 Apr 2022 11:23:35 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D0057A061A; Thu, 28 Apr 2022 13:23:34 +0200 (CEST)
Date:   Thu, 28 Apr 2022 13:23:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     jack@suse.cz, tj@kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next v4 2/3] block, bfq: refactor the counting of
 'num_groups_with_pending_reqs'
Message-ID: <20220428112334.um5mnmxmm2y2oqqf@quack3.lan>
References: <20220428111907.3635820-1-yukuai3@huawei.com>
 <20220428111907.3635820-3-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428111907.3635820-3-yukuai3@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 28-04-22 19:19:06, Yu Kuai wrote:
> Currently, bfq can't handle sync io concurrently as long as they
> are not issued from root group. This is because
> 'bfqd->num_groups_with_pending_reqs > 0' is always true in
> bfq_asymmetric_scenario().
> 
> The way that bfqg is counted into 'num_groups_with_pending_reqs':
> 
> Before this patch:
>  1) root group will never be counted.
>  2) Count if bfqg or it's child bfqgs have pending requests.
>  3) Don't count if bfqg and it's child bfqgs complete all the requests.
> 
> After this patch:
>  1) root group is counted.
>  2) Count if bfqg have at least one bfqq that is marked busy.
>  3) Don't count if bfqg doesn't have any busy bfqqs.
> 
> The main reason to use busy state of bfqq instead of 'pending requests'
> is that bfqq can stay busy after dispatching the last request if idling
> is needed for service guarantees.
> 
> With this change, the occasion that only one group is activated can be
> detected, and next patch will support concurrent sync io in the
> occasion.
> 
> This patch also rename 'num_groups_with_pending_reqs' to
> 'num_groups_with_busy_queues'.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/bfq-iosched.c | 46 ++-----------------------------------
>  block/bfq-iosched.h | 55 ++++++---------------------------------------
>  block/bfq-wf2q.c    | 19 ++++------------
>  3 files changed, 13 insertions(+), 107 deletions(-)

I love the diffstat :)

> +	 * Number of groups with at leaset one bfqq that is marked busy,
				    ^^^^^ least

Otherwise the patch looks good so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
