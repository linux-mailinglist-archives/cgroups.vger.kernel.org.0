Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002EB4A3C7B
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 02:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbiAaBrr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 30 Jan 2022 20:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiAaBrq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 30 Jan 2022 20:47:46 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9960AC061714;
        Sun, 30 Jan 2022 17:47:45 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id k25so37557464ejp.5;
        Sun, 30 Jan 2022 17:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GkhcVI15gZvcXdR5pviGmh2yWHBWlCX9+d8RaY4e+NM=;
        b=PfyBxdltlF5w8FdwbosIkSlZzhAS88lLwzicvgGmn7xMF0OiLXyFp7jBJ+KYSOI8tr
         NbPMvTbcV4JbZNNp20xGFl3AMeb/E+EMXetLXJwImVXPbXX1kWO6/DDtB7T2mDRL3cyp
         4WgU+haILaHGlh+fgujO8pp7nejO5xH8eEnak74PC/dNK6jU8ClUnq7oO4M3AeM0exEH
         ZOvXBdgV7hP7WUEUXXxJ0TaXCPNbO2iCYVuxqGSjBA234DinG1NHNrZ7t2sV1Pkwi58t
         DTDDI4UG3KN/ephUzZ/QvJEDWEbtuY/qVcNiXhKuWk2Tf673dInDX8sgdpMUTh4VNO58
         6TFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GkhcVI15gZvcXdR5pviGmh2yWHBWlCX9+d8RaY4e+NM=;
        b=CK+dNIeif7sUHOTvYuwk1gpBLi0SdGXU2jYIbPKJGU956ACFgUejqH0g6tijuUw3qx
         SPaxBLszHrrkI1f+r44R2jdLX1DQ17thMVtOPaYQoXkl1fyyA8twj7WOxCtel7B12PNf
         /aHwxOVOSPMTJS00e0LC+ZZc/7aX3XHml1t2LIixkIZgZ0xHE9oG/er84Tcf1IAgtmR8
         qOHW9XZ7L+U7MSdvboU/U/wH+CpiQUEa5DCByO/OJ5FKbSGI3WXIWysz6CWU1prseaOW
         i6rnr84M4oWngk83dchI/VVLYjFoDSCJ1lhhR9TdRCO0a6uJZbbIzcTL762GQc773UIU
         do4w==
X-Gm-Message-State: AOAM5312AmUIJDqTuY+USlCnB4HkCfzk9DwxTWSTHOdpXoHWbnKAJC+n
        TAFfKG0rfnQoO5IuidSBojtJ1qljvx8=
X-Google-Smtp-Source: ABdhPJzfYskGQVCQ6wlLyAtq1snJ/WfxGxvPFR8YnzeiPFr+T1v1iY4Je9WzafGVZ+KwY9OEoJrNxw==
X-Received: by 2002:a17:907:9726:: with SMTP id jg38mr7677174ejc.384.1643593664095;
        Sun, 30 Jan 2022 17:47:44 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id hq28sm10407000ejc.204.2022.01.30.17.47.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Jan 2022 17:47:43 -0800 (PST)
Date:   Mon, 31 Jan 2022 01:47:42 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        vbabka@suse.cz, willy@infradead.org, songmuchun@bytedance.com,
        shy828301@gmail.com, surenb@google.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/4] mm/memcg: use NUMA_NO_NODE to indicate allocation
 from unspecified node
Message-ID: <20220131014742.oxcrctcg6sqwvzij@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220111010302.8864-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111010302.8864-1-richard.weiyang@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, Andrew

Would you pick up this patch set, or prefer me to send a v2?

On Tue, Jan 11, 2022 at 01:02:59AM +0000, Wei Yang wrote:
>Instead of use "-1", let's use NUMA_NO_NODE for consistency.
>
>Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>---
> mm/memcontrol.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>index 2ed5f2a0879d..11715f7323c0 100644
>--- a/mm/memcontrol.c
>+++ b/mm/memcontrol.c
>@@ -5054,7 +5054,7 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
> 	 *       function.
> 	 */
> 	if (!node_state(node, N_NORMAL_MEMORY))
>-		tmp = -1;
>+		tmp = NUMA_NO_NODE;
> 	pn = kzalloc_node(sizeof(*pn), GFP_KERNEL, tmp);
> 	if (!pn)
> 		return 1;
>-- 
>2.33.1

-- 
Wei Yang
Help you, Help me
