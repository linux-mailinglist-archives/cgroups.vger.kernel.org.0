Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400675FA927
	for <lists+cgroups@lfdr.de>; Tue, 11 Oct 2022 02:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiJKAM6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Oct 2022 20:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiJKAMe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Oct 2022 20:12:34 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CEF80537;
        Mon, 10 Oct 2022 17:11:40 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id n18-20020a17090ade9200b0020b0012097cso435701pjv.0;
        Mon, 10 Oct 2022 17:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3HeZ1MWqvHmFwkHFUYY7AasOkcoNUsKqjWhjxCGFgtU=;
        b=qWi1ZwygS7xPmJRW43G176yEDlsQ51unX4GoUg2ea83DXcnYeh+ABvZZD0bQDvQqbD
         7qfX7QOojDNPcnkYxdyfKLeDImoDuUKa+VadF7E/uB7iAEbn/4SZxNtDDvxpNYYTA7Ku
         NkXmrp1R3aEpN/Qww+km5hnZJL9C/NP2oqJJGeS7mEVXAp4kLCN47o+1Zp5bR2wkOxm0
         NzSsXLcoGvme91agEmgMNwYktA9b+ghTzGHz5zIOv3iWDA4rrzyChm3DDvHfI1PNJ94b
         3sQhtKQ8lIiU+0jUyndK7Rd/gu+2IR0mVBAEvzbU12RsexDpxJOxTAwx6TJsVpiSwiZq
         AIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3HeZ1MWqvHmFwkHFUYY7AasOkcoNUsKqjWhjxCGFgtU=;
        b=xgTh/0w1Wf/OdREjs7TNKXBj9TMGQX9If2MeA2uUvPZz5TD5WCpws+57Jq2Ngxk48r
         eNCjF/rmYjC7eAYk6ClqgpucPBISGvRehV0WMKOsJLCZOVP25NbbFov3TxnrQgdt8924
         mgRFhW/mwhhBTH4X4chtdkBRCw4D2Z5yFGcjKzDwMYi2BLLaX9MyjNCssi2Ch6+NJbNI
         cRqpMwefuir/oHqhx99/6KgXSMTwM3UX6GG4zfjyj0EMqG+iUOSHlGN0Jwse3Hz87ico
         KruWYzvSVkO8y6qw0gEf0NjStUe0vD4j+7nio0HOl9OEGI2st1hqL39mTwikrR7JeV8O
         SOjQ==
X-Gm-Message-State: ACrzQf0wv0LQP3zAs2bOXE4re2Yr1GtHbPfWk5SgTCtf+9JjcIks4x8n
        9rJ+AdvLHI0hjYk2zW21fUM=
X-Google-Smtp-Source: AMsMyM7PiKPoIdGhm7wULHRfkzwizC1WE23Jl5wb+PJcxUfum7XiLOYrja5b7h1Vif7X90Ice3gvzg==
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id mw7-20020a17090b4d0700b001ef521cf051mr35385568pjb.164.1665447070580;
        Mon, 10 Oct 2022 17:11:10 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id o67-20020a625a46000000b005628a30a500sm7480405pfb.41.2022.10.10.17.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 17:11:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Oct 2022 14:11:08 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v1 2/3] cgroup: add cgroup_all_get_from_[fd/file]()
Message-ID: <Y0S0nFSyivpU4H0n@slm.duckdns.org>
References: <20221010235845.3379019-1-yosryahmed@google.com>
 <20221010235845.3379019-3-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010235845.3379019-3-yosryahmed@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 10, 2022 at 11:58:44PM +0000, Yosry Ahmed wrote:
> Add cgroup_all_get_from_fd() and cgroup_all_get_from_file() that
> support both cgroup1 and cgroup2.

Looks generally good. How about cgroup_v1v2_ as the prefix?

Thanks.

-- 
tejun
