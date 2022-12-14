Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBF564CD90
	for <lists+cgroups@lfdr.de>; Wed, 14 Dec 2022 16:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238607AbiLNP7e (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Dec 2022 10:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238619AbiLNP7M (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 14 Dec 2022 10:59:12 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDC829820;
        Wed, 14 Dec 2022 07:57:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BDCC61F894;
        Wed, 14 Dec 2022 15:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671033470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B4OheqqFLoHea6X9Q+7CKodDyXD/mYyUFNDiEKU1Y5I=;
        b=gM4CtN/H82jW/oj+L6LHZBSQM+xE8svPLl+esaPN/+znII72XqlZuXtzN6I1VjHphNJbpv
        SY9r/eNd2pP+aatAc50bRAnumdhVsD654mDL9oxtED4JTWzWmz3o8gaxnS5zEXN2JILnFA
        6GH8jLaXg7OjDsL0vDtaS/4pDYI/zBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671033470;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B4OheqqFLoHea6X9Q+7CKodDyXD/mYyUFNDiEKU1Y5I=;
        b=pqf2UoRr2rrqpTMHTqmuFmGlDOxvQL89y779TNDsxBWmGUrKnocMzBcNQ7gL0FN/4ggy2c
        fIG1BshGhkAotNAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AEA9C138F6;
        Wed, 14 Dec 2022 15:57:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id u4ihKn7ymWPgWgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 14 Dec 2022 15:57:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1275DA0727; Wed, 14 Dec 2022 16:57:50 +0100 (CET)
Date:   Wed, 14 Dec 2022 16:57:50 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Jan Kara <jack@suse.cz>, paolo.valente@linaro.org, axboe@kernel.dk,
        tj@kernel.org, josef@toxicpanda.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 0/2] block, bfq: minor cleanups
Message-ID: <20221214155750.ivc43jgkfvxlp6y4@quack3>
References: <20221214033155.3455754-1-yukuai1@huaweicloud.com>
 <79d587ef-66c3-e84d-0904-41da2c8e7146@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79d587ef-66c3-e84d-0904-41da2c8e7146@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 14-12-22 11:14:49, Yu Kuai wrote:
> Hi, Jan
> 
> Sorry that I forgot to cc you.

Both patches look good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> Thanks,
> Kuai
> 
> 在 2022/12/14 11:31, Yu Kuai 写道:
> > From: Yu Kuai <yukuai3@huawei.com>
> > 
> > Yu Kuai (2):
> >    block, bfq: don't return bfqg from __bfq_bic_change_cgroup()
> >    block, bfq: replace 0/1 with false/true in bic apis
> > 
> >   block/bfq-cgroup.c  | 16 +++++++---------
> >   block/bfq-iosched.c |  4 ++--
> >   2 files changed, 9 insertions(+), 11 deletions(-)
> > 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
