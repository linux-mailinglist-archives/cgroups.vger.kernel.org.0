Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74F86F91A9
	for <lists+cgroups@lfdr.de>; Sat,  6 May 2023 13:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjEFLon (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 6 May 2023 07:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjEFLok (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 6 May 2023 07:44:40 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3268A51
        for <cgroups@vger.kernel.org>; Sat,  6 May 2023 04:44:38 -0700 (PDT)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 686593F457
        for <cgroups@vger.kernel.org>; Sat,  6 May 2023 11:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683373476;
        bh=LHpyysAD0KT29d8ObzyF//DXpS+COhpwRCE79w2kL7U=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=qQKY/TVz6NbLNXDX1WAg0MuJP6K37kRnAsMAb1lUYLoUwrOodJDM50s2EpKrbN9LF
         cL1sNDwhvA40upc7fVVuph/xdcdM/yp14UpxsiZcKiJT/w9ZZ1qUZeAydvb3EN7s8+
         WAOdYD1VCHHhPKSJOS+zPRaYJz11TGiEsNwrk70QPc0cYGNTBBjbaAyuq4VnP6eZSG
         7s2+v+X4Wt0ccbWfirKhsREpaV6OC1+TLNEnYZRStz8CVnRt13dfAT+ZZoz8rXXBL4
         kJivIi36fVuCJisSWwlK6rjjNL12LU5wYr9kU68lfxRFMxn2GpFvHej9pnfJE1+Ai1
         76/rpEbL/NbXg==
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30634323dfeso986995f8f.3
        for <cgroups@vger.kernel.org>; Sat, 06 May 2023 04:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683373476; x=1685965476;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LHpyysAD0KT29d8ObzyF//DXpS+COhpwRCE79w2kL7U=;
        b=HlWbPuHXUr9PXUj9/Kn8eM+K9TyNkiEaPGK8Gf+F56YhCkvqxcZ6N7dPxB9SodaBiJ
         eHqjZiF3pUyqTEE3gTGiiZjzz/bYzkSiKfPEq1W74LSwcEmrsT8lBJv1SZ3JiJKnGY5s
         3hZjofflMkYC2ntGA+yKQ3Lbg0mAt00sgO6/8Z62/Bc6harmMjf0kpP1UE+99MSLC7zv
         VYvHQgMAuJbCqv0xTwNF5g/5EDqsWGGNYs3kmsKsE9arBEvDeA/DIpOTgcpHECpZPL6j
         4Olzo9nQPUTRgTQytCpeGmqLv7c4bgP97m2TXLQBXIOA3eTSrsXCRFnwYnx8nDEjcs+9
         la2g==
X-Gm-Message-State: AC+VfDxzxIap7ha6KU7A678Xfq1UBsHhgDpJ8PMH1jxXJQ6dw/weYLbj
        BhOaVmieiJ7MXSIFLlS5JGfWaF5zTqtN8f+uyFmRau+YjhAhOFG26LmBQTbIhjfbLrGQpOl7B8X
        8ZvbFfEOqgRasYhy6bCEAreaGnygFIbK2oOR8m2XwJSrnnQ==
X-Received: by 2002:adf:f749:0:b0:306:334a:7f1a with SMTP id z9-20020adff749000000b00306334a7f1amr3442075wrp.20.1683373475876;
        Sat, 06 May 2023 04:44:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7fS+3eezw9LWaSBGoAgJpRtT4d4jntY60FCm2jiHccNAAsF1wxMTeJ5iuPJqIZ2mFP4qzDSg==
X-Received: by 2002:adf:f749:0:b0:306:334a:7f1a with SMTP id z9-20020adff749000000b00306334a7f1amr3442067wrp.20.1683373475586;
        Sat, 06 May 2023 04:44:35 -0700 (PDT)
Received: from localhost ([151.82.128.252])
        by smtp.gmail.com with ESMTPSA id a11-20020adfeecb000000b003048477729asm5170198wrp.81.2023.05.06.04.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 04:44:35 -0700 (PDT)
Date:   Sat, 6 May 2023 13:44:33 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     hanjinke <hanjinke.666@bytedance.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH v2] blk-throttle: Fix io statistics for
 cgroup v1
Message-ID: <ZFY9ocCi2EPU3Cu3@righiandr-XPS-13-7390>
References: <20230401094708.77631-1-hanjinke.666@bytedance.com>
 <ZEwY5Oo+5inO9UFf@righiandr-XPS-13-7390>
 <eb2eeb6b-07da-4e98-142c-da1e7ea35c2b@bytedance.com>
 <ZFQf3TCs7DqsSR8l@righiandr-XPS-13-7390>
 <6696100e-e838-d96a-2894-bbca9783d2a3@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6696100e-e838-d96a-2894-bbca9783d2a3@bytedance.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 05, 2023 at 09:35:21PM +0800, hanjinke wrote:
> 
> 
> 在 2023/5/5 上午5:13, Andrea Righi 写道:
> > On Thu, May 04, 2023 at 11:08:53PM +0800, hanjinke wrote:
> > > Hi
> > > 
> > > Sorry for delay（Chinese Labor Day holiday).
> > 
> > No problem, it was also Labor Day in Italy. :)
> > 
> > > 
> > > 在 2023/4/29 上午3:05, Andrea Righi 写道:
> > > > On Sat, Apr 01, 2023 at 05:47:08PM +0800, Jinke Han wrote:
> > > > > From: Jinke Han <hanjinke.666@bytedance.com>
> > > > > 
> > > > > After commit f382fb0bcef4 ("block: remove legacy IO schedulers"),
> > > > > blkio.throttle.io_serviced and blkio.throttle.io_service_bytes become
> > > > > the only stable io stats interface of cgroup v1, and these statistics
> > > > > are done in the blk-throttle code. But the current code only counts the
> > > > > bios that are actually throttled. When the user does not add the throttle
> > > > > limit, the io stats for cgroup v1 has nothing. I fix it according to the
> > > > > statistical method of v2, and made it count all ios accurately.
> > > > > 
> > > > > Fixes: a7b36ee6ba29 ("block: move blk-throtl fast path inline")
> > > > > Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
> > > > 
> > > > Thanks for fixing this!
> > > > 
> > > > The code looks correct to me, but this seems to report io statistics
> > > > only if at least one throttling limit is defined. IIRC with cgroup v1 it
> > > > was possible to see the io statistics inside a cgroup also with no
> > > > throttling limits configured.
> > > > 
> > > > Basically to restore the old behavior we would need to drop the
> > > > cgroup_subsys_on_dfl() check, something like the following (on top of
> > > > your patch).
> > > > 
> > > > But I'm not sure if we're breaking other behaviors in this way...
> > > > opinions?
> > > > 
> > > >    block/blk-cgroup.c   |  3 ---
> > > >    block/blk-throttle.h | 12 +++++-------
> > > >    2 files changed, 5 insertions(+), 10 deletions(-)
> > > > 
> > > > diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> > > > index 79138bfc6001..43af86db7cf3 100644
> > > > --- a/block/blk-cgroup.c
> > > > +++ b/block/blk-cgroup.c
> > > > @@ -2045,9 +2045,6 @@ void blk_cgroup_bio_start(struct bio *bio)
> > > >    	struct blkg_iostat_set *bis;
> > > >    	unsigned long flags;
> > > > -	if (!cgroup_subsys_on_dfl(io_cgrp_subsys))
> > > > -		return;
> > > > -
> > > >    	/* Root-level stats are sourced from system-wide IO stats */
> > > >    	if (!cgroup_parent(blkcg->css.cgroup))
> > > >    		return;
> > > > diff --git a/block/blk-throttle.h b/block/blk-throttle.h
> > > > index d1ccbfe9f797..bcb40ee2eeba 100644
> > > > --- a/block/blk-throttle.h
> > > > +++ b/block/blk-throttle.h
> > > > @@ -185,14 +185,12 @@ static inline bool blk_should_throtl(struct bio *bio)
> > > >    	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
> > > >    	int rw = bio_data_dir(bio);
> > > > -	if (!cgroup_subsys_on_dfl(io_cgrp_subsys)) {
> > > > -		if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
> > > > -			bio_set_flag(bio, BIO_CGROUP_ACCT);
> > > > -			blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
> > > > -					bio->bi_iter.bi_size);
> > > > -		}
> > > > -		blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
> > > > +	if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
> > > > +		bio_set_flag(bio, BIO_CGROUP_ACCT);
> > > > +		blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
> > > > +				bio->bi_iter.bi_size);
> > > >    	}
> > > > +	blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
> > > 
> 
> I checked the code again. If we remove cgroup_subsys_on_dfl check here, io
> statistics will still be performed in the case of v2, which I think is
> unnecessary, and this information will be counted to
> io_service_bytes/io_serviced, these two files are not visible in v2. Am I
> missing something?

You are absolutely right. Sorry, I have just re-tested your fix and it
seems to handle the cgroup v1 case correctly, you can add my:

Tested-by: Andrea Righi <andrea.righi@canonical.com>

And we definitely need the cgroup_subsys_on_dfl() check, otherwise we'd
account extra IO in the v2 case that is not really needed.

Thanks,
-Andrea
