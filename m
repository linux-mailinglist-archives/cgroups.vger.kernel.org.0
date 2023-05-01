Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F146F34D0
	for <lists+cgroups@lfdr.de>; Mon,  1 May 2023 19:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbjEARDx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 1 May 2023 13:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbjEARCe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 1 May 2023 13:02:34 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08474210A
        for <cgroups@vger.kernel.org>; Mon,  1 May 2023 09:57:15 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-559f48c530eso34098207b3.0
        for <cgroups@vger.kernel.org>; Mon, 01 May 2023 09:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960200; x=1685552200;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=voe2xx017YXPnsPA1F569u968pU4cdVPLrVyFh58V3A=;
        b=XY3g0fA5IrJ+YzYe2wUQ0ftZyFUg7ny2GrTo3NPiBlk4iPlMC/kY+SH8g6iLrwV+KV
         Xw+if+jca7PJgAtbAXeVriY1aFJ/EteLLOMZx1AdK6gJrXbG1uRZWDO/40Axb4AODOAW
         bu8B0l1k4HzrQxgM9N1NQnABkM6L6EHe4PLk5Qr9MgkaJ72bwWRTz68SbwPhkOTfAlCN
         aIInpOCqjYNQr/7r19P8lUnDyjtSJAnNSRwk6D0bpZ0QASPWz9H1GwXTn8bC79Kr3VsJ
         to3IBoyJHWuDBBn4X4nEQDSitAsGc5WJp6sVno05l5o1QoTuKQpKB8qBzlmM5zczDq7s
         CPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960200; x=1685552200;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=voe2xx017YXPnsPA1F569u968pU4cdVPLrVyFh58V3A=;
        b=jxy5UcuIz26+aPvxxqB9Z26MUiXxtKiClgUCw8GIf9EHYayw8D7ZFPSUwGLyaSRgvM
         Ax3uYBi2gT90jXi5JO/OQsEusTO1y4YmGaVXiqDh3zDVSWyLkBVH2qtoAkoteeVjWhpv
         GsLWvzdQqvr5C/1eC3TrgsyBLo9rKiwWjnNY0TglIk0++uDA0jftL5ShmeDBBff5nu99
         +utakQwgPvvU8KAIwGzyEEBRWAH2WWeYAdoNxq0FprVv7qnIAIWD4GE8Qf2i3P+XHdk3
         Nuolu03lO4V1z0K2fDZrTS10n13j8Bh465WYbpt5ur8egDk+ZNbr0AnqeL1y85CM8+v6
         cVXQ==
X-Gm-Message-State: AC+VfDz7Q7QBQ2S/7MPBarri2jznfoDoFEyYOiAfjrpZb4so7Plf3Q2+
        QVMe2rr574EEQRHwkyQ1+njhvkCREFg=
X-Google-Smtp-Source: ACHHUZ7TphX74FdXdGj2KrrIAly5W9cbCjXqr70LC9E11i/xFawgHPr35IiqOdTvLYzAxeQM5sfRxSe2CSI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a81:de0c:0:b0:559:e97a:cb21 with SMTP id
 k12-20020a81de0c000000b00559e97acb21mr4262900ywj.9.1682960199781; Mon, 01 May
 2023 09:56:39 -0700 (PDT)
Date:   Mon,  1 May 2023 09:54:50 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-41-surenb@google.com>
Subject: [PATCH 40/40] MAINTAINERS: Add entries for code tagging and memory
 allocation profiling
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        corbet@lwn.net, void@manifault.com, peterz@infradead.org,
        juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        surenb@google.com, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Kent Overstreet <kent.overstreet@linux.dev>

The new code & libraries added are being maintained - mark them as such.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 MAINTAINERS | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3889d1adf71f..6f3b79266204 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5116,6 +5116,13 @@ S:	Supported
 F:	Documentation/process/code-of-conduct-interpretation.rst
 F:	Documentation/process/code-of-conduct.rst
 
+CODE TAGGING
+M:	Suren Baghdasaryan <surenb@google.com>
+M:	Kent Overstreet <kent.overstreet@linux.dev>
+S:	Maintained
+F:	include/linux/codetag.h
+F:	lib/codetag.c
+
 COMEDI DRIVERS
 M:	Ian Abbott <abbotti@mev.co.uk>
 M:	H Hartley Sweeten <hsweeten@visionengravers.com>
@@ -11658,6 +11665,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
 F:	drivers/video/backlight/ktz8866.c
 
+LAZY PERCPU COUNTERS
+M:	Kent Overstreet <kent.overstreet@linux.dev>
+S:	Maintained
+F:	include/linux/lazy-percpu-counter.h
+F:	lib/lazy-percpu-counter.c
+
 L3MDEV
 M:	David Ahern <dsahern@kernel.org>
 L:	netdev@vger.kernel.org
@@ -13468,6 +13481,15 @@ F:	mm/memblock.c
 F:	mm/mm_init.c
 F:	tools/testing/memblock/
 
+MEMORY ALLOCATION PROFILING
+M:	Suren Baghdasaryan <surenb@google.com>
+M:	Kent Overstreet <kent.overstreet@linux.dev>
+S:	Maintained
+F:	include/linux/alloc_tag.h
+F:	include/linux/codetag_ctx.h
+F:	lib/alloc_tag.c
+F:	lib/pgalloc_tag.c
+
 MEMORY CONTROLLER DRIVERS
 M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.40.1.495.gc816e09b53d-goog

