Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643AE6257A2
	for <lists+cgroups@lfdr.de>; Fri, 11 Nov 2022 11:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbiKKKIs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Nov 2022 05:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiKKKIs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Nov 2022 05:08:48 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E67DF038;
        Fri, 11 Nov 2022 02:08:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BD43B22A6B;
        Fri, 11 Nov 2022 10:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668161325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Njy+9VQDA2x8k6xdte7NdH5PI4Y0RD6JCuHPbQ59y9Y=;
        b=mij2Vx3pVUYxoFhx5V9lxpwv4DvmeN9TvBH9YYtc49WknJbIUyktZGk10aPTQ00zdKLPWO
        oRNWMZr/dcvxJ9hSlakB50Gl5mCTfCJ9KpdDzJshteaGX5hubk+5tcRdYPupAw3AilLiXV
        oqBZSAgliR2auCbW9y5N0bPQIGDv7fg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B5CE13357;
        Fri, 11 Nov 2022 10:08:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oS7oHC0fbmNGeAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 11 Nov 2022 10:08:45 +0000
Date:   Fri, 11 Nov 2022 11:08:44 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Lu Jialin <lujialin4@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/memcontrol.c: drains percpu charge caches in
 memory.reclaim
Message-ID: <20221111100843.GG20455@blackbody.suse.cz>
References: <20221110065316.67204-1-lujialin4@huawei.com>
 <20221110144243.GA10562@blackbody.suse.cz>
 <CAJD7tkat6QAJkPJ-of0xYGbKJ1CyXeC0cMh+U9Nzmddm4pOZ9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q6STzHxy03qt/hK9"
Content-Disposition: inline
In-Reply-To: <CAJD7tkat6QAJkPJ-of0xYGbKJ1CyXeC0cMh+U9Nzmddm4pOZ9g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--Q6STzHxy03qt/hK9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 10, 2022 at 11:35:34AM -0800, Yosry Ahmed <yosryahmed@google.com> wrote:
> OTOH, it will reduce the page counters, so if userspace is relying on
> memory.current to gauge how much reclaim they want to do, it will make
> it "appear" like the usage dropped.

Assuming memory.current is used to drive the proactive reclaim, then
this patch makes some sense (and is slightly better than draining upon
every memory.current read(2)).

I just think the commit message should explain the real mechanics of
this.

> The difference in perceived usage coming from draining the stock IIUC
> has an upper bound of 63 * PAGE_SIZE (< 256 KB with 4KB pages), I
> wonder if this is really significant anyway.

times nr_cpus (if memcg had stocks all over the place).

Michal

--Q6STzHxy03qt/hK9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY24fFAAKCRAkDQmsBEOq
uQqYAP43Vb8o2c74sobuMNtlWw1gCKYZQ/J7GQSxdpVrnAcQdgEAwVkZvEqxNW26
8VIva1cppj+dAzB+o1VI3+WkrJk8uw8=
=Z1CV
-----END PGP SIGNATURE-----

--Q6STzHxy03qt/hK9--
