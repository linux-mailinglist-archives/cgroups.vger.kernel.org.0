Return-Path: <cgroups+bounces-16726-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u8qcANS0JmorbgIAu9opvQ
	(envelope-from <cgroups+bounces-16726-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:25:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A04D656236
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:25:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=A1tOrh6+;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16726-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16726-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B548730AD727
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 12:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED90E3C3BE5;
	Mon,  8 Jun 2026 12:16:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36743806B6
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 12:16:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920973; cv=none; b=Hoby3OA9rohDjj1wmCx8B+oB8X1UjuSfLrxnBL3oITs5BqKqH7sDzns1z9z8gD+cPUUcPYtmQxSAnftnslCWa9GqJ1hQ7mMH0ZdFMuLaU0CE86q7xH/DtMqUeZX93ijeTwlFZsVHiHBqMXj/SuAXMY6m+qbvpT3P8R+cvlgmKfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920973; c=relaxed/simple;
	bh=HcRNgF/O8yJDYJTUnmjZ+m7CiqJa3AxT4FmrF+40hgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Auvb7KCa7Fs/di1AbRK6+i+He6LMHiVjrKkagM7nJCddogVFFPZ/m/EcRdqYvELHnTbGwlCG1kjpLrSnTytGQPz7s7Ht9RJMHNufSBNfmzoA1VazgYUyM6fsAF2iUShjQuY/zAyIbAjicCyQftqSzRdEOUJCiNfusfh0eCXlxtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1tOrh6+; arc=none smtp.client-ip=209.85.221.47
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45ef5146b56so3310206f8f.0
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 05:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780920970; x=1781525770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkbH48zQzOxR1p1OVZ36l1CXw9g8/fUqm1rKlMh4u8E=;
        b=A1tOrh6+vWISxf0DC5FfGjtd4KVa+Ua4GQNNGnqaO8CbEHPRvL380V3YXJZSKmSLtF
         lpZ+CY62OXdfN6+7y/nR80QR/yptJcLa7SYEOyVewXq4g9+B7psnOXQmDTh6yKESDW9R
         1rOOcIZ48cHFx/Ng+VXdLzDiKkpkBm4CKS3cev3s+VJ5VXKb5G1OtW0Zcg4JXvogn9aK
         H58L+4gizlzv2NWqpEJuOfYruaUkdDS87W+r4LEZAGEP9kTXmSuf87ACzU7LF+M4iRK5
         voIDt0/tqeXbmZPsvWlhzYTZpnPzL2bcgdvzCDopuuTZb90GycBb68gw4eyLwcHGjB+J
         YedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920970; x=1781525770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EkbH48zQzOxR1p1OVZ36l1CXw9g8/fUqm1rKlMh4u8E=;
        b=YVRYyNLkaMulEMEQIm5sm0oDLVeQFpx+sTsWYQs9dsC9hYoRymyuRTeqPqYUPqSnVJ
         l5FWqOcIs8/xBxGYhEVCx/zDEgKA8JMGqD7KnXbMUbHkVoAtWTJeJdY806GZqN58let7
         p/LA9JW2iRGB4U8QvtWkeDGmsvFZPXdUUgoFE27A6jOxyh2dhul9muFcfu+MlH3/zHHB
         4OgQdXDhPiiLsE3FKXEz2LAkiJCyI/fK8GmeXikfL5SZgEFWib8qKVyR+9DKRGJ0YnJE
         VBqjkiMlLF/tHNuuZdrOlDM+/EReICarS11vgXUpr4EW9cN4ayibwCPwUMe6SZ7FewXh
         baWg==
X-Gm-Message-State: AOJu0Yw4APe6e9pyI5yk+pc1Rs7vcPpd+cDg8HZxbK4WMAAqtfXwsR76
	9Fm7hGva0NIFYyl7XuCBxKecQx5T4agS8TkVce39OF23lBbYgjm8di6f
X-Gm-Gg: Acq92OFYBYx5WTLfdx6OX9z5ibG3rdIoOHofHUDjT6hZPM7xl8TPi0Rk2MxctDQGPv9
	PVQh/Ywj7uSuMjGyFkb05aIiCC+wtvRJHksuZTCkbCt9I/kTSiHE4PpkfA526EkkyirQpI0yxCk
	KCiOvcUMJc2wZ5LqZviJIWFxsupi+8Qi16t6207WYOMK8BsCmp8GgmG5g8p5zOI5YyxVxKYTuVr
	FOvMghNGo81UuUchM3rbLb6SOfgnwBPdRLW0S9BxwEP5SzZlWs3/1SPFT603zj4qdIybP4kt838
	X3KvATv0itS8XgLrbRrB801h9R9LPQR7QGRM4GH2Uj5QJnosX7YBr6p8JwJnoTqPRYEr32KLtit
	n2LnztWhZvguJdwyV3T/+7Ewb+z3KoLGTVBiDtuPiURly5P7y/pvxdVIX8TyHxEQ1EDRDZxcZDi
	rMlbj6YOCdSyjRLkzPwH3hKAYsj7X4Sj4=
X-Received: by 2002:a5d:42d2:0:b0:44f:69f4:39b5 with SMTP id ffacd0b85a97d-46032dd94d2mr13083394f8f.29.1780920970201;
        Mon, 08 Jun 2026 05:16:10 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm50644906f8f.12.2026.06.08.05.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:16:09 -0700 (PDT)
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
Subject: [RFC PATCH v6 24/25] sched/core: Execute enqueued balance callbacks after migrate_disable_switch
Date: Mon,  8 Jun 2026 14:15:43 +0200
Message-ID: <20260608121546.69910-25-yurand2000@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-16726-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luca.abeni@santannapisa.it,m:yuri.andriaccio@santannapisa.it,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yurand2000@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 5A04D656236

Execute balance callbacks after migrate_disable_switch.
  Balancing may be requested on the __schedule path, in migrate_disable_switch,
  when the running task is throttled and then pushed away from its runqueue.

Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9e337f0090b3..1d458638aab9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2410,6 +2410,9 @@ do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx);

 static void migrate_disable_switch(struct rq *rq, struct task_struct *p)
 {
+	struct rq_flags rf;
+	struct balance_callback *head;
+
 	struct affinity_context ac = {
 		.new_mask  = cpumask_of(rq->cpu),
 		.flags     = SCA_MIGRATE_DISABLE,
@@ -2421,8 +2424,13 @@ static void migrate_disable_switch(struct rq *rq, struct task_struct *p)
 	if (p->cpus_ptr != &p->cpus_mask)
 		return;

-	scoped_guard (task_rq_lock, p)
-		do_set_cpus_allowed(p, &ac);
+	rq = task_rq_lock(p, &rf);
+
+	do_set_cpus_allowed(p, &ac);
+
+	head = splice_balance_callbacks(rq);
+	task_rq_unlock(rq, p, &rf);
+	balance_callbacks(rq, head);
 }

 void ___migrate_enable(void)
--
2.54.0


