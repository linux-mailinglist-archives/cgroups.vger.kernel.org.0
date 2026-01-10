Return-Path: <cgroups+bounces-13028-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C16CD0D0B3
	for <lists+cgroups@lfdr.de>; Sat, 10 Jan 2026 07:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D4E73024D49
	for <lists+cgroups@lfdr.de>; Sat, 10 Jan 2026 06:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0968311592;
	Sat, 10 Jan 2026 06:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMQ6UoW5"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAC022097
	for <cgroups@vger.kernel.org>; Sat, 10 Jan 2026 06:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768027583; cv=none; b=GuqTtNloVtJhMIJPh1JFX+6UwEWTk0lBaGzvIXUR0UHf+nM+X7E2hJ8erwrA+qAZY+X4Mw4FUpf+8XyTG7wW+asl6eUsn7ZKM65fz+3Cqr5rGLxH9A/Uxfkc8P79WLqWYrsqUQNFPW3C3jIHb0coS7abiniRpN30swxYNPEQfjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768027583; c=relaxed/simple;
	bh=cQV8/MBD0nnc/1hD9Er5zxldFxzhLYdeS8IBRzexO/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dyt9rrO/9z+zUPRrr6rKBv9+E6oQfabN+dSeR0R4VZmsYTtxr6XqZJK2VpSOLqEQkLBJrPLzeXo4rHZehydYmeIrlQcmfrljsIQA4Lgl8d6jwqZ3aP0nXbusO13GBLdCS2c7I6iBOvxR7tB5Bm/sAHFQFP8p4Q6Pu1P+8qDRlp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMQ6UoW5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0f3f74587so39045235ad.2
        for <cgroups@vger.kernel.org>; Fri, 09 Jan 2026 22:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768027581; x=1768632381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ou5lC76BYaJdteXUTMwt+L2/JNxHr6qaLeaM9sIinw=;
        b=OMQ6UoW5tZvChFWuMZcex1WLDifi3quo+esmlz7/AsrMqdd0p967RCvh+TEVg2s1YS
         pPvj66rQNnBqkDmBOAyppjP1yB4he7ozRGTE55SdT8z14KW0JMhksW+6Dzz9Z2O9vsM/
         OGp6c4mJ8SPqOX/UBTL3f1PFoyhNYQ35Z5JrCaabRtArXmVcfgd56+/BMuA7xTIOB4nZ
         RankMwDRnVmlsZ02XB8lAolHYCGGgaPNBaDwrpVDlCQwSlV34lGfVDu5AhmMS5dA11C1
         ugHRujVniRxtAUqiwOZtC4Jt42gOU8Y1i23zfPXIhf0qHW4aEPpHZSzP3CWXTOvApclS
         wciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768027581; x=1768632381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Ou5lC76BYaJdteXUTMwt+L2/JNxHr6qaLeaM9sIinw=;
        b=na8lm17WvBy5UdPmL1+0UDLiPBrYLbeYhEa07Niywl9zuhO8WmYW4+PukUw+enM8tq
         GamU5QrFvS4nGQkaVRH7ZAl+hPO5ntKh1eV6dfjcY0OOAZiVxwa1b65CXcwDk2S2jsy4
         tQSLMGK/R9M0+w3sCpDD/BEkEU+GJ56+MGzgKMLUg2XDEKa1lXgmOsor5q3x146nPPiX
         FAis9wXsur3bGXfeKdaY2ktgyLyl8Tzm7x9q9RT/IEzxH0cy6OXwPbIRmPymlWrohxEi
         iNkkYvc8wXDxEW62LKp9RQgsChS3xJnjlOnUARQak3z744o81SPykNgjGkCxa9mw32PX
         RSbA==
X-Gm-Message-State: AOJu0YxK/xY9LqEDBQ+oyoHdCqPuWGPrv2nfakwKIP5Z/JcDf6lveZRn
	7/R8ZNN0gRJiRaLfcltO7uWkUs3Bclio2EP25xy3ySK1z+wN/3CvHGo0MntpSg==
X-Gm-Gg: AY/fxX7v+5Gw6qIrM1De1pI8Rhn9ni2eiX3d4xuaaM7gmC3SN1vHHtiDNSPPq71l0jm
	jT8sNf93o8DjkItFCl9yPEyoHtAziAFfFudU/c4eMnWP5ms7Td9TicPY1lxorFYsAzJtdgIu/pj
	sgh7bDqsV2PSDvdylAnSNpMltKGJ2GhOvZZ4mSN8ftXcFYXeyxIT6tWZSUS50QybbmwBS6GsibE
	tsHDm9RjoiMhPVQB3TvYyeRt3W3JZxIS/FyRvhAgxjVSia21R14kLlFkWMtga/0yGk9Jh2grehk
	3SlQIxe7WCSH0v7D0Y6ScFircexiwOjwONgYf0vz0uryi1LQNOg0VZLgNM9s80ImxkQXEcmmlQT
	xiANUQzeoInk+zgxiGWlj3z/KGdrgmdA0jqCwPxjqhfABG9g9ShDu3Ikzmpserc7vjOrYyp8B4+
	pNu9EQlXRkcJDzRq/QH1VolNZW/AstrtL6/WTblyDbnk7AU+Ea5muLYQ1EJC0RBcuarLY=
