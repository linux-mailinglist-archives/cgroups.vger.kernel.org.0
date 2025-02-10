Return-Path: <cgroups+bounces-6480-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C1CA2F114
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2025 16:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F9373A55D1
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2025 15:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9AE23BF99;
	Mon, 10 Feb 2025 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="McNG672j"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB721204876
	for <cgroups@vger.kernel.org>; Mon, 10 Feb 2025 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200380; cv=none; b=Xj/SjJoqkOa25evSeZEyXtJud677igh+9bPjbohjMShIZczP6WsLXqJ+/Uvsk8w1wjiU+dIZIYOZ3MhLhxH4ghCwONInfZODapQ7wEruE5fY+/raLBXf9E4kzkJFOfcKemV/2CBaX7OuILIQLbkuBdoE29E7uh/h3jANcMlZTkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200380; c=relaxed/simple;
	bh=ulHvHm4ifWHwuLhPFEPjoFTZbkUUcsP0tD9oetZXMyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YIc5MkWtj8OnArNH+ZNveMmEzmy9cBkh5ywtNHHCOKbxecYxe7u1VXISxoWB4aWn9vCH4OXH0zZaO8sdlnG70433NtVGFYZbpyhZv6BM3ipmZLCME7ZmDKhwy0n9QrZASN95spBB0UUBLlyF9xj9VNk/0olUlncfMJBmhZcWPFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=McNG672j; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaecf50578eso889297566b.2
        for <cgroups@vger.kernel.org>; Mon, 10 Feb 2025 07:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739200376; x=1739805176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1XVXoywLqfki7vGasTJjryB1AUnkPOTgHHVt4Rbtn8=;
        b=McNG672j6sqqp+IGQiZuENkWW6y7g2R68sks8diMZd4Lx3i2VXluYNlXHRoKwt2bZj
         gcY4xW9aaFk8y358uMqU0yq0KkifjeWr5sHc/TfoGA+6WFhOvDicZQJ57QXixNw3ZAFp
         pKH3yA4uJ2uiEdsvFiQ8g7eGs0evi2PQM9bEKiJP5WHrqoWGKRjQKjuqfcOnjaeI5W4I
         gbG+AoXlzaK8DBGvBeq9/RHOXRup8k8ARtyDBiwFvMdiadIPhYaR3lIQzR7W4Lp8X1tU
         uMSz0YV+V59NnyMVe1iaKapzeTIRoPJYO9Js3BWZRhxmvyxz1B07yCQBrXY7gWtrLJtO
         9acA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739200376; x=1739805176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1XVXoywLqfki7vGasTJjryB1AUnkPOTgHHVt4Rbtn8=;
        b=SPbry/Pt1J1CM16QwAJvCd4P5SGqS89toefAXuCpIsJHUxUG0ajUUOqKVbNvZwOcg3
         xDcR+uk9tAuK/qrnj3YGD6crln/VjWhKYhNm+W/n5YECKUPI/PA6e/juFCJfrMosTDY+
         Lkff99FztzFGB9HqEPTOTHVifYBNuwyWX6NTBMAHnxfo5Tf8Vc+Yjx3jI72cKq3Q9k8j
         xUvwpGUac7k1QI0m6hgWHF4a+UAJX9iTkbnWl+kt3xWDJvlOHIBFNWa/O7IJpaG0Io7z
         ZXbCzyTkqn8zUh3qfUXVPJnETfOLuTG2PMHd4V4+/KrZhZ5pxJkiVv/1cjf2X4TqWle0
         9X3w==
X-Gm-Message-State: AOJu0YxV5tD30e8aqsvX/jLTS6Qk5QB0RvZdAhASBaGuZpKP7W2bI+qK
	sujudLUlnBh+CsVjRwBPiEbsbBVPwzHUI1dtZ6lDQ3MZwDPmHosf1si6t6jd2fOUD/2/vWZCkwV
	s
X-Gm-Gg: ASbGncskKygzzDlAMawVuVewvrWvgl48VDvEHc+UTCEQGLE7g3utrWfiEwwLuUJBuZF
	KaISYM36DFeEVxvpu/7Iw3HuHPue2ri/f1L+V3LC68/RV8s5KQSxL49EXBWRVJ/q1tBUcEV2KVJ
	Um7/vXB8x9F2cacs2Yui+Mla+wgWualmjARzNU5cwPm8mZ+e/OB31REVnZJFaQe7HH7GKIAz0OI
	UmfZ9jh4jZo99O7mFFfpOFvyrqe2z/4G9WctEl1Za847zaKg5lszakZgp4mYz3UWarLtGxFoh53
	R87RJH2tHjUWlFa2TQ==
X-Google-Smtp-Source: AGHT+IHsHQFc3X6Y/WpOuje7/im6oWOB0bQqY28XRbEOckOEoxISoOotX0WPyGhk1EP1KQLT3TLonA==
X-Received: by 2002:a17:907:6eac:b0:ab7:d6c:5781 with SMTP id a640c23a62f3a-ab789b1e3bamr1456428866b.24.1739200375951;
        Mon, 10 Feb 2025 07:12:55 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab773339e82sm895192866b.143.2025.02.10.07.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 07:12:55 -0800 (PST)
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
Subject: [PATCH 2/9] sched: Remove unneeed macro wrap
Date: Mon, 10 Feb 2025 16:12:32 +0100
Message-ID: <20250210151239.50055-3-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210151239.50055-1-mkoutny@suse.com>
References: <20250210151239.50055-1-mkoutny@suse.com>
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


