Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E9155B524
	for <lists+cgroups@lfdr.de>; Mon, 27 Jun 2022 04:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiF0CNA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 26 Jun 2022 22:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiF0CM7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 26 Jun 2022 22:12:59 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDB32739
        for <cgroups@vger.kernel.org>; Sun, 26 Jun 2022 19:12:58 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id j21so14201818lfe.1
        for <cgroups@vger.kernel.org>; Sun, 26 Jun 2022 19:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=J1m6KgphNIic/L8WHuZiss6XcSSiZCMzYR1UJoO0HMc=;
        b=Kxte3o580Pu1piGMd/tMaeKLcaYVnazjes2jkA1MeRbEVwuAjE11CCbYmYRlNLpsTw
         ouDSlFLtVKYo+Ypvn/e4PTGdQBuBZSF8EMqVPtqqJKVIpYXcBsUFENRymu17f8RNCuqY
         Pm/82bhd295KDLa0ilJFqdTMh4JkoC+poaMfMlNN2V80LjCvpchBMl+H7N8FrRyJPJh+
         nTSBgMNVuORpGb3zfKVzKxBUE8bd8rfxtdIgZUi1lUKL4fUx6ppsM0QVQldCU+CnZYsd
         ZJteSZJMdcqSyoMY+ubnkpFtWTm+0VbsbNradd5tM5mDISvt1wyV+NF6yVISG4BfRLXj
         XbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=J1m6KgphNIic/L8WHuZiss6XcSSiZCMzYR1UJoO0HMc=;
        b=Vp2be0dVBfnPHmffnGx5YT1eO8EGHvjeCgrZoCLtZrfL2c0NJ3MfvcRpdCxq9T3EAh
         mnNw3WLLa1wg+bbEZHsFbOt595Mn6BCzlg2AiOqmVqKLrKmIwNiMoY8gt7fOE8gNzwGY
         w+Ux5SPwIuhAIrhDxeBo3Ubr+Lzc9+6hxQGcyy/ROZD2eHCrJ7t1suNnRj+Ql+3brOaL
         8DohFjec8WS0zpe53qT/CUUqnpowAIdVIuMlHF1p6mTus2SYuBxvCLHxK2yqotf5gz74
         Yb+ctaNjXBwdt+D9ZJ5uI5HS3TwUX3UXDX6orxAS/xwExASrXFNLr9if9d4c1zMV+T24
         IfFg==
X-Gm-Message-State: AJIora+VCt3VE6eNsH+5o8tLkITSFWBKLFmriO/x5MB215GSS1dLboU/
        A7L8l8xfUysDZ5rkIG+NOAw5ng==
X-Google-Smtp-Source: AGRyM1vr0Ly7U9f3BihWY/5DMiX9z0MJzNTrfnMnO4tWxm9I/+S2YyaWNHAxkerzErA1L2jM03KzDg==
X-Received: by 2002:a05:6512:1288:b0:47f:b7a6:221d with SMTP id u8-20020a056512128800b0047fb7a6221dmr7602818lfs.236.1656295976649;
        Sun, 26 Jun 2022 19:12:56 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id g20-20020a2ea4b4000000b002554f044e1asm1206501ljm.116.2022.06.26.19.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 19:12:56 -0700 (PDT)
Message-ID: <d8a9e9c6-856e-1502-95ac-abf9700ff568@openvz.org>
Date:   Mon, 27 Jun 2022 05:12:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH cgroup] cgroup: set the correct return code if hierarchy
 limits are reached
To:     Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
References: <186d5b5b-a082-3814-9963-bf57dfe08511@openvz.org>
Content-Language: en-US
In-Reply-To: <186d5b5b-a082-3814-9963-bf57dfe08511@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When cgroup_mkdir reaches the limits of the cgroup hierarchy, it should
not return -EAGAIN, but instead react similarly to reaching the global
limit.

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1be0f81fe8e1..243239553ea3 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5495,7 +5495,7 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
 		return -ENODEV;
 
 	if (!cgroup_check_hierarchy_limits(parent)) {
-		ret = -EAGAIN;
+		ret = -ENOSPC;
 		goto out_unlock;
 	}
 
-- 
2.36.1

