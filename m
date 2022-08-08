Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2466558C72A
	for <lists+cgroups@lfdr.de>; Mon,  8 Aug 2022 13:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242897AbiHHLFY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 8 Aug 2022 07:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242808AbiHHLFE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 8 Aug 2022 07:05:04 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEDB14D20
        for <cgroups@vger.kernel.org>; Mon,  8 Aug 2022 04:05:03 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id t22so8465430pjy.1
        for <cgroups@vger.kernel.org>; Mon, 08 Aug 2022 04:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uLMRRkpz76WFAC6w4foL1Edra508Vk6fX2ixUPszkRg=;
        b=U6k3lehDVxN49RqBtV2xHyF+h26ildCUx/hcQLS9PcepCqK9IKcw4CdPAOeUIuPG1s
         mnq493zh8DB20EHT/ai2shQdEyKlIWuxBPLr9RwwFptYyqtgSHSYvaBTR82EiYDsqV+B
         7HioJDTamptDapEshQrGUO5P4EWY1LC7erYwBHO8bW/02kfj0t9ek1st38Td6Fs+vuDX
         Uip9TgU+7YcBuNOJSM+ttx3zWrfaftX4/gZQJY14Tp23U8DKeiK1omha+8GKoSjbwSaT
         sM8kDBGUzcZbCVFNmleTqCYfQeZcqXfVtc+VLHbpn2Gpw9+9B+i7ZIHuDzt2KArEeqAH
         Svuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uLMRRkpz76WFAC6w4foL1Edra508Vk6fX2ixUPszkRg=;
        b=QU2WDAySOD4DqI2epoOpY3woGGw643KDnN4luuCGuIeoHN45RQMpzSL52pg3oLe1tw
         aSez2dikEvpfM5+72Xtwpz1pIHlW/PBl6iUBWSzBCaBUo6ZsNBDZE6U3KMrCEDgiwQ6q
         3WnnL8ywBr8JBhB7GJ3HcruoCxG+UKorJtwR0BoIDDKSplhQe/dRziByiPTz4SnriEkG
         DkiCQzgQGDbStICGAprtCReiunBE7OPbc1+uU0Ifmv3Sp+41apirqV0IoZpRV96xyM/i
         8VK8MZ9HK+d1xc+qvzmWdeJWhO4c4yV2L2euc/RDzFGvI19g7BVe5xFIP0qiVOwld53o
         gq7g==
X-Gm-Message-State: ACgBeo2rNpzv3eEKlsYt/pH08FJBu0v/Km97AxI7Yb4KUaRHk4Q1fnvn
        cCLP4Z8r2vJmc6iK//ch2GqeeA==
X-Google-Smtp-Source: AA6agR5CgK+PlaY0Ns19IbVG4pKfoQG1NbbChIIISPB+PJFmIeUjO/oI2kx3Riadbhug5fmTC+eLBA==
X-Received: by 2002:a17:90b:3586:b0:1f4:d507:783e with SMTP id mm6-20020a17090b358600b001f4d507783emr28080636pjb.171.1659956702869;
        Mon, 08 Aug 2022 04:05:02 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id o12-20020aa7978c000000b0052dbad1ea2esm8393180pfp.6.2022.08.08.04.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 04:05:02 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, tj@kernel.org, corbet@lwn.net,
        surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 06/10] sched/psi: save percpu memory when !psi_cgroups_enabled
Date:   Mon,  8 Aug 2022 19:03:37 +0800
Message-Id: <20220808110341.15799-7-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220808110341.15799-1-zhouchengming@bytedance.com>
References: <20220808110341.15799-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We won't use cgroup psi_group when !psi_cgroups_enabled, so don't
bother to alloc percpu memory and init for it.

Also don't need to migrate task PSI stats between cgroups in
cgroup_move_task().

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 kernel/sched/psi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 974471f212a3..595a6c8230b7 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -205,6 +205,7 @@ void __init psi_init(void)
 {
 	if (!psi_enable) {
 		static_branch_enable(&psi_disabled);
+		static_branch_disable(&psi_cgroups_enabled);
 		return;
 	}
 
@@ -952,7 +953,7 @@ void psi_memstall_leave(unsigned long *flags)
 #ifdef CONFIG_CGROUPS
 int psi_cgroup_alloc(struct cgroup *cgroup)
 {
-	if (static_branch_likely(&psi_disabled))
+	if (!static_branch_likely(&psi_cgroups_enabled))
 		return 0;
 
 	cgroup->psi.pcpu = alloc_percpu(struct psi_group_cpu);
@@ -964,7 +965,7 @@ int psi_cgroup_alloc(struct cgroup *cgroup)
 
 void psi_cgroup_free(struct cgroup *cgroup)
 {
-	if (static_branch_likely(&psi_disabled))
+	if (!static_branch_likely(&psi_cgroups_enabled))
 		return;
 
 	cancel_delayed_work_sync(&cgroup->psi.avgs_work);
@@ -991,7 +992,7 @@ void cgroup_move_task(struct task_struct *task, struct css_set *to)
 	struct rq_flags rf;
 	struct rq *rq;
 
-	if (static_branch_likely(&psi_disabled)) {
+	if (!static_branch_likely(&psi_cgroups_enabled)) {
 		/*
 		 * Lame to do this here, but the scheduler cannot be locked
 		 * from the outside, so we move cgroups from inside sched/.
-- 
2.36.1

