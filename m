Return-Path: <cgroups+bounces-10151-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3ABB58DA5
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 06:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC6A3BAEC8
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 04:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B382F1FC1;
	Tue, 16 Sep 2025 04:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRPVEEEM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABB92EFDA8
	for <cgroups@vger.kernel.org>; Tue, 16 Sep 2025 04:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998187; cv=none; b=RP3wQBaL1u71pHP7zQHhf75WUtbcwYtbc2rsatHRyLIwbh5EgW+QdkzCoO+9XSa9Xdko/mZJTiSQS+xplXZrttg1NLXJzPxDCVBOn1VYyDSvPp9XpCT/6EUNORxuJvX/R1JA9O5F8boxfogc/XoJRjVmITuXD4uynYl2aiHrZEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998187; c=relaxed/simple;
	bh=xZie7XPvdT38eYIBnvXACDOKlp4uDfFQ6p8xkwCAypA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bS3L4HboduxeOJyS98iFcNyOOjd6eIwQBlb+aMtXvCAPqolbCCUt/bYCn1kGkU2V6/ZJpdr73HEFIJlSj3sYPOouca0mKnQWThiljohKRfntMGqA0AiCC6hJU2p8k/lHXLlJzRxzyQ7pFteTTceaQmrY6U7RC3+dlJ5vshqQH68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRPVEEEM; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-26799bf6a2eso13907425ad.3
        for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 21:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998181; x=1758602981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Tcedso9pzLAwLQitmBj+2+6wC4HZyTUiqHFeMdiOi8=;
        b=VRPVEEEMyPFp1/apdgsdGcdVZa8RyIEDb4oi+MRkYBM99QFUqx8qesncXE5xPiXr4k
         5EmQzzVM6ROAy9MD5JQWOsyeqzNpcJOOfhDFpvyiLSBzgAVmSV4PpvkG7J3oLLXh3T2t
         aSGMxXUkZ/sTwLMVvwCxtrd/98Mzai0cB56bcT2QDXO9wehrl8U9zH9CWY9ycecU5qrW
         lgZghkMXBNPhiPB0dDJ7sUurWKQUnVaHBn61VqMU8sFvJRgf6DYXbUA1UPvggaPVkZ2/
         wEyAhf8NXX+w9nILAVNf9HZ/dItwjE6ImKe5EZYWjDrUvt9j68hAE0JwgxYdvG9auYLy
         KGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998181; x=1758602981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Tcedso9pzLAwLQitmBj+2+6wC4HZyTUiqHFeMdiOi8=;
        b=S4GkAju0QWjGU00NmQkXUlFj23vUrgn4M3f5noBVelXGv9ECsNH2ffG+iPw28Y8RR2
         n3jlhIoibnhEGJz7nhlq4o380HVPwH9eadwVQPToM0H3WMvVDCD/HY5yVarCCEC4QkBh
         AeKY7fzsXxRtYdp/DHJgD09Mxda7m1DD58EHNM66m0WxCGf4oYP5jXhIMCR0D1sFqbeE
         JrgwxxdicEEMn6uBXbOJt1ySk09eDalRW6GIfIhBpksNfxtSuKhj1lwP7gxXNZTyIajg
         N57PMde0yGDl3h0wcD4fJeAqJ1Or6BMNGrrsFRHqqXV4lExQaXhC4J0/Br3VYZN/VH3L
         I8pA==
X-Forwarded-Encrypted: i=1; AJvYcCVTb0cJNuej2RnitdrFgelERVeaoRlPt/LUZkux6JS9u1l26V+z8Qk+Q4RElkYZSupyVKGe8hIH@vger.kernel.org
X-Gm-Message-State: AOJu0YyS6sryZmHi7bI/0cWkFquh4xU9jj8/qqTOcWE+jPSzE632QBTC
	8rbTR7IVIWROrDKqem5OJn9xFl/SpbUtwof9zh5Ff9dr7zfVBDV8QWMG
X-Gm-Gg: ASbGncs5rMpHhDuJJNO34mH20qsc6l62TJ/j2EO7VQwykzLy2dv4LLfIrtaklIJbHO5
	RRpxxz2iM3j/Itz7XcVVvlgYh1vUMGWhdvFkNAbBp/86rBewQ3l/f10+BZSaMnlCcSvn/BvhBqy
	s/Czxd8LdE9ZjODyiTPyyeRw8dEe4lVA+HkPuUn7txS79f5f6jqyOigvmyyVnXj+eRSYvo0iXJx
	nsr7dog7Uv9Trcx+2VxQWJCyxYMftNesTE0txUD+bwbWSBbZgYpDykjk7Au9zEE9Z6uv2pA6uC6
	7JKO98aJ8Q7JdNwk8ntIoDZGx8nJ1NJvk61njRqAbXZS2y0rvUIFDOpEMd8a/76bATb1Efgce27
	6EMwVAE5xYTZbetKBWeEnmiAhlOInAm6uQ8wGkiY=
X-Google-Smtp-Source: AGHT+IEk/DXYOCMhugqpymqTGh+KMlTQeAIuikssxOXlHLYZS5SBPJrXDrKkOxyomJ+DECodEM8EoQ==
X-Received: by 2002:a17:902:c40d:b0:251:a3b3:1580 with SMTP id d9443c01a7336-25d24cac4eemr191581215ad.6.1757998180587;
        Mon, 15 Sep 2025 21:49:40 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:49:40 -0700 (PDT)
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
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 13/14] net: bonding: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:34 +0800
Message-Id: <20250916044735.2316171-14-dolinux.peng@gmail.com>
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

Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 drivers/net/bonding/bond_3ad.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 4edc8e6b6b64..c53ea73f103a 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -2485,7 +2485,6 @@ void bond_3ad_state_machine_handler(struct work_struct *work)
 	 * concurrently due to incoming LACPDU as well.
 	 */
 	spin_lock_bh(&bond->mode_lock);
-	rcu_read_lock();
 
 	/* check if there are any slaves */
 	if (!bond_has_slaves(bond))
@@ -2537,7 +2536,6 @@ void bond_3ad_state_machine_handler(struct work_struct *work)
 			break;
 		}
 	}
-	rcu_read_unlock();
 	spin_unlock_bh(&bond->mode_lock);
 
 	if (update_slave_arr)
-- 
2.34.1


