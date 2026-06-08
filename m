Return-Path: <cgroups+bounces-16704-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 51skFA6zJmp8bQIAu9opvQ
	(envelope-from <cgroups+bounces-16704-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:18:22 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D286560FB
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:18:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=sncBl5Bt;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16704-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16704-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCA1B304B2BB
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 12:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC770379EDC;
	Mon,  8 Jun 2026 12:15:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE53370AE4
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 12:15:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920952; cv=none; b=bslG5iJ9OuXB5aMeEk3SqMhv9YultGk8kNXZFZYjjlRLhXY9q3+Wody/RWM/lUbU9cmy5MXHmRUkWVkjrgQaPYiwA1wZj/X/UMhxJe5LOvRFCLzfIRF2Ok/Sfyw8pNf0LxagTBJDbIeTEUk5ue2XarRiCZaVAaJnsTZ4gIxQMlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920952; c=relaxed/simple;
	bh=UjEBDxtPRqozcWdlJuwbLUvPglANfSeYQER9BO4aiPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhGqIrsfb8pAwAX09qAJgHc0nCm6tdIB9lgyL/M4tmRXcDfPyOOwsgbZXwXjmZLZYiJaw88nYiuREYIZoAj7TZcEZnfDe5zsV52pp7kO++evimGiDRUvWSdX0I6RRn4SdUfDL+DRAIHP6uUQagso2RPfzQHnv+ov3v0uO/PJHVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sncBl5Bt; arc=none smtp.client-ip=209.85.221.46
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-460166910e6so2137142f8f.2
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 05:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780920949; x=1781525749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aa6pcb3XbDlbPOw5oJXZLx2AdQ+6MRmY7aNw+gfgVdc=;
        b=sncBl5BtdK1nsqEbteCy70OKWgtnEYj6CHYB2xzZuJgx7PRLexqr26/CB3Ss32RT3Q
         VJN41aBe3VRVTLeTBTIWXg3sB5/fZ7ajSjkx9i5lkKMlVnC8KCevBcb8nfXvcxilEDrb
         +a/ItWrzFObTQbOZaOY5K5DzSoPavTJtVUsxtz/V6Yqo14FyB2xWhSnsHTh2yYAQ6g6P
         dkPdOcR1fwGkDj7xR4tYLLlFBiPR9EfZJCwkW3anHF5vv0b29I5c2+5D6waj7KCS/YCg
         hsIIXItaZuvX8P6TzhtiURsE18ceJORGncK8mOiLfQTXMdfI0JoYcOooS7v6dUiT9BQL
         /kdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920949; x=1781525749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Aa6pcb3XbDlbPOw5oJXZLx2AdQ+6MRmY7aNw+gfgVdc=;
        b=ga6tojTFlBYhsnNsxwIOfqigzDe4ypEn0/bxkX0PNC8JroLrS/QmY+Gawhvflx/N9U
         Thf6wQ4N2bsr3ttouWOx8e0zO9ldhtfoefUYLQEw9OBbr3Vo6sgeyfOrekM5HnrSYMR0
         8gwOlzwUacHnllEjhSonRGlN/sWk0PA1V3IPPynA1NON1pUHadfxeudruXb10OT/NpQ5
         Qr4xO5qjD3eBu1NnBWy8XO+0REweAbvtDexzjxTGOXV7eLN9R7YHrEIOXDjF+03R2nIy
         Qr2SVYH1PW9c9GWdmjQosLRI//P0m2RHon8hE4ofU0lcQET4pwsYKnEr//qZCS5ISW3V
         KJnA==
X-Gm-Message-State: AOJu0YyvpbKCMQ/FrrXbCU+xUZTsU6/Nv8QPbVwmGa1oblHPpsbkqBw0
	QWCaBtmcygqPixfFL/V7MSC8uNrHm4OEK5LkAbSjyixAMCMJIYatYY15
X-Gm-Gg: Acq92OFW/s9jHTUZTU8ydmmEp7yF5pjB9wZLoLXI3TkonbSyK7YHWOtDtipnaZ/zsWm
	pJQNb0cl7Yo4dIyBoMjra1xqffulif2R351AOGelMA0lpZqn906Z30lU+ssW+z5YWU0lFGOmm2K
	YEOjWBrl+PP7zvlXRjskfr51PYZHXx5bQ2FecJ9bx+T8iEAg1HFrwk26Z2woHRs+2k1oEI21g73
	udJDGxq4rllmhDVxHC5Rg97uvsMqOqALzDwWG+nBWLoZiuh6pZBwpHr+djPSyw5nsglUq+3HN0R
	cn8rAHLmfAL7/hHtrjyr18qtB1tEgeakvx4ppefJxf7S9jAguBx1TX1Twtwblo+esQFGMfmfhHu
	6MolQEHs0J4F1KL/qUNkByInG2YnIB4jG/G2NiJWprKJcTRULvIN05zG+tnn6gJiDx9drRrAxOe
	vUZxMLKzaABjDAeL54ujx4zpd0FphFiEY=
X-Received: by 2002:adf:d02f:0:b0:460:f36:79b0 with SMTP id ffacd0b85a97d-460304fda0amr17776245f8f.19.1780920949486;
        Mon, 08 Jun 2026 05:15:49 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm50644906f8f.12.2026.06.08.05.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:15:49 -0700 (PDT)
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
Subject: [RFC PATCH v6 02/25] sched/rt: Update default bandwidth for real-time tasks to ONE
Date: Mon,  8 Jun 2026 14:15:21 +0200
Message-ID: <20260608121546.69910-3-yurand2000@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-16704-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A3D286560FB

Set the default total bandwidth for SCHED_DEADLINE tasks and servers to ONE.
  FIFO/RR tasks are already throttled by fair-servers and ext-servers, and
  the sysctl_sched_rt_runtime parameter now only defines the total bw that
  is allowed to deadline entities.

---

Already merged in sched/tip:
https://git.kernel.org/tip/c2e390197ad1360db6686a8c89abaafaf83adf72

Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/rt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4ee8faf01441..e6ea728f519e 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -19,9 +19,9 @@ int sysctl_sched_rt_period = 1000000;

 /*
  * part of the period that we allow rt tasks to run in us.
- * default: 0.95s
+ * default: 1s
  */
-int sysctl_sched_rt_runtime = 950000;
+int sysctl_sched_rt_runtime = 1000000;

 #ifdef CONFIG_SYSCTL
 static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC * RR_TIMESLICE) / HZ;
--
2.54.0


