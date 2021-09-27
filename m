Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF8D41996B
	for <lists+cgroups@lfdr.de>; Mon, 27 Sep 2021 18:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235512AbhI0QpR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Sep 2021 12:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbhI0QpR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Sep 2021 12:45:17 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2DBC061575;
        Mon, 27 Sep 2021 09:43:39 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 145so16367562pfz.11;
        Mon, 27 Sep 2021 09:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mpp3yt5UlhJzcT0WXNiNQ5zDVt3UnhzU5xESPpUlLrY=;
        b=N6U4tHO7NsJPCAI0pl2qLjHILOWVWb0tMyq2HluBHcliYns5+8xvPinnRPTqZLH0Vp
         mjDwUGERqM+OLJEABbwAol4NPWVJezO6I0MZVTKNORmd/B+h34NEDOcb68rAv0YmupuZ
         8bkK3aG6reOpZDr0tyJ84dzBfEbp0AIADBf+YFz/B8Xh37dd+8jayjQ++afsnikievA0
         hyvk7st00zP25LRpCvBlwq0w0Of4Sop9JeO9VLHlA21sz70pV4PKeb1VbDW6QVCFsBW/
         aU+qGeKRdcYyDOavIovSgSbh4pdi9nQFhqQMkv5AQdDHphByKFQ2pvBbQxKAG4mdMzWO
         aPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Mpp3yt5UlhJzcT0WXNiNQ5zDVt3UnhzU5xESPpUlLrY=;
        b=UUbcANZf7DBFeJhnD9u1A4GaBTOFLeXsTZMxzq6RGSWQKWN+k2IFQQkQL/9WqmO4/K
         WcUtYFXYS0oXArPU5EQPZIqsq7Sxm1HNAnp64Ku4SgS7Lm0dkne9vVUl0C7NPU7B1Y0h
         ecXmkOxXlmzx3LVxq2T6lGlrTSvbTFzrgD0ARw6YO6XGAivo6EMQ/daGFuCm2qQAXC1x
         qDgKvgOwIhIqx+egcLN3N7IRezhE0ZVjKWuRpY1DbHMVSpEnvJWxex/4zT+ETzHAah2n
         M7onxWwGuTCI1qIle7k8I355h+vPFhCBs8by96hDZRuGau/1o0aTguo+WiO5xbSgSh6/
         T5bQ==
X-Gm-Message-State: AOAM53113vx5DhiJduI5lhtq1zF/O7LTAvGNALxbxyj49/pFRzmYSmhs
        gJaQxLmNAeHwwEkvkUlXnYnV24+P2A0=
X-Google-Smtp-Source: ABdhPJwmazHB15zxzDX59vC+eDNU/75kvTpRv3bXs6Y+Knr3x5h8A8K7naXV8ZUXyy79WUEHnmSA6g==
X-Received: by 2002:a63:334c:: with SMTP id z73mr570514pgz.160.1632761018498;
        Mon, 27 Sep 2021 09:43:38 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id b3sm17339636pfo.23.2021.09.27.09.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 09:43:38 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 27 Sep 2021 06:43:36 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/debug: Fix lockdep splat with "%pK" format
 specifier
Message-ID: <YVH0uKGGmRjrIlFy@slm.duckdns.org>
References: <20210927025807.26918-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927025807.26918-1-longman@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Sun, Sep 26, 2021 at 10:58:07PM -0400, Waiman Long wrote:
> The lockdep splat is caused by the fact that the debug controller use the
> "%pK" format specifier to print out address of cset's with css_set_lock
> held. Under some circumstances, the use of "%pK" format specifier may
> acquire the selinux_ss.policy_rwlock.
> 
> To avoid this possible deadlock scenario, we have to abandon the use of
> the "%pK" format specifier and just use "%p" to always hash the cset
> addresses. The actual cset addresses aren't that important as long as
> they are unique for matching purpose.

Isn't the right thing to do here making the selinux rwlock an irqsafe one?
It's a bit crazy to have printf specifier to have restrictive locking
requirements.

Thanks.

-- 
tejun
