Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97361220DC1
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2020 15:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbgGONKv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Jul 2020 09:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730868AbgGONKv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Jul 2020 09:10:51 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF31C061755
        for <cgroups@vger.kernel.org>; Wed, 15 Jul 2020 06:10:50 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id n2so1570950edr.5
        for <cgroups@vger.kernel.org>; Wed, 15 Jul 2020 06:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vkCY6kDWjByVF/jAwqrMxG8bXNVZTl6QD0EIHDVYVvg=;
        b=T5LhLO42jFeK8otjiZMlFd/9dTVrSG8T1SXlUDpXXePwRFiDaTChrtR6/5AL6KIw+w
         ALeafWne74XeJ2cUm9BH8jJSRMagzJn/pbb+aT1MdoID6XNOyc+4V0p63UKIS2c9IKC5
         cVuDvv+F2sZfzwkL5EzZEvsqqahRgwwtZYias=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vkCY6kDWjByVF/jAwqrMxG8bXNVZTl6QD0EIHDVYVvg=;
        b=OwQxVxvxy6dj8zZXkHDubr9N0cMzsgL2iGOKyiBCAFpbSsqy417k9LzpjUVy2pi82B
         4id9khg8NjTd71y3q9j8WrfhhcbJwU7a6XEjbD+0/BU9psWY4qSouFBc1J98ImGhp18i
         zNI0Wj8BmHbZY2eKaczFk9zJH+fruE/CtB2tJYDq2EKu3pstW8+SZ/zqkjlSHXEBffJl
         F6aRDyj8f7Q2It5QunM4qWHFRlvCKWEcWv7GlSM5LJfYniYYWD2VZ9tQgAOR9o4pTeCr
         nogmaZMmpuOiLZx7sT6cKY5O5MCl610aGFdkwutrGpbVbcpRvsw3ei4CXhKLm+75sNHj
         WZpw==
X-Gm-Message-State: AOAM5316ZxyShFCVocnjFoyzl1naprxLkvyQeigHr0WhA4+ktP2+szQX
        vtkZrkHmy41hSK6Y1507Aq9Qlw==
X-Google-Smtp-Source: ABdhPJyhY5cN0L+v+z/JsqezWVFNriRXkI06IQ9mceLAEKRfn47qTlJO8K5juPaf2zCWOu3J9DonpQ==
X-Received: by 2002:a05:6402:354:: with SMTP id r20mr10036250edw.32.1594818649439;
        Wed, 15 Jul 2020 06:10:49 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:3d8a])
        by smtp.gmail.com with ESMTPSA id u19sm2209262edd.62.2020.07.15.06.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 06:10:48 -0700 (PDT)
Date:   Wed, 15 Jul 2020 14:10:48 +0100
From:   Chris Down <chris@chrisdown.name>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm, memcg: provide a stat to describe reclaimable memory
Message-ID: <20200715131048.GA176092@chrisdown.name>
References: <alpine.DEB.2.23.453.2007142018150.2667860@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.23.453.2007142018150.2667860@chino.kir.corp.google.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi David,

I'm somewhat against adding more metrics which try to approximate availability 
of memory when we already know it not to generally manifest very well in 
practice, especially since this *is* calculable by userspace (albeit with some 
knowledge of mm internals). Users and applications often vastly overestimate 
the reliability of these metrics, especially since they heavily depend on 
transient page states and whatever reclaim efficacy happens to be achieved at 
the time there is demand.

What do you intend to do with these metrics and how do you envisage other users 
should use them? Is it not possible to rework the strategy to use pressure 
information and/or workingset pressurisation instead?

Thanks,

Chris
