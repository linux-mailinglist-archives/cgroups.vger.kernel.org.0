Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9201F7C20
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2020 19:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgFLRNi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Jun 2020 13:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgFLRNi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Jun 2020 13:13:38 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19F4C03E96F
        for <cgroups@vger.kernel.org>; Fri, 12 Jun 2020 10:13:37 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e1so10498038wrt.5
        for <cgroups@vger.kernel.org>; Fri, 12 Jun 2020 10:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6/WKj2RP2D9n4+fw5DYObbawXZCZEXk2atts5/6vXZA=;
        b=TI6S+MwlPkt8KC/tPABYYKsT1TobgOSEYvn7gfp61hj7IWbDiaISOUSExWX249s6fi
         EIYHO6hkn1K1f6HNJlpcgTM7TC6HcJ9Bz/i/U+52KQ4SDr9GmgcRXdjV7av4HWETWXxM
         fxu5PbxWzUePUak1TSIszwbrfNsSF2Mef0XA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6/WKj2RP2D9n4+fw5DYObbawXZCZEXk2atts5/6vXZA=;
        b=Sgl3Ona+lqANpRv0pL1O5EvHvWR5As+LY9KjxLEG4H9TIpCUo+BPi9QusSs0S5C0BV
         jTf4/B2pFLzPgaLJr85kSSesnfuDx6M14/doLNaQ9vONCeFLG6OJN5SblyfPsujIk2ZQ
         nlopC3ndjxCgQiYBGMQTcKxzs0FCjlAdfnrmwZNkoN/q+40D2yT0GOsLRAe6YuFnkzR5
         JLC6J328BP4xMaGjxIbQAwRWaP+PIszCCEU/nogY56Q4Hhr/gT9lw27WtODgOsnLPnOU
         0eUzsBMfawi9YJAyMUrqlF5sF3Z+fOcDWwIFLruNL9Zz4/kGLHxBqM80N3IdBOxo2AYR
         +p7Q==
X-Gm-Message-State: AOAM533gnIbMjx+DkcjJlS0DGcgGIN4q6Y320zy6Wrr6ljPunNc4gdAa
        K1BqeDDjVjpZyjyoFLCuZSRN9Q==
X-Google-Smtp-Source: ABdhPJzlc5PIQbzc9wrrQMNksbeyPR5ziC+iT8uaWIdBJcsqaBBESl71xk5jFNvubBzbMwIi3XoqOw==
X-Received: by 2002:a5d:4404:: with SMTP id z4mr16439075wrq.189.1591982016383;
        Fri, 12 Jun 2020 10:13:36 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id b185sm16603283wmd.3.2020.06.12.10.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 10:13:35 -0700 (PDT)
Date:   Fri, 12 Jun 2020 18:13:35 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/6] mm, memcg: Prevent memory.low load/store tearing
Message-ID: <20200612171335.GA341094@chrisdown.name>
References: <cover.1584034301.git.chris@chrisdown.name>
 <448206f44b0fa7be9dad2ca2601d2bcb2c0b7844.1584034301.git.chris@chrisdown.name>
 <20200612170352.GA40768@blackbook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20200612170352.GA40768@blackbook>
User-Agent: Mutt/1.14.2 (2020-05-25)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michal,

Good catch! Andrew and I must have missed these when massaging the commits =
with=20
other stuff in -mm, which is totally understandable considering the amount =
of=20
places being touched by this and other patch series at the same time. Just =
goes=20
to show how complex it can be sometimes, since I even double checked these =
and=20
didn't see that missed hunk :-)

The good news is that these are belt-and-suspenders: this avoids a rare=20
theoretical case, not something likely to be practically dangerous. But yes=
, we=20
should fix it up. Since the commit is already out, I'll just submit a new o=
ne.

Thanks for the report!

Chris

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQKTBAEBCgB9FiEECEkprPvCOwsaJqhB340hthYRgHAFAl7jt79fFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDA4
NDkyOUFDRkJDMjNCMEIxQTI2QTg0MURGOEQyMUI2MTYxMTgwNzAACgkQ340hthYR
gHAerQ//Zf+6DzdEaZvfnvPNq5+6NbmAAs+Pw1AZn2s81dipkRY38MGPNTqY8oBL
qd46ZDJ24zSUPAcHvu6E3UGwpjO8VSynvP+CfEoFlS+R5k15oEqTe36C7l9eA+IY
zTDyLj9LrFhy5qD2V2GKH9Dp9ZQC9BrIls1Gc0J+XaB7h9umEc2g1Ybadj1d3ouk
xAX/6iV19fAW4uFgXVOq70BhYGXGXvWCX0NYQ3Yz18Kkr5bSnjzTz2irIxCbaWZ+
q2Gj+Q1JFN/yhkRUt+m+8qtJZAb/i4cXqDJp9kqJ6t9cLjIhybFNRnXMueGr1Puc
byWoWK7i9+vEjnY6VbjToicAWQPeId063wxJzzhp/uqQ+zoCMDX+P7Iz4s1u+6l6
R3nXQSRcrw9VNc3ZOfJjXy1R/hIwGBbeGt/ndPnyNrznWu8yYJJr7qZirk8Uy4lp
wTmv/5QTkal+TiVXOMW6VwXMLLvu50Q+E3/7dIz4waKt98kfM8hd8zjB676rwcGD
olHRJHD956i7HOAU3uzFrijiMOgOnXAiJIDj1+MxLXdTL0ZidJizBh6eeSbxUrcg
egr+KPJSKcxuZ+K8c+yZD8MoCLJX84xTU1LdtTwQC9x10M1HnT1OMFLrfso4yWTK
SYtQxYe6sGiKMLvN3tYD5Ql63m8D2CIK5NDiK/hxG9hZtiYOH9k=
=2HeI
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
