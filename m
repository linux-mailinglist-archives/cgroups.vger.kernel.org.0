Return-Path: <cgroups+bounces-9291-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A63BB2DAC2
	for <lists+cgroups@lfdr.de>; Wed, 20 Aug 2025 13:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A30C7B7C7E
	for <lists+cgroups@lfdr.de>; Wed, 20 Aug 2025 11:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72352E425A;
	Wed, 20 Aug 2025 11:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="j04Lu8UV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A88F18CC13
	for <cgroups@vger.kernel.org>; Wed, 20 Aug 2025 11:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755688793; cv=none; b=Wzvm6p6WAHXWM+RM7aNQ9BZ1KtNYg1hiMUuToH/1KxHngv+eSRiaWOG7onSR5qJ/Dn+xULYX2zc/YcI1Je+KBIWcMyOdUl7V93xSY3Krv6FlE7xmcPvdYFqbRuY2LbmYyDAlcUIRMnA0EVtxH3d68z1g9NQr3XDW53muHU9YoGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755688793; c=relaxed/simple;
	bh=I8eEAlb8CZTOJDVpTC1DVhT7/pwV/0gX3Eqm6Eus7eA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oHyzxq9Iv739D5stDRBWblvhEJknKhPofrrAaSgDEKLd2Llb09FkV6+2PUIucYBmoFih0e6HNkPPXd0FHwL2eu41g62BI/VJqAgbJgH2XtJuGYBVc/YPGxJEnK1+sR1Rsiu2MRoD9RhY01z3vnlqmfiANaCp/TG8S7MLdDHTDxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=j04Lu8UV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24457fe9704so48968045ad.0
        for <cgroups@vger.kernel.org>; Wed, 20 Aug 2025 04:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755688792; x=1756293592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etfq7Z3ynN+Xhnf5fpj8hv4AyY95nd/Rrih5Sc1jrvk=;
        b=j04Lu8UVG+LUKzT5l0MrLTwVYMnfjKmJHs8TJXwi6bW9+z3LCH+l11amJC9r15jBKJ
         UPb9NVac8Mk215EnHi81lUhoRlfo/w/boF2gJTqM9OV6NWSj6mrAHtiRyEMuog90fm7H
         GfNfqrCBmJnkRHpmj0+sgkZtDvV/9S2M7zYwJZYDvwJAdTMjBoR0G1VdNPK3Ih7JJoyU
         KPG6dTEB8U9/dqce6j9w1hq0fQB105+c49vPmEVx1+8m+6UsSkYUhmAGOdSKYdwE+dx8
         hStS0GYxmWMOxg8mj46gIn5YGF9X8yQ+IAiXMyW80nP2iw3Gs4NPbmC5+QlzPi17Q+Vc
         zpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755688792; x=1756293592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etfq7Z3ynN+Xhnf5fpj8hv4AyY95nd/Rrih5Sc1jrvk=;
        b=KSmgaFttA+D/Lc6Dmy7G6rp+4ZyJQWGvlFbbQ1NEEtx+tnVEYO/utEoDJqqb+Wh+3w
         3guesqpB4GtI49/ZpOgKPUR7qcmprXpczKLcGA4S1JSi4296fYCChKm24G0hGOsUHSGx
         DvRxGu+bp2M+drcVgW9Ld2cKAK9f9gRZyWkttkTpHCF+w403TkXt4vgK23qbMbP7lrfX
         g7r5N75iOOMtQz8FyhA9yuiKj7K2t6hnKvhXAQcIb90JA4sm5R9lKkaoBn+uNpA/Kh4a
         zOmfDlWpfBXiH0bFxiQ/fbFfXoEHawmLNFTZTM5N+zLWhDZkoWWDm7dRJ62KIfMC2A3G
         NAQw==
