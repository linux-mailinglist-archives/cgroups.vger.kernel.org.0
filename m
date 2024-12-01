Return-Path: <cgroups+bounces-5720-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A39DB9DF585
	for <lists+cgroups@lfdr.de>; Sun,  1 Dec 2024 13:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97929162BCE
	for <lists+cgroups@lfdr.de>; Sun,  1 Dec 2024 12:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC80B1B3B2E;
	Sun,  1 Dec 2024 12:43:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EE51ABEB4;
	Sun,  1 Dec 2024 12:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733056991; cv=none; b=FXHDxoiFer3NG2vrODkWr5olKTAmmcwm5Gr690QpJrwgIOqoWAeBNNS4xXd1n+8CdW3+CzanV139/OQyrSv3wAGskzddcscV2Yr0rOy+HKfWnCpD0icQcT7X78xT9od6Fq8q1IQmE5a2YrXXXBf9yhwQl6luYNahb6qe2BzCg1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733056991; c=relaxed/simple;
	bh=KfhRzWySzFUYAr+kVqtvBhG315vFirAFcq5NWWBMUY0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W3F5rcAhjiNoET9RZ37k1EiLdYAOGg8/vIs3xnrWKJ8AaGPPto8MXkk5MfLeFnKQtXP5vPejQ8U6UTM5Oc8NbgbTTbc1LoedFIluk1RkmP0W3DGW3zlYt+tF3nbmMoz2Tj48E37c8kieE5dMM9r2AdYVzSlcqrGlNqw9qjsfeAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434a2033562so26853705e9.1;
        Sun, 01 Dec 2024 04:43:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733056988; x=1733661788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDZZ2nuy37BUtFZGESe/BsfLdL68Z5Xtb87JQGkcaNE=;
        b=VPpWaRoS/gllx5a/qf2zviCuCGeZvo/34CbgDKtf7ZevdCXqY8JFRUEjTQM7qkj94U
         fMiPs7ffFNfEuyD5ySHfg5FLT0mR+BLCI21zAFMTjQmvfTXntWOHyOU7JKaUyUAEbcIk
         4N2pBgRfdguOZYKEJfPwKgOa8eSlgfYw8lzss1bSKMKBoCMsZxcG3gXyLqfs3yqo41bl
         lOfhhCdWSn4Wvd0xjUEyfOKD91aiFfvBrT3SAMPDmec+C7/ULeSQqrPofbm0/9BkRzuN
         JXrdNsVrew9pbV282pJCfK3XpaVEgeoLIm1wyO1acK2KEKPh4pRMo0hchdWHyDvea/SD
         aNsw==
X-Forwarded-Encrypted: i=1; AJvYcCUWzqV9l0b4GLJc0qGPDv7fqmcCwQaUBRZT8eXnD698NeD4VTKc6l9TBm6eBBZv7I9LcnljjQ9hVYeJM1Uw@vger.kernel.org, AJvYcCW4Xvjm3HjOkglb470bYn+eQQCxYVA6gIlbasv7yOknMDVrKLxVYxuNB2ZRMPWFVhQS4VI62Qsn@vger.kernel.org
X-Gm-Message-State: AOJu0YxR1w6cTTVZzEnUpW85WDtpiKMTacXNAhcjZ/oAPmHb7G2DevbL
	f0aGbkyxF0UQw38XyWFA65TDdRXRkTicrKIM1xHv0XcImVUOD/QG
X-Gm-Gg: ASbGnctxHiMMqNJ/aROr3OVqUamsCIbKetKbGLhzFe7d5DlGjKQ+x2FkBAXWlkMLJ3m
	aXgnT7Gx+tPymgMi/wcMRdGt9C9sDPhR6AdZ/rrsQEOIXMmO16jODOp7QFpfkbetuC7SDk9+x0Z
	rQpiLDbzRf4yubiGOGBYrn1uZsZWOA7hajJ+vRiEullX03ChNlGbBhL1DIaJnhElPcj4cKhvYgO
	/MUicrxh8H4GfhHhV6xtKRQRTFlZpCar8hd7xV+m7C6ZWkUEjVXl2BfJGIka7myC+8=
X-Google-Smtp-Source: AGHT+IFdXVdGGRVdmQ9j2nUN2ScMyJYwoD58U2MmR/tNNYmP4LdjN8IUbxXv3/RxyRcNLNoTXexpuw==
X-Received: by 2002:a05:600c:458b:b0:434:a924:44e9 with SMTP id 5b1f17b1804b1-434a9dcfedfmr182085565e9.15.1733056988064;
        Sun, 01 Dec 2024 04:43:08 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e280:5300:9068:704e:a31a:c135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f70d91sm114434985e9.39.2024.12.01.04.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 04:43:06 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: longman@redhat.com,
	ming.lei@redhat.com,
	pauld@redhat.com,
	juri.lelli@redhat.com,
	vschneid@redhat.com,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH v4 1/4] cgroup/cpuset: Add HK_TYPE_MANAGED_IRQ to HOUSEKEEPING_FLAGS
Date: Sun,  1 Dec 2024 14:42:41 +0200
Message-ID: <20241201124244.997754-2-costa.shul@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241201124244.997754-1-costa.shul@redhat.com>
References: <20241201124244.997754-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

update_isolation_cpumasks() should also update
housekeeping.cpumasks[HK_TYPE_MANAGED_IRQ]

The patch amends
https://lore.kernel.org/lkml/20240821142312.236970-3-longman@redhat.com/

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 kernel/cgroup/cpuset.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index fb23eee3f18d..570941d782ef 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -90,6 +90,7 @@ static struct list_head remote_children;
 #define HOUSEKEEPING_FLAGS	(BIT(HK_TYPE_TIMER)  | BIT(HK_TYPE_RCU)  |\
 				 BIT(HK_TYPE_SCHED)  | BIT(HK_TYPE_MISC) |\
 				 BIT(HK_TYPE_DOMAIN) | BIT(HK_TYPE_WQ)   |\
+				 BIT(HK_TYPE_MANAGED_IRQ) |\
 				 BIT(HK_TYPE_KTHREAD))
 
 /*
-- 
2.47.0


