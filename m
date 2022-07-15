Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D66575A85
	for <lists+cgroups@lfdr.de>; Fri, 15 Jul 2022 06:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiGOEis (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Jul 2022 00:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiGOEir (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Jul 2022 00:38:47 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE82DF63;
        Thu, 14 Jul 2022 21:38:46 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id b8so4601148pjo.5;
        Thu, 14 Jul 2022 21:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to:84;0;0cto;
        bh=WtkuRfGOX+EeArsQgZ8vEJVaXdyjjyp5b+gWBk4NmN0=;
        b=F/slt/TvVHPF+qnaW1+rRFIHVrBtRqgr2uEEiB725isM2nC+d8CDUiJMdCXIchcTBr
         MEe6n5OfuvxZxd+2FjfxvBegGQZfyDqzjoVAhsxvM12DBSxi7DCSVoTqFBlEmuNvYJml
         MmoiVTqN9QTK8Sjz9/Brai1q5LcTKs+WVOKVbkMPYKRpkQzLQCC/y78Z7uGDDqPawz/g
         hVpJQgKLmUuIRHlShEgoohuVanbWRn3l2PkgAH885uIIIwHSOyB3ww4zqv7S8CIk+XuT
         5VcfpA5fxj9i/dJUPoUvcNJBpeZckFlXWnhOcdNpTc5LPkESlNFpQRZSFxrBfrL42aHJ
         G4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:84;0;0cto;
        bh=WtkuRfGOX+EeArsQgZ8vEJVaXdyjjyp5b+gWBk4NmN0=;
        b=my/eLSHGtAYkAZgolManwClWLamqPQ7FSVtbDTdP6G0BAT1u+AOsMpBtrmqT4zfxTQ
         t+Oqqx+SBgyFpi0C0KyKLbG/7kMIySWPBixh0Xg2pC8vFl5AcB9E4mC83+AMn9ziY/ok
         OrzIoV4R7n6vUdzd4v6VPa2wenwDVwlOsF8r3WEXkdU7gDlCsVkxT9I5p7I6iCqqLd1c
         s3n5L2YF5Xn8iUQlJnEpwu33xT6CP4zQXkWoZs7GRd5YC1+PdEMd1RzvG0uaGq+43dfh
         k0XNSGF6jD91wAmneo0hg4DL80Kpe5Tez6E4rXHo40TZ4EKesWVnyrFDQe2zJINsjph4
         TglQ==
X-Gm-Message-State: AJIora8+EwtogGwQeMdp7qV22o9kYXm+R69OhzdVGGNLdJ6S2KHNJfd/
        dgwxqe7PJdF6NEjmR2yRujw=
X-Google-Smtp-Source: AGRyM1urbqn9lHFmCGSKwgpmvmNseNqmdRwn67+1c8RaHk4w3Dz2EyKjCoMtqTNic8wk4U5aehQV2g==
X-Received: by 2002:a17:90b:1b48:b0:1ef:a90d:eae1 with SMTP id nv8-20020a17090b1b4800b001efa90deae1mr19384843pjb.68.1657859925760;
        Thu, 14 Jul 2022 21:38:45 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id d1-20020a62f801000000b00528c26c84a3sm2611433pfh.64.2022.07.14.21.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 21:38:45 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 14 Jul 2022 18:38:43 -1000
From:   Tejun Heo <tj@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Dmitry Shmidt <dimitrysh@google.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: [PATCH 2/3 cgroup/for-5.20] cgroup: Add "no" prefixed mount options
Message-ID: <YtDvU4jRPSsarcNp@slm.duckdns.org>
References: <YtDvN0wJ6CKaEPN8@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YtDvN0wJ6CKaEPN8@slm.duckdns.org>
84;0;0cTo: Christian Brauner =?iso-8859-1?Q?=3Cbraune?=
 =?iso-8859-1?Q?r=40kernel=2Eorg=3E=2C_Michal_Koutn=FD?= <mkoutny@suse.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        MISSING_HEADERS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We allow modifying these mount options via remount. Let's add "no" prefixed
variants so that they can be turned off too.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Michal Koutný <mkoutny@suse.com>
---
 Documentation/admin-guide/cgroup-v2.rst |    6 +++---
 kernel/cgroup/cgroup.c                  |   20 +++++++++++++++-----
 2 files changed, 18 insertions(+), 8 deletions(-)

--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -177,14 +177,14 @@ disabling controllers in v1 and make the
 
 cgroup v2 currently supports the following mount options.
 
-  nsdelegate
+  [no]nsdelegate
 	Consider cgroup namespaces as delegation boundaries.  This
 	option is system wide and can only be set on mount or modified
 	through remount from the init namespace.  The mount option is
 	ignored on non-init namespace mounts.  Please refer to the
 	Delegation section for details.
 
-  memory_localevents
+  memory_[no]localevents
         Only populate memory.events with data for the current cgroup,
         and not any subtrees. This is legacy behaviour, the default
         behaviour without this option is to include subtree counts.
@@ -192,7 +192,7 @@ cgroup v2 currently supports the followi
         modified through remount from the init namespace. The mount
         option is ignored on non-init namespace mounts.
 
-  memory_recursiveprot
+  memory_[no]recursiveprot
         Recursively apply memory.min and memory.low protection to
         entire subtrees, without requiring explicit downward
         propagation into leaf cgroups.  This allows protecting entire
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -279,8 +279,6 @@ bool cgroup_ssid_enabled(int ssid)
  *
  * - When mounting an existing superblock, mount options should match.
  *
- * - Remount is disallowed.
- *
  * - rename(2) is disallowed.
  *
  * - "tasks" is removed.  Everything should be at process granularity.  Use
@@ -1859,16 +1857,19 @@ int cgroup_show_path(struct seq_file *sf
 }
 
 enum cgroup2_param {
-	Opt_nsdelegate,
-	Opt_memory_localevents,
-	Opt_memory_recursiveprot,
+	Opt_nsdelegate, Opt_nonsdelegate,
+	Opt_memory_localevents, Opt_memory_nolocalevents,
+	Opt_memory_recursiveprot, Opt_memory_norecursiveprot,
 	nr__cgroup2_params
 };
 
 static const struct fs_parameter_spec cgroup2_fs_parameters[] = {
 	fsparam_flag("nsdelegate",		Opt_nsdelegate),
+	fsparam_flag("nonsdelegate",		Opt_nonsdelegate),
 	fsparam_flag("memory_localevents",	Opt_memory_localevents),
+	fsparam_flag("memory_nolocalevents",	Opt_memory_nolocalevents),
 	fsparam_flag("memory_recursiveprot",	Opt_memory_recursiveprot),
+	fsparam_flag("memory_norecursiveprot",	Opt_memory_norecursiveprot),
 	{}
 };
 
@@ -1886,12 +1887,21 @@ static int cgroup2_parse_param(struct fs
 	case Opt_nsdelegate:
 		ctx->flags |= CGRP_ROOT_NS_DELEGATE;
 		return 0;
+	case Opt_nonsdelegate:
+		ctx->flags &= ~CGRP_ROOT_NS_DELEGATE;
+		return 0;
 	case Opt_memory_localevents:
 		ctx->flags |= CGRP_ROOT_MEMORY_LOCAL_EVENTS;
 		return 0;
+	case Opt_memory_nolocalevents:
+		ctx->flags &= ~CGRP_ROOT_MEMORY_LOCAL_EVENTS;
+		return 0;
 	case Opt_memory_recursiveprot:
 		ctx->flags |= CGRP_ROOT_MEMORY_RECURSIVE_PROT;
 		return 0;
+	case Opt_memory_norecursiveprot:
+		ctx->flags &= ~CGRP_ROOT_MEMORY_RECURSIVE_PROT;
+		return 0;
 	}
 	return -EINVAL;
 }
