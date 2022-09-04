Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944585AC691
	for <lists+cgroups@lfdr.de>; Sun,  4 Sep 2022 23:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiIDVKe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 4 Sep 2022 17:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIDVKd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 4 Sep 2022 17:10:33 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A516248F9
        for <cgroups@vger.kernel.org>; Sun,  4 Sep 2022 14:10:31 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id c24so6501246pgg.11
        for <cgroups@vger.kernel.org>; Sun, 04 Sep 2022 14:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=43Nmvkjv9GxUHoVscLQ8SY4GDNo4VMXckrpq90NSt8A=;
        b=NZ6Q4Zts1LjC6s/8VxNFazkhNXd16ED897xtAjTP1YtgYhl/XqtS+tSee7vzjejG+h
         06TxAhnJb0vTbqNu1emuHsw9NdLKZz650kAylw0iGoygrtTFopht5LmLJN3QW61+2RCX
         dmc1uXe/eLH0gC8H6jUaMOR03sMhxqS6co8XGUCFlcEfYMWayi0Mpdk9jn1gzPcVKPD2
         /Ss0uFXMwopJf1YWeW8Xve1qaEi5J1lstvHeupWn9iU4XGaZNfRYDhTcmVa3h+935cw2
         t1awrI95OdacT3J4YEQzsYwGDWdoPHJbY7VtvfxiKFR3xZ2nkdkF9XWijYo30mXakH9r
         H4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=43Nmvkjv9GxUHoVscLQ8SY4GDNo4VMXckrpq90NSt8A=;
        b=r+xt1fWQqTud6HfHxN2hci3zyrqexAeUYy+w6X7VeVtu1EQzkOG2x88AxS4taheFgl
         Hs4gi4zY+gBGPTo61omJu2XkyzRqyQjO9CsIcBiN9VCEt0/z9KvedLZnSsgj3D/LE43N
         fcMzXzj3o2gGWaWeIsaoE6rgKHL57F9X8LOQ8qeHSk0M8UWuvIFPa2Ul9cjwwZlBgIKs
         UlQy4LznQSENv8HoxPoKHrcrLqT6MjaD9cG6aIJ3/WaKbL5oI7Wr2e2lyZhLRp+75EzA
         bHwu6o3NfusE8tBA01yoe8LRA9cqOP1lRaJjb8Hzc27uFY1I5lwJQ2zluicvlb2kAdyG
         iVIg==
X-Gm-Message-State: ACgBeo1B7CDbpV6bDyA0Q7AT1HOtKyFqbOiyzkR2yzt+4alyN2S4CynO
        6/LjyOlzQFIq9tJd8xjWu9k=
X-Google-Smtp-Source: AA6agR4kB7/ihSL6V0nrke4mzYmdnY/X3OocIAugVoqMU42tS3udvye7+PQO+IkhUQSGLWaR80+M+w==
X-Received: by 2002:a65:44c1:0:b0:428:ab8f:62dd with SMTP id g1-20020a6544c1000000b00428ab8f62ddmr39473115pgs.211.1662325830458;
        Sun, 04 Sep 2022 14:10:30 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:291b])
        by smtp.gmail.com with ESMTPSA id k13-20020a170902c40d00b001635b86a790sm5907054plk.44.2022.09.04.14.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:10:30 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 4 Sep 2022 11:10:28 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/2 cgroup/for-6.1] cgroup: Remove CFTYPE_PRESSURE
Message-ID: <YxUURG8i2m2b2Ji2@slm.duckdns.org>
References: <YxUUISLVLEIRBwEY@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxUUISLVLEIRBwEY@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

CFTYPE_PRESSURE is used to flag PSI related files so that they are not
created if PSI is disabled during boot. It's a bit weird to use a generic
flag to mark a specific file type. Let's instead move the PSI files into its
own cftypes array and add/rm them conditionally. This is a bit more code but
cleaner.

No userland visible changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/cgroup-defs.h |    1 
 kernel/cgroup/cgroup.c      |   64 +++++++++++++++++++++++++-------------------
 2 files changed, 37 insertions(+), 28 deletions(-)

