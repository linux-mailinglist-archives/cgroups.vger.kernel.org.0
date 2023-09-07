Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF987973A4
	for <lists+cgroups@lfdr.de>; Thu,  7 Sep 2023 17:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjIGP2w (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Sep 2023 11:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242498AbjIGPYs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Sep 2023 11:24:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919AF1BCA;
        Thu,  7 Sep 2023 08:24:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 69FCF1F8B3;
        Thu,  7 Sep 2023 15:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694099209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jlk2aVZRvC2y/qKDlLstKtfgf2Vh9rUftT3QduXr7LQ=;
        b=og32zLaWxL+nBMJpNev005pWzlZ8xcaftNekvoDckFB9fNls3DMj51BpD/mL6rsum2WDqk
        NI5Ut9JSRIAYoaRE1XOVzik/fl02jwg7IJvJk3CEKtKN+eWkxj2NTEZTnXLanV5OO58CH1
        eIfOHGCTdrycY4aDYbYpUKJ3cccECMM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D716138FA;
        Thu,  7 Sep 2023 15:06:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qo7GDQnn+WRNcgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 07 Sep 2023 15:06:49 +0000
Date:   Thu, 7 Sep 2023 17:06:48 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Luiz Capitulino <luizcap@amazon.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        longman@redhat.com, lcapitulino@gmail.com
Subject: Re: [PATH v2] cgroup: add cgroup_favordynmods= command-line option
Message-ID: <lqcl5cblo3s45afvtgqjkbz2an3zwccsckglhpe3ufyffqavjk@ui45m6itz4ne>
References: <20230906005712.66461-1-luizcap@amazon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fb522kinagxi363h"
Content-Disposition: inline
In-Reply-To: <20230906005712.66461-1-luizcap@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--fb522kinagxi363h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 06, 2023 at 12:57:12AM +0000, Luiz Capitulino <luizcap@amazon.com> wrote:
> We have a need of using favordynmods with cgroup v1, which doesn't support
> changing mount flags during remount. Enabling CONFIG_FAVOR_DYNMODS at
> build-time is not an option because we want to be able to selectively
> enable it for certain systems.

Could this be implemented by a utility that would read /proc/cmdline
(while kernel ignores the arg) and remount respective hierarchies
accordingly? Or what do I miss?

Thanks,
Michal

--fb522kinagxi363h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZPnnBQAKCRAGvrMr/1gc
jkAPAP97oDuOi9qLFPYmLAYQvF0zxgwO1uM7BUMdlLfLcLl5cQEAqUN0ZTNPFM6f
W8z+8KTpA6lbp2Cn/PVij8rH1I/V3wA=
=YGWh
-----END PGP SIGNATURE-----

--fb522kinagxi363h--
