Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBFB5F0B8A
	for <lists+cgroups@lfdr.de>; Fri, 30 Sep 2022 14:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiI3MTC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Sep 2022 08:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiI3MTB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Sep 2022 08:19:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293E117B53D;
        Fri, 30 Sep 2022 05:19:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D240C1F8E0;
        Fri, 30 Sep 2022 12:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664540338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BaGYgYOltcuFMagUnNo4H7/eNx7M5K3c/+7aHMYsQnk=;
        b=E5aIcQKedCKEd937mwLvNyq8KdU+SfVo36mF+OKdVSFEcOyCbGZIoQBiLQgU8di7R6vCVj
        MBYf8f8vxXuOKp35z4ezICExHFn0cHzFcuINkRCzkvbIsSZpfxDdV/EZP20Oiyz8pzBJKm
        M7fFXAH3FAXpaTH/YcnqAPtZlxKF6Aw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9ED7413677;
        Fri, 30 Sep 2022 12:18:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id y52eJbLeNmP0IwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 30 Sep 2022 12:18:58 +0000
Date:   Fri, 30 Sep 2022 14:18:56 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH] memcg: calling reclaim_high(GFP_KERNEL) in GFP_NOFS
 context deadlocks
Message-ID: <YzbesGeUkX3qwqj8@blackbook>
References: <20220929215440.1967887-1-david@fromorbit.com>
 <20220929222006.GI3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="33Qom3szwTZ9RgHI"
Content-Disposition: inline
In-Reply-To: <20220929222006.GI3600936@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--33Qom3szwTZ9RgHI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 30, 2022 at 08:20:06AM +1000, Dave Chinner <david@fromorbit.com> wrote:
> Fixes: b3ff92916af3 ("mm, memcg: reclaim more aggressively before high allocator throttling")

Perhaps you meant this instead?

Fixes: c9afe31ec443 ("memcg: synchronously enforce memory.high for large overcharges")

Thanks,
Michal

--33Qom3szwTZ9RgHI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCYzbejAAKCRAkDQmsBEOq
uV68AP9hdmCM6Vtov4cMYIgG++x22J/zOiQgKt35KYTsLOyL3gEAkryZGyGkaHFJ
SgTK9XCwM7Y010kO2jDfXgtyLUSNcAw=
=fG5j
-----END PGP SIGNATURE-----

--33Qom3szwTZ9RgHI--
