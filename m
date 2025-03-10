Return-Path: <cgroups+bounces-6938-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FECA59BEE
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 18:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51B6C7A36B0
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 17:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEED230988;
	Mon, 10 Mar 2025 17:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d+Pznmcd"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FD9230BFC
	for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626304; cv=none; b=OEnewIgBYB3ci6aYB1xkF389wsmg+BlXwEmhLltKG4AGuKwDkPXigwR6GcREqVQxlKF7j3PQX0gOyoYNPhTRW1HQduSiZn2H2FvOKeC5Ys55dpA7Cpq2TCk1YrUHZ6/v6qT5ium23j/yhKp3GZntTyNL90yVsUQ7/PKF5TRXemw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626304; c=relaxed/simple;
	bh=ulHvHm4ifWHwuLhPFEPjoFTZbkUUcsP0tD9oetZXMyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NEYZW+c1CalYYcOvw19H66pPW44MiflZpMWiWRPnVi8aq9uls2WUWlvbHD2zf4bsdPEoxPDnZE9tB3ufcBUDTdsrS5QEoKdaiNVc7RiZ3TupKMJWry2rF9yFaP2KCJKNbSBkV4eUXj4qm01JqsAL6m+iNFZjr2uoANBWxkDXySQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d+Pznmcd; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso11640475e9.3
        for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 10:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741626301; x=1742231101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1XVXoywLqfki7vGasTJjryB1AUnkPOTgHHVt4Rbtn8=;
        b=d+Pznmcdu5P5tPyaVb4IQXu5YGVsjmjlbUUr1WnmCgc3vtb+Cv02A+Gcxs/bC3PRQx
         T49ZbG5HDQtpErOFgyXQzw+d3IKisFQFvT2R9IjyUwimuwORnmPX02r0/Dry+vadL0gO
         n0aNh5LQw7jQh6puW9DA085Wi+lWgwerbvffzTX6tjfsEsIF82aeuVCm4Z6lySgGAagf
         ht6GsZM+8iUCb/6Qq6ibxkoOWsSbrbclJwsGgPsZILq4e5ZwXpxOLLSLzKvZHMXy8BAn
         vQIvh2dZ0gtdI8fDtJrjIVgbG0PdOXCWwgi8nTKx0hL2gou8udwy8n5hnb39rIoQwBYW
         SS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741626301; x=1742231101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1XVXoywLqfki7vGasTJjryB1AUnkPOTgHHVt4Rbtn8=;
        b=I32QVMREnsW0/lg0Jp8qH4RaO1Hb47Y+EZfspzxBiLKRo5AUYg1kdSTXNJapaSCpvy
         tOhTP/pnnMS21m+W63zWb55t89pMGeb0kgoPmIDQhYFwuREkGlanOmYLOaT6Zns0z12+
         QoTAEZb8MCP0mMp8TreeToufev31SSiwEHQ0jOsOn4FN+RYst5QcMqXNDpEcG0Rd/kVE
         dX6NAlou7Z4gt/E3c52Tj9nKf1bTMEHM5OSb8engIlPFgCVQe9wAokePFrU7epqy8ev/
         48M3ZvjivjURSHQrHc0qdaYyWO3vn55h/W3bX/P7OMFAQUYzOlIV6cGDVZ24wIUT38H7
         4pjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCWdFIjInXJtvb3m8LSbTtyOYJr/Yw2Die23xRKR4GNQVAZTxPgTMu7kUWq89Xseka/K0l2ciE@vger.kernel.org
X-Gm-Message-State: AOJu0YzLaiL54ZIHKKeBVWNWOja98hIZ0mYulsKGYU/5XW/I7RpXmncE
	gGrySyPoSos+wzObYVM6GNU+JxwpwDLoUkn/hmraqLtmp0yUXncEHG960pXe4gU=
X-Gm-Gg: ASbGncteYOzHcQ1gIr5MWHqNgCUl1P4sZDGLnT64d71u5Te87E9pxU/bttokq5VBTjN
	PV1QrGA0tNFwaTodW6ivaeU0ArHOtulZhjap6jQGowkGZQAuLtLBngm434j5KaOXBOuVw0VBPIM
	Wl/AITTAX78D2QgJNf6izObNNEPMHSYn2uLfQ1cgt86Ys+o+ct5zwgK5q78s0TZFVku49LsLDmH
	gWE2l+IUGsXe1m01tsoJaA0v1SJlRN2nG0rrCYOqP9FDKgKJMNSky2R9U79I8Gtw+lBYn9SdBV9
	FcA18Gqsa+NGwClSiT3T7b5awhXf7LGerhOJdXz/7bpBrX8=
X-Google-Smtp-Source: AGHT+IHLhYt01Kb6d2mIiq9FHtyIMTPc4IjBIT5jTxdQZOVbxaPzcSdfaEEgUiXUP6+NCd78rpobVw==
X-Received: by 2002:a05:6000:186b:b0:391:231b:8e0d with SMTP id ffacd0b85a97d-39132dc5632mr12134770f8f.39.1741626300723;
        Mon, 10 Mar 2025 10:05:00 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba679sm15302514f8f.8.2025.03.10.10.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 10:05:00 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: Peter Zijlstra <peterz@infradead.org>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <fweisbecker@suse.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [PATCH v2 02/10] sched: Remove unneeed macro wrap
Date: Mon, 10 Mar 2025 18:04:34 +0100
Message-ID: <20250310170442.504716-3-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170442.504716-1-mkoutny@suse.com>
References: <20250310170442.504716-1-mkoutny@suse.com>
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
index 3116745be304b..17b1fd0bac1d9 100644
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
2.48.1


