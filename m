Return-Path: <cgroups+bounces-5737-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D66829E194E
	for <lists+cgroups@lfdr.de>; Tue,  3 Dec 2024 11:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40899B29D28
	for <lists+cgroups@lfdr.de>; Tue,  3 Dec 2024 09:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D011E008D;
	Tue,  3 Dec 2024 09:55:01 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9327410E3;
	Tue,  3 Dec 2024 09:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733219701; cv=none; b=CbBNlOZZ2qiSd6dPExRSyLWHlEcZoVZSwtjEOgrQMFtLtJ94EZdjUEU7rhA83Zb/C+VnziEt2X7y0RBAMVofpCr8r2PP3+8cyvNDzsjQtCaSms7b2tdZ+8etNcP+lK+erDeBYSfdjk2iAnh/8gu3NHDilSm/0Arp106gVuVSZ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733219701; c=relaxed/simple;
	bh=NMPPASBAaGqeeuIOlkhk+NbFh8iPCw/0pT25FffpvOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TDT2UVv8ufUFQpLvA/8AqOKyFEizAoG2mQybzCABAb/9kfhxIkM0mPmQ+r/FR4+VhfDaagqaBpRe/rTLtasdHMWfAL6SK5dlOW+Ox6sBgY2NoLU0Hjtl6QtrtlQlXAFnjQgkJlwb+qnbEeZkagCp1pfbXk0P3bt9IoYDcB6nBF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434acf1f9abso48715575e9.2;
        Tue, 03 Dec 2024 01:54:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733219698; x=1733824498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jgCr6iFMQ0xP+2mbLQ6BFFP+TLxrgnRYSs0t2kXPM80=;
        b=v4BlJ5mx9AXC/1brrV8RNHSNsNBrLXf067yIIZY06ph1WRPpDXnlVXxb4PSCKhYvaL
         4XXXz/uM8hro4avcuNG/L3VlnFIkTff8E/QSYVAMqBTGpgZdc+Da+ft8FM2lNX8Orz6c
         2iU1YVex3x+AwlNGmdFXQhpaB+/1Ed5ik6esFmUlvWfq+SeKo0aBVAphUCUFNsMWAJyH
         XSoNILIgZkNDsjJFWK0A10QU9BKyj8KxrMF/f/u8N7sb3kAtglwYDgNIQWmnJrUWoVPj
         Q8ny7cgBi5l7yRDP6Jso0IEmj+bBkz/iwXHqKf9VrNfr6ACNdGE2I3FIVBjd0PP3jWmn
         jxbA==
X-Forwarded-Encrypted: i=1; AJvYcCULGiIEtT8ujPQnS6gbMtjAiAm+JXPKKnggFk6fuR/waYmTo6RcrQoCou8pudzX+CuyjuCPjkVqilfEeBdo@vger.kernel.org, AJvYcCVA7PIJgzIfhLGTZSPc5H6THMR/Q7ZXyK7CQKhDDYcMrvwrZshtALAqDw7pp2dLu2Vrslvt5DtT@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9paRjQFdScGPG+UkoGPdHfVAhSHMEzFIrnqdUGKzjMVrZ5Cs1
	dj5eTyTjlC/YyPX73hwsFV97yudwAGLYUdeWcWRkdtboyLI+7hCSUW4RwUp/ODA=
X-Gm-Gg: ASbGncv5LrkDUM94IR/jj9/UAZsXRcgYZ3j1eJ06t7A5XdAh/ujtjJgwHjlzs123GI4
	D4asvSrXD5+DT7xUQN6dunA7I0mW2Eo36v3agshN12bfC9Z9GdMu6UCbJaM6EGIV3nWJzW79ugE
	kP7dasK4MSuyXrPTYPijreBLJbX0vyER5Dq/Dfv2UbKNCZ5MDVhMhi8pgjLQ+N7sVHNc7FTFS1Q
	5tk+L818bFXVnxtHjc5iav54ZydFpB1BpwFmQROEfe3GJwZv0ZHiNPhteA8K2scMhI=
X-Google-Smtp-Source: AGHT+IHsfT5XY2+RUUioVUiVTdR9559WL195PVC6Nv3+ZN1K1k0q1J/EfjR4hvmTVMX549Vbhbrmrg==
X-Received: by 2002:a05:600c:3c82:b0:434:a7e3:db50 with SMTP id 5b1f17b1804b1-434d0a08177mr12018945e9.21.1733219697665;
        Tue, 03 Dec 2024 01:54:57 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e280:5300:9068:704e:a31a:c135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385dd99504csm13027370f8f.85.2024.12.03.01.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 01:54:57 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH] cgroup/cpuset: Remove stale text
Date: Tue,  3 Dec 2024 11:54:13 +0200
Message-ID: <20241203095414.164750-2-costa.shul@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Paragraph "The task_lock() exception ...." was removed by
commit 2df167a300d7 ("cgroups: update comments in cpuset.c")

Remove stale text:
'See "The task_lock() exception", at the end of this comment.'
and reformat.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 kernel/cgroup/cpuset.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d5d2b4036314..c833a86f73ce 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -208,9 +208,8 @@ static struct cpuset top_cpuset = {
 /*
  * There are two global locks guarding cpuset structures - cpuset_mutex and
  * callback_lock. We also require taking task_lock() when dereferencing a
- * task's cpuset pointer. See "The task_lock() exception", at the end of this
- * comment.  The cpuset code uses only cpuset_mutex. Other kernel subsystems
- * can use cpuset_lock()/cpuset_unlock() to prevent change to cpuset
+ * task's cpuset pointer.  The cpuset code uses only cpuset_mutex. Other kernel
+ * subsystems can use cpuset_lock()/cpuset_unlock() to prevent change to cpuset
  * structures. Note that cpuset_mutex needs to be a mutex as it is used in
  * paths that rely on priority inheritance (e.g. scheduler - on RT) for
  * correctness.
-- 
2.47.0


