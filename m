Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13160758820
	for <lists+cgroups@lfdr.de>; Wed, 19 Jul 2023 00:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjGRWFI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 Jul 2023 18:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjGRWFE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 Jul 2023 18:05:04 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122B11FFA;
        Tue, 18 Jul 2023 15:04:43 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b8b2886364so37530615ad.0;
        Tue, 18 Jul 2023 15:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689717828; x=1692309828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FR+6E9FyZxtez1dGS44CZnCU/J8novnbxJHJ/pWrifY=;
        b=T5EhxnRXBSA7LDQpQiVg3BdYf/rybxuzpOdRyouCElvPFosDcNy7erdqXQ8E/EoWc1
         XORYYUp4WziozuqO980Vj0N1N3z6YXgrrNNIqzVxU99CZJI0AriyiJS40o41t+GG99eX
         QzzjbcmJRL/Il4EBULf5EktEhyjYyEXKCkn/g4IpiGWHAFjr7h+cIQEf2YgZ8EOABfaw
         U19EOVHLry9io77aGzkvdEMnfZIDFLkLkiWoUnIXYwB/3fdN7t1f5tcaEz+c88VPBnRI
         pl/jpm92kgR2L8o5ynFpK2FjSoG54rEEwP8TPqfi1Tx+TcLRhe9UFWc/9uMEB3OC8YCo
         ouEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717828; x=1692309828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FR+6E9FyZxtez1dGS44CZnCU/J8novnbxJHJ/pWrifY=;
        b=FZsCb68Dhm6uGDJcq0C1UUznbugKCejKo0SQ7nQNndeRzgCJPWikDpvIoJjyh8bqIo
         7hltROGXpzpaQ00mS+wU5FpmwOet6dhsYh1Ipn8+hehkcMxv0yP2H+aBPkKpxQeOc75L
         TJOcokrsI9sT1BpRBln6zblzfwV6NHUUiqq8bOYEoh8x547xy05np4CtWl6cOpqf+SPC
         UBcJVreufkBWYKdu5smix1VwaflhBdxsDUX0uWxYAdx9sCp92fZcvNzHcQsHDtXfiiKM
         Cyctsl7igOH4ZuK71FYzRga0cHIpx+bIM071SdHEfB8Q8behFRS5yDPhdekkx2m2i/Xf
         6JoA==
X-Gm-Message-State: ABy/qLYzd8mh+TUCZLFitC1Kh6GaJ9DHHM8KEqvZ3FCyHnZ2LhjCzsTx
        IPKWsZn2tPtaLjkyZih/6Zc=
X-Google-Smtp-Source: APBJJlH4z7JVa6LG1Rw/jHvaZnLPYeTjsRdV1wAP8Dyj/SVnakj13zi/3x+tk+O2AeLsBvr1YJdT8Q==
X-Received: by 2002:a17:902:7001:b0:1b9:ea60:cd8a with SMTP id y1-20020a170902700100b001b9ea60cd8amr821989plk.50.1689717828063;
        Tue, 18 Jul 2023 15:03:48 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:fbd8])
        by smtp.gmail.com with ESMTPSA id x21-20020a170902ea9500b001b9c5e07bc3sm2333500plb.238.2023.07.18.15.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:03:47 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 18 Jul 2023 12:03:46 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kamalesh Babulal <kamalesh.babulal@oracle.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/misc: update struct members descriptions
Message-ID: <ZLcMQiHnrkptxw8Q@slm.duckdns.org>
References: <20230718090834.1829191-1-kamalesh.babulal@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718090834.1829191-1-kamalesh.babulal@oracle.com>
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

On Tue, Jul 18, 2023 at 02:38:34PM +0530, Kamalesh Babulal wrote:
> Update the miscellaneous controller's structure member's description of
> struct misc_res and struct misc_cg.
> 
> Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>

Applied to cgroup/for-6.6.

Thanks.

-- 
tejun
