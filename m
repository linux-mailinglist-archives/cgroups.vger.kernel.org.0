Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927F368AE97
	for <lists+cgroups@lfdr.de>; Sun,  5 Feb 2023 07:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjBEG6l (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 5 Feb 2023 01:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBEG6k (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 5 Feb 2023 01:58:40 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED292311D;
        Sat,  4 Feb 2023 22:58:30 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 143so6254157pgg.6;
        Sat, 04 Feb 2023 22:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cekXoP31ZR51IJygqDIUgQ8CQ5lvQGcczV3A0ytqEZw=;
        b=jW10FVIllpk2UmObYJXnztvkxz67v4iRh5dx08YuEgB9VxdIzS1XiVDjSsmQZ/yizH
         TIx1w+oPsyzs6CxqC+YnzbcuutuyIhN5hMRGUyh1LBjttodYi0B2ZZ7ar3lCimJPaj9E
         1BuCXvc77bDY99d/CMraUwg0ZxZvNljDPI6nrmwm6bJDgn1eO1VQ7Q5l+ErK1Zqm8Wti
         p0gcJ1/lWqkOpOlYWBY8uXUqPRdXOwG8a+e7bRG3KoE3rsGDtqBUhGUfTvAA305muR+V
         qhM185BVxKKTsWE28gnV1B3jLRF9uIiCIbTh3IgK950jdA8lCIlUdvQqDsNSoPnbMPgJ
         9wKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cekXoP31ZR51IJygqDIUgQ8CQ5lvQGcczV3A0ytqEZw=;
        b=Uf/u+X8A/QulC1FYxS5fu/CQWRybYPkcpBV5TsCORF4wUZ4VSpjdO/AfaK2Lrg6GSl
         5DvwMcwOiJkUpwOFrEqzsEkwlWAGpqjPm3kg7zuwBV0qn+b48E2ozhWlh4LHKeAl8Yjv
         KUolTQ7ylB2OWOJqjiehuwWNbrRx1G3xFd9NOo2uWWGlhoYmr89RXxotEPW+mcos5o7I
         D1Fbd8XAZrb2+DE7TSwTGe5FBo5K5zJX6GU+R05VN+DrSxwOJ/NnsUwq39kvlO39hqw4
         3xG8cAfELxYb7tnlM+fZCm/g5/OjvDzelC5/R0D0YuYTs8gPYQ+5dBhlukuh1oodjlSZ
         BXsQ==
X-Gm-Message-State: AO0yUKUEzzjSymOS+Zt7Z6jQxT+la1Q1ylNRrudGTDVl9EOfN9GvYsSu
        h+buQRQU6JdEjU5KBwVuOKg=
X-Google-Smtp-Source: AK7set8XCAleQGwzei2uSh+f/kpAooHQ+aepCJvOk66z8RfqGTLeVFmSXEcPe1mkxEJEyMs7erfirQ==
X-Received: by 2002:aa7:9af1:0:b0:57a:7140:84ae with SMTP id y17-20020aa79af1000000b0057a714084aemr14810074pfp.9.1675580310103;
        Sat, 04 Feb 2023 22:58:30 -0800 (PST)
Received: from vultr.guest ([2401:c080:1c02:6a5:5400:4ff:fe4b:6fe6])
        by smtp.gmail.com with ESMTPSA id 144-20020a621596000000b00593ce7ebbaasm4596114pfv.184.2023.02.04.22.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 22:58:29 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     tj@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, akpm@linux-foundation.org
Cc:     bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 2/5] bpf: use bpf_map_kvcalloc in bpf_local_storage
Date:   Sun,  5 Feb 2023 06:58:02 +0000
Message-Id: <20230205065805.19598-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230205065805.19598-1-laoar.shao@gmail.com>
References: <20230205065805.19598-1-laoar.shao@gmail.com>
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

Introduce new helper bpf_map_kvcalloc() for this memory allocation. Then
bpf_local_storage will be the same with other map's creation.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
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

