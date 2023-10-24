Return-Path: <cgroups+bounces-21-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FE47D5271
	for <lists+cgroups@lfdr.de>; Tue, 24 Oct 2023 15:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4F66281A55
	for <lists+cgroups@lfdr.de>; Tue, 24 Oct 2023 13:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147B12C87B;
	Tue, 24 Oct 2023 13:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ogBFPLi8"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956812B775
	for <cgroups@vger.kernel.org>; Tue, 24 Oct 2023 13:47:07 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E941A10F4
	for <cgroups@vger.kernel.org>; Tue, 24 Oct 2023 06:47:04 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f61a639b9so61785347b3.1
        for <cgroups@vger.kernel.org>; Tue, 24 Oct 2023 06:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155224; x=1698760024; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YHgfLVMScT5H/FxRnxJh+3xP9v/l17ghYQJMJklbWxc=;
        b=ogBFPLi8fvrnXU6vKCvucgyBHD5/3evNz0uRdyIFs1oqcaBX8qH5RZIeDsGH5V53QY
         JLd7XMnbQQW4W6PcPFwunDg79vf1GF+pP0ZszfguoLxlNiM6dNl9bhmgYu9aYHXqe5MG
         y16phkyjP8bmXcYvLbVM7YJLoOIG6SS4BfVuqAGapmdfBrGOrgcKjgu7u44cD8cOm9kE
         qpUSR4ZpYt1oFZNTpSldByfENNAof0Yda8pAhuvtUGtgQiJ0Lwc5DkLRBOPLUEGZpma7
         qyjusp0eIOv43YbpV2B02o5Bmw7aBZdYPAM0vGYC3iHwM7a+tawV6Rat4RnOz5U+04yt
         JClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155224; x=1698760024;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YHgfLVMScT5H/FxRnxJh+3xP9v/l17ghYQJMJklbWxc=;
        b=R0TN9EkCEEZiGupaAL1gXxy/5UBGsGw6GDPYeYh4ebcsjHusFpKR/8+dmcBcMUnzxb
         gHVzLq5Lql+Xm8WJswZCMnZcShwfFlVjumwmfM5U+1TOFPR3aZ7KZ0R6qfDhzYtxf4su
         Htg6iuW7zzTXMPyRQuICMseQc7IzCgBGBSMIeNBFu7vIOvDaJ71DBVonVmMsJ5cOICJB
         slAgQn0hmJog7N6xx9O8ONCTgVULxA9YNhDJCoEQRr0yQ/lJfKKuN3N/MzPPZPDrELzB
         Iqti8wXeq/YVGzR5pjgnMjRY1dugrQDTwsaUJXmOzkTX1KXcYRzDw7ir1eELrCpQSKdi
         zgdg==
X-Gm-Message-State: AOJu0YwZCs8zJK/ybUEtiZnULNR0RJ33OKydZyOY/Us5WjuoOw8lPBIx
	sW/ANnBLJwYRk9/J/G35vtGcwdnnlRE=
X-Google-Smtp-Source: AGHT+IHeBKvEZxCc8z4s40S7ha5hgPZX8U0NGngnhsFR9kbksVyPLDfdSNwpUqF/X+vAqjdciG/7nvEnCYM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a25:297:0:b0:d9a:4c45:cfd0 with SMTP id
 145-20020a250297000000b00d9a4c45cfd0mr213074ybc.2.1698155223878; Tue, 24 Oct
 2023 06:47:03 -0700 (PDT)
Date: Tue, 24 Oct 2023 06:46:07 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-11-surenb@google.com>
Subject: [PATCH v2 10/39] mm: prevent slabobj_ext allocations for slabobj_ext
 and kmem_cache objects
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, ldufour@linux.ibm.com, catalin.marinas@arm.com, 
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

Use __GFP_NO_OBJ_EXT to prevent recursions when allocating slabobj_ext
objects. Also prevent slabobj_ext allocations for kmem_cache objects.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/slab.h        | 6 ++++++
 mm/slab_common.c | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/mm/slab.h b/mm/slab.h
index 5a47125469f1..187acc593397 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -489,6 +489,12 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
 	if (!need_slab_obj_ext())
 		return NULL;
 
+	if (s->flags & SLAB_NO_OBJ_EXT)
+		return NULL;
+
+	if (flags & __GFP_NO_OBJ_EXT)
+		return NULL;
+
 	slab = virt_to_slab(p);
 	if (!slab_obj_exts(slab) &&
 	    WARN(alloc_slab_obj_exts(slab, s, flags, false),
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 2b42a9d2c11c..446f406d2703 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -222,6 +222,8 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 	void *vec;
 
 	gfp &= ~OBJCGS_CLEAR_MASK;
+	/* Prevent recursive extension vector allocation */
+	gfp |= __GFP_NO_OBJ_EXT;
 	vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
 			   slab_nid(slab));
 	if (!vec)
-- 
2.42.0.758.gaed0368e0e-goog


