Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4E0581C8F
	for <lists+cgroups@lfdr.de>; Wed, 27 Jul 2022 01:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240038AbiGZXtR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Jul 2022 19:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240017AbiGZXtM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Jul 2022 19:49:12 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03745192AE;
        Tue, 26 Jul 2022 16:49:12 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id z3so14728544plb.1;
        Tue, 26 Jul 2022 16:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc;
        bh=yY9aRjMSrl3E8MLV9o3v7Jic3NwUOJ4OPWNoEH9R3G8=;
        b=iipoFRSFuacCTvG/hBlkKdzj7RgSpYh5GhiKNSBenYInTcpP45AEJiqCoHNPQ0Ovzn
         jEwxW8dfwiqO9S+mgdFnj+VRvmtr21ggmyIVMg34YUtmLWcgnEMk85j3OnqupYDJmxw0
         8jPYxI/J+1nesQ2FdFpavvq/Kr6iEl6WWET/Hd1VY6prHDwieRQD/jQy5tFbEXOk0k7/
         HP16312p2nDTd7uow6CWiVgNfSSUNZ0ztCwFiOHn0dox20oL9fmUexamI2Yt54/I1ElJ
         MYKPTKMY8agPE3xkx6oLLPYQpgZYJaSSicdpQ5j9NLRfEDKxUc3Iqzolvm4p/SZPXMQi
         MTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc;
        bh=yY9aRjMSrl3E8MLV9o3v7Jic3NwUOJ4OPWNoEH9R3G8=;
        b=nXA1MB5JZ1uyQgXz4YonPJqMJqWMzI/QTMVEB2aCfTC9QXUEoNx/qYzy4p7nqgUtJM
         d7eKzZdCof7LrcQUmTGBWHDZnlphNEe9jalcPFTC8EBitGg6Rnu8qi3R10bDh0GM2Ruu
         rBNHm83xCS4Fij+XlirB0hyRUzX2QQNE1aKTrHnq0Mm2xpNJXDezlHwBUxxp05Vct9cM
         YaCLMEaca9HksjDETlVrDs7KCyjUxqffmDMVrogFUe24ChkMdiCQw5Z9kSAwVdUSduFu
         4bHGXrzwGtH6qyD3ZxAEPEN9rue7od7aWz8TgCO6NAYHAC1fGqGSm11qoUoheMrxnY2M
         Gpbg==
X-Gm-Message-State: AJIora8jC8acu1N+N0FG4chMw5MNERNYuwJr444aO4tDMMpQW+7AcI4V
        iEXKL2Olhp+gXibbmiXvUik=
X-Google-Smtp-Source: AGRyM1vI27BlrEFalJ73T2vXL3luzCwfS3LrKilZUAjB78L7RlLilvVXshxCzctwKeyI4OyhRAbkDQ==
X-Received: by 2002:a17:90b:1e4d:b0:1f0:462b:b573 with SMTP id pi13-20020a17090b1e4d00b001f0462bb573mr1508544pjb.164.1658879351272;
        Tue, 26 Jul 2022 16:49:11 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:370d])
        by smtp.gmail.com with ESMTPSA id i29-20020aa796fd000000b0052b94e74e45sm12170184pfq.204.2022.07.26.16.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 16:48:43 -0700 (PDT)
Sender: htejun <htejun@gmail.com>
Date:   Tue, 26 Jul 2022 13:48:17 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Dmitry Shmidt <dimitrysh@google.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: [PATCH cgroup/for-5.20] cgroup: remove "no" prefixed mount options
 options
Message-ID: <YuB9QXapVUy1t8TZ@slm.duckdns.org>
References: <YtDvN0wJ6CKaEPN8@slm.duckdns.org>
 <YtDvU4jRPSsarcNp@slm.duckdns.org>
 <20220726143246.GA23794@blackbody.suse.cz>
 <YuBIACfZDk72yjI3@slm.duckdns.org>
 <YuB5ICv3bXsy5Xuh@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YuB5ICv3bXsy5Xuh@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

