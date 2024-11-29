Return-Path: <cgroups+bounces-5716-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA069DE901
	for <lists+cgroups@lfdr.de>; Fri, 29 Nov 2024 15:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50499162E12
	for <lists+cgroups@lfdr.de>; Fri, 29 Nov 2024 14:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C2F13C9C7;
	Fri, 29 Nov 2024 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lo8ptnC3"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F7284D3E
	for <cgroups@vger.kernel.org>; Fri, 29 Nov 2024 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732892325; cv=none; b=NxycmXAWX3ezcQMYt8urTMeJqKvO1decyCb8UtQdpGby+hsMVut9nRT7RTUKIRPeZ18r2KUwoIJobckg60NU8IkX3hxdIDbTmF1E84uPvx1yzBl1rH0xICR/hG/tzeMYRDNqZ2T+Kjhx3NLo/Z4SgsZIUgf8yT9WQ1GqR9MbSwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732892325; c=relaxed/simple;
	bh=CBop+YSCCMMojpmFezdrCbqe9ataCIhn+PD0qvGky5Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Nwt6PII5Onku3tgsx5fmgwGMHcWil+tMwDYV4kRnBhi8/f386BX326SDesn0z4tf+IZASXuGqCh+t3NMu6rkYT2OB93nrVqhktyfEURoiMHfHWxwM+APg3pilqb4TxmM1Szd3KaiAiHbvHxsNSF/ccv0caOE2leXvo+nYKQ4jn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lo8ptnC3; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-385dc37cb3eso555712f8f.0
        for <cgroups@vger.kernel.org>; Fri, 29 Nov 2024 06:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732892322; x=1733497122; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qOHv5KJ3NWzGHishhKL1KBW7zLhmn2iCzmFqlAygBdg=;
        b=Lo8ptnC3DYu5c0JxNKjpwpF/39O9jU7dVUuF6THCnUaErME9gnA7ifwxtwSmAbVkpf
         Z44WxQPKs0dhU1zAoDzfaaTl/UlX2v/zjagWUp4EAROELCaRBmc4zp+KgUiB1kAt7nn7
         EAgoDIKcg8XM/fc5ACkH+7CKBcq5VycC5bkGe+cd6M1lrO9a9gcbb5VWuCotDNkO9cBI
         ET4Zsilg2FGRkSEUHwaoJHmESpEDprxS72P10J7IOoYnwnq/1GHcHLRGOuZyg4eaKOCT
         TW5f4MGtJx12E81PtOsaOjl2YmTALmmSr1u1sOO1dsAj+qU/LEZb2qvFJVujOwz7pXiY
         0XyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732892322; x=1733497122;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qOHv5KJ3NWzGHishhKL1KBW7zLhmn2iCzmFqlAygBdg=;
        b=XknXE68xSnRI0vdOjIDdON8kR6Y/QkOjeSN4TwbcQ21WEOwfBGdWv6ib0/p2fqCUNW
         kRDxWTWDyl6Imww8JlevGdgzM8zkTWE0nVb1LuhYqBIdfkp9hf6ck2AREFfbYatrq1OP
         5BPkz3QIxE5UkvgNSk34JL9kkGI0MOdeXjZIhQ9EhVcgTE/QS5QxRrWRimxTV6YUEC2P
         Msv9iIUgr8tKEHlQRMxreV0oyfmTUl/C+f5asbkksiDnwXsMmuuk3Zqq8mC5GStMarf7
         NXnuR3c3KNrr5Ri6AuJwNYnPjhZLnAVPYWRXRYEhbdmeRWITl4UlQDpsk5S1C1P4kcq9
         Qp6A==
X-Forwarded-Encrypted: i=1; AJvYcCVbHUQ2B5Ok5/7W8GvDOTRXiPZ8bseWeBDUWO5sxxZHRUXeWxXBAZrR3IfC3arHmEPQk+r5V3IW@vger.kernel.org
X-Gm-Message-State: AOJu0YzWs9qttsKCLJbZ9Fiqlc3znWGIz++owqKRbFRg/6rRfgDJ+kbO
	DzmW7ZKLmGntiG1rMiM9TT0+jEzRg6Nuna8pfuxypXtNFSy2+BU2CuyuwUbrr1VQXfAhhaA55fA
	X5Hqp0fVrFyXVzQ==
X-Google-Smtp-Source: AGHT+IEyGbf9icNVbiYCIgs6htIdvZ9baEHisAIn3VQNzAuguzrtl+kYarEDYcZgbQkeYhcN0YyYlv3eE3N1PGk=
X-Received: from wrfn11.prod.google.com ([2002:a5d:588b:0:b0:385:cfa6:7962])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1446:b0:382:3f31:f3b9 with SMTP id ffacd0b85a97d-385c6ef3a96mr10849321f8f.56.1732892322433;
 Fri, 29 Nov 2024 06:58:42 -0800 (PST)
