Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4254F023
	for <lists+cgroups@lfdr.de>; Fri, 21 Jun 2019 22:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfFUUw3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jun 2019 16:52:29 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39308 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfFUUw2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jun 2019 16:52:28 -0400
Received: by mail-pl1-f195.google.com with SMTP id b7so3557980pls.6
        for <cgroups@vger.kernel.org>; Fri, 21 Jun 2019 13:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=xsZwkR1O4dGnGMsIIG/ufAmeJ6Z+ZenaQocCY4Tza70=;
        b=rv+E/7b7JY6cpCuEo3QEn8sbHqI1ZR79p1uD+ayLvYUjdZXy45cMBXnpOBANzRD/h9
         AKwFkx5YKkPwDV+z+alIPV1uhD4Us31/0w7Onebbflsxun6qItXz81HGcxTZ7S45mQkF
         mdeJXXlNrRYxGieY6CO5sW7OvYILoQQwQhzFqNXgIR9sUhMfzb7yJehRXESr28JDm6lq
         IJUwCKmkCEQEHh2qvgZDsesKij6FJXeF66csul2evLnnuuXC21nlojygQcdLk+8jHF2L
         PqLK6XveRhNJzO6G5iTrQWirXDKQbFegQGPu2Np+nWTUBVb8ggftrLbBsHWiZy5kTdaQ
         g5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=xsZwkR1O4dGnGMsIIG/ufAmeJ6Z+ZenaQocCY4Tza70=;
        b=B2Xup00J6jZ/kRU6PaIyNLnevnQxqXKH0DzqrTHXX3+HC8gWKW0JwTH02smQfXZCFF
         8i6QHPK5NKBRbjOne8KrDngqce171JKgIUaTd6OHTA4RapfhPIhQb2uniFoyClvUdGjR
         mLxDKO/ibBrjHcIcxyopFmC/7cPHPilqwp75cxnKqA7VJVAfsfmPioqROOFowAWXGY8Y
         P9znb0qvdp3ZLPDFB14OuvUTe+lKWwK59hG11nIMKor13jf/qiP31aVENlJD1do6eVsF
         bNqZWAbq6oi+qj0OrIPkCOZHayIqDTY0LXYdvWVVQ1cySG/t/7vBZj2pGS/0MsfNFqLQ
         8FPw==
X-Gm-Message-State: APjAAAUpBDbQv4HOFD1MxGqTvjW/2Oevs7h1zNL1FPtSG/Zp31nDnn/M
        p+LGfMo0WqT4QyFh1WTClXr0dA==
X-Google-Smtp-Source: APXvYqz8pEu9QXTZCF8KWb47EU2DnXnK1n2Nyy53mjFvIfV6G+FleV8pUn/1peh0vqHcvEjyo/py0Q==
X-Received: by 2002:a17:902:f089:: with SMTP id go9mr64259063plb.81.1561150347844;
        Fri, 21 Jun 2019 13:52:27 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id f17sm3582163pgv.16.2019.06.21.13.52.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 13:52:27 -0700 (PDT)
Date:   Fri, 21 Jun 2019 13:52:26 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Shakeel Butt <shakeelb@google.com>
cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] slub: Don't panic for memcg kmem cache creation
 failure
In-Reply-To: <20190619232514.58994-1-shakeelb@google.com>
Message-ID: <alpine.DEB.2.21.1906211352130.77141@chino.kir.corp.google.com>
References: <20190619232514.58994-1-shakeelb@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 19 Jun 2019, Shakeel Butt wrote:

> Currently for CONFIG_SLUB, if a memcg kmem cache creation is failed and
> the corresponding root kmem cache has SLAB_PANIC flag, the kernel will
> be crashed. This is unnecessary as the kernel can handle the creation
> failures of memcg kmem caches. Additionally CONFIG_SLAB does not
> implement this behavior. So, to keep the behavior consistent between
> SLAB and SLUB, removing the panic for memcg kmem cache creation
> failures. The root kmem cache creation failure for SLAB_PANIC correctly
> panics for both SLAB and SLUB.
> 
> Reported-by: Dave Hansen <dave.hansen@intel.com>
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: David Rientjes <rientjes@google.com>
