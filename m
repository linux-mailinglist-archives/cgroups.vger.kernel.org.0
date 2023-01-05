Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D7665F471
	for <lists+cgroups@lfdr.de>; Thu,  5 Jan 2023 20:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbjAET31 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Jan 2023 14:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbjAET24 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Jan 2023 14:28:56 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A7F392F4;
        Thu,  5 Jan 2023 11:23:56 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CC3FB22A9F;
        Thu,  5 Jan 2023 19:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672946568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mg38u8VDBZl2kUeOIq51W5k4gswYU2BaFcdprzVD4ho=;
        b=Pl5Grl6tSEVdgCpRGyl9PaXajNlIjlsYnWLjdUuBJ9XyAdWiXq6MEejzoZsxIUDGG6j+fT
        lc67hk77bkVQlX0KMffLrClAfSEboithD4tgcYWrNKrRvGSfxo21bcE0CZXZWhS7vnheSM
        E7b9KRVkcC/0SIePI5VNChHJAIe2xCE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97374138DF;
        Thu,  5 Jan 2023 19:22:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bo3iI4gjt2N2EwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 05 Jan 2023 19:22:48 +0000
Date:   Thu, 5 Jan 2023 20:22:47 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jinke Han <hanjinke.666@bytedance.com>, josef@toxicpanda.com,
        axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jack@suse.cz
Subject: Re: [PATCH v3] blk-throtl: Introduce sync and async queues for
 blk-throtl
Message-ID: <20230105192247.GB16920@blackbody.suse.cz>
References: <20221226130505.7186-1-hanjinke.666@bytedance.com>
 <20230105161854.GA1259@blackbody.suse.cz>
 <Y7cKf7IH+FJ/6IyV@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Content-Disposition: inline
In-Reply-To: <Y7cKf7IH+FJ/6IyV@slm.duckdns.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 05, 2023 at 07:35:59AM -1000, Tejun Heo <tj@kernel.org> wrote:
> Hard limits tend to make this sort of problems a lot more pronounced because
> the existing mechanisms tend to break down for the users which are severely
> throttled down even while the device as a whole is fairly idle. cpu.max
> often triggers severe priority inversions too, so it isn't too surprising
> that people hit severe priority inversion issues w/ io.max.

To be on the same page:
1) severe PI == priority inversion across cgroups (progated e.g. via
   global locks (as with cpu.max) or FS journal (as with io.max)),
2) ordinary PI == priority inversion contained within a single cgroup,
   i.e. no different from an under-provisioned system.

The reported issue sounds like 2) but even with the separated queues 1)
is still possible :-/

> Another problem with blk-throttle is that it doesn't prioritize shared IOs
> identified by bio_issue_as_root_blkg() like iolatency and iocost do, so
> there can be very severe priority inversions when e.g. journal commit gets
> trapped in a low priority cgroup further exacerbating issues like this.

Thanks for the broader view. So the separated queues are certainly an
improvement but ultimately a mechanism based on bio_issue_as_root_blkg()
predicate and deferred throttling would be better? Or is permanent limit
enforcement more important?

Thanks,
Michal

--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY7cjfQAKCRAkDQmsBEOq
uXQsAP99LZP7f/n8ygASlLevHgj9Zm/D5kI8jlxOD2LanjzNzQD+JY4fvNFnGQmI
edy1iZb/lxGcHMME7EZPqkuZJbXbcw4=
=w2/G
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
