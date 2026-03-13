Return-Path: <cgroups+bounces-14813-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBvhAnoytGn4igAAu9opvQ
	(envelope-from <cgroups+bounces-14813-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 16:51:22 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDF32865AF
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 16:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D7DB303D7FC
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 15:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CAB3BD65F;
	Fri, 13 Mar 2026 15:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OGCP2Y6t"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC64A1DD889
	for <cgroups@vger.kernel.org>; Fri, 13 Mar 2026 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773416732; cv=none; b=FoKodT+J8c6MBNc18ADj/N5ZH2W4Tz5mR89Q3FHEyn+rVDaK4upbYEKhA1pcIfhs1oKjUDv67nMGO+JYO8MhZYcITV2RNhue+Jp+URT4eUiQudg81hf+eF9kimYJoKZpwOb+ArWlJ0zTt9wIroPt9iO6eUD8W/8EuYadlfDsA5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773416732; c=relaxed/simple;
	bh=21bXOg0JQpJVdJaDBIhDYe1WUO9w0bqmWHBTbZ6vSew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jdN+dniiNQ5XLSM4hZJNnaKCymXTkAqWEgTahbnvwqmefBqzg3VESMOpQxseCJgVoyDd530jxKEXubpMKUEUaUlVLF65+YeOMmo3NJNVKSw6Hf5D0T0iviDKZACLGzc9ANyrV99/KTtUHFjtB6NuIz0siGY+0CRlwfFhCbQosmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OGCP2Y6t; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48539cbb7b1so13871015e9.3
        for <cgroups@vger.kernel.org>; Fri, 13 Mar 2026 08:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773416728; x=1774021528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8h0xBRZpJwupjrPCtc2DfsfhP5gGT2O2YpJh7upEqBM=;
        b=OGCP2Y6tWDqKUlM/o7JYj3ZLgo8EP8I8SVweL5YPiKSfBSyTwF9pXB8LXyH70oaOCh
         IfrJmwIsliDbv4oIx3b52GzTyc5N9HJy8mY2NM/xzshpaqRr1Ph8VybO+HoTf87IOZ/a
         ugV0JBBTlLIirLbM8hMMjZmpQ2fzmOtS/pVEvsCxWBy1m6JjYgwG8BcSzM3/3+70GdSU
         Xa/IDlKatAIgCnBPsRRHYuXM3ZPCBL1dplr9BaruN57mUVcZxGjiNgI+jrZWoPQsCrZj
         rNoYGdYqyrjpnfmSkqVwk8OEfxP+UOfjlmYcmbbrVaat/NiFkubGnXQmJsgWmXbsxpl8
         xzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773416728; x=1774021528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8h0xBRZpJwupjrPCtc2DfsfhP5gGT2O2YpJh7upEqBM=;
        b=bpYU68gS0d7tZgm4JAItDMM2rAB65zXLJy0CBocXjED0eEcz4Fmv0gJy1jLj/RqJhw
         ueErcJAWb593Pz9ZhIcn4TaMs3fsO6mHpRUbZCuFQ80PGu3WDtOHq+EUqclN5kajKXKv
         2CVa7DezvgikBhMjv+eQ7YoqHw1YapaChhQ1kmU493WybdYhdbMQ1+49pkY1fedvD/e9
         krYoAfjHULS18K4Ck89ksnmH/MjzVEkuDz5DnJur6Ig0QM+pr2LfMHGCiGJFFZQdaiZd
         txvLewuwkh6k7jPrnugRZ2K8S4QiEjNcfRlAS/6/7lqLcD5Ve2EGap4M5ty19yiI7J38
         S1HQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+LXrmgU+ELWecXl55lZU1I1aTvatbzcnMpycRT2nqiOWQEA9Bc8Oa8Ajqcfhqqd7/fW/FFe3b@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5J5cFEwFgLkd/w60lKqPkGT0DstHI4+iSWB59HuG1TN02LgC3
	0mItF6Z8bQp8OWToqmPiXyRrRIP7XK06HxrguEiymgPyyWShdETxo/Baw0cNcBeF07U=
X-Gm-Gg: ATEYQzyGRNOnvgoLY6h3CRocPgnF7RH53Vg5uFd3QXLZRfBGp6j5pmuN5zNsUocsMti
	Skhw0zU2HfMbHV+yTChr/9XAGblXutq4SpMb6MQU3crOGGAKsBSyeOeJ1eoCOrzk5fb1Yoro2iJ
	MH7HTDf41e6jignqsisS6CO+wsSydM8hHiMv+HmmVwrVJ/H8F5Z1xS3ge1+EP8t+UpcuIkAbwof
	rqljHvZgCEwQelsvz+Rv6fElEMUTLqMSCzODQwFKeSC5saSGOQJvy1Wb/DeaICPwiuzGti3jCxi
	KQUG2mJZvLee2OaIXl6+zAKrpEuHkilZylPF2WHwuPjImjBr+N8qocGYQp3mUKB176m7WU7jIKC
	pQSHx4VuCEbeTbfxGg3NPtNltbDaaUfhbH9hgj5j/BVBeUnHAjCf7jV/xLPc83t1XcWwYfdVr7i
	z2WaBupyed++q1JIDBLXVlFUnnOCb8UJo36TEL5j0=
X-Received: by 2002:a05:600c:6291:b0:485:4f20:1335 with SMTP id 5b1f17b1804b1-485566e1a39mr70343685e9.6.1773416728036;
        Fri, 13 Mar 2026 08:45:28 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20c473sm19009987f8f.24.2026.03.13.08.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 08:45:27 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>
Subject: [PATCH] cgroup/cpuset: Replace use of system_unbound_wq with system_dfl_wq
Date: Fri, 13 Mar 2026 16:45:20 +0100
Message-ID: <20260313154520.302888-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,redhat.com,huaweicloud.com,cmpxchg.org];
	TAGGED_FROM(0.00)[bounces-14813-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0DDF32865AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch continues the effort to refactor workqueue APIs, which has begun
with the changes introducing new workqueues and a new alloc_workqueue flag:

   commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
   commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The point of the refactoring is to eventually alter the default behavior of
workqueues to become unbound by default so that their workload placement is
optimized by the scheduler.

Before that to happen, workqueue users must be converted to the better named
new workqueues with no intended behaviour changes:

   system_wq -> system_percpu_wq
   system_unbound_wq -> system_dfl_wq

This way the old obsolete workqueues (system_wq, system_unbound_wq) can be
removed in the future.

Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 kernel/cgroup/cpuset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index e200de7c60b6..b399f5d0a158 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3937,7 +3937,7 @@ static void cpuset_handle_hotplug(void)
 	 * item at all, this is not a problem.
 	 */
 	if (update_housekeeping || force_sd_rebuild)
-		queue_work(system_unbound_wq, &hk_sd_work);
+		queue_work(system_dfl_wq, &hk_sd_work);
 
 	free_tmpmasks(ptmp);
 }
-- 
2.53.0


