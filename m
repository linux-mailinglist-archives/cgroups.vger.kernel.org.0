Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA21F4CE27C
	for <lists+cgroups@lfdr.de>; Sat,  5 Mar 2022 04:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiCEDmL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 4 Mar 2022 22:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiCEDmL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 4 Mar 2022 22:42:11 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81510229C89
        for <cgroups@vger.kernel.org>; Fri,  4 Mar 2022 19:41:18 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id ay5so9419200plb.1
        for <cgroups@vger.kernel.org>; Fri, 04 Mar 2022 19:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g3T8Wrd1J7uGYe15NcawUAYKxW858bm+7idoDqUxKYI=;
        b=MyaYOjbzKClchfYsPyWtaapwj4xAq3tSb4HBkNNsRnhNYZTuEomnmeMB4qHMTVEYLf
         u7IYfAxFrljMrpJ5U148gK8VLJL8mZSazH5MslieGV4nb3kyeUTiGa7Le9jFztpUzjPK
         /hFELLvBajcg0wrFpUDLEEcuWt67POL2MCKy4HISQ5W20yghK4E1lQto1s/O6WhNLUml
         x2J/ZSdWA4XoA655TSnAWldBccQGT4aQZt8nvqrNXarkACbhsq73irzwEX68lHfzexAs
         UfWnSYy8uEi56AwIIHiEHgvVM2lzs7CBRtb0eAmi3EwVdwpMJSA6Xu5kZ53n6czbV3An
         tJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g3T8Wrd1J7uGYe15NcawUAYKxW858bm+7idoDqUxKYI=;
        b=sZqVHjRHO8gYVSR+KmOI+mI285gst13B2WSF+/Qmp/V30EpsEdea3zAcZt93o3BnaA
         X3x8pX4ZIsshSXSIZDiu/sI5HjXXonTNMhlpQ5VdezXieVLTqbNpyUMPThIzuBwKU0+x
         Y+RCxh31oKrkJU8ISukXrXn02Ay7BT5BtZ654cROcviulAYxfNl4+5c/m6VK96VJ1qk6
         sQL0MC+eYMP3sPTsiyiOYNMZYr6vFGRio8AEMqUpTmjvhd/jkUPUkEsHMgVAxCWh9B5f
         a/GmNVJMzQVs1P5DyRsjxT0EsF3/piByE4AXC+NwmrJx138rcIqt/HRMuy687lZOvViH
         q1iA==
X-Gm-Message-State: AOAM531NWJeI7kNR/t3TV9WFC9Du2n/QcuUaAL3d4jzj0Z2JD2EL1+Q9
        XjPbnwfckrqhNCFipwz1uJM3pQ==
X-Google-Smtp-Source: ABdhPJxvVO84UijMWteTh39H+Sz9+e3LBMyDKw84DqwLeJMQyNDa3ooXBiIpls9IiNWRP8tv+hlaIg==
X-Received: by 2002:a17:903:124a:b0:151:99fe:1a10 with SMTP id u10-20020a170903124a00b0015199fe1a10mr1545897plh.87.1646451678079;
        Fri, 04 Mar 2022 19:41:18 -0800 (PST)
Received: from localhost.localdomain ([2409:8a28:e6d:cc00:d089:89fd:5c33:f12])
        by smtp.gmail.com with ESMTPSA id h5-20020a056a001a4500b004e177b8cbfdsm7360927pfv.197.2022.03.04.19.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 19:41:17 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        peterz@infradead.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        syzbot+16e3f2c77e7c5a0113f9@syzkaller.appspotmail.com,
        Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH linux-next] cgroup: fix suspicious rcu_dereference_check() usage warning
Date:   Sat,  5 Mar 2022 11:41:03 +0800
Message-Id: <20220305034103.57123-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

task_css_set_check() will use rcu_dereference_check() to check for
rcu_read_lock_held() on the read-side, which is not true after commit
dc6e0818bc9a ("sched/cpuacct: Optimize away RCU read lock"). This
commit drop explicit rcu_read_lock(), change to RCU-sched read-side
critical section. So fix the RCU warning by adding check for
rcu_read_lock_sched_held().

Fixes: dc6e0818bc9a ("sched/cpuacct: Optimize away RCU read lock")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Reported-by: syzbot+16e3f2c77e7c5a0113f9@syzkaller.appspotmail.com
Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/cgroup.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 1e356c222756..0d1ada8968d7 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -450,6 +450,7 @@ extern struct mutex cgroup_mutex;
 extern spinlock_t css_set_lock;
 #define task_css_set_check(task, __c)					\
 	rcu_dereference_check((task)->cgroups,				\
+		rcu_read_lock_sched_held() ||				\
 		lockdep_is_held(&cgroup_mutex) ||			\
 		lockdep_is_held(&css_set_lock) ||			\
 		((task)->flags & PF_EXITING) || (__c))
-- 
2.20.1

