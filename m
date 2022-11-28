Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9970463AA77
	for <lists+cgroups@lfdr.de>; Mon, 28 Nov 2022 15:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiK1OHJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Nov 2022 09:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbiK1OGl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Nov 2022 09:06:41 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB43421E0F;
        Mon, 28 Nov 2022 06:06:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9A4EC21B8A;
        Mon, 28 Nov 2022 14:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669644392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4yiwoI9xze/bvvYsQ6MdgjViodw7i3sVy+Mfdib+hi0=;
        b=dM+RRQP85j6tCnpaeFC6IaoAklNnGvuffWFKJCeG/G+4EVXC4waWkZ6Qbbc3+ljra+mvqK
        Y7jNhIgPc3fN/05T7T7h1Y1lvX4s+E98o9CtW3twrDcT0FELzQ5gpg4vlgnK+8CII3vvWr
        4Cw2A8QF/ST9FcbYnmZGQCWjPfJoMrQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 623B81326E;
        Mon, 28 Nov 2022 14:06:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mxgUF2jAhGMjGwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 28 Nov 2022 14:06:32 +0000
Date:   Mon, 28 Nov 2022 15:06:31 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH-block] blk-cgroup: Use css_tryget() in
 blkcg_destroy_blkgs()
Message-ID: <20221128140631.GI25160@blackbody.suse.cz>
References: <20221128033057.1279383-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tSiBuZsJmMXpnp7T"
Content-Disposition: inline
In-Reply-To: <20221128033057.1279383-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--tSiBuZsJmMXpnp7T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Sun, Nov 27, 2022 at 10:30:57PM -0500, Waiman Long <longman@redhat.com> wrote:
> That may not be true if there is no blkg associated with the blkcg. If
> css_get() fails, the subsequent css_put() call may lead to data
> corruption as was illustrated in a test system that it crashed on
> bootup when that commit was included.

Do you have a stacktrace of the underflowing css_put() in
blkcg_destroy_blkgs()?

It looks to me slightly as a mistake of the caller site that it passes
struct blkcg * without any references.

By a cursory look, could it be cgwb_release_workfn?

--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -390,11 +390,11 @@ static void cgwb_release_workfn(struct work_struct *work)
        wb_shutdown(wb);

        css_put(wb->memcg_css);
-       css_put(wb->blkcg_css);
        mutex_unlock(&wb->bdi->cgwb_release_mutex);

        /* triggers blkg destruction if no online users left */
        blkcg_unpin_online(wb->blkcg_css);
+       css_put(wb->blkcg_css);

        fprop_local_destroy_percpu(&wb->memcg_completions);

Does your crash involve this stack?

Thanks,
Michal

--tSiBuZsJmMXpnp7T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY4TAZQAKCRAkDQmsBEOq
uS+5AP97cFglT6cqH0lX6xHLHlFTnlz0R8/2eiUTZc7t+UMIAAEAx44DeExOpRjE
QcJ6UH59lXEoD6kvkW4qmcP6+AWHTAA=
=jz60
-----END PGP SIGNATURE-----

--tSiBuZsJmMXpnp7T--
