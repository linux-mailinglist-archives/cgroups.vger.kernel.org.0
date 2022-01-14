Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D098648E181
	for <lists+cgroups@lfdr.de>; Fri, 14 Jan 2022 01:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbiANA3k (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Jan 2022 19:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiANA3k (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Jan 2022 19:29:40 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45A0C061574;
        Thu, 13 Jan 2022 16:29:39 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id t24so29153389edi.8;
        Thu, 13 Jan 2022 16:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8EJiE87iFvzZs2wfpp7MhZSruKW5x9ebf2/nsWfIQAY=;
        b=KzGxA/Mn5jnF3eZqy7OWsndDxgnJpSHZAE+/AsMtTVpwYdR+j5o7zqZybAwsY3FtfC
         Zdhb4E/EIDEzf3/C/I6WWnCyQ3MVlat+azg4xSdQJ5PMhoLivaX+W0w2Ks8GBbKdjJKO
         8cDYIaYTatdFa5sunv/AGeKgu/Bw4ABOVqHsc70RH7d0C5oA8w1qz2cMAQuH5ITEcfdf
         euxQZ8B3cT42PKxNQL0n8RDQyw5ILnnDrH6mR0+p5FeilycRyArnNQtA1lHzQMCBWEvq
         uSGjp71IEJm70ZrPWH56e7JGMeqBHO6cUeH1QRx0COuJBM1M3RxbXAH+TvdBkY7sRDuk
         fQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8EJiE87iFvzZs2wfpp7MhZSruKW5x9ebf2/nsWfIQAY=;
        b=AXv/2R2Gd/CdG79wF4LJc8LJLeDFTefKr1hfKYjoClKMQouhWjdMoG6BlfKYG/Ln7T
         Uh7YZH3cuE4jkriTqU3QqZIAXWcOIbDrxG4JX7V+LQBMp54P/0X0XheiNGymfMsi7Ddo
         R1m0ErilfToNBDS9lRV3NhRMXPR1DgYYW44AXDxdeAdRGEvEYovMPuAMX1kYmWy4zrfG
         yE5U/5yWXIFdiLyIyBinb5hgym8lHTkOvapEjt61KJ7dtEw0d750GYFXjdRP5PaP6BtM
         aPou98gv8vbB+Pb31pZpyaRsq+PmvgS7qOGK1cXPb2+iDCfblsKxJDJfvSizdjx5HJxq
         hrKg==
X-Gm-Message-State: AOAM5329/8bAXIB3D9yWBXGIo7vXnb6Sy4pLHSAEwoOy4msgGzR7ELJB
        VG2/nTPCgCF2zmxvmHgxSa4=
X-Google-Smtp-Source: ABdhPJwgzBvEezAa5NINhfz1SA5iwrNunoXYrzVrs5APytwkgDEFLy8R0bo2N6zJZtlQgqy2SIMUlw==
X-Received: by 2002:a17:906:7e57:: with SMTP id z23mr5422663ejr.674.1642120178277;
        Thu, 13 Jan 2022 16:29:38 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id t8sm1710368edr.90.2022.01.13.16.29.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jan 2022 16:29:37 -0800 (PST)
Date:   Fri, 14 Jan 2022 00:29:37 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        shakeelb@google.com, guro@fb.com, vbabka@suse.cz,
        willy@infradead.org, songmuchun@bytedance.com, shy828301@gmail.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/4] mm/memcg: use NUMA_NO_NODE to indicate allocation
 from unspecified node
Message-ID: <20220114002937.fnyq3yyk36j4nb3d@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220111010302.8864-1-richard.weiyang@gmail.com>
 <Yd1CdJA5NelzoK1D@dhcp22.suse.cz>
 <20220112004634.dc5suwei4ymyxaxg@master>
 <Yd6Xr7K9bKGVgGtI@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd6Xr7K9bKGVgGtI@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jan 12, 2022 at 09:56:15AM +0100, Michal Hocko wrote:
>On Wed 12-01-22 00:46:34, Wei Yang wrote:
>> On Tue, Jan 11, 2022 at 09:40:20AM +0100, Michal Hocko wrote:
>> >On Tue 11-01-22 01:02:59, Wei Yang wrote:
>> >> Instead of use "-1", let's use NUMA_NO_NODE for consistency.
>> >> 
>> >> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> >
>> >I am not really sure this is worth it. After the merge window I plan to
>> >post http://lkml.kernel.org/r/20211214100732.26335-1-mhocko@kernel.org.
>> 
>> Give me some time to understand it :-)
>
>Just for the record, here is what I have put on top of that series:

Ok, I got what you try to resolve. I am ok with the following change except
one point.

>--- 
>>From b7195eba02fe6308a6927450f4630057c05e808e Mon Sep 17 00:00:00 2001
>From: Wei Yang <richard.weiyang@gmail.com>
>Date: Tue, 11 Jan 2022 09:45:25 +0100
>Subject: [PATCH] memcg: do not tweak node in alloc_mem_cgroup_per_node_info
>
>alloc_mem_cgroup_per_node_info is allocated for each possible node and
>this used to be a problem because not !node_online nodes didn't have
>appropriate data structure allocated. This has changed by "mm: handle
>uninitialized numa nodes gracefully" so we can drop the special casing
>here.
>
>Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>Signed-off-by: Michal Hocko <mhocko@suse.com>
>---
> mm/memcontrol.c | 14 ++------------
> 1 file changed, 2 insertions(+), 12 deletions(-)
>
>diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>index 781605e92015..ed19a21ee14e 100644
>--- a/mm/memcontrol.c
>+++ b/mm/memcontrol.c
>@@ -5044,18 +5044,8 @@ struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
> static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
> {
> 	struct mem_cgroup_per_node *pn;
>-	int tmp = node;
>-	/*
>-	 * This routine is called against possible nodes.
>-	 * But it's BUG to call kmalloc() against offline node.
>-	 *
>-	 * TODO: this routine can waste much memory for nodes which will
>-	 *       never be onlined. It's better to use memory hotplug callback
>-	 *       function.
>-	 */

Do you think this TODO is not related to this change?

>-	if (!node_state(node, N_NORMAL_MEMORY))
>-		tmp = -1;
>-	pn = kzalloc_node(sizeof(*pn), GFP_KERNEL, tmp);
>+
>+	pn = kzalloc_node(sizeof(*pn), GFP_KERNEL, node);
> 	if (!pn)
> 		return 1;
> 
>-- 
>2.30.2
>
>
>-- 
>Michal Hocko
>SUSE Labs

-- 
Wei Yang
Help you, Help me
