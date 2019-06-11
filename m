Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56BB83C6C7
	for <lists+cgroups@lfdr.de>; Tue, 11 Jun 2019 10:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404702AbfFKI54 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jun 2019 04:57:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59361 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403860AbfFKI54 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jun 2019 04:57:56 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 69F488021D; Tue, 11 Jun 2019 10:57:43 +0200 (CEST)
Date:   Tue, 11 Jun 2019 10:57:53 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        sfr@canb.auug.org.au
Subject: -next-20190607 kernel: oopses on bootup or shutdown
Message-ID: <20190611085753.GA12364@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

It failed to boot three times; now it booted but failed on shutdown.

Hardware is thinkpad X60 (32bit x86), and I'm copying oops by hand.

EIP: exit_creds+0x1a
Call Trace:
 __put_task_struct
 css_task_iter_end
 cgroup_pidlist_start
 cgroup_seqfile_start
 kernfs_seq_start
 seq_read
 ? kernfs_fop_write
 ...
 sys_read

Kernel panic - not syncing: Attempted to kill init

Any ideas?
							Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlz/bREACgkQMOfwapXb+vJMyQCdETJGv9ZLT5dkhTw6BfKL+eoN
/8AAn3VDLp02ZpYszETZXN+9zkdE8pAB
=ay6w
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
