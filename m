Return-Path: <cgroups+bounces-16-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B587D524A
	for <lists+cgroups@lfdr.de>; Tue, 24 Oct 2023 15:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44378B212A5
	for <lists+cgroups@lfdr.de>; Tue, 24 Oct 2023 13:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB762B76A;
	Tue, 24 Oct 2023 13:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mdQU02L1"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655462B74A
	for <cgroups@vger.kernel.org>; Tue, 24 Oct 2023 13:46:55 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B65D7A
	for <cgroups@vger.kernel.org>; Tue, 24 Oct 2023 06:46:53 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7d261a84bso61822327b3.3
        for <cgroups@vger.kernel.org>; Tue, 24 Oct 2023 06:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155212; x=1698760012; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r9ZaCKU38kmyhI7VEwX4KjtHXLgRMjapTHFgQ9SG6t0=;
        b=mdQU02L1CvfERziAV1S4IWGZDX7irUzrH657u0xJG/54by6a1PhBxsUviX5Pwjua/T
         tyX9oRC7TJS1/NjrQVkH2nEgsfpx1CADvuBwn9rmhdGH32e419ZbVLElz2vF7W3PzB/0
         wGACZwKxOG0lbxY6tgKksbxYI5qC4gKYNecyeBklDKUcA5HA0g5v9hWgSXg2KtLeQm7n
         vRt2tiqzDBTxDPdAhfQ0TO87X+AvbN61YbzpDPWOBQCokVInUWM4EbBMbG0vl1CUfoOG
         Ph4KI8dy0JXLh6ycauQ1HOyH+AF3xuT/aVX18YoM0St6IHTjmP0OR/HnLbDMkTt2f40p
         auRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155212; x=1698760012;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r9ZaCKU38kmyhI7VEwX4KjtHXLgRMjapTHFgQ9SG6t0=;
        b=ULZ6DND3dAimd6ItdecyG3t3dOu1TReJobwWWRnOlG9WQQcpnXvsSNq88Oa0yPXtZk
         r9NHbYjorTXDZntP+cJKbffWT3S/OfMSefFxJlet4ImcVvA77LI8toMwilBGv3jDvhQ7
         4EHL925P100TppLzZkBgissnZuO5N6y/g83/1EDKL/+KsYGdTchg6YIOua4iGy2Kr43v
         cebOPhR79PviUt1FhjNqrgnLHddNEB9W0u2kioTs0bXMGouERJTgV7SOZrp9pmLANL4+
         9uZ8px+grvZYGeBb+1Xk1GdcBNxmOOyOEvK5xOtnMCwYp2znY7vmlQ9JOX0/jDdqYBQ1
         BDsQ==
X-Gm-Message-State: AOJu0YzhklmswzZ0sRvhgdeJmQ1LE4pGLRHXS4D71KTA3VTVNRVBmcyp
	WxR0F1hS+cufFSi8zjGc1lAtfCTO11A=
X-Google-Smtp-Source: AGHT+IFUpFLBsDMNDQVhWCjHvEp+oEK06bmA8hZB4NpLCdYe9bJ3XL90v8R51rmnjDRHAZifNxDo+IuLmGU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a0d:dfd0:0:b0:5a7:ad67:b4b6 with SMTP id
 i199-20020a0ddfd0000000b005a7ad67b4b6mr254303ywe.2.1698155212529; Tue, 24 Oct
 2023 06:46:52 -0700 (PDT)
Date: Tue, 24 Oct 2023 06:46:02 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-6-surenb@google.com>
Subject: [PATCH v2 05/39] prandom: Remove unused include
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

From: Kent Overstreet <kent.overstreet@linux.dev>

prandom.h doesn't use percpu.h - this fixes some circular header issues.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/prandom.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/prandom.h b/include/linux/prandom.h
index f2ed5b72b3d6..f7f1e5251c67 100644
--- a/include/linux/prandom.h
+++ b/include/linux/prandom.h
@@ -10,7 +10,6 @@
 
 #include <linux/types.h>
 #include <linux/once.h>
-#include <linux/percpu.h>
 #include <linux/random.h>
 
 struct rnd_state {
-- 
2.42.0.758.gaed0368e0e-goog


