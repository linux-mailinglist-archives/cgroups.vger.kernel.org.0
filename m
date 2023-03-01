Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1615C6A64F2
	for <lists+cgroups@lfdr.de>; Wed,  1 Mar 2023 02:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjCABq7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Feb 2023 20:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCABq6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Feb 2023 20:46:58 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B2F298D1
        for <cgroups@vger.kernel.org>; Tue, 28 Feb 2023 17:46:56 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536bbaa701aso249499437b3.3
        for <cgroups@vger.kernel.org>; Tue, 28 Feb 2023 17:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677635215;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hkk07sQi4ewYkgcLI5Vv3w/Ohqk2oO/iYGZZBdhoujI=;
        b=SPZCLaYSWsFrDoFUe+8BNKpQBvdrTpQWNkS+pSnYsNjidK6DiG6uxbfe7ZnXEF5NJn
         mA4kKgoYr+T01aH7H9Odwr+okLsltXjxhHH8k/FBiPg0KQ05aWI6MnXcOTSBQBtmnZti
         59IM9MtiQSlS5IIx5lpMwTlsQFBBfJKjga+S5NGw+aXNoPb6PpM92R+dqa3tXtO45j57
         RPny4gtbyLIvSMGpWUYZEn0P66MLNtWF7zQh7PNLL89KppUZcj5yxU6XLU8oU7IJw3NG
         V5S++Dy9Z/OJgLN7yPmibRr23zDQlcIIqNOKl+MKw+gsadanJtye+mwY96YZ1yXoFkyH
         FAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677635215;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hkk07sQi4ewYkgcLI5Vv3w/Ohqk2oO/iYGZZBdhoujI=;
        b=pdATTjXfVZw3znpyrHdM5Gemanb0R/diyZWr1jj9t91n2Tlokrx0/krCnLutEhm98K
         6pk0uFKhZz7VLl41SgMUJe3rylWiAWGW1hu44PWqnTvF9ITwAM7mPrE0Wubav0IqFZ9k
         Y3qFL0T9medjg2S+QJs++gSa5ns/RSm0g2ZgbgpfGNiMAzxNcS5aXpVbYeGf4e0kwsOv
         pQGMAXu3YeWZbp7ojirS8egGfWKLD1aSENp2qoQNwvF+cL3hhGuFpM+OG33A4ak3pedq
         ZheoMEYZDT6UA6ec6JokGoL24kKAxOQkS0eGD9rtJlH/QgyKc8FiZANmNPqRuBmXSGAY
         DcqA==
X-Gm-Message-State: AO0yUKUkWS6ifv2naSJRSXOI4lFQqoUq2SW4u/HOtl193IzbABG1VuMh
        ezZpbZ0yfsfqZxELxql4JGoUzcAHpZk=
X-Google-Smtp-Source: AK7set8u9kvWL+CJ3udaU7rkHUOfeWfiv3WiPx2d6BFNa6wRGcNcHxwUKh6Yo3I3K7hVVZt+Ni6rt2s8D+s=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:612b:820a:2225:ad82])
 (user=surenb job=sendgmr) by 2002:a05:6902:128c:b0:8da:3163:224 with SMTP id
 i12-20020a056902128c00b008da31630224mr12241994ybu.0.1677635215361; Tue, 28
 Feb 2023 17:46:55 -0800 (PST)
Date:   Tue, 28 Feb 2023 17:46:51 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230301014651.1370939-1-surenb@google.com>
Subject: [PATCH 1/1] cgroup: limit cgroup psi file writes to processes with CAP_SYS_RESOURCE
From:   Suren Baghdasaryan <surenb@google.com>
To:     tj@kernel.org
Cc:     hannes@cmpxchg.org, lizefan.x@bytedance.com, peterz@infradead.org,
        johunt@akamai.com, mhocko@suse.com, quic_sudaraja@quicinc.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>
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

Currently /proc/pressure/* files can be written only by processes with
CAP_SYS_RESOURCE capability to prevent any unauthorized user from
creating psi triggers. However no such limitation is required for
per-cgroup pressure files. Fix this inconsistency by requiring the same
capability for writing per-cgroup psi files.

Fixes: 6db12ee0456d ("psi: allow unprivileged users with CAP_SYS_RESOURCE to write psi files")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 kernel/cgroup/cgroup.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

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
-- 
2.39.2.722.g9855ee24e9-goog

