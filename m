Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DE170F015
	for <lists+cgroups@lfdr.de>; Wed, 24 May 2023 10:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239899AbjEXICX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 May 2023 04:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239155AbjEXICV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 May 2023 04:02:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB78A9E;
        Wed, 24 May 2023 01:02:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6BE741F896;
        Wed, 24 May 2023 08:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684915339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WqlOFgy8/FolADupE6AkHXzpXFhsTG20aogxrqmC9bo=;
        b=BMAQHwQ+haz+kQLroOOIGsgizMYwNwYD8kzZI6hAsngZzYKuB+I+0kHgf/PLLRbvr3XrM5
        eQ7foxYuTF3KprWqB30AgvgoKKtARBsTjTqpZ5tf5BKAwlKk739ir9Q/w6w0Mx/NkS3Ssb
        +z+6cG23iMD4wwFR4B2mYzb0aW3bP6Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C70313425;
        Wed, 24 May 2023 08:02:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PpXgEYvEbWQZUAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 24 May 2023 08:02:19 +0000
Date:   Wed, 24 May 2023 10:02:18 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH] cgroup: rstat: Simplified
 cgroup_base_stat_flush() update last_bstat logic
Message-ID: <remnwctqmxleig7ywt6puhxnpmzjo7xm6hlfhpnul46ulfnw7j@36sbuxhuatto>
References: <20230518124142.57644-1-jiahao.os@bytedance.com>
 <f39b9229-e59c-2b1c-7f3f-1aeedfad44dc@bytedance.com>
 <5g73i4yvi4ub4dqrf4dnq5qghkyckoygmgd2st6be3gg7twww2@w6zim6nxpt3b>
 <4d49f7e7-2488-9690-258e-34e617cfef6f@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ixixg2dethhn6gyp"
Content-Disposition: inline
In-Reply-To: <4d49f7e7-2488-9690-258e-34e617cfef6f@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--ixixg2dethhn6gyp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 24, 2023 at 02:54:10PM +0800, Hao Jia <jiahao.os@bytedance.com> wrote:
> Yes, so we need @curr to record the bstat value after the sequence fetch is
> completed.

No, I still don't see a problem that it solves. If you find incorrect
data being reported, please explain it more/with an example.

> Yes, but it may not be obvious.
> Another reason is that when we complete an update, we snapshot last_bstat as
> the current bstat, which is better for readers to understand. Arithmetics is
> somewhat obscure.

The readability here is subjective. It'd be interesting to have some
data comparing arithmetics vs copying though.

HTH,
Michal

--ixixg2dethhn6gyp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZG3EdwAKCRAkDQmsBEOq
uSG7AQCCqh0Ztm3AvJ/AD3CDMG7kdKSMWs1vPOT5JeHoYIeO+QD+Nf1Fd5xQzIvV
XFrpdN/nyCT6u8+MgTJtO0zv1YTPHgE=
=l5cB
-----END PGP SIGNATURE-----

--ixixg2dethhn6gyp--
