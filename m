Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A0169E341
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 16:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjBUPVV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 10:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbjBUPVU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 10:21:20 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3971C25BB2;
        Tue, 21 Feb 2023 07:21:19 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EDEB234C14;
        Tue, 21 Feb 2023 15:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676992877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gzHiHoqH1FZ2e8or4vCjWdlBkU2/7QX1hNdRkugFVaM=;
        b=LgKqeo2yQ2b1D0vJPE7Wjp9MTcodIdE2vXEn1gZ//a8FuhQ9ii4mh4H5rDAL/Tr1f9SzFB
        sB8OPFP2fFPTN1KhtaaEvkMNx1gadQSAqlS9PRt1QrX4dncGI7ulO5iOTfM1uRSUZvsKU7
        12M7ip+L/P6NrUrHbV8prJjVsYRv7Kk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD84313481;
        Tue, 21 Feb 2023 15:21:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o626L23h9GP7bwAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 21 Feb 2023 15:21:17 +0000
Date:   Tue, 21 Feb 2023 16:21:17 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     hannes@cmpxchg.org, shakeelb@google.com, muchun.song@linux.dev,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcg: Skip high limit check in root memcg
Message-ID: <Y/ThbQNqrdny4+Pf@dhcp22.suse.cz>
References: <20230210094550.5125-1-haifeng.xu@shopee.com>
 <Y+uvRKo7OQ02yB4K@dhcp22.suse.cz>
 <82918a12-d83e-10c0-0e04-eec26657b699@shopee.com>
 <Y/S3GHT1P6awZaPb@dhcp22.suse.cz>
 <99bdfbec-2de4-b432-9649-09557d3f95d6@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99bdfbec-2de4-b432-9649-09557d3f95d6@shopee.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 21-02-23 22:21:45, Haifeng Xu wrote:
[...]
> >> The test result show that with or without the patch, the time taken is almost the same.
> > 
> > This is in line with my expectation. So the question is whether the
> > additional check is really worth it. 
> 
> This patch doesn't bring any obvious benifit or harm, but the high
> limit check in root memcg seems a little weird.  Maybe we can add this
> check

Well, I do not see the code to look weird TBH. There is nothing wrong in
doing the check for the root memcg. It is a bit pointless but it is not
incorrect.

> It all depends on your viewpoint.

From my POV, I prefer changes that either fix something (correctness
issue or a performance issue/improvement) or improve readbility. The
check doesn't fix anything and I am not convinced about an improved
readabilit either.

Thanks for the patch anyway!
-- 
Michal Hocko
SUSE Labs
