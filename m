Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D504A6832
	for <lists+cgroups@lfdr.de>; Tue,  1 Feb 2022 23:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241992AbiBAWso (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Feb 2022 17:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241098AbiBAWso (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Feb 2022 17:48:44 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7E2C061714;
        Tue,  1 Feb 2022 14:48:44 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id g20so16671341pgn.10;
        Tue, 01 Feb 2022 14:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HsfDWGpmirQwGTRSNLQmFIAkG7JByQa85AM3b1LDm9s=;
        b=CJBxYQNIX+LlGI+UmRx6JCxuUPoQ7jTBOZzzrt7PdYR/WkLZRWZvXQj3G0f86j/+b6
         UXbU0FxuqsspOF5IPtFH6OFpXkbZEwPt8NK/wSkHNf9OyU9cgEqG3luPE28pUZ0L1BBl
         lhiM199dG1suxWuKlC7TBlGkQIvSt6OVQZsqMz/l1bKYP/qJWEMRNbXAc4w1D8bVngks
         sgYdJc/royL6aG8SLjFjryd6VtDD3S8E5U1tN+Hxc6fRDDMrayyKiSkVhFLXo1aM+Kk1
         kGhFbb5oFGdSUfrW64XdKFsIP7FFFzAmKgZ3/UObVR8WXVzMS/cpiV3oLZwRBhe471b/
         Q/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=HsfDWGpmirQwGTRSNLQmFIAkG7JByQa85AM3b1LDm9s=;
        b=cgcQuNOdrF4UCNo3a2QcJ66Dtsjez5zzxrtv9VdSjguYn+neBiMh1JEwEzKI42Jtkz
         3jCXUe/Sihz2A3iV6ITpBg9Kf2wuhZD7ben0jLp/dJjMszS3x4WalMgNsd/YRmzp1xXF
         rCvb4s01d+DS28yPx7TPAKX5AQMMmIVKBDT9JuU7ScprJ7OoGDlXcpIecLtp7jCTBgJC
         sUFEo5br3KlZVS66kIHm06lBeVd43tut3V2/ltZ8Y6ItO/BYj/YyaPnkYGLyMUQSWZVU
         BNTWugdlfFsPZRZaKdbGEh0xVftBHuN7TNwUhErCoDrbEo88Tkl4nuhUl6rgcebtN7ay
         Ua1A==
X-Gm-Message-State: AOAM531o7K9IVcAWQg2obqnd1A7ZW0j2gRYa/sG8giKm7CRnbccRGHGM
        Uv4+CnBqZcxmA72mwfpSP34=
X-Google-Smtp-Source: ABdhPJzdXnMCg2EBoZH2Dkb00LT9HMJ4ybMbqzhP6ibrT7ncjxKu7gIW5GuoBd6wZGkMaI8GDhIifQ==
X-Received: by 2002:a63:5f52:: with SMTP id t79mr22219870pgb.177.1643755723353;
        Tue, 01 Feb 2022 14:48:43 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id nk11sm3743647pjb.55.2022.02.01.14.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 14:48:42 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 1 Feb 2022 12:48:41 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Jeremy Linton <jeremy.linton@arm.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH RESEND] mm: memcg: synchronize objcg lists with a
 dedicated spinlock
Message-ID: <Yfm4yfrrJeTlaJZc@slm.duckdns.org>
References: <Yfm1IHmoGdyUR81T@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yfm1IHmoGdyUR81T@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 01, 2022 at 02:33:04PM -0800, Roman Gushchin wrote:
...
> In this example a slab allocation from __send_signal() caused a
> refilling and draining of a percpu objcg stock, resulted in a
> releasing of another non-related objcg. Objcg release path requires
> taking the css_set_lock, which is used to synchronize objcg lists.
> 
> This can create a circular dependency with the sighandler lock,
> which is taken with the locked css_set_lock by the freezer code
> (to freeze a task).
> 
> In general it seems that using css_set_lock to synchronize objcg lists
> makes any slab allocations and deallocation with the locked
> css_set_lock and any intervened locks risky.
> 
> To fix the problem and make the code more robust let's stop using
> css_set_lock to synchronize objcg lists and use a new dedicated
> spinlock instead.
> 
> Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reported-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> Tested-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> Reviewed-by: Waiman Long <longman@redhat.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Jeremy Linton <jeremy.linton@arm.com>
> Cc: cgroups@vger.kernel.org

Acked-by: Tejun Heo <tj@kernel.org>

I suppose this will go through -mm? If you want me to route it through the
cgroup tree, please let me know.

Thanks.

-- 
tejun
