Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FC55269F0
	for <lists+cgroups@lfdr.de>; Fri, 13 May 2022 21:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbiEMTPF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 May 2022 15:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiEMTPE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 May 2022 15:15:04 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD43E71;
        Fri, 13 May 2022 12:15:03 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id kl21so7341874qvb.9;
        Fri, 13 May 2022 12:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=p574xXlGBpc8qZHyt2pwHHSkpjniuBS9UHrRl2xc4Cc=;
        b=idXlyIH8V9U0AM4IyFAljhg2HkPiQTVJJKEVS3wQaxuy5NKp4lPKxe6yEusPx+ANsF
         /eiicxDEH16e6f84MVhwFYU0S8qqlYKdtb2eK+DYiy1PrWZmvRRJ36PM37NPmAeDWnsK
         npbwml71REqHsuWk/y7QDO9NO4IThDq1sWZAblpLh2xk8cfBaX56xVwTnUQtd0MQfqM+
         5wXFe0zPqvUVhwim+6Kaml9Vv1ZxOn4DMgUk8hLrgeQVFw/SZDDyLhfSCUw1kISIWWSY
         Sa4dld73fbOejCQv5MFogl18bEFOSMJ6yhCKveLF1/5qCKmwvI9qgLV89Pf8PLLf+yhv
         cOHA==
X-Gm-Message-State: AOAM532P40JYp/21hRNsj1U7DNmq5Iu9LhYbNIg16x1HghiwyIzAf33M
        FI/ttHl3A3LlOxcSfWHAcpc=
X-Google-Smtp-Source: ABdhPJw5uIPwsI4RjyLfr/Fa/my7GiG+kuUc1zYJNDotGR+vRVn8xO8+UAzQLi7VVzplQLRinRiIZg==
X-Received: by 2002:a05:6214:21aa:b0:461:b0d9:b265 with SMTP id t10-20020a05621421aa00b00461b0d9b265mr2743723qvc.110.1652469302072;
        Fri, 13 May 2022 12:15:02 -0700 (PDT)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-004.fbsv.net. [2a03:2880:20ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id t11-20020ac8760b000000b002f39b99f694sm1884975qtq.46.2022.05.13.12.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 12:15:01 -0700 (PDT)
Date:   Fri, 13 May 2022 12:14:59 -0700
From:   David Vernet <void@manifault.com>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        hannes@cmpxchg.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        tj@kernel.org, Richard Palethorpe <rpalethorpe@suse.de>
Subject: Re: [PATCH 4/4] selftests: memcg: Remove protection from top level
 memcg
Message-ID: <20220513191459.qgnmnu62xgxvhx5z@dev0025.ash9.facebook.com>
References: <20220512174452.tr34tuh4k5jm6qjs@dev0025.ash9.facebook.com>
 <20220513171811.730-1-mkoutny@suse.com>
 <20220513171811.730-5-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220513171811.730-5-mkoutny@suse.com>
User-Agent: NeoMutt/20211029
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 13, 2022 at 07:18:11PM +0200, Michal Koutný wrote:
> The reclaim is triggered by memory limit in a subtree, therefore the
> testcase does not need configured protection against external reclaim.
> 
> Also, correct/deduplicate respective comments
> 
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>  tools/testing/selftests/cgroup/test_memcontrol.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> index 9ffacf024bbd..9d370aafd799 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -247,7 +247,7 @@ static int cg_test_proc_killed(const char *cgroup)
>  
>  /*
>   * First, this test creates the following hierarchy:
> - * A       memory.min = 50M,  memory.max = 200M
> + * A       memory.min = 0,    memory.max = 200M
>   * A/B     memory.min = 50M,  memory.current = 50M
>   * A/B/C   memory.min = 75M,  memory.current = 50M
>   * A/B/D   memory.min = 25M,  memory.current = 50M
> @@ -257,7 +257,7 @@ static int cg_test_proc_killed(const char *cgroup)
>   * Usages are pagecache, but the test keeps a running
>   * process in every leaf cgroup.
>   * Then it creates A/G and creates a significant
> - * memory pressure in it.
> + * memory pressure in A.
>   *
>   * A/B    memory.current ~= 50M
>   * A/B/C  memory.current ~= 29M
> @@ -335,8 +335,6 @@ static int test_memcg_min(const char *root)
>  			      (void *)(long)fd);
>  	}
>  
> -	if (cg_write(parent[0], "memory.min", "50M"))
> -		goto cleanup;
>  	if (cg_write(parent[1], "memory.min", "50M"))
>  		goto cleanup;
>  	if (cg_write(children[0], "memory.min", "75M"))
> @@ -404,8 +402,8 @@ static int test_memcg_min(const char *root)
>  
>  /*
>   * First, this test creates the following hierarchy:
> - * A       memory.low = 50M,  memory.max = 200M
> - * A/B     memory.low = 50M,  memory.current = 50M
> + * A       memory.low = 0,    memory.max = 200M
> + * A/B     memory.low = 50M,  memory.current = ...

Is there a reason that we would adjust this comment but not the A/B comment
from above in from test_memcg_low()? In both cases, I would just remove the
memory.current = ... part altogether, as Roman suggested.

>   * A/B/C   memory.low = 75M,  memory.current = 50M
>   * A/B/D   memory.low = 25M,  memory.current = 50M
>   * A/B/E   memory.low = 0,    memory.current = 50M
> @@ -490,8 +488,6 @@ static int test_memcg_low(const char *root)
>  			goto cleanup;
>  	}
>  
> -	if (cg_write(parent[0], "memory.low", "50M"))
> -		goto cleanup;
>  	if (cg_write(parent[1], "memory.low", "50M"))
>  		goto cleanup;
>  	if (cg_write(children[0], "memory.low", "75M"))
> -- 
> 2.35.3
> 

Looks good otherwise.

Reviewed-by: David Vernet <void@manifault.com>
