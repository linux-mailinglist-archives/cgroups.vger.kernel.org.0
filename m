Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F4B486AB1
	for <lists+cgroups@lfdr.de>; Thu,  6 Jan 2022 20:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243448AbiAFTwh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Jan 2022 14:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbiAFTwg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Jan 2022 14:52:36 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149A1C061245;
        Thu,  6 Jan 2022 11:52:36 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id n30-20020a17090a5aa100b001b2b6509685so4278955pji.3;
        Thu, 06 Jan 2022 11:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FMCYSxfBHDKrU2xtUn5iYVpLMUW2H/Uaai2PBAbWbI4=;
        b=kLnEU6mmNacpPREArN2iOC4bExYQSNan1xlnuUEIUu/f9MIY1GKKH0ycKAdCknNg8f
         Mj/AbvEndlEgJczppSeUzmbnj9r41HfyP7xYrXkiU5bhD2L5rYHxHLFYJIGBNLVS7Gj2
         IpEDW8GEOZ2YYJccx9M8lwjJj7Z1sBygpt6vdoFdPSMa86ImKFX9pic6sOOhsj8t/OiO
         J4gWFEzgUTdwygFjwUdI5h0l+aQ/Cu+0+ks7b6t063dHaOeJBk5LcXHt+9W6//uNTqTp
         i6nqtBtF4xN8OHzTDmv6KggQCobF31b72TpRAcV1yCO6erR8ZjH4PABoPbBO0pE8IZ4C
         pwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=FMCYSxfBHDKrU2xtUn5iYVpLMUW2H/Uaai2PBAbWbI4=;
        b=j2BCcGYqXelwDahsHXoUBP55HQ1X4zkkUWo68dLNSAnCcpOdZI26Reoue5WTQnopEW
         cyS7tsY+JrnFu678eoyFDsMLuBcxljxrKEC7vN5lZG42T4/bh9eOUwvk1FHZuQy+ikaW
         wzMoUDTB/VDmJyeKjKXOcdZqx4BvQk2XX2u1bXu12LrUT0xIUH0ot68m2AZyuynv4A5B
         s/DETa+Nvn6dUJp2HvuQoSy+HDoJgcic6IGy0jeWSWRshzJWOXcO2+wduLfNEHanqy6n
         GGML9/OFjM1bpPvqln9QqgZu8QTvZBsgn2uECHUplmL7N4y5IdZYyrcp9erGwfxa/qDv
         W5Vw==
X-Gm-Message-State: AOAM533VbxEpgU6f9Gz7Ljh0BqL5lV7ChnY6qOY+gM+hdoSfX4tw8UeK
        OORawRB3lX6U6lsGu2nSA1Q=
X-Google-Smtp-Source: ABdhPJxbugOz2KK4DK/K/KUtKtQxVTlz5B9ZkIgnkPTWOPAJ78Zp04PUmOnuV/XX+AvMDeOrUrr0Aw==
X-Received: by 2002:a17:903:1108:b0:149:9c03:23ce with SMTP id n8-20020a170903110800b001499c0323cemr36794515plh.140.1641498755527;
        Thu, 06 Jan 2022 11:52:35 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id ot6sm3804199pjb.32.2022.01.06.11.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 11:52:35 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 6 Jan 2022 09:52:33 -1000
From:   Tejun Heo <tj@kernel.org>
To:     QiuLaibin <qiulaibin@huawei.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] blk-throttle: Set BIO_THROTTLED when bio has been
 throttled
Message-ID: <YddIgWU73LabYICc@slm.duckdns.org>
References: <20211118131551.810931-1-qiulaibin@huawei.com>
 <YaUZExR6v8IdZUeM@slm.duckdns.org>
 <03964258-10ff-7f19-10cb-ca4eccf72848@huawei.com>
 <YbepLpyMPqP2ao3J@slm.duckdns.org>
 <8c87a712-93fb-d794-6d08-cadf6452efc3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c87a712-93fb-d794-6d08-cadf6452efc3@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Dec 14, 2021 at 05:12:48PM +0800, QiuLaibin wrote:
> I am thinking of adding a new bio tag (like BIO_THROTTLE_BYPASS) to avoid
> those requests which do not need to be throttled to enter the throttle
> multiple times.

Sorry about the long delay. Was off for several weeks, so my recommendation
would be separating the two issues. It'd make a lot of sense to fix the
immediate bug in a minimal way first.

Thanks.

-- 
tejun
