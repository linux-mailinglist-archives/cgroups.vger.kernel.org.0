Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BCF55AAC8
	for <lists+cgroups@lfdr.de>; Sat, 25 Jun 2022 16:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbiFYOEe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 25 Jun 2022 10:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiFYOEc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 25 Jun 2022 10:04:32 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24133263C
        for <cgroups@vger.kernel.org>; Sat, 25 Jun 2022 07:04:30 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z13so9031634lfj.13
        for <cgroups@vger.kernel.org>; Sat, 25 Jun 2022 07:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=P4+NIZh0+FuNtpaxK6+hjjWOuYrxTf6SJFt+dTJJxto=;
        b=j8MthZMi7RVwBJqVMUfnHVHFR5zj5MeoLZOa3BxwPZ1FLgoE9Ys0FlepkG5k1jy0Ar
         1jd1cU1J0OwwcYO1fa3uCSE8SYVa/y2JS27/ypUs79A+KpiOvGdu1RQl3xi074/bc00v
         RL1IGWckKGZwUazwHBZlN6KhGst6eN5PwXkAyTUo0D47JHNUaNg9HxNN5376TXha3PAd
         5zYzFHqepDuzLYgKW6g1dwQ9NhMNJNTEVHNMZjI54ILaUSlAXylzhfvFCOV4dLG4fr1e
         IIFSmh0qjFSp9/y89//v2cWpEP2dIMxPqfFT+OlCWT+2SQWWooWlSouK15V5avd6IEK1
         1cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=P4+NIZh0+FuNtpaxK6+hjjWOuYrxTf6SJFt+dTJJxto=;
        b=cC+V7rz2oEaUgM5Ps2DXimzXLaeKcCha+V3Kpqg4cWDk5b/66H6VBJI3xUzBv69p5Z
         XQCYjwaUI2ZtaOzVZPLs4pFlSCV1CIJ7DZuwGg+OrcjKw0sBamH4G/Wz37zndeCipkpG
         NtLxktpbb6WfQScMWe07h2qTVm168QCgAGyrQLMNk0wPwgfG2cb1MOmjLXrDPcgSnCBY
         Fif7Pv2F+CpdNdp8/Gi1iypFHwllXce12vD6/DSt+N9Tn6Rf7ABJiX7JHQvTrhtE1K7T
         1SM5KvcKGRt6MChrmplgNh/T5GhWFu1nTpgUZj7SrftMkXmG8SvOU2Mjte2YVZwIN1lY
         GffA==
X-Gm-Message-State: AJIora+lkKWiz0WOIZzH/oEc8pk4hwZhOb24kiPXbvVagAizA1+U0Aio
        qe+zxFmgDFeX+B9acI+niNpF/g==
X-Google-Smtp-Source: AGRyM1vvzA7OHUST2zoOuLhvPLwzd5015PjFuqMp1C1gm6IJFiYGxecMnRVRAiJxj5bd42b5p7haMA==
X-Received: by 2002:a05:6512:3f10:b0:47f:42ae:c0fc with SMTP id y16-20020a0565123f1000b0047f42aec0fcmr2471017lfa.688.1656165868465;
        Sat, 25 Jun 2022 07:04:28 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id e14-20020a05651c038e00b0025a7056f4easm669538ljp.85.2022.06.25.07.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 07:04:28 -0700 (PDT)
Message-ID: <c53e1df0-5174-66de-23cc-18797f0b512d@openvz.org>
Date:   Sat, 25 Jun 2022 17:04:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH RFC] memcg: notify about global mem_cgroup_id space depletion
To:     Shakeel Butt <shakeelb@google.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
References: <YrXDV7uPpmDigh3G@dhcp22.suse.cz>
Content-Language: en-US
In-Reply-To: <YrXDV7uPpmDigh3G@dhcp22.suse.cz>
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

Currently host owner is not informed about the exhaustion of the
global mem_cgroup_id space. When this happens, systemd cannot
start a new service, but nothing points to the real cause of
this failure.

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 mm/memcontrol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d4c606a06bcd..5229321636f2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5317,6 +5317,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 				 1, MEM_CGROUP_ID_MAX + 1, GFP_KERNEL);
 	if (memcg->id.id < 0) {
 		error = memcg->id.id;
+		pr_notice_ratelimited("mem_cgroup_id space is exhausted\n");
 		goto fail;
 	}
 
-- 
2.36.1

