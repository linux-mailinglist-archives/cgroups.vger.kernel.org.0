Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43FF5E87EF
	for <lists+cgroups@lfdr.de>; Sat, 24 Sep 2022 05:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiIXD12 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Sep 2022 23:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiIXD11 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 23 Sep 2022 23:27:27 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F986126B44;
        Fri, 23 Sep 2022 20:27:24 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id f23so1740378plr.6;
        Fri, 23 Sep 2022 20:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=u6G2g0hsb0gnt4B0UTc0XIJN5inGwACRWvwc4rYVrzY=;
        b=b0RXQ2cuaKFf7211zJWOmrMfykhMB0XiamXF4V9zMyH/g907vyZKG4VVCkxZcT/kyT
         Lajvonmk8YXfkUzQPSvI5UutVayH0CT/1KSe/dFWtT2LeMubNwTmt308w2skhBF2ys7h
         SYN4oOq3H+cSpcauHR9P+eb5L7QCvIfpfKwF/RQIAdFETzHhKWefeUoVO0yCj+6yt5y2
         5hkA6BJnqynJz11dehAtpNY4bIyKjAY/LPd1wtE3eHUnBZtxfofmLh3t1XpuXqr8tBEM
         Lsduy2Ri1cyvLmuu0TXvUnHhYXI0zDOz7l+h4e7xgIJnZJEVg0/vmlisOmx3ad7IGWAf
         BiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=u6G2g0hsb0gnt4B0UTc0XIJN5inGwACRWvwc4rYVrzY=;
        b=YFrdvkiQSl36l6a4E9TGXULozjG77ucu0QKDkntUtIicIw5SMIxemysIqLB3TdYxMo
         TxA4cWFRfM0sBMV41QiJw3d9QltXN90whBX5psNpDR8Vuqr+qgjT/nvk5OP0ofGh5x/H
         pdXYkpPwPrE9McSttp+VuoTtDuayCT0RVoEsiElajqaxuxAC3v1feT6b6MRZRomds/Hc
         qzpVRpCNrt1fA+L/soTKtsOVAphV5XEEyv3qNal4cR9dKElLqnZ2MoViZs3ZbLRYeqhh
         ZF+nov30+Fl5uO0W8H7QppJs2z14n+N+ARK6py59KrTe4oaP5zRQQ4M9jWtF1FWsF3ZN
         Redw==
X-Gm-Message-State: ACrzQf08u0iiMtLyBKT/MvkTu2Yg3G5GiC0DfBZZlsRnMR4GKzpUGVPf
        +dmau6ueaKFN6PN/hsoQ7g7GQVVR9QA8jA==
X-Google-Smtp-Source: AMsMyM6uBiNnbMMRbhAhUk9tU4h9fBxy3bUMQv77htLoF5hHcIAHwuNmvQwsN/CHlr62ulUfsw9sgg==
X-Received: by 2002:a17:90b:1e0d:b0:202:91ec:e167 with SMTP id pg13-20020a17090b1e0d00b0020291ece167mr12744688pjb.174.1663990043737;
        Fri, 23 Sep 2022 20:27:23 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id y10-20020a17090a2b4a00b001fab208523esm2309590pjc.3.2022.09.23.20.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 20:27:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 23 Sep 2022 17:27:22 -1000
From:   Tejun Heo <tj@kernel.org>
To:     cgel.zte@gmail.com
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>
Subject: Re: [PATCH linux-next] cgroup: use strscpy() is more robust and safer
Message-ID: <Yy55GrBte6cqY21I@slm.duckdns.org>
References: <20220921093517.230745-1-ye.xingchen@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921093517.230745-1-ye.xingchen@zte.com.cn>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 21, 2022 at 09:35:17AM +0000, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.
> 
> That's now the recommended way to copy NUL terminated strings.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Applied to cgroup/for-6.1.

Thanks.

-- 
tejun
