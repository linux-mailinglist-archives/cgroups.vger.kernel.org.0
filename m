Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCDD322E7E
	for <lists+cgroups@lfdr.de>; Tue, 23 Feb 2021 17:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbhBWQO3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Feb 2021 11:14:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:55178 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233532AbhBWQO1 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 23 Feb 2021 11:14:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614096818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hSSWb6rYIaUJkIAo1VQ5w7wYavKCbYbcsKfGHrXCuTI=;
        b=hXfpY2GYOXDt7KiTCZVUgesYyjIx0kKpHd9RZrR/pgeVldRGMEMifQSKN65pZMx9FvxA+u
        tBrrGszcyktmLgFDXTSndHIyFf8tcEMfmP0C9UuDcRz3jqVe2729q4qQjSGWEFjo4c03C2
        YGzII7qT68I1SAI5rg32EEGb5EHjuE4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 80C98ACCF;
        Tue, 23 Feb 2021 16:13:38 +0000 (UTC)
Date:   Tue, 23 Feb 2021 17:13:30 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/20] cgroup: Manual replacement of the deprecated
 strlcpy() with return values
Message-ID: <YDUpqn+cRWg1ZYYT@blackbook>
References: <20210222151231.22572-1-romain.perier@gmail.com>
 <20210222151231.22572-2-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1/tBU1JjKCYi4JT4"
Content-Disposition: inline
In-Reply-To: <20210222151231.22572-2-romain.perier@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--1/tBU1JjKCYi4JT4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Mon, Feb 22, 2021 at 04:12:12PM +0100, Romain Perier <romain.perier@gmai=
l.com> wrote:
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -2265,7 +2265,7 @@ int task_cgroup_path(struct task_struct *task, char=
 *buf, size_t buflen)
Actually, this function isn't used at all. So I'd instead propose the
patch below.

-- >8 --
=46rom 4f7e0b9c0412f60e0b0e8b7d1ef6eb2790dca567 Mon Sep 17 00:00:00 2001
=46rom: =3D?UTF-8?q?Michal=3D20Koutn=3DC3=3DBD?=3D <mkoutny@suse.com>
Date: Tue, 23 Feb 2021 17:05:57 +0100
Subject: [PATCH] cgroup: Drop task_cgroup_path()
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

The function has no current users and it is a remnant from kdbus
enthusiasm era 857a2beb09ab ("cgroup: implement
task_cgroup_path_from_hierarchy()"). Drop it to eliminate unused code.

Suggested-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Michal Koutn=FD <mkoutny@suse.com>
---
 include/linux/cgroup.h |  1 -
 kernel/cgroup/cgroup.c | 39 ---------------------------------------
 2 files changed, 40 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 4f2f79de083e..e9c41b15fd4e 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -115,7 +115,6 @@ int cgroup_add_legacy_cftypes(struct cgroup_subsys *ss,=
 struct cftype *cfts);
 int cgroup_rm_cftypes(struct cftype *cfts);
 void cgroup_file_notify(struct cgroup_file *cfile);
=20
-int task_cgroup_path(struct task_struct *task, char *buf, size_t buflen);
 int cgroupstats_build(struct cgroupstats *stats, struct dentry *dentry);
 int proc_cgroup_show(struct seq_file *m, struct pid_namespace *ns,
 		     struct pid *pid, struct task_struct *tsk);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index c80fe99f85ae..d75ffd461222 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2235,45 +2235,6 @@ int cgroup_path_ns(struct cgroup *cgrp, char *buf, s=
ize_t buflen,
 }
 EXPORT_SYMBOL_GPL(cgroup_path_ns);
=20
-/**
- * task_cgroup_path - cgroup path of a task in the first cgroup hierarchy
- * @task: target task
- * @buf: the buffer to write the path into
- * @buflen: the length of the buffer
- *
- * Determine @task's cgroup on the first (the one with the lowest non-zero
- * hierarchy_id) cgroup hierarchy and copy its path into @buf.  This
- * function grabs cgroup_mutex and shouldn't be used inside locks used by
- * cgroup controller callbacks.
- *
- * Return value is the same as kernfs_path().
- */
-int task_cgroup_path(struct task_struct *task, char *buf, size_t buflen)
-{
-	struct cgroup_root *root;
-	struct cgroup *cgrp;
-	int hierarchy_id =3D 1;
-	int ret;
-
-	mutex_lock(&cgroup_mutex);
-	spin_lock_irq(&css_set_lock);
-
-	root =3D idr_get_next(&cgroup_hierarchy_idr, &hierarchy_id);
-
-	if (root) {
-		cgrp =3D task_cgroup_from_root(task, root);
-		ret =3D cgroup_path_ns_locked(cgrp, buf, buflen, &init_cgroup_ns);
-	} else {
-		/* if no hierarchy exists, everyone is in "/" */
-		ret =3D strlcpy(buf, "/", buflen);
-	}
-
-	spin_unlock_irq(&css_set_lock);
-	mutex_unlock(&cgroup_mutex);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(task_cgroup_path);
-
 /**
  * cgroup_migrate_add_task - add a migration target task to a migration co=
ntext
  * @task: target task
--=20
2.30.1


--1/tBU1JjKCYi4JT4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAmA1KaUACgkQia1+riC5
qSj6iw/+KM9ZHrO8LHe4huudTAA4UslnunDL7DeMWOO8qvCWXfW5qAfXsb8C/+TL
hLackrNtbaVvrTVT8bYtf6ie7aHMwrWS1SYcmx7t+1pSwjUry3MBALru/3M2l2P0
9JebE5iRyiESr4M0LeYYt2RmAw+upkGld5VQKAUoPujsee1q+ZRs07lz2sjSQs73
YJ9juFrUGcyP2IkUzRe4+YHjhMd4IoIpATUYzorS3uc3Q1EZaD0s4BjLIdRj6Z2E
ZW4PLBl7Tu0K+A/sXrYWhRpE8WZfjKXrs35QIsjK7KZhJ7DSxoDfyhfBb+6p5F3o
8LRM8ekF+9abw/3WBaKZjGNEG5iJp3Zet8xrnNZkGrVb6b8LoRYPF1t8aS1t6Kb8
dgLzYRsGO5VCrJhBkHgDN7XJIxA+hvKzUCAeU0DCBdw3koJyEtV8H4g5XJYHKB0f
r7UPn/vHvOoIXmmYIeRt8RZvXgqXlBIpzlPwYGCP6yC8mbaalKW/Ur6z1PCg9QV9
NNZ1oR+HhQFayDpUuouR/NR/BpnTByCiqeaCH3M591U+/rJGEpda9t+y0riHfzxC
kiIWdxSEczzG2OA8MIgf0OwVm7jdDwtVvCn3Al8F12HNvSlKJCEXfH2D0t1j8Cns
tfw2SvWhRtQPEhhwpqFF8FHq//HpSJakR+S/kidHhEu0SxBhtqc=
=mKOE
-----END PGP SIGNATURE-----

--1/tBU1JjKCYi4JT4--
