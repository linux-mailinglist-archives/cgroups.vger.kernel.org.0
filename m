Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840F4539FA2
	for <lists+cgroups@lfdr.de>; Wed,  1 Jun 2022 10:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348066AbiFAIic (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jun 2022 04:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343797AbiFAIib (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jun 2022 04:38:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A424D269;
        Wed,  1 Jun 2022 01:38:31 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D14871F897;
        Wed,  1 Jun 2022 08:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654072709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6sRJx7dgkrP3lfQ1w9+FmL/xTk+6hJEOi+Q76uJOa+s=;
        b=gnq3y9WXYS1tb+Tz+KYQ6JTFI1uVEOhIwJDuBykhJIOGw1d2k6EiVq8J4FP/2dN7MCr8XD
        wlptnvtmfE0zmXxv0WTlzZ5war3KlL/HpjkNgZLMfmQ0XDw1ygOyi2+cCBfrHiIfLDdyPu
        B25E4US3VhWnjxoyVPz5EeWEJE+zWeY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654072709;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6sRJx7dgkrP3lfQ1w9+FmL/xTk+6hJEOi+Q76uJOa+s=;
        b=zWAzszJYpDCB0DkfCK/db+u6SHB52Qys/480v4DJs75l1jjdlckXvxAmvT4dMM3nQIT5GF
        aSRFuveYLXQ6AZBw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C21862C141;
        Wed,  1 Jun 2022 08:38:29 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 74833A0633; Wed,  1 Jun 2022 10:38:29 +0200 (CEST)
Date:   Wed, 1 Jun 2022 10:38:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     paolo.valente@linaro.org, jack@suse.cz, axboe@kernel.dk,
        tj@kernel.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next v8 4/4] block, bfq: do not idle if only one group
 is activated
Message-ID: <20220601083829.ywv4z5yfdmslcihv@quack3.lan>
References: <20220531140858.3324294-1-yukuai3@huawei.com>
 <20220531140858.3324294-5-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531140858.3324294-5-yukuai3@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 31-05-22 22:08:58, Yu Kuai wrote:
> Now that root group is counted into 'num_groups_with_pending_reqs',
> 'num_groups_with_pending_reqs > 0' is always true in
> bfq_asymmetric_scenario(). Thus change the condition to '> 1'.
> 
> On the other hand, this change can enable concurrent sync io if only
> one group is activated.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Just one language fixup below:

> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 03b04892440c..d4aa8421968d 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -820,7 +820,7 @@ bfq_pos_tree_add_move(struct bfq_data *bfqd, struct bfq_queue *bfqq)
>   * much easier to maintain the needed state:
>   * 1) all active queues have the same weight,
>   * 2) all active queues belong to the same I/O-priority class,
> - * 3) there are no active groups.
> + * 3) there are one active groups at most.
         ^^^ "there is at most one active group"

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
