Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACC667AB02
	for <lists+cgroups@lfdr.de>; Wed, 25 Jan 2023 08:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbjAYHhC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Jan 2023 02:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235134AbjAYHgx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Jan 2023 02:36:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4AB4A209
        for <cgroups@vger.kernel.org>; Tue, 24 Jan 2023 23:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674632161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i0PZh+yTsPG9Po4mo5Kh71H2anPuGxn31rIFI1zWHXw=;
        b=cEhyx4CVXxxP7oH0boIAzIj4YO3rZjYnryslJLa+Rx9MeLb9JMXiId3qKVrxhU4KnBgREv
        7K3uhEBsjOWnFhkMrwB0T5Lhjdwfn4Bq4OY54//l4L/BTbTEMWU+i4sFlixT6KhRDdUA9L
        NmsUkmfMGPPcqhFYN34dGmk6OHu5h/g=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-52-YZNm7n37NTS5lR0JR2C-2A-1; Wed, 25 Jan 2023 02:36:00 -0500
X-MC-Unique: YZNm7n37NTS5lR0JR2C-2A-1
Received: by mail-ot1-f70.google.com with SMTP id cj23-20020a056830641700b00686e1aed2e4so2234136otb.8
        for <cgroups@vger.kernel.org>; Tue, 24 Jan 2023 23:35:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0PZh+yTsPG9Po4mo5Kh71H2anPuGxn31rIFI1zWHXw=;
        b=s3z1W0uDLt8o7STdyifo6+Lue7/NoffCDLsXNRhFsyxkTJG6nZ1SYn6BYT7PzsMnjV
         zg3kGOeP4lw1rO2ki73baZZzKdwa+T9cUP5+FKNOpbOX7gRHXA6ZD+LEKggEsZ3akIRP
         7cxC2reJP/bI8HKBtjUEweFaLDba92msI3S3IaPZ4W6/Cjzo8SHYCYtMrnHU5q04Hd1b
         aA7lPqmD+hV17h9O4Hy42DEH4B4agS4lUhfxHKorWgEF4Pdvvz0E61c/RdMjoifPw00O
         uTs/E19kVohy7qA8bP6zcBPuGQ7khyJdUhPZSXWeAmmANT1oPqnjXbOdkfTagdk1lG3+
         m21g==
X-Gm-Message-State: AO0yUKUnk8QgWJWousVnr017qGuG6PXIv3FsC4wUuykaOdHVCHSQwxmj
        ViaKAzWivYGD64wb7bIPQK6nUueSTO0guWwoTyP4WgEmaUl+xUWB+mF7vg1CDsI/H6GIfIDSGyq
        X7SAQQuONRq1aVurBhQ==
X-Received: by 2002:a05:6870:a788:b0:163:2d2d:beb with SMTP id x8-20020a056870a78800b001632d2d0bebmr1040181oao.26.1674632159219;
        Tue, 24 Jan 2023 23:35:59 -0800 (PST)
X-Google-Smtp-Source: AK7set8+5KjsnMLSgwOG2ncR10Nu23wlcmyAQ1nW0yNjNQg2bEEedKAnOT5WZ8vqhPBMDlxLuA4+1w==
X-Received: by 2002:a05:6870:a788:b0:163:2d2d:beb with SMTP id x8-20020a056870a78800b001632d2d0bebmr1040175oao.26.1674632158988;
        Tue, 24 Jan 2023 23:35:58 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a800:14fa:9361:c141:6c70:c877])
        by smtp.gmail.com with ESMTPSA id x189-20020a4a41c6000000b0050dc79bb80esm1538802ooa.27.2023.01.24.23.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 23:35:58 -0800 (PST)
From:   Leonardo Bras <leobras@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Leonardo Bras <leobras@redhat.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] mm/memcontrol: Reorder memcg_stock_pcp members to avoid holes
Date:   Wed, 25 Jan 2023 04:35:00 -0300
Message-Id: <20230125073502.743446-4-leobras@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125073502.743446-1-leobras@redhat.com>
References: <20230125073502.743446-1-leobras@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In 64-bit architectures, the current layout of memcg_stock_pcp should look
like this:

struct memcg_stock_pcp {
        spinlock_t                 stock_lock;           /*     0     4 */
        /* 4 bytes hole */
        struct mem_cgroup *        cached;               /*     8     8 */
        unsigned int               nr_pages;             /*    16     4 */
        /* 4 bytes hole */
	[...]
};

This happens because pointers will have 8 bytes (64-bit) and ints will have
4 bytes.

Those 2 holes are avoided if we reorder nr_pages and cached,
effectivelly putting nr_pages in the first hole, and saving 8 bytes.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1d5c108413c83..373fa78c4d881 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2173,8 +2173,8 @@ void unlock_page_memcg(struct page *page)
 
 struct memcg_stock_pcp {
 	spinlock_t stock_lock; /* Protects the percpu struct */
-	struct mem_cgroup *cached; /* this never be root cgroup */
 	unsigned int nr_pages;
+	struct mem_cgroup *cached; /* this never be root cgroup */
 
 #ifdef CONFIG_MEMCG_KMEM
 	struct obj_cgroup *cached_objcg;
-- 
2.39.1