X-Google-Smtp-Source: AGHT+IHGuQt22SdTcAc4PZYM+XsESzmpxcEWJWs9UUXAO5SJX6AiSx1GNlfqbJQp7/JvjdqURXdu0A==
X-Received: by 2002:a17:903:32d1:b0:2a1:3895:e0d8 with SMTP id d9443c01a7336-2a3ee50926fmr104894095ad.60.1768027581447;
        Fri, 09 Jan 2026 22:46:21 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:3fae:1049:5d45:ed6a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a512sm122712385ad.10.2026.01.09.22.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 22:46:20 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org
Cc: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+d97580a8cceb9b03c13e@syzkaller.appspotmail.com
Subject: [PATCH] mm/swap_cgroup: fix kernel BUG in swap_cgroup_record
Date: Sat, 10 Jan 2026 12:16:13 +0530
Message-ID: <20260110064613.606532-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using MADV_PAGEOUT, pages can remain in swapcache with their swap
entries assigned. If MADV_PAGEOUT is called again on these pages, they
reuse the same swap entries, causing memcg1_swapout() to call
swap_cgroup_record() with an already-recorded entry.

The existing code assumes swap entries are always being recorded for the
first time (oldid == 0), triggering VM_BUG_ON when it encounters an
already-recorded entry:

  ------------[ cut here ]------------
  kernel BUG at mm/swap_cgroup.c:78!
  Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
  CPU: 0 UID: 0 PID: 6176 Comm: syz.0.30 Not tainted
  RIP: 0010:swap_cgroup_record+0x19c/0x1c0 mm/swap_cgroup.c:78
  Call Trace:
   memcg1_swapout+0x2fa/0x830 mm/memcontrol-v1.c:623
   __remove_mapping+0xac5/0xe30 mm/vmscan.c:773
   shrink_folio_list+0x2786/0x4f40 mm/vmscan.c:1528
   reclaim_folio_list+0xeb/0x4e0 mm/vmscan.c:2208
   reclaim_pages+0x454/0x520 mm/vmscan.c:2245
   madvise_cold_or_pageout_pte_range+0x19a0/0x1ce0 mm/madvise.c:563
   ...
   do_madvise+0x1bc/0x270 mm/madvise.c:2030
   __do_sys_madvise mm/madvise.c:2039

This bug occurs because pages in swapcache can be targeted by
MADV_PAGEOUT multiple times without being swapped in between. Each time,
the same swap entry is reused, but swap_cgroup_record() expects to only
record new, unused entries.

Fix this by checking if the swap entry already has the correct cgroup ID
recorded before attempting to record it. Use the existing
lookup_swap_cgroup_id() to read the current cgroup ID, and return early
from memcg1_swapout() if the entry is already correctly recorded. Only
call swap_cgroup_record() when the entry needs to be set or updated.

This approach avoids unnecessary atomic operations, reference count
manipulations, and statistics updates when the entry is already correct.

Link: https://syzkaller.appspot.com/bug?extid=d97580a8cceb9b03c13e
Reported-by: syzbot+d97580a8cceb9b03c13e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d97580a8cceb9b03c13e
Tested-by: syzbot+d97580a8cceb9b03c13e@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 mm/memcontrol-v1.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 56d27baf93ab..982cfe5af225 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -614,6 +614,7 @@ void memcg1_swapout(struct folio *folio, swp_entry_t entry)
 {
 	struct mem_cgroup *memcg, *swap_memcg;
 	unsigned int nr_entries;
+	unsigned short oldid;
 
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 	VM_BUG_ON_FOLIO(folio_ref_count(folio), folio);
@@ -630,6 +631,16 @@ void memcg1_swapout(struct folio *folio, swp_entry_t entry)
 	if (!memcg)
 		return;
 
+	/*
+	 * Check if this swap entry is already recorded. This can happen
+	 * when MADV_PAGEOUT is called multiple times on pages that remain
+	 * in swapcache, reusing the same swap entries.
+	 */
+	oldid = lookup_swap_cgroup_id(entry);
+	if (oldid == mem_cgroup_id(memcg))
+		return;
+	VM_WARN_ON_ONCE(oldid != 0);
+
 	/*
 	 * In case the memcg owning these pages has been offlined and doesn't
 	 * have an ID allocated to it anymore, charge the closest online
-- 
2.43.0


