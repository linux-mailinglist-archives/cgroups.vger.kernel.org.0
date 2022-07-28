Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71657583B47
	for <lists+cgroups@lfdr.de>; Thu, 28 Jul 2022 11:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbiG1Jdv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Jul 2022 05:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbiG1Jdt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Jul 2022 05:33:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142A461D97;
        Thu, 28 Jul 2022 02:33:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C0E3B209AA;
        Thu, 28 Jul 2022 09:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659000827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SB6tJ4z7ixYCC4m5qWSYZT9XjUVOUuyqFKcfB92kx20=;
        b=hRehc4W65y4S7gZEYw54uweayg3E0ArpqGQbQyLN0cKr7UkMOcM3LGxp1AJoL2gltZtfYf
        9/67Du5A+am+IryU8wF2FrkwkiQm/O6/BS34np2EarxFoT4CF1HfFJuklyvvIzMp0NoZiW
        cTWD9/HFZfvIDiF+6tNyd0lEkZR0wfI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9058713A7E;
        Thu, 28 Jul 2022 09:33:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yCdBIvtX4mLxUAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 28 Jul 2022 09:33:47 +0000
Date:   Thu, 28 Jul 2022 11:33:46 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
        ming.lei@redhat.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH RESEND v6 4/8] blk-throttle: fix io hung due to config
 updates
Message-ID: <20220728093346.GA2281@blackbody.suse.cz>
References: <20220701093441.885741-1-yukuai1@huaweicloud.com>
 <20220701093441.885741-5-yukuai1@huaweicloud.com>
 <YuGGVxdlOVk/eF2l@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <YuGGVxdlOVk/eF2l@slm.duckdns.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 27, 2022 at 08:39:19AM -1000, Tejun Heo <tj@kernel.org> wrote:
> I'm not quiet sure this is correct. What if the limit keeps changing across
> different values? Then we'd be calculating the skipped amount based on the
> last configuration only which would be incorrect.

When one change of configuration is correct, then all changes must be
correct by induction. It's sufficient to take into account only the one
old config and the new one.

This __tg_update_skipped() calculates bytes_skipped with the limit
before the change and bytes_skipped are used (divided by) the new limit
in tg_with_in_bps_limit().
The accumulation of bytes_skipped across multiple changes (until slice
properly ends) is proportional to how bytes_allowed would grow over
time.
That's why I find this correct (I admit I had to look back into my
notes when this was first discussed).

HTH,
Michal

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCYuJX3wAKCRAkDQmsBEOq
uen2AP9DlRReKs7tBs0MfsBYoy0j+l23U/bpUzVeRFefU6hqBQD/dwu4UjPCbCwb
oYbP30IoXD0s6tsiKY9PSyDBkf1xMAU=
=r1c9
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
