Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2577978E5
	for <lists+cgroups@lfdr.de>; Thu,  7 Sep 2023 18:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245019AbjIGQ6R (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Sep 2023 12:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245042AbjIGQ6R (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Sep 2023 12:58:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA2D1BF2;
        Thu,  7 Sep 2023 09:57:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AF3D421866;
        Thu,  7 Sep 2023 15:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694102248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UnG3kyHx/yySq1uQAqm63aAFoe+tK7nrYedgBgmw3Sk=;
        b=qNG59kr3JPMUSa7aErahyZeWVgBZ/LFmTUWjofl1Ge+sd8TgCYFmeGfGN+Mcm7CcLguLwN
        /dOcb3nSK9p7Tw6Q1dzdWC6bpyE8JLbQiNbaE7ObOW/zO5WOkvPGP+GQuE3b6/fOFgykRw
        GnvMh13oE1m8dySb2Ffu6QFcmZbX4EI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8EAFA138FA;
        Thu,  7 Sep 2023 15:57:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RqwvIujy+WRcDgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 07 Sep 2023 15:57:28 +0000
Date:   Thu, 7 Sep 2023 17:57:27 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Luiz Capitulino <luizcap@amazon.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        longman@redhat.com, lcapitulino@gmail.com
Subject: Re: [PATH v2] cgroup: add cgroup_favordynmods= command-line option
Message-ID: <zqgnootbsjyj7wq5ayiallz4m2bz7ad6w67t24peglhc5v6ern@4pfqlshgpnie>
References: <20230906005712.66461-1-luizcap@amazon.com>
 <lqcl5cblo3s45afvtgqjkbz2an3zwccsckglhpe3ufyffqavjk@ui45m6itz4ne>
 <236f84be-26b0-758d-3d3f-380e536f72c2@amazon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ibi6d2k6h7vappp"
Content-Disposition: inline
In-Reply-To: <236f84be-26b0-758d-3d3f-380e536f72c2@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--7ibi6d2k6h7vappp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 07, 2023 at 11:16:41AM -0400, Luiz Capitulino <luizcap@amazon.c=
om> wrote:
> Yeah, this works for cgroup v2 but my understanding is that cgroup v1
> doesn't support changing flags in remount, take a look at
> cgroup1_reconfigure().

Ah, didn't notice.
Alhtough -- there seems to be a deeper issue -- the mount option doesn't
have a per-root semantics. There is only a single
cgroup_threadgroup_rwsem afterall.

Even with your cmdline option, you may loose the behavior after
unmounting any of the v1 hierarchies (cgroup_destroy_root()
unconditionally disables it).

Or you could still achieve the result by mounting cgroup2 hierarchy with
favordynmods. (And unmount it, default root is not ever released.)

Maybe it would be the best to have this controllable only via v2
hierarchy (as it's the only documented).
(And maybe v1s should not show the option at all.)

My 0.02=E2=82=AC,
Michal

--7ibi6d2k6h7vappp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZPny4gAKCRAGvrMr/1gc
jqjdAQCR/eGLDLOEDNOiaj8HrKSt34AoCZ11IrxIBd136Vqe0gD9FLcG+ak0oijQ
u/PovQBg+jQA2Hax7qFMyjarQs33IwQ=
=BLiB
-----END PGP SIGNATURE-----

--7ibi6d2k6h7vappp--
