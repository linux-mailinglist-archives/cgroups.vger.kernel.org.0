Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27B579088D
	for <lists+cgroups@lfdr.de>; Sat,  2 Sep 2023 17:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbjIBPm5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 2 Sep 2023 11:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjIBPm4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 2 Sep 2023 11:42:56 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83FDCFE;
        Sat,  2 Sep 2023 08:42:53 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5694a117254so14008a12.0;
        Sat, 02 Sep 2023 08:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693669373; x=1694274173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6SQfYFAS0iiVi0orcSaVcos5wFLJxvemd/2Ha3R3PtM=;
        b=g68w/pSDRFvZIkLd+b5CqkL3pvlZnFKG1mpjkSF7JwC4z9P03ASSMkLyobfqDRMd6J
         uw30zS9vzquH6tTEWaXkHRsKSGwBkocXDhw2eBP7xql1wZqtBItfTmT79sa+SQJMbwcm
         lq9/We9hS7aYsDM12AVvs/+Wkvqx/wk0QkANye2WIHs7wbHIPO615jTkNjUehp0OokGB
         vLo+YqtgL9PqiTBOBLYZdg3kgkGan0oZL0Z8UHCe0skGw4FNuB/Lq6PP8cF8slZ/sPst
         W20IfMfMM8/pg2tDG6HZsjcZ6dxERXpmFLIqLkU5FZTCwP85x0z3E/ilyR8ehM30abCc
         gHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693669373; x=1694274173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SQfYFAS0iiVi0orcSaVcos5wFLJxvemd/2Ha3R3PtM=;
        b=k2f668GIZgAe445DCDsAnJ1tPUfHtAN6NulwlVpvOwNskCKJo2Z/pcZLkmKLtWGC2X
         OB02ZrNJhfxXQAmW3Js9LpUdqiN6GgV0BsX/ZTP6HlP9F/4qF51XsymBMLUMEr/IwbUV
         NOYJJi/zKLqUL9XjsaNWzjUptC4frcRGxsxS1ELiXwsrY8kMZiOb1r5ztgKxunNX9nH4
         TO+P4WIdQsj+MroaMkWd4dWXcLrFmLf4Yg55Bw7NI5ePQljs537LV444EZwgf0UGxH7o
         fgdyNE1rxLIyAOqlM7IT6uT/1SXtMkJxgdOFDZamKikQdul9FN0kFFloWe4cGdJ0JaNT
         i/+A==
X-Gm-Message-State: AOJu0YxpdlO/g1PgG28YWp32TrV5pFh1sbn1P+k5TkHGvxPI7D9tMXuG
        Yp26sC4DlXIAQycEA8TMDEo=
X-Google-Smtp-Source: AGHT+IE2AG9OKVJwY3C00izsMETmrEpukmxWa4XJJxTCGW/GqZ7zAP1hi8yl32ymGI5dgepZormV6g==
X-Received: by 2002:a05:6a20:244d:b0:12f:382d:2a37 with SMTP id t13-20020a056a20244d00b0012f382d2a37mr7402802pzc.15.1693669372796;
        Sat, 02 Sep 2023 08:42:52 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:eca7])
        by smtp.gmail.com with ESMTPSA id m28-20020a63711c000000b0056c3ee09b71sm4773430pgc.74.2023.09.02.08.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 08:42:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sat, 2 Sep 2023 05:42:50 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        regressions@lists.linux.dev
Subject: [PATCH cgroup/for-6.6-fixes] cgroup: Put cgroup_local_stat_show()
 inside CONFIG_CGROUP_SCHED
Message-ID: <ZPNX-jZAZbebizXA@slm.duckdns.org>
References: <ZPMdTJ7zwrCkdMTu@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPMdTJ7zwrCkdMTu@debian>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From d8416c5d2a38e36651f022be01bb234a404b8f01 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Sat, 2 Sep 2023 05:28:06 -1000

677ea015f231 ("sched: add throttled time stat for throttled children") which
was merged through the sched branch added cgroup_local_stat_show() which is
marked with __maybe_unused and used iff CONFIG_CGROUP_SCHED is set. This was
following the existing pattern of cgroup_extra_stat_show().

However, in the cgroup tree, 1299eb2b0ad5 ("cgroup: minor cleanup for
cgroup_extra_stat_show()") moved cgroup_extra_stat_show() inside
CONFIG_CGROUP_SCHED and dropped __maybe_unused and subsequently d1d4ff5d11a5
("cgroup: put cgroup_tryget_css() inside CONFIG_CGROUP_SCHED") moved
cgroup_tryget_css() inside the config option too as cgroup_extra_stat_show()
was the only user.

When the tree commits met in mainline, this led to a build breakage when
!CONFIG_CGROUP_SCHED as cgroup_tryget_css() was no longer available for the
__maybe_unused cgroup_local_stat_show().

Fix it by moving cgroup_local_stat_show() inside CONFIG_CGROUP_SCHED and
also drop __maybe_unused.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Link: http://lkml.kernel.org/r/ZPMdTJ7zwrCkdMTu@debian
Fixes: 677ea015f231 ("sched: add throttled time stat for throttled children")
Cc: Josh Don <joshdon@google.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
---
Sorry about that. This should fix it. Guess nobody is building linux-next w/
!CONFIG_CGROUP_SCHED. I'll send the pull request to Linus soon.

Thanks.

 kernel/cgroup/cgroup.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index babb34a643ea..156eb96d7cc5 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3686,8 +3686,9 @@ static int cpu_stat_show(struct seq_file *seq, void *v)
 	return ret;
 }
 
-static int __maybe_unused cgroup_local_stat_show(struct seq_file *seq,
-						 struct cgroup *cgrp, int ssid)
+#ifdef CONFIG_CGROUP_SCHED
+static int cgroup_local_stat_show(struct seq_file *seq, struct cgroup *cgrp,
+				  int ssid)
 {
 	struct cgroup_subsys *ss = cgroup_subsys[ssid];
 	struct cgroup_subsys_state *css;
@@ -3704,6 +3705,7 @@ static int __maybe_unused cgroup_local_stat_show(struct seq_file *seq,
 	css_put(css);
 	return ret;
 }
+#endif
 
 static int cpu_local_stat_show(struct seq_file *seq, void *v)
 {
-- 
2.42.0

