Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E2F6C6CB9
	for <lists+cgroups@lfdr.de>; Thu, 23 Mar 2023 16:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjCWP4R (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Mar 2023 11:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjCWP4Q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Mar 2023 11:56:16 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4802197A
        for <cgroups@vger.kernel.org>; Thu, 23 Mar 2023 08:56:15 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id g19so1945191qts.9
        for <cgroups@vger.kernel.org>; Thu, 23 Mar 2023 08:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1679586974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=73H5IIveVwCSuj8ISfgz0DD6tM9W3+Bkt6XVlPhAYGQ=;
        b=BOTN3RHikvmNyJ/5BRIscfqCjptXrf8qpEubjPg0OC/Xwy+boUt94/+OfrbOvrjrzs
         cJmWGbxdzfNwYKXLNjFeE4gMQoT6n7Ue/HEG5/LMoEeTKeSw/uGUVJVLhA+eCCAdPAw6
         TtqrrK35mvYRbzkyskIxNy5mDJm9BfKY9K6UzVcc3DGVU9OzF+09jvq6Drjb5mZ2qmVt
         HenjMS5dF/r4y3zFsqrBc6Pye1BCCpqXxrBcHNF0Eo2mmCOm0/3b/V5FU143KRmBza1U
         0t4zXTHbwVZfvfVGehbwYOD9++M2yfXXjOlk6zzl04FgUWlZQ7+y/4hEPkd/CR7pqYbK
         NovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679586974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73H5IIveVwCSuj8ISfgz0DD6tM9W3+Bkt6XVlPhAYGQ=;
        b=iBvwKN0g5e+YhbXuG4x3YkQ0AIQAJIGdveRuYyi5TZlYTPMONwtwEFqfb+mvIQt3iU
         47L/k6AcaYfAL9iZTZ9J4Qbg4wfNoBauczzcxpZbLEgj2LOLopypHk8byP38QsUY4CMa
         +3Bb18Ch4K1x83FhqRpz3Np+wls97v18DBEuAfndUOQveehL5HC8gLlc8VJcSUKy8WdN
         TcPeAPOPzHbQ8newFy07syYHgqEZHRGrqcpYX2elQSNEw64O+BY6QbjsGwk+6oefyfjB
         +5V3RuAsQVhFr85S/fA0//Ro+tQxOdwU7UV6FAjlZJ8Jk6DdEqHjA76Pf30ea/WBTo3r
         viXQ==
X-Gm-Message-State: AO0yUKUdF9ddGp8Je2ulORN7gazlvDyU4lO0GwV2E0rND15UOCpCM+Qw
        npvBMwdIlrXYv97Sl6/3Oyz1Kg==
X-Google-Smtp-Source: AK7set8ZHb51Enf0t/dIsgKw2woHO3ntBPTQ4bYWsu5XGHqtbaXdqba7YQaqZsTNXwWNIceHWF4QLA==
X-Received: by 2002:ac8:5b87:0:b0:3b9:bc8c:c214 with SMTP id a7-20020ac85b87000000b003b9bc8cc214mr9815638qta.31.1679586974671;
        Thu, 23 Mar 2023 08:56:14 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:62db])
        by smtp.gmail.com with ESMTPSA id 201-20020a3708d2000000b007456efa7f73sm8647826qki.85.2023.03.23.08.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 08:56:14 -0700 (PDT)
Date:   Thu, 23 Mar 2023 11:56:13 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Subject: Re: [RFC PATCH 4/7] memcg: sleep during flushing stats in safe
 contexts
Message-ID: <20230323155613.GC739026@cmpxchg.org>
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-5-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323040037.2389095-5-yosryahmed@google.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 23, 2023 at 04:00:34AM +0000, Yosry Ahmed wrote:
> @@ -644,26 +644,26 @@ static void __mem_cgroup_flush_stats(void)
>  		return;
>  
>  	flush_next_time = jiffies_64 + 2*FLUSH_TIME;
> -	cgroup_rstat_flush(root_mem_cgroup->css.cgroup, false);
> +	cgroup_rstat_flush(root_mem_cgroup->css.cgroup, may_sleep);

How is it safe to call this with may_sleep=true when it's holding the
stats_flush_lock?

>  	atomic_set(&stats_flush_threshold, 0);
>  	spin_unlock(&stats_flush_lock);
>  }
