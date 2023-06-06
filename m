Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C14B7233FA
	for <lists+cgroups@lfdr.de>; Tue,  6 Jun 2023 02:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjFFAJV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Jun 2023 20:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjFFAJU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Jun 2023 20:09:20 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E9FFA;
        Mon,  5 Jun 2023 17:09:18 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-654f8b56807so2809326b3a.1;
        Mon, 05 Jun 2023 17:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686010158; x=1688602158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z84IZvmzWip89Eeas0z1NQsVyFYK452XIFdNItStgJo=;
        b=hrqPYRMhlf3i8gMrJ2AXc9LXwaaiJbiN9/s2TQXdJBJ80dtZzCntUtMbGD2yPaR5t5
         69JVQjlA6r1ljlN6bELt0TBdxnRRM5Qd38lMvlwgZl3QW2RcW8IKKaMk9TI9vHddTgf0
         zWD5mwak9jULNMU8vsOsHm3u3WdT4TsJ7yIj8yNPECuaKt4x8XSYr0GoUBgMmHdf1MLw
         sfdoULkhA9K/77al/u3iWAO4LxhuwtSxgJWqZyjLUn4wFOt0+Q7XPZ9OM9pTDsfrHgmU
         gtIxFiWJyF/Cbg4jEBFUi2UoSQBYmOzRMzPIWY0nKZK+LtC4TqdUOZnq6RqFg6/7PBfS
         OzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686010158; x=1688602158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z84IZvmzWip89Eeas0z1NQsVyFYK452XIFdNItStgJo=;
        b=T8RzcR88rc/U6LZmeoRYq0G14f/HBeuTkzTVWtavgj9LZs3Y0WL1fC4nTtNvDT7ikB
         vtXkSe18O0VF07oshLRuLj93hCMekYuOg7wUBKz4K43MTmcFnpCmMjGbfTxBp/kLuv2k
         imGww3wR9sY1qSR7rJ/5IfvhFSC3HqeGIA/Z3EzsiEWQf5Lc51vELSxJVEY3i1tSWUQf
         pq3U5jHU4eKaFblw/DOX7nNLBkvhzFs+Y+pf4FY8E42tGLqqjstLVBe9L+bmStgDcHwX
         5n9rdjku/u0105NVgWrmwjLIg1LjGxTbfDIxtmCqqzfQXcfNHjcN+F+4lePDk6eBG2Po
         3H9g==
X-Gm-Message-State: AC+VfDxH761OxAe+Az1rS1RgKN7OxdSh0jMqBtvmv6S/5n1KatKisPWB
        WH/Ly5CJD8bfaHHXYbXKltXL+w419w0=
X-Google-Smtp-Source: ACHHUZ4J0kaXrsmCfj5YsGenu5P3xx5lgX4AqWKOx6ZSv3+F0vXh8bd+gjZiBDMlgN8LucBN8KtSFg==
X-Received: by 2002:a05:6a20:7487:b0:10b:3b0d:b05c with SMTP id p7-20020a056a20748700b0010b3b0db05cmr773322pzd.28.1686010157419;
        Mon, 05 Jun 2023 17:09:17 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id x7-20020aa793a7000000b006475f831838sm5741516pff.30.2023.06.05.17.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 17:09:16 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 5 Jun 2023 14:09:15 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Chris Down <chris@chrisdown.name>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: Clarify usage of memory limits
Message-ID: <ZH55K79CaSD6Zya1@slm.duckdns.org>
References: <20230601183820.3839891-1-schatzberg.dan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601183820.3839891-1-schatzberg.dan@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Jun 01, 2023 at 11:38:19AM -0700, Dan Schatzberg wrote:
> The existing documentation refers to memory.high as the "main mechanism
> to control memory usage." This seems incorrect to me - memory.high can
> result in reclaim pressure which simply leads to stalls unless some
> external component observes and actions on it (e.g. systemd-oomd can be
> used for this purpose). While this is feasible, users are unaware of
> this interaction and are led to believe that memory.high alone is an
> effective mechanism for limiting memory.
> 
> The documentation should recommend the use of memory.max as the
> effective way to enforce memory limits - it triggers reclaim and results
> in OOM kills by itself.
> 
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>

Applied to cgroup/for-6.4-fixes. Please see below for a comment tho.

> @@ -1213,23 +1213,25 @@ PAGE_SIZE multiple when read back.
>  	A read-write single value file which exists on non-root
>  	cgroups.  The default is "max".
>  
> -	Memory usage throttle limit.  This is the main mechanism to
> -	control memory usage of a cgroup.  If a cgroup's usage goes
> +	Memory usage throttle limit.  If a cgroup's usage goes
>  	over the high boundary, the processes of the cgroup are
>  	throttled and put under heavy reclaim pressure.
>  
>  	Going over the high limit never invokes the OOM killer and
> -	under extreme conditions the limit may be breached.
> +	under extreme conditions the limit may be breached. The high
> +	limit should be used in scenarios where an external process
> +	monitors the limited cgroup to alleviate heavy reclaim
> +	pressure.

I think it'd be helpful to provide pointers to oomd and systemd's
implementation of it here.

Thanks.

-- 
tejun
