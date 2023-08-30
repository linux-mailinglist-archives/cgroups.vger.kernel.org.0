Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DF378E0AF
	for <lists+cgroups@lfdr.de>; Wed, 30 Aug 2023 22:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239677AbjH3UbP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Aug 2023 16:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240053AbjH3UbH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Aug 2023 16:31:07 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73224EE;
        Wed, 30 Aug 2023 12:27:56 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68c0d886ea0so13625b3a.2;
        Wed, 30 Aug 2023 12:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693423587; x=1694028387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GTF8uU39IXGUS1zNRIqYR6R0K0rtvdFudoKrSX9kw1k=;
        b=AFvvh2vedbt/Klxv5llmSY+4QZo7dpggLb3kn7secLTvsXomFbp0WQwvKzDXKFrDYE
         7YXAutZH0rOeSoE3JwB14MaLRHTdvosZsrUd15kje8ItKdHnhbBk2ILhxyhWR0zlwgrq
         8iYqoWEGHidbCWVM+M+N/zPrRM+MbpVx1CDHVdXSF2XRoIAz1ZWFUpO4NO/GSTBH7YWN
         jwts8l7QgK7PmRxFodyEMLPNMAKWg+d4RKBChA73FLZrpgVlgXHDS5sx5sBIgay9BKgN
         b/IJzuSMt4oY00we0lXlY9i0gfv+DQcBJBvB2yJyGqPvejuiMCeweQA0LT4xGlA5ywOX
         PFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693423587; x=1694028387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTF8uU39IXGUS1zNRIqYR6R0K0rtvdFudoKrSX9kw1k=;
        b=KHcG61aVWRKMmdkVw1+DH6l6o9LeJnIDXE+IHI3kbjU2wVYZ6fWTSjuvYY8cF8fIIE
         WakQolmATcuthvB7oQZ/YfhnH1KvXWonQzg8yLjKnZ4h6QRmurB+YsXnjNMfCcOh3FZD
         zPM4pbMRYuOCYfBE0EmKqSjsIySNzuOcISqF/oCzjwb+qOo5Qj7Ekv8Sg4hnkdblmThB
         xtOh3Np6M+oaeXp+SXh2WNnz89/m1qiJAxLflzJCzowXiqcFKc9TV7rmrQK3QbMDzBbD
         pf1TUSbUF7NB9EoxSNiGGkk4biM5DnHJWE2O1KLg5WoJ4mx/Cer8l4nAYuO9WRDhOVOz
         a3ZA==
X-Gm-Message-State: AOJu0YwA/wWgKcDhf0kyr3BCENrgyOa772oWTeFN7DWbr41StDhAHKUI
        ef3ILvoMbMjT0sSITMWcwgk=
X-Google-Smtp-Source: AGHT+IE+cAHljrtPXZeCQaIN5eFSNasrSqxWRu2HCgLYRewDRAE57XvGffAcaegec4EFHHJ2me7q1g==
X-Received: by 2002:a05:6a00:158a:b0:68b:dbad:7ae0 with SMTP id u10-20020a056a00158a00b0068bdbad7ae0mr3917537pfk.21.1693423586632;
        Wed, 30 Aug 2023 12:26:26 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9222])
        by smtp.gmail.com with ESMTPSA id n3-20020a62e503000000b006877a2e6285sm10265474pff.128.2023.08.30.12.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 12:26:25 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 30 Aug 2023 09:26:24 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [PATCH-cgroup v7 0/6] cgroup/cpuset: Support remote partitions
Message-ID: <ZO-X4KnEtOjhJffR@slm.duckdns.org>
References: <20230817132454.755459-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817132454.755459-1-longman@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Waiman.

On Thu, Aug 17, 2023 at 09:24:48AM -0400, Waiman Long wrote:
>  v7:
>   - Fix a compilation problem in patch 1 & a memory allocation bug in
>     patch 2.
>   - Change exclusive_cpus type to cpumask_var_t to match other cpumasks
>     and make code more consistent.

This overall looks fine to me but I'm afraid we're a bit too late for this
devel cycle. I'll merge these into cgroup/for-6.7 when it opens.

Thanks.

-- 
tejun
