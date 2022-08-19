Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F7D5994E8
	for <lists+cgroups@lfdr.de>; Fri, 19 Aug 2022 08:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345757AbiHSFyE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Aug 2022 01:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346194AbiHSFx7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Aug 2022 01:53:59 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD893C17A
        for <cgroups@vger.kernel.org>; Thu, 18 Aug 2022 22:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=LXIju/pZq7pSNW6LnM8b4sTVTukd
        FnVNMRzhxn6c1LQ=; b=zuNyA9ScwNDOoqj1m0F1nLXHuOuHWyBfZTuf7kGHaDi/
        NB2VMiPDZSHWlp3JKPA9dZWtPjROsS909xjd10SGWpkdL5Yb8VLziuAZZEp9Qu2P
        IYOhMSR8tBCyRo8SibXE9UDWqoiJB+2Xt5E8Z1GcxHj3afBeYJkkn/NU5UnnXTE=
Received: (qmail 4115059 invoked from network); 19 Aug 2022 07:53:52 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 Aug 2022 07:53:52 +0200
X-UD-Smtp-Session: l3s3148p1@Scn+uJHmpZMucrTL
Date:   Fri, 19 Aug 2022 07:53:51 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Steven Rostedt <rostedt@goodmis.org>
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
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, bpf@vger.kernel.org,
        cgroups@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] kernel: move from strlcpy with unused retval to strscpy
Message-ID: <Yv8lb1tUKxYlAcp8@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
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
        Namhyung Kim <namhyung@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, bpf@vger.kernel.org,
        cgroups@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20220818210202.8227-1-wsa+renesas@sang-engineering.com>
 <20220818181506.0d838d02@gandalf.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="imGX9vdjm3pSRE9T"
Content-Disposition: inline
In-Reply-To: <20220818181506.0d838d02@gandalf.local.home>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--imGX9vdjm3pSRE9T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Steven,

> But in my cases I actually do trust the source string. They are all

The ultimate goal is to remove strlcpy entirely. My motivation is to get
rid of the extra work for maintainers that they need to ensure that the
author of a patch paid attention to the detail that the source string
must be trusted.

Happy hacking,

   Wolfram

--imGX9vdjm3pSRE9T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmL/JW8ACgkQFA3kzBSg
Kbb/cxAAnj8gY2iJMJEMUNF2CQXBszyFdlW8pM+4lHflaDhlrdBOhhKlq9vCX5Td
aAs0S5K8tk2DANywxX4gtQHGIR9h9HfDBFOTAONRnJ5fkmb6olQFUBqhIjQt/uNR
VxjPKDYmWQqBFv/F4dAxnesfIA8M34Psd0zFVfNMFbu8hVcsE6VaLcUCU2AskKQx
Q0ULNoIW9MGMSfZhaHH1iO7sowNu+Wy2BrBbb5+Bjzo85BSseCgyHTb1lgio2bSN
OZTTWZV6AOJWy7C14VMKm5/swgyjcqaiyNZPGqtMUxEakGIer+4fd1AH43ILsEk/
PoGsHT9F+myYBnlBAyRIhO4eSGxTJGekD4vRT/wVCYe1IrPRqFyfa7MaNitjzSTS
ObyG7vVbwoCl4tzPCGXMU46b0Ydq8dYw5XBP1xQmcK77Z8IZY9WyIOY0vbcPizo6
IcRK3ubeUTz/FOw9IG+sZ8kL+TcchTyoKKP6a68IzisCsdeOPPpGT6VEDPxuM0S0
X7nfso4wX7FXzDUYy9lbhQrJ3YnxUvGuqoBHpM9fAXwYQ0PcBgUWVSaWZEE/X50m
VB5k/mTzhrnVAjFwhaLyaJei10mjQ4vDUOD5LSvzkGpzbUk8iDHNDKXSKued8t9u
nH5ZIQ0JLb5roFTZjnvbSHRGEMTkPkIEibxH/uSoEJCWaoJehDo=
=t18q
-----END PGP SIGNATURE-----

--imGX9vdjm3pSRE9T--
