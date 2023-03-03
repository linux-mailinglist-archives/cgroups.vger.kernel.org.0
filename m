Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAD86A8E8C
	for <lists+cgroups@lfdr.de>; Fri,  3 Mar 2023 02:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjCCBPC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Mar 2023 20:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjCCBOK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Mar 2023 20:14:10 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE0222DC6
        for <cgroups@vger.kernel.org>; Thu,  2 Mar 2023 17:13:50 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id d7-20020a25adc7000000b00953ffdfbe1aso728658ybe.23
        for <cgroups@vger.kernel.org>; Thu, 02 Mar 2023 17:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677806030;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pk7Od9lx1FvwXfe2+jCyuETO6j4UmvCkXNRwPfsPdX8=;
        b=eawrTzCH33CbOpQRrdHF07gcS0h9D1fZAptzT+SJUwp8eltvWzEvvp9uSp3iqVbkls
         cqD96AeE8qiN73slqQ81HuGUu6xBeCHlD/QwFmF4SWXenGr98sEL5df8aqUJgveG2cZA
         MIRo5Gf6PS8V7+p93ejwhwPx/Zzm8icHjBpOJpQ5mT/DzAHhN1Ua/6fBWtLOS3kr55VC
         3GEyDVbXsOkpLx5aJClCUXvSUnC7JOuxd2OR/Zbimj6cGtSwn7Ad4+TroPZDrDw3oBbW
         2cUbgCSfRfZTug//WxNgmYlh8jp6snpqjyp3oQIgg1RyVqOYyxrglI95cfpAy3GN3cnZ
         CAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677806030;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pk7Od9lx1FvwXfe2+jCyuETO6j4UmvCkXNRwPfsPdX8=;
        b=xpX706/pFwO2Ntv49984Ncg5tnaZV9ocpNm/dQCIod39COfFQ1mS5sGOdIJhCR1Sfh
         fbhaZ8tAnba+3P0ue+2tOzImRBT5lf6dHuR7Cc7tPDJCxQQ/kc85XIZLFBK284Xj8FAV
         dSdaIGvNuBauoRQzqKlu9CJIuYZMaVtyY/ao9jmNljopErdFzoNow+zc5LToGG9ZqZ9S
         RimvZln5Y24XgDtUcvAmS8Snujc/gFAOfFSzjUrGT/qc2tJQaExbepHZhYBarIQnM8pA
         IFLqOom6+qL1a+SW28Md8iUQM2NUq6Ee19iyuP9lKGgNweYfj+2m1xXnavl9dgpDjL0z
         EREg==
X-Gm-Message-State: AO0yUKXv2Y6j606v3DKpK0R2h760S++AkHsUQHnRAEjQZ5F3IFBuQIlW
        cbkNDRvsuOsbqD6b5nyEzozrLM0o6SE=
X-Google-Smtp-Source: AK7set85a9u2TpY4EKigfXzI8OCBp4gfZp5TC44x/oTa8B6mXZ19XkruqBUD6Y1l4ByN/bQmQq0C7M2NxnI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:58cd:2543:62b7:a517])
 (user=surenb job=sendgmr) by 2002:a05:6902:344:b0:8a3:d147:280b with SMTP id
 e4-20020a056902034400b008a3d147280bmr2337965ybs.3.1677806030055; Thu, 02 Mar
 2023 17:13:50 -0800 (PST)
Date:   Thu,  2 Mar 2023 17:13:46 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230303011346.3342233-1-surenb@google.com>
Subject: [PATCH v2 1/1] psi: remove 500ms min window size limitation for triggers
From:   Suren Baghdasaryan <surenb@google.com>
To:     tj@kernel.org
Cc:     hannes@cmpxchg.org, lizefan.x@bytedance.com, peterz@infradead.org,
        johunt@akamai.com, mhocko@suse.com, keescook@chromium.org,
        quic_sudaraja@quicinc.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Current 500ms min window size for psi triggers limits polling interval
