Return-Path: <cgroups+bounces-7566-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8E9A8922E
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 04:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2353B2533
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 02:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1B6233148;
	Tue, 15 Apr 2025 02:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RpS6rVR3"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC662327A3
	for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 02:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685267; cv=none; b=hXlwIDiA0C07o03GoWrBZanT2TI8c1RbA8xi1tUr6H1mUAAPBLfHctZfDBqi2HXF9WYq+lx7FYtu8V3xK2RRaeNTRNlqu8m+g9VA0Tvct91DdqwoPczXiatrVtozPNqlGg4i6+gMSn5pWG//l4x+H1MXw1SPlwpM8konNAJF4cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685267; c=relaxed/simple;
	bh=MrXrXjTBYXLdLREsfYrjSTNotRmujCm0BhazHpTsW2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oe2lW5pB0FD/55Ki21B+W3uOcK2sojHhNxxtZz7x4j5RR+k3iFhHVefV+n/uPuzCOMm7yS1kin2OdkeENNrWuBA/HJ6R8JXhvLj9g4x4F3dL7/UELAL1PiNMd3KHsqYXZFGpHzuARuzqzX/vEtaUS25ij/1uVSQtSn1I4eK6M5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RpS6rVR3; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22423adf751so45813855ad.2
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 19:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744685265; x=1745290065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63b5+F5fFo9uNyjbfST0FZ55aigVErZF90xX0QFU4a4=;
        b=RpS6rVR3Kav0RuLYj5Hi8WHnWyG74tKTln+QeVE4hgeO1oZvihhy6UQC3eUTGfhfin
         7Go+fHxQOr+rTpcdDZrwkUzdfDmIfPz0dfeMPEcdaw0EHodfp1VID0DEmlJBJY5DNc8F
         zYz2P+Cea1TCqDwziLNcV3S/eNfuaGBbSxXvoumaIrX+LxyelIUk26/qNyhnkxKwXXLS
         TGTX79vnfEbKKOz+0OL0mZ3VlMqTAbs9crJszuvY3NYuthu8ru3s886AdlCJrIWmVEXg
         WMkJ18nFMSOSQGZX8vHANNX7mCtiHJyddQDQ5cpr77sOBjIWNAJxRTVcgrhnuAQU+H86
         PDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744685265; x=1745290065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63b5+F5fFo9uNyjbfST0FZ55aigVErZF90xX0QFU4a4=;
        b=tyULe5m6p5g4SHT7QTOEdtly9+693jBbmDsCnmq0Xf4IAcYGrTo5gsR4nlifa95lJM
         vpgPnw5ydoO85DGejjC8gSENjmTZ5MkTWex31sqiYS7j382TEuFF0jI6p2Vv+SBMrCVp
         9PuXGbnmg3G0wjX0Qed8heabeQ3yjzKGkRu31D7cHvm/HANHpSNNL5JUIkWooiEheDEh
         sjU8xfRi4QeUaKiv0zlfUR4USwdfgZisRjfX8O6ud2bQLrjLKRzyQ3WIn6yh13c8F2ee
         7L98t7PGx3LU5muvtFZv9znWF18Je9WIJL6s6f2RmkZf1tOm+cqxaJMXsPAdUdZ6/eVY
         8bfw==
X-Forwarded-Encrypted: i=1; AJvYcCWiRFvNrq6JtX53866LHWPp38SfnqiYSl1xTM8jIWjgjKYZlvP/JLTKfyneeUvdLxIflE4Yo3Tp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ld4/xOPNq0SiN6Qq6JmQMuJjl+fy5aVV62ix5iejvvC+CqZA
	wMwXsaoRByQF5YVRnJV+jl30cpa1fVMFuQYg4xpuE176jTB7NkRj/a7xqMxqdLw=
X-Gm-Gg: ASbGncu7XaKm4j4Sti82HkKiOrKi4SfrCAY8AhZVTu1HvdUtR0vbxO4h+KzxuwmxhXz
	nlj1lyRTcg3K8cIJodsl1d9fcL/QCcvBATrvCs+KXpHXEZxXqwh1ueLsXl4rIBNNz1fwmdCB9SD
	nAxiqwXro+INNOPHEbrQBnliFTtIE0+q02CYn1zLPch/9TUs8hwYFona5RufHla6QRa5W+J6hd6
	WXaGzhxjO6Hyurnx8Tcd58CGQCCQLdokVCtDxvwD+cu9tXNvrXrqg9FBp8TkKV3VNdovZRjVc+B
	lbZom3iBChh0TdNKIYgg56N6b5fawksn3gmkmpyvUCZT4VATgcodFLAqE2Uuwzbqq2xTtOJO
X-Google-Smtp-Source: AGHT+IFmIkyy7FOoYDJmjbvJNymfdfM84C+MAEagetSFHxG3fte/Kh1b2EKbddjsXQhUKdg0bAYVCg==
X-Received: by 2002:a17:902:da91:b0:220:f7bb:842 with SMTP id d9443c01a7336-22bea4efafamr182908255ad.42.1744685264764;
        Mon, 14 Apr 2025 19:47:44 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccac49sm106681185ad.217.2025.04.14.19.47.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Apr 2025 19:47:44 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	david@fromorbit.com,
	zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH RFC 20/28] mm: workingset: prevent lruvec release in workingset_refault()
Date: Tue, 15 Apr 2025 10:45:24 +0800
Message-Id: <20250415024532.26632-21-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250415024532.26632-1-songmuchun@bytedance.com>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the near future, a folio will no longer pin its corresponding
memory cgroup. So an lruvec returned by folio_lruvec() could be
released without the rcu read lock or a reference to its memory
cgroup.

In the current patch, the rcu read lock is employed to safeguard
against the release of the lruvec in workingset_refault().

This serves as a preparatory measure for the reparenting of the
LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/workingset.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index e14b9e33f161..ef89d18cb8cf 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -560,11 +560,12 @@ void workingset_refault(struct folio *folio, void *shadow)
 	 * locked to guarantee folio_memcg() stability throughout.
 	 */
 	nr = folio_nr_pages(folio);
+	rcu_read_lock();
 	lruvec = folio_lruvec(folio);
 	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
 
 	if (!workingset_test_recent(shadow, file, &workingset, true))
-		return;
+		goto out;
 
 	folio_set_active(folio);
 	workingset_age_nonresident(lruvec, nr);
@@ -580,6 +581,8 @@ void workingset_refault(struct folio *folio, void *shadow)
 		lru_note_cost_refault(folio);
 		mod_lruvec_state(lruvec, WORKINGSET_RESTORE_BASE + file, nr);
 	}
+out:
+	rcu_read_unlock();
 }
 
 /**
-- 
2.20.1


