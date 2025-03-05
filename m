Return-Path: <cgroups+bounces-6848-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C89B3A50615
	for <lists+cgroups@lfdr.de>; Wed,  5 Mar 2025 18:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3F457AB05F
	for <lists+cgroups@lfdr.de>; Wed,  5 Mar 2025 17:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1360519ABA3;
	Wed,  5 Mar 2025 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P1p3UOO0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893941AAE28
	for <cgroups@vger.kernel.org>; Wed,  5 Mar 2025 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741194582; cv=none; b=uO0VzDGhivPUb+raTpjPzJ93AngayxzxE9BMZfyUZBcj8VZpolnq+DgIwPh3BJoa6p6B4k5OKRY4z87S5wdn6x6Qjl8rLeL0BYvWXwagbpBfNBnat9eSN7SjSvrk0eJvKpbLg31Qrbcq2l9rANvc9NRVWK5yLpeOX422PpIy26c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741194582; c=relaxed/simple;
	bh=irFcCVMJ+YoW6k8byXnRJIVW9wTUS4yGDTwhsoaB6Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I2gGiM9WdvoC0vM5LePqwWfNmfDTZP2Ky7fH2Qj175KSsHpZSdnFAKHmRPG2s8xPDgoBSf6lk2Q05xWIUKrhnyx0Qp+BlWcXGeSWd5pGX7Hqdkgvd7Tk/RKhSz4dPdYuVsWILioeb+YROiAEoFMDRI/COzkx+YkiTtadnFWotB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P1p3UOO0; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-43bd5644de8so9491165e9.3
        for <cgroups@vger.kernel.org>; Wed, 05 Mar 2025 09:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741194579; x=1741799379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Xwduz/qNPiyy4RhwG9d9PScJsmgmVdCqCQSC6jOGw4=;
        b=P1p3UOO0b9YDJTFpWR4YE+ZSKZf6Xcn52yudVG+sPHwyBxBtardW009r9baCZcBeB4
         4YrBwUNx2JnWKUZCwE8P5GXIHIEPQ0jNvCevdy2YOChbqBHkzpHt/1wzFn5RYouw4lg7
         Ubnyj/AmJTt084JQMIhTcWp0jpVFjR0Xndt2RDe864mTy2ddPAAr0onst3U6rKkFxD45
         H0M4bgWyKxC98MlJmxb9oAlG/J9F2VNQt4FJxc+tUtjyiDfKCDHtPn8v130bldZUxkdd
         1L/Pie03mBgGdJDVfupW8ScDCv5mNHuWB5VmdaSSZ68xZEXatoTBkzENiNCy/KsCr8T5
         oqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741194579; x=1741799379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Xwduz/qNPiyy4RhwG9d9PScJsmgmVdCqCQSC6jOGw4=;
        b=qQ1QnGPFkMOYv9HpFUIT9+7+MoCvijVMYoAGsQ7joz29Jdg4mcFNhZbAiSdNRSGLvG
         +ezeGVSHyzGl0FE99gCfIJLlWWWLentRaLMLGH/+g49rQhtvo1y3VzIlbeAv30oFMSgl
         kQIFGagxdgMoDEhvaIKPNnycDG9tE9ZGsCODm3gvIIT5eSH+krQW++b3j3BDUtv8cVV0
         BU9IAvBhbl5ubp8OmPsyp1JIAAssAgRhtINGQcpWqsO8HENEhP23sg45+B9epz3FlMU+
         4mPoAAbvzng3kCm5PD0BEzght1QN2IuCAaJlrsOYgvFurtff1WR8WkVlkKW7t9FPm1Ir
         zHvA==
X-Forwarded-Encrypted: i=1; AJvYcCVhWXTgGK5kaXVqhJ+SkOmIM5lHR5d7f+huCK8N+A+SOFBTbb8XRGerIYA/iF1PTYKFmHg/S/av@vger.kernel.org
X-Gm-Message-State: AOJu0YysqcPuclkbcmXmPiltc6VeZvjMbLfT5moyS89mTEj/RlLLRvnE
	8vlDfwknYOoGJVCLNuNWXCCrLLimc1Jzzj8GYVseXbRrl3w2fPH22cMxnnG9Axc=
X-Gm-Gg: ASbGncvRss2QE7hBdsahAG/fcLL5GEtj5rgaVcDfzVzZ9V5QccnORjrn5Ilb816ZHzn
	Dw3kPbEzOzB4BqV8RlU7YOg0l95a+IaEGr4Yo/tAryPnvhTz8WqNwZ+D3Ec+7jP9adBd5EoumDm
	O96wazhsqHpkb/3Tan8YAT82kq5PUEId6YZNhZNg+/mtdxSX5THNjcjPVEjPlLetMH3e0kY0ap7
	JB8OdTApeL5G2OFaI9TaZx9E0Qdmckd42IjNbTPcu1IUhaozq6S0zyQPmbccB/AW5/q6Fd8WV1J
	OGtJHAifvd3RMX67VuUu3SdBPt+jlFINWiR894wOFUmry/U=
