Return-Path: <cgroups+bounces-6219-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81555A14DE6
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 11:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C521882215
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 10:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2161FC0FC;
	Fri, 17 Jan 2025 10:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fILtG4W0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6CA1F76AD
	for <cgroups@vger.kernel.org>; Fri, 17 Jan 2025 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737110682; cv=none; b=Orh8jL1w0Zb/QJ6La+nfVmZXzNrtf0Uy1a94NQ/tvJ2bAQVFZ5PUOOlCIqon2FTdbvffKPQ3JNxpXz5pU9kX01RP+0YU1j4CI8CKAJFXQ0pl5zGriuLpwF4xtSxUxcLIeS3MT73+ZjpHSIUNURJxRqz2RTcWVY7tnlgnXQbSbv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737110682; c=relaxed/simple;
	bh=Bx/MtoWrWg82jUzhvuOnbTmdBMyVrEUnoOcDghnA3js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7xjpE//CneWl3MGH4eoA4Nqb9cMDejLvBg20PhasHwTp2xAe+z0HRNBzgUIGoaZ4ZFtWSRbigYufB0hA8oygWykXHYEfUeTuHp0Ed3ypAdCK5URbOUYSGQB/6WRHl/L521xfcy+KL/9usay4NhcFLkds/840KemOOvSLLRTD9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fILtG4W0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4368a293339so20643245e9.3
        for <cgroups@vger.kernel.org>; Fri, 17 Jan 2025 02:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737110678; x=1737715478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSHa/Z4jU1Iq9mWzXKLL31eCBwQbIWU3ZelXu160NPM=;
        b=fILtG4W083rC+DJ7jXrPq0sbWx5CdfE4WhsmA+A+uZIgiMjLfikuk7W7qLe+DQNvLY
         Hh7EDtu1YjezaTR7ZbUeBODLZlJK+sVo/546FsFKU8uWQZYqhMhc5NoZhvkbG4Bze+yJ
         y3ZNzhE4Q5gDvCUaXrb7Xa9nEHFEE5zPoybQAYElsXcydFg0PJkNCEzE1UtY29h/q/Y5
         lq5bvvCEMv6WJbkGh3S1KM5TH72W28GNOjAvnfkAhrk3XayW2nKjCAdS9atqwvta1622
         4SaQzGX15hg41nmWLsPQUWsBDnY8o+nwBFsZKqPYVfCJXCDY2LeIH9+AJcURp58L41Oe
         GalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737110678; x=1737715478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSHa/Z4jU1Iq9mWzXKLL31eCBwQbIWU3ZelXu160NPM=;
        b=iGHCFkzKoTo5kpdXJmGG/RXWhSC+pHE9h9cZ7m0QB1WraqxY09E8g1LrKPT0lqsD0h
         0id5rBz1AFe2rP5TwNDCnmoMcvPlt8QCtHIzm61q+jFxhH9OXiIMFc5oznkB0DeK2Joi
         FAHaj/0nlR5BZcZNTBfXn1LIazH1ZVKou+9kno5i7NPHYrXk897pSmHACvbCc5eQZl2O
         VAr7lyGkjKK4wcZuOP0z9Xc+1aWG08O8IZWD/naish5LaZKjYC41rpqNnEGq9At/stou
         O5rl6hA4Bfp1bI4c/siJlnmE1yjuu7YXlzGKDY1A04TJksgks6iauMd4TnctwszZmrZ5
         Q+Ag==
X-Forwarded-Encrypted: i=1; AJvYcCVYCERE9JGIMnNOy+7PUBP4CP50l6LEuArFprNJpz1HI0wHAoBrn2CCN0h1xnh93uujvijwvdyJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyvXGWyv5dKUwMmEBKxX6UM1QPCV9xj2/kX1jJCyAAIXyWh3OcN
	sYb/PJLdMZMe23AgdZ4lunIyEF7y+Olqxs80KJZw4zHTBXxQx5siDSN0eAz1VqV/CqyiUW2ZPPR
	P
