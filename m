Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35FF51FE98
	for <lists+cgroups@lfdr.de>; Mon,  9 May 2022 15:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbiEINtw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 May 2022 09:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbiEINtv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 May 2022 09:49:51 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBF229CBD
        for <cgroups@vger.kernel.org>; Mon,  9 May 2022 06:45:56 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id t11so10972793qto.11
        for <cgroups@vger.kernel.org>; Mon, 09 May 2022 06:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fdtyY+76slzM1oP4DlLOabKhkAkAGRbXkU+vbbhXODI=;
        b=ASZyWPXF9PtMX10Dwd7rQieT8a3L+16a5mx52slrfszXDgs4xuzeCVGKZXDxgmFbvX
         xP8Vbz4n60V1G0p7lbKcmpOr4/RXMn39dp3bXXpKSMYf4xxmY0uZSFy29gmknYlOd0jg
         Q07UCLl/aYGd+vnRS+5snSd1jU/CVTUB+npodpUmxlyUNUOHNiXQYlVmhMDl5/P16ipN
         RtwacxeumcSaUs/89KM+tiMp2Dl6CLA67scGwmkttVV7Uvx40WybSXpAQ4p2AObPcwSX
         W5TkreCcvuX97pJ2o88fM8HYgmqNFB6TkunZhjoDyf5beCqpPZ24XAdhcOYGjMvDB57c
         khGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fdtyY+76slzM1oP4DlLOabKhkAkAGRbXkU+vbbhXODI=;
        b=qUqDsRyhWB5SAf1B7nakR1jY2MEIzRchUtXwC0gkC1UgHezcf9foU/XUlDKzcsWf1j
         ebf7oKXqo8M0oNJJS7Vyp/YWWuWRNjuCXHRQyADQgjpFmzOp8UiRWmIph8kQJVb4fwRu
         2VjuLKsxfS4lsVuwzvoZe8Ai2EYAVfWAmwocqIpvr9SxddTyarRLzZ01QSAqsb2L/4sL
         LpjepVgoWEb/9sXUjWR9B2kzNpnb4B6C51XWxitvL7Hj1TpxNntyXafFB50PSWE86DFA
         549AwIl+TGt9BTTVwtbZv8RmM0nppw8rinVQ1wv9gtcR1wuWLnn/mFGEP7NNSmmliQfA
         glxw==
X-Gm-Message-State: AOAM531QIZjuOvGhNDu0nxOnyFZuWdJzOMh/eJLq6KrWyYZFYfoGJ7QD
        gqd0BDuBoSETIzP3CtdFw5D59Q==
X-Google-Smtp-Source: ABdhPJzKYh0T+cOT8AdJzg5vmaD+u1ezEXrU0M4bp98QI9Rk9T9vGmQ/GN9GZTVap08E/m/bVJKxgA==
X-Received: by 2002:ac8:5948:0:b0:2f3:cd85:f244 with SMTP id 8-20020ac85948000000b002f3cd85f244mr11370810qtz.149.1652103955845;
        Mon, 09 May 2022 06:45:55 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:538c])
        by smtp.gmail.com with ESMTPSA id 18-20020a05620a06d200b0069fc13ce213sm6831521qky.68.2022.05.09.06.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 06:45:55 -0700 (PDT)
Date:   Mon, 9 May 2022 09:44:58 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Ganesan Rajagopal <rganesan@arista.com>
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/memcontrol: Export memcg->watermark via sysfs for
 v2 memcg
Message-ID: <Ynka2s67yLpkOoE5@cmpxchg.org>
References: <20220507050916.GA13577@us192.sjc.aristanetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507050916.GA13577@us192.sjc.aristanetworks.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 06, 2022 at 10:09:16PM -0700, Ganesan Rajagopal wrote:
> We run a lot of automated tests when building our software and run into
> OOM scenarios when the tests run unbounded. v1 memcg exports
> memcg->watermark as "memory.max_usage_in_bytes" in sysfs. We use this
> metric to heuristically limit the number of tests that can run in
> parallel based on per test historical data.
> 
> This metric is currently not exported for v2 memcg and there is no
> other easy way of getting this information. getrusage() syscall returns
> "ru_maxrss" which can be used as an approximation but that's the max
> RSS of a single child process across all children instead of the
> aggregated max for all child processes. The only work around is to
> periodically poll "memory.current" but that's not practical for
> short-lived one-off cgroups.
> 
> Hence, expose memcg->watermark as "memory.peak" for v2 memcg.
> 
> Signed-off-by: Ganesan Rajagopal <rganesan@arista.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
