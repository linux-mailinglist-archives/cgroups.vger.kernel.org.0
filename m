Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FBE59A4C0
	for <lists+cgroups@lfdr.de>; Fri, 19 Aug 2022 20:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350865AbiHSRyi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Aug 2022 13:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350171AbiHSRyK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Aug 2022 13:54:10 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D2D11A08;
        Fri, 19 Aug 2022 10:33:25 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w14so4691850plp.9;
        Fri, 19 Aug 2022 10:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc;
        bh=fqadMmXWI3FPz7mWQ1shnlAoTXiP9jnMsgjYOJuOFoo=;
        b=XLoC5u3RQueoGHx7vAILKwaXo9QAjQrU4TwhNNPQBOd1CnzLc6TQpxCmCFhiADzo2M
         vVzngvi3WWgBQbHqiBk3ZDLCAUuPjsOGvq+AGpzzL5J1EfxslGp6P0d16cIryfiH4y/n
         xkTma1UrGwx13EnmFlj+t92DXI+pb/J7lFFi07Y6kiEK594GfromCsbC9ArT89I/NTo9
         arjB8kANy2CdiyZSmvdv0vmifeMOLkJ7YYPu32SOgSPlcSb/X+g3dYWd/lAAaArmjvvn
         mSD19RWLbvEOBRRoOKBhYlBNuq2YnHIzJg8JAJEyfRCobB7OkDORfs/qQOxdqjBkUUAH
         mGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc;
        bh=fqadMmXWI3FPz7mWQ1shnlAoTXiP9jnMsgjYOJuOFoo=;
        b=Us/QqrwaU8wtgIj5UZIzhCXKKTUbS/tRxWgL+qmDZR71NnWzqn1Ny0qrkrFPu14bil
         NfMRqIZvHub3+87Re3UHajn3l8OC39y4JgsJLoKDGoV4Cz3KiS5NhAH5HsrZsT+oXHaR
         ZdwdXtHXqUz4dKBZiuHy2QW8PMW+kffNrU2u7XWC8BKmL13SkW13YEe5aj6/2r8hQnVw
         FmXg5Ji4kpzFF3yGeMQ1uOEveSWMui3von3RAyQgjzy9txQqSiEMoF7GRrBrs8kNU8E9
         t65RbRuWAfxiTXz02DUn7NrqmNW45ea/SjEeenCXBnhEQn4BVsXRlwW6vyMRQqAPgx3N
         ZNXA==
X-Gm-Message-State: ACgBeo2+gLWUOPLK4S9abG7kQ2zkkwbR9/zGsAR1mCT7yd1QZOaQNQfx
        MtIXy50qembD1i9gjQ6cjl4=
X-Google-Smtp-Source: AA6agR6oscwM7f9Y+IO+Kt+o2d0lLW6v3d+P4w7KCUmrGv6Fk8Oyu9zHo8XEtW7WcMdJO+Rj6oAyEA==
X-Received: by 2002:a17:903:18a:b0:16f:9027:60dc with SMTP id z10-20020a170903018a00b0016f902760dcmr8243997plg.147.1660930404825;
        Fri, 19 Aug 2022 10:33:24 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:db7d])
        by smtp.gmail.com with ESMTPSA id s2-20020a170903200200b00172cb8b97a8sm279412pla.5.2022.08.19.10.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 10:33:24 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 19 Aug 2022 07:33:22 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     mkoutny@suse.com, axboe@kernel.dk, ming.lei@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai3@huawei.com >> yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v7 4/9] blk-throttle: fix io hung due to configuration
 updates
Message-ID: <Yv/JYrqLygLAX56N@slm.duckdns.org>
References: <20220802140415.2960284-1-yukuai1@huaweicloud.com>
 <20220802140415.2960284-5-yukuai1@huaweicloud.com>
 <Yvv3jcycOguuEbA3@slm.duckdns.org>
 <215b4842-c09f-d622-7127-c8b1d9ce3aa9@huaweicloud.com>
 <Yv0q7T5Eg6MzOIuU@slm.duckdns.org>
 <d82305ef-1672-a648-f0b6-882bef1659f1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d82305ef-1672-a648-f0b6-882bef1659f1@huaweicloud.com>
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

On Thu, Aug 18, 2022 at 09:16:28AM +0800, Yu Kuai wrote:
> 在 2022/08/18 1:52, Tejun Heo 写道:
> > On Wed, Aug 17, 2022 at 09:30:30AM +0800, Yu Kuai wrote:
> > > > Would it be easier if the fields were signed? It's fragile and odd to
> > > > explain "these are unsigned but if they underflow they behave just like
> > > > signed when added" when they can just be signed. Also, I have a hard time
> > > > understand what "preempt" means above.
> > > 
> > > I think preempt shound never happen based on current FIFO
> > > implementation, perhaps
> > 
> > Can you elaborate what "preempt" is?
> 
> Here preempt means that the bio that is throttled later somehow get
> dispatched earlier, Michal thinks it's better to comment that the code
> still works fine in this particular scenario.

You'd have to spell it out. It's not clear "preempt" means the above.

> > How about carryover_{ios|bytes}?
> 
> Yes, that sounds good.
> 
> By the way, should I use 'ios' here instead of 'io'? I was confused
> because there are many places that is using 'io' currently.

Yeah, blk-throttle.c is kinda inconsistent about that. It uses bytes/ios in
some places and bytes/io in others. I'd prefer ios here.

Thanks.

-- 
tejun
