Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B935662E4C
	for <lists+cgroups@lfdr.de>; Mon,  9 Jan 2023 19:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237234AbjAISKS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Jan 2023 13:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237291AbjAISI5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Jan 2023 13:08:57 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1BC232;
        Mon,  9 Jan 2023 10:08:40 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id q9so6444975pgq.5;
        Mon, 09 Jan 2023 10:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v8mDl6z8HZB+9Kmvxhak2TbVtn9xL/oPkERHONVaK/o=;
        b=IrAiD+WenjCOrXbXt8CHP0KM/kRGlzZglFdJYig8j5c+YduPyy214fU95mZg19YZkQ
         6If8TiMTCLETa696jiUhr8lxUtbHqo/oWKanSDA1M81PLYUn5V8qOopxrztev4v2o+xS
         V2WA8iphWw18eOMfI2BgQAfYq1ZX2nlK2k5EoWL9e5OUP6fgSnLqENq/CIg9Sh9q6iu4
         vV+CoMLnAbgl8Fzj2B+BU+TrePgajPu1J04qyNvFN2hRraF72WvETFCxK7Xy32dwolKT
         aKdW3jdopXXVKJ7gmLyeqSd2CfFnMBbrBjyC614BjE2lw+mf0XsK77jr5I5etdCJOh6A
         0MHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8mDl6z8HZB+9Kmvxhak2TbVtn9xL/oPkERHONVaK/o=;
        b=39JLb+tqVUa57D27OmnDZbbowm7WmniRk4DFjqrabzcND/jC4WaBCH6aWxDqv4+jbA
         Vp4R5vMCgleg/XdASu0yCHqf4dQj0nJrUl3gKDcgeBs1CwNTwYZZMWYq90nawMIkC7xP
         4qI6NmEadrTwLW5HjsH24LW+Jw6J4GVw/0SeDIimzw/puEHnPBCD0sPCIKP/Tv+ai/Lx
         +WhJLpY8bXC/c/VREMoNjWivmQhAjyJbUyfTj+emHTqgzme/5f45IdUjlNNrYLe9UDvd
         8qM+tqrJhtiE1RjUMnS0pu+UAqvunkARumdjpqqYXfiCc8IWGz7I/Yx0HAeJ4a78V6bo
         XJbg==
X-Gm-Message-State: AFqh2krUpwYnOZY/wPEu78WxcG0THPClhtXuRDE1u5VRzKkIJzKqq5gv
        pjijonAvFdBWEtxaeSURZjA=
X-Google-Smtp-Source: AMrXdXvF6SQqW4OIsHaOrTkEXKKQcWrsf8pD0JyZy4xDSSGlS0ZUbM9NQXxmWMDmJpbz+9pRCA2+1w==
X-Received: by 2002:aa7:96f9:0:b0:582:7007:3fec with SMTP id i25-20020aa796f9000000b0058270073fecmr29248932pfq.11.1673287719766;
        Mon, 09 Jan 2023 10:08:39 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 186-20020a6216c3000000b0057fec210d33sm5215812pfw.152.2023.01.09.10.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 10:08:39 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 9 Jan 2023 08:08:37 -1000
From:   Tejun Heo <tj@kernel.org>
To:     hanjinke <hanjinke.666@bytedance.com>
Cc:     Jan Kara <jack@suse.cz>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com
Subject: Re: [External] Re: [PATCH v3] blk-throtl: Introduce sync and async
 queues for blk-throtl
Message-ID: <Y7xYJfRLSMYk9tj9@slm.duckdns.org>
References: <20221226130505.7186-1-hanjinke.666@bytedance.com>
 <20230105161854.GA1259@blackbody.suse.cz>
 <20230106153813.4ttyuikzaagkk2sc@quack3>
 <Y7hTHZQYsCX6EHIN@slm.duckdns.org>
 <c839ba6c-80ac-6d92-af64-5c0e1956ae93@bytedance.com>
 <Y7hlX4T1UOmQHiGf@slm.duckdns.org>
 <e499f088-8ed9-2e19-b2e5-efaa4f9738f0@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e499f088-8ed9-2e19-b2e5-efaa4f9738f0@bytedance.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Sat, Jan 07, 2023 at 12:44:35PM +0800, hanjinke wrote:
> For cost.model setting, We first use the tools iocost provided to test the
> benchmark model parameters of different types of disks online, and then save
> these benchmark parameters to a parametric Model Table. During the
> deployment process, pull and set the corresponding model parameters
> according to the type of disk.
> 
> The setting of cost.qos should be considered slightly more，we need to make
> some compromises between overall disk throughput and io latency.
> The average disk utilization of the entire disk on a specific business and
> the RLA（if it is io sensitive） of key businesses will be taken as
> important input considerations. The cost.qos will be dynamically fine-tuned
> according to the health status monitoring of key businesses.

Ah, I see. Do you use the latency targets and min/max ranges or just fixate
the vrate by setting min == max?

> For cost.weight setting, high-priority services  will gain greater
> advantages through weight settings to deal with a large number of io
> requests in a short period of time. It works fine as work-conservation
> of iocost works well according to our observation.

Glad to hear.

> These practices can be done better and I look forward to your better
> suggestions.

It's still in progress but resctl-bench's iocost-tune benchmark is what
we're starting to use:

 https://github.com/facebookexperimental/resctl-demo/blob/main/resctl-bench/doc/iocost-tune.md

The benchmark takes like 6 hours and what it does is probing the whole vrate
range looking for behavior inflection points given the scenario of
protecting a latency sensitive workload against memory leak. On completion,
it provides several solutions based on the behavior observed.

The benchmark is destructive (to the content on the target ssd) and can be
tricky to set up. There's installable image to help setting up and running
the benchmark:

 https://github.com/iocost-benchmark/resctl-demo-image-recipe/actions

The eventual goal is collecting these benchmark results in the following git
repo:

 https://github.com/iocost-benchmark/iocost-benchmarks

which generates hwdb files describing all the found solution and make
systemd apply the appropriate configuration on boot automatically.

It's still all a work in progress but hopefully we should be able to
configure iocost reasonably on boot on most SSDs.

Thanks.

-- 
tejun
