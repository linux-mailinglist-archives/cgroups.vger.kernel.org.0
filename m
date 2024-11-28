Return-Path: <cgroups+bounces-5708-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6749DB73A
	for <lists+cgroups@lfdr.de>; Thu, 28 Nov 2024 13:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61805B21375
	for <lists+cgroups@lfdr.de>; Thu, 28 Nov 2024 12:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A255619AD86;
	Thu, 28 Nov 2024 12:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ev7phKaB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C5519AD87
	for <cgroups@vger.kernel.org>; Thu, 28 Nov 2024 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732795951; cv=none; b=KOQaJkDsoIidHQc++2/whGoFe17h5jRMOCVpai54JUjzgSq8Py4KctWOQYqxb7O92hHJ8ySHleP5UqyUDD2s7bJp9Wt70soT4V5RBfCECO3V75eID4dqosx8b7m/XUUkgAxuu480agB88uI9HNO0211ZT/OukPW0DTcgDZcaqi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732795951; c=relaxed/simple;
	bh=/LGrZOzJI+6kS93veQaIwzlwY/GP+eS2PE8NhODdl4Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZGqcvBYcXmKJsFjq/+RLTm5wNjQ3d/jLY9+pCDz7lkul39sMXYa/VQJVPMooUwwuNj/7O8uqYU8J0XCIYrjXILmUsemyITP0s3L4dBoi6ha6AXv8L9ucYfZRaN44523L+pwEp0iDnqiNaHdNwsxgzFLgshupKPfs4etPsrWXZPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ev7phKaB; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3825a721afaso466160f8f.0
        for <cgroups@vger.kernel.org>; Thu, 28 Nov 2024 04:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732795948; x=1733400748; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xv9Mnsqw0yP552va4yFfmGxxYoQFMLmXfy+o8MwyuvI=;
        b=ev7phKaBLwqggggwB8mIZBHdin5kO0Ofu3E2OvrJ24o2zcNHDEFgkhkDgCeTMV/kct
         Pl/47BRzs1kGusksJiW38tcMd838I+A9hEMsuxc6PaG8so/KeiraEuw/5XbCpiyN68Lg
         vniW1b3nlk2JWbQMcIH5kM3WtLTeTldtBtXEBlWFY6n1cTlJL0o5R3uE0ZzVP1pDPvya
         DVaDD92wFN+eiTAkBbLKAvp2f4TXGZUkyzriCCa6PlzBNWu2QirFatofq2Ws8hs73Db8
         8beX7aQT0aFBnNU3oeFMYPphAiDDp6SxkmbjUNZLfz8lTwSytsN4nBdpYLNCzDoK/XV5
         ptWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732795948; x=1733400748;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xv9Mnsqw0yP552va4yFfmGxxYoQFMLmXfy+o8MwyuvI=;
        b=NgMnO5aeviiq7qlxxw8Ql+3ZnVbpvxPy/icSmMrWxKFxToRvIXCh0pd7AfA8Z1TkQ4
         lWAW+EH3Yon1zNf9OX29FtYPqZKG9JIdQUqw3nt5iZr/6ZVlXS/xYgSVL+2ltvlAg8va
         /toCHa7gSzaBj6zHfoUMFwGOcoGq2IBOD4/uLLzffzeRPUu/K31tq3i7Mew8BInaS9PK
         k8Nt93YVn+BCn7lTTpPSpuU8uVz+aDExMuHV+OjKV6Qj8OI5G/AyjuU5ZqfQaylIaVR0
         rcDj+gISsdPiLxYRJXKEuaPR7MjG19YsxYqDM7bmXfxhlv8N6TUgM+Ham/Q3UplpVVP2
         Snlw==
X-Forwarded-Encrypted: i=1; AJvYcCVUypkdC+Jd2aymD7OXH9cVYwEaRTjFEGshH5C4lpCUxWKk+Sk/q1cf5BUxKFQ2f2mTChTN6ZnY@vger.kernel.org
X-Gm-Message-State: AOJu0YzdgswtHjzsqM0j8A1+mhX9Sc8a+hOuvn2MFdhm+S/QKJPb9zI0
	imSLk8TwWaFASuWz0Z2mRFjOKVf5sCg+zbJXtpA1wFok7VIMVsWmUxcVMV850RZbUlqboQDom9b
	pYpVOIRXEse7rjg==
