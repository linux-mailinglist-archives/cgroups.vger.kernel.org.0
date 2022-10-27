Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F4260F1CE
	for <lists+cgroups@lfdr.de>; Thu, 27 Oct 2022 10:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbiJ0IGT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Oct 2022 04:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbiJ0IGF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Oct 2022 04:06:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F54963AB;
        Thu, 27 Oct 2022 01:06:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6ACE7228C3;
        Thu, 27 Oct 2022 08:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666857960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JB+ZwAH3tZeB/xLL4oPkxw2lhqsXmnM+w4yaMWPtXfA=;
        b=UxCwOG8iaQ5z0kR30Xhv+T+YgXM6Da+nA+OAxZkukpkX/xt782QOG0p80yV8edfcvjWAOL
        YugPs+pZEe4xBn0214wiJrQSxaZbfa5pwFugb+c/m8i4KNEaHrIJEEIsQH1S4qEpD4ki6N
        0M0k6hECJ0Jx2+OMwt5QhqrwViPFonw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 47069134CA;
        Thu, 27 Oct 2022 08:06:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X919EOg7WmNWNgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 27 Oct 2022 08:06:00 +0000
Date:   Thu, 27 Oct 2022 10:05:58 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     "haifeng.xu" <haifeng.xu@shopee.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: Simplify code in css_set_move_task
Message-ID: <20221027080558.GA23269@blackbody.suse.cz>
References: <20221020074701.84326-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <20221020074701.84326-1-haifeng.xu@shopee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Thu, Oct 20, 2022 at 07:47:01AM +0000, "haifeng.xu" <haifeng.xu@shopee.com> wrote:
> -	lockdep_assert_held(&css_set_lock);
> +	if (!cset || css_set_populated(cset))
> +		return;

1) the guard should be css_set_populated() ^ populated (when unsetting
the populated trait)

2) I'd keep the lockdep_assert_held() after it anyway.

Also the commit message should explain what's the reason to move
css_set_populated() after css_set_move_task().


Thanks,
Michal

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY1o75AAKCRAkDQmsBEOq
uXHDAQCOinrY1kFjcQOhAJCTkNGtfYQw8WGO+dSV9SKp6KVpKgD/aGGawMIRLY2k
sOu1Rbx6xA0c6ypKQLhvxZks/MOPuQU=
=pEmY
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
