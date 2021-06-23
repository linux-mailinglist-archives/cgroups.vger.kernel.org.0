Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0283B3B1F71
	for <lists+cgroups@lfdr.de>; Wed, 23 Jun 2021 19:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhFWRab (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Jun 2021 13:30:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52608 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFWRab (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Jun 2021 13:30:31 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0B77F21976;
        Wed, 23 Jun 2021 17:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624469293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mYyynKwtehNPTyX1THKKb3El0qFbl9kjsXWw3DO0Cyg=;
        b=ggCdPixjzjfnvYzh8cFPC3mmpsko8L8djdCRmIRn9tB3zoo2F84MzrI5ApxBCpghL1j+6S
        GY/vZwY1q/UQdJ/4TZBwmoQjJWUExfeYywJ2/1RCJuRhkuZF1MtENMZaPHh22hDeQZxqgk
        qwvo9Azn0auThexBB0JVarf8/IMRf6g=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id DD56511A97;
        Wed, 23 Jun 2021 17:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624469293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mYyynKwtehNPTyX1THKKb3El0qFbl9kjsXWw3DO0Cyg=;
        b=ggCdPixjzjfnvYzh8cFPC3mmpsko8L8djdCRmIRn9tB3zoo2F84MzrI5ApxBCpghL1j+6S
        GY/vZwY1q/UQdJ/4TZBwmoQjJWUExfeYywJ2/1RCJuRhkuZF1MtENMZaPHh22hDeQZxqgk
        qwvo9Azn0auThexBB0JVarf8/IMRf6g=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id PMXwNCxv02BjPwAALh3uQQ
        (envelope-from <mkoutny@suse.com>); Wed, 23 Jun 2021 17:28:12 +0000
Date:   Wed, 23 Jun 2021 19:28:11 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Ronny Meeus <ronny.meeus@gmail.com>
Cc:     cgroups@vger.kernel.org
Subject: Re: Short process stall after assigning it to a cgroup
Message-ID: <YNNvK0koEdkuD/z3@blackbook>
References: <CAMJ=MEegYBi_G=_nk1jaJh-dtJj59EFs6ehCwP5qSBqEKseQ-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iwo5q46b7oRDEl/S"
Content-Disposition: inline
In-Reply-To: <CAMJ=MEegYBi_G=_nk1jaJh-dtJj59EFs6ehCwP5qSBqEKseQ-Q@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--iwo5q46b7oRDEl/S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Ronny.

On Mon, Jun 14, 2021 at 05:29:35PM +0200, Ronny Meeus <ronny.meeus@gmail.com> wrote:
> All apps are running in the realtime domain and I'm using kernel 4.9
> and cgroup v1. [...]  when it enters a full load condition [...]
> I start to gradually reduce the budget of the cgroup until the system
> is idle enough.

Has your application some RT requirements or is there other reason why
you use group RT allocations? (When your app seems to require all CPU
time, you decide to curb it. And it still fullfills RT requirements?)


> But sometimes, immediately after the process assignment, it stops for
> a short period (something like 1 or 2s) and then starts to consume 40%
> again.

What if you reduce cpu.rt_period_us (and cpu.rt_runtime_us
proportionally)? (Are the pauses shorter?) Is there any useful info in
/proc/$PID/stack during these periods?

> Is that expected behavior?

Someone with RT group schedulling knowledge may tell :-)

HTH,
Michal

--iwo5q46b7oRDEl/S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAmDTbycACgkQia1+riC5
qSjuGw/+PwgyMCdN3B3T/DIUA8jgqdahhAhOr6gvKki2T+6nna3+hEHUgxek2IJr
hLcLKL6EDyHQDTPi5CuqD/yDmpMePCbZiKbx6TczCk1wlbVAeUrJo5MZmVqqoZX/
+CISMLNWXZ1zdvGB7FXa3yOn10Q99EAwBo8IycXpg8YNMExlboaDpUZNtfjiaQnE
+XcXTi1titifBLtV5SPo3EkOkUSivGyQo6vcvWQcEsBO3CHpHK3bJCzxCHlV4hzM
LsaYBTs8dmp8Om8BkybbuR61YsghFiZyFULRIDAUfbd3Jt7cLJvdgPdXQL4rJEEy
7mbq2x46n/r8v3m3DR6KLpO+a+OGChxFZFxSGuN0jqA0/ae2sXwetX94mVsml/Zd
NOFYv22Hm+yhM5UEQUWBlq6AuvKmgVeuqVBY6JGaKXFq540k8WoERDHQ0vWpyhUv
68WTrcVEE5IWSzZ/SM6sOA8EPf7e5PzvRe9ddCNIKmpOYP7fyIzyVe7v1Fi+QHUf
jxaARY1/Dyx84lm4eqLJ6j+038iMDAvP7gX3HG9uOnAJAF7dTGyW4HY3nPm00iyZ
FYbx1ZEIFMWKKOXDbxUVopZM5JPdFzF30zq1GXPR0N54IimDNkQEQ1pJjsRAYJn2
LWTq7ed2zVnW/Eb1xM06+kH5d2LgfxzRGxe/XX9d4lL7FKkqEzE=
=oi2J
-----END PGP SIGNATURE-----

--iwo5q46b7oRDEl/S--
