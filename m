Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F11523A50
	for <lists+cgroups@lfdr.de>; Wed, 11 May 2022 18:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344741AbiEKQ3D (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 May 2022 12:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344740AbiEKQ3B (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 May 2022 12:29:01 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3262380E0
        for <cgroups@vger.kernel.org>; Wed, 11 May 2022 09:28:59 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id m1so2651538qkn.10
        for <cgroups@vger.kernel.org>; Wed, 11 May 2022 09:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vjtbfzb3XfQBK49vkLU2ME+zLfRrW3PO/4LCqkSQxEo=;
        b=4rjytAOgIXa9oPL4+JvWFQPgZx54vdMfMIxW8eljWagpDYXPTR81+XelntW9epHwlY
         DPldjGntjh0a7rjeBqYQVVoujjL/MVQo0nqpIkvAXLC4NlYfuPZdMHZOpF6tz7nxW5x0
         UbHP9qf1gRsOxHo/D6Xrwrt3Q1NPgnfJR50weL9kafzWEeHl1RdJeCc220fvKfdufkVk
         qCmDi88pFnxUC9Hy9C85YGx0KIpbiun+O79f7ude563WJnH2cUkwsB4uCDnUwW3xtpbR
         zIIuXu9o6qjwbfRwtpqi7ZvCHEdEjbASF/jD9PiRkM5GKbJ0F/ZmqKvgO2zwKVfDmVEt
         xQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vjtbfzb3XfQBK49vkLU2ME+zLfRrW3PO/4LCqkSQxEo=;
        b=5EPSthTg53fOmE0BI9PogRxuYVsf6bmYENOWOMLeHP4JEO635OTlKG8/RGGZVYi5t8
         bqw3nkbU84NiFtpkop0KJ/byURItV8dzokRoPOftTQWXrHCYJ+xs4/ugHGOWM+lQiTYc
         JrHCn0DE8KfSeQAHqNOofmGCrm1voTEbOri2SD872lOs/VYN7H/Bvp0a5KKUaCIZp8ot
         H2dZTgsU/LvDDbnMqdpTPS1ehlhSs18Kc1N6c9LoJT2qfFtU3lxE30VPD4K7RCs9qDlS
         xcddrkovA6YdWL8+oJQnQTJIwNnjVeEOzVndOdiuXiagYbOSQQNYYvDDSRbBQBTPjQYG
         fw9A==
X-Gm-Message-State: AOAM532hJ+JmWT42o/nhUi951YS0NgAlnpfwkmW1YJVN2kel3zoZUo1E
        0rIJ3JEacYGQr1FZ1c2DSntboA==
X-Google-Smtp-Source: ABdhPJxft2gzXlXl71SNi+1b64jFQbBGf7Iu8X2dSHgjCzwPpZHsDPkpt95dPvlqSuT8vGr0Dc2BFg==
X-Received: by 2002:a05:620a:28ca:b0:6a0:a0a9:b2e6 with SMTP id l10-20020a05620a28ca00b006a0a0a9b2e6mr9828094qkp.638.1652286538773;
        Wed, 11 May 2022 09:28:58 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:14fe])
        by smtp.gmail.com with ESMTPSA id cb25-20020a05622a1f9900b002f39b99f6b0sm1461209qtb.74.2022.05.11.09.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 09:28:58 -0700 (PDT)
Date:   Wed, 11 May 2022 12:28:57 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 3/6] mm: Kconfig: group swap, slab, hotplug and thp
 options into submenus
Message-ID: <YnvkSVivfnT57Vwh@cmpxchg.org>
References: <20220510152847.230957-1-hannes@cmpxchg.org>
 <20220510152847.230957-4-hannes@cmpxchg.org>
 <20220510154037.c7916ee9d7de90eedd12f92c@linux-foundation.org>
 <YnvU0hwCfQ11P8Ce@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnvU0hwCfQ11P8Ce@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 11, 2022 at 11:22:59AM -0400, Johannes Weiner wrote:
> On Tue, May 10, 2022 at 03:40:37PM -0700, Andrew Morton wrote:
> > On Tue, 10 May 2022 11:28:44 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> > 
> > > There are several clusters of related config options spread throughout
> > > the mostly flat MM submenu. Group them together and put specialization
> > > options into further subdirectories to make the MM submenu a bit more
> > > organized and easier to navigate.
> > 
> > Causes
> > 
> > hp2:/usr/src/25> make allnoconfig
> 
> My bad. I'll respin those on top of the others and add allnoconfig
> builds to my testing routine. Thanks.

Actually, this is rather straight-forward to fix in place. This delta
for 3/6 takes care of both warnings:

---
From 2b5fcaed2714584b40c7d7f76bdda250aa94b48f Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Wed, 11 May 2022 12:12:37 -0400
Subject: [PATCH] mm: Kconfig: group swap, slab, hotplug and thp options into
 submenus fix

WARNING: unmet direct dependencies detected for ARCH_WANT_GENERAL_HUGETLB
  Depends on [n]: TRANSPARENT_HUGEPAGE [=n]
  Selected by [y]:
  - X86 [=y]

WARNING: unmet direct dependencies detected for ARCH_WANTS_THP_SWAP
  Depends on [n]: TRANSPARENT_HUGEPAGE [=n]
  Selected by [y]:
  - X86 [=y] && X86_64 [=y]

The ARCH_WANT* symbols are selected by the arch to communicate
requests to THP if enabled. Those mustn't be inside the 'if THP' block
for user-visible THP options of course. Move them back out.

Reported-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 2c5935a28edf..c2f4a547ab00 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -692,6 +692,12 @@ config NOMMU_INITIAL_TRIM_EXCESS
 
 	  See Documentation/admin-guide/mm/nommu-mmap.rst for more information.
 
+config ARCH_WANT_GENERAL_HUGETLB
+	bool
+
+config ARCH_WANTS_THP_SWAP
+	def_bool n
+
 menuconfig TRANSPARENT_HUGEPAGE
 	bool "Transparent Hugepage Support"
 	depends on HAVE_ARCH_TRANSPARENT_HUGEPAGE && !PREEMPT_RT
@@ -733,12 +739,6 @@ choice
 	  benefit.
 endchoice
 
-config ARCH_WANT_GENERAL_HUGETLB
-	bool
-
-config ARCH_WANTS_THP_SWAP
-	def_bool n
-
 config THP_SWAP
 	def_bool y
 	depends on TRANSPARENT_HUGEPAGE && ARCH_WANTS_THP_SWAP && SWAP
-- 
2.35.3
