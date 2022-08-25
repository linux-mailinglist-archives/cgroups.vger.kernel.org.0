Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F495A10C3
	for <lists+cgroups@lfdr.de>; Thu, 25 Aug 2022 14:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242010AbiHYMkz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Aug 2022 08:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241985AbiHYMkv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Aug 2022 08:40:51 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E32C4BA4C
        for <cgroups@vger.kernel.org>; Thu, 25 Aug 2022 05:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=aZqNW6W08ih6JS2IUvIIZiIqCV3W
        gHPNwpTFgHstyik=; b=m2WPERIsCK59vBzWco9kmFaJ/EdlAkSDaOmQX21n+pUB
        hY77VM8gyKz77N60QfRJXv+nVVZTH7hJ2o86ZUFrXv0a3Rr1uHAgMa3by4QVdlVX
        IyUWRuZwcj0lfbdsiCZB/p6+2IOScAleePiChPOJEQTOOwHUaYYjG8RzipR6m8s=
Received: (qmail 2687725 invoked from network); 25 Aug 2022 14:40:29 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Aug 2022 14:40:29 +0200
X-UD-Smtp-Session: l3s3148p1@UcMaGhDnZNcgAwDtxwoDABxA2q3xYuRb
Date:   Thu, 25 Aug 2022 14:40:26 +0200
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
Message-ID: <YwdtunymYd4VO83D@shikoro>
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
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QWwBO+hWQkYuUjLm"
Content-Disposition: inline
In-Reply-To: <YwdAknZFyKxCXZuL@alley>
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


--QWwBO+hWQkYuUjLm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> > Generated by a coccinelle script.
^ ^ ^

> You might want to use Coccinelle if a simple sed/awk gets too
> complicated. See

:)

So, I did a tree wide conversion and let Linus know that I have a branch
available. He didn't respond, so I assumed that individual patches is
the way to go.


--QWwBO+hWQkYuUjLm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmMHbbYACgkQFA3kzBSg
KbZAYw/+NDqOY8g0Yuz+VlyR09k33L8XgacCAPbI3iIT3HWMPSLM5PILZvw4/KmS
fbEWjJpCFWjSOoZSM5M+vw6MicaUqwjn7UXrJNLIR25RklM/Re8rfgmmo2iqqyb+
UPAdKt3tapAX5Yb4BQWBRSNxp8+TOl+CiNtdZjec35ESDaSdAd2vDtHE6C6yxP43
pY3tgKgjIwpI5jqMU/KxOLMCdQHy7TTr63qbeHZcPPpqeBkMMO55rqucIBrx8h26
WtCE2di3Uzt4ma7Lo+7NJUiYdzvX17U+98XDxm0MxeeQpEstI6qK/zz0NE9pR1pH
1AmJjRt72JxP0o7ryWvxcnXHOer2j1vEMI05kS8kmMjwCBeQWiV5/KvbxcA6S4dU
vsUiHJQfJlzpYjjudEV7De6l3zKbrjf/jJQvhv8Poz4AkrFR8kUIGfvV5sRM06wq
ASybvskRI+M+7BiyJC/KwHjRePkqsHsp/0FqtjOt+Ztejinu9mFc8xPcfqjiPAXx
bTzqhvtmyUDn+vxJpfmGh59mBzyp3toKatWCH7Xwr6RYBgwBZLTucH6K64XJp7Gz
4rb2ubLz8PZhLDCmi01R5z9E3nZD1Jpn8XV0/qYyrA+8zFqdV4iZSFKxMjwL+Csd
LvvbPt0YRE8mmR9zwZqNoSi6xSDIx6KBrtQpUbs2lCw9H5riV50=
=lWpT
-----END PGP SIGNATURE-----

--QWwBO+hWQkYuUjLm--
