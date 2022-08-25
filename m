Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1C85A1A98
	for <lists+cgroups@lfdr.de>; Thu, 25 Aug 2022 22:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiHYUxT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Aug 2022 16:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242651AbiHYUxS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Aug 2022 16:53:18 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9139AD982
        for <cgroups@vger.kernel.org>; Thu, 25 Aug 2022 13:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=6AQOodmRYhiBHPJku0/KQnZuH4bu
        aowrp/Re1ISUE2I=; b=zHBzvPwMzrT30ZuQESeQ0WB3zDlH36zoP0o69ouSCYGz
        pjziUHmiIOIIihWk23x18LpSZky4T04LmoP0uRnPDJrwFJZyBDg217KLeEjeVx31
        GdMCJ+72b2bbgJn795NCLBl3uEWfapnPLcWUq4lUnC5kLR5bxc6NbwrOVge8eY4=
Received: (qmail 2843961 invoked from network); 25 Aug 2022 22:53:12 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Aug 2022 22:53:12 +0200
X-UD-Smtp-Session: l3s3148p1@toIf/BbnAcUucrQf
Date:   Thu, 25 Aug 2022 22:53:08 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, bpf@vger.kernel.org,
        cgroups@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] kernel: move from strlcpy with unused retval to strscpy
Message-ID: <YwfhNNwis4b3qwdX@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, bpf@vger.kernel.org,
        cgroups@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20220818210202.8227-1-wsa+renesas@sang-engineering.com>
 <YwdAknZFyKxCXZuL@alley>
 <YwdtunymYd4VO83D@shikoro>
 <Ywd+jrlh+6ZJw7u5@alley>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fz94ukbbgpPoi98t"
Content-Disposition: inline
In-Reply-To: <Ywd+jrlh+6ZJw7u5@alley>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--fz94ukbbgpPoi98t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Also he might prefer to get the script that did the tree-wide change so
> that he knows what exactly has changed.

The script was also published in the thread originating all this [1].

[1] https://lore.kernel.org/all/YvhXzarjOLEJ8nsW@shikoro/


--fz94ukbbgpPoi98t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmMH4TAACgkQFA3kzBSg
KbYP/g//aVNK4imScpt4qSn7pT65itBbV6E0v08ayuKks5ZT2rcrGdfJyCfX6LSV
PVku2MNOXlDaDdDbgS46m223zggvOiSVmOqOvHykRszXKsm9g+vmZE/UNW8s8Po9
dKY4gz1eIlQD0+eFlZQEazTdPHohC18xLwHg/IKKk2xt1MZ+5tJM/mDE05vXhvdM
lyJl8EZsKIE0f6xMAc1JJ/soTxvgzWCOR5IU9j9tp2OyPiEA8oseD9DGUyLoAJ1q
ORw5KyghzMt4J2cIjONRz/bF82upiijk3y8Llip2dlHiqXIGb2kYd7OECLZQ0+08
wBwy5Dg9ssBT77nyl2aJjHVDY6x3TzlcCERn+gaF29vmeP4Ks0/AKuJ9cQQ4wbwL
bknBVNmmnuLv7beMr8LBZHccr2lFAk2M4FovY4nXtRFhFNhszDMCDSCyBNDtqYyX
2MKs95ejp14Q05FYrAoOVZPWIrOUa0Uk0Gk1bqE7dq9Ym74a4/bneiqPPxhkZbxo
dukbxVJlJ4NzzuStc4iRS01UDZEO6ewy6FbwijcvUav8zGYu3RkkHbUHEd9LIzIw
fUqs88whXatJVQr1nda8CrOG1AIa/6LeiGeD+1pS/wORmqskp757mwJhNVBgk38a
Ev2HkqgZnTkGzI5ecc8nlv7vJonMDl0OPHSVamWTOs/arGcBHmY=
=lPL3
-----END PGP SIGNATURE-----

--fz94ukbbgpPoi98t--
