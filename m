Return-Path: <cgroups+bounces-6966-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225E7A5C166
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 13:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B65303A694D
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 12:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0134A2594BE;
	Tue, 11 Mar 2025 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="En5vfUC6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0932580D7
	for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 12:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696623; cv=none; b=Ko6132e4Y3yaCv6grp/cJsXTz2MqwfrykmSpV5cslKTJMAGHe/r/ZAyEQvV+ebVMQrAbgdGzYCClPwn5NJljpGiPrsrDazoZxSntiXPk441FiE3VJU43olEq3vAlSSmM+dNrMqKInJWtSCsgrYJ0dOBL7chE/G17vjaMf+dnLZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696623; c=relaxed/simple;
	bh=2ITt60hWHc0r3GvTb/7g3Havz5rR++GRpwzVkgyK8qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sYejXmS052ZDXSWHsRo+V6O94CNHaEjTpI7MlUwkJLvGOhIFw54acr6MvT/sTDezBdebR+aJBd0oMzOu1y6IDzvQ3Np57AJxL7m72JEckU2ZJS6sL1JC3rZOrvaKhezl83for8EydJisMrtYJVftbekx1TmlErXC+yedWXki6D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=En5vfUC6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so13093365e9.2
        for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 05:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741696620; x=1742301420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGCLGZxH43T6lkRYp7vhg0rX2pU6776/zsJhIa1Cwzg=;
        b=En5vfUC6n1lW9ea6SWdXarRWG6EOHOLhni0M5EXyae3vK/Hvzdj0A+EvLUWtLqmzcc
         H/bL7ThORYYtkaniYXHIBwJ88PrZcR1lr3a4FNg7kYp5ZueYeVz+MxhEclYnikMuCLCg
         mGaV8sfN/eQUUEryr07WbvNGFU6OnIA4pn7LXMkHnF6uH/aP06PVuKb5gXx+TGIXgoVQ
         yuKCNrGMrgTgjg1pa+NMrp6oh3mqC222VaEV1Lac2E3SjvGx1jKptJHpSG7TDoyL2uQ8
         DfRei6A/nm5CgdvkivpqQjXSQat4Mg1JUvEJS8hNiaOBRkG5WCpzPwOwwch1P6lmFWBB
         24iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741696620; x=1742301420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGCLGZxH43T6lkRYp7vhg0rX2pU6776/zsJhIa1Cwzg=;
        b=fyi5WZ1ni/uCyDBDP7BiC4wy0cUsR6DGdUp38ovOl4N6s/9vOwKiLIUlVgA8Tg9Ibn
         zzlTjLJS0aCS30Vs7K1+Z0H6Tqb5r8QbR9nY71gC8yIagydFsva55b+gx/7gI7BXCkC/
         03ndiuRqOm6IwF0YP9oKADdfm/Jtpg92ldeVCwuXbTbotGJWK2ctXJXyPYdH1+mRlaM2
         RID4tVustwDW0gussz1hkDHSvbfa/+zzEzBugxk8XvuA3V/H68/Ux5Pagyosfz300pLS
         syO/Tb02WL228iYuVGtI5eO/FZNbdI5KUxja7NcTtD7I4klAEGlnRpD70WNU4ItnnUvv
         EczA==
X-Gm-Message-State: AOJu0Yxa/oBs1K+b90JFKfDKfTaRS99QnP5dLpn+AjckSPZgw208TmU3
	x/HtQ54/VTGTVJtr/75fbT24m2PPLodCTWGobc5JxthEwScOPqKBugJ23TSTYTaVyd65GKwWZmg
	3sAA=
X-Gm-Gg: ASbGncvnEtC1exjAWZSjr+OjMEg17JKxGhY+7nYxXaAOks25duLQXLceAkuBFw0GC1G
	vabags/XfYQe6gW/mfGDpZlLob0sXtt5mmDUJxmYr0AEFY/HV8DOF1pUm0o9mUGhXH+xXWVXoeU
	cUb1zCz/+QjAX31oUmHfJ7qn98LgEYd9wDfWc759IfUXDSrh5cwFYVhCyzIFSsr8GIBEa63EIxe
	zfGm2wyfR8gXuqjkFNjV1Nw4tlZTxrajDj1VUse1arBcHc/H++Y451QKET9+mBVr/x1PWTAUR5s
	YKMuyhnVCuYQa3Lg73Ki8z+ucrKC6cTk5liEpa6nDep7yn8=
X-Google-Smtp-Source: AGHT+IF58w0f7YtTRozTF/uVQ4G2fK8Q6DSMhIynp+p7Thprd9B1hIoUoD3xl3YtV8/T5lnX+cBNhQ==
X-Received: by 2002:a05:600c:1547:b0:43c:fceb:91f with SMTP id 5b1f17b1804b1-43cfceb0aedmr81539955e9.11.1741696619822;
        Tue, 11 Mar 2025 05:36:59 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d04004240sm9742265e9.3.2025.03.11.05.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:36:59 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH v2 05/11] cgroup/cpuset-v1: Add deprecation messages to mem_exclusive and mem_hardwall
Date: Tue, 11 Mar 2025 13:36:22 +0100
Message-ID: <20250311123640.530377-6-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311123640.530377-1-mkoutny@suse.com>
References: <20250311123640.530377-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The concept of exclusive memory affinity may require complex approaches
like with cpuset v2 cpu partitions. There is so far no implementation in
cpuset v2.
Specific kernel memory affinity may cause unintended (global)
bottlenecks like kmem limits.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cpuset-v1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index fea8a0cb7ae1d..b243bdd952d78 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -424,9 +424,11 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 		retval = cpuset_update_flag(CS_CPU_EXCLUSIVE, cs, val);
 		break;
 	case FILE_MEM_EXCLUSIVE:
+		pr_info_once("cpuset.%s is deprecated\n", cft->name);
 		retval = cpuset_update_flag(CS_MEM_EXCLUSIVE, cs, val);
 		break;
 	case FILE_MEM_HARDWALL:
+		pr_info_once("cpuset.%s is deprecated\n", cft->name);
 		retval = cpuset_update_flag(CS_MEM_HARDWALL, cs, val);
 		break;
 	case FILE_SCHED_LOAD_BALANCE:
-- 
2.48.1


