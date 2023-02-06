Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD5868C108
	for <lists+cgroups@lfdr.de>; Mon,  6 Feb 2023 16:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjBFPKg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 10:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjBFPKf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 10:10:35 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F0F8A56;
        Mon,  6 Feb 2023 07:10:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1CAA5605F9;
        Mon,  6 Feb 2023 15:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675696233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sd5nDRHXJk++5A7W1c8QOz1iQG/3lZICXPVElgOmb6Y=;
        b=ThcOtschhlpEv1GvXgf49lGKS1ihus3Qw82rT2rJff2mbZ0TtKu1oxMV3OVvBaZBvjqWzU
        otCZwlDmUyqwx4FPNSP6bA2xRMz0PlsZXQQzMPIKQg2O1UqclWhVr+KStARpiwPvBq94v3
        ltYSws6YThw4EeL7+pbVF24NHIzvVz8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E98DF138E8;
        Mon,  6 Feb 2023 15:10:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8hIhOGgY4WMXYgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 06 Feb 2023 15:10:32 +0000
Date:   Mon, 6 Feb 2023 16:10:31 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Tejun Heo <tj@kernel.org>, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH -next] blk-throttle: enable io throttle for root in
 cgroup v2
Message-ID: <20230206151031.GB21332@blackbody.suse.cz>
References: <20220114093000.3323470-1-yukuai3@huawei.com>
 <YfGE9L4i7DtNTo08@slm.duckdns.org>
 <235b0757-d322-2b6e-3ab6-ecc8c82f8f1e@huawei.com>
 <Yflr4FzUTWsiLTC/@slm.duckdns.org>
 <32b6949d-60b1-82ce-ae44-1cf089a78276@huawei.com>
 <YgK7J8TFyFvp/rv1@slm.duckdns.org>
 <34ae7d06-4f6b-73f7-7299-65cb8859aad8@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline
In-Reply-To: <34ae7d06-4f6b-73f7-7299-65cb8859aad8@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Kuai.

On Wed, Feb 09, 2022 at 09:22:30AM +0800, "yukuai (C)" <yukuai3@huawei.com> wrote:
> Do you agree that the server can't control how many io it can receives
> from one client if we limit from server? I think the difference is that
> limit from client can control it...

(Perhaps it depends on the protocol used for the IO but) eventually
client requests would be noticably lost/dropped and that's how the
server propagates the requested control onto the clients without relying
on the clients throttling themselves.

(Maybe better place to implement this would be a "testing" device mapper
target akin to the 'delay' one.)

Regards,
Michal

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY+EYZQAKCRAkDQmsBEOq
uYmjAPsG5BcOsvviZP85LUOSIeXHZpkSx9/T2c2MgnKfcze59AD6A67gBQWTt2pC
/s80tllQKtomn3NTxSWL5rdz+oehegI=
=d/38
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