Date: Fri, 29 Nov 2024 14:58:25 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJHWSWcC/32NQQ7CIBBFr9LMWoyDtaAr72Ea0sBASWhpQImm6
 d3FHsDl+8l7f4VMyVOGW7NCouKzj3MFfmhAj8PsiHlTGfiJt4hcsuDzU4X0UhNN2ikTdWZGnDt
 CI3EQFqq5JLL+vVcffeWxOjF99pOCv/V/ryBDJqi9dPIqpG3p7mJ0gY46TtBv2/YFlPSsfLcAA AA=
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5443; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=CBop+YSCCMMojpmFezdrCbqe9ataCIhn+PD0qvGky5Y=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnSdaSIG9cS9LiAmjD0wAKIgh8j9clODX4rm3ma
 4Bz/GkIar2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ0nWkgAKCRAEWL7uWMY5
 RtIYEACJO3wXaKlE0GOOBUsa1kCSaVp3F41zps55VKJizS6PXnfYGpbzKxsFUXayFq73uZ8hTVe
 Xv3QzlD7M0CD1kWkVEfU2AdnHtsDHlWhk5P4IbL64coA9qrhYaB/A3BC9V8yQbs4N3yk5HnT0D3
 8JBebttOkvm2+5naJYryI4cRpFfrmheZrVDYYsrYqEkeSJ93I9YNQ9TbjQQknTFL0EPWSRfRbnr
 27ZtoiqgkOdgZ+MVfja3l+bhfvYMRnZfGs081g8wgwnNHWV1wMQeSwmK1KLLOw7yXR1Fa4DuBaK
 6PP1obG/edfrPntJmPxyCq1qL4Kh0CSARcOO8DGUKOZ/1GKWXhDgcjDwSG12Tpos38Wvw3zEhow
 kyF6zOp5Vhfn0l+qShziyYRZa9g8WidPT/ssSvPVRXr/WEioc85AAxrsJAxBOh6vGAHan4CzZFF
 JyLUcr7cW6oQWkiITqTS3RKvvrZhCli6rRw22K/VLuBfF52zM5kAZrzOGi4FQS8REhvR8DMfUWD
 Iu73g0XaEBYNKxLQalu3w5NIIWx9G2Blo05treMi1uOBJF8FUW0hUtEPX1VOMuWCSAIwHP5Nnk0
 JeCPsW1JkEJwr5qkGi5si6oYNuJNRIkAjHy9wQGDIonJvZCkQFytCID3n/D6Pz6J4RLVT7u377i vD0YBEGWfQ2/WXw==
X-Mailer: b4 0.13.0
Message-ID: <20241129-list_lru_memcg_docs-v2-1-e285ff1c481b@google.com>
Subject: [PATCH v2] list_lru: expand list_lru_add() docs with info about sublists
From: Alice Ryhl <aliceryhl@google.com>
To: Dave Chinner <david@fromorbit.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>, 
	Alice Ryhl <aliceryhl@google.com>
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

Also fix incorrect use of 'Return value:' which should be 'Return:'.

Link: https://lore.kernel.org/all/Z0eXrllVhRI9Ag5b@dread.disaster.area/ [1]
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
- Don't reword "if the list was updated".
- Update 'Return value:' to 'Return:' on list_lru_*_obj() functions.
- Link to v1: https://lore.kernel.org/r/20241128-list_lru_memcg_docs-v1-1-7e4568978f4e@google.com
---
 include/linux/list_lru.h | 44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 05c166811f6b..fe739d35a864 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -91,13 +91,24 @@ void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *paren
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
+ *
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
  *
  * Return: true if the list was updated, false otherwise
  */
@@ -113,7 +124,7 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
  * memcg of the sublist is determined by @item list_head. This assumption is
  * valid for slab objects LRU such as dentries, inodes, etc.
  *
- * Return value: true if the list was updated, false otherwise
+ * Return: true if the list was updated, false otherwise
  */
 bool list_lru_add_obj(struct list_lru *lru, struct list_head *item);
 
@@ -125,8 +136,19 @@ bool list_lru_add_obj(struct list_lru *lru, struct list_head *item);
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
  * Return: true if the list was updated, false otherwise
  */
@@ -142,7 +164,7 @@ bool list_lru_del(struct list_lru *lru, struct list_head *item, int nid,
  * memcg of the sublist is determined by @item list_head. This assumption is
  * valid for slab objects LRU such as dentries, inodes, etc.
  *
- * Return value: true if the list was updated, false otherwise.
+ * Return: true if the list was updated, false otherwise.
  */
 bool list_lru_del_obj(struct list_lru *lru, struct list_head *item);
 

---
base-commit: 7af08b57bcb9ebf78675c50069c54125c0a8b795
change-id: 20241128-list_lru_memcg_docs-d736e1d81a7f

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


