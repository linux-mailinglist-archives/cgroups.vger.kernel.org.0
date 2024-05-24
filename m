Return-Path: <cgroups+bounces-2995-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 446228CE86B
	for <lists+cgroups@lfdr.de>; Fri, 24 May 2024 18:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EB86B21AC8
	for <lists+cgroups@lfdr.de>; Fri, 24 May 2024 16:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C6112DD8F;
	Fri, 24 May 2024 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Q14CfsNl";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sSNN+UXq"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B2912C7FA;
	Fri, 24 May 2024 16:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716566604; cv=none; b=psf88jGNomL0mhXmPa8h6DnC18o8Akn/nvZBzFtqkRlI3CGhvPsrFVz67Es4nuuDc1OspSC7AXnYKfcHdbhsCAbBr+VvYoI3vAxgfR1KQUYkoZ66UE9tEdBomvFr6aL6lLEKBKVPKhvDIuhfUwRfAOsHbenbi7MPSx5Q72EOrIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716566604; c=relaxed/simple;
	bh=JqKS4wpPgXqZOf3iMQQ8ii+Ilnkc19O7nq7rAofjl6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDJkX4aXvNkS9jrcoUMl56ZftHvP18LfM7w3SJ7baLEyao+L2wyxjlrxqye1jPksMjjgOMBkdEYsC879hu0a1We52NE4cI6V/L0Y/mbC5cP1rWGhojJ69Vc7hGK4ioAk6u95S6nFk/SiaKXnyEdImHYbt90/MlWnK43xIlaQhI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Q14CfsNl; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sSNN+UXq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4EED520B60;
	Fri, 24 May 2024 16:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716566598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6lUxk/Tjt7m/ohntKkHsSv/2LsIygylGYaEnvovT1G4=;
	b=Q14CfsNlKWPRsawRA1UJAYqnKI+SK51ujfeyWWXYvpqR7Dwlap1rStX5b1rPD2scnO8H0Q
	QcmxsFKTD6Dj8MHQeRYxLQPQN/aqF/s4EkefKZoAxqZXyckUrPlq6WWeT8paZrQC2gE6+x
	AwoAhNRCebcLT/47Uer3O3QLVztze4E=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716566597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6lUxk/Tjt7m/ohntKkHsSv/2LsIygylGYaEnvovT1G4=;
	b=sSNN+UXqk6PzJE5+gQ07B+a+eAyOLOl9++Jho5njILKRbhaKSOwVx+7QsvM5RkbVjpU9nT
	w/GMmcvTI8bohYMflafNS2OGZHqUycV6P7OiT3DsnraDuLPS/efeluoDLmSbHwtM/BQn8k
	P9SrJmfoZYRo/8tU+xCHhogh41dKn8U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B07313A3D;
	Fri, 24 May 2024 16:03:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TYn9DUW6UGajZwAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Fri, 24 May 2024 16:03:17 +0000
Date: Fri, 24 May 2024 18:03:16 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Sam Sun <samsun1006219@gmail.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, tj@kernel.org, 
	syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com, 
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [Linux kernel bug] KASAN: slab-use-after-free Read in
 pressure_write
Message-ID: <q7lfvwrjrs3smyoyt5pyduv5c7hmmgv2mgo6ns3agbjaxawoso@24dbbmumc7ou>
References: <CAEkJfYMMobwnoULvM8SyfGtbuaWzqfvZ_5BGjj0APv+=1rtkbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wtqa4dzpqfs5my2o"
Content-Disposition: inline
In-Reply-To: <CAEkJfYMMobwnoULvM8SyfGtbuaWzqfvZ_5BGjj0APv+=1rtkbA@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -5.90
X-Spam-Level: 
X-Spamd-Result: default: False [-5.90 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,cmpxchg.org,bytedance.com,kernel.org,googlegroups.com,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]


