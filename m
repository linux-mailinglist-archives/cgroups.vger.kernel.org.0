Return-Path: <cgroups+bounces-8764-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FE7B09F13
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 11:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9038617BB8A
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 09:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AE1296168;
	Fri, 18 Jul 2025 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A8Wx/dDa"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3FB295D96
	for <cgroups@vger.kernel.org>; Fri, 18 Jul 2025 09:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830341; cv=none; b=Wd6bfYycb/z5/980X2h2zI0foBeDqTzLxxcGWCBO6PQdj+gbr6kBjkrJ/mVwhZ8t80tHpNsPR12ZQfKUQkkLo0P8oRLNt+JUtqqWnavqtlUFDAvJKw+aam64cGu+f3tvsEAvaY2MqQuGZTW1i7yuTZFhri85km5qpYvhvxOn12g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830341; c=relaxed/simple;
	bh=i+Vq/xR72krYm0PnU071Yn9hfDeqbZjLHDI4rSfa0a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewwV45xF7JNakviQVaJW+wZz7lEyYqebOrVOSrSKuoXlYb6eIwulJNWDCi7FXRJ8WVv+2QzP7Zzxm8dniUFzUPJXiAly5Qnlxl0g75dEWBjAin+WccwCq7rlGndHifoP2WCDBeNTtC3jvr4e3Wge0Cj7ZhKO+7upfzbnalVax7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A8Wx/dDa; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae04d3d63e6so346704766b.2
        for <cgroups@vger.kernel.org>; Fri, 18 Jul 2025 02:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752830337; x=1753435137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=joBFBOMytxNNU/jMdqhGaVi+szdGw5RUwZA6YyI+ma0=;
        b=A8Wx/dDaY4X0eBACRtg7tsTzk4q75HZblAlH6o4ToicxFdo9waB9Qm1on9URQrTrCW
         FTR+0lGz6FBQXuCTkvzxaERoOCpoyyHfQpavhNORwt7lGTRmXYbMa9+qBOICMqE6M6eh
         /yABSPEHlJ3RvxoX0ka1pKepBUxVhi7itElrxtsi3OE3XlQGqW2aEP0UAdhnT8wZuWRG
         Fk5szLWXqx4CzzSO298rfdp/LiBfK9cTMFFAQxtvKIo96u2NSA3p+NtycfuuVyKlNLCw
         FyLA7xwQ4vaUJwiQQ32sBWxsfLBnP7GbAVbQnZ6vIwdclX1XwTcPlmwNEld6tHqskZYe
         cmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752830337; x=1753435137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joBFBOMytxNNU/jMdqhGaVi+szdGw5RUwZA6YyI+ma0=;
        b=w9frbd9uRR+tDJFYfx+ub1u6Ilp0Ez/FwvhlfOHZl2NPZCDLoJxUx8mW2F04J8RgA1
         6bWXklQ6MQ+0Ipza24Lg0IEFBwWIT4N31JE8N/FW9cVw0U1JDAC0rEvPERZJhbNyuNDL
         2/jt2+a/ELcdA5zyUKoC98qJfdut9746ti60vUU29U92LodP845v6i0ipiDDeUKv7frw
         H6xK1s1SQU8R2OirVTJMVPQxV/irEJbnEeAtOrNg4xcSTBdzN3WL8VPfL5Ka2eWPQECz
         fi9TEr5Kmi2cKRPDl+h1YBYwZr/l6LaFOzcwBuU9Dzi7I/xxLvhLwC/jnDtxj/OJqWCX
         A33g==
X-Gm-Message-State: AOJu0Yx9kOYFIGuKn2//e73Bx+3XLau3eOCcO2S2X4INAsLg/SonMcy+
	/r240++Bk9+Nt1tLspB3tOvjFn+osUlYcdzCX21lysVKg5Jfu7LO6vM74UG/J/+3tvMEjZUg7Fw
	I0urv
