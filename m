Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3B9649F50
	for <lists+cgroups@lfdr.de>; Mon, 12 Dec 2022 14:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbiLLNBj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Dec 2022 08:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbiLLNBC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Dec 2022 08:01:02 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7131F13D06;
        Mon, 12 Dec 2022 04:59:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7BBA433801;
        Mon, 12 Dec 2022 12:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670849995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=95JjiZBzv65n1mXRBvbktBTBpXMKtPfhRGInuWjwgaw=;
        b=uuKDsqZWYBzL3/5EH0W9pudOuIMhaAq4/3TnbUS+als3ZaEvEGNa0OKuG9U915dTuE5nv1
        J5XsBEBbXnDawcj5Nq3kHSUgUEF8D/90UfElpXVAK76hhfcDZgzhMEyL+gJTA1bFhbruQ4
        4AB2Z5GtWCRgu6mh/wZqowW3cR1wTH4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A92B13456;
        Mon, 12 Dec 2022 12:59:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EbVZDcsll2P+EgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 12 Dec 2022 12:59:55 +0000
Date:   Mon, 12 Dec 2022 13:59:53 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: Re: [PATCH-block v2 2/3] blk-cgroup: Don't flush a blkg if destroyed
Message-ID: <20221212125953.GE16456@blackbody.suse.cz>
References: <20221211222058.2946830-1-longman@redhat.com>
 <20221211222058.2946830-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="11Y7aswkeuHtSBEs"
Content-Disposition: inline
In-Reply-To: <20221211222058.2946830-3-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Sun, Dec 11, 2022 at 05:20:57PM -0500, Waiman Long <longman@redhat.com> wrote:
> Before commit 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()"),
> blkg's stats is only flushed if they are online.

I'm not sure I follow -- css_release_work_fn/cgroup_rstat_flush may be
called on an offlined blkcg (offlined!=released). There's no invariant
ensuring offlined blkcg won't be flushed. (There is only current
situation when there is no reader of io data that'd need them flushed
[1].)

> In addition, the stat flushing of blkgs in blkcg_rstat_flush()
> includes propagating the rstat data to its parent. However, if a blkg
> has been destroyed (offline), the validity of its parent may be
> questionable.

Parents won't be freed (neither offlined) before children (see
css_killed_work_fn). It should be regularly OK to pass data into a
parent of an offlined blkcg.

> For safety, revert back to the old behavior by ignoring offline
> blkg's.

I don't know if this is a good reasoning. If you argue that offlined
children needn't be taken into parent's account, then I think it's more
efficient to exclude the offlined blkcgs from update. (With the caveat I
have in [1].)

Regards,
Michal

[1] https://lore.kernel.org/r/YqEfNgUc8jxlAq8D@blackbook/

--11Y7aswkeuHtSBEs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY5clxQAKCRAkDQmsBEOq
uSetAQCmnfBYSQWk5l/gfz/eBj+JLLtB5FF0vKwMUp7t6s2hdQEA/iF6GKtaE8D3
6UdBR14daTYUWeIsw+Jji88gMzQy9gY=
=kEQi
-----END PGP SIGNATURE-----

--11Y7aswkeuHtSBEs--
