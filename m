Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B3C6AA0BB
	for <lists+cgroups@lfdr.de>; Fri,  3 Mar 2023 21:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjCCU4o (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Mar 2023 15:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjCCU4n (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Mar 2023 15:56:43 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D621F168A4;
        Fri,  3 Mar 2023 12:56:42 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so7399559pjb.3;
        Fri, 03 Mar 2023 12:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677877002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fjh9IEpIRyNQHewWnw6H4mE9vVwZa4PIB3habustRYM=;
        b=YcOgEPLI7Pxk40hWD3Mrc61wy5H7d33RmImy1dSuT0n4jGUj8+bCu3IGc/pduDoDNP
         D1qe5VQ7yxuzuyqc3/evqmE8QqXcgX0OVNLrCQARJcIhlNXePr0f5m+RdBIjuxKmxgAE
         Ny1FrXP+3lDFuxJrmwArqa5MNDU8AL80bYRhAHPKZN9yKxNUEG2/XnbPi2uMjuAouwim
         7QGe7PZoVhz2SMwK3BOoiE9ORtcdrHAumSQzzZM4SFcycRnJSbsy+7Wu+fxpSIfTlTO+
         tynTtNrbxYrXe9PVRjftdClTEsLfEsILK7GlAllCaveqepfzveMDwsDP8XuqDt2KTIqL
         3j1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677877002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjh9IEpIRyNQHewWnw6H4mE9vVwZa4PIB3habustRYM=;
        b=kifLUyy6mcGIzbEBT1V7jsS7wdJdhrKUy5XYALaCZsMtcEo4/mlru0ojJUzE32ELnG
         TULns5O3oCXE7KoSgZSrSUOu99f/kyGOIeBNFayFXxOmfno+eN3ary8m9CdMTMQjdSpn
         pBcFWmcoQsXTaBfpwJua979hzMtn669KghRU3wW+7nsJRtoCjaDAubXixmlFp02NChAG
         xR7jcB1Vv+a+dFvKm7idHIjwLTKkiifFJ291Vpy79l9hEx3kn/f4yqdztC4P8Lc6ZEXU
         7WLF/RcpCgZloTMWiOyfjo0N6LwkO+ZSGnyooiL8Pnz3szlTbnK+ZI0Mwtl6eZPZj1Y2
         cePw==
X-Gm-Message-State: AO0yUKXaJrY3z+GFpQeN+fUxpgmQnnfPFrcIuCsZuCgi8ETDgSYmnYCL
        ElKCw765WMHycP9E+IuW7fwodX0t5A8=
X-Google-Smtp-Source: AK7set8Rg7RDKbeAplxt/7+7Tu1q5BB6FaMGpY1vkp+vH9xvZF1xovUA3JORx0AXBDPevem23XuVuQ==
X-Received: by 2002:a17:90b:3ec2:b0:237:a500:eca6 with SMTP id rm2-20020a17090b3ec200b00237a500eca6mr6953890pjb.22.1677877002138;
        Fri, 03 Mar 2023 12:56:42 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id b4-20020a17090a488400b00230c8484fbfsm1905578pjh.55.2023.03.03.12.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 12:56:41 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 3 Mar 2023 10:56:39 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kamalesh Babulal <kamalesh.babulal@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        cgroups@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: bpf: use cgroup_lock()/cgroup_unlock() wrappers
Message-ID: <ZAJfB/LuHtE5Iq3i@slm.duckdns.org>
References: <20230303095310.238553-1-kamalesh.babulal@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303095310.238553-1-kamalesh.babulal@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Mar 03, 2023 at 03:23:10PM +0530, Kamalesh Babulal wrote:
> Replace mutex_[un]lock() with cgroup_[un]lock() wrappers to stay
> consistent across cgroup core and other subsystem code, while
> operating on the cgroup_mutex.

cgroup_[un]lock() were added because multi-gen lru wanted to lock
cgroup_mutex from code which may be enabled even when cgroup is not enabled.
That's the only place where that's the case. Hmm... it doesn't really matter
I guess. Yeah, let's do this.

  Acked-by: Tejun Heo <tj@kernel.org>

Alexei, if you wanna take it through the bpf tree, please go ahead.
Otherwise, I can route it through cgroup tree.

Thanks.

-- 
tejun
