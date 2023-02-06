Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1290B68C0D7
	for <lists+cgroups@lfdr.de>; Mon,  6 Feb 2023 16:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjBFPAK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 10:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBFPAJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 10:00:09 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2984C644;
        Mon,  6 Feb 2023 07:00:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 61EE73E968;
        Mon,  6 Feb 2023 15:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675695607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CHr5Q9e/qYSR9V7lQvVbstMTRujY37JvhtvhbDdNFhc=;
        b=enJco1GFYEfekNRXGEjHa1Y2bGfrnhXYglwlqDZW2Sv4Qk1qm0y4/4RCCjo+Xihi+IuVOA
        ePgWSGg1LBdHFyZfUnbe0cAI60zlC54RcqWcKG6Xrrc3Y8s61rAy4aQkl18x0CDEKO1L4L
        cUoroXDioBA0ZPiMfXdkUlPZrOoTikY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31B37138E8;
        Mon,  6 Feb 2023 15:00:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kZVBC/cV4WOAXAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 06 Feb 2023 15:00:07 +0000
Date:   Mon, 6 Feb 2023 16:00:05 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Ofir Gal <ofir.gal@volumez.com>
Cc:     ming.lei@redhat.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        tj@kernel.org, yi.zhang@huawei.com, yukuai3@huawei.com,
        Ofir Gal <ofir@gal.software>
Subject: Re: [PATCH -next] blk-throttle: enable io throttle for root in
 cgroup v2
Message-ID: <20230206150005.GA21332@blackbody.suse.cz>
References: <YgMxjyVjMjmkMQU5@T590>
 <20230205155541.1320485-1-ofir.gal@volumez.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20230205155541.1320485-1-ofir.gal@volumez.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 05, 2023 at 05:55:41PM +0200, Ofir Gal <ofir.gal@volumez.com> w=
rote:
> I have tried to limit the SSD on Server #1, but it seems that the NVME
> target kworkers are not affected unless I use Yu Kuai's patch.
>=20
> Can you elaborate on the issues with this patch or how the scenario
> described above can be done with cgroups v2?

The issue is that if there's a client that doesn't implement
self-throttling you cannot guarantee anything on the server side.
Hence the mechanism must exist on the server side.

The NVME target should charge IO to respective blkcg's (just a generic
advice, I'm not familiar with that interface; see also
kthread_associate_blkcg() use in loop device driver).

HTH,
Michal

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY+EV8wAKCRAkDQmsBEOq
uYzSAQC5yFq4obBPBxGW7dUITuiVPv6Svw5a8kySKrK/nZPGYAD+KRMo99VYj9Y2
xbYlmja7pXl+uBz41omMQ8YYSzDE2Ag=
=Ujhj
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
