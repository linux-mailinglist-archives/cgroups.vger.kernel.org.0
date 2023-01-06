Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2E5660528
	for <lists+cgroups@lfdr.de>; Fri,  6 Jan 2023 17:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbjAFQ6M (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Jan 2023 11:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbjAFQ6K (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 Jan 2023 11:58:10 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B5678A7A;
        Fri,  6 Jan 2023 08:58:08 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d3so2212547plr.10;
        Fri, 06 Jan 2023 08:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=snReoJ52ndOwVl0ihFne37Ntk/YfJwEwK939SBaIpCs=;
        b=Gx4xxHNFjIVJ/RowxB+wt373DC9fu+a85w9xTcZD8wARaeDbA3mxC/HyWuGb/ZeYqo
         PY68+XpwGGM2iTW5bU2vmHoqPKqEK2v7dDsrIAqu70HLSDIWC+Hwh5FC1NX6sSGpGCc6
         LSBdG8LBPd+JCFyu4atqv2TiZQgf8cZhOs9+Y/bAsdcJd7V81VxcIcfss1N8XLHv1djY
         CYx3y9m8FJNmh94zY/LasS6vhHg8gj5iyd2cs9kb1bL0G+TT/I94Dw0oiTJcZfzC1aFJ
         LLvbzhY/wziR1nvD96f2rXcMGCDchif+jWC5dAoOLWmEJYeJTz7BJc2GGA7rbSta4Bjt
         7+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snReoJ52ndOwVl0ihFne37Ntk/YfJwEwK939SBaIpCs=;
        b=TF/ehhUwPkxSOHTjZj1Sxuz+IvJTaqF16yVS5+5nV/6Up9P0cWxyiF52wg/Jf1Rg2S
         rMjs2tHnvtsDXiWtI42sCWhKWechX9BKenmx3KHSJTATGJDoVGF8vyGRdIUFYehQVJii
         H823WDVY/9QFeuYHvi3nEgm02wVOFuDmo28OpY4m1t7csP0vWHTDAvgALCJKn2I2zV3A
         xbnkENYgCaOiU9C1lAI/Cu/FnmRYL96rqmb9VeZ5e3vtYrbK68RahXioJ+1Ltc+EYFSg
         QzcNIeiQeMqZVzHm/A499NcCPpKg8iTAjxtc2OpqHy8pABC4kokZwZsJnnL7ym/LX6TH
         oprw==
X-Gm-Message-State: AFqh2kojqsP1IqId1H+ef2XepZUaG0KN8zUK5NtqNBe/6BSmfvalLNo8
        vB2nFw0/TiGWm4WXjjQyDqQ=
X-Google-Smtp-Source: AMrXdXsDW4929A4MkXhaXCwzQQ1ZTDCiZn/Ajnx6m9C3NPQSGbD5nxp7TRc1O11v6UzXqEwsXkorPA==
X-Received: by 2002:a17:902:cad5:b0:193:12fd:a2e3 with SMTP id y21-20020a170902cad500b0019312fda2e3mr1334668pld.55.1673024288168;
        Fri, 06 Jan 2023 08:58:08 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id g21-20020a170902869500b001745662d568sm1118025plo.278.2023.01.06.08.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 08:58:07 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 6 Jan 2023 06:58:05 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Jinke Han <hanjinke.666@bytedance.com>, josef@toxicpanda.com,
        axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com
Subject: Re: [PATCH v3] blk-throtl: Introduce sync and async queues for
 blk-throtl
Message-ID: <Y7hTHZQYsCX6EHIN@slm.duckdns.org>
References: <20221226130505.7186-1-hanjinke.666@bytedance.com>
 <20230105161854.GA1259@blackbody.suse.cz>
 <20230106153813.4ttyuikzaagkk2sc@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106153813.4ttyuikzaagkk2sc@quack3>
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

On Fri, Jan 06, 2023 at 04:38:13PM +0100, Jan Kara wrote:
> Generally, problems are this are taken care of by IO schedulers. E.g. BFQ
> has quite a lot of logic exactly to reduce problems like this. Sync and
> async queues are one part of this logic inside BFQ (but there's more).

With modern ssd's, even deadline's overhead is too high and a lot (but
clearly not all) of what the IO schedulers do are no longer necessary. I
don't see a good way back to elevators.

> But given current architecture of the block layer IO schedulers are below
> throttling frameworks such as blk-throtl so they have no chance of
> influencing problems like this. So we are bound to reinvent the scheduling
> logic IO schedulers are already doing. That being said I don't have a good
> solution for this or architecture suggestion. Because implementing various
> throttling frameworks within IO schedulers is cumbersome (complex
> interactions) and generally the perfomance is too slow for some usecases.
> We've been there (that's why there's cgroup support in BFQ) and really
> the current architecture is much easier to reason about.

Another layering problem w/ controlling from elevators is that that's after
request allocation and the issuer has already moved on. We used to have
per-cgroup rq pools but ripped that out, so it's pretty easy to cause severe
priority inversions by depleting the shared request pool, and the fact that
throttling takes place after the issuing task returned from issue path makes
propagating the throttling operation upwards more challenging too.

At least in terms of cgroup control, the new bio based behavior is a lot
better. In the fb fleet, iocost is deployed on most (virtually all) of the
machines and we don't see issues with severe priority inversions.
Cross-cgroup control is pretty well controlled. Inside each cgroup, sync
writes aren't prioritized but nobody seems to be troubled by that.

My bet is that inversion issues are a lot more severe with blk-throttle
because it's not work-conserving and not doing things like issue-as-root or
other measures to alleviate issues which can arise from inversions.

Jinke, is the case you described in the original email what you actually saw
in production or a simplified test case for demonstration? If the latter,
can you describe actual problems seen in production?

Thanks.

-- 
tejun