X-Gm-Gg: ASbGncttezbKhbEfjcO/LJonrRpRMi7MJoMzvb6C/XigTAAxPvYAT17dPJQvpWgN9/z
	KSIGL1Sx83OIsyIZazcp8ttXefmsDyxtkvofk3YfQ1qjoQyTUXFFn7ILjejK+TZU0qYaYAa4V8a
	oog6l/jyaZnrfcMBaInmU7v0x6g/8Ji3wRoHuQJkX6vev+h5ygnciNe+FYYTVSvuyixc0WTfNK8
	qWAoF+jZQ6gQYHN18c6RHKSNuv7bHVH3ATWe7jL0ElEI8FzK+2qEPuKeOM=
X-Google-Smtp-Source: AGHT+IEIzKnOEISAzuAneR9SYLGn/1E1WPufonl4dtropiCcqhHtEjI3PQ7oICC/hKP4A/Anks/JTg==
X-Received: by 2002:a05:600c:524c:b0:435:23c:e23e with SMTP id 5b1f17b1804b1-438913db8d1mr21031955e9.12.1737110678046;
        Fri, 17 Jan 2025 02:44:38 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43890468869sm28737895e9.35.2025.01.17.02.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 02:44:37 -0800 (PST)
Date: Fri, 17 Jan 2025 11:44:36 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <llong@redhat.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Chen Ridong <chenridong@huawei.com>
Subject: [PATCH v2] cgroup/cpuset: Move procfs cpuset attribute under
 cgroup-v1.c
Message-ID: <7ft2u3u5kniyb6s7tcajsntvmn7kbico7yjclgamjlr5rgqvwk@vzfqbcivt77i>
References: <20250116095656.643976-1-mkoutny@suse.com>
 <b90d0be9-b970-442d-874d-1031a63d1058@redhat.com>
 <l7o4dygoe2h7koumizjqljs7meqs4dzngkw6ugypgk6smqdqbm@ocl4ldt5izmr>
 <Z4lA702nBSWNFQYm@slm.duckdns.org>
 <3ebd4519-4699-47ff-901e-a3ce30e45bcd@redhat.com>
 <Z4lgLxZXjoKuMh3r@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3mrvxbj4bxj7a4r7"
Content-Disposition: inline
In-Reply-To: <Z4lgLxZXjoKuMh3r@slm.duckdns.org>


--3mrvxbj4bxj7a4r7
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [PATCH v2] cgroup/cpuset: Move procfs cpuset attribute under
 cgroup-v1.c
MIME-Version: 1.0

The cpuset file is a legacy attribute that is bound primarily to cpuset
v1 hierarchy (equivalent information is available in /proc/$pid/cgroup path
on the unified hierarchy in conjunction with respective
cgroup.controllers showing where cpuset controller is enabled).

Followup to commit b0ced9d378d49 ("cgroup/cpuset: move v1 interfaces to
cpuset-v1.c") and hide CONFIG_PROC_PID_CPUSET under CONFIG_CPUSETS_V1.
Drop an obsolete comment too.

Signed-off-by: Michal Koutn=FD <mkoutny@suse.com>
---
 init/Kconfig              |  5 +++--
 kernel/cgroup/cpuset-v1.c | 40 +++++++++++++++++++++++++++++++++++
 kernel/cgroup/cpuset.c    | 44 ---------------------------------------
 3 files changed, 43 insertions(+), 46 deletions(-)

v2 changes:
- explicitly say what's part of CPUSETS_V1
- commit message wrt effective paths

diff --git a/init/Kconfig b/init/Kconfig
index a20e6efd3f0fb..2f3121c49ed23 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1182,7 +1182,8 @@ config CPUSETS_V1
 	help
 	  Legacy cgroup v1 cpusets controller which has been deprecated by
 	  cgroup v2 implementation. The v1 is there for legacy applications
-	  which haven't migrated to the new cgroup v2 interface yet. If you
+	  which haven't migrated to the new cgroup v2 interface yet. Legacy
+	  interface includes cpuset filesystem and /proc/<pid>/cpuset. If you
 	  do not have any such application then you are completely fine leaving
 	  this option disabled.
=20
@@ -1190,7 +1191,7 @@ config CPUSETS_V1
=20
 config PROC_PID_CPUSET
 	bool "Include legacy /proc/<pid>/cpuset file"
-	depends on CPUSETS
+	depends on CPUSETS_V1
 	default y
=20
 config CGROUP_DEVICE
diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 25c1d7b77e2f2..fff1a38f2725f 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -373,6 +373,46 @@ int cpuset1_validate_change(struct cpuset *cur, struct=
 cpuset *trial)
 	return ret;
 }
