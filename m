Return-Path: <cgroups+bounces-4520-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5199961A3F
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 01:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6212D1F24784
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 23:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40031D45FD;
	Tue, 27 Aug 2024 23:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VZE/MPbO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FCB1C8FB0
	for <cgroups@vger.kernel.org>; Tue, 27 Aug 2024 23:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724800301; cv=none; b=cO47UE+UDpNtKwZHD8Ggeek3rZK7fWRHoh7imzfJb13iQ9hnXMNVp1XwG4rbye4qw0Lx7LGqW+CyUrz+SVIha+GFnKYLBITqoy8Lkxvmc2D+8GJlXtObVYbcgYD8AxxlcCiaj5BRg+OeB+/T/KEtr2dJl+84zeZM+d4J7VtBLOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724800301; c=relaxed/simple;
	bh=pmnA98OHlkAk1b+OhNUeP4JA8KFIHmpFHK8wxlWLNA4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HqULM0js4Owp8jX6LvMYLyfBzCjap+WjI135haLxmPziviBz3tQfEijMDbKAe7VuoYl1ptw1k4Og73+5C2+SLCJX9JvvfUCexMxwNDiQ1L6vd6tmG7sphEiM9Ynfk6W3tlrWoIs8DfWDfNkPG5w2RMnoVxU1ytTAuGwEnlcgsnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VZE/MPbO; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7d1fe1dd173so2448160a12.0
        for <cgroups@vger.kernel.org>; Tue, 27 Aug 2024 16:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724800299; x=1725405099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uLJnrvY/TNbJZgveXjXzKwi1waLm2OswD6XrKXtY0Dg=;
        b=VZE/MPbOss8wfDj3UEJ1b8YUikmnFZXldSQhRVU5t9KPHd5waNUCQtyGM6icJJqprn
         JTpcqQGM0F1K/xuxquTCJZ1no81EIhckSNloyIiq5SQenw0TV4JOkfIqcYTQsfkm1Dc4
         uWyr/YAUd52cNyKCYb3qk/9tCXXn27s9mTKy7BKFIloYdbJIgejSybW7Ue8mxCDA/Tfb
         Z7PK5zJMEyqGNKURrGVsVvGoGlZXZ/ncqGqJcs0lFxS+b1M0m3LgT3tzVg2nMRTuCk9J
         p0D5TfF+hAZokcGQAeh/V8IzjfEgE/+bPAvPDl50jKyS+jbTI5FXdv4esX+PN3NHd2CF
         vUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724800299; x=1725405099;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uLJnrvY/TNbJZgveXjXzKwi1waLm2OswD6XrKXtY0Dg=;
        b=GxSJqZuZXkqU9pSj39IiuIGTkz7n/lBZi/0mbBd+OcHQdSeCL4oxTMHE6oW0ILMBDe
         UmOSR09JYe+YiYO2WmDqFn4CSCTukQ4g7DIQvWTmTR5ZcMuVqHcNKmGzXxBKNXtRqIhQ
         U5UrU5cLP0LqsI1LywgW0Yp3ErBHFIzM2293/jJKmPJMKttQmyjVo4c4wWXVw9kHiZaG
         MtNHY99HxuMzySuhd9Tgl6lbFMqX0KM5Trx4AIEme524qhL3Z7edtlDJ/QqJjNXNyj3N
         hwkANnun8XVWpWytQQB/tZ+jKHYRkgOKzAq+rLEjewDk4lJkAtQoWAes/geMfnqMCOQ5
         +wew==
X-Forwarded-Encrypted: i=1; AJvYcCWiVTn/DgeEDtc1raR8RFFyxZdLsLAp1TKoh0EODn9exeJ3ykzIOKxxz0NwOkma/ieX4h+W60MN@vger.kernel.org
X-Gm-Message-State: AOJu0YxPpdz3SDC8MsDxR4QA99XUr+7Pd1IxABs0Hd/QH6WIXIKfrIVP
	eVx7AZUK7T71F4n/yV5y+a+5MfMHrLNS0c1IYdWBqqJ7RjZrYvmQkjQ3w8kXaLTjnA5aA1NUekx
	3XPeGdvAsJg==
