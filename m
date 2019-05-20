Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAE023B4A
	for <lists+cgroups@lfdr.de>; Mon, 20 May 2019 16:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388177AbfETOy3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 May 2019 10:54:29 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:37939 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732387AbfETOy3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 May 2019 10:54:29 -0400
Received: by mail-ua1-f66.google.com with SMTP id r19so4745369uap.5;
        Mon, 20 May 2019 07:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8cXCSMG/utY4UucWb4ekygNexeTn9aJiisIiVvtivhA=;
        b=ZU1x/Bp2X6efOLs6VCJ6w1Y0/Tx//zW4Ud90lRRbRSmCiz5AojOo473KCRA1bw98rL
         Xr8VvLNK5CrMk2GXwtG407SUCkWPF3GcdHtkGzyYxq9CO0MN8PeXxCh2EVJV95XXloKQ
         ts6dEhyIdh71+h7iYVn147d+/97Sj7jezcx+AncoJt0Js2Pki95HdfKfeuxQ4aK0LrEg
         L8w8tHdtnJzu6vuHtsCmaj698Jci8ICsaiU5knDuPLCDSgalX75JuSBfVb/yntUmDFBz
         guLP5Ak5FGNc8SFTBSYNfxGmPH3qKxIYZspdEBK9dNELQhFtZteuW8hrYaPt9WWJauX4
         qMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8cXCSMG/utY4UucWb4ekygNexeTn9aJiisIiVvtivhA=;
        b=BecE2poLD9b7h0/Gw1+3K9L+dXx6sAzX8uUnGHCEdkWkJP+arJNdx6A1gPplJkK3u2
         C0JQEfm6ha+Aeq+Y0sdK7VXVsj/1MehKWvf5XNWK0XApxbkOG6SUR+ecJKRXnryduTN4
         dMOJCTQiqQkz9wukJMjDJYukyREf+QsTRnM2vYVVQfMyVflEsSSd7vxlGBPrBYOF11IM
         xCcR7NNOAtTTNfpr3vNtWGQMlbA860dQWYKed5mbvV09gDWrR3xoWghow6XHiYQwC+yj
         kx8Uof+GWBYFAwtR0fvDnLGLd/DfD2CeG94d+Bl0iyZaJ128edBuFu6+c/RENYAq6a13
         eLyg==
X-Gm-Message-State: APjAAAWJfLjYtmJl8iNZFkH13mFFw45kj54HYHBDpsozKAsttQAHRWCg
        jzl/LraKRMU2Z6vD1uU4cVueq4mZ
X-Google-Smtp-Source: APXvYqwlmD0ueYLqSZ4VSGxhwR1uaHyYJwtikMj8/LvKbmobY+swajNr6uJX9UnneAMOHiTbm0GAbw==
X-Received: by 2002:ab0:42e4:: with SMTP id j91mr14823452uaj.28.1558364067745;
        Mon, 20 May 2019 07:54:27 -0700 (PDT)
Received: from llong.remote.csb (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 125sm5502165vkt.11.2019.05.20.07.54.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 07:54:26 -0700 (PDT)
Subject: Re: [PATCH v4 5/7] mm: rework non-root kmem_cache lifecycle
 management
To:     Roman Gushchin <guro@fb.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Christoph Lameter <cl@linux.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>
References: <20190514213940.2405198-1-guro@fb.com>
 <20190514213940.2405198-6-guro@fb.com>
 <CALvZod6Zb_kYHyG02jXBY9gvvUn_gOug7kq_hVa8vuCbXdPdjQ@mail.gmail.com>
From:   Waiman Long <longman9394@gmail.com>
Message-ID: <5e3c4646-3e4f-414a-0eca-5249956d68a5@gmail.com>
Date:   Mon, 20 May 2019 10:54:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CALvZod6Zb_kYHyG02jXBY9gvvUn_gOug7kq_hVa8vuCbXdPdjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/14/19 8:06 PM, Shakeel Butt wrote:
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 4e5b4292a763..1ee967b4805e 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -45,6 +45,8 @@ static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work);
>  static DECLARE_WORK(slab_caches_to_rcu_destroy_work,
>                     slab_caches_to_rcu_destroy_workfn);
>
> +static void kmemcg_queue_cache_shutdown(struct percpu_ref *percpu_ref);
> +

kmemcg_queue_cache_shutdown is only defined if CONFIG_MEMCG_KMEM is
defined. If it is not defined, a compilation warning can be produced.
Maybe putting the declaration inside a CONFIG_MEMCG_KMEM block:

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 61d7a96a917b..57ba6cf3dc39 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -45,7 +45,9 @@ static void slab_caches_to_rcu_destroy_workfn(struct
work_stru
ct *work);
 static DECLARE_WORK(slab_caches_to_rcu_destroy_work,
             slab_caches_to_rcu_destroy_workfn);
 
+#ifdef CONFIG_MEMCG_KMEM
 static void kmemcg_queue_cache_shutdown(struct percpu_ref *percpu_ref);
+#endif
 
 /*
  * Set of flags that will prevent slab merging
-- 

Cheers,
Longman

