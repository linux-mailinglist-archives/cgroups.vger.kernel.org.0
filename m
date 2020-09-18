Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C01E27043D
	for <lists+cgroups@lfdr.de>; Fri, 18 Sep 2020 20:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgIRSla (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Sep 2020 14:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgIRSla (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 18 Sep 2020 14:41:30 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B19FC0613CF;
        Fri, 18 Sep 2020 11:41:30 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id db4so3483752qvb.4;
        Fri, 18 Sep 2020 11:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RyuK5UieZne+pKhpGinbT1xLnPtjZ4n2yvvqOQQR/RM=;
        b=bijR7TvXbgX48PfH9waDRVC/Tbn3PSFLH/s/gHvqLfGFatnCdUy9xUMEhd8hR+12c6
         bM4G7PDeskHdUznZLA0Y1RXttv8Zf5Kc4gWb0xfOf7BiW2JvYcY8zQoWk/EWjxWDr9Co
         F6lzPp0d/WanDs+PEy5McGVjmqp9J4aOu1Mj6fu/oo7Zb28uMf6HGPvK3eQekiroIocI
         qgnEXOWua96Vs6spW1iBrlpEY1kxchcSzIEAAer60R4lQGVJsXv55z2V/a4PjsGPbf7R
         0pHxW2in/M7Xd1ZBpmWUarETt52ESRjqTDHazLcEMmOk0JD1lIYUj0mqE7Idd144OnLF
         94sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=RyuK5UieZne+pKhpGinbT1xLnPtjZ4n2yvvqOQQR/RM=;
        b=R6Igt2pcSBpeIJSiGiK++72Kc+2hfNI7Gg0GMRG5pf1EY9BccHzgEmZViiPJhpfnIk
         +nc05zhCbC5CJKOJB1BksU/7MretGyaNRH9Nd5Jtsx8HqrB6+bvqTl2QN6Kyl8bvBxBz
         npDzEm5wmjQOCJO5oXA1iYKgkOB/RCDllEnGghlPViOlkb1csyq0Uq3u7HIGNATUG03m
         Oh2EIuwQTEHzrySAQ8mexQhzX8N7qs3s5KxMRqKmXKXHPw01EoOy8AMLSgmh7l76OJdZ
         YNbNY7NCkPNkG+2g9/zVZdkkXPENbUlWNR9DvKDUgBJfSL7FCopkwoSaeEBYjhH9h9op
         VAOg==
X-Gm-Message-State: AOAM530IL2qpZuoziGyMoUB62AHLxPC7F6wWpjbSY9d5+HfHgQBvQKFA
        poh6GX6GoTsrtOL9W35iDn0=
X-Google-Smtp-Source: ABdhPJyrfE5zh7qVv/Ct8VYZ7c9haa82D17TT639IsPr+2OBmTZj5Zp7at5HyuG8X09vdAQnQQeKVQ==
X-Received: by 2002:a0c:8ec6:: with SMTP id y6mr23235555qvb.24.1600454489667;
        Fri, 18 Sep 2020 11:41:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:602a])
        by smtp.gmail.com with ESMTPSA id 18sm2584248qkd.120.2020.09.18.11.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 11:41:29 -0700 (PDT)
Date:   Fri, 18 Sep 2020 14:41:27 -0400
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: [PATCH 6/5] iocost: consider iocgs with active delays for debt
 forgiveness
Message-ID: <20200918184127.GB4247@mtj.thefacebook.com>
References: <20200918004456.593983-1-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918004456.593983-1-tj@kernel.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

An iocg may have 0 debt but non-zero delay. The current debt forgiveness
logic doesn't act on such iocgs. This can lead to unexpected behaviors - an
iocg with a little bit of debt will have its delay canceled through debt
forgiveness but one w/o any debt but active delay will have to wait out
until its delay decays out.

This patch updates the debt handling logic so that it treats delays the same
as debts. If either debt or delay is active, debt forgiveness logic kicks in
and acts on both the same way.

Also, avoid turning the debt and delay directly to zero as that can confuse
state transitions.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Jens, a follow up patch to the series. The git tree is also updated.

Thanks.

 block/blk-iocost.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2048,7 +2048,7 @@ static void ioc_forgive_debts(struct ioc
 	list_for_each_entry(iocg, &ioc->active_iocgs, active_list) {
 		u64 __maybe_unused old_debt, __maybe_unused old_delay;
 
-		if (!iocg->abs_vdebt)
+		if (!iocg->abs_vdebt && !iocg->delay)
 			continue;
 
 		spin_lock(&iocg->waitq.lock);
@@ -2056,8 +2056,11 @@ static void ioc_forgive_debts(struct ioc
 		old_debt = iocg->abs_vdebt;
 		old_delay = iocg->delay;
 
-		iocg->abs_vdebt >>= nr_cycles;
-		iocg->delay = 0; /* kick_waitq will recalc */
+		if (iocg->abs_vdebt)
+			iocg->abs_vdebt = iocg->abs_vdebt >> nr_cycles ?: 1;
+		if (iocg->delay)
+			iocg->delay = iocg->delay >> nr_cycles ?: 1;
+
 		iocg_kick_waitq(iocg, true, now);
 
 		TRACE_IOCG_PATH(iocg_forgive_debt, iocg, now, usage_pct,
@@ -2129,7 +2132,7 @@ static void ioc_timer_fn(struct timer_li
 		    iocg->delay) {
 			/* might be oversleeping vtime / hweight changes, kick */
 			iocg_kick_waitq(iocg, true, &now);
-			if (iocg->abs_vdebt)
+			if (iocg->abs_vdebt || iocg->delay)
 				nr_debtors++;
 		} else if (iocg_is_idle(iocg)) {
 			/* no waiter and idle, deactivate */
