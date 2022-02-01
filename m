Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDAC4A623E
	for <lists+cgroups@lfdr.de>; Tue,  1 Feb 2022 18:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbiBARUi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Feb 2022 12:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiBARUg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Feb 2022 12:20:36 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CB1C061714;
        Tue,  1 Feb 2022 09:20:35 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id j16so15924431plx.4;
        Tue, 01 Feb 2022 09:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P/OM7TjxmbJXWO65CCc5u6gW1j1hf5TT48SuvRQUGM4=;
        b=Th2pE7IdvVAvL27K0Qf/WfMwKXepCYHz0caGuE/hHj2a/Cnls+2LvQk4pd0hPSsVmc
         /P6uhuhZiLl+17CpwiopYhBR/qCtJBVssgTbQdYnIISNQERS2GZ14qq/Hg7eUUCaN674
         VCwtBPI4DwClaYXcyxJN+XKveP7T7CfMg5ljyW3+GK7dyKLOmA8hFBXrPEcKThr76/Z1
         McM98ys2DJwA4II8akyGsTpeN9bHmMtE68PaVABB+oTwu+4yN2ONkyGt3QHviGejnNXf
         7GgXGq04oayAGMEjV9a1B4yP0UFh2KbtUdz2IDGrTo7ZtGrKniUuXyFMvj/ITBpXNTId
         pHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=P/OM7TjxmbJXWO65CCc5u6gW1j1hf5TT48SuvRQUGM4=;
        b=nuphlPTDXdkwSDnUWH6Ss4nCdRdRM01kQ/PnJVhFMY2drww3RLAKnddClVatJzm4ju
         G+AB6hS2MZulCp70yX3pqVTkVScVvjBg8fDV0DJ26PJYkZD4eu0EAmMjbaWxiP1RB49A
         +JMPrhUwcXVUFYgEyE+Ip3tLosSnBbwqddRu03TW0yLJkx+10lHPm3afWK3cDdSr76lk
         YIQgQlIBbENFCkt5wP6KKbbGFaYlm/UPtclylwqpuhJvQ3bnMIvZJTajVd6VErs2qPOj
         FlvfytpnS7AW+hgBrSGK8qymxDykqjyutbBblDGgSt/e/yyWm8RbygMx4WZjFRvu+Oax
         Cmbg==
X-Gm-Message-State: AOAM530FgnFIe+8gwqdIiSh7X5EdtGuXGy9n309ybF87mfrXei6StaOc
        s1oZSYfjysQvzR0DjwUgsjQ=
X-Google-Smtp-Source: ABdhPJyk13e7IHTfwNVZ5H4BVDaKYyNxLipIUGhMx2bZAPAdIiubCpR1ZgCsi1FvSg/sKK/5ZB7m1A==
X-Received: by 2002:a17:90b:3144:: with SMTP id ip4mr3488407pjb.23.1643736035151;
        Tue, 01 Feb 2022 09:20:35 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id a1sm31598385pgg.18.2022.02.01.09.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 09:20:34 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 1 Feb 2022 07:20:32 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next] blk-throttle: enable io throttle for root in
 cgroup v2
Message-ID: <Yflr4FzUTWsiLTC/@slm.duckdns.org>
References: <20220114093000.3323470-1-yukuai3@huawei.com>
 <YfGE9L4i7DtNTo08@slm.duckdns.org>
 <235b0757-d322-2b6e-3ab6-ecc8c82f8f1e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <235b0757-d322-2b6e-3ab6-ecc8c82f8f1e@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Jan 27, 2022 at 10:36:38AM +0800, yukuai (C) wrote:
> In our case, the disk is provided by server, and such disk can be shared
> by multipul clients. Thus for the client side, the server is a higher
> level parent.
> 
> Theoretically, limit the io from server for each client is feasible,
> however, the main reason we don't want to do this is the following
> shortcoming:
> 
> client can still send io to server unlimited, we can just limit the
> amount of io that can complete from server, which might cause too much
> pressure on the server side.

I don't quite follow the "send io to server unlimited" part. Doesn't that
get limited by available number of requests? ie. if the server throttles,
the in-flight requests will take longer to complete which exhausts the
available requests and thus slows down the client. That's how it's supposed
to work on the local machine too.

Thanks.

-- 
tejun
