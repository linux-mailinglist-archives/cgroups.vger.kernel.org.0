Return-Path: <cgroups+bounces-3017-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A9B8D112E
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 02:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B3A4282068
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 00:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7A6FBEF;
	Tue, 28 May 2024 00:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQC+Y/9t"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460E38F6B;
	Tue, 28 May 2024 00:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716857815; cv=none; b=XECxNl00HlGHjrsvzzYoSchsb1PBW+n8A7H8cNTMXSaSdFmpoGzYyRa0NGJLv241d0g1mX3TCRygj1CVrMnl27Pe/IW+sHKVBxQfoiZHTwFuQ//zBdG+fsqn8ul6ywydXuCcr0Oe3TupiiOIJbj8EeIfN0O78IHp4Cg5bEYSp8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716857815; c=relaxed/simple;
	bh=PvmXeWG0SnCHkNhBbrWqdrOlPRFIU9W0p/d1USU6NiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hzADNJTcvSUa2UtrJ25Z2NyXfc2WaPpPKzCQ33LHb3GG9mC1dECHRUg31j3NzbFX7B4CBn1jA29FwucFs4SNvXFQHDMeoINAQn3lR4Xo1GBADezn1+sp2474cgFvmm5EyYhzzEnjUIK9HnJj8BkLFd+ys0Pi6MlRXtT6E7CRwwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQC+Y/9t; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-627ea4e0becso2772557b3.0;
        Mon, 27 May 2024 17:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716857813; x=1717462613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2i8ZBq63RXzGfHsgGbqgssORCMraFAb6HrAbhKbhoNE=;
        b=mQC+Y/9t4slyyfMRGcpahrhiiqWMRBwRTIRqDUgSmttHxON8w4owtDN8FV8g8r1PyY
         QU2bwNKZy+0PFaV50eHbj4stf7A/CIkjoEiDnoeKkU2Iga1k0DdeVBtH3GrdMC7QFCBu
         +ntJrKZBOySHGflauUkOVwtf12VTnUMSaVQU2qfVQVakT+UC39IeQc3zl8fzEJPaEPhV
         OToa+tDWZQfHNlqRHzxxCOhGrJ/w1kuxwkVpZZq1GqAMwjC6ZnJaC2WAPwRfN5mlQM/P
         oJVXU406VoX+uLP5+CrQWZ7PwhtB7NVPGhGztFh+F6l4lmdvQigWXnf6nfEhEs3OAWq/
         HXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716857813; x=1717462613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2i8ZBq63RXzGfHsgGbqgssORCMraFAb6HrAbhKbhoNE=;
        b=Wh8SC/iPfgkLiWOGgD+kCFFKSA/eb24JEMHrMpq0ggEWuzCNaoV3zcPkQg262r9sQa
         VcmVi+W0tCU1SoiwF+pShy2RjliLyKi31XINQ7cHpvWIl3wB2P2L2fMs6AbbN0lQegZ2
         ra/Olz1DNYPJhMxPq6CH2B8Xegb5PhHQCtfZqAMH/DqhXA2nhTKIcYo105aaD3bDoqyN
         h+Ixqcu80/B8AuNGNv4CmASrlB6qLFBmZVt4SOomHQkmgfGe7XIiGzvZ1iJAuSMRU8n1
         nzxdYAXwgnqEHzSK41OIgxth9iugYrr0kaRljXWGNkZnoiJ4S1cz/oiAz6jvA96xhyZi
         2nNw==
X-Forwarded-Encrypted: i=1; AJvYcCUndcLVEv0xHZywTup8TcO8NwAtD7JZkwlGNtbqAgfXZfgXAYCuIeQUgthN5o+8XrzSQZog47AZVyhDSRz+y1bF2Ttbv0N3EptqwuzziMJejFA5vjb0SocrW77tQ2nKq3lwY7ghHreAZUwBlgui7xJzy1JV6UFNPsC/DZxd9eWgGA==
X-Gm-Message-State: AOJu0YzO4nBflnsAMpyrDB50aQW7b3b4dPwp4pnga28uxoUIVRBMOaQ2
	11/Z2r9j3Syp5s3/3pU3c4gqY9YVEKbD4LIzcyB9CeW9B/Z4HRwTFalDCQ==
X-Google-Smtp-Source: AGHT+IGanwN5puLfVgJdTwaNaX0ZijOyB3yt9T1U0vsxt/p9RAMkPTjCsnwW8VBWu9iPsjNHvtaDqQ==
X-Received: by 2002:a0d:d954:0:b0:61a:999f:e499 with SMTP id 00721157ae682-62a08da8ef8mr105496297b3.22.1716857813196;
        Mon, 27 May 2024 17:56:53 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:35f3:16c3:302:8fdb])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a5345b1sm18328627b3.120.2024.05.27.17.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 17:56:52 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Amit Daniel Kachhap <amit.kachhap@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Christoph Lameter <cl@linux.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Dennis Zhou <dennis@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Zefan Li <lizefan.x@bytedance.com>
Subject: [PATCH 2/6] sched: avoid using ilog2() in sched.h
Date: Mon, 27 May 2024 17:56:44 -0700
Message-Id: <20240528005648.182376-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240528005648.182376-1-yury.norov@gmail.com>
References: <20240528005648.182376-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

<linux/sched.h> indirectly via cpumask.h path includes the ilog2.h header
to calculate ilog2(TASK_REPORT_MAX). The following patches drops sched.h
dependency on cpumask.h, and to have a successful build, the header has
to be included explicitly.

sched.h is a frequently included header, and it's better to keep the
dependency list as small as possible. So, instead of including ilog2.h
for a single BUILD_BUG_ON() check, the same check may be implemented by
taking exponent of the other part of equation.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 61591ac6eab6..98abb07de149 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1604,7 +1604,7 @@ static inline char task_index_to_char(unsigned int state)
 {
 	static const char state_char[] = "RSDTtXZPI";
 
-	BUILD_BUG_ON(1 + ilog2(TASK_REPORT_MAX) != sizeof(state_char) - 1);
+	BUILD_BUG_ON(TASK_REPORT_MAX * 2 != 1 << (sizeof(state_char) - 1));
 
 	return state_char[state];
 }
-- 
2.40.1


