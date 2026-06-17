Return-Path: <cgroups+bounces-17037-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NnOXJgGTMmpJ2QUAu9opvQ
	(envelope-from <cgroups+bounces-17037-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 14:28:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F5E699B60
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 14:28:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b="W4l/XXJY";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17037-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17037-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B0E233002D04
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 12:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6452D42188A;
	Wed, 17 Jun 2026 12:26:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8FD3F5BFD
	for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 12:26:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781699213; cv=none; b=nZoakxXw7PQFabtHSNiSU0yjT1nbRn2NW+v3kGFLP/Otg1Qj4+QUzdnRJsvtMA/8C/pidFVeVLHLb6IY0yqqMw/xbU2UOWVzXxZqGBOF5HH2o1/ZrhlBBs1ee8RZ0I9lnCWWiJw7PlVqLLbRwxqiyNd66cAwKXp+ecqW/hEq5oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781699213; c=relaxed/simple;
	bh=t5BISyRSybdyRVB4Kd5sDs3bmibV+j0fL1zqOzB12HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMsIeghs0b7/0h5hw66N2wWlfHMZHKO62RjL0GuS11mRT3AXTalIxLEANfYm/ohgOoAwAWBOQ4hc0jkKs9gpOdhcl82d/Rw0lb3+u/3RmC5GSK/efFtjZfNXngEUIRiKoWM1ime16JtlfFPFcda1ogjtMa761R+5/acM+X6xx0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W4l/XXJY; arc=none smtp.client-ip=209.85.128.54
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso8831485e9.0
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 05:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781699207; x=1782304007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F1QUUKaLC/Yp6GNmwaJDa63gpktICnRgKXbMRmfaFDY=;
        b=W4l/XXJYNH4+leSUIKmuHDknwfY2xt/rr4yMbaltePKiVzV4mcgKjcMHQN8SAD7WHA
         UzkT4NmbgqskIT55aJXYbd98Z0KOe3aaXuGKk7asN+RZtePYXApkgrn1gtnaU41EihEy
         /WGrQWApmAXVezn6pCvixKzEcAU5r95HBwbxBQddEK6JOOOYYx/aN+Oucx74MB6cbxvN
         OAVROfuC6DBh9HaQeNn133pFXGOoGLGpS05BPsas3LkLhxx/NzdCXvK2gVSZV4dWTwRH
         t05qlpSm4I0/k8bo7HlLBvQ80DWm/X3Ry07Fv2MgBXDmIaUdSehXj//14zzl8DSB15Ky
         Em1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781699207; x=1782304007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1QUUKaLC/Yp6GNmwaJDa63gpktICnRgKXbMRmfaFDY=;
        b=EG0r/nZzTG4kKhmsTvvlJE1hCqIpqDd+PsfrAbUa4ggH3VQ58yrrCayyxBNZq/z1RH
         L7uEl4ZlBtr6LKxbtsesbfKjfp5ZyjRmc3pjuYl29sOJSfNrwjtRsLK8ho3vhCHHFBO+
         C799HuQdj/qgVA9rI7zHd5UVn1LVVruuEKUe+LYfJ5IMbefuE1ObSs2EIHc7hV4nyFJB
         UxDjRrGqxstptezFHVJgfRWKq7Z9pCJ+W9XQfTBK/yySJrXsV3TVP5SciT9oQlAj2TL2
         Z87VKt6sp6Yqaqjb8dTCP2Hwp4/ngW+pcIWuPPXH1Jtv2j4p9QBd2c46QK9lmgUiTxAr
         jsrQ==
X-Forwarded-Encrypted: i=1; AFNElJ93pFGAt1eruzh9npNZnFOtjElsPk8lJ2Gi0f6RZEaXbLKpLgGn17HbD+9MgYyOX+bjC3mcSrt3@vger.kernel.org
X-Gm-Message-State: AOJu0Yzowgk4L1EHIxu/mttEg2SvS6DPsFpe91iSv5TlYg5lS5dMoXWQ
	BElpdT03BbA3n8PjF5B0fvtVSzDoVq3lxEyWWbYjqHPI68aSkkB3TqaLtv7xXYWWnrk=
X-Gm-Gg: Acq92OGyff6knAbCdJddWUE1G03cIOSzqY51l8uvBYSKSGz02Elh5kq4blonE77F3Ok
	E4qd/uRfJ2jGTo4K2rGnBJy+Vfdqr2jtnKmvdD0xIwLlj6g3N6C0cXFWkuJlldSTePZF8qv78RO
	gxxfyWkU9O6pC3pk+DGULSb4QgY65Esj7vbKA8smq95kfwztq9ahA9S+eknCFvTD7fyVQIpItCW
	mmfIEyLnOKkKrsupWPEvuRrCbuEB0Hz4V/hJrSrNnt/eonZHg/WGa/sB8ldqD4GAmxBGO0eT09D
	hAZyPYkmgmmMrLMihaVUxlzXTrn+fxiftV0eZnxIYuFcY6cLrBlIx7oiqP3unOLurcH/PM4ieb4
	g2N36pY038srsVaKiwj72CnwjHKyq4YNGNtCTCbekwm6nLTHnCQpI/b2iHZOPDsenBNNhr37nQI
	hZKPVnD5kvHtCHsrKmEA==
X-Received: by 2002:a05:600c:8285:b0:490:4b89:5372 with SMTP id 5b1f17b1804b1-492357da8b7mr20835875e9.11.1781699206568;
        Wed, 17 Jun 2026 05:26:46 -0700 (PDT)
Received: from localhost.localdomain ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a8ec56sm139769275e9.9.2026.06.17.05.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 05:26:45 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:26:43 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Li Wang <li.wang@linux.dev>
Cc: akpm@linux-foundation.org, tj@kernel.org, longman@redhat.com, 
	roman.gushchin@linux.dev, hannes@cmpxchg.org, yosry@kernel.org, jiayuan.chen@linux.dev, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, shuah@kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH v7 4/8] selftests/cgroup: rename PAGE_SIZE to BUF_SIZE in
 cgroup_util
