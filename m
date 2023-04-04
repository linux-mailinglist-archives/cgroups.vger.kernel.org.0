Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E48A6D697C
	for <lists+cgroups@lfdr.de>; Tue,  4 Apr 2023 18:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbjDDQxd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Apr 2023 12:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbjDDQxY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Apr 2023 12:53:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5AE4EC5;
        Tue,  4 Apr 2023 09:53:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9A75E20689;
        Tue,  4 Apr 2023 16:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680627186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ll6vzEKQtu1d/iiPFBcw95nX9gIYgOaKMZRWVNUtfkM=;
        b=OnTsPuWsvR8SUopMCtCWMTgT2XxI3U2ix4/z/djlxuJpDe5rTy1vlqUc7rIQ79SwyWU+Ba
        aNQWpCYDuFeaj6SA/BU2bvIIYzm8uWKKX3KtU5qWEj3+h5Nzr/fpy+by5cNlp77YPmMqCo
        FWnVjkGyLQXqBJ8fQCYb63lUO4hLKBw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C4161391A;
        Tue,  4 Apr 2023 16:53:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +w65EfJVLGTSMAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 04 Apr 2023 16:53:06 +0000
Date:   Tue, 4 Apr 2023 18:53:05 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v3 6/8] workingset: memcg: sleep when flushing stats in
 workingset_refault()
Message-ID: <20230404165305.ffs7uscqpndnfytn@blackpad>
References: <20230330191801.1967435-1-yosryahmed@google.com>
 <20230330191801.1967435-7-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qfkseaqkxxqkcz24"
Content-Disposition: inline
In-Reply-To: <20230330191801.1967435-7-yosryahmed@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--qfkseaqkxxqkcz24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 30, 2023 at 07:17:59PM +0000, Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> In workingset_refault(), we call
> mem_cgroup_flush_stats_atomic_ratelimited() to read accurate stats
> within an RCU read section and with sleeping disallowed. Move the
> call above the RCU read section to make it non-atomic.
>=20
> Flushing is an expensive operation that scales with the number of cpus
> and the number of cgroups in the system, so avoid doing it atomically
> where possible.

I understand why one does not process the whole flushing load in one go
in general.
However, I remember there were reports of workingset_refault() being
sensitive to latencies (hence the ratelimited call was created).

Is there any consideration on impact of this here?
(Or are there other cond_resched() precendents on this path? Should it
be mentioned like in the vmscan (7/8) commit?)

Thanks,
Michal

--qfkseaqkxxqkcz24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZCxV7gAKCRAkDQmsBEOq
uUD+AQD8wXXi9jmmMAZsQDelWPQkkod/PwIlrMWJ7mxxhDrGEwEAqpLPmU1ZnE0x
eJvubQemadydJAWDGZe8mox2qJ3iLAY=
=AwCK
-----END PGP SIGNATURE-----

--qfkseaqkxxqkcz24--
