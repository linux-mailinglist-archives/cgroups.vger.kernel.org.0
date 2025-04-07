Return-Path: <cgroups+bounces-7411-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C6CA7F153
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 01:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A62A17A45E
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 23:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB46C254AFC;
	Mon,  7 Apr 2025 23:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGqKT58k"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C3A22DF8C;
	Mon,  7 Apr 2025 23:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744069353; cv=none; b=ALKGEPxhjaUMFzx40IdzuN7PGUD//8mXxjW9kZOVRsHaOCtXnvAP1HHoTRyPYHlOfgtQxcWKq4A/LKuFVCsrvILrgMUDl+DxSCHqgh94dsOPH+PHv0PrtSKcI7Hf3LYrxBYYq2CjebOlX6Zsc1LQA8X/ssBwcp4tws3e8BQCb5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744069353; c=relaxed/simple;
	bh=+tImoJN8LOAx3XNgUjBTI+HCxDl7uh4xChIEILnZeQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErUl5AQZlQzFb+edws/+TsYWj9B9l//Yb8yXfORgd1xoAvfRkhbO6CLgwutPbVPwybRKaHBWrRGIH1PfLKwgtkDKXwz6JvVSDp5yXOM73nl0fQV1aq92LyN/huYOdjl+kjBA6m0Ol531kZc2HWjaaSajloLSenGcoiHFod2lzBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGqKT58k; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e6e09fb66c7so4061734276.2;
        Mon, 07 Apr 2025 16:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744069350; x=1744674150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEmnwad/N64NAZz/aFOTPsiQL1svvHVYAYQ6CpUFW0k=;
        b=NGqKT58kxfwB302Zuac9qrJek5JadKsV6bAGOEEucvVc1gWkBtflBG2Ui5gzgxHPYS
         FuQn14P/LrMHPgqhcxr51430K7XWnSy38C1LisCbs1sumhSJajcedwGvAKME6M6P6Wh/
         OSiktrfYv654o/ZY5hJ+FzxZc5IHeL1ImmnBhVEOXu6eDAvCK23rB/Ftdyu4ZLRb7Gsc
         4s392D0FDpASSLRoZagRalqGAEFzMh/sLertVdTCAInIVpLxCRKMjyWUfhdImKfOnxNN
         f8G9hsw/gEOay04QYgEuVEDJczJ5qBz9V752WQoMrqzzzuA6CLe+LeocAyKFKXYjAdf/
         VS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744069350; x=1744674150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEmnwad/N64NAZz/aFOTPsiQL1svvHVYAYQ6CpUFW0k=;
        b=SwUrPt10LxTAHPVBz4fe0J45AfnTh/zvFMm/bX93SRY4W9D25Yh1PxdsOWSrOWbQ2B
         zYMTg8UV3nUYPOXKUr9M2PWgRUNPJAWTWlakEYfhCJ9Hi8KN2pnQExHvbXrAvpvoWPH2
         EMhd04KbOlkBj1DdqUkV+w7MSx41hcexPNJ/MUU4HSAPImPzjY3bQ77cTT5Bs9+FmL2v
         hALG0NDYPfzCHQMQrHYQ6VQJeWeLCGvQlbOeMfhrrTAIVX/eDNZIC7icXfkGbIYq5VKR
         swUxjXEczaS9aQ5e0C0Mo8EHdZ9iYkAZ7k3F9XQdmrLKapUntik0mA73aBM4+fA6H1r+
         Wxug==
X-Forwarded-Encrypted: i=1; AJvYcCUpqFGx5iPsLWVJ0Q2c59DjN5GODK0Ad3V0ambaXLTJuc7ENgA61M0S39O+qf6ZBjWb6sqVk6mA@vger.kernel.org, AJvYcCVLS/R5c116GuE9OmiGDZAGsO8AspSazTIbsPT+z/dieyycaBbPuxY55iCxlGxNFr0LSnevbF/ZinWdXy3b@vger.kernel.org, AJvYcCW9JrDrkKWVDB2wII2qdxZZwB6Y3SUkKv7fn+ba3Zh/AWj9B4WhzDRmUgBQ/LUJwCpMMEEKFyKTvCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4hXkzUf44aUfE0QXDJjuPUeYIjxSGPNrTkli9WMa5s5gU54uR
	0dZxBbI4GqyWfAxCecRx2cmRqkjaiP/gnZ5sV0LRdmlfbjnjdVV1
X-Gm-Gg: ASbGncuC8HGhU11gruqU1+1boIbdD69yRGEX7u2SwvUmKKpmMig6aY05hSmr0OUOpmt
	Vy/UIRjLiptnpAluTiBRjq5pk4P4KOFjAsKy+Z7trj2NXP140izyQFMqnQudRh3C1xsbkukDWpH
	lx/Uu2s6SLVkeNZEFGkAgViTCXG5Hghx9WuGzwozCoRXoAIIyXdbgS60VIO8VTqcBo7Gbyl1763
	EePYnxq2hncPovi09eN+un2lwN7+4Zzm3jiz3MRI46RpqDaS0/h0BsVUHUZl6bkB+Dn/xX1PF9M
	mDMLjp4Ou074QoR6nvsdSXCxwrySe3RrM4Tqi4z/xCUEn5U=
