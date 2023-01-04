Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26C065D6ED
	for <lists+cgroups@lfdr.de>; Wed,  4 Jan 2023 16:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjADPMq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Jan 2023 10:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjADPMo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Jan 2023 10:12:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006721AA27;
        Wed,  4 Jan 2023 07:12:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7E0DA5205;
        Wed,  4 Jan 2023 15:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672845162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cK854pd9Zs98xPWzA1GXwHSTWLX/srzXjI6ZWiC477A=;
        b=cH+VtVgskkQNDth3N6NwWyDS9lN1sKVg8Vn/Qi8LKSu1lriebiOJim04EXndrnDvUNug7u
        +A76W+SQbvN0ieAmwxN+ZD5aH2sNPdMAOgFhd113uLs6EwGno5wQ1ez3+J0t1+MO1+bu1A
        0qb7mZ9ZapFiyIPvI9PzKB68szHUApk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 527081342C;
        Wed,  4 Jan 2023 15:12:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Qq1SE2qXtWOwaQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 04 Jan 2023 15:12:42 +0000
Date:   Wed, 4 Jan 2023 16:12:41 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] blk-cgroup: fix missing pd_online_fn() while activating
 policy
Message-ID: <20230104151241.GA13268@blackbody.suse.cz>
References: <20230103112833.2013432-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <20230103112833.2013432-1-yukuai1@huaweicloud.com>
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
Content-Transfer-Encoding: quoted-printable

Hello.

On Tue, Jan 03, 2023 at 07:28:33PM +0800, Yu Kuai <yukuai1@huaweicloud.com>=
 wrote:
> If the policy defines pd_online_fn(), it should be called after
> pd_init_fn(), like blkg_create().

Is this based only on code review or has it some negative effects?

I assume this would affect hot-plugged (read after cgroup creation) devices.

I took a cursory look at:

	blkcg_init_disk
	  blkg_create
	    pol->pd_init_fn(blkg->pd[i]);
	    pol->pd_online_fn(blkg->pd[i]);
	  blk_throtl_init
	    blkcg_activate_policy
	      pol->pd_init_fn(blkg->pd[i]);
	      ?? pol->pd_online_fn(blkg->pd[i]);

I.e. the pd_online_fn is already called and pd_init_fn is called 2nd
time?=20

Thanks,
Michal

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY7WXZwAKCRAkDQmsBEOq
uYzCAQCQJvItX+0rH8KzvN8r0AYCi6gTM5ah+aXAYQr8dUNElAD/e8CzXJ5O5Duv
Pv8irMcwqhh3xMyMa381dZ2QS/G2iAo=
=m4Pb
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
