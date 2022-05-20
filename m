Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B3E52E1BA
	for <lists+cgroups@lfdr.de>; Fri, 20 May 2022 03:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244214AbiETBMi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 May 2022 21:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238676AbiETBMh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 21:12:37 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D507212816C
        for <cgroups@vger.kernel.org>; Thu, 19 May 2022 18:12:36 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x3-20020a25b3c3000000b0064e03a85ccbso5868124ybf.5
        for <cgroups@vger.kernel.org>; Thu, 19 May 2022 18:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tRp9XwLCJd757nd6S6xrPEWJRWBLPfMUrN42v2RElFU=;
        b=kLj1335gWXNqN3m0x4aikHu59YFs4w9jVsakDkYazDHkv7NdPPTHMDWcCBbO3/UU6H
         C4koYXf/EG3VCj89YpQGoAsQcqkjWiUI4krLBCoyZ0vffn/xz7p+GjRLzkI0Djr3cUR7
         icY3wNQnvbaXZORjv/+6eb+8c/8U5ZM0Sd2cE2skWOCrjurR8T/B9QDmAf8S1w48L3bR
         87Z4HB468t+jYhTBRp28yYN2j311pzzKaC5m+TmiItPYKSuvb9j5Zd5tiOdshLhQ5Ts2
         I54OjEYN9vXGiN83EaXLux5pHpSMsc31hiSPBrS5buR9BD8XZhC4mZXKH3ayBQ0DRmHS
         IVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tRp9XwLCJd757nd6S6xrPEWJRWBLPfMUrN42v2RElFU=;
        b=mwKGJs+FjvJpRBeU+LZdPOFgHKjjbCpM8F6ntwjKj58cmukXHY5nm3HrFs7zkKkhZh
         8yYcRQ7c9mAg5meihm9ovBBhJlESnoMlGcNOtS0vfoCIhz6gLxYiNEw8wJYkDYuMgD4k
         67zDQQ/20Khl1LYxdIMzmCw5wdq/fWcJoRJNGN4xicvxLUC/TedqYH9OZY/FyGtGqmim
         u6ekJi+THQjGVanlsd2gf7qmDJ1QeDfMllFWaLTeKxw8ISeVuH+XcEiSnPUXeLxnz6fS
         eWh3fPANmXzXzAQurZu5T9PZwO0mtAUu+4ho7FTit/r7fLZD11Lt8b7JVkTpQ0519ndF
         b6Bw==
X-Gm-Message-State: AOAM531zsWWnTbdZYgPgwWIhiZJf5yvZTPkvNeP0jAnEXyE8YUZKTb3u
        SQHpgyyQ3hDOz7t8RPZJU4AHpzL18p1cqA==
X-Google-Smtp-Source: ABdhPJyuiwPd0mGkX3bVtfcgfftvAb+9azlm4isHk7kCY2QP2shRGSH8dq+GIVT0R0Fjh1DkLbeEJW8MtvjZ4A==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a25:1f85:0:b0:64b:a5fc:e881 with SMTP id
 f127-20020a251f85000000b0064ba5fce881mr7404391ybf.514.1653009156066; Thu, 19
 May 2022 18:12:36 -0700 (PDT)
Date:   Fri, 20 May 2022 01:12:33 +0000
In-Reply-To: <22ccf325-6aa5-9b55-4729-d03f34125650@openvz.org>
Message-Id: <20220520011233.fxbqxcljfcrjk44n@google.com>
Mime-Version: 1.0
References: <Ynv7+VG+T2y9rpdk@carbon> <22ccf325-6aa5-9b55-4729-d03f34125650@openvz.org>
Subject: Re: [PATCH 2/4] memcg: enable accounting for kernfs nodes and iattrs
From:   Shakeel Butt <shakeelb@google.com>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        "Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>,
        kernel@openvz.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 13, 2022 at 06:51:55PM +0300, Vasily Averin wrote:
> kernfs nodes are quite small kernel objects, however there are few
> scenarios where it consumes significant piece of all allocated memory:
> 
> 1) creating a new netdevice allocates ~50Kb of memory, where ~10Kb
>    was allocated for 80+ kernfs nodes.
> 
> 2) cgroupv2 mkdir allocates ~60Kb of memory, ~10Kb of them are kernfs
>    structures.
> 
> 3) Shakeel Butt reports that Google has workloads which create 100s
>    of subcontainers and they have observed high system overhead
>    without memcg accounting of kernfs.
> 
> It makes sense to enable accounting for kernfs objects, otherwise its
> misuse inside memcg-limited can lead to global memory shortage,
> OOM and random kills of host processes.
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>

Acked-by: Shakeel Butt <shakeelb@google.com>

You can keep the ack if you decide to include simple_xattr_alloc() in
following version or different patch.
