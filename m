Return-Path: <cgroups+bounces-8587-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD6BADEAC4
	for <lists+cgroups@lfdr.de>; Wed, 18 Jun 2025 13:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 228C77AB6C5
	for <lists+cgroups@lfdr.de>; Wed, 18 Jun 2025 11:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C75D2E8DEB;
	Wed, 18 Jun 2025 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="g5cBbILV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2482E7194
	for <cgroups@vger.kernel.org>; Wed, 18 Jun 2025 11:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750246822; cv=none; b=VtXrfhPd/XtXPXWVeUL7V3xD09H8kdi3yw0J4FjyqRMHi/Fr5oHi1zf88D/3TzpuyDl0TfOCJesc7Mv2JJi8MTo/4cc2PYSykP4dRsntFp0ueD6NhnO0Zm4wJCe+aBp9N2zgc0Gm4E10KlhGf2J53kBz//+XxNDwvZQsNUuyMOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750246822; c=relaxed/simple;
	bh=Rm2a5l12BGJE4dDocrWPzywUMfLSXKw948jSbHOTcSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qrUUOQmLPuQ7qIRhfkEl9gXV5TRMNLDL+FyIByF9dX9IaPXa3r5kY8ZIy6HYxPZe3h5949saLCQuu+/z4bnGhBrGFaqoN5BrF6Qt3oTot0PyA0M7LWeXI9ITIox4w8bQZfIQHRrPKyZ7VDZm1BTdEES/FlW/uYOPHs6nZHhGUgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=g5cBbILV; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so5149955b3a.0
        for <cgroups@vger.kernel.org>; Wed, 18 Jun 2025 04:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1750246820; x=1750851620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vg9KlwIz1mnZGI4kokyeGTdkzv1z3OHfndjs6itg7OE=;
        b=g5cBbILVdq3kyB+XG58R0GD+io14/UUnUzEJ9JnUPH8N5YI/jcV2XTpyzfOxlbX+Dy
         30fBLFNOER/HpZkLMZct9/010rgVzI+WtM0mUs+g9quDP5TFEwbZSd/hAupMDvZyeFWl
         O2uJOtCr+VFhYfpHVfpqIcL9GDE5MoPxXD5y+Oi168C/pIJSC4zyvagctqfISozdalUE
         +c/Q71Txt7HsBZPsbYD2bDHs7hIQAOmEefsTomuXqU0UFGolkh/UZZ0iRZjksXWJwlT4
         RvRQMbn8b1whID6ZY2Eg+dIhHCIBpGGiN9Zpwfrlt+77H/3hZDMzPYQx2SvzerazswUp
         fxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750246820; x=1750851620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vg9KlwIz1mnZGI4kokyeGTdkzv1z3OHfndjs6itg7OE=;
        b=uh3gOzod/ciillPE2CzkUCEJzxHSVzAP0C1pzM2BV7L9ih7Y1aQVgptzcdMZSA2lDD
         fEl2Y0dky6zUvupoMhmI3MJiIbSvDncj36C8VvWrmAXCqow6PVHJKjmUZi2TGiUeDE4x
         X5JcGrCwZ7WKFXHm3tGylKIxFQ8OSDp0kmm/H9CpV1cAulFDdbgV3EeADe0FUTh/kT7M
         jQ4IuTQ1YFmYMc5ACwvqnYLgVK8zXqBdHw7f9pWExoE8PJGJwC4rE4wMPiMuERzgW4mu
         WFeYZMfs/M+NqHL6RTthMkeBAu5EKfFmM80DGlQucSqtYvPuzfPQWrux1Zn3etPRDiuD
         Pm2g==
X-Forwarded-Encrypted: i=1; AJvYcCVpr9hDY2F0i0XCbtd2YWznC3AEuPAM/cG7YO/eTULmAF0gbn8/Ejvem9BkyvpE5d/OE3dEb+48@vger.kernel.org
X-Gm-Message-State: AOJu0YykId19c/14/EwKPnhb9+5F7BC+rR9P5fWGYaAG/0A2T8DanpQR
	h+zFHv6WMd+2kMzHWi5xBTN8jrH1BX6J0JgNDFkeIoOg1kIXtK++0V0K5dJ8J96p8vA=
X-Gm-Gg: ASbGncvoTyyQ20EH+7mruIxiZ9ijJ9+Cyu7WjO6OFHmJaLEM3OLj/AQMFNwmxtYmlLr
	Eiet9YK6LGK4U+wyuG9SQbwytv5SRao06Hp2NY99sZE5ZkvngwhIApZi3oFqcfuNVlD8rMS0D4c
	os016xcjxwoXrk6xQLzsDlmRaMvCgnjowlu1MO9yo0bTkdpzMZB+0FSAy2fF6BJFmAOi7x/w8bI
	OdZSdghLectrrX6+kFxf2ZLWg7lqqVcoms8umZ468AXkujtV+k/LkxCASJ/KOVYYUIbUUiX1cel
	2qy7I/i3NbB/dQuJKWqT4MwDmWKyFfbV5AmgGNHDEb96eBhK3XbM6bVBaUvejsxlxgOg6zCqQO1
	/XUtbIa08KBk=
