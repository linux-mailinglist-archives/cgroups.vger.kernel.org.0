Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF156BB0B4
	for <lists+cgroups@lfdr.de>; Wed, 15 Mar 2023 13:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjCOMUk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Mar 2023 08:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjCOMUL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Mar 2023 08:20:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD4487379
        for <cgroups@vger.kernel.org>; Wed, 15 Mar 2023 05:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678882755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2PRbwpAoEnOZK1WgHwlMyMBfG9nGKa4R9Y3iK9sv+Ts=;
        b=Y+tBqveNFkCebtVM4gYrrG2SGgqWwvmUO35LwZnrKiijncu5JgZeIOPiWW9AMo03pzySsS
        w2d7NMr40pM99rtR18P+xY1wMVXJfAL5Fq93Jt4gu+3g6MpbDKfxsGIPigLPe4rJecym2C
        p/DATnOJeUIke9vNCORpCO1liIFvNzE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-awVfK6tJPquavdnPT5b8hA-1; Wed, 15 Mar 2023 08:19:14 -0400
X-MC-Unique: awVfK6tJPquavdnPT5b8hA-1
Received: by mail-qv1-f72.google.com with SMTP id q1-20020ad44341000000b005a676b725a2so5957095qvs.18
        for <cgroups@vger.kernel.org>; Wed, 15 Mar 2023 05:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678882753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PRbwpAoEnOZK1WgHwlMyMBfG9nGKa4R9Y3iK9sv+Ts=;
        b=TAq1xCApe0kSnf/nChU83IuPB/AaZn+RYb3y0X8sFtFPh3gS1eEBL2rpzFOPIQazeR
         DKj+45Si7C3cOZfmh8NcDf7I+f9bZUUgH/lNyzteaHgvk+k5s1XDtAXaOEW8ZNw6pDuu
         94bPaiwif0hyFexJuG5FvImjj9kt9hM/ceV3vs/Fcf3o2GLeQYgqnEqum2X1M2GbAW7m
         V6+cg2RRLSzQZuAU0Aw9gBiv1tcj6hBAt6SNOyZZiapILbtYqIJj1JAAJ70t29WnHcn6
         ZGPlBMxDiSz7/eetr26K7ifzJGStFwz2g6FVCMLykxJVkF5XREhPFANA7NEBFlhsc961
         T0TQ==
X-Gm-Message-State: AO0yUKW3Ka+xMsJLKLllc7qDu3NnkfkeW1TtHDiBQtFbM2PzzIss/cTN
        7rI336jo7QLJmswaU5KHnyQmB9yvbslBSOI5y5ftMNwSwlgJtKGODUPYR9O5aVQTZRB/rC9YPFC
        dx+05reCPqnvBdBvnPA==
X-Received: by 2002:ac8:7f4d:0:b0:3b9:a441:37f4 with SMTP id g13-20020ac87f4d000000b003b9a44137f4mr69515106qtk.52.1678882752880;
        Wed, 15 Mar 2023 05:19:12 -0700 (PDT)
X-Google-Smtp-Source: AK7set95YdMrNVK6tuMn7EYZw7rYKlJSLXs7KyFChGj5Sxcw5WbC8bIXA9Fzp2upKtYbW3ZnEHALwQ==
X-Received: by 2002:ac8:7f4d:0:b0:3b9:a441:37f4 with SMTP id g13-20020ac87f4d000000b003b9a44137f4mr69515075qtk.52.1678882752606;
        Wed, 15 Mar 2023 05:19:12 -0700 (PDT)
Received: from localhost.localdomain.com ([2a00:23c6:4a21:6f01:ac73:9611:643a:5397])
        by smtp.gmail.com with ESMTPSA id f11-20020ac8014b000000b003bd21323c80sm3672595qtg.11.2023.03.15.05.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 05:19:12 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [RFC PATCH 3/3] cgroup/cpuset: Iterate only if DEADLINE tasks are present
Date:   Wed, 15 Mar 2023 12:18:12 +0000
Message-Id: <20230315121812.206079-4-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315121812.206079-1-juri.lelli@redhat.com>
References: <20230315121812.206079-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

update_tasks_root_domain currently iterates over all tasks even if no
DEADLINE task is present on the cpuset/root domain for which bandwidth
accounting is being rebuilt. This has been reported to introduce 10+ ms
delays on suspend-resume operations.

Skip the costly iteration for cpusets that don't contain DEADLINE tasks.

Reported-by: Qais Yousef <qyousef@layalina.io>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/cgroup/cpuset.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 57bc60112618..f46192d2e97e 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1090,6 +1090,9 @@ static void update_tasks_root_domain(struct cpuset *cs)
 	struct css_task_iter it;
 	struct task_struct *task;
 
+	if (cs->nr_deadline_tasks == 0)
+		return;
+
 	css_task_iter_start(&cs->css, 0, &it);
 
 	while ((task = css_task_iter_next(&it)))
-- 
2.39.2