30312730bd02 ("cgroup: Add "no" prefixed mount options") added "no" prefixed
mount options to allow turning them off and 6a010a49b63a ("cgroup: Make
!percpu threadgroup_rwsem operations optional") added one more "no" prefixed
mount option. However, Michal pointed out that the "no" prefixed options
aren't necessary in allowing mount options to be turned off:

  # grep group /proc/mounts
  cgroup2 /sys/fs/cgroup cgroup2 rw,nosuid,nodev,relatime,nsdelegate,memory_recursiveprot 0 0
  # mount -o remount,nsdelegate,memory_recursiveprot none /sys/fs/cgroup
  # grep cgroup /proc/mounts
  cgroup2 /sys/fs/cgroup cgroup2 rw,relatime,nsdelegate,memory_recursiveprot 0 0

Note that this is different from the remount behavior when the mount(1) is
invoked without the device argument - "none":

 # grep cgroup /proc/mounts
 cgroup2 /sys/fs/cgroup cgroup2 rw,nosuid,nodev,noexec,relatime,nsdelegate,memory_recursiveprot 0 0
 # mount -o remount,nsdelegate,memory_recursiveprot /sys/fs/cgroup
 # grep cgroup /proc/mounts
 cgroup2 /sys/fs/cgroup cgroup2 rw,nosuid,nodev,noexec,relatime,nsdelegate,memory_recursiveprot 0 0

While a bit confusing, given that there is a way to turn off the options,
there's no reason to have the explicit "no" prefixed options. Let's remove
them.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Michal Koutný <mkoutny@suse.com>
---
 Documentation/admin-guide/cgroup-v2.rst |    8 ++++----
 kernel/cgroup/cgroup.c                  |   24 ++++--------------------
 2 files changed, 8 insertions(+), 24 deletions(-)

--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -177,14 +177,14 @@ disabling controllers in v1 and make the
 
 cgroup v2 currently supports the following mount options.
 
-  [no]nsdelegate
+  nsdelegate
 	Consider cgroup namespaces as delegation boundaries.  This
 	option is system wide and can only be set on mount or modified
 	through remount from the init namespace.  The mount option is
 	ignored on non-init namespace mounts.  Please refer to the
 	Delegation section for details.
 
-  [no]favordynmods
+  favordynmods
         Reduce the latencies of dynamic cgroup modifications such as
         task migrations and controller on/offs at the cost of making
         hot path operations such as forks and exits more expensive.
@@ -192,7 +192,7 @@ cgroup v2 currently supports the followi
         controllers, and then seeding it with CLONE_INTO_CGROUP is
         not affected by this option.
 
-  memory_[no]localevents
+  memory_localevents
         Only populate memory.events with data for the current cgroup,
         and not any subtrees. This is legacy behaviour, the default
         behaviour without this option is to include subtree counts.
@@ -200,7 +200,7 @@ cgroup v2 currently supports the followi
         modified through remount from the init namespace. The mount
         option is ignored on non-init namespace mounts.
 
-  memory_[no]recursiveprot
+  memory_recursiveprot
         Recursively apply memory.min and memory.low protection to
         entire subtrees, without requiring explicit downward
         propagation into leaf cgroups.  This allows protecting entire
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1872,22 +1872,18 @@ int cgroup_show_path(struct seq_file *sf
 }
 
 enum cgroup2_param {
-	Opt_nsdelegate, Opt_nonsdelegate,
-	Opt_favordynmods, Opt_nofavordynmods,
-	Opt_memory_localevents, Opt_memory_nolocalevents,
-	Opt_memory_recursiveprot, Opt_memory_norecursiveprot,
+	Opt_nsdelegate,
+	Opt_favordynmods,
+	Opt_memory_localevents,
+	Opt_memory_recursiveprot,
 	nr__cgroup2_params
 };
 
 static const struct fs_parameter_spec cgroup2_fs_parameters[] = {
 	fsparam_flag("nsdelegate",		Opt_nsdelegate),
-	fsparam_flag("nonsdelegate",		Opt_nonsdelegate),
 	fsparam_flag("favordynmods",		Opt_favordynmods),
-	fsparam_flag("nofavordynmods",		Opt_nofavordynmods),
 	fsparam_flag("memory_localevents",	Opt_memory_localevents),
-	fsparam_flag("memory_nolocalevents",	Opt_memory_nolocalevents),
 	fsparam_flag("memory_recursiveprot",	Opt_memory_recursiveprot),
-	fsparam_flag("memory_norecursiveprot",	Opt_memory_norecursiveprot),
 	{}
 };
 
@@ -1905,27 +1901,15 @@ static int cgroup2_parse_param(struct fs
 	case Opt_nsdelegate:
 		ctx->flags |= CGRP_ROOT_NS_DELEGATE;
 		return 0;
-	case Opt_nonsdelegate:
-		ctx->flags &= ~CGRP_ROOT_NS_DELEGATE;
-		return 0;
 	case Opt_favordynmods:
 		ctx->flags |= CGRP_ROOT_FAVOR_DYNMODS;
 		return 0;
-	case Opt_nofavordynmods:
-		ctx->flags &= ~CGRP_ROOT_FAVOR_DYNMODS;
-		return 0;
 	case Opt_memory_localevents:
 		ctx->flags |= CGRP_ROOT_MEMORY_LOCAL_EVENTS;
 		return 0;
-	case Opt_memory_nolocalevents:
-		ctx->flags &= ~CGRP_ROOT_MEMORY_LOCAL_EVENTS;
-		return 0;
 	case Opt_memory_recursiveprot:
 		ctx->flags |= CGRP_ROOT_MEMORY_RECURSIVE_PROT;
 		return 0;
-	case Opt_memory_norecursiveprot:
-		ctx->flags &= ~CGRP_ROOT_MEMORY_RECURSIVE_PROT;
-		return 0;
 	}
 	return -EINVAL;
 }