X-Google-Smtp-Source: AGHT+IFjiNLAtj905GCE7Fre41c5uh14WoSaN+/SDx34U3YOO1Dp0kn5NqBhaBmjWveoEpoBhRI3Og==
X-Received: by 2002:a05:6a00:852:b0:736:a540:c9ad with SMTP id d2e1a72fcca58-7489cfca938mr25785015b3a.20.1750246819747;
        Wed, 18 Jun 2025 04:40:19 -0700 (PDT)
Received: from n37-069-081.byted.org ([115.190.40.12])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900e3a09sm10683148b3a.180.2025.06.18.04.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 04:40:19 -0700 (PDT)
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
To: akpm@linux-foundation.org,
	tytso@mit.edu,
	jack@suse.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org
Cc: muchun.song@linux.dev,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	Zhongkun He <hezhongkun.hzk@bytedance.com>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 2/2] jbd2: mark the transaction context with the scope PF_MEMALLOC_ACFORCE context
Date: Wed, 18 Jun 2025 19:39:58 +0800
Message-Id: <81b1f3df0379b0e34bdf239d36d4d9aeb4bee9cf.1750234270.git.hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1750234270.git.hezhongkun.hzk@bytedance.com>
References: <cover.1750234270.git.hezhongkun.hzk@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The jbd2 handle, associated with filesystem metadata,
can be held during direct reclaim when a memcg limit is hit.
This prevents other tasks from writing pages, resulting
in shrink failures due to dirty pages that cannot be written
back. These shrink failures may leave many tasks stuck in
the uninterruptible (D) state. The OOM killer may select a
victim and return success, allowing the current thread to
retry the memory charge. However, the selected task cannot
respond to the SIGKILL because it is also stuck in the
uninterruptible state. As a result, the charging task resets
nr_retries and attempts reclaim again, but the victim never
exits. This leads to a prolonged retry loop in direct reclaim
with the jbd2 handle held, significantly extending its hold
time and potentially causing a system-wide block.

We found that a related issue has been reported and
partially addressed in previous fixes [1][2].
However, those fixes only skip direct reclaim and
return a failure for some cases like readahead
requests. Since sb_getblk() is called multiple
times in __ext4_get_inode_loc() with the NOFAIL flag,
the problem still persists.

So call the memalloc_account_force_save() to charge
the pages and delay the direct reclaim util return to
userland, to release the global resource jbd2 handle.

[1]:https://lore.kernel.org/linux-fsdevel/20230811071519.1094-1-teawaterz@linux.alibaba.com/
[2]:https://lore.kernel.org/all/20230914150011.843330-1-willy@infradead.org/T/#u

Co-developed-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
---
 fs/jbd2/transaction.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index c7867139af69..d05847301a8f 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -448,6 +448,13 @@ static int start_this_handle(journal_t *journal, handle_t *handle,
 	 * going to recurse back to the fs layer.
 	 */
 	handle->saved_alloc_context = memalloc_nofs_save();
+
+	/*
+	 * Avoid blocking on jbd2 handler in memcg direct reclaim
+	 * which may otherwise lead to system-wide stalls.
+	 */
+	handle->saved_alloc_context |= memalloc_account_force_save();
+
 	return 0;
 }
 
@@ -733,10 +740,10 @@ static void stop_this_handle(handle_t *handle)
 
 	rwsem_release(&journal->j_trans_commit_map, _THIS_IP_);
 	/*
-	 * Scope of the GFP_NOFS context is over here and so we can restore the
-	 * original alloc context.
+	 * Scope of the GFP_NOFS and PF_MEMALLOC_ACCOUNTFORCE context
+	 * is over here and so we can restore the original alloc context.
 	 */
-	memalloc_nofs_restore(handle->saved_alloc_context);
+	memalloc_flags_restore(handle->saved_alloc_context);
 }
 
 /**
@@ -1838,7 +1845,7 @@ int jbd2_journal_stop(handle_t *handle)
 		 * Handle is already detached from the transaction so there is
 		 * nothing to do other than free the handle.
 		 */
-		memalloc_nofs_restore(handle->saved_alloc_context);
+		memalloc_flags_restore(handle->saved_alloc_context);
 		goto free_and_exit;
 	}
 	journal = transaction->t_journal;
-- 
2.39.5