X-Google-Smtp-Source: AGHT+IEokv9e6LuULnuwid4WZdlPlarG8J+pXfvpDb7CgbDsiCb9RtBxcqB82FKfSIIge11nvt7XccQqszzV4Q==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a05:6a02:5aa:b0:6e7:95d3:b35c with SMTP
 id 41be03b00d2f7-7d2228eb22fmr302a12.5.1724800299140; Tue, 27 Aug 2024
 16:11:39 -0700 (PDT)
Date: Tue, 27 Aug 2024 23:07:38 +0000
In-Reply-To: <20240827230753.2073580-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240827230753.2073580-1-kinseyho@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827230753.2073580-2-kinseyho@google.com>
Subject: [PATCH mm-unstable v3 1/5] cgroup: clarify css sibling linkage is
 protected by cgroup_mutex or RCU
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, mkoutny@suse.com, 
	Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Explicitly document that css sibling/descendant linkage is protected by
cgroup_mutex or RCU. Also, document in css_next_descendant_pre() and
similar functions that it isn't necessary to hold a ref on @pos.

The following changes in this patchset rely on this clarification
for simplification in memcg iteration code.

Suggested-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Michal Koutn=C3=BD <mkoutny@suse.com>
Signed-off-by: Kinsey Ho <kinseyho@google.com>
---
 include/linux/cgroup-defs.h |  6 +++++-
 kernel/cgroup/cgroup.c      | 16 +++++++++-------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 7fc2d0195f56..ca7e912b8355 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -172,7 +172,11 @@ struct cgroup_subsys_state {
 	/* reference count - access via css_[try]get() and css_put() */
 	struct percpu_ref refcnt;
=20
-	/* siblings list anchored at the parent's ->children */
+	/*
+	 * siblings list anchored at the parent's ->children
+	 *
+	 * linkage is protected by cgroup_mutex or RCU
+	 */
 	struct list_head sibling;
 	struct list_head children;
=20
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 0a97cb2ef124..ece2316e2bca 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4602,8 +4602,9 @@ struct cgroup_subsys_state *css_next_child(struct cgr=
oup_subsys_state *pos,
  *
  * While this function requires cgroup_mutex or RCU read locking, it
  * doesn't require the whole traversal to be contained in a single critica=
l
- * section.  This function will return the correct next descendant as long
- * as both @pos and @root are accessible and @pos is a descendant of @root=
.
+ * section. Additionally, it isn't necessary to hold onto a reference to @=
pos.
+ * This function will return the correct next descendant as long as both @=
pos
+ * and @root are accessible and @pos is a descendant of @root.
  *
  * If a subsystem synchronizes ->css_online() and the start of iteration, =
a
  * css which finished ->css_online() is guaranteed to be visible in the
@@ -4651,8 +4652,9 @@ EXPORT_SYMBOL_GPL(css_next_descendant_pre);
  *
  * While this function requires cgroup_mutex or RCU read locking, it
  * doesn't require the whole traversal to be contained in a single critica=
l
- * section.  This function will return the correct rightmost descendant as
- * long as @pos is accessible.
+ * section. Additionally, it isn't necessary to hold onto a reference to @=
pos.
+ * This function will return the correct rightmost descendant as long as @=
pos
+ * is accessible.
  */
 struct cgroup_subsys_state *
 css_rightmost_descendant(struct cgroup_subsys_state *pos)
@@ -4696,9 +4698,9 @@ css_leftmost_descendant(struct cgroup_subsys_state *p=
os)
  *
  * While this function requires cgroup_mutex or RCU read locking, it
  * doesn't require the whole traversal to be contained in a single critica=
l
- * section.  This function will return the correct next descendant as long
- * as both @pos and @cgroup are accessible and @pos is a descendant of
- * @cgroup.
+ * section. Additionally, it isn't necessary to hold onto a reference to @=
pos.
+ * This function will return the correct next descendant as long as both @=
pos
+ * and @cgroup are accessible and @pos is a descendant of @cgroup.
  *
  * If a subsystem synchronizes ->css_online() and the start of iteration, =
a
  * css which finished ->css_online() is guaranteed to be visible in the
--=20
2.46.0.295.g3b9ea8a38a-goog


