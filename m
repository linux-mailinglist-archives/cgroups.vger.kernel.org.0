Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6130C5F306D
	for <lists+cgroups@lfdr.de>; Mon,  3 Oct 2022 14:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiJCMrY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Oct 2022 08:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiJCMrR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Oct 2022 08:47:17 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF45205E1
        for <cgroups@vger.kernel.org>; Mon,  3 Oct 2022 05:47:14 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 25so6147530lft.9
        for <cgroups@vger.kernel.org>; Mon, 03 Oct 2022 05:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=bbW48lF7w7dqMd3ew4lAUYrRQXOK7chMR3ZlI/inaU4=;
        b=NGoUgbYfYtHEEYsy9dCs1A9gSkbNIQg2VSZnphma6IT1DMIuVPaEqNzqy37pZE9kvf
         B3h0E1O4KOfYhRvqwo0TMWPWdCo3ZYSNABgDYaOfhNSmhPfbKa0t9aVmQQFMO7/mnT7K
         fpUG2XHFQYIyeE8Nob6/UpNH7j/i/9XBYqsfsk0Elum5w90fFoCQLjcTMgtZybM/ByWo
         R2wGU5eW037JUB4mfk6j7/LezcpdYINK3+5dCPf4Edi7t8YLg+s1qpK39i94feFj65br
         R6HnacVAvceG4G3eBlnK2VAE7KVwAAWc8F6mXIcy9BojiZDLzbccZqISrA74KAG6rS7u
         f83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=bbW48lF7w7dqMd3ew4lAUYrRQXOK7chMR3ZlI/inaU4=;
        b=LmQqL+RniOgF8rmnwd7OhjFYqxFsIeGiTFPU+ql2LdK/Ldw3gd4pYEwhzYYuVGUl2P
         7TVpQdSHn3kh4ycF8y9ZhG94JeTi8UkHJ3tZv578kP+eGb04ZKTNnW35NSjhtJ00XUDO
         hDAMYyu70S0tWTYKVpWPx9qthUkQ8JKBNXeqak5+TehtKHO/DG3HjSZkliBVtJw/Sd/G
         Omd+Fl+UoHZIXmc1SqUirXKEdQOeK5vzL5K0d0HI1JVFc+1V2Gr/EnWQJjPCzhgYWxcT
         64ecVyPdJQ6JUf8lxHOJWS2LOTD/3XOpG5gzp7QPcD852RYMF0NBHX0B+6bjz8uiX8Uw
         PwMQ==
X-Gm-Message-State: ACrzQf0DqdO8B6Hz6DOGhJKI8L7m6gyk2C3m3qm+WoYy228YZpOiV137
        TJJUMfieakq7hOQciSSUQh8=
X-Google-Smtp-Source: AMsMyM5kO0YKeK5rgnUvXoxrmYFDf04/f0ZIbTHZOOm5UlTIgYDUorOWUnONufhYfVCnKSPqU9L0Jw==
X-Received: by 2002:ac2:4f03:0:b0:49b:bc01:35d3 with SMTP id k3-20020ac24f03000000b0049bbc0135d3mr6960800lfr.467.1664801233190;
        Mon, 03 Oct 2022 05:47:13 -0700 (PDT)
Received: from ?IPV6:2a02:2168:a11:244b::1? ([2a02:2168:a11:244b::1])
        by smtp.gmail.com with ESMTPSA id bd21-20020a05651c169500b0026c037747bfsm890574ljb.3.2022.10.03.05.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 05:47:12 -0700 (PDT)
Message-ID: <d3cf9c69-19a1-53f9-cf97-5d40ce5cda44@gmail.com>
Date:   Mon, 3 Oct 2022 15:47:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: Possible race in obj_stock_flush_required() vs drain_obj_stock()
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
References: <1664546131660.1777662787.1655319815@gmail.com>
 <Yzc0yZwDB8GG+4t7@P9FQF9L96D.corp.robot.car>
 <b91e75f4-b09c-85aa-c6ad-2364dab9af92@gmail.com>
 <Yzm5cukBe6IfyAs7@P9FQF9L96D.lan>
From:   Alexander Fedorov <halcien@gmail.com>
In-Reply-To: <Yzm5cukBe6IfyAs7@P9FQF9L96D.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 02.10.2022 19:16, Roman Gushchin wrote:
> On Sat, Oct 01, 2022 at 03:38:43PM +0300, Alexander Fedorov wrote:
>> Tested READ_ONCE() patch and it works.
> 
> Thank you!
> 
>> But are rcu primitives an overkill?
>> For me they are documenting how actually complex is synchronization here.
> 
> I agree, however rcu primitives will add unnecessary barriers on hot paths.
> In this particular case most accesses to stock->cached_objcg are done from
> a local cpu, so no rcu primitives are needed. So in my opinion using a
> READ_ONCE() is preferred.

Understood, then here is patch that besides READ_ONCE() also fixes mentioned
use-after-free that exists in 5.10.  In mainline the drain_obj_stock() part
of the patch should be skipped.

Should probably be also Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
but I am not sure if I have rights to add that :)


    mm/memcg: fix race in obj_stock_flush_required() vs drain_obj_stock()
    
    When obj_stock_flush_required() is called from drain_all_stock() it
    reads the `memcg_stock->cached_objcg` field twice for another CPU's
    per-cpu variable, leading to TOCTTOU race: another CPU can
    simultaneously enter drain_obj_stock() and clear its own instance of
    `memcg_stock->cached_objcg`.
    
    Another problem is in drain_obj_stock() which sets `cached_objcg` to
    NULL after freeing which might lead to use-after-free.
    
    To fix it use READ_ONCE() for TOCTTOU problem and also clear the
    `cached_objcg` pointer earlier in drain_obj_stock() for use-after-free
    problem.

Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
Signed-off-by: Alexander Fedorov <halcien@gmail.com>

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c1152f8747..56bd5ea6d3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3197,17 +3197,30 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
 		stock->nr_bytes = 0;
 	}
 
-	obj_cgroup_put(old);
+	/*
+	 * Clear pointer before freeing memory so that
+	 * drain_all_stock() -> obj_stock_flush_required()
+	 * does not see a freed pointer.
+	 */
 	stock->cached_objcg = NULL;
+	obj_cgroup_put(old);
 }
 
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg)
 {
+	struct obj_cgroup *objcg;
 	struct mem_cgroup *memcg;
 
-	if (stock->cached_objcg) {
-		memcg = obj_cgroup_memcg(stock->cached_objcg);
+	/*
+	 * stock->cached_objcg can be changed asynchronously, so read
+	 * it using READ_ONCE(). The objcg can't go away though because
+	 * obj_stock_flush_required() is called from within a rcu read
+	 * section.
+	 */
+	objcg = READ_ONCE(stock->cached_objcg);
+	if (objcg) {
+		memcg = obj_cgroup_memcg(objcg);
 		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
 			return true;
 	}
