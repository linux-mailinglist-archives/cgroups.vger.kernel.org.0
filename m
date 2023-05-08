Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1A46FA1C3
	for <lists+cgroups@lfdr.de>; Mon,  8 May 2023 10:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbjEHIAW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 8 May 2023 04:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjEHIAS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 8 May 2023 04:00:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF025203D4
        for <cgroups@vger.kernel.org>; Mon,  8 May 2023 00:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683532757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Do5cxKLb8h80paBttvd+Pmn2/iiZatJNSZpVANHwiHM=;
        b=YznHsA1WSKaV8k7t12U8xCbwkenGt4VeIdR7stO4p26AgMzCFShKEnIzefsyD40Gwd3qK1
        oCXgE/tTe0zRXRpuAdZD9KkshQiA/I/i4VmLDP7sW3aCbPI9R1GfKA81NaSQTmhLSAOCd6
        B8mSWAzjC7OGbZTagTZG7+Ay7FzUoNo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-hbXKP639O2ix6YZFHA_CmA-1; Mon, 08 May 2023 03:59:16 -0400
X-MC-Unique: hbXKP639O2ix6YZFHA_CmA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f421cfb4beso4756095e9.0
        for <cgroups@vger.kernel.org>; Mon, 08 May 2023 00:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683532755; x=1686124755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Do5cxKLb8h80paBttvd+Pmn2/iiZatJNSZpVANHwiHM=;
        b=IGlfGXzEEFVeJ3eY8/Ct9rnrO1APwQsoIQNwtueIDWTnCFW+HymZ9Z5U2LhULrGwKk
         OYVxNtfg+mM0iPx6S/Qu+HUo5wO7qdqerO4UD4JUk05ErFiPfDsdOuYQGaE/6KGl2Fta
         Ijgjduse/12sBJY112n9X7f7NOOTDhcvL3vq1S3vkXMBhAPAz2pK5wMBOQW5klYbkLuf
         RA3IiLo7hD4BGoVBX89ioGjBcdVNgPggu+GU5++kPHmcDxodVBxiMbR8V7X4KSoNoALE
         C8a3Otwm4NO2hEXyGL35STrnrQyv26pUfA5G9u4ujuUdBplDbNnTUm+oUKg+qz7dy8NN
         lAbg==
X-Gm-Message-State: AC+VfDzBC4Baxe0SyAIHiv4CD9Lwn7ajMGA4ejxUHF2+RojNQA8//wGk
        hdMC691RALAaKaPyal1SqMrmQ4kKNtK7o/D3BAku57OWIj2XSMC22Q+CrySAmu+trzk7YbJ+uTp
        lyPG9TG8/3Xrj7gCA4A==
X-Received: by 2002:a05:600c:2055:b0:3f1:74c3:3c51 with SMTP id p21-20020a05600c205500b003f174c33c51mr6675877wmg.35.1683532754956;
        Mon, 08 May 2023 00:59:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5v14zKFo1pDg4Wh9qV7TE7jGoda/WgLtlS5cHxbXYtBW1ITXfsgw5+X8in60Yf0lXwCpjuaQ==
X-Received: by 2002:a05:600c:2055:b0:3f1:74c3:3c51 with SMTP id p21-20020a05600c205500b003f174c33c51mr6675845wmg.35.1683532754642;
        Mon, 08 May 2023 00:59:14 -0700 (PDT)
Received: from localhost.localdomain.com ([176.206.13.250])
        by smtp.gmail.com with ESMTPSA id f8-20020a7bcd08000000b003f42894ebe2sm250423wmj.23.2023.05.08.00.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 00:59:14 -0700 (PDT)
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
Subject: [PATCH v3 4/6] cgroup/cpuset: Iterate only if DEADLINE tasks are present
Date:   Mon,  8 May 2023 09:58:52 +0200
Message-Id: <20230508075854.17215-5-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508075854.17215-1-juri.lelli@redhat.com>
References: <20230508075854.17215-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
Link: https://lore.kernel.org/lkml/20230206221428.2125324-1-qyousef@layalina.io/
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 968a49024871..c7a346cfdd8d 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1092,6 +1092,9 @@ static void dl_update_tasks_root_domain(struct cpuset *cs)
 	struct css_task_iter it;
 	struct task_struct *task;
 
+	if (cs->nr_deadline_tasks == 0)
+		return;
+
 	css_task_iter_start(&cs->css, 0, &it);
 
 	while ((task = css_task_iter_next(&it)))
-- 
2.40.1

