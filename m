Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF044FF583
	for <lists+cgroups@lfdr.de>; Wed, 13 Apr 2022 13:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbiDMLOj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Apr 2022 07:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbiDMLOi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Apr 2022 07:14:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3573027FE3;
        Wed, 13 Apr 2022 04:12:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E1787210E5;
        Wed, 13 Apr 2022 11:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649848336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ngB0VaDZkffeOh+BSwJSCsqMcNibSRUO4jU8FKml6Bs=;
        b=i8qKj0NNFnGDs/62UlAmcsdLiT3oYBGGKRDyTKuXoGgeqCfro+kOFHFEtUEnkuXMb9nrfZ
        jsOai74lku4/r+dmPZLZkCSpMSx3PL33g3X0PyDW/EOZWGk9rEXFvoS8UkeuIHLitPT1b5
        ViZOs9dic+cSfwyRWq1RVGDSWUAlQGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649848336;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ngB0VaDZkffeOh+BSwJSCsqMcNibSRUO4jU8FKml6Bs=;
        b=haFT45FMpnXW+0MzW9Ui1fMZNh/llnnI3l08AdD/0HoufaBvM07pNwAHzWzodylCXdQXTp
        kTc795IgiNJSZQBA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CCDB2A3B87;
        Wed, 13 Apr 2022 11:12:16 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7F4AFA0615; Wed, 13 Apr 2022 13:12:16 +0200 (CEST)
Date:   Wed, 13 Apr 2022 13:12:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     tj@kernel.org, axboe@kernel.dk, paolo.valente@linaro.org,
        jack@suse.cz, cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH -next 00/11] support concurrent sync io for bfq on a
 specail occasion
Message-ID: <20220413111216.npgrdzaubsvjsmy3@quack3.lan>
References: <20220305091205.4188398-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305091205.4188398-1-yukuai3@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 05-03-22 17:11:54, Yu Kuai wrote:
> Currently, bfq can't handle sync io concurrently as long as they
> are not issued from root group. This is because
> 'bfqd->num_groups_with_pending_reqs > 0' is always true in
> bfq_asymmetric_scenario().
> 
> This patchset tries to support concurrent sync io if all the sync ios
> are issued from the same cgroup:
> 
> 1) Count root_group into 'num_groups_with_pending_reqs', patch 1-5;

Seeing the complications and special casing for root_group I wonder: Won't
we be better off to create fake bfq_sched_data in bfq_data and point
root_group->sched_data there? AFAICS it would simplify the code
considerably as root_group would be just another bfq_group, no need to
special case it in various places, no games with bfqg->my_entity, etc.
Paolo, do you see any problem with that?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
