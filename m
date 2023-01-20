Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AA0675E64
	for <lists+cgroups@lfdr.de>; Fri, 20 Jan 2023 20:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjATTtL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Jan 2023 14:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjATTtK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Jan 2023 14:49:10 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA111917EC
        for <cgroups@vger.kernel.org>; Fri, 20 Jan 2023 11:49:04 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d2so5759734wrp.8
        for <cgroups@vger.kernel.org>; Fri, 20 Jan 2023 11:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U1fLfhP+Gt35sMsNmrxRVX9NnAlPOzN2tCmzAKeG25c=;
        b=fKL1gUuQQfN6lRf5NSg53u6eZGlPjqy4XoEJ5j3qxOPk/2Hu6yEAVzixdXJRaTDZHl
         sz5xMdaT8RP5E85DS1uxDdK46TTWtLtnZ/x4Xs92L+JUCAI+PZUV5kkrFflkbEX7H5oE
         xuCXDPnhzCKaEB2yXbzOmKW8xXB/KiD0OSHJ3h8CmSMpFUtMubbkDXZVrb7dEdDAI+uy
         0qOPjtjNkVtu+ry4neyo6eB/N6RdaP32R9YnfWq3p1kn/tZtx2r2WpeQBuAugU1vn2YH
         Em765RcL91Qhe6XjlgouI94lBmYTsv15xUwAwpqV0q32yxOFM0TivIHU0+9efciVircU
         QuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U1fLfhP+Gt35sMsNmrxRVX9NnAlPOzN2tCmzAKeG25c=;
        b=ARF4MGoQQFGqfBUGmhJ3+5qq1IIpdLO2DhmpDFRutwgBsoAOA2iHIqc0YQxdgmXrrj
         kogK/8oa8+vSUe/XUNra4cz5ScrVhGxlER2yAN61byoJ2EkPc1Az9bqdt1ryrb8ktl3i
         vobe6MN57apEdT/ypffU4VwiCXhTnOjPp3LN9sNeQK5VZeqnC3UTKrIUjOt2pbsGMmRP
         K98qdawUWNvQrq9tSld+abz0OX4NPa+yqaG3oJ/8FOWLbG0AXAdJcK/wzcrlj6cUmdNJ
         eaVw6Q51U25JJYQH3b/j4G9TQUbY6j6ZwOA430B4GVAacuEfr7UKViN+nLGhviXyduWt
         QThg==
X-Gm-Message-State: AFqh2kpKeNUWlDvxMewxLx4uCg1F1eIHHq0Ez6bJi04MErzHkGZDkSar
        Q17NdjGkVRhnA1z2lQiIzxMJvw==
X-Google-Smtp-Source: AMrXdXsVJMYNom7SLj5vM30I7jS3ShXNULJqDkSHssTAjPTH021Au/32dCYHSiwtt6csRhcWs5mYGw==
X-Received: by 2002:a5d:6282:0:b0:2bf:9516:d295 with SMTP id k2-20020a5d6282000000b002bf9516d295mr1510192wru.22.1674244143346;
        Fri, 20 Jan 2023 11:49:03 -0800 (PST)
Received: from localhost.localdomain (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id l29-20020adfa39d000000b002bf95500254sm878921wrb.64.2023.01.20.11.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 11:49:02 -0800 (PST)
From:   Qais Yousef <qyousef@layalina.io>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v2] sched: cpuset: Don't rebuild sched domains on suspend-resume
Date:   Fri, 20 Jan 2023 19:48:22 +0000
Message-Id: <20230120194822.962958-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Commit f9a25f776d78 ("cpusets: Rebuild root domain deadline accounting information")
enabled rebuilding sched domain on cpuset and hotplug operations to
correct deadline accounting.

Rebuilding sched domain is a slow operation and we see 10+ ms delay on
suspend-resume because of that.

Since nothing is expected to change on suspend-resume operation; skip
rebuilding the sched domains to regain the time lost.

Debugged-by: Rick Yiu <rickyiu@google.com>
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---

    Changes in v2:
    
    	* Remove redundant check in update_tasks_root_domain() (Thanks Waiman)
    
    v1 link:
    
    	https://lore.kernel.org/lkml/20221216233501.gh6m75e7s66dmjgo@airbuntu/

 kernel/cgroup/cpuset.c  | 3 +++
 kernel/sched/deadline.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a29c0b13706b..9a45f083459c 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1088,6 +1088,9 @@ static void rebuild_root_domains(void)
 	lockdep_assert_cpus_held();
 	lockdep_assert_held(&sched_domains_mutex);
 
+	if (cpuhp_tasks_frozen)
+		return;
+
 	rcu_read_lock();
 
 	/*
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0d97d54276cc..42c1143a3956 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2575,6 +2575,9 @@ void dl_clear_root_domain(struct root_domain *rd)
 {
 	unsigned long flags;
 
+	if (cpuhp_tasks_frozen)
+		return;
+
 	raw_spin_lock_irqsave(&rd->dl_bw.lock, flags);
 	rd->dl_bw.total_bw = 0;
 	raw_spin_unlock_irqrestore(&rd->dl_bw.lock, flags);
-- 
2.25.1

