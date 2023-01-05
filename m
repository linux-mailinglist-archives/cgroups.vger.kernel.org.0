Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015E765F2EE
	for <lists+cgroups@lfdr.de>; Thu,  5 Jan 2023 18:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjAERjQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Jan 2023 12:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjAERjF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Jan 2023 12:39:05 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF6218E32;
        Thu,  5 Jan 2023 09:39:04 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id c2so12489387plc.5;
        Thu, 05 Jan 2023 09:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4AnT3159KFsCJ48uEVH/264Q/p+zAUBME0hFPZg68eg=;
        b=T9iSn5FzZm2l6Viva4kX8AvyD/WH9zRn2pTLbOVeXmWhVoEA3zpe9CRAuPUy4dHkYO
         NSEHuZBHhD7KkKwFEfQ813/AlSTenvi1RJG1FcbvgbZ+7ZUQNUnO0rRYOHeSbGu7N0Jz
         zX5irW0PrakMdmoGO8/byqY6133m/OW/YjIjk8fvB3BXE2hQzzZH31EP4UcUT9NLJO+y
         VsxxhttA20KpNwTY8Y1df+pY11APnUzx7R8kAUFT6FFTWMRmotpMQ9CPxn3/McTfkyRW
         09CG7J9+RCQCT5mE0j9mlUzE+YZ+/rtBM+aToJXX/NN4hXZV1PtSUTF21KLFAJQ1s97h
         Wi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4AnT3159KFsCJ48uEVH/264Q/p+zAUBME0hFPZg68eg=;
        b=wcQqnJrRej8/mrNkXcvajmaWvfcdjWW9GFLDBAGdmBC/RX3bhPMxFtqLoF3AfbfHW3
         kPLrcBG1GAF+rSQfUSKjgg2f0mk53R/n7mvciQQhHXKp/h/XIS/1nlyJfsRm1bVVbvT2
         dUCbULAkkdbIXa+MRkOKyFSc609VVtQ/g9sGU6KshlZdR9pOEj3kl5HdNCZKXYwbk9xt
         TN4ZbWigBolpKVDMVkh1gTqkuo+X2W53KIqfpvJPKQlGtfix1HSJnIr3+g1cElYlmy6W
         KsjOkYqLt0E5oxUGo/TAtGbNT63QkVXRaZyviZaGT2zPn33YLSO1fuHFdmnsqyPGgvgU
         P6gw==
X-Gm-Message-State: AFqh2kr2znyZnUhu3j8gb3Lxx5htV3iM0DSYHLeLOp+oaNmok0Vl4Cpr
        qjO7kAzUPRf+rIva1da6vIU=
X-Google-Smtp-Source: AMrXdXt+7ybxxETkk/HzQmIbC2AjejPD2RPmifiyZVi8Kx/kOOdUFlwOC8cSDKdC/O1ODXmbt+grqA==
X-Received: by 2002:a17:902:7583:b0:189:4bf4:2cfc with SMTP id j3-20020a170902758300b001894bf42cfcmr54184892pll.31.1672940343827;
        Thu, 05 Jan 2023 09:39:03 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902e74700b00186b8752a78sm26389725plf.80.2023.01.05.09.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 09:39:03 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 5 Jan 2023 07:39:01 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux CGroups <cgroups@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH v2 0/9] docs: cgroup-v1: formatting improv for "Memory
 Resource Controller" doc
Message-ID: <Y7cLNTlazRghuxoy@slm.duckdns.org>
References: <20230105131633.553574-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105131633.553574-1-bagasdotme@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jan 05, 2023 at 08:16:25PM +0700, Bagas Sanjaya wrote:
> "Memory Resource Controller" CGroup v1 documentation has been in reST since
> 99c8b231ae6c6c ("docs: cgroup-v1: convert docs to ReST and rename to *.rst").
> The current doc look is kinda ugly, so improve the formatting (only htmldocs is
> tested).

Applied to cgroup/for-6.2-fixes.

Thanks.

-- 
tejun
