Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F9953955A
	for <lists+cgroups@lfdr.de>; Tue, 31 May 2022 19:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346486AbiEaRTf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 May 2022 13:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbiEaRTf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 May 2022 13:19:35 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77AF14022;
        Tue, 31 May 2022 10:19:33 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gd1so6207066pjb.2;
        Tue, 31 May 2022 10:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TifpfMoDlGxLgqXOhSyuPYzc2dB196x72BY7fE2wUZk=;
        b=NX1qO31Nmah+xqNr6YcOYiJumlgg7+QsK1AYsMYODbBoAwGGqI4wTQpZGnBMJ+E9yF
         mzTLek8eUCaBAtCzBt0RCWIu1CNWH0oAjRLN1kZ4+UHLZI9Uj2OEHZUSnR+exDoYAwe1
         0H1CEqjc+D9COgvl3QskBuO6vXXcqsLYAkQWawKc6B6G3xXMlv3jZpOLFH6JJWkBdK7/
         b7chkKFHxD9s1OhJshxp5APXdWd4Jso6xosmRmVJ75DCO3s3qNoznXFYBrCvScciW03j
         IA9JfblnJHNiesH0Xs+VMZxl4yJxnqC6svpsDJklGI3VFA3jjtYqAHp0qFi1iTtiy0pY
         S27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=TifpfMoDlGxLgqXOhSyuPYzc2dB196x72BY7fE2wUZk=;
        b=GriZLBzZQ0pnqy3/TN/LOBs4Oz3lftyuvITWatfca4QPFZRMvV7zv6JDg66J6+mV3K
         4U1Klj8rD3nlCl+Tbkg8w8rAEWYQCAuv3LCegM5TLDpNDc9EMEjf/DEaOzwiVJN1bF0O
         P4ifkdVkOj6QhvB6FTWil7nomHRVeJsG4X/VyA+i2UGqCYbES53mDm/LZBQ70iIZq446
         Az3KWQ7tnksWzJFz/baRH2f2pRfeEaH1Fi+K1cg2vylnBz1a2Khj4NcDeKdjQmqSwz8T
         hIbE6pnAZivZNItt1agbEEV1U1AuhPa76Ah0ivs8IUGoeVXDT4R4hDkzO3w9IqCxwD/l
         cWfA==
X-Gm-Message-State: AOAM532KsIgXnfw0ct1/T363VN7PFxrN6JUghL4+9yHihANp0xQbARc3
        dv2fQbdef3wjnEY5ZFpaHBbstlfbYxw=
X-Google-Smtp-Source: ABdhPJwz1OHWUtwFYQIM887NnX/DQqp7bnnPcVaaeuCc9yijbGKNF4LtG4+f/A18ltX3J4oLsKEY+A==
X-Received: by 2002:a17:90a:bd89:b0:1e3:50de:5ccf with SMTP id z9-20020a17090abd8900b001e350de5ccfmr1482046pjr.104.1654017573119;
        Tue, 31 May 2022 10:19:33 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:987b])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090a390c00b001dc37aef4ffsm2274266pjb.48.2022.05.31.10.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 10:19:32 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 31 May 2022 07:19:31 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Hongchen Zhang <zhanghongchen@loongson.cn>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: wait for css offline when rmdir
Message-ID: <YpZOIz/CbQs+aWF6@slm.duckdns.org>
References: <1653619158-27607-1-git-send-email-zhanghongchen@loongson.cn>
 <YpCQZ5RRnxwh7fmK@slm.duckdns.org>
 <e74e03f1-cb54-b158-a085-2965fd088d1d@loongson.cn>
 <YpVo4XiIDu68w40Z@slm.duckdns.org>
 <fbb820c5-dbcb-0f00-c365-d3c57ca27edf@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbb820c5-dbcb-0f00-c365-d3c57ca27edf@loongson.cn>
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

On Tue, May 31, 2022 at 11:49:53AM +0800, Hongchen Zhang wrote:
> Yes, the problem would disappear when add some reasonable delay. But I think

It'd be better to wait for some group of operations to complete than
inserting explicit delays.

> if we can increase the MEM_CGROUP_ID_MAX to INT_MAX.Thus the -ENOMEM error
> would be never occured,even if the system is out of memory.

Oh, you're hitting the memcg ID limit, not the css one. Memcg id is limited
so that it doesn't consume as many bits in, I guess, struct page. I don't
think it'd make sense to increase overall overhead to solve this rather
artificial problem tho.

Maybe just keep the sequence numbers for started and completed offline
operations and wait for completed# to reach the started# on memcg alloc
failure and retry? Note that we can get live locked, so have to remember the
sequence number to wait for at the beginning. Or, even simpler, maybe it'd
be enough to just do synchronize_rcu() and then wait for the offline wait
once and retry.

Thanks.

-- 
tejun
