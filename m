Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB822ADEE5
	for <lists+cgroups@lfdr.de>; Tue, 10 Nov 2020 19:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731649AbgKJS51 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Nov 2020 13:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731564AbgKJS50 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Nov 2020 13:57:26 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D370C0613D3
        for <cgroups@vger.kernel.org>; Tue, 10 Nov 2020 10:57:26 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id t18so6947778plo.0
        for <cgroups@vger.kernel.org>; Tue, 10 Nov 2020 10:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=/kb37eWBLDbjDnXmFWfjVVLRM7gSVNXEojlTedCdvIo=;
        b=JqIkwI7mdvEOLGgaIkz1ad0WiIuxYzgH0Yc+w9hHs29ATydarbNS09YbvxzgGRTA+P
         4v2AYugE3z7Q2QIeD3OhEndw3WYxeW2qZ16+ck2tb5l8QvEnSQ3AF/yxD9OfnJXgSvfU
         0kUI2sAyChygWhOdSkQLeY4rXbW4trVTu5JZ6TAtI7Nl4yewa5HMXRcieo9By2J0Sv/1
         FZfrBAyhW2vT5RjBkJAMyeqeBzWN1CfhkwhjlYL1MDOnm0kZmD51aUsf2d8saiztrvEk
         sgMVef5QM8EDIEN1uklngMw5xuO1SAjFMC28c0Fo0sTiedCuw73rPx2KgT5Ctj3UEx+K
         9MNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=/kb37eWBLDbjDnXmFWfjVVLRM7gSVNXEojlTedCdvIo=;
        b=VKOjqDh9ZDu3SZOrd7BH1qvAVCsnGMOAFgcYNwo2Ed/SGvR5CcwrS8jDbXElkzbjYd
         /V9M+76F2uzi67nBpYqD7PhXEsgUHky+2QfVQLjx4kwSPKL2whsAqRI89UD9ZMvtmyIT
         /di/azT5TnUO9eajhg2xxBGO507Tb3Pd6ELpHdMLUQIsL8P9bks0iaf6NruygkV3J3e3
         kWpDikfFH3/kzCBrkgaQoNgRGekVz21wSdzLgvZ9u+rTTc9SMVCb5J/CS0qxAaoSeHXP
         Y0nop3lSbs4YRV7gbom5/yjR1fVVA6fyP/LArx7JHLcjSlDuFKSdOZJ/YgVYnJVi/X1E
         S4xA==
X-Gm-Message-State: AOAM530LFGFZnyK0MiqcYFBZnhViL/3mTbNZcST6DmH8jyBhCg909hLM
        /pcFpCfGGa+ciAwc0LbInWZmZw==
X-Google-Smtp-Source: ABdhPJyLZxTXoySuldNuf+7kK21QLpddc/YRss2vggm6jrq66wCxAHCGe8DKoULcFL0dOTVlNbHSEQ==
X-Received: by 2002:a17:902:e9c4:b029:d6:d5d6:c288 with SMTP id 4-20020a170902e9c4b02900d6d5d6c288mr18061556plk.22.1605034645751;
        Tue, 10 Nov 2020 10:57:25 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id s6sm13826565pgo.8.2020.11.10.10.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 10:57:24 -0800 (PST)
Date:   Tue, 10 Nov 2020 10:57:23 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Muchun Song <songmuchun@bytedance.com>
cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, shakeelb@google.com,
        guro@fb.com, Vlastimil Babka <vbabka@suse.cz>,
        laoar.shao@gmail.com, chris@chrisdown.name,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: memcg/slab: Fix root memcg vmstats
In-Reply-To: <20201110031015.15715-1-songmuchun@bytedance.com>
Message-ID: <alpine.DEB.2.23.453.2011101054350.1685210@chino.kir.corp.google.com>
References: <20201110031015.15715-1-songmuchun@bytedance.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 10 Nov 2020, Muchun Song wrote:

> If we reparent the slab objects to the root memcg, when we free
> the slab object, we need to update the per-memcg vmstats to keep
> it correct for the root memcg. Now this at least affects the vmstat
> of NR_KERNEL_STACK_KB for !CONFIG_VMAP_STACK when the thread stack
> size is smaller than the PAGE_SIZE.
> 
> Fixes: ec9f02384f60 ("mm: workingset: fix vmstat counters for shadow nodes")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Roman Gushchin <guro@fb.com>

Acked-by: David Rientjes <rientjes@google.com>

I assume that without this fix that the root memcg's vmstat would always 
be inflated if we reparented?  If that's accurate, perhaps this is 
deserving of a

Cc: stable@vger.kernel.org # 5.3+
