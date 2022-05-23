Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8A3530C35
	for <lists+cgroups@lfdr.de>; Mon, 23 May 2022 11:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbiEWI7Q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 23 May 2022 04:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiEWI7G (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 23 May 2022 04:59:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D231C3EAB5;
        Mon, 23 May 2022 01:59:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7DC3621998;
        Mon, 23 May 2022 08:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653296344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h1QuB3M+BmdTEHvDbJ/48/qLXP8QUk8L4+wxn4b3JqE=;
        b=rZ+SQ9qfiHZw+b4x1x93KOH97ACbM8txlwl7+4DjUI1B9uu2F8p5huYe0KZJV6PhmLenGI
        /9pILZIIIJWcMF+BCk6vdTMDMbhQXj+VC8y9+To+2Rs2io0FF/X5sHXKShFqjUWZFpvWD2
        2Qan9NrxdGvwUwV47jUecy4SyZZwch4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653296344;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h1QuB3M+BmdTEHvDbJ/48/qLXP8QUk8L4+wxn4b3JqE=;
        b=UTh5pzrrDqKQxilv/HUuRQHZel4jue/bNpbW5iFLK+uFLL6KEgaRovHb4Cq7L/5LXVPIgN
        uIHOwEt7pP/JwFAw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 64E892C141;
        Mon, 23 May 2022 08:59:04 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E0083A0632; Mon, 23 May 2022 10:59:02 +0200 (CEST)
Date:   Mon, 23 May 2022 10:59:02 +0200
From:   Jan Kara <jack@suse.cz>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, paolo.valente@linaro.org,
        jack@suse.cz, tj@kernel.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next v5 0/3] support concurrent sync io for bfq on a
 specail occasion
Message-ID: <20220523085902.wmxoebyq3crerecr@quack3.lan>
References: <20220428120837.3737765-1-yukuai3@huawei.com>
 <d50df657-d859-79cf-c292-412eaa383d2c@huawei.com>
 <61b67d5e-829c-8130-7bda-81615d654829@huawei.com>
 <81411289-e13c-20f5-df63-c059babca57a@huawei.com>
 <d5a90a08-1ac6-587a-e900-0436bd45543a@kernel.dk>
 <55919e29-1f22-e8aa-f3d2-08c57d9e1c22@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55919e29-1f22-e8aa-f3d2-08c57d9e1c22@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 23-05-22 09:10:38, yukuai (C) wrote:
> 在 2022/05/21 20:21, Jens Axboe 写道:
> > On 5/21/22 1:22 AM, yukuai (C) wrote:
> > > 在 2022/05/14 17:29, yukuai (C) 写道:
> > > > 在 2022/05/05 9:00, yukuai (C) 写道:
> > > > > Hi, Paolo
> > > > > 
> > > > > Can you take a look at this patchset? It has been quite a long time
> > > > > since we spotted this problem...
> > > > > 
> > > > 
> > > > friendly ping ...
> > > friendly ping ...
> > 
> > I can't speak for Paolo, but I've mentioned before that the majority
> > of your messages end up in my spam. That's still the case, in fact
> > I just marked maybe 10 of them as not spam.
> > 
> > You really need to get this issued sorted out, or you will continue
> > to have patches ignore because folks may simply not see them.
> > 
> Hi,
> 
> Thanks for your notice.
> 
> Is it just me or do you see someone else's messages from *huawei.com
> end up in spam? I tried to seek help from our IT support, however, they
> didn't find anything unusual...

So actually I have noticed that a lot of (valid) email from huawei.com (not
just you) ends up in the spam mailbox. For me direct messages usually pass
(likely matching SPF records for originating mail server save the email
from going to spam) but messages going through mailing lists are flagged as
spam because the emails are missing valid DKIM signature but huawei.com
DMARC config says there should be DKIM signature (even direct messages are
missing DKIM so this does not seem as a mailing list configuration issue).
So this seems as some misconfiguration of the mails on huawei.com side
(likely missing DKIM signing of outgoing email).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