--wtqa4dzpqfs5my2o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 03:14:23PM GMT, Sam Sun <samsun1006219@gmail.com> w=
rote:
> ...
> We analyzed the root cause of this problem. It happens when
> concurrently accessing
> "/sys/fs/cgroup/sys-fs-fuse-connections.mount/irq.pressure" and
> "/sys/fs/cgroup/sys-fs-fuse-connections.mount/cgroup.pressure". If we
> echo 0 to cgroup.pressure, kernel will invoke cgroup_pressure_write(),
> and call kernfs_show(). It will set kn->flags to KERNFS_HIDDEN and
> call kernfs_drain(), in which it frees kernfs_open_file *of. On the
> other side, when accessing irq.pressure, kernel calls
> pressure_write(), which will access of->priv. So that it triggers a
> use-after-free.

Thanks for the nice breakdown.

What would you tell to something like below (not tested).

Regards,
Michal

-- >8 --
=46rom f159b20051a921bcf990a4488ca6d49382b61a01 Mon Sep 17 00:00:00 2001
=46rom: =3D?UTF-8?q?Michal=3D20Koutn=3DC3=3DBD?=3D <mkoutny@suse.com>
Date: Fri, 24 May 2024 16:50:24 +0200
Subject: [PATCH] cgroup: Pin appropriate resources when creating PSI pressu=
re
 trigger
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Wrongly synchronized access to kernfs_open_file was detected by
syzkaller when there is a race between trigger creation and disabling of
pressure measurements for a cgroup (echo 0 >cgroup.pressure).

Use cgroup_mutex to synchronize whole duration of pressure_write() to
prevent working with a free'd kernfs_open_file by excluding concurrent
cgroup_pressure_write() (uses cgroup_mutex already).

Fixes: 0e94682b73bf ("psi: introduce psi monitor")
Fixes: 34f26a15611a ("sched/psi: Per-cgroup PSI accounting disable/re-enabl=
e interface")
Reported-by: Yue Sun <samsun1006219@gmail.com>
Reported-by: xingwei lee <xrivendell7@gmail.com>
Signed-off-by: Michal Koutn=FD <mkoutny@suse.com>
---
 kernel/cgroup/cgroup.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e32b6972c478..e16ebd0c4977 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3777,31 +3777,30 @@ static ssize_t pressure_write(struct kernfs_open_fi=
le *of, char *buf,
 	struct psi_trigger *new;
 	struct cgroup *cgrp;
 	struct psi_group *psi;
+	ssize_t ret =3D nbytes;
=20
 	cgrp =3D cgroup_kn_lock_live(of->kn, false);
 	if (!cgrp)
 		return -ENODEV;
=20
-	cgroup_get(cgrp);
-	cgroup_kn_unlock(of->kn);
-
 	/* Allow only one trigger per file descriptor */
 	if (ctx->psi.trigger) {
-		cgroup_put(cgrp);
-		return -EBUSY;
+		ret =3D -EBUSY;
+		goto out;
 	}
=20
 	psi =3D cgroup_psi(cgrp);
 	new =3D psi_trigger_create(psi, buf, res, of->file, of);
 	if (IS_ERR(new)) {
-		cgroup_put(cgrp);
-		return PTR_ERR(new);
+		ret =3D PTR_ERR(new);
+		goto out;
 	}
=20
 	smp_store_release(&ctx->psi.trigger, new);
-	cgroup_put(cgrp);
=20
-	return nbytes;
+out:
+	cgroup_kn_unlock(of->kn);
+	return ret;
 }
=20
 static ssize_t cgroup_io_pressure_write(struct kernfs_open_file *of,
--=20
2.44.0


--wtqa4dzpqfs5my2o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZlC6QQAKCRAGvrMr/1gc
jvnJAP0VHPulkTLjdFvEPehO3a5hlZoKLC2RYbz1+2pc/oQoxgD9Hr2sNyZnb5kR
TkRvrrDg6Xazb53v7L69DAUQz/mA+gg=
=25o2
-----END PGP SIGNATURE-----

--wtqa4dzpqfs5my2o--