X-Gm-Gg: ASbGncvCRTDPhUy48gluDITNMKxxZuzHQ8pdergDWUlhBHjcsbrTvDwNdezcuPxfom6
	tVEQhWja3yPibAYc/3PbY5a8AWyxwIeAwVBShzUN++60KPt16zfOMtSRosgn9f+oAabpNeXXgeK
	QM3VrpWNz0glPXFFEgwYt0Am/nc8WgNzR4P5YqvlHddGLYuHPHficRLwP+VFXHR8vu21lbop5E4
	ybigrEAfZ+qCskjNLtzI4yWqzQjJtoSQEs6dMX0ORUKbuylzojpo9Qu9u5rlTxDvhZa3flzU/Vs
	njmGyHjuwp3gygQyQeEPPyCtuAqZ06AcJZpehFaUz5Bl3a7P06XJsFa16lhAXrdLrpDZ2UxFTbe
	fVJfucMOmGVFQGzo2qnY1lrvW8MgmqAcdxVlwGHOkwQ==
X-Google-Smtp-Source: AGHT+IGgzlzcp+poi8q6uuu7BU3aB58Ut4IdQD49YEpQkvDUzHt2FYW5lWaitH/yqU5HPqp9C13ynQ==
X-Received: by 2002:a17:907:26cd:b0:ae3:bb0a:1ccd with SMTP id a640c23a62f3a-ae9cde5a17amr905879966b.26.1752830336917;
        Fri, 18 Jul 2025 02:18:56 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca2efc1sm85811266b.83.2025.07.18.02.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 02:18:56 -0700 (PDT)
Date: Fri, 18 Jul 2025 11:18:54 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>, Ben Hutchings <ben@decadent.org.uk>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Chen Ridong <chenridong@huawei.com>, 1108294@bugs.debian.org
Subject: Re: [PATCH 4/4] cgroup: Do not report unavailable v1 controllers in
 /proc/cgroups
Message-ID: <7sbzasggfk3elhvxsd5mtuzd4yo3c64wuzkaulr7yqybpfxwuh@g6dcatriw7hx>
References: <20240909163223.3693529-1-mkoutny@suse.com>
 <20240909163223.3693529-5-mkoutny@suse.com>
 <b26b60b7d0d2a5ecfd2f3c45f95f32922ed24686.camel@decadent.org.uk>
 <bio4h3soa5a64zqca66fbtmur3bzwhggobplzg535erpfr2qxe@xsgzgxihirpa>
 <aHGM6_WOTWLiUdpU@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lv3ti64caqbl2n53"
Content-Disposition: inline
In-Reply-To: <aHGM6_WOTWLiUdpU@slm.duckdns.org>


--lv3ti64caqbl2n53
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/4] cgroup: Do not report unavailable v1 controllers in
 /proc/cgroups
MIME-Version: 1.0

On Fri, Jul 11, 2025 at 12:15:07PM -1000, Tejun Heo <tj@kernel.org> wrote:
> I think we still want to deprecate /proc/cgroups but given that there are
> impacted users maybe we can bring it back under a boottime param w/ warni=
ng?

