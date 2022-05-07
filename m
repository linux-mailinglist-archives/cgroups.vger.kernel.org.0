Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C9151E36D
	for <lists+cgroups@lfdr.de>; Sat,  7 May 2022 04:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356524AbiEGCJP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 May 2022 22:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356477AbiEGCJN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 May 2022 22:09:13 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397751836E;
        Fri,  6 May 2022 19:05:28 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id cu23-20020a17090afa9700b001d98d8e53b7so8854319pjb.0;
        Fri, 06 May 2022 19:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=jalhMSau/4ac1aQTeKEt0TtpRgwPn28KXUpA5qg/su4=;
        b=KRd718Jg9pNqg0PO87qH43qF2rb43W1ldMnyH8wRDwVA955pSBtF2Af3S9Z8RoJy9A
         c4uqDtiZTfE7hmRtXjAlBTkmPZuG8VLUjKfVS5sC4d/snsPe2GfdrXp394cHdt2jfEXd
         rP8jvytgtnjziXev8xgqf2zdJGypsg0FtDsZadiPSu/a4cWRLzCuRnBpyHhbfudhrCYL
         x0+eOlN9Bkc7mzWlg75F55khDRlA7PjdXQQb+mp3dfY3qCyMkspEbSdREXmQSQXFsMLW
         d3WlADCQUxFo0E+OD3dNCf3qmyxe1nDKBdgDN7dDy8NLWumIZzUdnDPoO47ogIY+l8Pg
         ddgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=jalhMSau/4ac1aQTeKEt0TtpRgwPn28KXUpA5qg/su4=;
        b=J9htfiqh8UhnEXNSXmK03zq2zGd29oBgIsi9fhCGBbTPsiIVhxaSHZHrTQSCX4zvT3
         OVdjCmJiFB16sWC6b/jzFUhrcFF5wVxJPWfNtKkCTxrG3Wrx04ajs66NUmLs4txwytqw
         x8786t868fJJzPl8ZLEzcimw0H1H7xvQFxHTgHQzrpzwYcW3mIg4tUdbzozpyqFUxxCO
         xLouISkLyNmpPbg+F4aBdsDGUKt4Kla2GreycSMLFom04GxXwvTGighDgMz1yTtNZSVn
         UzwFujEuTtoBJ0GPzIMpvR8YaATVjoCaKVBZarxtMzsV016PEPB2Vb4ueTRonqOnAuYX
         Bdyw==
X-Gm-Message-State: AOAM531vpH8dddJTB94ZGLa5/l8COEDH3J1H5QIdipEBS19eWdATHs7t
        DYsR4sE+MzuU+YOQf2tPpUk=
X-Google-Smtp-Source: ABdhPJy7T41X/72GySbNn47N0uNkibxJz8jqtoaW1gWqsUShW0gI7XsZ/T1SyHoiX8O5W3qqeJnxnw==
X-Received: by 2002:a17:903:1206:b0:151:7d67:2924 with SMTP id l6-20020a170903120600b001517d672924mr6535189plh.45.1651889127755;
        Fri, 06 May 2022 19:05:27 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d6-20020a170903230600b0015e8d4eb2c5sm1912558plh.271.2022.05.06.19.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 19:05:27 -0700 (PDT)
Message-ID: <6275d3e7.1c69fb81.1d62.4504@mx.google.com>
X-Google-Original-Message-ID: <20220507020525.GA639691@cgel.zte@gmail.com>
Date:   Sat, 7 May 2022 02:05:25 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, willy@infradead.org,
        shy828301@gmail.com, roman.gushchin@linux.dev, shakeelb@google.com,
        linmiaohe@huawei.com, william.kucharski@oracle.com,
        peterx@redhat.com, hughd@google.com, vbabka@suse.cz,
        songmuchun@bytedance.com, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH] mm/memcg: support control THP behaviour in cgroup
References: <20220505033814.103256-1-xu.xin16@zte.com.cn>
 <YnUlntNFR4zeD+qa@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnUlntNFR4zeD+qa@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 06, 2022 at 03:41:50PM +0200, Michal Hocko wrote:
> On Thu 05-05-22 03:38:15, cgel.zte@gmail.com wrote:
> > From: Yang Yang <yang.yang29@zte.com.cn> 
> > 
> > Using THP may promote the performance of memory, but increase memory
> > footprint. Applications may use madvise to decrease footprint, but
> > not all applications support using madvise, and it takes much costs
> > to re-code all the applications. And we notice container becomes more
> > and more popular to manage a set of tasks.
> 
> Could you be more specific about the actual usecase? When do you group
> processes based on their general THP reqirements? You are mentioning
> containers but those are usually bags of different processes that just
> share a common objective.
>
> > So add support for cgroup to control THP behaviour will provide much
> > convenience, administrator may only enable THP for important containers,
> > and disable it for other containers.
> 
> Why would that be a matter of importance?
> 
> Also what is actual semantic when processes living inside those cgroups
> explicitly state their THP requirements?
>
Docker might support this new cgroup knob in the future, add provide UI likes:
# docker run -it --thp-enabled=[always,never,madvise]
The cmdline format from https://docs.docker.com/engine/reference/run/

If there are many containers to run on one host, and some of them have high
performance requirements, administrator could turn on thp for them:
# docker run -it --thp-enabled=always
Then all the processes in those containers will always use thp.
While other containers turn off thp by:
# docker run -it --thp-enabled=never

By doing this we could promote important containers's performance with less
footprint of thp.
> -- 
> Michal Hocko
> SUSE Labs