Message-ID: <ajKCNAocU_BXxymR@localhost.localdomain>
References: <20260424040059.12940-1-li.wang@linux.dev>
 <20260424040059.12940-5-li.wang@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pntlo5ut2wdod2v4"
Content-Disposition: inline
In-Reply-To: <20260424040059.12940-5-li.wang@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,redhat.com,linux.dev,cmpxchg.org,gmail.com,kvack.org,vger.kernel.org,google.com];
	TAGGED_FROM(0.00)[bounces-17037-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:li.wang@linux.dev,m:akpm@linux-foundation.org,m:tj@kernel.org,m:longman@redhat.com,m:roman.gushchin@linux.dev,m:hannes@cmpxchg.org,m:yosry@kernel.org,m:jiayuan.chen@linux.dev,m:nphamcs@gmail.com,m:chengming.zhou@linux.dev,m:shuah@kernel.org,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mhocko@kernel.org,m:muchun.song@linux.dev,m:shakeel.butt@linux.dev,m:yosryahmed@google.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,suse.com:dkim,suse.com:email,suse.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93F5E699B60


--pntlo5ut2wdod2v4
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 4/8] selftests/cgroup: rename PAGE_SIZE to BUF_SIZE in
 cgroup_util
MIME-Version: 1.0

On Fri, Apr 24, 2026 at 12:00:55PM +0800, Li Wang <li.wang@linux.dev> wrote:
> The cgroup utility code defines a local PAGE_SIZE macro hardcoded to
> 4096, which is used primarily as a generic buffer size for reading cgroup
> and proc files. This naming is misleading because the value has nothing
> to do with the actual page size of the system. On architectures with larg=
er
> pages (e.g., 64K on arm64 or ppc64), the name suggests a relationship that
> does not exist. Additionally, the name can shadow or conflict with PAGE_S=
IZE
> definitions from system headers, leading to confusion or subtle bugs.
>=20
> To resolve this, rename the macro to BUF_SIZE to accurately reflect its
> purpose as a general I/O buffer size.
>=20
> Furthermore, test_memcontrol currently relies on this hardcoded 4K value
> to stride through memory and trigger page faults. Update this logic to
> use the actual system page size dynamically. This micro-optimizes the
> memory faulting process by ensuring it iterates correctly and efficiently
> based on the underlying architecture's true page size. (This part from Wa=
iman)
>=20
> Signed-off-by: Li Wang <li.wang@linux.dev>
> Signed-off-by: Waiman Long <longman@redhat.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Michal Koutn=FD <mkoutny@suse.com>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Nhat Pham <nphamcs@gmail.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  .../selftests/cgroup/lib/cgroup_util.c        | 18 +++++++++---------
>  .../cgroup/lib/include/cgroup_util.h          |  4 ++--
>  tools/testing/selftests/cgroup/test_core.c    |  2 +-
>  tools/testing/selftests/cgroup/test_freezer.c |  2 +-
>  .../selftests/cgroup/test_memcontrol.c        | 19 ++++++++++++-------
>  5 files changed, 25 insertions(+), 20 deletions(-)
>=20
> diff --git a/tools/testing/selftests/cgroup/lib/cgroup_util.c b/tools/tes=
ting/selftests/cgroup/lib/cgroup_util.c
> index 6a7295347e9..9be8ac25657 100644
> --- a/tools/testing/selftests/cgroup/lib/cgroup_util.c
> +++ b/tools/testing/selftests/cgroup/lib/cgroup_util.c
> @@ -140,7 +140,7 @@ int cg_read_strcmp_wait(const char *cgroup, const cha=
r *control,
> =20
>  int cg_read_strstr(const char *cgroup, const char *control, const char *=
needle)
>  {
> -	char buf[PAGE_SIZE];
> +	char buf[BUF_SIZE];
> =20
>  	if (cg_read(cgroup, control, buf, sizeof(buf)))
>  		return -1;
> @@ -170,7 +170,7 @@ long cg_read_long_fd(int fd)
> =20
>  long cg_read_key_long(const char *cgroup, const char *control, const cha=
r *key)
>  {
> -	char buf[PAGE_SIZE];
> +	char buf[BUF_SIZE];
>  	char *ptr;
> =20
>  	if (cg_read(cgroup, control, buf, sizeof(buf)))
> @@ -206,7 +206,7 @@ long cg_read_key_long_poll(const char *cgroup, const =
char *control,
> =20
>  long cg_read_lc(const char *cgroup, const char *control)
>  {
> -	char buf[PAGE_SIZE];
> +	char buf[BUF_SIZE];
>  	const char delim[] =3D "\n";
>  	char *line;
>  	long cnt =3D 0;
> @@ -258,7 +258,7 @@ int cg_write_numeric(const char *cgroup, const char *=
control, long value)
>  static int cg_find_root(char *root, size_t len, const char *controller,
>  			bool *nsdelegate)
>  {
> -	char buf[10 * PAGE_SIZE];
> +	char buf[10 * BUF_SIZE];
>  	char *fs, *mount, *type, *options;
>  	const char delim[] =3D "\n\t ";
> =20
> @@ -313,7 +313,7 @@ int cg_create(const char *cgroup)
> =20
>  int cg_wait_for_proc_count(const char *cgroup, int count)
>  {
> -	char buf[10 * PAGE_SIZE] =3D {0};
> +	char buf[10 * BUF_SIZE] =3D {0};
>  	int attempts;
>  	char *ptr;
> =20
> @@ -338,7 +338,7 @@ int cg_wait_for_proc_count(const char *cgroup, int co=
unt)
> =20
>  int cg_killall(const char *cgroup)
>  {
> -	char buf[PAGE_SIZE];
> +	char buf[BUF_SIZE];
>  	char *ptr =3D buf;
> =20
>  	/* If cgroup.kill exists use it. */
> @@ -548,7 +548,7 @@ int cg_run_nowait(const char *cgroup,
> =20
>  int proc_mount_contains(const char *option)
>  {
> -	char buf[4 * PAGE_SIZE];
> +	char buf[4 * BUF_SIZE];
>  	ssize_t read;
> =20
>  	read =3D read_text("/proc/mounts", buf, sizeof(buf));
> @@ -560,7 +560,7 @@ int proc_mount_contains(const char *option)
> =20
>  int cgroup_feature(const char *feature)
>  {
> -	char buf[PAGE_SIZE];
> +	char buf[BUF_SIZE];
>  	ssize_t read;
> =20
>  	read =3D read_text("/sys/kernel/cgroup/features", buf, sizeof(buf));
> @@ -587,7 +587,7 @@ ssize_t proc_read_text(int pid, bool thread, const ch=
ar *item, char *buf, size_t
> =20
>  int proc_read_strstr(int pid, bool thread, const char *item, const char =
*needle)
>  {
> -	char buf[PAGE_SIZE];
> +	char buf[BUF_SIZE];
> =20
>  	if (proc_read_text(pid, thread, item, buf, sizeof(buf)) < 0)
>  		return -1;
> diff --git a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h b/t=
ools/testing/selftests/cgroup/lib/include/cgroup_util.h
> index 567b1082974..febc1723d09 100644
> --- a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
> +++ b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
> @@ -2,8 +2,8 @@
>  #include <stdbool.h>
>  #include <stdlib.h>
> =20
> -#ifndef PAGE_SIZE
> -#define PAGE_SIZE 4096
> +#ifndef BUF_SIZE
> +#define BUF_SIZE 4096
>  #endif

I wouldn't preserve any previously defined BUF_SIZE here (as opposed to
possible more conventional PAGE_SIZE value).
I.e.

-#ifndef PAGE_SIZE
-#define PAGE_SIZE 4096
-#endif
+#define BUF_SIZE 4096

But it's nothing substantial.

> =20
>  #define MB(x) (x << 20)
> diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/s=
elftests/cgroup/test_core.c
> index 7b83c7e7c9d..88ca832d4fc 100644
> --- a/tools/testing/selftests/cgroup/test_core.c
> +++ b/tools/testing/selftests/cgroup/test_core.c
> @@ -87,7 +87,7 @@ static int test_cgcore_destroy(const char *root)
>  	int ret =3D KSFT_FAIL;
>  	char *cg_test =3D NULL;
>  	int child_pid;
> -	char buf[PAGE_SIZE];
> +	char buf[BUF_SIZE];
> =20
>  	cg_test =3D cg_name(root, "cg_test");
> =20
> diff --git a/tools/testing/selftests/cgroup/test_freezer.c b/tools/testin=
g/selftests/cgroup/test_freezer.c
> index 97fae92c838..160a9e6ad27 100644
> --- a/tools/testing/selftests/cgroup/test_freezer.c
> +++ b/tools/testing/selftests/cgroup/test_freezer.c
> @@ -642,7 +642,7 @@ static int test_cgfreezer_ptrace(const char *root)
>   */
>  static int proc_check_stopped(int pid)
>  {
> -	char buf[PAGE_SIZE];
> +	char buf[BUF_SIZE];
>  	int len;
> =20
>  	len =3D proc_read_text(pid, 0, "stat", buf, sizeof(buf));
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/tes=
ting/selftests/cgroup/test_memcontrol.c
> index b43da9bc20c..44338dbaee8 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -26,6 +26,7 @@
> =20
>  static bool has_localevents;
>  static bool has_recursiveprot;
> +static int page_size;
> =20
>  int get_temp_fd(void)
>  {
> @@ -34,7 +35,7 @@ int get_temp_fd(void)
> =20
>  int alloc_pagecache(int fd, size_t size)
>  {
> -	char buf[PAGE_SIZE];
> +	char buf[BUF_SIZE];

This buffer is actually used as the stride, so keeping it page-sized is
more sensible.

>  	struct stat st;
>  	int i;
> =20

--pntlo5ut2wdod2v4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCajKSfxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AhHwgEAkX4FwWHul4xsY8MctUcV
Vl/flepLLEiM/EKitqQPxNsBAJuVp8BQeVZpJQ29pFjdnPKSxvEJmQhD3mGHwEUf
A18N
=yJJi
-----END PGP SIGNATURE-----

--pntlo5ut2wdod2v4--

