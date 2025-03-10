Return-Path: <cgroups+bounces-6914-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4C6A58F47
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 10:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B7A3AB4B7
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 09:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622CD2236EE;
	Mon, 10 Mar 2025 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMnHrpRF"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949AF170826
	for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741598386; cv=none; b=DYbkNFbPHgcTF2rzD8YAwWPAnyqdilGxkYTJ9pVgUxXohVfBNI5YK62EdYhnT4ZWkWKKfBBt+OuQx0sSDKXb3ljkzRi2HKvSm7PoqL6S5d79fAR23AeOf2EWUxUltf3VZwz1lhp0pBx7uN9bDas+Q5oCvdyi2zT2aQRowi5NZ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741598386; c=relaxed/simple;
	bh=ofu/XDmnupv4JAviLY8SaWPygIQTjFUfrxSbjVFGdzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjauIT60Qjc4GVEVTD2r9H0M1awtj6i0w26dWv5DztddpJto5TdkqplAXyddxkpaSPCJ7+7g78PxQzE3Aad1nzz4s9KpTp03iUxy0drMtnYMFB7nEES0KTr/zmVD5QZEvWqwAq5EHHEQNC+yKqU2P1wsFILT/XexbjALiu1Fheg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UMnHrpRF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741598383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N5e8XPVQftzsj9VqneTTVVLeBZoXHhJpQKjzVqdDaw4=;
	b=UMnHrpRFB/nnD35C6qVauH67knTdeGjr/ANodUvwaGO48rmjKrMDzakrGVERFMuAMzPKOF
	gtNDCA7lGs0/i5pjgsknmfdv+SuVy+5ZMauAK8r238R8Z/HJsIb+FSI+ot5+h+0THg9lsr
	aJrQ+bhMXEi7P7q7etGIPhazlITV8H0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-IJV64L36MgG4zUWbrBWpZw-1; Mon, 10 Mar 2025 05:19:42 -0400
X-MC-Unique: IJV64L36MgG4zUWbrBWpZw-1
X-Mimecast-MFC-AGG-ID: IJV64L36MgG4zUWbrBWpZw_1741598381
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43bd0586a73so32321125e9.2
        for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 02:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741598381; x=1742203181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5e8XPVQftzsj9VqneTTVVLeBZoXHhJpQKjzVqdDaw4=;
        b=s9XhD5MacQJjFzST5n2++jNCvC2Fr0JDE4egdFGI6kVxDuZcYWlcjl4xWh6ygiIOuM
         g3Uc533xkXvQW4+KD5wYcnHQe7JvrfS34+dd1w1WtR0hSVU9c2UjlIv/2qB8zdXMYWqK
         wTlOgWY8tweTiECoYuXDg3rdoxAIcAN/pbdkpATMHrgpZxKJ8gXAklRS/Gzkfz3M6vo7
         A1qA9qJv9yedAyT+4WUGEJxmdsCbo9W/uermqtyn+HxPzJEdRY4zll+aI4jgy3NZ4lcT
         bkfKyDK5LcIs93XIstIcuyDCthpSC5e5T2A3nYSu8p3EsDrhtnyFAAYjrQrlhEP3CwHY
         Zv/A==
X-Forwarded-Encrypted: i=1; AJvYcCVP0wipfofCXNtVWYcZRsRVcpETztFWquKbhOmbGZaZgU1BHMcciL85HfqG56FLnQjYyt5a14PZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2BeR4aArQVhA9DQqh1VuSubo27njzxFSl4Hf7GqrNoSKLlMb2
	r7SyqI8gS/uEjRF4ng7aotXsMyF7ffzHAVWw9jVDwFLTQIgGo+cr8h4OOtBpH58G9zuVr5USYYd
	uil5C5yP6pg3Gp4yMTn5xT6TecnYu6osK02F7un7T72ogui9vSnC+99k=
X-Gm-Gg: ASbGnct/ivya5oTKkIf6GZizNdkuIDSIXVe2KBqS3Bgn8+Ai0enuISGWH13vxx0wkz7
	OzLnMqKaKQ2eYnabb9I/7VpEZobu5Bzc7X6JWyttn0v0/vJtbkYmTBNEsX9sS/Jl9QhtUTgGaoR
	4AI2Srh4RUMn3SZzM/XsO76+Qq7Rdpp7fBx8Ab6n5PRHxvOhntz++XaqXd+AHkPPrCGhkg6S5am
	9rheL3Xg8NOsqmNWuirLvatGhu9n2JcYZsOvdYfP+MNG34BnfhO1rMc+OJWxablnVjqCWpz8lKn
	kugAJpbf1TYsztiyN7kdRD2cyOlU8y0GQ+Je2FxFnx8=
X-Received: by 2002:a05:600c:4fc5:b0:43c:f969:13c0 with SMTP id 5b1f17b1804b1-43cf9691636mr14251945e9.29.1741598380831;
        Mon, 10 Mar 2025 02:19:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYwaPQhNcEyHI4jeS2gXnFMH/We5pnIXg1uaGo0WIN/FUnIPC+tMOh6jU3BTonbxCUdQr4Rw==
X-Received: by 2002:a05:600c:4fc5:b0:43c:f969:13c0 with SMTP id 5b1f17b1804b1-43cf9691636mr14251705e9.29.1741598380400;
        Mon, 10 Mar 2025 02:19:40 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce8a493d0sm77462735e9.1.2025.03.10.02.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 02:19:40 -0700 (PDT)
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>,
	luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH v3 1/8] sched/deadline: Ignore special tasks when rebuilding domains
Date: Mon, 10 Mar 2025 10:19:28 +0100
Message-ID: <20250310091935.22923-2-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310091935.22923-1-juri.lelli@redhat.com>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SCHED_DEADLINE special tasks get a fake bandwidth that is only used to
make sure sleeping and priority inheritance 'work', but it is ignored
for runtime enforcement and admission control.

Be consistent with it also when rebuilding root domains.

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
Tested-by: Waiman Long <longman@redhat.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ff4df16b5186..1a041c1fc0d1 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2956,7 +2956,7 @@ void dl_add_task_root_domain(struct task_struct *p)
 	struct dl_bw *dl_b;
 
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
-	if (!dl_task(p)) {
+	if (!dl_task(p) || dl_entity_is_special(&p->dl)) {
 		raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 		return;
 	}
-- 
2.48.1