X-Google-Smtp-Source: AGHT+IFtGhkxbSoAukRbj+0OU4tWjwIUdMbR+YxJ19NpEyyOkHcigzH97IKjBGD1dt64XVgLyZVotw==
X-Received: by 2002:a05:690c:670e:b0:6f9:4bb6:eb4e with SMTP id 00721157ae682-703e1623ab2mr255941227b3.31.1744069350152;
        Mon, 07 Apr 2025 16:42:30 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:73::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-703d1fdf9ebsm27726707b3.123.2025.04.07.16.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 16:42:29 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	hughd@google.com,
	yosry.ahmed@linux.dev,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	len.brown@intel.com,
	chengming.zhou@linux.dev,
	kasong@tencent.com,
	chrisl@kernel.org,
	huang.ying.caritas@gmail.com,
	ryan.roberts@arm.com,
	viro@zeniv.linux.org.uk,
	baohua@kernel.org,
	osalvador@suse.de,
	lorenzo.stoakes@oracle.com,
	christophe.leroy@csgroup.eu,
	pavel@kernel.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [RFC PATCH 09/14] swap: implement locking out swapoff using virtual swap slot
Date: Mon,  7 Apr 2025 16:42:10 -0700
Message-ID: <20250407234223.1059191-10-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250407234223.1059191-1-nphamcs@gmail.com>
References: <20250407234223.1059191-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the old design, we obtain a reference to the swap device to maintain
the validity of the device's metadata struct (i.e swap_info_struct), as
well as the swap entry itself, before various operations.

In the new virtual swap space design, however, this is no longer
necessary - we can simply acquire a reference to the virtual swap slot
itself to ensure it remains valid.

Furthermore, once we decouple virtual swap slots from their backing,
obtaining a reference to the backing swap device itself is not
sufficient or even possible anyway, as the backing of a virtual swap
slot can change under it.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap.h | 24 +++++++++++++++++++++++-
 mm/vswap.c           | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 1d8679bd57f3..7f6200f1db33 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -730,11 +730,33 @@ int vswap_init(void);
 void vswap_exit(void);
 swp_slot_t swp_entry_to_swp_slot(swp_entry_t entry);
 swp_entry_t swp_slot_to_swp_entry(swp_slot_t slot);
+bool vswap_tryget(swp_entry_t entry);
+void vswap_put(swp_entry_t entry);
 bool folio_swapped(struct folio *folio);
 bool vswap_swapcache_only(swp_entry_t entry, int nr);
 int non_swapcache_batch(swp_entry_t entry, int nr);
 bool swap_free_nr_any_cache_only(swp_entry_t entry, int nr);
 void put_swap_folio(struct folio *folio, swp_entry_t entry);
+
+static inline bool trylock_swapoff(swp_entry_t entry,
+				struct swap_info_struct **si)
+{
+	if (!vswap_tryget(entry))
+		return false;
+
+	/*
+	 * No need to hold a reference to the swap device. The virtual swap slot pins
+	 * the physical swap slot, which in turns pin the swap device.
+	 */
+	*si = swap_slot_swap_info(swp_entry_to_swp_slot(entry));
+	return true;
+}
+
+static inline void unlock_swapoff(swp_entry_t entry,
+				struct swap_info_struct *si)
+{
+	vswap_put(entry);
+}
 #else
 static inline int vswap_init(void)
 {
@@ -773,7 +795,6 @@ static inline void put_swap_folio(struct folio *folio, swp_entry_t entry)
 {
 	swap_slot_put_folio(swp_entry_to_swp_slot(entry), folio);
 }
-#endif
 
 static inline bool trylock_swapoff(swp_entry_t entry,
 				struct swap_info_struct **si)
@@ -789,6 +810,7 @@ static inline void unlock_swapoff(swp_entry_t entry,
 {
 	swap_slot_put_swap_info(si);
 }
+#endif
 
 #if defined(CONFIG_SWAP) && !defined(CONFIG_VIRTUAL_SWAP)
 int add_swap_count_continuation(swp_entry_t, gfp_t);
diff --git a/mm/vswap.c b/mm/vswap.c
index 1b8cf894390c..8a518ebd20e4 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -425,6 +425,42 @@ swp_entry_t swp_slot_to_swp_entry(swp_slot_t slot)
 	return ret;
 }
 
+/**
+ * vswap_tryget - try to obtain an ephemeral reference to a virtual swap slot.
+ *
+ * @entry: the virtual swap slot.
+ *
+ * Return: true if the reference was obtained.
+ */
+bool vswap_tryget(swp_entry_t entry)
+{
+	struct swp_desc *desc;
+	bool ret;
+
+	rcu_read_lock();
+	desc = xa_load(&vswap_map, entry.val);
+	if (!desc) {
+		rcu_read_unlock();
+		return false;
+	}
+
+	ret = kref_get_unless_zero(&desc->refcnt);
+	rcu_read_unlock();
+	return ret;
+}
+
+/**
+ * vswap_put - release an ephemeral reference to the virtual swap slot.
+ *
+ * @entry: the virtual swap slot.
+ */
+void vswap_put(swp_entry_t entry)
+{
+	struct swp_desc *desc = xa_load(&vswap_map, entry.val);
+
+	kref_put(&desc->refcnt, vswap_ref_release);
+}
+
 /**
  * swap_free_nr_any_cache_only - decrease the swap count of nr contiguous swap
  *                               entries by 1 (when the swap entries are removed
-- 
2.47.1


