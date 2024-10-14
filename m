Return-Path: <cgroups+bounces-5108-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3303599BE01
	for <lists+cgroups@lfdr.de>; Mon, 14 Oct 2024 05:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D222B1F2253E
	for <lists+cgroups@lfdr.de>; Mon, 14 Oct 2024 03:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47BF7602D;
	Mon, 14 Oct 2024 03:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdnJnzf7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163511BF2B;
	Mon, 14 Oct 2024 03:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728875493; cv=none; b=n8zyjOIOjmWKOVhPck+VrVs+XvkanXddaLz6E9BGjHrFnrPPd1ZH0AOgYQjdB1OhkynoPo8LxBUDS0WdzESJkJqNoELiRRDxKsl0uHTy9I+tiYeTlCdyFJ2S9Z9MDJubYzf1llKHnRzLz4qQHUnlS16ba27Zrz6uZKaRnCnGgzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728875493; c=relaxed/simple;
	bh=UATzxBpzvyjT4QxUNGjwaJojge+8LbeUNVFkaxtJjgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WDKDVG8z2ULDLKtpnOkMpDTUwe3sPG0gYRI+DoYTY1yxwNlp2RMhlLM/AjYpERsSCSsNZNdqmmV+E8Sh4TvxY1X6UFvCzjth0vPHyoCRb9emIB6JEsUsHaVCdbheDc1sDNkMoR1ua1vfB9z7BNBdKVKd4o5C98Mc36hJB6UDTRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdnJnzf7; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so950772a12.1;
        Sun, 13 Oct 2024 20:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728875491; x=1729480291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTcsvLBt6qYLHkMhyyOrBJnopX+R4q5PsgT0wkU2hcE=;
        b=HdnJnzf7rRuxKNznejClZgRBhmcYN81NCaI7ti8sZhHy7pgcb/iGlH0ChMK35so5WU
         cvxzEaL6Tme/8tbVQg5iBbWF6lRMNy6tRFYILqiLnz0TKWROGANZ5MnbQnhmqlSmwg6Y
         TU3XBpjtWrbthmjiJgPsx9ODSLV+cBS9YF2WcSOErcK5HSk5lgI+L+XaAwUVD/WarySQ
         9qwqygrF0jMp2smm4n/CWHlIYouY8jDITtt0vjkOYg4AdYmXUl7LcM0TN3ith2+CUhYn
         B8Zhm+2PTk9TIc4l+An9ikCIFm3eWNll4z5cxQv9q6U2KYNB5ZlWy2xPScu12y0yBTwv
         H/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728875491; x=1729480291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTcsvLBt6qYLHkMhyyOrBJnopX+R4q5PsgT0wkU2hcE=;
        b=C54EHo7bEVFrvrVjPni8wj1tMK3iCfoYMGeMuxgik6hOQgO43hfkFflWoAqLsPLok2
         OQ4DlIDAn2/gnIkd/RceevW1J6bRr5JwI61SNpfRgueWGsrAEYfqr+8xQRJoysgVmMIE
         X9v7EgSTN3KVW2P8yHKsk6tzMwPilhaRSzxUezeCJnwfY5rpuugU6sXCazuQH9juIr3u
         YE0B9ERYJ0WEMDxq1p6tDMo4kHNXEl7w4iAnPKpy90MzoCUiZu4JQuryt+GRLtHvaebW
         zDtecpK5IfBqwAkmrS2nDEbl8+kr9z9ZUNdBjENY84VpP1HuSG2oZZ4g74BpHWJxJ0oA
         gQRA==
X-Forwarded-Encrypted: i=1; AJvYcCUAAJEGR4HWWJ7NTmUh4BlbAWzMZ620egArzVBbqQxxaMERzB1Rwkfd8edAJeN+5PpW1l9CASRcUuW5Imk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNiUfBRcL5tRTuoXLUmgdzezu3YzXp5Mt0x1p14elPJa95DkDd
	YuaC2O4GXUGzLUVzLo+D8b5HjLKP5m56VHdhB/QupyPepxw2tLFY
X-Google-Smtp-Source: AGHT+IGH33yhUOGKrNZb5vm8e8ExVR/UGC7dmxHYpaQ1ZiquElwKkxXSAqmH9hTHJVtpN/wOcpEImA==
X-Received: by 2002:a05:6a20:db0c:b0:1d3:293d:4c5a with SMTP id adf61e73a8af0-1d8bcf3e6e8mr13900268637.22.1728875491345;
        Sun, 13 Oct 2024 20:11:31 -0700 (PDT)
Received: from localhost.localdomain ([39.144.103.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea6e396a71sm2987514a12.73.2024.10.13.20.11.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Oct 2024 20:11:30 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	hannes@cmpxchg.org,
	surenb@google.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 bpf-next 3/4] sched, psi: Don't account irq time if sched_clock_irqtime is disabled
Date: Mon, 14 Oct 2024 11:10:56 +0800
Message-Id: <20241014031057.8199-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20241014031057.8199-1-laoar.shao@gmail.com>
References: <20241014031057.8199-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sched_clock_irqtime may be disabled due to the clock source. When disabled,
irq_time_read() won't change over time, so there is nothing to account. We
can save iterating the whole hierarchy on every tick and context switch.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 kernel/sched/psi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 020d58967d4e..49d9c75be0c8 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1000,7 +1000,8 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
 	u64 now, irq;
 	s64 delta;
 
-	if (static_branch_likely(&psi_disabled))
+	if (static_branch_likely(&psi_disabled) ||
+	    !static_branch_likely(&sched_clock_irqtime))
 		return;
 
 	if (!curr->pid)
-- 
2.43.5