=20
+#ifdef CONFIG_PROC_PID_CPUSET
+/*
+ * proc_cpuset_show()
+ *  - Print tasks cpuset path into seq_file.
+ *  - Used for /proc/<pid>/cpuset.
+ */
+int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
+		     struct pid *pid, struct task_struct *tsk)
+{
+	char *buf;
+	struct cgroup_subsys_state *css;
+	int retval;
+
+	retval =3D -ENOMEM;
+	buf =3D kmalloc(PATH_MAX, GFP_KERNEL);
+	if (!buf)
+		goto out;
+
+	rcu_read_lock();
+	spin_lock_irq(&css_set_lock);
+	css =3D task_css(tsk, cpuset_cgrp_id);
+	retval =3D cgroup_path_ns_locked(css->cgroup, buf, PATH_MAX,
+				       current->nsproxy->cgroup_ns);
+	spin_unlock_irq(&css_set_lock);
+	rcu_read_unlock();
+
+	if (retval =3D=3D -E2BIG)
+		retval =3D -ENAMETOOLONG;
+	if (retval < 0)
+		goto out_free;
+	seq_puts(m, buf);
+	seq_putc(m, '\n');
+	retval =3D 0;
+out_free:
+	kfree(buf);
+out:
+	return retval;
+}
+#endif /* CONFIG_PROC_PID_CPUSET */
+
 static u64 cpuset_read_u64(struct cgroup_subsys_state *css, struct cftype =
*cft)
 {
 	struct cpuset *cs =3D css_cs(css);
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 0f910c828973a..7d6e8db234290 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4244,50 +4244,6 @@ void cpuset_print_current_mems_allowed(void)
 	rcu_read_unlock();
 }
=20
-#ifdef CONFIG_PROC_PID_CPUSET
-/*
- * proc_cpuset_show()
- *  - Print tasks cpuset path into seq_file.
- *  - Used for /proc/<pid>/cpuset.
- *  - No need to task_lock(tsk) on this tsk->cpuset reference, as it
- *    doesn't really matter if tsk->cpuset changes after we read it,
- *    and we take cpuset_mutex, keeping cpuset_attach() from changing it
- *    anyway.
- */
-int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
-		     struct pid *pid, struct task_struct *tsk)
-{
-	char *buf;
-	struct cgroup_subsys_state *css;
-	int retval;
-
-	retval =3D -ENOMEM;
-	buf =3D kmalloc(PATH_MAX, GFP_KERNEL);
-	if (!buf)
-		goto out;
-
-	rcu_read_lock();
-	spin_lock_irq(&css_set_lock);
-	css =3D task_css(tsk, cpuset_cgrp_id);
-	retval =3D cgroup_path_ns_locked(css->cgroup, buf, PATH_MAX,
-				       current->nsproxy->cgroup_ns);
-	spin_unlock_irq(&css_set_lock);
-	rcu_read_unlock();
-
-	if (retval =3D=3D -E2BIG)
-		retval =3D -ENAMETOOLONG;
-	if (retval < 0)
-		goto out_free;
-	seq_puts(m, buf);
-	seq_putc(m, '\n');
-	retval =3D 0;
-out_free:
-	kfree(buf);
-out:
-	return retval;
-}
-#endif /* CONFIG_PROC_PID_CPUSET */
-
 /* Display task mems_allowed in /proc/<pid>/status file. */
 void cpuset_task_status_allowed(struct seq_file *m, struct task_struct *ta=
sk)
 {
--=20
2.47.1


--3mrvxbj4bxj7a4r7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ4o0fAAKCRAt3Wney77B
SYzNAQCOuZqqQOfFkTfhJs478K400pCXtR4FUOuKMg3COv600gD9H3KMaUwJsNO7
/k/MouvBC4nG1Z0sm6N1yIOD07hzBQM=
=kIV0
-----END PGP SIGNATURE-----

--3mrvxbj4bxj7a4r7--

