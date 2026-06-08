Return-Path: <cgroups+bounces-16703-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yOqwC/ayJmp5bQIAu9opvQ
	(envelope-from <cgroups+bounces-16703-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:17:58 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A06806560F4
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:17:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=WkCpvkXV;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16703-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16703-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DC6A304411A
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 12:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1096378D92;
	Mon,  8 Jun 2026 12:15:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F62E35F5EA
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 12:15:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920951; cv=none; b=GD+T3aiqw2XEjbcwZzWL70gE5eDuebSkPll1357tcR3EIuDjGOYYG1Jw7wWxrnPdqn3Idy0Uaa2+RFIq+ReFlh4Zseyd5C5+dv9WY5xBh18P+t6ajgCKDTuAUfdlhr7gkbIXla5DPSmdEVLCGmiRd+FHqENuv6ZqCBLbZqo3CZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920951; c=relaxed/simple;
	bh=cExBacDTus5EuPLcE+dMq0EfEQ2Qzf4UcPMcwgVhM7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNznSCbeOwvhdaoXvgHwMhL9lRrkLajhHuzV7FhXHvOHzYJQqBGKlQsXZsGGyzwwSPOCTN1wd6nb9E8EEFvB0OKYwav6Q+rqAomJ6lkGYP3dUiOWSgfY2WWXzvKLLWuFWaGcsjGQXfltd7gD8L4/Ij5KCDWZg//iMN193NDXHbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkCpvkXV; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b915ded5so35767355e9.3
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 05:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780920949; x=1781525749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4r5mAas9Db2M4QBCfy/IlZpu64a+mCWZ5iexSneZTA=;
        b=WkCpvkXVdszcsngvyc1b8TyXaWpj/5bmtl4/PpjC3HVLCvCT5EI15AUUxw25z3PWu5
         0VSWsu5bgR6lnX7Q69rIVX3dXZBxT2sBtzJ1S7LHeabbl0eoxsZmXS0lsdhwRCFvsqJ7
         4OQ6xnPVfL2Vf1eCPVBvm59LfYT2onnqaaYolE7QWs/YE8aw61Mf4sSmwJldaiiJZYJf
         FfKeoy6vAz86k+Rn2u5hOKQVP/amV7AAQQ9u7tQ+NFGRcNIBuj1wKon6ho5M6+v/2dch
         JoMigPs+UjdzVJslzcED+LXrsaz+ck8MN8iO6QWbHV6cc2TP0OY+vMPhBORewoQfmuhY
         ZRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920949; x=1781525749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I4r5mAas9Db2M4QBCfy/IlZpu64a+mCWZ5iexSneZTA=;
        b=tAQkBfG+HTf2z8EB6LRj7XwheCDte4GEmiiuCsFVyCmr5oIVN8e/gOh8TJ0TZBNaQo
         4tu3VSovREATFvyIEM80wo5zGgxJvnjoGAdyI6ORgNt19NvWr9npGJu1uWkrSgQOd8vd
         Fg2QSmuiO99eAlvPAyo7cAbKzXyExPc2ITw5wy9UnI9VYMOjEJx1ayzDfjh6spGjhwb2
         c4bfUoP0NKy0C3aX4uHvAkw5BQ4mDuheFXSi6UOu5Cgl7XCMiRryj3CJXFNaZ1XmULvf
         Y1lKzOm6WS0yM+xcHYmRf4DyhvIhy+Yb0W4c2GLNsu5TVUdOMNFgwppFamSDksrUYRrR
         qkmA==
X-Gm-Message-State: AOJu0YxBupkgh0aS9Z1vl1pdFcASLvtTeDYBwBkx5jXo8ztgbqj2cimi
	3uU+pmbCi64c8G8lFoS9h9SHd646pbxiIqSYqj7UC8D+homaRcoGI8oQ
X-Gm-Gg: Acq92OGReUI17zt7X96/5X31QA+8DKe/9hrX2dSZNQsLeOGfpMrvSYGYLdht4QL3a2h
	bT/LI0Q+UMdJkvf+mhyx8Whc6NJ+Qh4fLTHlMur5p7lFqAasCW+fR68bPo59nplWEs1ihZ8rhU/
	gnjRIrGCdhm4rus9kCtkmJGpJilBxbr+xBqi8bFv2qCQX0ZfxukiAK9pvRbgC58ukK4TrxxtdI9
	N4BOA2tGAWbZHhqSqjWiO4lQgH2TOdLkuNnD79VaL6zNU2MPFcbiKO6wvI7qOdZmhLMTt/NeT4f
	GzcR8b34NiOEEmLFe03C0X4PRL7KzohNkDCKFKK4I3MaXJMu9coLUBgk21UMLZyb6pHDmDOlwRt
	x746E0s8HyHWx2/GUhMcxmZm6ClI/KSrXyWritB0Adj9gPA0EwHOy5RTmsL27fhr8RlVoEjVim6
	T+9ziOsHfQa1daxLP68nUIu47HmdNU6xI=
X-Received: by 2002:a05:600c:c16e:b0:490:b8c0:d470 with SMTP id 5b1f17b1804b1-490c2622d03mr266687855e9.19.1780920948601;
        Mon, 08 Jun 2026 05:15:48 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm50644906f8f.12.2026.06.08.05.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:15:48 -0700 (PDT)
From: Yuri Andriaccio <yurand2000@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: [RFC PATCH v6 01/25] sched/deadline: Fix replenishment logic for non-deferred servers
Date: Mon,  8 Jun 2026 14:15:20 +0200
Message-ID: <20260608121546.69910-2-yurand2000@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608121546.69910-1-yurand2000@gmail.com>
References: <20260608121546.69910-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-16703-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luca.abeni@santannapisa.it,m:yuri.andriaccio@santannapisa.it,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yurand2000@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yurand2000@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A06806560F4

Enqueue and replenish non-deferred deadline servers when their runtime is
exhausted and the replenishment timer could not be started because it is
too close to the wake-up instant.

---

Already merged in sched/tip:
https://git.kernel.org/tip/eecd5e117cfa63a353f4c69fdcea5d9b14af698e

Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/deadline.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 7db4c87df83b..ddfd6bc63ab1 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1515,8 +1515,12 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64

 		if (unlikely(is_dl_boosted(dl_se) || !start_dl_timer(dl_se))) {
 			if (dl_server(dl_se)) {
-				replenish_dl_new_period(dl_se, rq);
-				start_dl_timer(dl_se);
+				if (dl_se->dl_defer) {
+					replenish_dl_new_period(dl_se, rq);
+					start_dl_timer(dl_se);
+				} else {
+					enqueue_dl_entity(dl_se, ENQUEUE_REPLENISH);
+				}
 			} else {
 				enqueue_task_dl(rq, dl_task_of(dl_se), ENQUEUE_REPLENISH);
 			}
--
2.54.0


