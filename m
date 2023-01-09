Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E59B66238C
	for <lists+cgroups@lfdr.de>; Mon,  9 Jan 2023 11:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjAIK7X (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Jan 2023 05:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjAIK7U (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Jan 2023 05:59:20 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1DAF5AD;
        Mon,  9 Jan 2023 02:59:18 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 656897690D;
        Mon,  9 Jan 2023 10:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673261957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0zum01+6W6CWGMuMAoT/HPm/pZWcmXb0ZmN9Mhpgb7I=;
        b=ymj96arAyGY+TaDCybETNaeMAySXQp5KaSrVNcO0/OpY+kQw5rdon1sjJB7tKOPbOyxBwd
        A2CoKC/TqexuuhGvp62eh3K/FkSGbUpPtWfJM7Q8WOHWgpjlmaSUOJRn9OKafa1k8qdnjW
        t4yKDvi7JUiI9afyU16poZuHMUoIIU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673261957;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0zum01+6W6CWGMuMAoT/HPm/pZWcmXb0ZmN9Mhpgb7I=;
        b=i8nH3Nw8dN1tGgWZlu3bylvucdc8gG2H7zcFWPr66gE2yEASNbya0Ohs/HqWFhRbPegPeF
        LQGbI2DPoix2hhAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 561CC134AD;
        Mon,  9 Jan 2023 10:59:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 337/FIXzu2ORLwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 09 Jan 2023 10:59:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D8AE9A0749; Mon,  9 Jan 2023 11:59:16 +0100 (CET)
Date:   Mon, 9 Jan 2023 11:59:16 +0100
From:   Jan Kara <jack@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jan Kara <jack@suse.cz>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Jinke Han <hanjinke.666@bytedance.com>, josef@toxicpanda.com,
        axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com
Subject: Re: [PATCH v3] blk-throtl: Introduce sync and async queues for
 blk-throtl
Message-ID: <20230109105916.jvnhjdseqkwejmws@quack3>
References: <20221226130505.7186-1-hanjinke.666@bytedance.com>
 <20230105161854.GA1259@blackbody.suse.cz>
 <20230106153813.4ttyuikzaagkk2sc@quack3>
 <Y7hTHZQYsCX6EHIN@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7hTHZQYsCX6EHIN@slm.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello!

On Fri 06-01-23 06:58:05, Tejun Heo wrote:
> Hello,
> 
> On Fri, Jan 06, 2023 at 04:38:13PM +0100, Jan Kara wrote:
> > Generally, problems are this are taken care of by IO schedulers. E.g. BFQ
> > has quite a lot of logic exactly to reduce problems like this. Sync and
> > async queues are one part of this logic inside BFQ (but there's more).
> 
> With modern ssd's, even deadline's overhead is too high and a lot (but
> clearly not all) of what the IO schedulers do are no longer necessary. I
> don't see a good way back to elevators.

Yeah, I agree there's no way back :). But actually I think a lot of the
functionality of IO schedulers is not needed (by you ;)) only because the
HW got performant enough and so some issues became less visible. And that
is all fine but if you end up in a configuration where your cgroup's IO
limits and IO demands are similar to how the old rotational disks were
underprovisioned for the amount of IO needed to be done by the system
(i.e., you can easily generate amount of IO that then takes minutes or tens
of minutes for your IO subsystem to crunch through), you hit all the same
problems IO schedulers were trying to solve again. And maybe these days we
incline more towards the answer "buy more appropriate HW / buy higher
limits from your infrastructure provider" but it is not like the original
issues in such configurations disappeared.

> > But given current architecture of the block layer IO schedulers are below
> > throttling frameworks such as blk-throtl so they have no chance of
> > influencing problems like this. So we are bound to reinvent the scheduling
> > logic IO schedulers are already doing. That being said I don't have a good
> > solution for this or architecture suggestion. Because implementing various
> > throttling frameworks within IO schedulers is cumbersome (complex
> > interactions) and generally the perfomance is too slow for some usecases.
> > We've been there (that's why there's cgroup support in BFQ) and really
> > the current architecture is much easier to reason about.
> 
> Another layering problem w/ controlling from elevators is that that's after
> request allocation and the issuer has already moved on. We used to have
> per-cgroup rq pools but ripped that out, so it's pretty easy to cause severe
> priority inversions by depleting the shared request pool, and the fact that
> throttling takes place after the issuing task returned from issue path makes
> propagating the throttling operation upwards more challenging too.

Well, we do have .limit_depth IO scheduler callback these days so BFQ uses
that to solve the problem of exhaustion of shared request pool but I agree
it's a bit of a hack on the side.

> At least in terms of cgroup control, the new bio based behavior is a lot
> better. In the fb fleet, iocost is deployed on most (virtually all) of the
> machines and we don't see issues with severe priority inversions.
> Cross-cgroup control is pretty well controlled. Inside each cgroup, sync
> writes aren't prioritized but nobody seems to be troubled by that.
> 
> My bet is that inversion issues are a lot more severe with blk-throttle
> because it's not work-conserving and not doing things like issue-as-root or
> other measures to alleviate issues which can arise from inversions.

Yes, I agree these features of blk-throttle make the problems much more
likely to happen in practice.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
