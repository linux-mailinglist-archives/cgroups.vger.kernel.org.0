Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBBD6A7459
	for <lists+cgroups@lfdr.de>; Wed,  1 Mar 2023 20:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjCATeK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Mar 2023 14:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCATeJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Mar 2023 14:34:09 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9213C241F3
        for <cgroups@vger.kernel.org>; Wed,  1 Mar 2023 11:34:08 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 66-20020a250245000000b00a53c1100d72so1394141ybc.0
        for <cgroups@vger.kernel.org>; Wed, 01 Mar 2023 11:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677699248;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VW1a/ztFW3oOtIrI9ep2g5ojznwZvfd6phBOKuSBaFU=;
        b=Ll26EZNi/jeVAl0OTcHUVwbVkpV9f3gHXLoSYmO1V8V6ZnM8Xix86qmIbRQCiW/uqN
         JubSJxWHW/nuhVWBP9+ve54r0YG4l+9yACZF9yiPrUuykGvrcanYHwntjSiUthPfmQD6
         oUEN2puY+bilBZaqeWPtoysFJZ2cfz8Hoo//99yYDxceQFxOMz+zghx16LhfRoF9ydvr
         cwBT2ktXIetOsJsU0cr2FxMs6cnP6ugcOTzLRtSxklIHuLgx6Y3cktvHmeTRKzNOXCPb
         +QGiVN0Bd2LEPJP+3h7pQoEg54t6GPrvyGV5w0HvWufE1ooG0JHvDEVXj29IrNkl7XiY
         ePuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677699248;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VW1a/ztFW3oOtIrI9ep2g5ojznwZvfd6phBOKuSBaFU=;
        b=25S9VeN2BcXoiVSRLQyl4at2Lh+i+hCq8ewZMTGb8o2/7FdxT72oPAz4MYc/d2dWO3
         kmUDg7BQAhpAwJOb9ouA+iv9fI0CjvyuQRU3R7dx//n6wOqmc24JzHNmYNUKeZ/Ecnuv
         UaDCkOiLCFp2fa1EJKs8xwD8NQhQdt/p2sGDuupvK0KnjaN1D9euxl7bJyaQH96XmVs3
         LNN7EUyfmvZunDgv1A2zql3cvpxAE8vVvmoNvI/W1DrGfaz/TVaMhB91+8PC3eOs5fR9
         0xhXcgNGBCdrvQa9TWhWDOFMaOMt0chqWFGBoj+S/7vUP15/C6wAisZmvbtnFMPbYMIr
         rgDQ==
X-Gm-Message-State: AO0yUKXsf5eTWjUzAK6rGBmUN8iamr9w2v0GKdYhG+yjxNDKNVE/iE2o
        JK1PKLXWFhHODPkv24cZTJIOFTrjHKk=
X-Google-Smtp-Source: AK7set9EJvTqQFnc1go59+KKiznJH8pXjUdW79pW5pRUUyJRbcowF8nm34WBAwnjBgVcdnT6eUxGJswuKmg=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:3c40:eeb3:7c3a:807e])
 (user=surenb job=sendgmr) by 2002:a81:af08:0:b0:536:5557:33a8 with SMTP id
 n8-20020a81af08000000b00536555733a8mr4702461ywh.9.1677699247788; Wed, 01 Mar
 2023 11:34:07 -0800 (PST)
Date:   Wed,  1 Mar 2023 11:34:03 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230301193403.1507484-1-surenb@google.com>
Subject: [PATCH 1/1] psi: remove 500ms min window size limitation for triggers
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
index 02e011cabe91..9c02b27052bb 100644
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
+	if (window_us <= 0 || window_us > WINDOW_MAX_US)
 		return ERR_PTR(-EINVAL);
 
 	/* Check threshold */
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

