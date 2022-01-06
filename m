Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C86486CF0
	for <lists+cgroups@lfdr.de>; Thu,  6 Jan 2022 22:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244797AbiAFVz3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Jan 2022 16:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239471AbiAFVz2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Jan 2022 16:55:28 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332A4C061245;
        Thu,  6 Jan 2022 13:55:28 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id v11so3625317pfu.2;
        Thu, 06 Jan 2022 13:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=baLlX8J8fiaO85yjXAAqEuWMCG9f2mB0MZtSG6XCtsI=;
        b=cxw8HDbt/q+HOmPJeOndfMSKKs6qZF3mxJR8F51mdDj4j41LtWMxrhBRGgusQeuiA+
         8bQ4nmKVrXwHsfSeYSA7gN9CtfGmQOvXdkTzxErRCKb8KjLk9S6WiaLSx3PsKeDuhqla
         4No7o5oXOXihiQTjKOZ+jS0+OKu+JsAND8bD0TvKCnnorVyItdSSqwqGg+ZITAuzUsH4
         ZbNu5RlF8ZEfPjqYKHQp83YwcTH0jvtqz+5el0wNpk5mIQLwlUEmBPiCziNgE5PRcy/V
         D6ybDhDIir0dtCMSEoBH/Cp4tOee6377q65jjrojwDpO0p/h8aIosrbQPX7hiBe2+RqZ
         hb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=baLlX8J8fiaO85yjXAAqEuWMCG9f2mB0MZtSG6XCtsI=;
        b=fG+gz6oJ1pZ1rtFCZiaSb9F0jt3u/CnUtXi3GiKK/48L7yyF6z3iTGCucCXbanNG54
         fe0sv8D5JQqooUmMx9/dlYKHWBSc6hpP1uDRCQHFQ6XsHe4RkatFvoObRp0BsYpN8dQg
         e6DnDHyQdCnYb0A8mylFv+WYMJhhNfz+FjUEzsj68WfDO/wDMnodbiM6jM7YrARmGms2
         O7hQf5QxvZGoIEya3UZzVXyn6kBBwe21WxmOp2fYWVxSFiIG7GHBwHzK+4A0te/pHX1d
         OcPntKeRqRWvkZELaSZfiVt2oZUBPbnvyxrwOFJQEIbI/kZ/HRuDISGs4rE/f5DhAYlm
         LzBw==
X-Gm-Message-State: AOAM533z2qL0R9b2HyjCYPnW6Q7pl972xuYDAa7QdZ3KrLevL9hd2AA/
        tBQ+bM/koPeIODTDk+LM+0g=
X-Google-Smtp-Source: ABdhPJy3EFXHBDOQH4AF0zGAFOCziAz4u+v91tVS0wlLJX/gbwDWepm05nFGg4CUudYPKGJ0Ck2YAw==
X-Received: by 2002:aa7:9705:0:b0:4bb:6897:6b80 with SMTP id a5-20020aa79705000000b004bb68976b80mr62265172pfg.21.1641506127644;
        Thu, 06 Jan 2022 13:55:27 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id o27sm2769514pgm.1.2022.01.06.13.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 13:55:26 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 6 Jan 2022 11:55:24 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cgroup/rstat: check updated_next only for root
Message-ID: <YddlTA/+sBAHGGYo@slm.duckdns.org>
References: <20211225000932.7253-1-richard.weiyang@gmail.com>
 <20211225000932.7253-2-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211225000932.7253-2-richard.weiyang@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Dec 25, 2021 at 12:09:32AM +0000, Wei Yang wrote:
> After commit dc26532aed0a ("cgroup: rstat: punt root-level optimization to
> individual controllers"), each rstat on updated_children list has its
> ->updated_next not NULL.
> 
> This means we can remove the check on ->updated_next, if we make sure
> the subtree from @root is on list, which could be done by checking
> updated_next for root.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

Applied to cgroup/for-5.17 w/ coding style fixes.

Thanks.

-- 
tejun