X-Google-Smtp-Source: AGHT+IE8+KYnkF58GMuTj0VAu4E6cZL1TCWj/R8Fz3NdRbDJvaqchxbrbwH7siNgqYgBqqkBkJUSkwuvPxhg4xI=
X-Received: from wmpk41.prod.google.com ([2002:a05:600c:829:b0:434:a2fb:effe])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1543:b0:382:4f6e:a57a with SMTP id ffacd0b85a97d-385c6edc83emr6304046f8f.54.1732795948065;
 Thu, 28 Nov 2024 04:12:28 -0800 (PST)
Date: Thu, 28 Nov 2024 12:12:11 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABpeSGcC/x3MSwqAMAwA0atI1hZMFSteRaRIG2vAH42KIN7d4
 vItZh4QikwCbfZApIuFtzUB8wzcNKyBFPtk0IWuEHWjZpbDzvG0Cy0uWL85Ud6UNaFvcDAjpHK PNPL9X7v+fT/wu1jwZQAAAA==
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5452; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=/LGrZOzJI+6kS93veQaIwzlwY/GP+eS2PE8NhODdl4Q=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnSF4idTCr3X7DVYiatk5PpMqpcyL1UCi/4Liig
 TTZhVH50k6JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ0heIgAKCRAEWL7uWMY5
 RlfoEAC2nrOfgVrSgeKaMotPVEFfEs1t+E8RZVYdgNMXJlR9wKJeRs/IhzKbfMPKaJaxHkDfK6u
 ZShkjb6U/pHHXN8N3ZnpC1xTj1rnlEhny0ocAfqDVNNZyygvGlc1ZcpxlKq6LCndOYQ0s/Dv1fB
 KKOlQV0yB7p5k1wA7Phun42TnzLBPZwz664FT+92i04GYq5j6nMQJe0l8jDnO8PqYgVhBYbIeMz
 pQKbJZeMhsYQ4T1iDlSPYIPgRZ/VBCAiBsNtQzEMmUjD14Rcia5uZszmKK/ogQXt+HYnAAWSlkb
 D52cTuFqsvGsFzUG7wPgoXYs0SvOVCWNRsGHqXsFYM2a2ayv/KionikvwCQlhvAKB7bi2jMC/x5
 QiYLRoQGPt/S4ih1zHj56BUc8Xa+jwgdtz5txJhQ6uUkFFcK15LkeOousMyWJQiWizccZpAnZTo
 r96pEaZKPbSGOr/aPCDIpX0cyYxaW5iajzkYR1bBlDz4RD9Nb1FHcfjebYqJpFxZHKxRF6Ausax
 iKQKah8XTF25idJ9cmT7TD3WzLTnI402VrO+2jYH2vgXAUHYup1R5FZBitPcShJLDfAj+QNTX4y
 LezjQ7WkYc+mxHnTgAzNEcUR3PlEgpgsSpH8o5Vkpo9uld9MOjLkkpvZnHrfBE4msertzBYHWpa bPXky9OsM8tPadQ==
X-Mailer: b4 0.13.0
Message-ID: <20241128-list_lru_memcg_docs-v1-1-7e4568978f4e@google.com>
Subject: [PATCH] list_lru: expand list_lru_add() docs with info about sublists
From: Alice Ryhl <aliceryhl@google.com>
To: Dave Chinner <david@fromorbit.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

The documentation for list_lru_add() and list_lru_del() has not been
updated since lru lists were originally introduced by commit
a38e40824844 ("list: add a new LRU list type"). Back then, list_lru
stored all of the items in a single list, but the implementation has
since been expanded to use many sublists internally.

Thus, update the docs to mention that the requirements about not using
the item with several lists at the same time also applies not using
different sublists. Also mention that list_lru items are reparented when
the memcg is deleted as discussed on the LKML [1].