X-Forwarded-Encrypted: i=1; AJvYcCUknyeGCN2E2Utp3zfZqpI7BP1Qc6Mbnvrv2DbPsGphuoYa9L6wYPlI1nFldiD49FomuIF8F1k9@vger.kernel.org
X-Gm-Message-State: AOJu0YzaA9A7Of6zgDg8AAlkQwUyPOtdxHOfYeIwBgbqo2Ai0OE6wzYc
	QF4algbfkJdC3E0n24nzZ+hjTsOWWPcv//I0VljM+lJUXgRbsds+O4xvzxt+Btj/P1o=
X-Gm-Gg: ASbGncsJawl+YDyNHXN4Xr0Iml+PROmpMoB2FHr6Fa/22zbiQuyV7R+TTv+aDbheZvi
	zTNzB1MGFPFIq7unDs3iFI3MsDZHcl5h0qlzNGVJUWlbxIW3Z+bFrf9rFMr8I4aG4jVOg//4uEW
	dK5KGW+R+o0/3B77ncZaz1YfsOW8QXz+Dxnl0FGxnTtlnR52qe2I8WM+CQJQLJBHuELgAShbpeb
	8oczimft+XJouyRQ3gKKyLY/+NJSKuWX9FIhAFzXnDPGsYVA0NCfdZyTowIphFi76rqkACt9gKt
	OdSRTPgIl+8VEb2YTs72GYipZcFz35YoIIu8WWZc2JOhknOjpa+UPN1DMdIC/1ijy6eN2Li6/Sy
	0eso0JLQL2Wa+jgWjzmBvElqbiyLGcLE=
X-Google-Smtp-Source: AGHT+IF9yMAQzAeu7oFSZbN1hEkzdOyEwI7/xKUKHr1JqovbQHv/4TBbJdLBUdslaIF5hPaYBQQ47w==
X-Received: by 2002:a17:902:f70e:b0:245:f1ea:2a4f with SMTP id d9443c01a7336-245f1ea2d96mr20929305ad.37.1755688791478;
        Wed, 20 Aug 2025 04:19:51 -0700 (PDT)
Received: from localhost ([106.38.226.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324e7fcff9bsm671051a91.23.2025.08.20.04.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:19:51 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	axboe@kernel.dk,
	tj@kernel.org
Subject: [PATCH] writeback: Add wb_writeback_work->free_done
Date: Wed, 20 Aug 2025 19:19:39 +0800
Message-Id: <20250820111940.4105766-3-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250820111940.4105766-1-sunjunchao@bytedance.com>
References: <20250820111940.4105766-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add wb_writeback_work->free_done, which is used to free the
wb_completion variable when the reference count becomes zero.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 fs/fs-writeback.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 4a6c22df5649..56faf5c3d064 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -49,6 +49,7 @@ struct wb_writeback_work {
 	unsigned int for_background:1;
 	unsigned int for_sync:1;	/* sync(2) WB_SYNC_ALL writeback */
 	unsigned int free_work:1;	/* free work on completion */
+	unsigned int free_done:1;	/* free wb_completion on completion */
 	enum wb_reason reason;		/* why was writeback initiated? */
 
 	struct list_head list;		/* pending work list */
@@ -169,15 +170,19 @@ static void wb_wakeup_delayed(struct bdi_writeback *wb)
 static void finish_writeback_work(struct wb_writeback_work *work)
 {
 	struct wb_completion *done = work->done;
+	bool free_done = work->free_done;
 
 	if (work->free_work)
 		kfree(work);
 	if (done) {
 		wait_queue_head_t *waitq = done->waitq;
 
-		/* @done can't be accessed after the following dec */
-		if (atomic_dec_and_test(&done->cnt))
+		/* @done can't be accessed after the following dec unless free_done is true */
+		if (atomic_dec_and_test(&done->cnt)) {
 			wake_up_all(waitq);
+			if (free_done)
+				kfree(done);
+		}
 	}
 }
 
-- 
2.20.1


