Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A02448F99F
	for <lists+cgroups@lfdr.de>; Sat, 15 Jan 2022 23:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbiAOWK1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 15 Jan 2022 17:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiAOWK0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 15 Jan 2022 17:10:26 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FA4C061574;
        Sat, 15 Jan 2022 14:10:26 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id m4so48261222edb.10;
        Sat, 15 Jan 2022 14:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EPbI8Tt0WfUMwAmaR0DL4u0NGyT4Pfp5ibYD0UcG0DI=;
        b=agj6fChYEnKrSoNxBVq48eG35QoBd5Z4IF+iAiicRpU2JWeJ9LfMJNox6L4q2g2RBL
         4ETDJyBfAyhwTeit7qORH7ag0LnhF2LlADK4vfaVOzEQi/ZW5lHvfa82MDys4hXQK+C3
         4hJN/NnQMc73yqTl5qISSYt5yrcUMzgCFAXwTi3GLM1kOeIw6js15Tx/R0XIYwz6PTXa
         4ZwyvjW7pSAjcoWl9BMhmTQ0SloTVQLPkExYXobQE08n1ZfTuuww4aVBjSKCVRKtf75l
         UwhvkbPdJkfEIcvOk0IyuUjkHa+J6Ffexa9DabrExe6AtDsr+WdXHHvkyFsvbMoVt92K
         o4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EPbI8Tt0WfUMwAmaR0DL4u0NGyT4Pfp5ibYD0UcG0DI=;
        b=DS8iPNcuvqk+asW/cA38H82w0E+EjGgqt1gbAU9JFKjfjuj+OuKuNIpRvc1vSTLdvt
         DTUYU1SWA4e08/D8ImK0zTUcZT6tZL9PWl0jNxEeOlfTgFyuspVv7/pTyZmWhTZjt53j
         BPtXQfwGAlWHLk9Lgx8u66aq3vAt1DNiF15OX+VSx60Y/DvXqP/uoKzehiqbBBsi5PLi
         WnI+Yf6dADUFWXcp7v9y1mmj6YFFrVb+dllUh/akGBldsrJjMy6/3Hy4m3euyWNPUubI
         zFxZpYMs3JQQDYCFyKovGrS3Oc1g+O4w/RnlLFZTDlaIZWZFIAUE3Q8JWlniP6hbs5R3
         WuHA==
X-Gm-Message-State: AOAM53217UHEIH0H3Q+lJ7IME0FhtGWIll2UVjhqaV2mLepYmPRifzBs
        hFP0ApneTSFxl+/3vwAv4lY=
X-Google-Smtp-Source: ABdhPJyyNWOlbijFCkXzof9hTCK0gRxJs24hN60XetvbzrKmVaUKeHF2ngn5PutlX7rMQmoqy+A9jQ==
X-Received: by 2002:a17:907:9085:: with SMTP id ge5mr12006871ejb.128.1642284624835;
        Sat, 15 Jan 2022 14:10:24 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id j5sm2957736ejo.177.2022.01.15.14.10.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Jan 2022 14:10:24 -0800 (PST)
Date:   Sat, 15 Jan 2022 22:10:23 +0000
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
Message-ID: <20220115221023.qndjlehjxdrj5r6b@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220111010302.8864-1-richard.weiyang@gmail.com>
 <Yd1CdJA5NelzoK1D@dhcp22.suse.cz>
 <20220112004634.dc5suwei4ymyxaxg@master>
 <Yd6Xr7K9bKGVgGtI@dhcp22.suse.cz>
 <20220114002937.fnyq3yyk36j4nb3d@master>
 <YeE5k79uP3xBPCv7@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeE5k79uP3xBPCv7@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 14, 2022 at 09:51:31AM +0100, Michal Hocko wrote:
>On Fri 14-01-22 00:29:37, Wei Yang wrote:
>> On Wed, Jan 12, 2022 at 09:56:15AM +0100, Michal Hocko wrote:
>> >On Wed 12-01-22 00:46:34, Wei Yang wrote:
>> >> On Tue, Jan 11, 2022 at 09:40:20AM +0100, Michal Hocko wrote:
>> >> >On Tue 11-01-22 01:02:59, Wei Yang wrote:
>> >> >> Instead of use "-1", let's use NUMA_NO_NODE for consistency.
>> >> >> 
>> >> >> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> >> >
>> >> >I am not really sure this is worth it. After the merge window I plan to
>> >> >post http://lkml.kernel.org/r/20211214100732.26335-1-mhocko@kernel.org.
>> >> 
>> >> Give me some time to understand it :-)
>> >
>> >Just for the record, here is what I have put on top of that series:
>> 
>> Ok, I got what you try to resolve. I am ok with the following change except
>> one point.
>> 
>> >--- 
>> >>From b7195eba02fe6308a6927450f4630057c05e808e Mon Sep 17 00:00:00 2001
>> >From: Wei Yang <richard.weiyang@gmail.com>
>> >Date: Tue, 11 Jan 2022 09:45:25 +0100
>> >Subject: [PATCH] memcg: do not tweak node in alloc_mem_cgroup_per_node_info
>> >
>> >alloc_mem_cgroup_per_node_info is allocated for each possible node and
>> >this used to be a problem because not !node_online nodes didn't have
>> >appropriate data structure allocated. This has changed by "mm: handle
>> >uninitialized numa nodes gracefully" so we can drop the special casing
>> >here.
>> >
>> >Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> >Signed-off-by: Michal Hocko <mhocko@suse.com>
>> >---
>> > mm/memcontrol.c | 14 ++------------
>> > 1 file changed, 2 insertions(+), 12 deletions(-)
>> >
>> >diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> >index 781605e92015..ed19a21ee14e 100644
>> >--- a/mm/memcontrol.c
>> >+++ b/mm/memcontrol.c
>> >@@ -5044,18 +5044,8 @@ struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
>> > static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
>> > {
>> > 	struct mem_cgroup_per_node *pn;
>> >-	int tmp = node;
>> >-	/*
>> >-	 * This routine is called against possible nodes.
>> >-	 * But it's BUG to call kmalloc() against offline node.
>> >-	 *
>> >-	 * TODO: this routine can waste much memory for nodes which will
>> >-	 *       never be onlined. It's better to use memory hotplug callback
>> >-	 *       function.
>> >-	 */
>> 
>> Do you think this TODO is not related to this change?
>
>It is not really related but I am not sure how useful it is. Essentially
>any allocation that is per-possible node is in the same situation and if
>we really need to deal with large and sparse possible nodes masks.
>

Sounds reasonable :-)

>If you want me to keep the TODO I will do it though.
>
>-- 
>Michal Hocko
>SUSE Labs

-- 
Wei Yang
Help you, Help me
