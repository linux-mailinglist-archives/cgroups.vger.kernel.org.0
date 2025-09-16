Return-Path: <cgroups+bounces-10152-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C30DB58D85
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 06:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 925D27A8CEF
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 04:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43282F28EC;
	Tue, 16 Sep 2025 04:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JL+Xia8W"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBE7289E07
	for <cgroups@vger.kernel.org>; Tue, 16 Sep 2025 04:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998190; cv=none; b=sTk6kMJWvAzslH/SOBOrAcAHDZHw8+HUsWYVjIVQ92SWE4fJ+ql2jTetz2oiSecL4Loc/lHcQ453EJfeeL6BmrxYzigWS+LTNkGjBPP/FbCIygKVXPLF6V7pn7AzUJ1FbrYEVMsM5Mr4QGywfmimCHSy6+ZveDYH/7f+iXGw0nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998190; c=relaxed/simple;
	bh=slyVnZPzDDOXEcpF4QZOR3I7YB3yd3f7Gxtzb+FU87Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GgBA8tfsbPyJu+OFl77283+dFoEmNxRA6/CxBwN1VEXb60i4kx4Su6wFAcZoZBY5yfxD6q1lotuYaYnbto+3/wiSNsK5pGoX7Wc1jTOXUY+G8G3Up23RER98nntYtImbfjq8drphQO5QFYlUZ+FkvMde/6tswxiRdlowXM8XBhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JL+Xia8W; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-26060bcc5c8so29016665ad.1
        for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 21:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998187; x=1758602987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlYXyo2uZuFo7JhGyy9UUCXJlKeDR2CbpPIjqr5RgpE=;
        b=JL+Xia8W4uyroTDLgoFXQGcvga86g7+1VEKz2roIDSxQwxKuGGI1kJw0E5mRvO2QSO
         m/1WcvkXEpAacTm9jy5S7c5V4Dczrr3meBJOyddNip27HVCCCOgthvtb5FLtkxbvF41s
         iGlUzzPGymDg3T5amMQJm6PDCBR7n+L0ahtyEay0NJYWIu7m2vFg6tr2ajT32yaanfBd
         xDtJu+c4X/3CeTjTCyDCOh+jJ9IMVyUrOd4EWhGGuGTa3TWSp3+no8CtHQqAuwI3rWWA
         BuIdQSsCM/Xgm1YsJeGbAazZkNWV/RcrZ3PBFtpntXLtYH4Vrd8FCoda8o0sXcMxI94o
         +OOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998187; x=1758602987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlYXyo2uZuFo7JhGyy9UUCXJlKeDR2CbpPIjqr5RgpE=;
        b=UaWs6uX8BwWfu1lllHU6+HSj5ROZ9ASpHLXCf4dgyzVTlHBNHSwVqAH65ZuHYUkWF3
         YYN/k0826bhNa8c0aT61KCCng77Sq1rCsu9gpyOILXNjH0CV6QuLgWJRAMoZldmLkSFT
         YqsX0uj5JBx8ouj9AgYv/ePKtTTpU7XyQNif3tjv9MhK2XsOuZBV6Ff6T7QqlbOTXuVs
         WW4JaowN0/gFQPxjUHHBoc7rHe9UqZVWbblTYA8gCE9ygR+oW/2rrMYRAzwJclmotOiT
         Qw4OXE+zSbqjVz5iamqCdd6w0sCKQ6j12GqJWwKun5De4PxTx0HhBiA2V+mvOCbI5fsI
         7lug==
X-Forwarded-Encrypted: i=1; AJvYcCXxJ87JrkYaC401lAoKs7egHVmvpt8DmlL6XUvQLOr1OLswEafhf3QxMLaepF+rCavhTxSs2iPJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyKlIseOmZeg5CbDAwsM8mJce9sUajSCmfyRAwtgqXocZ4/zJ/c
	Ii4e65uMgtxyyh1QzuR0CTlC6JrvhSw/Z5Rrz+RrulhjZDiw180vhNsU
X-Gm-Gg: ASbGncvVF6zzziXe6388VBBF2gfx5p8OWZazFRODvElcOOV3DpgehCIChb4wRwp6yf3
	6zg4pXbJUsmaLkdywSkmjz9Bk1L4IixJvErfyNg1fJFrSdXGliYXIXDWIsqA7rdZxAU8KUHH9c+
	ma8R1nI6XowCLhqATK+eZWfWqqz8+8lxplOyTO2OkckQyPIms/LIF5aKVdNs2soRAa1ohlbgbe6
	vvZuZKn9ejPt3jtKy8zJjntWZ0T3MkS9LpshtvhFAPh86rbHjo3JyBvfNKPU0D4QbHF9qs+KIFs
	olZrs8wdVUecWyYeBxoZd5Iaa/MM2L26Mn9rNf+T2m1FdBQ/1jHsojd5/kbL5aZlOUJKAS/tVvj
	mEIflj3XhRK4G0/vfpKkCf5VkV5ZZfk7jgo9KkKqjjXXC5iGX6w==
X-Google-Smtp-Source: AGHT+IFV4zbzh4iycIfH4WDU92suC0bCanMglT0Ogl2GwpwL8kM68NHrYSygkh1AIkIcAzvJhqwslA==
X-Received: by 2002:a17:903:2f4f:b0:24c:99bd:52bb with SMTP id d9443c01a7336-25d267641camr179941415ad.30.1757998187203;
        Mon, 15 Sep 2025 21:49:47 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:49:46 -0700 (PDT)
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
	"Toke" <toke@toke.dk>,
	Jakub Kicinski <kuba@kernel.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 14/14] wifi: ath9k: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:35 +0800
Message-Id: <20250916044735.2316171-15-dolinux.peng@gmail.com>
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

Cc: "Toke" <toke@toke.dk>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 drivers/net/wireless/ath/ath9k/xmit.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index 0ac9212e42f7..4a0f465aa2fe 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -1993,7 +1993,6 @@ void ath_txq_schedule(struct ath_softc *sc, struct ath_txq *txq)
 
 	ieee80211_txq_schedule_start(hw, txq->mac80211_qnum);
 	spin_lock_bh(&sc->chan_lock);
-	rcu_read_lock();
 
 	if (sc->cur_chan->stopped)
 		goto out;
@@ -2011,7 +2010,6 @@ void ath_txq_schedule(struct ath_softc *sc, struct ath_txq *txq)
 	}
 
 out:
-	rcu_read_unlock();
 	spin_unlock_bh(&sc->chan_lock);
 	ieee80211_txq_schedule_end(hw, txq->mac80211_qnum);
 }
-- 
2.34.1


