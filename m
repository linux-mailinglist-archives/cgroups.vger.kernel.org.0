Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132686CCA34
	for <lists+cgroups@lfdr.de>; Tue, 28 Mar 2023 20:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjC1Sru (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Mar 2023 14:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjC1Sru (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Mar 2023 14:47:50 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96181FE5
        for <cgroups@vger.kernel.org>; Tue, 28 Mar 2023 11:47:48 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h8so53643393ede.8
        for <cgroups@vger.kernel.org>; Tue, 28 Mar 2023 11:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680029267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I8WAHPAOnoIsGbAeWRafsGc8bwd2YsHJNAiOdGspwD8=;
        b=2tUg7yrV99oGL+e/zjpM6igGege2u9YnHOxxfFKTkkGmkvvsMuO5PP2CzmH4hK514p
         OzAsp3rsWzlACLUdxakQBAEu3DoNf1m1iEqZVmxkPC4lkUAa1iTtcOp79RuXlJUkXN4G
         1Lm8am1hQ0KiyAtiXbahXpw30N5l7giyxjPWyz9NmYZx7HpzMdk3Vmqu5d4MOCcUyFVu
         RFjgUxlRIctgglXcHpHZI8WvxXkJJVPGw5ub8PRTGm7qCnNEMvs+AVviN3pW1AWwMm6/
         ma702djNMmmFeEwEYG6dbvKLFpzQm7B7QJvUgM6JKqGvshMPXh32s/FylmX7wpm3S4tS
         Y63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680029267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8WAHPAOnoIsGbAeWRafsGc8bwd2YsHJNAiOdGspwD8=;
        b=p/om9XYvC9rA+tAl8qO6I5IAKzw6Tv9Hy4kTmZ6FJzhcyMh7pCeAyTxp2/6/dMqc3Q
         SpfUxg+KdAZW75Js2nxRJaNTzAlLecCanmqnH9Du88IuRJL7MCChaugEAF+lYND42P2X
         U7q1KVRsEljn77NN5QtuNndLCm1ZGyqcKq/xq6kgIcG260V+VOHEOu/rp0f4TVDQRd7B
         UWgZKPy0u+EYaBLNS/LX+3A/PzKnC6hluz3+k8Q4WDIHAh8Tne7JpTrjj0wMoOikWIHc
         zR74NviESxaOmiZyYoq4EryUbHZjB6+tchIRdLjDnT8rJ0FR2vHPO2B9P0CtjbJSmHtz
         0RTQ==
X-Gm-Message-State: AAQBX9c4UTC1APeQrcyebhWwLz8nTs7+CKUKDD+P+F9Gy8uoj7SGT6b8
        4cszrlCPx5D+BOt8Eqga5G06jA==
X-Google-Smtp-Source: AKy350ZnaJNd8MXO1Vdjq+UQfXQqGNI7qy7qfVIDOlnZ69/PbdfJFKY7U4aJywQE80FPcvYhpkQmzQ==
X-Received: by 2002:a05:6402:8d9:b0:4fe:19cb:4788 with SMTP id d25-20020a05640208d900b004fe19cb4788mr17038191edz.42.1680029267444;
        Tue, 28 Mar 2023 11:47:47 -0700 (PDT)
Received: from localhost ([2a02:8070:6387:ab20:5139:4abd:1194:8f0e])
        by smtp.gmail.com with ESMTPSA id q18-20020a50c352000000b00501d39f1d2dsm11663627edb.41.2023.03.28.11.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 11:47:47 -0700 (PDT)
Date:   Tue, 28 Mar 2023 14:47:46 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v1 7/9] workingset: memcg: sleep when flushing stats in
 workingset_refault()
Message-ID: <ZCM2UseWAhahYVtS@cmpxchg.org>
References: <20230328061638.203420-1-yosryahmed@google.com>
 <20230328061638.203420-8-yosryahmed@google.com>
 <CALvZod5_NVTrYUhLjc3Me=CC6y3R4bhA71mCt-jXo0rX+2zUxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5_NVTrYUhLjc3Me=CC6y3R4bhA71mCt-jXo0rX+2zUxw@mail.gmail.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 28, 2023 at 08:18:11AM -0700, Shakeel Butt wrote:
> > @@ -406,6 +406,8 @@ void workingset_refault(struct folio *folio, void *shadow)
> >         unpack_shadow(shadow, &memcgid, &pgdat, &eviction, &workingset);
> >         eviction <<= bucket_order;
> >
> > +       /* Flush stats (and potentially sleep) before holding RCU read lock */
> 
> I think the only reason we use rcu lock is due to
> mem_cgroup_from_id(). Maybe we should add mem_cgroup_tryget_from_id().
> The other caller of mem_cgroup_from_id() in vmscan is already doing
> the same and could use mem_cgroup_tryget_from_id().

Good catch. Nothing else in there is protected by RCU. We can just
hold the ref instead.

> Though this can be done separately to this series (if we decide to do
> it at all).

Agreed
