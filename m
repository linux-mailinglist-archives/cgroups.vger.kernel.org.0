Return-Path: <cgroups+bounces-6162-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA884A118AF
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2025 06:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396673A1470
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2025 05:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3535F155CBF;
	Wed, 15 Jan 2025 05:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiDf1IHL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686F9232440;
	Wed, 15 Jan 2025 05:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736917535; cv=none; b=Zp+qWzd7rpvckgBLOG61ZQUdW+Np4cCO2ql3Mgjpyh5uU4CzTzqxu3u+0oaOu7maWo4yihK3l3bmJUtstlzm0lGt9qdjkYvaqAMdd9GdEngGRJKECgZXzSE9AgmbzU14Bd5ykUCT4rqrMDu8SEcwV7mx1+0YP00KtxqdkX3bzK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736917535; c=relaxed/simple;
	bh=8et3Wlgn1FaExiphtErdGIVdVSZ7lmVNJRR4NPVm6Is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=LEWHdZjizGtODD3Y4T009Z87E9hjXGmMzodbxLywsYB5atHaqjnal9qEdve+H8IRkFXE042WJCG52Lag/T48R3u560NCgebeVrsbH9GJoJ05HxPJw52iuifAguXggyC4Nzx2FO5m8jXgjDQggNP2tJPp/Shq+pY0nbe4u8qEgT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiDf1IHL; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-860f0e91121so294712241.0;
        Tue, 14 Jan 2025 21:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736917532; x=1737522332; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ow/IRyN+cemWyTkrDl3bh0gJC+EkqRfEmUEIN6uUVCg=;
        b=hiDf1IHLfOe6qig1ZRvYdIMSgZC5gJnTqp7MRzL4nWJT85HgTjGwWWdPl1YrzhMByd
         2sWTcZxNuhC+11dfeyHNRwbDYnJEEDY+dNzm1cBP06qH4hZQXhQT+6uB1mJhw0ge+9Du
         gEWqDpXRKnK/M637U2eGS6visAoFUT7aidWgMHYRfK+tz5w0j9se4xb6aPR1eI1eZDBN
         tRprdL7575Gv0x5yT5Ys4w2PZI9UA0yB3Py8SD3WnBVFnE/Tu1BBM2IxHdhAr1lf3d5u
         Gt7ajIj4piTSbzr+nTBraD9jkS0DHezGuQa9n2J1LejwL8EvyYEQc03fIDtW8Up+3Om+
         2G9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736917532; x=1737522332;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ow/IRyN+cemWyTkrDl3bh0gJC+EkqRfEmUEIN6uUVCg=;
        b=iyzDieH/jxQEQyqCXTKVdOx5kqSwCIFzaiz6lxABsBe9dR2zI1+VDiwaO1lYm68PCx
         JBCHtSO/IrIlJ/QfgUGGJEeKIt8aO+Up1wFyVLuOGhA7pOUQMwxiCtAWRr5imcC2ynO4
         2vdMoE1WTgb25usaU+64ye+/V8wx4erXe9z/N5pZFj1zLNQZ3pIuZ+jC46Ya1YK3WEsE
         O+Ba4QFEvSeRh/rSTghQUGVlkvE8FB2R4PpMnmScsaam64ROEWpw50IsShqkRvBgHOgA
         EypYXxgL4Z8Zx745opvOCcuBCKEdD8s3jzfHHdC49R7hQvR9fbNu9EXkWufncjX8LnzF
         cWbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrfLB+CZsUKIhxsYq8aThdLuLiQ0DfY6AUXdyAn3eW04bgBeqxa0zpTgjTxo8wj+MecAlReKSt@vger.kernel.org, AJvYcCVm5PjLH8VNOn50Q3zGsvwbK0ySpb/p2OXQ2yKDishA02wbQfnd++sLiGVRXUOud2UuWso66UYjLfJH3EON@vger.kernel.org
X-Gm-Message-State: AOJu0YwGltwb4E5tgnYxvYS555ER8LRVV9z1mUfwCUiQ1YBhasllmXiN
	jIOzYEgLFvRfuxs4o0I/GJRl8lSCbkt4vXdKZgZGedhFRA+OIbF8PNLVTsu7qWXEaoP65CTxVkg
	/lqKZOq7jHm0NHOABcQYUeIyFI+jSCpLz
