Return-Path: <cgroups+bounces-6858-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE160A54D0F
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 15:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81C73ABD5E
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 14:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889D1155757;
	Thu,  6 Mar 2025 14:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hmmkVwo7"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A2DCA6B
	for <cgroups@vger.kernel.org>; Thu,  6 Mar 2025 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270250; cv=none; b=GdDO1nNph6ci0NC6sZI/e43AJzsAxFV1YkYkhtDO55YcK+bKh8Tua3ITxDMBylYEgNlh5YrixG1VS90ZRy+IemZCK5esLEyw8aI0KPjwGZ43s/wjBScm4PkEonSTDFZBIZEdwybz/Q03Nx6e98Tg7+1vZZHoYzmpvNTnXBx1xUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270250; c=relaxed/simple;
	bh=xcnCm892YVWrZWbMShd7y4D6hSOZDUxmmffjBmaQwmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UIrXGmUPb1VT36u1QKcmKk/l4aPVopBA5uHVWU9pVRKjwFoeusXDz9rw28RBh4Exjs7wgebpzCLH/icQUB/+QuEQbjzpnkePqsccoS553qt0zMtqy6Q+G+v663CjQET9jC7clXUKMxqcjMN3I8Z1m2l4cMiHVQ/4kTe5DH+Mk+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hmmkVwo7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741270247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fsKE1JxR4r83PaPSyABYFCVJq9bgn0zVEf+tY5alCNY=;
	b=hmmkVwo7XM/5mSst0ryrkVQxXzrB0yF+4TOD5eWp0+CpH3KpcufApukVxuJH6wJ37YVs/G
	zcOLSgwkUb2pk6imoo/Q7vpm+iNt66uU9yXBBNhFr4iOkId2lYl35MIgMiNen7WIXpWL5K
	O3H64ULob2GPKfNbPg8/8eO4KmHJiLI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-WsqXB6y3MuKU6JrGb3crAQ-1; Thu, 06 Mar 2025 09:10:41 -0500
X-MC-Unique: WsqXB6y3MuKU6JrGb3crAQ-1
X-Mimecast-MFC-AGG-ID: WsqXB6y3MuKU6JrGb3crAQ_1741270241
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c0a89afcaaso147301985a.0
        for <cgroups@vger.kernel.org>; Thu, 06 Mar 2025 06:10:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741270241; x=1741875041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsKE1JxR4r83PaPSyABYFCVJq9bgn0zVEf+tY5alCNY=;
        b=eR48xs410FgVKFdgr4tXF0tLii4PnsmK/YAM/AlozKy4HWqNroFgZ2pzAlR+TtQEga
         M6IyYHNQOpRfBJKhPzJ9c5v3ggT8I1IUvlWqyY5vj1nhhLLERQDlUUyefbpzhyFfYYSD
         79I464EzOReV3IAKxto4xfIVEYq0k8uZfstFMTGs3ZT1JjAS2iCw7Fazko+rv4whWXCB
         NeM5sHy2IJpPPdIKuxhNWUss/uYrquBekB3juREwLMUjqWau0cgmnI/rapWve38c+74V
         paDhLrCH4Uh9soVmU/f0NyEOO92zm53ahenqZ4FbMb7Qgus/+KBEWjwf9XAhqcUFu2jd
         FhVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtbvLN/im8hNlecePYm5r22I1u6M1dBaK1jcoNlBzP4smPcHoKNyAk1w8KKiicC716SloW/n8x@vger.kernel.org
X-Gm-Message-State: AOJu0YwH2KJJm4YlN+4z6i/4plES86JrrG36GMYSaZ6nwvdCBhP8yu+e
	z4uNrZn4x96C88IV02mtIyEynfjMvtyaQjYoe4ercPRVTX7Q4UaIY/fCKhPHdaVc09Up0rBxn+0
	ih5qqRe9ObXwPiaqOpLMK1/lFz7x4daz57fxqKstZr2gY9uGWzajlTSc=
X-Gm-Gg: ASbGncuqVYFZSFEH+HY402CTOVuy2zVQdmCbc5lwECxPDym/UsHIzhDtq7ZHsHE7+bg
	++N/avidOYV71prSADD/ppOWo0MvbJfhItX5vi+qz6cyAZD+wyz9jJu7zuK502AbCT3EXvfZwNL
	cYYyFIHeCVMGnw2cEUzhg5RycANqzUuq7yVomoqGBNVeIugk+3kBcq31p9lMKgkO+PDfG20cep1
	CSRj5+s68l2Akv5CK36K/NCjH6z1s3bBf/D1eqLgq+PZPP1BhwxLJf+ClNZj6jXiy/cBiz6M61Q
	/vE46n6oKQ5G9X6C0cm6dYKCaEbRjwjdfizyosEg7IFiMzDgavkz2Rn1pokAY6moScP7x/Rgh/F
	9pZA9
X-Received: by 2002:a05:620a:1b96:b0:7b6:c324:d3a5 with SMTP id af79cd13be357-7c3e3a1c910mr432226885a.19.1741270241028;
        Thu, 06 Mar 2025 06:10:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdyD8P5f8M2e9rNo87PDZMvWDzY4ue5a2vKgh31vwHmBPocp18qKgVS97FsSXL2hbSExV6Mg==
X-Received: by 2002:a05:620a:1b96:b0:7b6:c324:d3a5 with SMTP id af79cd13be357-7c3e3a1c910mr432223185a.19.1741270240727;
        Thu, 06 Mar 2025 06:10:40 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e551119fsm93658985a.108.2025.03.06.06.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:10:37 -0800 (PST)
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
Subject: [PATCH v2 1/8] sched/deadline: Ignore special tasks when rebuilding domains
Date: Thu,  6 Mar 2025 14:10:09 +0000
Message-ID: <20250306141016.268313-2-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306141016.268313-1-juri.lelli@redhat.com>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
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
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 38e4537790af..ab565a151355 100644
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


