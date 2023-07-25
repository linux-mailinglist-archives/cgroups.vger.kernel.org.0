Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD78F7624E6
	for <lists+cgroups@lfdr.de>; Tue, 25 Jul 2023 23:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjGYVxO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Jul 2023 17:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjGYVxN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Jul 2023 17:53:13 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016B71FEC;
        Tue, 25 Jul 2023 14:53:11 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-26813cd7a8aso1799278a91.2;
        Tue, 25 Jul 2023 14:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690321990; x=1690926790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0NAyxb3rFJ8DVsDZGRmjKUAotFVj47uT2nzJm7HWZdo=;
        b=BfCSapNPBI0ZoQl7ctCkDeeepZfQfgulGN6gyOx0/0sueOCMg+/WgJwjCPjwW3s7hW
         As1hkOmgewEGqke6eHhJvmEbq87INwhshGea5/sb/WfzBODNRJK7fhdlZToVMq+A1htr
         4ePA7C2h6x9qm2k/fMq/5VJCfu3cr8cuxm1LD0s75OxL9svbACeumsBL+xfUyqbGEgmK
         svKjR8R3RvK+0HnPwQ+l0b9+sPwzgfQsvvJU8Qg+LRE+n0KAup5JxRsWGQYsYoGkEvcI
         9eohhry1vatEoRG1AJ7Fhxb2wYQ3AVE+aSokm9icL/xt4EMOlpExIw/o9wRjVpi42jl9
         ptTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690321990; x=1690926790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NAyxb3rFJ8DVsDZGRmjKUAotFVj47uT2nzJm7HWZdo=;
        b=Sz0neua4AU3ODyst+TEeEPBOV5kT8xd99iy9O/YsjJWasX+gds6Y/ZK7Z8CprtGHy1
         KK7cPJZM1vL//jCrfPiSCIf1jMql32nI9odwmoPj+4mFjIYcCg8Ek/1C56Z2VfnBpFO1
         /PrmpdKyVhwmyaV2nlAZvDIEuzmTy8PmeW4zcKaMV5duRXPzAqOzVoTvFoQF3M5T+qFv
         YVRPx9SgrFhLi7metZoGWFym0Ukh4AWiyfCzsI2ijX+I7sTCQxctPxDA2A9VHUdljYnZ
         wY1eqxZt6oLGXxfK2GLnbBw6xh94JJqnEpk3S3P23VyYQYibfaxpdbOj/S4AhFh59b/K
         j2Zg==
X-Gm-Message-State: ABy/qLbLsK1GtXd6eBXFljvQHEdiIlyE/HF2Da3Pnt62GmvecSJhXC87
        Lw7ufV2IMf3ewGw2QKWXNrx45/uKxf4=
X-Google-Smtp-Source: APBJJlFG2UMXEMbj3dZdKp/vPeue9r8LlszY3oguA+MRLaOuXETQZE+4joNtQh1K1bCju8zLDudaug==
X-Received: by 2002:a17:90b:384d:b0:263:41d2:4e2 with SMTP id nl13-20020a17090b384d00b0026341d204e2mr383740pjb.32.1690321990274;
        Tue, 25 Jul 2023 14:53:10 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:18d])
        by smtp.gmail.com with ESMTPSA id cp7-20020a17090afb8700b0026812c28365sm37497pjb.37.2023.07.25.14.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 14:53:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 25 Jul 2023 11:53:08 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     hannes@cmpxchg.org, lizefan.x@bytedance.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: minor cleanup for cgroup_local_stat_show()
Message-ID: <ZMBERCXR27X_gRAt@slm.duckdns.org>
References: <20230723031932.3152951-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230723031932.3152951-1-linmiaohe@huawei.com>
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

On Sun, Jul 23, 2023 at 11:19:32AM +0800, Miaohe Lin wrote:
> Make it under CONFIG_CGROUP_SCHED to rid of __maybe_unused annotation.
> Also put cgroup_tryget_css() inside CONFIG_CGROUP_SCHED as it's only
> called when CONFIG_CGROUP_SCHED. No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Patch doesn't apply to cgroup/for-6.6. Can you please respin?

Thanks.

-- 
tejun
