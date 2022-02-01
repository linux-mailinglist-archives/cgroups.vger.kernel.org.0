Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC1F4A5438
	for <lists+cgroups@lfdr.de>; Tue,  1 Feb 2022 01:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiBAAml (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 19:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiBAAmk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 19:42:40 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55179C061714;
        Mon, 31 Jan 2022 16:42:40 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a8so48351003ejc.8;
        Mon, 31 Jan 2022 16:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tM48J1r6RkVUujqg3c37yU/BycOtok0R6SCSR/HwO4I=;
        b=UUW3DPdsg1gI2lDGeDXFutTvvI5cYxgHl2wsh3p/ADj0fd46ifjisnczPrI4UjM8N/
         vOVnCmjP0puOYVDH6vyFuJWHTvvw3MF9QDhm52vgjSbVecXUHUwKGvLI7VCj03Yn+70n
         duOs6uAvOx3ewSYFheL0uw3EZlADa2KeTn0TK25CbE7pR7aGYginonT6BMbkFIFP6Wtp
         uc34SUM2eeQ0dXuMqc+tsTdjScmYBkC+RTH8qJyiP6GejSYPbid/1Fhvzj0l88X5dwUF
         xqdS53FSpXlQ7VTaC+JgrZgfimgH1Ox7lT0GtkHtEuRsFE3rYz5wLRlZjPaHOjQ3fDkw
         wphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tM48J1r6RkVUujqg3c37yU/BycOtok0R6SCSR/HwO4I=;
        b=eqSNNNg+TIT0yIkBe9opV8eYQN+d/FREZJ5OpPhDLWL1bNw6haJQqmXYvWUt4UzjyG
         RNLAfWvsbaC0K9ysvwPTT4bYKGHkkO3v1rKXnxc4D4+UfFebp0GkvSWPuOV0SUrOScrB
         EZqtm+mea+AXO1ePmCVKF5JRrCAxk3Fm2yCDJ/UdSvfS7O12bNNoujd4/ImezCaoC0aP
         ZMjIO7IuLiFSAtapmmJIT5tLMNyQbQ6Fq+FX5ye2mZOtQN6oHrIdezbSqKgXPCG8yiw+
         evIPZVOAtH1aEsIvdazlYQorAwGAOusronspomJrzv0Ro8GX5WLak4PfYQ5mVU66KDma
         kbnw==
X-Gm-Message-State: AOAM530vv0039/Uyeog5h9rJHP7R3gCLbgvJooNx4rSqxpG/bJL14zVe
        umCZlqWQ1Z8Ao0Up12zqdn8=
X-Google-Smtp-Source: ABdhPJxY5fgWWILhLGqCxpjBMMlFx486Xl1isTrvEuq8/x1ubfRORcKnjz54hAE4v2urxxFA9gTReA==
X-Received: by 2002:a17:907:1b02:: with SMTP id mp2mr18694773ejc.615.1643676158800;
        Mon, 31 Jan 2022 16:42:38 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id d15sm14199510ejw.143.2022.01.31.16.42.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Jan 2022 16:42:38 -0800 (PST)
Date:   Tue, 1 Feb 2022 00:42:37 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, vbabka@suse.cz, willy@infradead.org,
        songmuchun@bytedance.com, shy828301@gmail.com, surenb@google.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/4] mm/memcg: use NUMA_NO_NODE to indicate allocation
 from unspecified node
Message-ID: <20220201004237.77nqe36aqut6kuxc@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220111010302.8864-1-richard.weiyang@gmail.com>
 <20220131014742.oxcrctcg6sqwvzij@master>
 <20220131143620.b619f24f5246b26bce2b717d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131143620.b619f24f5246b26bce2b717d@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 31, 2022 at 02:36:20PM -0800, Andrew Morton wrote:
>On Mon, 31 Jan 2022 01:47:42 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:
>
>> Hi, Andrew
>> 
>> Would you pick up this patch set, or prefer me to send a v2?
>> 
>
>It's unclear to me what's happening with [4/4].  At least a new
>changelog with more justification is expected?
>

As Michal and Roman suggested, this is not a hot-path. I would drop this one.

>So yes, please resend?

Sure.

-- 
Wei Yang
Help you, Help me
