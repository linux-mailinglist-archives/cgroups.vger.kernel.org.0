Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880A363D90B
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 16:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiK3PQo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 10:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiK3PQo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 10:16:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC4C2FA69;
        Wed, 30 Nov 2022 07:16:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1D5C0218DF;
        Wed, 30 Nov 2022 15:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669821401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ATM8wuEZO4F8LmfuabnM5oV4K3RnnbDMeyDmwCZSpdY=;
        b=j6xq7JSq+Wr3SnG8eqNE+ECS5hPr743xQ5eo4n+UP7l3stds48QDvKwIiUHdHLnjAe5FLh
        i3ipUvJUniXllps7G5UVsQKq8e4auYqUEEFMQ/03zLcVsv9A4c4d2v2B6rezUF+XYnSfwU
        8/nlKl2px4rsGu4yjPnAuTS9c0Ex8fE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C987F1331F;
        Wed, 30 Nov 2022 15:16:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tYxQMNhzh2MWGwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 30 Nov 2022 15:16:40 +0000
Date:   Wed, 30 Nov 2022 16:16:39 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH-block v2] bdi, blk-cgroup: Fix potential UAF of blkcg
Message-ID: <20221130151639.GE27838@blackbody.suse.cz>
References: <20221129203400.1456100-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="T6xhMxlHU34Bk0ad"
Content-Disposition: inline
In-Reply-To: <20221129203400.1456100-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--T6xhMxlHU34Bk0ad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 29, 2022 at 03:34:00PM -0500, Waiman Long <longman@redhat.com> =
wrote:
> The reproducing system can no longer produce a warning with this patch.
> All the runnable block/0* tests including block/027 were run successfully
> without failure.

Thanks for the test!

> @@ -1088,7 +1088,15 @@ static void blkcg_destroy_blkgs(struct blkcg *blkc=
g)
> =20
>  	might_sleep();
> =20
> -	css_get(&blkcg->css);
> +	/*
> +	 * blkcg_destroy_blkgs() shouldn't be called with all the blkcg
> +	 * references gone and rcu_read_lock not held.
> +	 */
> +	if (!css_tryget(&blkcg->css)) {
> +		WARN_ON_ONCE(!rcu_read_lock_held());
> +		return;
> +	}

As I followed the previous discussion, the principle is that obtaining a
reference or being inside an RCU read section is sufficient.

Consequently, I'd expect the two situations handled equally but here the
no-ref but RCU bails out. (Which is OK because blkg_list must be empty?)

However, the might_sleep() in (non-sleepable) RCU reader section combo
makes me wary anyway (not with the early return but tools would likely
complain).

All in all, can't the contract of blkcg_destroy_blkgs() declare that
a caller must pass blkcg with a valid reference? (The body of
blkcg_destroy_blkgs then wouldn't need to get neither put the inner
reference).

HTH,
Michal

--T6xhMxlHU34Bk0ad
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY4dzxgAKCRAkDQmsBEOq
ua6MAQCYfYVZAsH1NgOid00l0b52FcccC2/s0ITlu8jm7ZQs6wEAhKRvdwKu6lsC
VQgfYht9U8f+lQdK562Fh/ONyn6DzQw=
=M1ug
-----END PGP SIGNATURE-----

--T6xhMxlHU34Bk0ad--
