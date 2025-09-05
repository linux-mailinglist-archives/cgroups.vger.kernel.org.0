Return-Path: <cgroups+bounces-9742-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5243FB45383
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 11:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5618C172C72
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 09:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2883D286419;
	Fri,  5 Sep 2025 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b="aaN+h4wA"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8019D27602D
	for <cgroups@vger.kernel.org>; Fri,  5 Sep 2025 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757065138; cv=none; b=F1gbTY+bP10jZHo7E4ba06EShcswIzO2OcFHuzmNjnyFg7wzWKSMOi8o3lWkkK1X5cZWSNZ4mMfbYby1Ox/NPiHjwBCuUNiX+sWCBDQkEIXch/WVF3nouFi6DogL7qksm1DuclW7CYuK1Q+ImAaE81N8uAyGKbbD+RUVM2Tgo4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757065138; c=relaxed/simple;
	bh=DQzqJSkZtdf2m9T83N17crffKyn7mU69jfmQVqs9XxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tU4CfDd5MSRerGeMbjH9+9b69EYPNRNTYCOH7XbRJiPw9rZ9uIS9NdMTTzdWbaGJmjUHL1Q8FpI+b1gb1ACHYCSj0S5AUon3fQ5Pj1oyS3x8liwRHg1iAwVAHcwRs429VQ9XuCIflb62GtS68tLd1Llil6xmvYdXkJUiPQNP1sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com; spf=pass smtp.mailfrom=aisle.com; dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b=aaN+h4wA; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisle.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-619487c8865so5529755a12.1
        for <cgroups@vger.kernel.org>; Fri, 05 Sep 2025 02:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aisle.com; s=google; t=1757065135; x=1757669935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8Lga1GkOl1oDiE+1dVHrqOvB9vstlkU/NOIqsz7Q7A=;
        b=aaN+h4wA3465qC28QM+eRTSaoFHeaqr5J2+wDrPvQWbMFgiVrQ4j2Xl3NNrJir6jdo
         uzn2pUdfqyTKKRAaC0vtJfR7ryLmwkNYJf+cHFLSvRG8+Dq9MCpdfN2wGAK5BoQAbjDI
         hjAlZ6TaqFDbJRC+Xi/titBmvO1CFV3b1PS9HiuOawloLfQJcwlCOKRNrra7LqWwWokb
         sIWPmfUkJCO8/Z9kW0zD/KtkZBv9d20Mx1SGfMEQFoQJqzbsTzXPwa7oL/W5WAOVHmL5
         W3vXMZszXAgjKY7f7FCzvjZLGcR+6nGsWIJH/vekLIJBHnGInswjV+rmkryCdFzMMdx1
         KIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757065135; x=1757669935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8Lga1GkOl1oDiE+1dVHrqOvB9vstlkU/NOIqsz7Q7A=;
        b=j8rmFS8s5sHFwOL8Fb2//mFRvcL8PTTde72gigVCVJwFU7IqIf+FXAjl43dvFFNJDL
         TeRiGJee5mstu2Hb2d8s7wxZ92Ul/obEUPeZa7iaN96ULxr0GCemU+vy17+e7BDvp4E8
         llfRkm+M4V7xaADPJfYysuN16/7PVHTrPoStoPQSuLwDaIvtRPvKwk+rgytrHX0dt8dp
         1aDrMmFiJ6V9a98wFk7BCxgiiFHDS6vdCeaysl0sz/g28U9wpTJGUJ1w7M1y1Et0XNhd
         +S7qhpP72mTkVI1edWoen6tkV9leUE2ndqRT/FU0s0/Jb7M8RfQrfoJBaC0tCdyaKzsg
         TJ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQjY0XGs7c8fW/3W6kMl/haGKbZr7OAy1b5HSRXbcUSGBe6H/M9ZvqimIzsKXmLslSlDHNkM3/@vger.kernel.org
X-Gm-Message-State: AOJu0YyyVa1YG77DRcSaHdCBUxwEZSDuC8OQXlCnUuuY0rJp/L/U8jLR
	rk+BDETTnYC9CEkMquKCjuwdvJqN69yJoazZjNtde3nhM6n0tS28eT0S7RbfWRR27dc=
