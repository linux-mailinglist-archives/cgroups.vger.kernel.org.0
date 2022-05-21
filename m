Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D9952F8C9
	for <lists+cgroups@lfdr.de>; Sat, 21 May 2022 07:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351895AbiEUFAU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 21 May 2022 01:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiEUFAT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 21 May 2022 01:00:19 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9ABF170F2C;
        Fri, 20 May 2022 22:00:17 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id bo5so9290589pfb.4;
        Fri, 20 May 2022 22:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TT52cKU8Oo9pvmq53QQ/gpy/l4ehF6WUmfOqY1Ifb5w=;
        b=Ri4Q2yDK9UddopX/efZVecxLBB/qzjAX8bOizIYqnYBz/IVPnAqRxKzwm1vJ0T8X0+
         nuqli3W/XU2w+3+GIA1ghzD5MCISZJd+atg1PhfSHFZW8V7M+vLgShlWqqVmmArVHAAj
         zffrOtgFX9Rqj5/HifljRxmrvGxNRZ4O1kzoXZZs4f9WN5Ykt4MQYUKi7LteHzVVgHyW
         bpJ7xFRb4wFhtzMY02KmxQhyr0XbS9Y1JJhNAkx9exmbRdG/+E4chTBnMvnwAbkQWjFw
         0NmE6kHrDNabzqwLUR32uOHW5Rv+xwsWUiIYDkEz1PtdnS4d6hk0vr0HXy7biSD13qSm
         FTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=TT52cKU8Oo9pvmq53QQ/gpy/l4ehF6WUmfOqY1Ifb5w=;
        b=WhsCt/Ya/yYrrTRc+2eXgjqY6pui/1isCdBudiEPx7IYA619HY/JmmSun9ngDuHuNq
         Ph3SPGcjEXaAVkCRIT6goD8P31hEpFWuyCFMsvKeRkCMGhRBz/x2LkEB6HcW0cbq+DXS
         R/iUoBGIPCF39U3ert/zg541/7f0Uk9QI/suZOXsF0ei7CV00fSeE4PyehH/ZFQrrQmW
         FIa7CVk+t55Cylo9td8h8oBPbesnDJZdAms7BSTCGrThknmiTP5aeQDVhV8O30ILP5ht
         WK1UhawlDgsHak6r2vrU0reRCQ/monfOIjol/8SihOiueOPz3k0vSl9Co9evYcvxs358
         sJmw==
X-Gm-Message-State: AOAM531RtiChTVSCULvRyAukCg4LUeVWuxVzrI8bfZcuxHFHu4VgROFY
        vtihJzdY5QnYIQ9xX1X3seirOFVzpU0=
X-Google-Smtp-Source: ABdhPJy1pzrVnSH8RYDdkvaQ97w0zLTB4FwLCQZ3KInQR5+wRhOBGCaAkd5Yze73kQyif3z+3cxqFA==
X-Received: by 2002:a05:6a00:1acd:b0:50e:1872:c680 with SMTP id f13-20020a056a001acd00b0050e1872c680mr13571991pfv.16.1653109217238;
        Fri, 20 May 2022 22:00:17 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:1761])
        by smtp.gmail.com with ESMTPSA id bo4-20020a056a000e8400b0050dc76281e2sm2565515pfb.188.2022.05.20.22.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 22:00:16 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 20 May 2022 19:00:15 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        axboe@kernel.dk, ming.lei@redhat.com, geert@linux-m68k.org,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH -next v3 2/2] blk-throttle: fix io hung due to
 configuration updates
Message-ID: <Yohx305S2bkSemQx@slm.duckdns.org>
References: <20220519085811.879097-1-yukuai3@huawei.com>
 <20220519085811.879097-3-yukuai3@huawei.com>
 <20220519095857.GE16096@blackbody.suse.cz>
 <a8953189-af42-0225-3031-daf61347524a@huawei.com>
 <20220519161026.GG16096@blackbody.suse.cz>
 <73464ca6-9412-cc55-d9c0-f2e8a10f0607@huawei.com>
 <fe3c03f7-9b52-7948-075d-cbdf431363e1@huawei.com>
 <20220520160305.GA17335@blackbody.suse.cz>
 <Yoe/1BRYzSRI0JBd@slm.duckdns.org>
 <97be6af0-ea94-f4ee-5ab2-02b6fc02cbff@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97be6af0-ea94-f4ee-5ab2-02b6fc02cbff@huawei.com>
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

On Sat, May 21, 2022 at 11:51:11AM +0800, yukuai (C) wrote:
> It's right the problem is self-inflicted. However, I do think with
> Michal's suggestion, how throttled bios are handled while new config is
> submitted really make sense from the functional poinit of view.
> 
> Do you think the solution is OK?

I haven't followed the details but anything which isn't overly complex and
doesn't produce extra budget or eat into existing one on config change is
fine by me.

Thanks.

-- 
tejun
