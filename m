Return-Path: <cgroups+bounces-1746-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C788585E7BC
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 20:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F0D1F2345C
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 19:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFC312C544;
	Wed, 21 Feb 2024 19:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Di2FTRif"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3142612B174
	for <cgroups@vger.kernel.org>; Wed, 21 Feb 2024 19:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544477; cv=none; b=Yd13TDMUKQbeiURGWNtyjvWKStxtnjZR+hU5JteKkNy7tfFjzsIeAnLwc7uPQR05CNvI8e7pxc0ndNogV5oKradvMTHDII/a+n3abeywiXhP7e3LdFbkOq4SYKbxg+OiDXCf8QpMt7Kci/gy7+VZnfm7RiDdS5/1curhmKN7HwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544477; c=relaxed/simple;
	bh=m5EGKOdquvmbILeFjjFHSeqjG9nrbDblZ38R+K7TUkQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oriLuRXqcdvdTy/ORXO2gfsGP4k/z0Db3pl2e7mMH2cyAZKAX8ctJh2WWyegqYs7JqKX0i4VKqU/mFFRPnR3kpfGvNcRNryarCX1Yjpfz5I2A7kJXQHa7StHaVetg2l+IveVZXth8vLrHwMBbJk26VZCD7QptBS8qe2ybre47kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Di2FTRif; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6081639fecfso53298707b3.1
        for <cgroups@vger.kernel.org>; Wed, 21 Feb 2024 11:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544474; x=1709149274; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DcVDeB20sah+c6m+q7qbj/Bohzcv0RbxXXpsl4x4Og4=;
        b=Di2FTRifG6eroHkDT21OoFBO7b2+ofk33a+EHisHiSFjZ4r5DbKQq4hMwE8PNIq9W/
         9/w8O1qAKTqhpCfOh73JlpeUshVQNgQmkRBxDs5JTMI+yO5C0KBnsv11dm5lXaHQU5tN
         qd1FdosjDsriFLoxqTbuLKQBykOYIp6vOfu3ILKoQ0UrjIX9icS/ZxsvHm91Ut6Y3oOE
         wMOEkDxAPdnlsM5VLEteL1LZ2pfE9hnOfDvQEKzDADhDvOx9tGhwyAWhKKWklFOcj15w
         zMeeLgHtAesCZjzI1EpbOiC4mHr0RDPfha49IOiuONYwzI/72czispOrkO4fkzudlkJw
         xb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544474; x=1709149274;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DcVDeB20sah+c6m+q7qbj/Bohzcv0RbxXXpsl4x4Og4=;
        b=k0zCpWA5ltuYrAz6D9se38WOKfirPJEZTv8lxuq/D1G/JerH1YKoPTqIkSRUcGI8yT
         cwqSt2kqRu5C+zLFEMg85OM03B/g47sHSv0vazHmYhkIVRNsmtejU+wUhjo+ohiRWp/H
         QWkAg4r4fJJEEy+Wt1Y5UFk4Lr0/WPPlQ1yETDzCIla+ZG9cWoTrq7sMiyDSGuJEZxZH
         Ycd7OKJh+RGstX91OvsPTiRHNEF5C/KAzg134wgG5kXpbq8Ej2SByR8gNfh0aJwZhfxQ
         MLbkWMcFcv5csMkeLGmlmJ1FAwlUVCB18RrMXm8qmgookUFYpsl1h4xX6PTbzJhpwzhZ
         Kjlg==
X-Forwarded-Encrypted: i=1; AJvYcCXufmHOdeehOpKIQc3VOV8kcduO1EReC1MeQzPCMy/dn7zNb0UowpUmW4m/mVhqBFmI083pcMS+SyBsCmBKOcP8sRLXdHj/eA==
X-Gm-Message-State: AOJu0YzejB3UnIXTk7qBY89Iuz/fnbcmbgzqVCzCbDyJMStUJi934jvP
	2BU7e4Tepn7Iwux78PUclU2eSJjarzjWwzj288OGSSKPwYlVL0Firu9x3hK7+hauCp3eEHUVxyj
	Q3Q==
X-Google-Smtp-Source: AGHT+IH75M2lZrHB2S9wjqCstmCY896frmoFhg/GjACV0w0wTBslVAISl72HA0I1QmkMPlsLusmP2hmQVrQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a81:4ecd:0:b0:608:9561:fdbe with SMTP id
 c196-20020a814ecd000000b006089561fdbemr96126ywb.2.1708544474186; Wed, 21 Feb
 2024 11:41:14 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:21 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-9-surenb@google.com>
Subject: [PATCH v4 08/36] mm: introduce __GFP_NO_OBJ_EXT flag to selectively
 prevent slabobj_ext creation
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, surenb@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce __GFP_NO_OBJ_EXT flag in order to prevent recursive allocations
when allocating slabobj_ext on a slab.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/gfp_types.h | 11 +++++++++++
 mm/slub.c                 |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 868c8fb1bbc1..e36e168d8cfd 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -52,6 +52,9 @@ enum {
 #endif
 #ifdef CONFIG_LOCKDEP
 	___GFP_NOLOCKDEP_BIT,
+#endif
+#ifdef CONFIG_SLAB_OBJ_EXT
+	___GFP_NO_OBJ_EXT_BIT,
 #endif
 	___GFP_LAST_BIT
 };
@@ -93,6 +96,11 @@ enum {
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
+#ifdef CONFIG_SLAB_OBJ_EXT
+#define ___GFP_NO_OBJ_EXT       BIT(___GFP_NO_OBJ_EXT_BIT)
+#else
+#define ___GFP_NO_OBJ_EXT       0
+#endif
 
 /*
  * Physical address zone modifiers (see linux/mmzone.h - low four bits)
@@ -133,12 +141,15 @@ enum {
  * node with no fallbacks or placement policy enforcements.
  *
  * %__GFP_ACCOUNT causes the allocation to be accounted to kmemcg.
+ *
+ * %__GFP_NO_OBJ_EXT causes slab allocation to have no object extension.
  */
 #define __GFP_RECLAIMABLE ((__force gfp_t)___GFP_RECLAIMABLE)
 #define __GFP_WRITE	((__force gfp_t)___GFP_WRITE)
 #define __GFP_HARDWALL   ((__force gfp_t)___GFP_HARDWALL)
 #define __GFP_THISNODE	((__force gfp_t)___GFP_THISNODE)
 #define __GFP_ACCOUNT	((__force gfp_t)___GFP_ACCOUNT)
+#define __GFP_NO_OBJ_EXT   ((__force gfp_t)___GFP_NO_OBJ_EXT)
 
 /**
  * DOC: Watermark modifiers
diff --git a/mm/slub.c b/mm/slub.c
index 76fb600fbc80..ca803b2949fc 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1899,6 +1899,8 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 	void *vec;
 
 	gfp &= ~OBJCGS_CLEAR_MASK;
+	/* Prevent recursive extension vector allocation */
+	gfp |= __GFP_NO_OBJ_EXT;
 	vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
 			   slab_nid(slab));
 	if (!vec)
-- 
2.44.0.rc0.258.g7320e95886-goog


