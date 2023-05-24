Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4697100EE
	for <lists+cgroups@lfdr.de>; Thu, 25 May 2023 00:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbjEXWZl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 May 2023 18:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237843AbjEXWZk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 May 2023 18:25:40 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F59E5A;
        Wed, 24 May 2023 15:25:12 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d5b4c3ffeso1135388b3a.2;
        Wed, 24 May 2023 15:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684966995; x=1687558995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Ps4++BD4n2hLwrgjdjqi8hVhoVdzFMxyoqft8e+OG8=;
        b=BxSoVxn1ynWjBrokKf8e2fM0dA5n50KyomGLR6Vb0G9LzB6NAEHYiFrT4g5TK2m6UL
         oedNlWCgSX62iIQofjo1qmkaElTaq6b5I6kq6gGdjZXZ6K/+36AhJJbdkGXJD7iQffAh
         McYJRjGRXeot0dRQzR3QWFJChJTGtNL0cCeLIM2ZM8Llf8ZlWQ3zIIi4hAAbHYtusfHE
         qlumgkbFb1g3kUL/n1jwjxgRG+iyDv0MUW7EU7Kpq/QGyKc0U7Y+1x5IejkhicHrp3Md
         TJLsGeLA+SCSNzpsj6GBh7jTyV4qBGQxUAh1gIJWUMLhW6bFwEU6srNqAr0MaVT9FIJr
         e5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966995; x=1687558995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Ps4++BD4n2hLwrgjdjqi8hVhoVdzFMxyoqft8e+OG8=;
        b=PJatAMBXnrEW1Qj8lzN1B3AlBNOBpqkJoJ6kB741Ag/2d5Tl8e5xJfRrQd4NK9qEjA
         s2B70DDYYzgvSqLiYPCRMIQtZyMB0bVmkUcfpM6chiYcQJLp6jWMRZa1dn6Hp6N1cTBs
         1V4eVZ9fECadULL7L72yXJ14g/30agkBtih1Q7zGG8N+umqJi89jH0D4xqO/JB2NVNlA
         Fff9IGMWLPPVToIBXVP50IqSj6p0uVW4Uh9ALrNVypUSjxkLYPn6ZwTCdBKHaXIM/D/q
         DNsX1AsySRClqQbtxlYNQO7poXfHfH4cJNv/UlkKnjLmeNAT1HKltfWa3lKogSHXJe8U
         7W4w==
X-Gm-Message-State: AC+VfDzPTrkC9/5GUawNdqiOCgEwoS0WIofhIQjB4AyYMvEvs/AOYU17
        MlUoUXE371VSDUp7xpsp4Sx7FwVVMBs=
X-Google-Smtp-Source: ACHHUZ5Enbnh2fdhfla+lUXmQNVArh7/Bqso/Qp+N2hROwoFLV+PVVmFtiabhmRYaekl8gqM/3a4jw==
X-Received: by 2002:a05:6a00:2352:b0:64f:40bc:74f3 with SMTP id j18-20020a056a00235200b0064f40bc74f3mr5277927pfj.13.1684966995101;
        Wed, 24 May 2023 15:23:15 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:be57])
        by smtp.gmail.com with ESMTPSA id t2-20020aa79382000000b0064d1d8fd24asm7912810pfe.60.2023.05.24.15.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 15:23:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 24 May 2023 12:23:13 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Xiu Jianfeng <xiujianfeng@huaweicloud.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] cgroup: Update out-of-date comment in
 cgroup_migrate()
Message-ID: <ZG6OURkhj4uQUTCo@slm.duckdns.org>
References: <20230524065431.145434-1-xiujianfeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524065431.145434-1-xiujianfeng@huaweicloud.com>
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

Hello,

I further edited the comment and applied the patch to cgroup/for-6.5

Thanks.

From 659db0789c2e66c5d6a52d57008e3a7401a3ffff Mon Sep 17 00:00:00 2001
From: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
Date: Wed, 24 May 2023 14:54:31 +0800
Subject: [PATCH] cgroup: Update out-of-date comment in cgroup_migrate()

Commit 674b745e22b3 ("cgroup: remove rcu_read_lock()/rcu_read_unlock()
in critical section of spin_lock_irq()") has removed the rcu_read_lock,
which makes the comment out-of-date, so update it.

tj: Updated the comment a bit.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/cgroup/cgroup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 9d809191a54f..f329f49529a2 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2872,9 +2872,9 @@ int cgroup_migrate(struct task_struct *leader, bool threadgroup,
 	struct task_struct *task;
 
 	/*
-	 * Prevent freeing of tasks while we take a snapshot. Tasks that are
-	 * already PF_EXITING could be freed from underneath us unless we
-	 * take an rcu_read_lock.
+	 * The following thread iteration should be inside an RCU critical
+	 * section to prevent tasks from being freed while taking the snapshot.
+	 * spin_lock_irq() implies RCU critical section here.
 	 */
 	spin_lock_irq(&css_set_lock);
 	task = leader;
-- 
2.40.1

