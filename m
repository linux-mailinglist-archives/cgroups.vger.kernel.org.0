Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975954F52A1
	for <lists+cgroups@lfdr.de>; Wed,  6 Apr 2022 04:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbiDFC4R (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Apr 2022 22:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573212AbiDESW6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Apr 2022 14:22:58 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8B32558F
        for <cgroups@vger.kernel.org>; Tue,  5 Apr 2022 11:20:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d2d45c0df7so953857b3.1
        for <cgroups@vger.kernel.org>; Tue, 05 Apr 2022 11:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FMzoEUuR7kMFf/p41WoCKSGPV5DJJawQawoS8VMfGf8=;
        b=jYIKh2vp9qzfZy+6UQTsSiswFuPf0yt2j5lgrCOf9U4Asuhj5voE7FXq3/eWuXqgvw
         ULBXZRop2ngkb2O9nMzY1uLHvP1LWd/x8fzu2w61irvv5uKNhUem37HnvK9XEO/Y4aBx
         9b7Wyk5tsV19GACNlZAkOIEnABxxWmf+iLah22Nnlus35H6foWOxb5WxSZkRlsXquc4z
         1+6aMH0AAQnFuIURELqM35d6UqL9WtphobKOT1uGSXpTe1a2gueSkkSlLq6xTc0yD7kQ
         l8K9Xu5eI3oEOggGCqayqCvc3ltRZ/okdmXjE7CFxYGUXTnqxiLonOjPprzJPBS9ijEI
         V/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FMzoEUuR7kMFf/p41WoCKSGPV5DJJawQawoS8VMfGf8=;
        b=mH+EZntfKXJJ15J9RmyX8ODBuFhZnbisXNVeTsLyBDu8NtWvzWnG89ImU2q0XSagzB
         nG3JeE7sjkfi3/ZeqDe8fJueUusuvrDpEG3zH+BqkkTDeWdbJeuz3MRuP2MIEsTIPtxf
         pb5Ru7pkFcZKnNRukV1RKHPTKWwLc6FDnYAICdJBzmycoXKFrmg6sB4Vn3iDdd3xhqn0
         r59xje2BNTIZHYG6UTBwPoXgsdXkCC0dnzfxq4elSeyrqkjh5chp1msBqyPuuB5G1px/
         cnAXAFWGzEuD1g537/ljNOGeq3KvNM4YQxJ3p+JOfkXMbdMNeDPcjkPMLxHEvqRYjln9
         YdpQ==
X-Gm-Message-State: AOAM531144zrNNYEaFVqmx9rEDDqYOLcHkSxBVgqD7B1d4ffopm8oyHc
        /L+mqpcDCQc8uU6exKEudrvaOj9qWc0IdA==
X-Google-Smtp-Source: ABdhPJyRJ8U3oDgsQlN6kSYTXqYVSNyGjuN383mqMzuG5X15/R39UeByfybT+kI/2S49Zn8l8ChvoM2vPwKpZg==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a25:3d42:0:b0:63d:c88a:faea with SMTP id
 k63-20020a253d42000000b0063dc88afaeamr3609443yba.171.1649182856090; Tue, 05
 Apr 2022 11:20:56 -0700 (PDT)
Date:   Tue, 5 Apr 2022 18:20:53 +0000
In-Reply-To: <20220403020833.26164-1-richard.weiyang@gmail.com>
Message-Id: <20220405182053.wvcewrm5ovi3qeev@google.com>
Mime-Version: 1.0
References: <20220403020833.26164-1-richard.weiyang@gmail.com>
Subject: Re: [PATCH] mm/memcg: non-hierarchical mode is deprecated
From:   Shakeel Butt <shakeelb@google.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Apr 03, 2022 at 02:08:33AM +0000, Wei Yang wrote:
> After commit bef8620cd8e0 ("mm: memcg: deprecate the non-hierarchical
> mode"), we won't have a NULL parent except root_mem_cgroup. And this
> case is handled when (memcg == root).
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Roman Gushchin <roman.gushchin@linux.dev>
> CC: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
