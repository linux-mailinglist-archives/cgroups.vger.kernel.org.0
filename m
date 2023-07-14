Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBD17542C5
	for <lists+cgroups@lfdr.de>; Fri, 14 Jul 2023 20:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbjGNSp0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jul 2023 14:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236253AbjGNSpZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Jul 2023 14:45:25 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B364635B5;
        Fri, 14 Jul 2023 11:45:08 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-3460b67fdd8so9633995ab.0;
        Fri, 14 Jul 2023 11:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689360307; x=1691952307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f6U7VZRuaLKxLmESL63dysq0/fq4KpyMaA9hEtA1d7I=;
        b=S88eaq7uGIfp4hAWvAnKu/7lHNW5XvbYuDFd3ZRgJfNNbZGOo1Z97yWIFOqlv5QVwG
         iIby0UcSrXcCGkgehrqt+o4jciKEVb8bB+BdcoYXKSpqThQwLff6adlOzh+3NEh5hmbS
         DwQB/whjHkpbiYLqtZeFIDq/FgxPeyT6DcaJ9a4S9y0l3vvHKvcBMo++9N1wULSca2hj
         /5U4QjaIKPUYqcHGEEAa067+IavekfLuk4txR56TJ6qteetfy+yia7/Wc49dUaNB0R+n
         SGVFBKBK3oHRBZDxkxuNHDsKyNgAsO3IucqTAUYsTH26OMrz1lBBqe0+/ugKwXGf+IEd
         uWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689360307; x=1691952307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6U7VZRuaLKxLmESL63dysq0/fq4KpyMaA9hEtA1d7I=;
        b=Yr9VUztqi6AIkxzo/gk9e1GiHlmXvrknZ3o3pzOYprY3woxUR35lO2eREF7rYrqP80
         H3+mS9dIaSyABkdgfP0zr+DX/+63PAz6NFyr8p370FclpU9ZQK4jlmCLI214wcp13VD9
         B3A3ptdsmChYgwokU7MRu3mIBSUUY0JdI5FmywvFlbacpIjDGad13UY3zJCvg+Ep15C9
         cMvJYL2HEqumgEhMqgjqAKL0m26J7M13ihYD+EerAee7/d1eLsWiV1D9KlwKlAz+HM/4
         67Kr2v0Ujvx9gZlAto/oGwhw+aU0CtNTELQOfcQ5JC2yifH65kgd82A2hIYWJZrG/M+K
         DMVg==
X-Gm-Message-State: ABy/qLYyRiAZxTzDgHGHb45wJ0X2IzBaTvLYwZx42QJfiz1aUvJ4/InA
        vyIyU0OEojSeWE0Rriv21ZA=
X-Google-Smtp-Source: APBJJlG5SVV3HQTUqCCXN346fsJmoRXie9pH9EUvnVbgMBPqdFFHXQTE1AyxBPDkIiKVGfnPYBliew==
X-Received: by 2002:a92:904:0:b0:347:73b4:9cf6 with SMTP id y4-20020a920904000000b0034773b49cf6mr4584519ilg.23.1689360307518;
        Fri, 14 Jul 2023 11:45:07 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:cdf5])
        by smtp.gmail.com with ESMTPSA id x16-20020a92d650000000b0033d136f248esm2869978ilp.5.2023.07.14.11.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 11:45:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 14 Jul 2023 08:45:05 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     hannes@cmpxchg.org, lizefan.x@bytedance.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: remove obsolete comment above struct cgroupstats
Message-ID: <ZLGXsYTmjj5Owbj4@slm.duckdns.org>
References: <20230713115938.177428-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713115938.177428-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 13, 2023 at 07:59:38PM +0800, Miaohe Lin wrote:
> There's no flag in the delay accounting structure indicates that the task
> is waiting on IO since commit 1193829da1a6 ("delayacct: cleanup flags in
> struct task_delay_info and functions use it"). So remove the comment.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Applied to cgroup/for-6.6.

Thanks.

-- 
tejun
