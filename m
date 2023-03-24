Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC28D6C754B
	for <lists+cgroups@lfdr.de>; Fri, 24 Mar 2023 03:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjCXCDn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Mar 2023 22:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCXCDm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Mar 2023 22:03:42 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F62E5BBA;
        Thu, 23 Mar 2023 19:03:39 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so273002pjb.0;
        Thu, 23 Mar 2023 19:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679623419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PY/nCrDiW8SdcBN3F88jY3M7fLY4heof/m4P0yCEwhw=;
        b=HL6A8izR0CkeHjxLTeXacguhkCInW7j8vtFgwkEVI+52gmedURua9uXjCQYd1au7M4
         J3wKLc5Aaxr4n8OrTW1aboOPukXGln1bEfbkxmfXkRn6g27aVMLkRw5UTMCDUUiMzrLu
         gA2qhSRF0DeHSKKS0Lfj2/OFgFLPQj+/W3uFZOJ8HKZ7Ef709sX3NmbybV0tVgYjcqo9
         LNtgR9a6IG8ul2Ht2ssRrjooLeqB4noIZg0Q/C4ZOaho+LB9gK7sfrhgZK+tSwqccjaS
         rxmjuwkEYAujP00mwv527Ch8lZwee8c/QiAm7yaggQs3brArDtQ01NmWgzttubBCX+Rj
         nd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679623419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PY/nCrDiW8SdcBN3F88jY3M7fLY4heof/m4P0yCEwhw=;
        b=dvBp75ORt/Olu0HfTL2fG/INKpCxjzPWW4j7KwxH5+xCAU+SiFbOlWuSkdN3S+eOuM
         MLbVK54zdmF9mHqcCuc33kauy3cGFSyDHmq2Z39QaBsCza8lYuqfUPvsnHWBfhff8Elf
         dURF4yF5kRoRp1VLG5ucOdcOuoTdtq3R2Vx1Yie2/caQdoP0CWlBSsCEJE+5stRsAww0
         gWbGIzWbMHWn9z6zzVZ5qZoDkXyQaBuysnHkR9t2KRSzjIJms9y22MbzPgBDf5QGPRTm
         6bEmUMeJFZ5IZex8gfyyjnYQ7dEitCnMKs8wdd1tjtfMR8+LbABZXZfDg8wEODlyBxvT
         9+vw==
X-Gm-Message-State: AAQBX9daTbRA9T3eyTkDuh44oVTbfZVUcvAmkS4piduIkswXhnV4pxPf
        KlMlkEokFIQNCKwX4QJLKVrxE2AOiBc=
X-Google-Smtp-Source: AKy350ZD0neSEhm9l4wbQl8oOrRyXw/6xPTWV3RJomuHrjMjhShTzuTfX1vJE/M1K2wU8G/JnpV8sw==
X-Received: by 2002:a17:902:ec86:b0:1a0:7425:4b73 with SMTP id x6-20020a170902ec8600b001a074254b73mr1258132plg.4.1679623418972;
        Thu, 23 Mar 2023 19:03:38 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id p6-20020a1709028a8600b00194c2f78581sm12941481plo.199.2023.03.23.19.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 19:03:38 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 23 Mar 2023 16:03:36 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Haifeng Xu <haifeng.xu@shopee.com>, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuset: Clean up cpuset_node_allowed
Message-ID: <ZB0E+C2nao2mKlbJ@slm.duckdns.org>
References: <9953284e-05da-56b0-047d-ecf18aa53892@redhat.com>
 <20230228083537.102665-1-haifeng.xu@shopee.com>
 <299c9c34-0c07-ae52-61d7-6332f35c6245@redhat.com>
 <2e71c2bf-9ee3-4ada-e9d9-acb6e422e9af@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e71c2bf-9ee3-4ada-e9d9-acb6e422e9af@redhat.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Mar 18, 2023 at 05:30:46PM -0400, Waiman Long wrote:
> On 3/17/23 21:35, Waiman Long wrote:
> > On 2/28/23 03:35, Haifeng Xu wrote:
> > > Commit 002f290627c2 ("cpuset: use static key better and convert to
> > > new API")
> > > has used __cpuset_node_allowed() instead of cpuset_node_allowed() to
> > > check
> > > whether we can allocate on a memory node. Now this function isn't
> > > used by
> > > anyone, so we can do the follow things to clean up it.
> > > 
> > > 1. remove unused codes
> > > 2. rename __cpuset_node_allowed() to cpuset_node_allowed()
> > > 3. update comments in mm/page_alloc.c
> > > 
> > > Suggested-by: Waiman Long <longman@redhat.com>
> > > Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
...
> It turns out that cpuset_node_allowed() isn't used anywhere except in
> cpuset.h. So it should be OK to remove the alternate cpuset_node_allowed()
> function.
> 
> Acked-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-6.4.

Thanks.

-- 
tejun