X-Google-Smtp-Source: AGHT+IHtALOlZRY8OEkAfMy/8LP4eO3WEczzKfPhSQDmbP+zhNlJTZUTR0mJ/R+5FMnzK/l5vhD0mw==
X-Received: by 2002:a05:600c:1d01:b0:43b:cf12:2ca6 with SMTP id 5b1f17b1804b1-43bd292e1cemr28484335e9.1.1741194578635;
        Wed, 05 Mar 2025 09:09:38 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b6ceesm21323862f8f.45.2025.03.05.09.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 09:09:38 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	cgroups@vger.kernel.org,
	Jan Engelhardt <ej@inai.de>,
	Florian Westphal <fw@strlen.de>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [PATCH v2] netfilter: Make xt_cgroup independent from net_cls
Date: Wed,  5 Mar 2025 18:09:35 +0100
Message-ID: <20250305170935.80558-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The xt_group matching supports the default hierarchy since commit
c38c4597e4bf3 ("netfilter: implement xt_cgroup cgroup2 path match").
The cgroup v1 matching (based on clsid) and cgroup v2 matching (based on
path) are rather independent. Downgrade the Kconfig dependency to
mere CONFIG_SOCK_GROUP_DATA so that xt_group can be built even without
CONFIG_NET_CLS_CGROUP for path matching.
Also add a message for users when they attempt to specify any
non-trivial clsid.

Link: https://lists.opensuse.org/archives/list/kernel@lists.opensuse.org/thread/S23NOILB7MUIRHSKPBOQKJHVSK26GP6X/
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 net/netfilter/Kconfig     |  2 +-
 net/netfilter/xt_cgroup.c | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

Changes from v1 (https://lore.kernel.org/r/20250228165216.339407-1-mkoutny@suse.com)
- terser guard (Jan)
- verboser message (Florian)
- better select !CGROUP_BPF (kernel test robot)

diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index df2dc21304efb..346ac2152fa18 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -1180,7 +1180,7 @@ config NETFILTER_XT_MATCH_CGROUP
 	tristate '"control group" match support'
 	depends on NETFILTER_ADVANCED
 	depends on CGROUPS
-	select CGROUP_NET_CLASSID
+	select SOCK_CGROUP_DATA
 	help
 	Socket/process control group matching allows you to match locally
 	generated packets based on which net_cls control group processes
diff --git a/net/netfilter/xt_cgroup.c b/net/netfilter/xt_cgroup.c
index c0f5e9a4f3c65..c3055e74aa0ea 100644
--- a/net/netfilter/xt_cgroup.c
+++ b/net/netfilter/xt_cgroup.c
@@ -23,6 +23,13 @@ MODULE_DESCRIPTION("Xtables: process control group matching");
 MODULE_ALIAS("ipt_cgroup");
 MODULE_ALIAS("ip6t_cgroup");
 
+#define NET_CLS_CLASSID_INVALID_MSG "xt_cgroup: classid invalid without net_cls cgroups\n"
+
+static bool possible_classid(u32 classid)
+{
+	return IS_ENABLED(CONFIG_CGROUP_NET_CLASSID) || classid == 0;
+}
+
 static int cgroup_mt_check_v0(const struct xt_mtchk_param *par)
 {
 	struct xt_cgroup_info_v0 *info = par->matchinfo;
@@ -30,6 +37,11 @@ static int cgroup_mt_check_v0(const struct xt_mtchk_param *par)
 	if (info->invert & ~1)
 		return -EINVAL;
 
+	if (!possible_classid(info->id)) {
+		pr_info(NET_CLS_CLASSID_INVALID_MSG);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -51,6 +63,11 @@ static int cgroup_mt_check_v1(const struct xt_mtchk_param *par)
 		return -EINVAL;
 	}
 
+	if (!possible_classid(info->classid)) {
+		pr_info(NET_CLS_CLASSID_INVALID_MSG);
+		return -EINVAL;
+	}
+
 	info->priv = NULL;
 	if (info->has_path) {
 		cgrp = cgroup_get_from_path(info->path);
@@ -83,6 +100,11 @@ static int cgroup_mt_check_v2(const struct xt_mtchk_param *par)
 		return -EINVAL;
 	}
 
+	if (info->has_classid && !possible_classid(info->classid)) {
+		pr_info(NET_CLS_CLASSID_INVALID_MSG);
+		return -EINVAL;
+	}
+
 	info->priv = NULL;
 	if (info->has_path) {
 		cgrp = cgroup_get_from_path(info->path);

base-commit: dd83757f6e686a2188997cb58b5975f744bb7786
-- 
2.48.1


