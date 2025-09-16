Return-Path: <cgroups+bounces-10141-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A13A3B58D2B
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 06:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B527132232D
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 04:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58FE2673B7;
	Tue, 16 Sep 2025 04:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldcgaDct"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975992DCF4E
	for <cgroups@vger.kernel.org>; Tue, 16 Sep 2025 04:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998116; cv=none; b=Mpo8yKM0mxiIRzpi0HZx5B/Dw7E4Ll0LxWs6VeqNp1GXi1n1m+6Fj8foY57r1+BE5jjqHHejS6MpK3fEi4cV0gGvq4uEqhSjptMkQpeXzENCzIvdx9B4cr/vjA9yujwmngYkpiBp7w2rHSVIDF5RgUD/6O9MMP0OR4avf2zyZCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998116; c=relaxed/simple;
	bh=ivk1kCPJFe/BzZPF72WSq3DpdkZ7hkdmk3r9ydq31tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nbiyj+BOIgQOEFJb0qEBi53kH82qjw6ja+Te3d8mxJQMWwVSJek0MmC7X4Y8gIeb+XU5dtD2+zd/b7wa5LAMxyLx1XOVThGD7HlE45XHxCGXP/yh/y8AXfnXosH6eA9KTSvNVVYEy3Sv367PCqOHXuuZBtShTULuqF8QjMHjJYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldcgaDct; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b54b55c6eabso2939306a12.2
        for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 21:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998114; x=1758602914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lT9DsPVy8x0mlOTAyxJueu7zb5O+t3UCUBl9ED2OMzE=;
        b=ldcgaDctXOfgSLf64W5XTkXL3DEk6cNTh/hZtEwwAoIMEXJ7nBBWetX01vNPBw3b9W
         jZDo/ihzinvGc71TxgSzbCWg1MkINwXVj+isFkr0JB682qWP40CLk9GcO4jjh8/pDWu7
         KuRU9hXBGyaKtbD3e/8dqL4Vb9A8A1Cl1Ci87LIjq6sFmpY+k+tnzg67+pGgYhPjGDUQ
         ++nwCK/Qi6G1Yem5BVlYpjZZKxqRdvGMMs6FpSW/SQlCGwMbnWL0p7yJ4CdB+XR1KlBY
         zgLgJHEOAdHxuTL+O/NFH4O8mWv/mnq4ZzNT2O8rhaM3p0qyK/3C9A2C2JE/av0S2fQt
         IGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998114; x=1758602914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lT9DsPVy8x0mlOTAyxJueu7zb5O+t3UCUBl9ED2OMzE=;
        b=WhZf13oA1z0i3HnDYnE8us16HnmuTOMiB2kllB3ij8yiMaGeU7F1oHIlXftDtmI/sU
         r7uDvxRmz+rqIpJWBmNMK66jKOPeMeHRJoeBGeUZm70+HRQuAGuDchbYFqEXQqFNAU7Z
         QNCJpDARxX11uEuAZYHqH8aU1W7T6ahaCZ3pFhPvZJ5L1fFkapveKao4AQpAEP0rxuty
         xW20ERZ8VBKhWqcjUVQ3JMgqtmSyCMddlc3o9/JVCOEHMH2/5o1ZrZVPlgC20Nu5I2w8
         StEEPNKPCYkNVOiK3EycK7xUAU8lKIOlA4FmC6GJKCNqm33l3K1jKTWGZ17kPdZ98iQp
         DahQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGnVa1B61edB5Gg00XUjjN7CW4MMtpzm34sQOPpdbEy3Zny7gINTZowXtrpkLmpJPyLaM9U7A8@vger.kernel.org
X-Gm-Message-State: AOJu0YxIN7+1V5/r0SseHfzN6TYGdwxE/5BvRIwVqTE3a1KD3hf8fzb4
	NWlkjNSq4OEpooEqMmzvf0xwvNK1sIh/toVQ6tztaQBkWvQ6SvDvhkUB
X-Gm-Gg: ASbGncsqDK4yhC23f0/P2oqKKVBzdN/TkG8SIFEki1bY96RbxEgzaQug/BaeJ5822Fi
	cIlkNpQuZGXUleJIK+g5cdpAA/plj1p5IOScJvqA/FAN58VjsrXQ0l6eXKZr3kDgtawnnz/Q/Ih
	IgQoRO3A8wm5lwaNIsOLOfgN/DPJW0Ac8wMLNkrXzTaL/k6fcPkMWopeCqieQlWj8lwLA3JyYH/
	54Sutj3Hwt9ncW7jULy6kzVHNrx5oHfuiARXjSAfMzI3QaWWJ/4+n3kNwt6aDlpXSRTTFGx/YYy
	QKwg6FG7d4kSasqXdD/hJ60FteaDCDIqkyVML6jMpacZLpq4irdpzbCGK64YzmhE+ZKtACL9HTF
	bboFHbqX/fSYpYhRPF14VFxlnYe6LKOgPRrazbro=
X-Google-Smtp-Source: AGHT+IF+n/WS6RKuYlQuLpfTYPIbA2M/p4imTXrTMvTksxJg/G6gJFeTxjjE/2igpzRcFyrC5Ibdeg==
X-Received: by 2002:a17:903:3585:b0:24c:ca55:6d90 with SMTP id d9443c01a7336-25d2771f4admr137080665ad.61.1757998113981;
        Mon, 15 Sep 2025 21:48:33 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:48:33 -0700 (PDT)
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
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 03/14] fs: aio: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:24 +0800
Message-Id: <20250916044735.2316171-4-dolinux.peng@gmail.com>
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

Cc: Benjamin LaHaise <bcrl@kvack.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 fs/aio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 7fc7b6221312..e3f9a5a391b5 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -359,15 +359,14 @@ static int aio_ring_mremap(struct vm_area_struct *vma)
 	int i, res = -EINVAL;
 
 	spin_lock(&mm->ioctx_lock);
-	rcu_read_lock();
-	table = rcu_dereference(mm->ioctx_table);
+	table = rcu_dereference_check(mm->ioctx_table, lockdep_is_held(&mm->ioctx_lock));
 	if (!table)
 		goto out_unlock;
 
 	for (i = 0; i < table->nr; i++) {
 		struct kioctx *ctx;
 
-		ctx = rcu_dereference(table->table[i]);
+		ctx = rcu_dereference_check(table->table[i], lockdep_is_held(&mm->ioctx_lock));
 		if (ctx && ctx->aio_ring_file == file) {
 			if (!atomic_read(&ctx->dead)) {
 				ctx->user_id = ctx->mmap_base = vma->vm_start;
@@ -378,7 +377,6 @@ static int aio_ring_mremap(struct vm_area_struct *vma)
 	}
 
 out_unlock:
-	rcu_read_unlock();
 	spin_unlock(&mm->ioctx_lock);
 	return res;
 }
-- 
2.34.1


