Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CD651DB41
	for <lists+cgroups@lfdr.de>; Fri,  6 May 2022 16:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358127AbiEFPAz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 May 2022 11:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384416AbiEFPAw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 May 2022 11:00:52 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8CC5D5D1
        for <cgroups@vger.kernel.org>; Fri,  6 May 2022 07:57:09 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id x9so6152273qts.6
        for <cgroups@vger.kernel.org>; Fri, 06 May 2022 07:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UMiJdnXRi9aL2AL9Vognq71+6oZgB61YztBopTVtQsI=;
        b=OQ7BK+mietcxdA+xGJIfTtOaowVb7K7X3AIK/p0uNueclD7Y7fS3s2OecMUE77qV1X
         c5lrVZcv3qzT9iXvcohzhZThbkkrY27rW1TYJFoKXU87Fxb1hBAfMPjp+DroOAMnb6nN
         +RfzBqhZFn1AVmUXUpoBS9Trkeaxg0rtJvWx8qbh3OrPmSLNw5vnbauJAcTj0z0MhCcG
         mbYIi4s4dytVvlg4zrOl3UEGEs6uXvVXQF4xq6kn4ruyxufmUY7+/P7yQuNSuYV6koW5
         B/kpsin/bvmMqHv6TwomKQg2J7PkZUjlJwogTKj2UXnpv+Dy9OYdeHM54qs9blfKuACF
         kiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UMiJdnXRi9aL2AL9Vognq71+6oZgB61YztBopTVtQsI=;
        b=weMAuNpUWSpilZ22hSPplRVwVS0P8ZxnGmPS4/xHDglQlDQOK44pc7ruqR8k1Ur8D2
         HKmzWrwHWl94H4pKkkvMffP8e+oRnKsCnVJCKoGYf+RkbhMeqr/hX3U1XX6M70uEu69C
         xQbbN1bvI6UMsWwIJXN5JBMWhNQt9LRMuEhMMbcAc++uMaR6vAufmQspa/OIW2KioTzu
         CeyW748YfgZd77CnxgI6z6gS9dRs8YZJv7rEcd3Md0m7FCOAC/NG/1p7J661HqzGln6l
         HFTSTw4suSNTFz1tpD66ap02TAZXE1R9YkTdSAVjZPR25TFw3GW60yCJNIDS5r9Czdms
         6F8A==
X-Gm-Message-State: AOAM531uYw3CPeNeasDR8UsdHHzpgdps+XptmzHFg98INx9p0DPNTLyr
        lWdzjx1hEo6j3ipPVGNKglVAUsFq+KVx1g==
X-Google-Smtp-Source: ABdhPJw5KlQIWwHvnoYh6CGzeMwc2xD2ZeoiJt6REs1ah2m8tXsLfJ8mfGEirSewIBncZHGs+ozCrg==
X-Received: by 2002:ac8:5245:0:b0:2f3:a331:b045 with SMTP id y5-20020ac85245000000b002f3a331b045mr3085687qtn.570.1651849028187;
        Fri, 06 May 2022 07:57:08 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:538c])
        by smtp.gmail.com with ESMTPSA id k6-20020ac81406000000b002f39b99f69fsm2577960qtj.57.2022.05.06.07.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 07:57:07 -0700 (PDT)
Date:   Fri, 6 May 2022 07:56:18 -0700
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Ganesan Rajagopal <rganesan@arista.com>
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/memcontrol: Export memcg->watermark via sysfs for v2
 memcg
Message-ID: <YnU3EuaWCKL5LZLy@cmpxchg.org>
References: <20220505121329.GA32827@us192.sjc.aristanetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505121329.GA32827@us192.sjc.aristanetworks.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 05, 2022 at 05:13:30AM -0700, Ganesan Rajagopal wrote:
> v1 memcg exports memcg->watermark as "memory.mem_usage_in_bytes" in
> sysfs. This is missing for v2 memcg though "memory.current" is exported.
> There is no other easy way of getting this information in Linux.
> getrsuage() returns ru_maxrss but that's the max RSS of a single process
> instead of the aggregated max RSS of all the processes. Hence, expose
> memcg->watermark as "memory.watermark" for v2 memcg.
> 
> Signed-off-by: Ganesan Rajagopal <rganesan@arista.com>

This wasn't initially added to cgroup2 because its usefulness is very
specific: it's (mostly) useless on limited cgroups, on long-running
cgroups, and on cgroups that are recycled for multiple jobs. And I
expect these categories apply to the majority of cgroup usecases.

However, for the situation where you want to measure the footprint of
a short-lived, unlimited one-off cgroup, there really is no good
alternative. And it's a legitimate usecase. It doesn't cost much to
maintain this info. So I think we should go ahead with this patch.

But please add a blurb to Documentation/admin-guide/cgroup-v2.rst.