X-Gm-Gg: ASbGnctI9EYMz64gccBouCVZIFl2T4eiNYUAqYgFqRpHKvYuNKvcMxjQz7fiAuPlRyi
	hCh5FuAF5yeLgWSoTowCdI4PWnnZINEqwd0EbNuI=
X-Google-Smtp-Source: AGHT+IEPIjE/yt1kBlHDkhiExpjHdJ/cUXgYRnLu3AB3J3DWNRi2NpSk/MmzmEe2wdBeS6sApxlZu6RBtrJqKE7x55g=
X-Received: by 2002:a05:6102:374e:b0:4af:fc7d:b74a with SMTP id
 ada2fe7eead31-4b669ed1ac0mr1202429137.2.1736917532171; Tue, 14 Jan 2025
 21:05:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3a5337f9-9f86-4723-837e-de86504c2094.jinguojie.jgj@alibaba-inc.com>
In-Reply-To: <3a5337f9-9f86-4723-837e-de86504c2094.jinguojie.jgj@alibaba-inc.com>
From: Jin Guojie <guojie.jin@gmail.com>
Date: Wed, 15 Jan 2025 13:05:21 +0800
X-Gm-Features: AbW1kvbNg6ANiJ99w8o31FxA5RfybMfm6xTCDD94IoQ7KyHDqFw5PHpFVmraiTw
Message-ID: <CA+B+MYQD2K0Vz_jHD_YNnnTcH08_+N=_xRBb7qfvgyxx-wPbiw@mail.gmail.com>
Subject: [PATCH v2] cgroup/cpuset: call fmeter_init() when cpuset.memory_pressure
 disabled
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When running LTP's cpuset_memory_pressure program, the following error occu=
rs:

(1) Create a cgroup, enable cpuset subsystem, set memory limit, and
then set cpuset_memory_pressure to 1
(2) In this cgroup, create a process to allocate a large amount of
memory and generate pressure counts
(3) Set cpuset_memory_pressure to 0
(4) Check cpuset.memory_pressure: LTP thinks it should be 0, but the
current kernel returns a value of 1, so LTP determines it as FAIL

V2:
* call fmeter_init() when writing 0 to the memory_pressure_enabled

Compared with patch v1 [1], this version implements clearer logic.

[1] https://lore.kernel.org/cgroups/CA+B+MYRNsdKcYxC8kbyzVrdH9fT8c2if5UxGgu=
Kep36ZHe6HMQ@mail.gmail.com/T/#u

Signed-off-by: Jin Guojie <guojie.jin@gmail.com>
Suggested-by: Michal Koutn=C3=BD <mkoutny@suse.com>
Suggested-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset-v1.c | 4 +++-
 kernel/cgroup/cpuset.c    | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 25c1d7b77e2f..7520eb31598a 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -66,7 +66,6 @@ void fmeter_init(struct fmeter *fmp)
        fmp->cnt =3D 0;
        fmp->val =3D 0;
        fmp->time =3D 0;
-       spin_lock_init(&fmp->lock);
 }

 /* Internal meter update - process cnt events and update value */
@@ -437,6 +436,9 @@ static int cpuset_write_u64(struct
cgroup_subsys_state *css, struct cftype *cft,
                break;
        case FILE_MEMORY_PRESSURE_ENABLED:
                cpuset_memory_pressure_enabled =3D !!val;
+               if (cpuset_memory_pressure_enabled =3D=3D 0) {
+                       fmeter_init(&cs->fmeter);
+               }
                break;
        case FILE_SPREAD_PAGE:
                retval =3D cpuset_update_flag(CS_SPREAD_PAGE, cs, val);
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 0f910c828973..3583c898ff77 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3378,6 +3378,7 @@ cpuset_css_alloc(struct cgroup_subsys_state *parent_c=
ss)

        __set_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
        fmeter_init(&cs->fmeter);
+       spin_lock_init(&cs->fmeter.lock);
        cs->relax_domain_level =3D -1;
        INIT_LIST_HEAD(&cs->remote_sibling);

@@ -3650,6 +3651,7 @@ int __init cpuset_init(void)
        nodes_setall(top_cpuset.effective_mems);

        fmeter_init(&top_cpuset.fmeter);
+       spin_lock_init(&top_cpuset.fmeter.lock);
        INIT_LIST_HEAD(&remote_children);

        BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
--
2.34.1

