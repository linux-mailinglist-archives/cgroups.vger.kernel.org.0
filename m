Return-Path: <cgroups+bounces-1981-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243A1873EE1
	for <lists+cgroups@lfdr.de>; Wed,  6 Mar 2024 19:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF484282E56
	for <lists+cgroups@lfdr.de>; Wed,  6 Mar 2024 18:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9843A13DB96;
	Wed,  6 Mar 2024 18:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nS//BiIE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D961448D6
	for <cgroups@vger.kernel.org>; Wed,  6 Mar 2024 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749513; cv=none; b=XPmS5HRw4VOOcFgf1c+ieY0T5D9sFqhz9hz+Sq2iu1QJgzevzybFIFT8o0nscNMrSKxIRLUumB5DACLRiWNHVIAs0dv6+rtV1MWvp0qv2AoJVBWZEROlNsPtYs21x+LlWvDGnKHMt1KmSBtY999q7EJiZ1+Nrz88+Rkrm32UNnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749513; c=relaxed/simple;
	bh=yct4qnU2TlVHTPT2LuakdSxlKoSb3v4n02iScNGM8ZI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Eesr4CcdgHqw8DPYRUHgUW/f7KKM4FVEGtxV8Kylxa3ldLsy6dCv7IZUkN93QnxA6G/640NhW1q4s/lrLkzq8PFMESGIp9gijbzv4X7aJyO1t1Kcu8xlm95LsS5XrBmtvcnksbtzmNM2JBbVOq6n1Anl/XLn2XVMGrlMTQ24gL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nS//BiIE; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64f63d768so3712659276.2
        for <cgroups@vger.kernel.org>; Wed, 06 Mar 2024 10:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749511; x=1710354311; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UUM81FzZaYB1+q8hTjh77vdQeiiRG/JwjOPLDZjum/8=;
        b=nS//BiIE45ejwDSPj1FiMmWK3Yah5k4796ouYLXvVqDiBtk12un39pDicGN9UDqyaZ
         19gYkyUhxhTJ/3wzrZIgVNdItDY/TmnsWmVf0bfxprUk0ydUoOH6odqDfSnr46/D4i1m
         VkXdaoLMdNA3MLyiFkic5nJIOa44zbm5DeyCu3a2H2uKZn91cUsi6T0LSB9vtF6/3rJO
         hQoCQBaOxrVhUHuRzs12+Oa8c3iABU/8NLkqcbmji62dKToMn5+mfxzXGoC+Ca8ubGnx
         Ogve8eOrbYGOSKBI4Lc5kgTlZnA9T9UuplHETVh+PjuezU2BkU5fpXZQYJP2NkGO3Q0/
         F55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749511; x=1710354311;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUM81FzZaYB1+q8hTjh77vdQeiiRG/JwjOPLDZjum/8=;
        b=byvzPpQPTI/2AA4dTznpvOuNoM0rY79alGx8Ev8sUkyDLWGYgSabCSzAzO1VBHfQwa
         sqxI5yRRMSFNY+1oqQiPOX5WbxVETTFBakryjjIBJszNBFSG6hv3I3KnmoF1uhEUPutQ
         9N12hIuTiPhQlsHTrCtEztMrwV0JHYowBfAA60+sR1pj7vYZ43XE37lqqVa+hQMum0CW
         WgJhbjnK4mhTJgbVWLDUrGnHU2mH7Qrb55YxE/51bhTSXOEtWIu/Xd3ZZqKPFwS926zx
         +AZcG/hdZw9/PUKttJnjXLhHKKOZf96AA80vKQrIUoFch+sDLXrLMWBVWNpVYV7okAuW
         I5Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXziZx8UY/vaUJQ2n8fNaeiiE9zHmRUr64LiWgVfioqG0WhtD4/yaKUsBEtFD6ATyMK/oSeCEAQBdag8G7Y0zVS8MFq2pc/UA==
X-Gm-Message-State: AOJu0Yy1rM50SNqePZ1GrzJ57BT/TMUK2GC1tOSUwG+FL/PxIFLLBC8v
	O9hRSoz8EExID/gSpGMzybFPooCwP1+dE2MpANhUy9GsXJ+1TP3feDbjXdEtSNe5kPafPXkX+3p
	jCA==
X-Google-Smtp-Source: AGHT+IGqHIJUWrUsfejQErup2Z224PwJZwn/RbIXxQkXJPLPBFMv4l1nRilm/FfAADknSVQZ33UMPS4jncc=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a05:6902:2492:b0:dcb:b9d7:2760 with SMTP id
 ds18-20020a056902249200b00dcbb9d72760mr4211044ybb.13.1709749510558; Wed, 06
 Mar 2024 10:25:10 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:10 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-13-surenb@google.com>
Subject: [PATCH v5 12/37] lib: prevent module unloading if memory is not freed
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
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Skip freeing module's data section if there are non-zero allocation tags
because otherwise, once these allocations are freed, the access to their
code tag would cause UAF.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/codetag.h |  6 +++---
 kernel/module/main.c    | 27 +++++++++++++++++++--------
 lib/codetag.c           | 11 ++++++++---
 3 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/include/linux/codetag.h b/include/linux/codetag.h