Something like below? (I don't change the log level.)

Ben, the affected Java users could modify it at boot time. I saw your
revert is in v6.12, so you may also want backport of a0ab1453226d8 to
give the users a message. (I realize current->comm in the message would
be even more instructive.)

-- >8 --

=46rom ace88e9e3a77ff3fe86aee4b7a5866b3bfd2df58 Mon Sep 17 00:00:00 2001
=46rom: =3D?UTF-8?q?Michal=3D20Koutn=3DC3=3DBD?=3D <mkoutny@suse.com>
Date: Thu, 17 Jul 2025 17:38:47 +0200
Subject: [PATCH] cgroup: Add compatibility option for content of /proc/cgro=
ups
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

/proc/cgroups lists only v1 controllers by default, however, this is
only enforced since the commit af000ce85293b ("cgroup: Do not report
unavailable v1 controllers in /proc/cgroups") and there is software in
the wild that uses content of /proc/cgroups to decide on availability of
v2 (sic) controllers.

Add a boottime param that can bring back the previous behavior for
setups where the check in the software cannot be changed and it causes
e.g. unintended OOMs.

Also, this patch takes out cgrp_v1_visible from cgroup1_subsys_absent()
guard since it's only important to check which hierarchy (v1 vs v2) the
subsys is attached to. This has no effect on the printed message but
the code is cleaner since cgrp_v1_visible is really about mounted
hierarchies, not the content of /proc/cgroups.

Link: https://lore.kernel.org/r/b26b60b7d0d2a5ecfd2f3c45f95f32922ed24686.ca=
mel@decadent.org.uk
Fixes: af000ce85293b ("cgroup: Do not report unavailable v1 controllers in =
/proc/cgroups")
Fixes: a0ab1453226d8 ("cgroup: Print message when /proc/cgroups is read on =
v2-only system")
Signed-off-by: Michal Koutn=FD <mkoutny@suse.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  8 ++++++++
 kernel/cgroup/cgroup-v1.c                       | 14 ++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentatio=
n/admin-guide/kernel-parameters.txt
index 07e22ba5bfe34..f6d317e1674d6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -633,6 +633,14 @@
 			named mounts. Specifying both "all" and "named" disables
 			all v1 hierarchies.
=20
+	cgroup_v1_proc=3D	[KNL] Show also missing controllers in /proc/cgroups
+			Format: { "true" | "false" }
+			/proc/cgroups lists only v1 controllers by default.
+			This compatibility option enables listing also v2
+			controllers (whose v1 code is not compiled!), so that
+			semi-legacy software can check this file to decide
+			about usage of v2 (sic) controllers.
+
 	cgroup_favordynmods=3D [KNL] Enable or Disable favordynmods.
 			Format: { "true" | "false" }
 			Defaults to the value of CONFIG_CGROUP_FAVOR_DYNMODS.
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index fa24c032ed6fe..2a4a387f867ab 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -32,6 +32,9 @@ static u16 cgroup_no_v1_mask;
 /* disable named v1 mounts */
 static bool cgroup_no_v1_named;
=20
+/* Show unavailable controllers in /proc/cgroups */
+static bool proc_show_all;
+
 /*
  * pidlist destructions need to be flushed on cgroup destruction.  Use a
  * separate workqueue as flush domain.
@@ -683,10 +686,11 @@ int proc_cgroupstats_show(struct seq_file *m, void *v)
 	 */
=20
 	for_each_subsys(ss, i) {
-		if (cgroup1_subsys_absent(ss))
-			continue;
 		cgrp_v1_visible |=3D ss->root !=3D &cgrp_dfl_root;
=20
+		if (!proc_show_all && cgroup1_subsys_absent(ss))
+			continue;
+
 		seq_printf(m, "%s\t%d\t%d\t%d\n",
 			   ss->legacy_name, ss->root->hierarchy_id,
 			   atomic_read(&ss->root->nr_cgrps),
@@ -1359,3 +1363,9 @@ static int __init cgroup_no_v1(char *str)
 	return 1;
 }
 __setup("cgroup_no_v1=3D", cgroup_no_v1);
+
+static int __init cgroup_v1_proc(char *str)
+{
+	return (kstrtobool(str, &proc_show_all) =3D=3D 0);
+}
+__setup("cgroup_v1_proc=3D", cgroup_v1_proc);
--=20
2.50.0


--lv3ti64caqbl2n53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaHoRfAAKCRB+PQLnlNv4
CJVaAP9sO+/2YiTwceG9v6JkcxV5hfVwLBHieERy+1l7jsbjAAD/QSfBAgM5hcw1
bXWYcQUKpYEwRHUR8Ir+zw4u8U1lMQc=
=hiX6
-----END PGP SIGNATURE-----

--lv3ti64caqbl2n53--

