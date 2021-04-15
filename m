Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F54360928
	for <lists+cgroups@lfdr.de>; Thu, 15 Apr 2021 14:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhDOMRW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Apr 2021 08:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhDOMRU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Apr 2021 08:17:20 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64728C061574;
        Thu, 15 Apr 2021 05:16:57 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id d23so12822351qko.12;
        Thu, 15 Apr 2021 05:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vWuMPoAE8UBxHeNo7QhXBPsmih0P+8U7Q8QiWirp95g=;
        b=QEPR7zW4F2buJfe2/0q/Do+HgnihvLvH75yFZXYoSIEAsd5pvO2VZsskORw9FaK3qT
         bcZn9AeJubvP+XKoDHKYPm17f5EnqO6SnyFbevyQpdLFd/dgjC8NtoAynIjQtSipvppY
         IKclDl5Wb55AG6gDcd55/LzTdzszDj/5h/oXHSpOMWj0JcWG67nS8W3Mi7BRYfpuNjAV
         98bZ0lymWQAsgfYv6Dq5dXZAOz/V/hYV67v6JD2mIh7ICfEbFoBpDUtTVM4s2Wr0wkQj
         yMRK89IE2tJKHj23aKC9y3TPmgaBFzMRLuEr+qKRaih2eEA02VSSOLndN4pCayGugPc6
         HyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vWuMPoAE8UBxHeNo7QhXBPsmih0P+8U7Q8QiWirp95g=;
        b=bLVqdZ2nTQpeHsvbGxUad08owbfzzKEBh+p/HUZu3S83Xr/EfkrUuQ96rSbYB7Ug60
         Tom2EfQf7Rj7YeeYOcqQVMDpmE7QHMgRGoYHq3UhLeun4x29ubKVpJOZV+0D0x6mJUk8
         KZZL6HZv228/TLprDxaqsCaPfyvww1HMuylF+FwgR5i65O9GOUO0bAC+pq4enyxuKuvt
         9l2XHGCLs20C0tXItxtXovXRRqhO4Vm5/XMK9RkwIQWIPtdvo5ZHHhFUDSUqV983gBG/
         wqJLu4gXS0ECr192E0tlZ00GeS/1PFbPRcz6/fiuOk2KFBdn3/2S2A0U3cg75Q5CPmGw
         ZmmA==
X-Gm-Message-State: AOAM533zCbzvknDCWqD99FT9XDylv84RRDTYtdlr8QEJwwBU5u2Ls+8q
        pHH6iXu0V7So9klJfuYLxw==
X-Google-Smtp-Source: ABdhPJxUbZ/hz2L3Dkwg5Kf0hfJ+pUukynyiaPFK5kfR5GN08QVvapRqOLkj598HM2XyDlmch6BqIQ==
X-Received: by 2002:a37:9bc8:: with SMTP id d191mr3120663qke.99.1618489016748;
        Thu, 15 Apr 2021 05:16:56 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id x24sm1709700qtm.95.2021.04.15.05.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 05:16:56 -0700 (PDT)
Date:   Thu, 15 Apr 2021 08:16:53 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: Re: [PATCH v3 5/5] mm/memcg: Optimize user context object stock
 access
Message-ID: <20210415121653.dotuf6253s5yuhae@gabell>
References: <20210414012027.5352-1-longman@redhat.com>
 <20210414012027.5352-6-longman@redhat.com>
 <20210415032836.lohexqge3cvpsqoa@gabell>
 <alpine.DEB.2.22.394.2104151143080.632904@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2104151143080.632904@gentwo.de>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 15, 2021 at 11:44:55AM +0200, Christoph Lameter wrote:
> Would you please stop quoting the whole patch when you have nothing to say
> about the details? It is enough to just respond without quoting. I was
> looking through this trying to find something you said about individual
> sections of code but there was nothing.

Thank you for pointing it out and sorry about that.
I'll do that next time.

- Masa
