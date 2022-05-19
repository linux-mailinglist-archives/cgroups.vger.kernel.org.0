Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95C952D9DD
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 18:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241829AbiESQKf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 May 2022 12:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236393AbiESQKa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 12:10:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FBAA0D1A;
        Thu, 19 May 2022 09:10:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2C9BC21B9D;
        Thu, 19 May 2022 16:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652976628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x8EKRxmOXRG1OntBeojKu9rfDE0STl30IvsPB4f27xM=;
        b=FvquVMKKbnG9WotMztePck6/FwQq4FjESGMn7k+sPiYOrB61HTiUNSyKuQbM6KDVBd3L7E
        P1mqYgInGDeml0YiecNbihAYmJgyK+ad8ThsMlVr6+CN+SmssV2GibwMvxYYEzOZq4AMMW
        lTHEpZipYrA6FQSu2THAoTaRGuhf4kM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC72913AF8;
        Thu, 19 May 2022 16:10:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RtTZOPNrhmKEdQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 19 May 2022 16:10:27 +0000
Date:   Thu, 19 May 2022 18:10:26 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     tj@kernel.org, axboe@kernel.dk, ming.lei@redhat.com,
        geert@linux-m68k.org, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next v3 2/2] blk-throttle: fix io hung due to
 configuration updates
Message-ID: <20220519161026.GG16096@blackbody.suse.cz>
References: <20220519085811.879097-1-yukuai3@huawei.com>
 <20220519085811.879097-3-yukuai3@huawei.com>
 <20220519095857.GE16096@blackbody.suse.cz>
 <a8953189-af42-0225-3031-daf61347524a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8953189-af42-0225-3031-daf61347524a@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 19, 2022 at 08:14:28PM +0800, "yukuai (C)" <yukuai3@huawei.com> wrote:
> tg_with_in_bps_limit:
>  jiffy_elapsed_rnd = jiffies - tg->slice_start[rw];
>  tmp = bps_limit * jiffy_elapsed_rnd;
>  do_div(tmp, HZ);
>  bytes_allowed = tmp; -> how many bytes are allowed in this slice,
> 		         incluing dispatched.
>  if (tg->bytes_disp[rw] + bio_size <= bytes_allowed)
>   *wait = 0 -> no need to wait if this bio is within limit
> 
>  extra_bytes = tg->bytes_disp[rw] + bio_size - bytes_allowed;
>  -> extra_bytes is based on 'bytes_disp'
> 
> For example:
> 
> 1) bps_limit is 2k, we issue two io, (1k and 9k)
> 2) the first io(1k) will be dispatched, bytes_disp = 1k, slice_start = 0
>    the second io(9k) is waiting for (9 - (2 - 1)) / 2 = 4 s

The 2nd io arrived at 1s, the wait time is 4s, i.e. it can be dispatched
at 5s (i.e. 10k/*2kB/s = 5s).

> 3) after 3 s, we update bps_limit to 1k, then new waiting is caculated:
> 
> without this patch:  bytes_disp = 0, slict_start =3:
> bytes_allowed = 1k	                            <--- why 1k and not 0?
> extra_bytes = 9k - 1k = 8k
> wait = 8s

This looks like it was calculated at time 4s (1s after new config was
set).

> 
> whth this patch: bytes_disp = 0.5k, slice_start =  0,
> bytes_allowed = 1k * 3 + 1k = 4k
> extra_bytes =  0.5k + 9k - 4k = 5.5k
> wait = 5.5s

This looks like calculated at 4s, so the IO would be waiting till
4s+5.5s = 9.5s.

As I don't know why using time 4s, I'll shift this calculation to the
time 3s (when the config changes):

bytes_disp = 0.5k, slice_start =  0,
bytes_allowed = 1k * 3  = 3k
extra_bytes =  0.5k + 9k - 3k = 7.5k
wait = 7.5s

In absolute time, the IO would wait till 3s+7.5s = 10.5s

OK, either your 9.5s or my 10.5s looks weird (although earlier than
original 4s+8s=12s).
However, the IO should ideally only wait till

    3s + (9k -   (6k    -    1k)     ) / 1k/s =
         bio - (allowed - dispatched)  / new_limit

   =3s + 4k / 1k/s = 7s

   ('allowed' is based on old limit)

Or in another example, what if you change the config from 2k/s to ∞k/s
(unlimited, let's neglect the arithmetic overflow that you handle
explicitly, imagine a big number but not so big to be greater than
division result).

In such a case, the wait time should be zero, i.e. IO should be
dispatched right at the time of config change.
(With your patch that still calculates >0 wait time (and the original
behavior gives >0 wait too.)

> I hope I can expliain it clearly...

Yes, thanks for pointing me to relevant parts.
I hope I grasped them correctly.

IOW, your patch and formula make the wait time shorter but still IO can
be delayed indefinitely if you pass a sequence of new configs. (AFAIU)

Regards,
Michal
