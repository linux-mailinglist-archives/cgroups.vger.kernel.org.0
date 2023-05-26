Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB66712EC1
	for <lists+cgroups@lfdr.de>; Fri, 26 May 2023 23:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjEZVLp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 May 2023 17:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjEZVLo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 May 2023 17:11:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903E5BB;
        Fri, 26 May 2023 14:11:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 187291FDB1;
        Fri, 26 May 2023 21:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685135502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GTCdMXnNw/we7gpWUIpXMsOp9HhjiCEV541QuBvZbyI=;
        b=nGFZHAxje2bQi5OKTGrbsgUMwcORsIAPWM0/azph8zJ/82STCr0zqq7OJskz3qFrMTvnm8
        8XShV3U1AYBeAbz5WvKd78glx2fuXqUWgSOB06tmBe4FuBqYbhe3JlbJ8zTde0afM1Nayn
        O0e+anTuA/QQKFYJZWvWvafOIk7vykE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D0923138E6;
        Fri, 26 May 2023 21:11:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 84YUMo0gcWQfVwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 26 May 2023 21:11:41 +0000
Date:   Fri, 26 May 2023 23:11:40 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] blk-cgroup: Flush stats before releasing blkcg_gq
Message-ID: <wrk7xlexb4kt7zlsqaubmc7ifig2fg6kkeuulfsc4u5xeubrck@pa3okxj3sor4>
References: <20230524011935.719659-1-ming.lei@redhat.com>
 <CAJD7tkZkbro4H-QC=RJx_dfCdGQ5c=4NJhbFrcEmQSidaaMOmg@mail.gmail.com>
 <ZG14VnHl20lt9jLc@ovpn-8-17.pek2.redhat.com>
 <3ej42djuuzwx36yf2yeo5ggyrvogeaguos5jtve2bvuaejnwff@fak3yjwe2fbi>
 <8f56f60f-8dd3-d798-3d81-6ccbb185465d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2lov5w6hllmz7efr"
Content-Disposition: inline
In-Reply-To: <8f56f60f-8dd3-d798-3d81-6ccbb185465d@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--2lov5w6hllmz7efr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 25, 2023 at 11:25:05AM -0400, Waiman Long <longman@redhat.com> wrote:
> Since the percpu blkg_iostat_set's that are linked in the lockless list will
> be freed if the corresponding blkcg_gq is freed, we need to flush the
> lockless list to avoid potential use-after-free in a future
> cgroup_rstat_flush*() call.

Ah, so that was meant to the situation post-patch (that removes refcnt
of entries on list lockless).

(It sounded like an answer to Yosry's question about
cgroup_rstat_flush in offline_css in pre-patch version. Nevermind, this
would need other adjustments.)

Thanks,
Michal

--2lov5w6hllmz7efr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZHEgigAKCRAkDQmsBEOq
uWtDAP9qS2v1mJD+JAJWF4NNLRntYEptKWXuYC5WuXbwLeHXVgEAv+bVtSIdoISo
P9lLBk2p49pDqTse3bR1E50c/pTTQgU=
=Aa81
-----END PGP SIGNATURE-----

--2lov5w6hllmz7efr--
