Return-Path: <cgroups+bounces-8423-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3F6ACCA79
	for <lists+cgroups@lfdr.de>; Tue,  3 Jun 2025 17:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6201B16C185
	for <lists+cgroups@lfdr.de>; Tue,  3 Jun 2025 15:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C092B23C8AA;
	Tue,  3 Jun 2025 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Sk3m2LWv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC7122F767
	for <cgroups@vger.kernel.org>; Tue,  3 Jun 2025 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748965547; cv=none; b=O3s3RQgxCakAHH4/K7lNs7Tsgdjhged2BjGpAcdZAXerO5NvtgLWm9g1W3wp0g5oMU4VBo9T6foAbl4MEhq3Eq80Checcw5qt3NsNr5SkQjNVRThCA7DhUWOkzfOl1PO4TttxLbvWw0CJE8IHE/HziM/L6EWDARB5OSpXsHXtvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748965547; c=relaxed/simple;
	bh=eGLBU5Crh+XobfNjtR640S9EorM9CF+b4a8zt0WCYFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V3o+U3wZ4VeEMUZ3UcSsO5wwYapYBipnIPC7Ha/TYkPFmTqB5r3sEUtUM0qFijWNjuj5FVZbuwJ1qAavmqSGoGjgSkbvxXELEqXKvPhbDfTO/KIy22btbiZbKx+xOV6npmrt/HbYpd+1VYyfYjHEa/dr2D5PVl1cjp3s98I+aeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Sk3m2LWv; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so37480435e9.2
        for <cgroups@vger.kernel.org>; Tue, 03 Jun 2025 08:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748965542; x=1749570342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aYCUJ5XErr9UBRSuF7B/2bm/XCId19PjW+/NwwVgzs8=;
        b=Sk3m2LWvtzjHBuZtvhbOFHLA1HN96iu/McHNU13zZbnbnpWjhObmJbXyESGutN6+1y
         QKL+cI+F2OCRPppxqkoz04/prSgYGjv74Tk31yEOA6bXh5EUAEfvTmdWRtzvb7RgYakI
         QV49ceEd6767GZC39YQaA8ha70NPFYiCG3Y+weQcZI3hygJnDWOtMVPY7Ps0hACuSEkI
         V7phIvqZWtSsYVLwp+z2l61BallDPIfMJ1wef8wIYRpa9wF8A4oNHJfOUpmYYHuryaPS
         iFQsemKjktQHxQd/qoSCQ+2CySjieBaoE34QmXTBbMlxKc2cfkFU0Vv3+DTnc+dOX3dK
         ktCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748965542; x=1749570342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aYCUJ5XErr9UBRSuF7B/2bm/XCId19PjW+/NwwVgzs8=;
        b=BvwCVK7RQaBrb+/KF75KUuXWyxNms9xolf/GEpSn7xD90bd51XpuWlalKaNKJ/g/kh
         nG3v30VRhQBDKPZRNfHoBMDIykBp+smH4/DcAaTlkEvtD/OC6sDSDD3ctYWUDH+3FYwW
         BivhCsPOTdOESaTmbWEgD7zmL/bB1FqbJwpTBmoSn6Yco+OJPpFhv0HeYvYQNtihSpQS
         RYhvsywuu80TGZCN/FOSx0GSiqmC3wpfiVrOn5yPS98JcCW7HZvDnZow/CQtxkTShL7x
         CGQ3fUj0iiY+oidyHkk8o5CdFUNZ5BUnqjF7aqYbkUnm7F0XIQFZrk6/kmJLZE+yFtD6
         /qqg==
X-Gm-Message-State: AOJu0Yw/+EiOXIaX6PxA/DcKSIZYKb73qiTzE4mSMcjUxU0D+d5XNgqs
	YPrQ18jc6ts2uO+EyJjF/VdeD7xrQV+VPu0v60tStL+wYRhc+ul7Hj18s2Z4mmMrKRgrjaZrH+U
	NHRvuTq489w==
X-Gm-Gg: ASbGncuWmrKvnN821XHFPWraCu3ROGmwMDnwIsISMhfG1Zm8TvTMZCLpkB0OEuTJa7J
	1htjw5b+lh61eE2FxqKcMdEDy+4vJMXVYpLg/eLR23NzUoJbJ1JPkzXuIfMpJ39iqKtpa3xb7Lu
	7jTIJaO9A2lkflZnL6JuuAlPkWCDRYlW1XrezJn9CGt432mPCpxGX/o/K+E/iKr+iTpfkbgYimz
	WdU2j+GUf6O8/8nGwtsxwmJzoezq7pwYofNf/IJj8syT8HhbyT87v7JTU8xKYIOtJYH7vI8hkkE
	uSeS0hV65oC9LZ8zufm9xtfq6xbMZCUJV0bVqGcRnBm/lNYvoqhLxQ==
X-Google-Smtp-Source: AGHT+IFbA0YnJHJhQOXozYnQDP6QUHiCWnvi883uqWMIH3Z9yWJVTCPbll5VydzvLsFF5Sn0ybR3oQ==
X-Received: by 2002:a05:600c:3b8e:b0:450:c210:a01b with SMTP id 5b1f17b1804b1-450d6504a0cmr182782255e9.17.1748965542562;
        Tue, 03 Jun 2025 08:45:42 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450dcc18a80sm160128875e9.38.2025.06.03.08.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 08:45:42 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH] cgroup: Drop sock_cgroup_classid() dummy implementation
Date: Tue,  3 Jun 2025 17:45:27 +0200
Message-ID: <20250603154528.807949-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The semantic of returning 0 is unclear when !CONFIG_CGROUP_NET_CLASSID.
Since there are no callers of sock_cgroup_classid() with that config
anymore we can undefine the helper at all and enforce all (future)
callers to handle cases when !CONFIG_CGROUP_NET_CLASSID.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
Link: https://lore.kernel.org/r/Z_52r_v9-3JUzDT7@calendula/
Acked-by: Tejun Heo <tj@kernel.org>
---
 include/linux/cgroup-defs.h | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index e61687d5e496d..cd7f093e34cd7 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -898,14 +898,12 @@ static inline u16 sock_cgroup_prioidx(const struct sock_cgroup_data *skcd)
 #endif
 }
 
+#ifdef CONFIG_CGROUP_NET_CLASSID
 static inline u32 sock_cgroup_classid(const struct sock_cgroup_data *skcd)
 {
-#ifdef CONFIG_CGROUP_NET_CLASSID
 	return READ_ONCE(skcd->classid);
-#else
-	return 0;
-#endif
 }
+#endif
 
 static inline void sock_cgroup_set_prioidx(struct sock_cgroup_data *skcd,
 					   u16 prioidx)
@@ -915,13 +913,13 @@ static inline void sock_cgroup_set_prioidx(struct sock_cgroup_data *skcd,
 #endif
 }
 
+#ifdef CONFIG_CGROUP_NET_CLASSID
 static inline void sock_cgroup_set_classid(struct sock_cgroup_data *skcd,
 					   u32 classid)
 {
-#ifdef CONFIG_CGROUP_NET_CLASSID
 	WRITE_ONCE(skcd->classid, classid);
-#endif
 }
+#endif
 
 #else	/* CONFIG_SOCK_CGROUP_DATA */
 

base-commit: cd2e103d57e5615f9bb027d772f93b9efd567224
-- 
2.49.0