index c44f5b83f24d..bfd0ba5c4185 100644
--- a/include/linux/codetag.h
+++ b/include/linux/codetag.h
@@ -35,7 +35,7 @@ struct codetag_type_desc {
 	size_t tag_size;
 	void (*module_load)(struct codetag_type *cttype,
 			    struct codetag_module *cmod);
-	void (*module_unload)(struct codetag_type *cttype,
+	bool (*module_unload)(struct codetag_type *cttype,
 			      struct codetag_module *cmod);
 };
 
@@ -71,10 +71,10 @@ codetag_register_type(const struct codetag_type_desc *desc);
 
 #if defined(CONFIG_CODE_TAGGING) && defined(CONFIG_MODULES)
 void codetag_load_module(struct module *mod);
-void codetag_unload_module(struct module *mod);
+bool codetag_unload_module(struct module *mod);
 #else
 static inline void codetag_load_module(struct module *mod) {}
-static inline void codetag_unload_module(struct module *mod) {}
+static inline bool codetag_unload_module(struct module *mod) { return true; }
 #endif
 
 #endif /* _LINUX_CODETAG_H */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index bf5a4afbe4c5..41c37ad3d16e 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1211,15 +1211,19 @@ static void *module_memory_alloc(unsigned int size, enum mod_mem_type type)
 	return module_alloc(size);
 }
 
-static void module_memory_free(void *ptr, enum mod_mem_type type)
+static void module_memory_free(void *ptr, enum mod_mem_type type,
+			       bool unload_codetags)
 {
+	if (!unload_codetags && mod_mem_type_is_core_data(type))
+		return;
+
 	if (mod_mem_use_vmalloc(type))
 		vfree(ptr);
 	else
 		module_memfree(ptr);
 }
 
-static void free_mod_mem(struct module *mod)
+static void free_mod_mem(struct module *mod, bool unload_codetags)
 {
 	for_each_mod_mem_type(type) {
 		struct module_memory *mod_mem = &mod->mem[type];
@@ -1230,20 +1234,27 @@ static void free_mod_mem(struct module *mod)
 		/* Free lock-classes; relies on the preceding sync_rcu(). */
 		lockdep_free_key_range(mod_mem->base, mod_mem->size);
 		if (mod_mem->size)
-			module_memory_free(mod_mem->base, type);
+			module_memory_free(mod_mem->base, type,
+					   unload_codetags);
 	}
 
 	/* MOD_DATA hosts mod, so free it at last */
 	lockdep_free_key_range(mod->mem[MOD_DATA].base, mod->mem[MOD_DATA].size);
-	module_memory_free(mod->mem[MOD_DATA].base, MOD_DATA);
+	module_memory_free(mod->mem[MOD_DATA].base, MOD_DATA, unload_codetags);
 }
 
 /* Free a module, remove from lists, etc. */
 static void free_module(struct module *mod)
 {
+	bool unload_codetags;
+
 	trace_module_free(mod);
 
-	codetag_unload_module(mod);
+	unload_codetags = codetag_unload_module(mod);
+	if (!unload_codetags)
+		pr_warn("%s: memory allocation(s) from the module still alive, cannot unload cleanly\n",
+			mod->name);
+
 	mod_sysfs_teardown(mod);
 
 	/*
@@ -1285,7 +1296,7 @@ static void free_module(struct module *mod)
 	kfree(mod->args);
 	percpu_modfree(mod);
 
-	free_mod_mem(mod);
+	free_mod_mem(mod, unload_codetags);
 }
 
 void *__symbol_get(const char *symbol)
@@ -2298,7 +2309,7 @@ static int move_module(struct module *mod, struct load_info *info)
 	return 0;
 out_enomem:
 	for (t--; t >= 0; t--)
-		module_memory_free(mod->mem[t].base, t);
+		module_memory_free(mod->mem[t].base, t, true);
 	return ret;
 }
 
@@ -2428,7 +2439,7 @@ static void module_deallocate(struct module *mod, struct load_info *info)
 	percpu_modfree(mod);
 	module_arch_freeing_init(mod);
 
-	free_mod_mem(mod);
+	free_mod_mem(mod, true);
 }
 
 int __weak module_finalize(const Elf_Ehdr *hdr,
diff --git a/lib/codetag.c b/lib/codetag.c
index 54d2828eba25..408062f722ce 100644
--- a/lib/codetag.c
+++ b/lib/codetag.c
@@ -5,6 +5,7 @@
 #include <linux/module.h>
 #include <linux/seq_buf.h>
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
 
 struct codetag_type {
 	struct list_head link;
@@ -206,12 +207,13 @@ void codetag_load_module(struct module *mod)
 	mutex_unlock(&codetag_lock);
 }
 
-void codetag_unload_module(struct module *mod)
+bool codetag_unload_module(struct module *mod)
 {
 	struct codetag_type *cttype;
+	bool unload_ok = true;
 
 	if (!mod)
-		return;
+		return true;
 
 	mutex_lock(&codetag_lock);
 	list_for_each_entry(cttype, &codetag_types, link) {
@@ -228,7 +230,8 @@ void codetag_unload_module(struct module *mod)
 		}
 		if (found) {
 			if (cttype->desc.module_unload)
-				cttype->desc.module_unload(cttype, cmod);
+				if (!cttype->desc.module_unload(cttype, cmod))
+					unload_ok = false;
 
 			cttype->count -= range_size(cttype, &cmod->range);
 			idr_remove(&cttype->mod_idr, mod_id);
@@ -237,6 +240,8 @@ void codetag_unload_module(struct module *mod)
 		up_write(&cttype->mod_lock);
 	}
 	mutex_unlock(&codetag_lock);
+
+	return unload_ok;
 }
 
 #else /* CONFIG_MODULES */
-- 
2.44.0.278.ge034bb2e1d-goog


