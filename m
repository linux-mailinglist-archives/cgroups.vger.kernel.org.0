Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35ACF723000
	for <lists+cgroups@lfdr.de>; Mon,  5 Jun 2023 21:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjFETpw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Jun 2023 15:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbjFETpv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Jun 2023 15:45:51 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6312AF4
        for <cgroups@vger.kernel.org>; Mon,  5 Jun 2023 12:45:50 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-654f8b56807so2556521b3a.1
        for <cgroups@vger.kernel.org>; Mon, 05 Jun 2023 12:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685994350; x=1688586350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CLJjoRijX39qGK5LPRbYndMR8lqM5lKT2Fd/Bv8D+Tc=;
        b=cXuyf6HNCJJfgVm6i5ADAOZHQYvhVQxixTCWYyskiViNPZlauTUS+ay7hbYMBpAptX
         34MGPT7SP1gW1P5Szb9wF8AhssJsXWaR5Mhsd+wDpZPLWncnpBaI6A2ujyKx1Z6QtizX
         L3RsQVnJQbWPQEv99HiHTDBfXJXRj1U+lfmczjHUPZLCL8NJKOD1CJMOKuvi5keGo2NL
         hUenxwQBPUFYRL562zIa7NBzqBMC7htAaUNZkBknNDyNh9Sfn6H/9tpliwTVrhmacC5m
         poM+xYOpS0VR64Tw7yUX9gzCDY9ErFK0zHOck9hYwTVaCAvvb6el6NmiBmF/Fj3Q0JgB
         pD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685994350; x=1688586350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLJjoRijX39qGK5LPRbYndMR8lqM5lKT2Fd/Bv8D+Tc=;
        b=Q9Fa5M9Js/p17RkudkZWuEWZJXZawPTy4rUdE2QLjVIaxaISUy8CkEwO0d7YwIP3PV
         U+tdO8vIem5pZLC1H9a3JSVl3/qA6awBW4DxnhvINNQY12kP6ioLWlfNFrLks1PHameN
         L8viBB4q0NnhcO2fBiGwa1ZhnVjPDE8UZziibQief9m/a9x7RE5ITC4hCj3czbN1+PCb
         QRUBhVhtRBvf9NM0EfBBr5iBn5t2ksFcUbt2ZBGWwioTlgt68NEhQVqO/4lxqdK4anGa
         JHvYnay8Sf03NcuX2tonTUDsMa6fGvF9JInP6zk2jfLiR+5LXy2OOMc9JC+cDqbuM727
         P8OA==
X-Gm-Message-State: AC+VfDym+DYgGYHs0N6TcqE1nRsQMbpJPqLGUHXOnM1eP/9C/iRE3A8E
        tbhUIt0mtv+cWUtEtaamw7A=
X-Google-Smtp-Source: ACHHUZ6y1nTbWbc2pwcK+ewg9oaipkYHs2+ft/NSo8ynu6AubCeKXsR89GpKuA65AbgOyK57RbWHPA==
X-Received: by 2002:a05:6a20:7286:b0:100:a201:83ce with SMTP id o6-20020a056a20728600b00100a20183cemr125282pzk.9.1685994349677;
        Mon, 05 Jun 2023 12:45:49 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:b318])
        by smtp.gmail.com with ESMTPSA id x21-20020a62fb15000000b0064fff9f540csm5450585pfm.164.2023.06.05.12.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 12:45:49 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 5 Jun 2023 09:45:47 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH -next] rdmacg: fix kernel-doc warnings in rdmacg
Message-ID: <ZH47azG4Cc5fn1vg@slm.duckdns.org>
References: <20230602074456.333840-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602074456.333840-1-cuigaosheng1@huawei.com>
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

On Fri, Jun 02, 2023 at 03:44:56PM +0800, Gaosheng Cui wrote:
> Fix all kernel-doc warnings in rdmacg:
> 
> kernel/cgroup/rdma.c:209: warning: Function parameter or member 'cg'
> not described in 'rdmacg_uncharge_hierarchy'
> kernel/cgroup/rdma.c:230: warning: Function parameter or member 'cg'
> not described in 'rdmacg_uncharge'
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Applied to cgroup/for-6.5.

Thanks.

-- 
tejun
