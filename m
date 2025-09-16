Return-Path: <cgroups+bounces-10149-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACF5B58D90
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 06:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E55C03A6D79
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 04:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05942EC55A;
	Tue, 16 Sep 2025 04:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h23e2S6Y"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84492EBBB3
	for <cgroups@vger.kernel.org>; Tue, 16 Sep 2025 04:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998170; cv=none; b=lF6BXmFkEbfWA5G2Gjce0KlgE5FtZaxCcpgocvfxQvFHbp5Tp0B9MA5ekTpfVUqM3+LNo7y3AUa9PJttRW5S2LG6VkB4S9gE9ljAxvMS87fQ0zKqjn7hgvDQ7dDsB7RJvc/rKfh4XxQMuQVlCMGnWh/oahVcZZpuuCBDMjMis0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998170; c=relaxed/simple;
	bh=+qvXPu8HTVeRFaubIyM3rQFPhKws6qzYTh9yka49uSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jx4IcYbfFeGrptGivEa7QgX6h11np9EKMsWcDUHJHHtLX7ONlPQEJb4evIGHIOccN+tLJdNnik4KlOu6RH0QoPrRuxY9XFaMaJ1qcFF21nEo/eCupsEC85BDU4NvTPEGS/wapsmEGZVWqdz3JjwxMqP/QTgI/menjEEGkrJb8lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h23e2S6Y; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b54b301d621so3114767a12.0
        for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 21:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998167; x=1758602967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSw+5V18QQW1zrEulMj1oteRdmYU7Zw4RYS7vag/74M=;
        b=h23e2S6YBhzCpQQF+vf3PMKlnWyaXYUwO6oF/J1csVqE8vMSVBFHJPP2kFyA7mTnw6
         QwnvilGcLAzZwk5dm9UBosQKS6iNp2CfPLVNNazBVsUUUJfAbDLJfrY+mfJQkUvtu3z1
         zWQax3mYP1rICXuSyt9xs3gS4/ZaW0cCGP0shYpcIQA0XBLWLYOdGS2SU+OIMLgtd4+t
         B4N2aRUeDCv7XMX5ZYvbbFkYrMoh8OH7RWXOt/2ZQJzUw1ujVaB2Fx6RTQa2fB9o45cH
         XBGVenMM6TSDsWgpoWOuPERolaNznuaoeMDBjHfKZa46SDncBp6qxbnQ5Typ86pzizmn
         KHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998167; x=1758602967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSw+5V18QQW1zrEulMj1oteRdmYU7Zw4RYS7vag/74M=;
        b=egsEhlxof5YHMPHpp5fnY9ys5uI42QEo0c4+kW8F5hvwGP+Ko/dm3DXsHsbvLC2idl
         BlxLvXmvOjifbpIKRSdV9i4ZPgbDr/e/8pBMNzWGvwnzD1iHr+s2WhVtT9kO/kZ8LVaH
         op5LiT8FlFLmVwbC9rTRDBtYs23yzKKTeqPcdxaTqSBja9PG5nc2Tn81AIQm1L+26sUV
         calz8eKNLTCzWpaR13Kj4xR7XYXkt0vgD+3Lefig9V0/3l/C16YTaUELNRB/o14KTILM
         YMSiDcNnbZ5Er8YpnWbhGP8tWOywHneOz8s+KqCNs1sJhaY6Q9z2lriBvSgIKZqYkxvn
         DD/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEPZlI84ixlFWirKOOzaivJI7jwJjsqJ1z8UR0r5b0ZDUGPGGmgG2t30oF3uBAqQLW3ftuOP1d@vger.kernel.org
X-Gm-Message-State: AOJu0YwktZB1DJz6ecDxf2DkZDUgCLHDcSP/M2Zt7xkl8lkwElEjS6eR
	ELPCF3gyLxg6q36zN30lqrNELjvSEcg+JXIejzGTxZiCqdrJJPh5bXu1
X-Gm-Gg: ASbGnctqK57KoqqDKNaD4AdmzaC0U8ZUiNAowZgoXuEJa2GIhaAs9e2kBot0VCTOIzK
	0uZbeb+f71+KDrEhUjlFMZT+8kzBW+qngDjevEYnyYjLsuAMRplu9UgIxGBLxS66mbZraUKtXVT
	EgmeVl32aVOjvdcPTvT+j1nHHq58JVqhuo6IYG4YlXrI0GsR5VzAV/2GIyMv50jokW1G4Vecj5S
	JTBUeIhEKsXcD6+SnyjWbVCDrmqDs28m1I7mdWttKvzCVV+Ea97V2KYSwWuRpn3t1i0PHr/hgRY
	L/IUvZYrrn9kLwD7cHuc+IXEeqr6JJ/8JKqYprglJRXwFIW5he4w13s9EyYI2hCL62QETjzFqmG
	MORH24IHjCbT5TDNFHXd65KXrNmd6vtlQn0/MqlI=
X-Google-Smtp-Source: AGHT+IFoVKHWE4WmC5NQoAJgz5S3HoMpNrjT8PBpaSw1vdAI3yXeG2nG2SQAkLHZCeabG5ejGwx28A==
X-Received: by 2002:a17:902:ea10:b0:24e:bdfa:112b with SMTP id d9443c01a7336-25d289e9988mr159622635ad.61.1757998167045;
        Mon, 15 Sep 2025 21:49:27 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:49:26 -0700 (PDT)
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
	Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 11/14] net: ncsi: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:32 +0800
Message-Id: <20250916044735.2316171-12-dolinux.peng@gmail.com>
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

Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Cc: Paul Fertser <fercerpav@gmail.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 net/ncsi/ncsi-manage.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 446e4e3b9553..6e36cd64a31e 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -650,7 +650,6 @@ static int set_one_vid(struct ncsi_dev_priv *ndp, struct ncsi_channel *nc,
 
 	spin_lock_irqsave(&nc->lock, flags);
 
-	rcu_read_lock();
 	list_for_each_entry_rcu(vlan, &ndp->vlan_vids, list) {
 		vid = vlan->vid;
 		for (i = 0; i < ncf->n_vids; i++)
@@ -661,7 +660,6 @@ static int set_one_vid(struct ncsi_dev_priv *ndp, struct ncsi_channel *nc,
 		if (vid)
 			break;
 	}
-	rcu_read_unlock();
 
 	if (!vid) {
 		/* No VLAN ID is not set */
-- 
2.34.1