to 50ms to prevent polling threads from using too much cpu bandwidth by
polling too frequently. However the number of cgroups with triggers is
unlimited, so this protection can be defeated by creating multiple
cgroups with psi triggers (triggers in each cgroup are served by a single
"psimon" kernel thread).
Instead of limiting min polling period, which also limits the latency of
psi events, it's better to limit psi trigger creation to authorized users
only, like we do for system-wide psi triggers (/proc/pressure/* files can
be written only by processes with CAP_SYS_RESOURCE capability). This also
makes access rules for cgroup psi files consistent with system-wide ones.
Add a CAP_SYS_RESOURCE capability check for cgroup psi file writers and
remove the psi window min size limitation.

Suggested-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
Link: https://lore.kernel.org/all/cover.1676067791.git.quic_sudaraja@quicinc.com/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 kernel/cgroup/cgroup.c | 10 ++++++++++
 kernel/sched/psi.c     |  4 +---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 935e8121b21e..b600a6baaeca 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3867,6 +3867,12 @@ static __poll_t cgroup_pressure_poll(struct kernfs_open_file *of,
 	return psi_trigger_poll(&ctx->psi.trigger, of->file, pt);
 }
 
+static int cgroup_pressure_open(struct kernfs_open_file *of)
+{
+	return (of->file->f_mode & FMODE_WRITE && !capable(CAP_SYS_RESOURCE)) ?
+		-EPERM : 0;
+}
+
 static void cgroup_pressure_release(struct kernfs_open_file *of)
 {
 	struct cgroup_file_ctx *ctx = of->priv;
@@ -5266,6 +5272,7 @@ static struct cftype cgroup_psi_files[] = {
 	{
 		.name = "io.pressure",
 		.file_offset = offsetof(struct cgroup, psi_files[PSI_IO]),
+		.open = cgroup_pressure_open,
 		.seq_show = cgroup_io_pressure_show,
 		.write = cgroup_io_pressure_write,
 		.poll = cgroup_pressure_poll,
@@ -5274,6 +5281,7 @@ static struct cftype cgroup_psi_files[] = {
 	{
 		.name = "memory.pressure",
 		.file_offset = offsetof(struct cgroup, psi_files[PSI_MEM]),
+		.open = cgroup_pressure_open,
 		.seq_show = cgroup_memory_pressure_show,
 		.write = cgroup_memory_pressure_write,
 		.poll = cgroup_pressure_poll,
@@ -5282,6 +5290,7 @@ static struct cftype cgroup_psi_files[] = {
 	{
 		.name = "cpu.pressure",
 		.file_offset = offsetof(struct cgroup, psi_files[PSI_CPU]),
+		.open = cgroup_pressure_open,
 		.seq_show = cgroup_cpu_pressure_show,
 		.write = cgroup_cpu_pressure_write,
 		.poll = cgroup_pressure_poll,
@@ -5291,6 +5300,7 @@ static struct cftype cgroup_psi_files[] = {
 	{
 		.name = "irq.pressure",
 		.file_offset = offsetof(struct cgroup, psi_files[PSI_IRQ]),
+		.open = cgroup_pressure_open,
 		.seq_show = cgroup_irq_pressure_show,
 		.write = cgroup_irq_pressure_write,
 		.poll = cgroup_pressure_poll,
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 02e011cabe91..0945f956bf80 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -160,7 +160,6 @@ __setup("psi=", setup_psi);
 #define EXP_300s	2034		/* 1/exp(2s/300s) */
 
 /* PSI trigger definitions */
-#define WINDOW_MIN_US 500000	/* Min window size is 500ms */
 #define WINDOW_MAX_US 10000000	/* Max window size is 10s */
 #define UPDATES_PER_WINDOW 10	/* 10 updates per window */
 
@@ -1278,8 +1277,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 	if (state >= PSI_NONIDLE)
 		return ERR_PTR(-EINVAL);
 
-	if (window_us < WINDOW_MIN_US ||
-		window_us > WINDOW_MAX_US)
+	if (window_us == 0 || window_us > WINDOW_MAX_US)
 		return ERR_PTR(-EINVAL);
 
 	/* Check threshold */
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

