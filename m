Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9992E7847C7
	for <lists+cgroups@lfdr.de>; Tue, 22 Aug 2023 18:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbjHVQfQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Aug 2023 12:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237891AbjHVQfL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Aug 2023 12:35:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488C6CF4;
        Tue, 22 Aug 2023 09:35:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C1636200EB;
        Tue, 22 Aug 2023 16:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692722101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qt0ZLoOqT9+wpCm2Ny+8HuPkuahGjnCugCYXd8XlMx4=;
        b=Pax4caF2Ef7NBtayR04STCzFqckSNupMb66tw35QjhgWvF9+wKzVgjJBg9YlG0KcbLsLZ2
        oCi24HsoJGkFuND2JYvuNfi4s3gIN/HH/BaylrFafuhYEdWG+9nZ1ta4ax3RchF+ksp0vy
        C1CLitUshYgpH557xXomFZYOIxXdAA8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A2CD13919;
        Tue, 22 Aug 2023 16:35:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9zIEHbXj5GRMXgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 22 Aug 2023 16:35:01 +0000
Date:   Tue, 22 Aug 2023 18:35:00 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: memcg: add a helper for non-unified stats
 flushing
Message-ID: <5y3e32ek6owren3q5e3gzonzxzdhs53ihywj3mtbhz56hnizfy@fctafygsnfaq>
References: <20230821205458.1764662-1-yosryahmed@google.com>
 <20230821205458.1764662-3-yosryahmed@google.com>
 <y7vvyndehadwy5ouounm5oyo52bqhsysiizuphzki2h3bwpdpc@3hvaq6sp6f4k>
 <CAJD7tkaVuiMU-ifJiyH5d_W1hi9DnAymYJxzBxEKCVX+tU=OCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7f63xjlvpzzrd5op"
Content-Disposition: inline
In-Reply-To: <CAJD7tkaVuiMU-ifJiyH5d_W1hi9DnAymYJxzBxEKCVX+tU=OCA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--7f63xjlvpzzrd5op
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 22, 2023 at 09:00:06AM -0700, Yosry Ahmed <yosryahmed@google.com> wrote:
> We can probably also kick FLUSH_TIME forward as well.

True, they guard same work.

> Perhaps I can move both into do_stats_flush() then. If I understand
> correctly this is what you mean?

Yes.

> What do you think?

The latter is certainly better looking code.

I wasn't sure at first about moving stats_flush_threshold reset before
actual flush but on second thought it should not be a significant change
- readers: may skip flushing, the values that they read should still be
  below the error threshold,
- writers: may be slowed down a bit (because of conditional atomic write
  optimization in memcg_rstat_updates), presumably not on average
  though.

So the latter should work too.

Michal

--7f63xjlvpzzrd5op
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZOTjsgAKCRAGvrMr/1gc
jnZMAP9j2epDKDEIrW1B1fJASKjVt5dkRJM2SCYyQNX6oNKqUAEAnUs7Pg88u8E/
lU8WkkS7hOz1ZQ2abpo1AtoV7nqS6QU=
=FEfo
-----END PGP SIGNATURE-----

--7f63xjlvpzzrd5op--
