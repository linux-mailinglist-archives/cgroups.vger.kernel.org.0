Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E99E69229A
	for <lists+cgroups@lfdr.de>; Fri, 10 Feb 2023 16:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjBJPr7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Feb 2023 10:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbjBJPr5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Feb 2023 10:47:57 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8F47073B;
        Fri, 10 Feb 2023 07:47:56 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id s8so3952546pgg.11;
        Fri, 10 Feb 2023 07:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3DzMoNfpXAhki9P1E058MwckxQ0M07ZDtVShvGycKA=;
        b=oZ0tIoXBZYNSfCI21Hayv+qmA7VSMOoMMOB6Lb5LFDSNKWa5ZA1OvywGXFbCWh8rAn
         fveeyllUwSACZz2OlzAqiEo59qwmLf7GZhgB7W3iSPCLWMmsW6NA4ZnSXreyGxulD3/y
         9BMmX3XJwetCzbqJ0iYfMiIavh+R1uAh+K3hErbzqpOKmoIYaCalasRZ8UQ2h7L6Ne2i
         nkGZnjmlwKEJDDtCSqQOZJFTk3tODlmIZL5QpGwW6jhKIrJzTnsshBKamVpjVcGittNQ
         6qyTM5pH4ToQwYnaUukshYiUudfoiKYDUGugo9i8aciEhz/+nkNDHKspgmXIQmp4xwow
         ncQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3DzMoNfpXAhki9P1E058MwckxQ0M07ZDtVShvGycKA=;
        b=uKiBu1tniC6Xdkv5d57mXf/koWHG0bFeBdFNT/KJHgoPvtTuxwBsek8octa2pQ60Rh
         ESS5hWMZgIyLHLzFXZiqNHNg3SJ7vsn7Z2p3y4nZZvlvIjZYMN0ssYOZAnl78Jf21/F1
         yYKKUtvv4zP/fPjCdN5MqLJAltAltTM4SvKDw9V3d275XWTNTY5tKPWpWguZhPmWie6C
         HiVrmtWnB035zGJGRJGYJxQxSQxWYpuZJaAT1rDt2T3AFUfjfs6WergmvReEuQIyBP8c
         59lpZPdP3EXjBACluSQcD7oJ6EVzaO2VJfmKEHpIag7VsGxgLKYNRHOgxEyVoChlHvyB
         Cg9g==
X-Gm-Message-State: AO0yUKU3BjEA+BDes/4HkNYgkFxzvVnJ1zHNkCy/db/jzo2c5OT+0J/T
        wmdqV1jlv8Mlo2rj36pvAfE=
X-Google-Smtp-Source: AK7set/wDZlxvee4YGZQEWH6VZZuQhWxaDntwzaB44hF8rNeick+jUa8cfDxbgwrQy6oPT1YaThwYg==
X-Received: by 2002:a62:380b:0:b0:5a8:58b5:bfa9 with SMTP id f11-20020a62380b000000b005a858b5bfa9mr5165943pfa.12.1676044075752;
        Fri, 10 Feb 2023 07:47:55 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7001:2f6a:5400:4ff:fe4c:e050])
        by smtp.gmail.com with ESMTPSA id t20-20020aa79394000000b005921c46cbadsm3520069pfe.99.2023.02.10.07.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 07:47:55 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     tj@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, akpm@linux-foundation.org
Cc:     bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 2/4] bpf: use bpf_map_kvcalloc in bpf_local_storage
Date:   Fri, 10 Feb 2023 15:47:32 +0000
Message-Id: <20230210154734.4416-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230210154734.4416-1-laoar.shao@gmail.com>
References: <20230210154734.4416-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Introduce new helper bpf_map_kvcalloc() for the memory allocation in
bpf_local_storage(). Then the allocation will charge the memory from the
map instead of from current, though currently they are the same thing as
it is only used in map creation path now. By charging map's memory into
the memcg from the map, it will be more clear.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/bpf.h            |  8 ++++++++
 kernel/bpf/bpf_local_storage.c |  4 ++--
 kernel/bpf/syscall.c           | 15 +++++++++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 35c18a9..fe0bf48 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1886,6 +1886,8 @@ int  generic_map_delete_batch(struct bpf_map *map,
 void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
 			   int node);
 void *bpf_map_kzalloc(const struct bpf_map *map, size_t size, gfp_t flags);
+void *bpf_map_kvcalloc(struct bpf_map *map, size_t n, size_t size,
+		       gfp_t flags);
 void __percpu *bpf_map_alloc_percpu(const struct bpf_map *map, size_t size,
 				    size_t align, gfp_t flags);
 #else
@@ -1902,6 +1904,12 @@ void __percpu *bpf_map_alloc_percpu(const struct bpf_map *map, size_t size,
 	return kzalloc(size, flags);
 }
 
+static inline void *
+bpf_map_kvcalloc(struct bpf_map *map, size_t n, size_t size, gfp_t flags)
+{
+	return kvcalloc(n, size, flags);
+}
+
 static inline void __percpu *
 bpf_map_alloc_percpu(const struct bpf_map *map, size_t size, size_t align,
 		     gfp_t flags)
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 373c3c2..35f4138 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -568,8 +568,8 @@ static struct bpf_local_storage_map *__bpf_local_storage_map_alloc(union bpf_att
 	nbuckets = max_t(u32, 2, nbuckets);
 	smap->bucket_log = ilog2(nbuckets);
 
-	smap->buckets = kvcalloc(sizeof(*smap->buckets), nbuckets,
-				 GFP_USER | __GFP_NOWARN | __GFP_ACCOUNT);
+	smap->buckets = bpf_map_kvcalloc(&smap->map, sizeof(*smap->buckets),
+					 nbuckets, GFP_USER | __GFP_NOWARN);
 	if (!smap->buckets) {
 		bpf_map_area_free(smap);
 		return ERR_PTR(-ENOMEM);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index bcc9761..9d94a35 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -464,6 +464,21 @@ void *bpf_map_kzalloc(const struct bpf_map *map, size_t size, gfp_t flags)
 	return ptr;
 }
 
+void *bpf_map_kvcalloc(struct bpf_map *map, size_t n, size_t size,
+		       gfp_t flags)
+{
+	struct mem_cgroup *memcg, *old_memcg;
+	void *ptr;
+
+	memcg = bpf_map_get_memcg(map);
+	old_memcg = set_active_memcg(memcg);
+	ptr = kvcalloc(n, size, flags | __GFP_ACCOUNT);
+	set_active_memcg(old_memcg);
+	mem_cgroup_put(memcg);
+
+	return ptr;
+}
+
 void __percpu *bpf_map_alloc_percpu(const struct bpf_map *map, size_t size,
 				    size_t align, gfp_t flags)
 {
-- 
1.8.3.1

