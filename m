Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF9C4EB782
	for <lists+cgroups@lfdr.de>; Wed, 30 Mar 2022 02:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241479AbiC3Ath (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Mar 2022 20:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiC3Atg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Mar 2022 20:49:36 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D796F182D9C
        for <cgroups@vger.kernel.org>; Tue, 29 Mar 2022 17:47:52 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id lr4so29967028ejb.11
        for <cgroups@vger.kernel.org>; Tue, 29 Mar 2022 17:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aUg+nsxlXPscnfiMYKd+M7CmvIDxhBFg2TxnVLMBR5s=;
        b=kX4HPddeobRAwdKEOnLTw4DYufDEk5c8qxuMObUBbwxa3aPvdY7LNLDGNalvMKvNKt
         F6jP6FhmeL+vsQ3CGykJmjwsST/Wba5VeZJ/Ou7Bg88KA3ZYI8jZCBK2zTUUGLcPECTp
         hwi30uLJsriwV0WJU/eHst1MWIbyhtSIA1SHOv5fwNP0C9Txq5brTn04fkHUtq9L8Fgd
         7KtMs8b4AWITjk1htYA6IbtbpDBOTkPMPVM43gsJpLbApkLr9FQzBIYN3rD58r9GqzEI
         bEbbb46WFRzhbK9EoZsgb4v8ClkPsVfVyUzHMqBYoUUb6zzqW3WdSw6odrdPaMeqn7Vj
         fUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aUg+nsxlXPscnfiMYKd+M7CmvIDxhBFg2TxnVLMBR5s=;
        b=a3cVkEG2S4a7zlYxJreoFp2+ug0ZaTMYIPKG6Mvc0qV02Lndgmx5Q+aHQnMgNVhDSd
         K45oCBrg0wcNRoSc9Nx8ohhnt0lidQdqZtf1ya8Eh5KF0lh/mrDwuzumwzW5tLYZwbo/
         iXF86QrFR99zXXjArFgAjZeBEjY4PCc26C0uJVJTmuGNMo5eXRhnJRjcQZYNWuHZUbFC
         GWDRFFxqhm8O2c+08VPEnzGvZxOE3E8SankQ3LmzI7PLpJs/bI7ZaL/UImwAI5ta9E/l
         Me8nnGtz0PySm9HY1TdQ8uilok8zdgGiLsc0RbxMeuHu8d8Ce4u/aQXn6QcUcijLm/er
         nSMw==
X-Gm-Message-State: AOAM533lTOl7akl/CWGdMQeqgT5/KtGJeqQDsqI0ZpDaTR175Xu9Hy68
        mexJPnIK6/a8Pje98gLkwKc=
X-Google-Smtp-Source: ABdhPJy4F9bfwKf/j18exkVQ9d4Twgxpur4utK6ckmoYoKOh1wD+mTKH2CnttB7AQvKvvY82D430Yw==
X-Received: by 2002:a17:907:6d82:b0:6d6:da31:e542 with SMTP id sb2-20020a1709076d8200b006d6da31e542mr36187919ejc.135.1648601271316;
        Tue, 29 Mar 2022 17:47:51 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id v5-20020a50c405000000b004161123bf7asm8834629edf.67.2022.03.29.17.47.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Mar 2022 17:47:50 -0700 (PDT)
Date:   Wed, 30 Mar 2022 00:47:50 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>, mhocko@kernel.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] mm/memcg: set pos to prev unconditionally
Message-ID: <20220330004750.fx4jr4bnehz4ynpf@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220225003437.12620-1-richard.weiyang@gmail.com>
 <20220225003437.12620-3-richard.weiyang@gmail.com>
 <YkNUZYrSHPjJ1XOb@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkNUZYrSHPjJ1XOb@cmpxchg.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 29, 2022 at 02:48:05PM -0400, Johannes Weiner wrote:
>On Fri, Feb 25, 2022 at 12:34:36AM +0000, Wei Yang wrote:
>> Current code set pos to prev based on condition (prev && !reclaim),
>> while we can do this unconditionally.
>> 
>> Since:
>> 
>>   * If !reclaim, pos is the same as prev no matter it is NULL or not.
>>   * If reclaim, pos would be set properly from iter->position.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> ---
>>  mm/memcontrol.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>> 
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 9464fe2aa329..03399146168f 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -980,7 +980,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
>>  	struct mem_cgroup_reclaim_iter *iter;
>>  	struct cgroup_subsys_state *css = NULL;
>>  	struct mem_cgroup *memcg = NULL;
>> -	struct mem_cgroup *pos = NULL;
>> +	struct mem_cgroup *pos = prev;
>
>I don't like this so much. It suggests pos always starts with prev, no
>matter what. But this isn't true for reclaim mode, which overrides the
>initialized value again.
>
>>  	if (mem_cgroup_disabled())
>>  		return NULL;
>> @@ -988,9 +988,6 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
>>  	if (!root)
>>  		root = root_mem_cgroup;
>>  
>> -	if (prev && !reclaim)
>> -		pos = prev;
>
>How about making the reclaim vs non-reclaim mode explicit and do:
>
>	if (reclaim) {
>		...
>		pos = iter->position;
>		...
>	} else {
>		pos = prev;
>	}

Something like this?

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index eed9916cdce5..5d433b79ba47 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1005,9 +1005,6 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 	if (!root)
 		root = root_mem_cgroup;
 
-	if (prev && !reclaim)
-		pos = prev;
-
 	rcu_read_lock();
 
 	if (reclaim) {
@@ -1033,6 +1030,8 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 			 */
 			(void)cmpxchg(&iter->position, pos, NULL);
 		}
+	} else if (prev) {
+		pos = prev;
 	}
 
 	if (pos)
-- 
Wei Yang
Help you, Help me
