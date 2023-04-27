Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E616EFE9E
	for <lists+cgroups@lfdr.de>; Thu, 27 Apr 2023 02:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242902AbjD0Apn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Apr 2023 20:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242852AbjD0Apl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Apr 2023 20:45:41 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AA840D2
        for <cgroups@vger.kernel.org>; Wed, 26 Apr 2023 17:45:31 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b7096e2e4so6510911b3a.2
        for <cgroups@vger.kernel.org>; Wed, 26 Apr 2023 17:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682556331; x=1685148331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ts741rvt3EAjVFILrn+Ylxxz4plnfZzZiWZWR2pi4+E=;
        b=X0/KEcMUWIF64/6JcKv0zgFw7E6ZmkGDYstg9d2n+0xZVW4F88EUh6zA77/6TpQGMs
         m7hDdPloutxu/VAItlE5Szi5wAHQKb7SB5rObMOVrSOz8+O7W9C9QnrjhvFlAb7P5jaN
         aU7b4Qu8CWA8HSx3LJzqmehasjFzH3h3W+3P0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682556331; x=1685148331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ts741rvt3EAjVFILrn+Ylxxz4plnfZzZiWZWR2pi4+E=;
        b=Nb2mNDKX0gMfHlSIlWxeDeyduTWFTYPL3qjZd7YrgKNjRE4KPmYbPkKNG1N9G5tpCE
         kSM5lms3br1BNDKZGXKzB0LcDsi7kLYK99fmbbc/UZk5801yXBG6jcYmbX5ebWxyAmJL
         O+RmzE0eWdIBsedR4najdrKw+G9T1nWuuE0R17jtE4q/DNr7Pv8RQzpZkIEBPRsXYPbE
         HS3/WC6JmpgIBoHML4sM7TpjKA6H8/dM50cUctEdmMSkSDT3P8KNSnopnk5Y9B1QrSQP
         QQM8ByjIKqDW8oARxx859vXmCe4fDATmys8weU+ckHriqJXvswzpVLrDSIQzNSUI4KhI
         jh5g==
X-Gm-Message-State: AAQBX9flgc6c+P80kLRidJzCcqAntzKAfQBc/YDXq1PGJ0XE/FhH5y3r
        jXgow3KzQb5ZDwV0LVSf5H1CKA==
X-Google-Smtp-Source: AKy350abCV0zUwJuxCuIiePd9zt1nrxk++4k+RKj3MGLVlWOqLYFnlrIzUaPs6Oi1bh8TuyJ1q7uZA==
X-Received: by 2002:a05:6a00:1a15:b0:63a:d2e4:cc35 with SMTP id g21-20020a056a001a1500b0063ad2e4cc35mr29972082pfv.31.1682556331140;
        Wed, 26 Apr 2023 17:45:31 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id m21-20020a62a215000000b0063f33e216dasm8082880pff.96.2023.04.26.17.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 17:45:30 -0700 (PDT)
Date:   Thu, 27 Apr 2023 09:45:25 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>, Chris Li <chrisl@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] memcg: use seq_buf_do_printk() with
 mem_cgroup_print_oom_meminfo()
Message-ID: <20230427004525.GE1496740@google.com>
References: <20230426133919.1342942-1-yosryahmed@google.com>
 <20230426133919.1342942-2-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426133919.1342942-2-yosryahmed@google.com>
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On (23/04/26 13:39), Yosry Ahmed wrote:
> Currently, we format all the memcg stats into a buffer in
> mem_cgroup_print_oom_meminfo() and use pr_info() to dump it to the logs.
> However, this buffer is large in size. Although it is currently working
> as intended, ther is a dependency between the memcg stats buffer and the
> printk record size limit.
> 
> If we add more stats in the future and the buffer becomes larger than
> the printk record size limit, or if the prink record size limit is
> reduced, the logs may be truncated.
> 
> It is safer to use seq_buf_do_printk(), which will automatically break
> up the buffer at line breaks and issue small printk() calls.
> 
> Refactor the code to move the seq_buf from memory_stat_format() to its
> callers, and use seq_buf_do_printk() to print the seq_buf in
> mem_cgroup_print_oom_meminfo().
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

FWIW,
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
