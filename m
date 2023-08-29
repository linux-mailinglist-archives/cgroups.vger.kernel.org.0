Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B8378CD63
	for <lists+cgroups@lfdr.de>; Tue, 29 Aug 2023 22:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjH2UNi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Aug 2023 16:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240166AbjH2UNL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Aug 2023 16:13:11 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0D91B7;
        Tue, 29 Aug 2023 13:12:54 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bbc87ded50so29785785ad.1;
        Tue, 29 Aug 2023 13:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693339974; x=1693944774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2c+nAeWfVQ1Bjfr8Iht6NC2EjfJ/cEr0+ZzRbynwAxk=;
        b=PKeJ3wv65Hxtbk9t9jwqLMwo41jPlQI/bEzBLZYuBxDXptwUr24208p2xvY6CA+3EG
         yli15LW0MnwR+QW7XpKaA8khOvp+KKpb2WsGXuGkzO2yj3ITQ1dYblxSDL0cSdMT7fbB
         lTR9RUQ+kCXoTXMz9N8AcbeGQLMRweuyGS436cI/RU4eNQZr6M0tO8ZKEAxQUvlk+c6+
         HK8W26grUmkCr9Ihinr9z2E42olcL9GVsaJOBHEBZbqbMlU8Cl3+p1ZKsg3GXTCAOZMM
         wVKxT0um3wcC9N0OKJ7do4BvG1Xyhd3dQMlZsvS0JSAoRvJe90209F+g0+ywZ5vf8kjt
         SrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693339974; x=1693944774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2c+nAeWfVQ1Bjfr8Iht6NC2EjfJ/cEr0+ZzRbynwAxk=;
        b=fhKwa1UiQaBmLGk9tbTVxH8Z4nmxo8ukmNzNvmmC1XKzOqM5ad7eaCfpUTeFPQ/53m
         DPoySyUIHwa0dhQGFGDXQ4ljpHtoVtOXtQOdUgha2y9bDwT8LjbGhjUjPw8RWXsVS5HO
         ZYaLCkL8pbjGNJdKIkBofpqiWZb7nAnx5wnsHQqby7UoqPulvjw66IUHGQFp9GJlIUvh
         eROkA+bjurkRqpbPOs5a9HPv1xwuo3sp3h4nnL/SmFFcdQAbrp4Wi1m+lOGFMDRozSc3
         iUUy9sKQCiGf8B0ga8hf+6QWasVptMxNGF/G3p0Rjdmo4slfA2A5ncYczpmIhMneIz/x
         Y6QA==
X-Gm-Message-State: AOJu0Yx9SlHLYW7ud7EC9ht9tqbps1KZlk7pZDfWisUduGff6QwvAj07
        o1tjjgf2WTAUO/tq7dxvS8k=
X-Google-Smtp-Source: AGHT+IEpUNj7wfCbFVL/mE5P7JQhyEe7o4NWw0E7lHBqGiS/CObrdBpX8m7cFK+x9bfHdypeD0t5jA==
X-Received: by 2002:a17:902:700c:b0:1bb:d7d4:e0d with SMTP id y12-20020a170902700c00b001bbd7d40e0dmr109537plk.64.1693339974366;
        Tue, 29 Aug 2023 13:12:54 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:f05])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902eb4c00b001a95f632340sm9827265pli.46.2023.08.29.13.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 13:12:53 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 29 Aug 2023 10:12:52 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: memcg: use non-unified stats flushing for
 userspace reads
Message-ID: <ZO5RROsZ1VESCsMG@slm.duckdns.org>
References: <ZOW2PZN8Sgqq6uR2@dhcp22.suse.cz>
 <CAJD7tka34WjtwBWfkTu8ZCEUkLm7h-AyCXpw=h34n4RZ5qBVwA@mail.gmail.com>
 <ZOcDLD/1WaOwWis9@dhcp22.suse.cz>
 <CAJD7tkZby2enWa8_Js8joHqFx_tHB=aRqHOizaSiXMUjvEei4g@mail.gmail.com>
 <CAJD7tkadEtjK_NFwRe8yhUh_Mdx9LCLmCuj5Ty-pqp1rHTb-DA@mail.gmail.com>
 <ZOhSyvDxAyYUJ45i@dhcp22.suse.cz>
 <ZO48h7c9qwQxEPPA@slm.duckdns.org>
 <CAJD7tkaQ1hD9HHyYTK_vfCQ9PCVZag7qMBueKyB+sEn=swvNJA@mail.gmail.com>
 <ZO5IuULSCXMe9_pN@slm.duckdns.org>
 <CAJD7tkYtnhemCLBqFqOVurfWEaCjKtyEM745JYRxFS0r5cpZwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkYtnhemCLBqFqOVurfWEaCjKtyEM745JYRxFS0r5cpZwQ@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Aug 29, 2023 at 12:54:06PM -0700, Yosry Ahmed wrote:
...
> > Maybe leave the global lock as-is and gate the userland flushers with a
> > mutex so that there's only ever one contenting on the rstat lock from
> > userland side?
> 
> Waiman suggested this as well. We can do that for sure, although I
> think we should wait until we are sure it's needed.
> 
> One question. If whoever is holding that mutex is either flushing with
> the spinlock held or spinning (i.e not sleepable or preemptable),
> wouldn't this be equivalent to just changing the spinlock with a mutex
> and disable preemption while holding it?

Well, it creates layering so that userspace can't flood the inner lock which
can cause contention issues for kernel side users. Not sleeping while
actively flushing is an side-effect too but the code at least doesn't look
as anti-patterny as disabling preemption right after grabbing a mutex.

I don't have a strong preference. As long as we stay away from introducing a
new user interface construct and can address the noticed scalability issues,
it should be fine. Note that there are other ways to address priority
inversions and contentions too - e.g. we can always bounce flushing to a
[kthread_]kworker and rate limit (or rather latency limit) how often
different classes of users can trigger flushing. I don't think we have to go
there yet but if the simpler meaures don't work out, there are still many
ways to solve the problem within the kernel.

Thanks.

-- 
tejun