Link: https://lore.kernel.org/all/Z0eXrllVhRI9Ag5b@dread.disaster.area/ [1]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 include/linux/list_lru.h | 48 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 05c166811f6b..d4fc967247ae 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -91,15 +91,26 @@ void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *paren
  * @memcg: the cgroup of the sublist to add the item to.
  *
  * If the element is already part of a list, this function returns doing
- * nothing. Therefore the caller does not need to keep state about whether or
- * not the element already belongs in the list and is allowed to lazy update
- * it. Note however that this is valid for *a* list, not *this* list. If
- * the caller organize itself in a way that elements can be in more than
- * one type of list, it is up to the caller to fully remove the item from
- * the previous list (with list_lru_del() for instance) before moving it
- * to @lru.
+ * nothing. This means that it is not necessary to keep state about whether or
+ * not the element already belongs in the list. That said, this logic only
+ * works if the item is in *this* list. If the item might be in some other
+ * list, then you cannot rely on this check and you must remove it from the
+ * other list before trying to insert it.
  *
- * Return: true if the list was updated, false otherwise
+ * The lru list consists of many sublists internally; the @nid and @memcg
+ * parameters are used to determine which sublist to insert the item into.
+ * It's important to use the right value of @nid and @memcg when deleting the
+ * item, since it might otherwise get deleted from the wrong sublist.
+ *
+ * This also applies when attempting to insert the item multiple times - if
+ * the item is currently in one sublist and you call list_lru_add() again, you
+ * must pass the right @nid and @memcg parameters so that the same sublist is
+ * used.
+ *
+ * You must ensure that the memcg is not freed during this call (e.g., with
+ * rcu or by taking a css refcnt).
+ *
+ * Return value: true if the item was added, false otherwise
  */
 bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
 		    struct mem_cgroup *memcg);
@@ -113,7 +124,7 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
  * memcg of the sublist is determined by @item list_head. This assumption is
  * valid for slab objects LRU such as dentries, inodes, etc.
  *
- * Return value: true if the list was updated, false otherwise
+ * Return value: true if the item was added, false otherwise
  */
 bool list_lru_add_obj(struct list_lru *lru, struct list_head *item);
 
@@ -125,10 +136,21 @@ bool list_lru_add_obj(struct list_lru *lru, struct list_head *item);
  * @memcg: the cgroup of the sublist to delete the item from.
  *
  * This function works analogously as list_lru_add() in terms of list
- * manipulation. The comments about an element already pertaining to
- * a list are also valid for list_lru_del().
+ * manipulation.
+ *
+ * The comments in list_lru_add() about an element already being in a list are
+ * also valid for list_lru_del(), that is, you can delete an item that has
+ * already been removed or never been added. However, if the item is in a
+ * list, it must be in *this* list, and you must pass the right value of @nid
+ * and @memcg so that the right sublist is used.
+ *
+ * You must ensure that the memcg is not freed during this call (e.g., with
+ * rcu or by taking a css refcnt). When a memcg is deleted, list_lru entries
+ * are automatically moved to the parent memcg. This is done in a race-free
+ * way, so during deletion of an memcg both the old and new memcg will resolve
+ * to the same sublist internally.
  *
- * Return: true if the list was updated, false otherwise
+ * Return value: true if the item was removed, false otherwise
  */
 bool list_lru_del(struct list_lru *lru, struct list_head *item, int nid,
 		    struct mem_cgroup *memcg);
@@ -142,7 +164,7 @@ bool list_lru_del(struct list_lru *lru, struct list_head *item, int nid,
  * memcg of the sublist is determined by @item list_head. This assumption is
  * valid for slab objects LRU such as dentries, inodes, etc.
  *
- * Return value: true if the list was updated, false otherwise.
+ * Return value: true if the item was removed, false otherwise.
  */
 bool list_lru_del_obj(struct list_lru *lru, struct list_head *item);
 

---
base-commit: b86545e02e8c22fb89218f29d381fa8e8b91d815
change-id: 20241128-list_lru_memcg_docs-d736e1d81a7f

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