--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -126,7 +126,6 @@ enum {
 	CFTYPE_NO_PREFIX	= (1 << 3),	/* (DON'T USE FOR NEW FILES) no subsys prefix */
 	CFTYPE_WORLD_WRITABLE	= (1 << 4),	/* (DON'T USE FOR NEW FILES) S_IWUGO */
 	CFTYPE_DEBUG		= (1 << 5),	/* create when cgroup_debug */
-	CFTYPE_PRESSURE		= (1 << 6),	/* only if pressure feature is enabled */
 
 	/* internal flags, do not use outside cgroup core proper */
 	__CFTYPE_ONLY_ON_DFL	= (1 << 16),	/* only on default hierarchy */
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -217,6 +217,7 @@ struct cgroup_namespace init_cgroup_ns =
 
 static struct file_system_type cgroup2_fs_type;
 static struct cftype cgroup_base_files[];
+static struct cftype cgroup_psi_files[];
 
 /* cgroup optional features */
 enum cgroup_opt_features {
@@ -1689,12 +1690,16 @@ static void css_clear_dir(struct cgroup_
 	css->flags &= ~CSS_VISIBLE;
 
 	if (!css->ss) {
-		if (cgroup_on_dfl(cgrp))
-			cfts = cgroup_base_files;
-		else
-			cfts = cgroup1_base_files;
-
-		cgroup_addrm_files(css, cgrp, cfts, false);
+		if (cgroup_on_dfl(cgrp)) {
+			cgroup_addrm_files(css, cgrp,
+					   cgroup_base_files, false);
+			if (cgroup_psi_enabled())
+				cgroup_addrm_files(css, cgrp,
+						   cgroup_psi_files, false);
+		} else {
+			cgroup_addrm_files(css, cgrp,
+					   cgroup1_base_files, false);
+		}
 	} else {
 		list_for_each_entry(cfts, &css->ss->cfts, node)
 			cgroup_addrm_files(css, cgrp, cfts, false);
@@ -1717,14 +1722,22 @@ static int css_populate_dir(struct cgrou
 		return 0;
 
 	if (!css->ss) {
-		if (cgroup_on_dfl(cgrp))
-			cfts = cgroup_base_files;
-		else
-			cfts = cgroup1_base_files;
-
-		ret = cgroup_addrm_files(&cgrp->self, cgrp, cfts, true);
-		if (ret < 0)
-			return ret;
+		if (cgroup_on_dfl(cgrp)) {
+			ret = cgroup_addrm_files(&cgrp->self, cgrp,
+						 cgroup_base_files, true);
+			if (ret < 0)
+				return ret;
+
+			if (cgroup_psi_enabled()) {
+				ret = cgroup_addrm_files(&cgrp->self, cgrp,
+							 cgroup_psi_files, true);
+				if (ret < 0)
+					return ret;
+			}
+		} else {
+			cgroup_addrm_files(css, cgrp,
+					   cgroup1_base_files, true);
+		}
 	} else {
 		list_for_each_entry(cfts, &css->ss->cfts, node) {
 			ret = cgroup_addrm_files(css, cgrp, cfts, true);
@@ -4100,8 +4113,6 @@ static int cgroup_addrm_files(struct cgr
 restart:
 	for (cft = cfts; cft != cft_end && cft->name[0] != '\0'; cft++) {
 		/* does cft->flags tell us to skip this file on @cgrp? */
-		if ((cft->flags & CFTYPE_PRESSURE) && !cgroup_psi_enabled())
-			continue;
 		if ((cft->flags & __CFTYPE_ONLY_ON_DFL) && !cgroup_on_dfl(cgrp))
 			continue;
 		if ((cft->flags & __CFTYPE_NOT_ON_DFL) && cgroup_on_dfl(cgrp))
@@ -4186,9 +4197,6 @@ static int cgroup_init_cftypes(struct cg
 			break;
 		}
 
-		if ((cft->flags & CFTYPE_PRESSURE) && !cgroup_psi_enabled())
-			continue;
-
 		if (cft->seq_start)
 			kf_ops = &cgroup_kf_ops;
 		else
@@ -5134,10 +5142,13 @@ static struct cftype cgroup_base_files[]
 		.name = "cpu.stat",
 		.seq_show = cpu_stat_show,
 	},
+	{ }	/* terminate */
+};
+
+static struct cftype cgroup_psi_files[] = {
 #ifdef CONFIG_PSI
 	{
 		.name = "io.pressure",
-		.flags = CFTYPE_PRESSURE,
 		.seq_show = cgroup_io_pressure_show,
 		.write = cgroup_io_pressure_write,
 		.poll = cgroup_pressure_poll,
@@ -5145,7 +5156,6 @@ static struct cftype cgroup_base_files[]
 	},
 	{
 		.name = "memory.pressure",
-		.flags = CFTYPE_PRESSURE,
 		.seq_show = cgroup_memory_pressure_show,
 		.write = cgroup_memory_pressure_write,
 		.poll = cgroup_pressure_poll,
@@ -5153,7 +5163,6 @@ static struct cftype cgroup_base_files[]
 	},
 	{
 		.name = "cpu.pressure",
-		.flags = CFTYPE_PRESSURE,
 		.seq_show = cgroup_cpu_pressure_show,
 		.write = cgroup_cpu_pressure_write,
 		.poll = cgroup_pressure_poll,
@@ -5921,6 +5930,7 @@ int __init cgroup_init(void)
 
 	BUILD_BUG_ON(CGROUP_SUBSYS_COUNT > 16);
 	BUG_ON(cgroup_init_cftypes(NULL, cgroup_base_files));
+	BUG_ON(cgroup_init_cftypes(NULL, cgroup_psi_files));
 	BUG_ON(cgroup_init_cftypes(NULL, cgroup1_base_files));
 
 	cgroup_rstat_boot();
@@ -6792,9 +6802,6 @@ static ssize_t show_delegatable_files(st
 		if (!(cft->flags & CFTYPE_NS_DELEGATABLE))
 			continue;
 
-		if ((cft->flags & CFTYPE_PRESSURE) && !cgroup_psi_enabled())
-			continue;
-
 		if (prefix)
 			ret += snprintf(buf + ret, size - ret, "%s.", prefix);
 
@@ -6814,8 +6821,11 @@ static ssize_t delegate_show(struct kobj
 	int ssid;
 	ssize_t ret = 0;
 
-	ret = show_delegatable_files(cgroup_base_files, buf, PAGE_SIZE - ret,
-				     NULL);
+	ret = show_delegatable_files(cgroup_base_files, buf + ret,
+				     PAGE_SIZE - ret, NULL);
+	if (cgroup_psi_enabled())
+		ret += show_delegatable_files(cgroup_psi_files, buf + ret,
+					      PAGE_SIZE - ret, NULL);
 
 	for_each_subsys(ss, ssid)
 		ret += show_delegatable_files(ss->dfl_cftypes, buf + ret,
