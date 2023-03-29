Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E210C6CD9C6
	for <lists+cgroups@lfdr.de>; Wed, 29 Mar 2023 14:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjC2M5z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Mar 2023 08:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjC2M5s (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Mar 2023 08:57:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FD91995
        for <cgroups@vger.kernel.org>; Wed, 29 Mar 2023 05:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680094610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5nV5Ts2SkJ8UEBvAJl55FmB5KeAii4wSJwG1pfX3s8w=;
        b=A7hjLshLDZbxJpUKPIiiUWZ7bvNCGZRQXxcpf9rU0M2TisuVnYaknxM4Pf1/iASrHTj6gX
        q7O/kjNx8R+4DrhWNo5Q35YImj8fhUfZbvltYepl4oaGFTyhTqoPfraAZIt86MN/3vfrpt
        V7T8WNsAifL1Bhe7FY/vgH9Sx61B6EE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-uwLbknnZPSiFQin2OJ2nKA-1; Wed, 29 Mar 2023 08:56:48 -0400
X-MC-Unique: uwLbknnZPSiFQin2OJ2nKA-1
Received: by mail-qv1-f70.google.com with SMTP id f3-20020a0cc303000000b005c9966620daso6498011qvi.4
        for <cgroups@vger.kernel.org>; Wed, 29 Mar 2023 05:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680094608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nV5Ts2SkJ8UEBvAJl55FmB5KeAii4wSJwG1pfX3s8w=;
        b=hmtvndNpc3UhtKi6qbxuiiDsM55mNnBRvJAwnPKwAGLl8EPoWviX1fxNyOI5RWPRy9
         LD5f3C0WTYcb0enrFSAOK2SDSR4eVD6muYwzsQmsZQyciaki3p9aMNcng7nC5T9Ot2zk
         z8O8MBm6q6pevjFvBkUYkTmlZNX94H7+/4g3fYqo3RLovcR6mGm0F5XNwh+eCLyz8SjR
         PNqZ76deqWQjMtoCUiinpOcwVye4+DFk8p4eU2+hj/KTYGQ6DxokzrKJJzOxtCpoke/B
         wM+/rFYEYqDsT8GSFUdpDgkmdqpzk/4SiPvuLySnIUHcbiQ7CCADCtUrkj8PX54KpgXs
         6eKw==
X-Gm-Message-State: AO0yUKXEo4Mka4d70PpbAV3Lo148fv8oq4TORL+69kRoGS4XaUSc2Wbl
        +EuEbTyUUp7C6a/w3s5+Qv34APoxK+/hcBvLzaOjFdBElMUgzPqNjbbxNLQZlZsZDbx4GlPCzYt
        KYi5giq6dMTh5K8ufXg==
X-Received: by 2002:a05:622a:647:b0:3bf:d9ee:882d with SMTP id a7-20020a05622a064700b003bfd9ee882dmr31368146qtb.40.1680094608253;
        Wed, 29 Mar 2023 05:56:48 -0700 (PDT)
X-Google-Smtp-Source: AK7set83m6ZzVM34kY1u32+kqOBpKNnVee7yjMSmeTfMNGq1oY16x+fOXLrQBMuAPX3spNrTz+DFbQ==
X-Received: by 2002:a05:622a:647:b0:3bf:d9ee:882d with SMTP id a7-20020a05622a064700b003bfd9ee882dmr31368117qtb.40.1680094607962;
        Wed, 29 Mar 2023 05:56:47 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.151.163])
        by smtp.gmail.com with ESMTPSA id c23-20020a379a17000000b007436d0e9408sm13527134qke.127.2023.03.29.05.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 05:56:47 -0700 (PDT)
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
Subject: [PATCH 6/6] cgroup/cpuset: Iterate only if DEADLINE tasks are present
Date:   Wed, 29 Mar 2023 14:55:58 +0200
Message-Id: <20230329125558.255239-7-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329125558.255239-1-juri.lelli@redhat.com>
References: <20230329125558.255239-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
Link: https://lore.kernel.org/lkml/20230206221428.2125324-1-qyousef@layalina.io/
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/cgroup/cpuset.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f8ebec66da51..05c0a1255218 100644
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
2.39.2