X-Gm-Gg: ASbGnct6/9fqC/fUPFtk11bWaRRcQBj3BvXzk7MBJ0eYHsrRMi5vH1PR2SmO3pJ/DzM
	yZ4hZrfaR47UOq/mDPxC8a09Qp2ZgMCJSieS1i5wghqEE5Fc7+v7bKT8FOjceqaIvQ9tl3u1QpX
	xOXt7Gs1XQe609iypabFrupABDDMgKqOuj4mwhmmlSwti8KFdDEquzhFGfE5dk4yvUtjGfqsJkg
	xFTTr6CizQWed1DwOz1jrrQV4y/ppWilZQC8rdj00+JbwkNUuj1upppN7Kg/ZMCBPQFp/vm3a4X
	4A8VHDCuuS+fte2ZHapoRKqmWtyWhMog9f/92BU/3ZmtlI/SJQykY9zB/LzxQc70T2q9aC9ci45
	KP8Mcbkb17BYmOGuv+RSYQtSs6RPWajbwfHamkyO2oq0Pwto=
X-Google-Smtp-Source: AGHT+IGybuK6K/kujLTwnL+Fz49sav06Z8CCw7Z9351OYmVQ4LWXK44fzX23p7+KrdEaFzCMcOmACA==
X-Received: by 2002:a17:906:b24e:b0:afd:eb4f:d5d2 with SMTP id a640c23a62f3a-b04931b6715mr240740366b.31.1757065134805;
        Fri, 05 Sep 2025 02:38:54 -0700 (PDT)
Received: from localhost ([149.102.246.23])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b046df9a44dsm561055366b.70.2025.09.05.02.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:38:54 -0700 (PDT)
From: Stanislav Fort <stanislav.fort@aisle.com>
X-Google-Original-From: Stanislav Fort <disclosure@aisle.com>
To: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	stable@vger.kernel.org,
	Stanislav Fort <disclosure@aisle.com>
Subject: [PATCH] mm/memcg: v1: account event registrations and drop world-writable cgroup.event_control
Date: Fri,  5 Sep 2025 12:38:51 +0300
Message-Id: <20250905093851.80596-1-disclosure@aisle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250904181248.5527-1-disclosure@aisle.com>
References: <20250904181248.5527-1-disclosure@aisle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch __GFP_ACCOUNT to GFP_KERNEL_ACCOUNT as suggested by Roman.

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Stanislav Fort <disclosure@aisle.com>
---
 mm/memcontrol-v1.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 4b94731305b9..6eed14bff742 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -761,7 +761,7 @@ static int __mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
 	size = thresholds->primary ? thresholds->primary->size + 1 : 1;
 
 	/* Allocate memory for new array of thresholds */
-	new = kmalloc(struct_size(new, entries, size), GFP_KERNEL);
+	new = kmalloc(struct_size(new, entries, size), GFP_KERNEL_ACCOUNT);
 	if (!new) {
 		ret = -ENOMEM;
 		goto unlock;
@@ -924,7 +924,7 @@ static int mem_cgroup_oom_register_event(struct mem_cgroup *memcg,
 {
 	struct mem_cgroup_eventfd_list *event;
 
-	event = kmalloc(sizeof(*event),	GFP_KERNEL);
+	event = kmalloc(sizeof(*event),	GFP_KERNEL_ACCOUNT);
 	if (!event)
 		return -ENOMEM;
 
@@ -1087,7 +1087,7 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 
 	CLASS(fd, cfile)(cfd);
 
-	event = kzalloc(sizeof(*event), GFP_KERNEL);
+	event = kzalloc(sizeof(*event), GFP_KERNEL_ACCOUNT);
 	if (!event)
 		return -ENOMEM;
 
@@ -2053,7 +2053,7 @@ struct cftype mem_cgroup_legacy_files[] = {
 	{
 		.name = "cgroup.event_control",		/* XXX: for compat */
 		.write = memcg_write_event_control,
-		.flags = CFTYPE_NO_PREFIX | CFTYPE_WORLD_WRITABLE,
+		.flags = CFTYPE_NO_PREFIX,
 	},
 	{
 		.name = "swappiness",
-- 
2.39.3 (Apple Git-146)


