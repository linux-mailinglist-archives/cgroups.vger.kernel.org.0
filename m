Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2025268AA
	for <lists+cgroups@lfdr.de>; Fri, 13 May 2022 19:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345844AbiEMRmR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 May 2022 13:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349689AbiEMRmQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 May 2022 13:42:16 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8336E3B3DA;
        Fri, 13 May 2022 10:42:14 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id z126so7594503qkb.2;
        Fri, 13 May 2022 10:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=97E4heSYwRBKYVRwXdi6vqHrNTq98nZhg9phqwxgAhQ=;
        b=19BtCJIHeXx6YnUtlZG+Xsgl/V3sPmmrZWTw0FpiVXE+B6xMY+rECSSIqaDxW0cYfz
         Gbab6THd8K47ALkttdapGVg0d1VdEqV/zdHHYz4cqHWgpoC5fcy4vNhxJtfa+tZ6cf/F
         rR/uUQLg3LeaQVbvIotNP7sDefxBf546BqQC24ztr951gbp2gB6MZ3+EPXCAKjYSAKUy
         i+dkPS3sG7p1PRa0SFArPoI4oG6j8LjJLwxeUqIP9+A4bW4UNiil0Sv2X7nsM9cddBSY
         ojzQmLJXpdIFUU9urBATpokDnlP/f/DqrF5mVffkYjEON7ClNA6nma2mOU8/tkHqxtUa
         oUeQ==
X-Gm-Message-State: AOAM532LD8kAvA3Z0Rx2opu8xGKzAdLOe21FEVclr65wP3pi/iW9L/dG
        va1KYWQOJ4K7yabojlGv76A=
X-Google-Smtp-Source: ABdhPJw/SDz0dQHBIutw7pRAimO1JpJHMkuofuWyT/cEabDgF7Kn0Vimv3OrPdeEdfry+uEXmlkDpA==
X-Received: by 2002:a37:98c4:0:b0:69a:e14:16a2 with SMTP id a187-20020a3798c4000000b0069a0e1416a2mr4538933qke.610.1652463733017;
        Fri, 13 May 2022 10:42:13 -0700 (PDT)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-014.fbsv.net. [2a03:2880:20ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id u123-20020ae9d881000000b006a0462eb091sm1634970qkf.80.2022.05.13.10.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 10:42:12 -0700 (PDT)
Date:   Fri, 13 May 2022 10:42:11 -0700
From:   David Vernet <void@manifault.com>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        hannes@cmpxchg.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        tj@kernel.org, Richard Palethorpe <rpalethorpe@suse.de>
Subject: Re: [PATCH 2/4] selftests: memcg: Expect no low events in
 unprotected sibling
Message-ID: <20220513174211.uv5yxzt5sochmwal@dev0025.ash9.facebook.com>
References: <20220512174452.tr34tuh4k5jm6qjs@dev0025.ash9.facebook.com>
 <20220513171811.730-1-mkoutny@suse.com>
 <20220513171811.730-3-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220513171811.730-3-mkoutny@suse.com>
User-Agent: NeoMutt/20211029
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 13, 2022 at 07:18:09PM +0200, Michal Koutný wrote:
> This is effectively a revert of commit cdc69458a5f3 ("cgroup: account
> for memory_recursiveprot in test_memcg_low()"). The case test_memcg_low
> will fail with memory_recursiveprot until resolved in reclaim
> code.
> However, this patch preserves the existing helpers and variables for
> later uses.
> 
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>  tools/testing/selftests/cgroup/test_memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> index 4958b42201a9..eba252fa64ac 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -528,7 +528,7 @@ static int test_memcg_low(const char *root)
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(children); i++) {
> -		int no_low_events_index = has_recursiveprot ? 2 : 1;
> +		int no_low_events_index = 1;
>  
>  		oom = cg_read_key_long(children[i], "memory.events", "oom ");
>  		low = cg_read_key_long(children[i], "memory.events", "low ");
> -- 
> 2.35.3
> 

Reviewed-by: David Vernet <void@manifault.com>
