Return-Path: <cgroups+bounces-10139-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4455CB58D23
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 06:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C33A1892BB5
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 04:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5132B2D4806;
	Tue, 16 Sep 2025 04:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgiTKs98"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79E72C235B
	for <cgroups@vger.kernel.org>; Tue, 16 Sep 2025 04:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998104; cv=none; b=mTwLP03Yr1r9lXiNi6/caIeIH1bvBN+W/tJ7xEzURmODwxVOtNrBRYsrYr8VZTNW4uol8KsqX7265Ad6bOAwrw4p54lfNBRwNKyiLSymwErpRrjYsRa7mT/YVNB2LpKP8plBzdwvmmt0gohFRmW193iwZ2bJK7hJFfrEZVuLOmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998104; c=relaxed/simple;
	bh=psJk8MWkw4yWUzhoGl6iC+/oKrIajPgKeNxYtGpbGJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ph27U6nSo/E/fSMmLjOgT6bbcv0mvTBWa9cQKW/brKJR0BEmmxfUCXX2k7aD+/98JpYJRSDpEIt04Zdavt0jSfVvkV47pZqE2omCM7D5tyyxi+NClEYCO8u/3ojC8frSKLYvlaReh4bLx5jGw7u8lfJChazE9NuxOnxoMzG2nhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgiTKs98; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24456ce0b96so56441455ad.0
        for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 21:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998101; x=1758602901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOaEQ/7pID9TluLY7/w8zgk+8Z8ChedlXZfnOV6tq/0=;
        b=UgiTKs98TYt0zah/UeSi4De4R5qcPuP9nE+oBFiDNrhtI0JRukYpwBGkrD1qMj8YZJ
         zxAPGGH9qL2hIdPkF9Ps9Xnd7Jvxf/ZVlkbnd47UidqnLrPiaPttc/PPgcfGNO4KSZFH
         MII8pjx2Ab32A8kOPiHi/IVq0+PdVSk9AH6nKylqP4ciHrUFZteDTLfbAAMcPsfOW9/9
         SxBLWNNbByPGH2KJGO4I8tQi++oIv91NAcecNWvFFImMV/zfHb4u5kUEiUYwITx8m6l+
         PbhcI71UPtGbN3T10jjL7ELy4EIjkaG/PtU6I9mrth/K43lLg7JX0O8z0A9pbbonH3JS
         zeIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998101; x=1758602901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOaEQ/7pID9TluLY7/w8zgk+8Z8ChedlXZfnOV6tq/0=;
        b=Shm5MBK0D+rT1zTF5VqVcxj1yCr55hRa6ZWXM5ZYgxhPJ1GzwV8tURCSppdl4ZyiVb
         pGoC8dKgpFyg0KJn5Av56yrWa7jHKdTxRo20Pv+pwfzD8Zn4Qyw5/3Nnt0/pagXbqP+D
         XWOf23wfz/fABQsnEOEjrjXzzoIvgqQExrwD9M9OXdSP3FikcVuuA3SnxmUiejusG+2s
         4UOtko4oYynWP5xjOht0lKrkzhiA9wuztCw6uY1hsjG6XMqixdBQTyU2oj9Oq/OPyxtp
         YVHbt9SoBw8gRgBQLDWANCc/gJiwbwUVYcTAyq6371vJFNEzDbL2UNf83BkZfEZZzi84
         MdGw==
X-Forwarded-Encrypted: i=1; AJvYcCWItLJ6s64hEI9h6PaWiKqfLQL2DEzhoZIP04iCHni9xZax6VhzaXKlEmtut/LzF/rkMkGrQbKz@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy0apnn4nnswdFFZppQMGivYDm4jxd1q2l17vS9bZGd1bjn/Fk
	YF4CeOFd2qHJ+3wp0xTMU1JJQFmTG6vn1+GouELfziAQHwJmNOq4Sn62
X-Gm-Gg: ASbGnctzQIpIXHTKqB2h1gz+ndrxN4fWN1QY54hE2lI20ANh6PhNxov6zWw5tXM1jHK
	/xMqG2VqP1baKXfrJaYEmFW2cBxLlJSz3CjlcMoMhMx37Fv61Qd55Vd3rFPOJEhYYAreO66e7w/
	dWb3pIYPmkafCZOg1yb7wyi+c79is+4h+ckwC5Uovg03iBbfrtKQZJLMmpURstA7tXfaBPe5GDZ
	AK84IX5EtRX2H/5/WsxpFELdq08Xr6thS93wCBWkkVMAT0ztGvQF9TXSxAlvl0RmSU6CSAFE5JT
	j3vCTq9QqY+xeyqOvAVGHzEBRdSDEEsmTCR8jCokgaAq9JVyokkhw7w0wNCEYWlCOCfu5Ps5lS/
	JlNqD2K2thdRkiIs+3MD7nafxB4UzGlWN7fll6Hc=
X-Google-Smtp-Source: AGHT+IFncLMpEiSXyRV3g2udd9oLTip5CIZ6fjiDS7nm0eY3IrUPzgwzagMuf9PJuGmIj5O4nns0xw==
X-Received: by 2002:a17:903:2f87:b0:249:71f5:4e5a with SMTP id d9443c01a7336-267d161e3b9mr10726455ad.26.1757998100825;
        Mon, 15 Sep 2025 21:48:20 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:48:20 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: tj@kernel.org,
	tony.luck@intel.com,
	jani.nikula@linux.intel.com,
	ap420073@gmail.com,
	jv@jvosburgh.net,
	freude@linux.ibm.com,
	bcrl@kvack.org,
	trondmy@kernel.org,
	longman@redhat.com,
	kees@kernel.org
Cc: bigeasy@linutronix.de,
	hdanton@sina.com,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 01/14] ACPI: APEI: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:22 +0800
Message-Id: <20250916044735.2316171-2-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
rcu_read_lock_sched() in terms of RCU read section and the relevant grace
period. That means that spin_lock(), which implies rcu_read_lock_sched(),
also implies rcu_read_lock().

There is no need no explicitly start a RCU read section if one has already
been started implicitly by spin_lock().

Simplify the code and remove the inner rcu_read_lock() invocation.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 drivers/acpi/apei/ghes.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index a0d54993edb3..97ee19f2cae0 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1207,12 +1207,10 @@ static int ghes_notify_hed(struct notifier_block *this, unsigned long event,
 	int ret = NOTIFY_DONE;
 
 	spin_lock_irqsave(&ghes_notify_lock_irq, flags);
-	rcu_read_lock();
 	list_for_each_entry_rcu(ghes, &ghes_hed, list) {
 		if (!ghes_proc(ghes))
 			ret = NOTIFY_OK;
 	}
-	rcu_read_unlock();
 	spin_unlock_irqrestore(&ghes_notify_lock_irq, flags);
 
 	return ret;
-- 
2.34.1


