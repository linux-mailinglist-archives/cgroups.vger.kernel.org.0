Return-Path: <cgroups+bounces-5920-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE4D9F3A8E
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 21:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A789C18887A5
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 20:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD84C1D514A;
	Mon, 16 Dec 2024 20:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MFGdYbBB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B210D1CCEDB
	for <cgroups@vger.kernel.org>; Mon, 16 Dec 2024 20:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734379997; cv=none; b=RQFghX+r0xSV1R9XE8Em2E+y+YPlVapH+f06OfAPntieIJczJWgUe8BiQbxzse2nq4IgbMvArlWn72oW9u7/Wvj6O+mNvRkwwvdRHegAUXdXXrTwaeZD8eyE407MXd8kBfEMekftIDtx7U41yIpGZ4DgSGYNh03EQ29OkVX0NUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734379997; c=relaxed/simple;
	bh=MemPLMXdk3uWnJs6gP0DQZ23rUlRf5oFXli2ZPMpwBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N9mBomOhg52hDy0VI3s6q1G3/itppz5iZy5rR8M68Fk/THFMjYnctsaZM99iROtBghIVd+nDUAm+NeT85PLUTnE1M46GF4G/zIW9UferonooJnemtimdxBYOSPV30j2Fnb3/VNCSHwirpDJBeonMfkjCOWfeT5PBJ1Ir66Ycus8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MFGdYbBB; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so2978936f8f.0
        for <cgroups@vger.kernel.org>; Mon, 16 Dec 2024 12:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734379994; x=1734984794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykUk1nCLfLYbgO6G1uURbaiHMeIrcr+xR9t27WM8uH0=;
        b=MFGdYbBBrxlathNLnbnI3sDz4DiLXLnavDBvvwYiL5NXgLpIUbRtPqJj2xcrdCSAzY
         4eA9PxlEO8lEC9Hy4K9/XdI+acNos5dbVzyxnUi80guhC6/Qv/s3iuszMrUCRnmYiMoO
         vHhrswPCeflHTzH5NW2CDF9HgQeRwVR+qn/v9gIH4KeW3btv4zd02n07xKpO1l24jL10
         TqcOGcoqGcXiI5Oo8EYoWkCIa0efcELv/C3a2YBvCaOhk2KGTMMJAmI+nwF19R7/rqtO
         j+QeEuvy7Vua0p2j0uZCAAdFByOhPYKHb/WuqHBSUgUGv0OnQTvnMNPKFS5SKsU+s0aL
         RPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734379994; x=1734984794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykUk1nCLfLYbgO6G1uURbaiHMeIrcr+xR9t27WM8uH0=;
        b=GU25J6GEHyeR4tcpeO8FteMX+ZiIICALQxiYHOsACfY2pjFwrLu6dFJPGgY2DaM8ZO
         qOJLJWJnbmsHlWFAa2T6GDO6/zpYsz4UzAfOk3jLlFcbW+wVgpepXHqo23fp6SGlqBqB
         j51qsmMtAIg6a+2PPKG1eBHabQenpTs/gvuW9zReGQHMHwWHN36V+swtSG3s0GraoQyH
         zBw5nByPwlq8A2dYZUM2/+z1c4ZulY0FRYCQ2fbjQhZ0+pzZ2n7rsK8XupfATCnj3CeW
         fHYdVw1E9jPRTdlKLdRYHY9A3f54wLaDI93H5VOUsMmnixtSdaYfopjwLzEhNB84Srxh
         Swtw==
X-Gm-Message-State: AOJu0YyvGPKzaphrT/9bV+GbIm/c0dT/1IW0hsyCem/3jPwyaaEv3mLV
	2hlnSlypKIXpt2CJryqiCl+lej8W4geAjp9/8bbg59AwYVLRG4+B0DAKKbF3PvFujsB+2enH4Hs
	O
X-Gm-Gg: ASbGnctL7kBvKRAJQQqmsYi+DSa4oDCnF7ebj+RTlMFyHucw3U6mE9K2sKc6TZCEBi0
	J6Hs3ldKxAgmh2ed1qYwbHhtK7JslCRhlsrn1lwTK8/nPvXaD03JeEpcsHxuGrYc/r2j7nkhG10
	8UoWiCqgfAQIolv/v6yk3tq3qJtJA+wMWv+Vtac3AzDv5pTkYT3ctrn9UAYyLgmuz139NDE1K2F
	qZ40Lu1/DCK40OZteHgi4B1KfZWkB6mUPH7cmqmuYtWSO6d8MQGSH/5PA==
X-Google-Smtp-Source: AGHT+IEkYdyHI1WGeTQVT3vTd9OrSkaJ/xGHM0dboeckZ2SBEOCxX/VzsSBkp7vOrSwHHiSIivFM1w==
X-Received: by 2002:a5d:584a:0:b0:385:f892:c8be with SMTP id ffacd0b85a97d-388db27533bmr583056f8f.23.1734379994063;
        Mon, 16 Dec 2024 12:13:14 -0800 (PST)
Received: from blackbook2.suse.cz ([84.19.86.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a379d69sm473715e9.0.2024.12.16.12.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:13:13 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <fweisbecker@suse.com>
Subject: [RFC PATCH 2/9] sched: Remove unneeed macro wrap
Date: Mon, 16 Dec 2024 21:12:58 +0100
Message-ID: <20241216201305.19761-3-mkoutny@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241216201305.19761-1-mkoutny@suse.com>
References: <20241216201305.19761-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

rt_entity_is_task has split definitions based on CONFIG_RT_GROUP_SCHED,
therefore we can use it always. No functional change intended.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/sched/rt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 6ea46c7219634..1940301c40f7d 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1257,11 +1257,9 @@ static void __delist_rt_entity(struct sched_rt_entity *rt_se, struct rt_prio_arr
 static inline struct sched_statistics *
 __schedstats_from_rt_se(struct sched_rt_entity *rt_se)
 {
-#ifdef CONFIG_RT_GROUP_SCHED
 	/* schedstats is not supported for rt group. */
 	if (!rt_entity_is_task(rt_se))
 		return NULL;
-#endif
 
 	return &rt_task_of(rt_se)->stats;
 }
-- 
2.47.1


