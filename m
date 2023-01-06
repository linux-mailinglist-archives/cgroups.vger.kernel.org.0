Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0786066036A
	for <lists+cgroups@lfdr.de>; Fri,  6 Jan 2023 16:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbjAFPiS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Jan 2023 10:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjAFPiR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 Jan 2023 10:38:17 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2435745A5;
        Fri,  6 Jan 2023 07:38:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 98D934023F;
        Fri,  6 Jan 2023 15:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673019494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D7BVs+c1jJrTgfTP4y3v5/V0eGmeqdXDwPfl0iJaAd4=;
        b=3E3Lgs2aAGpDdYW5+AKcNWdB5l9w4zvWCacqafvED4WVf1Z7fBzgAfn2miDNOdc50rpRcF
        /gPnEqvTuPLTE8Kk9wNQfTkQquPSENw6dOkP6baW5IQ0Juhba85jdQ8Erk0oTWmTJT8+Cw
        TZV1dEMWE0AzpAAHzknBF1M3LaDLsbI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673019494;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D7BVs+c1jJrTgfTP4y3v5/V0eGmeqdXDwPfl0iJaAd4=;
        b=1q0HHYB9DZXlBTx+ZpLaeAQje6jIDfq0gkybOD0Eto4yfx1n9s7rlKVsVBxz+DfiCkAVpl
        X4mbSYxsz7b2OeDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 87F5E13596;
        Fri,  6 Jan 2023 15:38:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FK4pIWZAuGPrHAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 06 Jan 2023 15:38:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9F946A0742; Fri,  6 Jan 2023 16:38:13 +0100 (CET)
Date:   Fri, 6 Jan 2023 16:38:13 +0100
From:   Jan Kara <jack@suse.cz>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Jinke Han <hanjinke.666@bytedance.com>, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jack@suse.cz
Subject: Re: [PATCH v3] blk-throtl: Introduce sync and async queues for
 blk-throtl
Message-ID: <20230106153813.4ttyuikzaagkk2sc@quack3>
References: <20221226130505.7186-1-hanjinke.666@bytedance.com>
 <20230105161854.GA1259@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230105161854.GA1259@blackbody.suse.cz>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 05-01-23 17:18:54, Michal Koutný wrote:
> Hello Jinke.
> 
> On Mon, Dec 26, 2022 at 09:05:05PM +0800, Jinke Han <hanjinke.666@bytedance.com> wrote:
> > In our test, fio writes a 100g file in sequential 4k blocksize in
> > a container with low bps limit configured (wbps=10M).
> > [...]
> > At the same time, the operation of saving a small file by vim will be
> > blocked amolst 140s.
> 
> Could you please elaborate why is this specific to blk-throtl?
> 
> I guess similar problem would arise for devices that are "naturally"
> slow.
> Then:
> a) it must have been solved elsewhere in the block layer (but it's
>    broken),
> b) it should be solved generically in the block layer (thus this is only
>    a partial solution).

Generally, problems are this are taken care of by IO schedulers. E.g. BFQ
has quite a lot of logic exactly to reduce problems like this. Sync and
async queues are one part of this logic inside BFQ (but there's more).

But given current architecture of the block layer IO schedulers are below
throttling frameworks such as blk-throtl so they have no chance of
influencing problems like this. So we are bound to reinvent the scheduling
logic IO schedulers are already doing. That being said I don't have a good
solution for this or architecture suggestion. Because implementing various
throttling frameworks within IO schedulers is cumbersome (complex
interactions) and generally the perfomance is too slow for some usecases.
We've been there (that's why there's cgroup support in BFQ) and really
the current architecture is much easier to reason about.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
