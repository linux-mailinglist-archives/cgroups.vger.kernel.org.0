Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A627784170
	for <lists+cgroups@lfdr.de>; Tue, 22 Aug 2023 15:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjHVNBB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Aug 2023 09:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjHVNBA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Aug 2023 09:01:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE47D7;
        Tue, 22 Aug 2023 06:00:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7B2D422C00;
        Tue, 22 Aug 2023 13:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692709257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OAbqRGEAHu7Ri1BEFwHTiMJqbULQ9AggcksOng91Am0=;
        b=cvqkpboFbqEuoqpJwUDKKnH2hSxO9sIKRD0OoHN68lpKaWPMvn6sYj3+y0FrVNkubvdd7y
        fhRZvkxdGrVB+2klXgVvUwuoxPBUH8NGm3GOyNzDLkZAbcqa6o+Bcu80dpJ1LGXUdWbeAr
        YktZZL9KkXW/Gqnkv6S94Mwwu6RQorc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 273A7132B9;
        Tue, 22 Aug 2023 13:00:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kVQQCImx5GQadQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 22 Aug 2023 13:00:57 +0000
Date:   Tue, 22 Aug 2023 15:00:55 +0200
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
Subject: Re: [PATCH 0/3] memcg: non-unified flushing for userspace stats
Message-ID: <a4opjlmm5it3ujoypcgjfljfamjvr7gu34sc7lrjldfbqzz4lj@6w4lqdcfd3zu>
References: <20230821205458.1764662-1-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rsgiuzyi263iyyyh"
Content-Disposition: inline
In-Reply-To: <20230821205458.1764662-1-yosryahmed@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--rsgiuzyi263iyyyh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Mon, Aug 21, 2023 at 08:54:55PM +0000, Yosry Ahmed <yosryahmed@google.com> wrote:
> For userspace reads, unified flushing leads to non-deterministic stats
> staleness and reading cost.

I only skimed previous threads but I don't remember if it was resolved:
a) periodic flushing was too much spaced for user space readers (i.e. 2s
   delay is too much [1]),
b) periodic flushing didn't catch up (i.e. full tree flush can
   occassionaly take more than 2s) leading to extra staleness?

[1] Assuming that nr_cpus*MEMCG_CHARGE_BATCH error bound is also too
    much for userspace readers, correct?

> The cost of userspace reads are now determinstic, and depend on the
> size of the subtree being read. This should fix both the *sometimes*
> expensive reads (due to flushing the entire tree) and occasional
> staless (due to skipping flushing).

This is nice, thanks to the atomic removal in the commit 0a2dc6ac3329
("cgroup: remove cgroup_rstat_flush_atomic()"). I think the smaller
chunks with yielding could be universally better (last words :-).

Thanks,
Michal


--rsgiuzyi263iyyyh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZOSxhQAKCRAGvrMr/1gc
jql9AP416SvKn+uj/hrokt/s6nOdeQdWlzpvkkf2UKZg17whHgD/SdSKRx0jIIbq
nqT/QXyO3EYKtOWfLu6jR/PVNXm4+A8=
=/E7c
-----END PGP SIGNATURE-----

--rsgiuzyi263iyyyh--
