Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9DE50AF65
	for <lists+cgroups@lfdr.de>; Fri, 22 Apr 2022 07:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444097AbiDVFMP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Apr 2022 01:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444069AbiDVFMI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Apr 2022 01:12:08 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEAD4F440
        for <cgroups@vger.kernel.org>; Thu, 21 Apr 2022 22:09:16 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id u15so5013672ple.4
        for <cgroups@vger.kernel.org>; Thu, 21 Apr 2022 22:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rpqDRBjWTFgnwu8hYqPDued7W5tN/z70+zi0V+kqfDQ=;
        b=Q0hcI1wq6TOk2nT188DONJl8NB23KNtCjhfItg9EEg/p3Wrhq0eawgIr8JTlnSl9gT
         RzIQDZfLJK+Un/ClfO2FXBkYSxX0RjMPs7MbYdAjubXsDgh9wwa+RtV9E5XVFLCszDIQ
         MK3KtHeydNAlOsqh4MLUdnTetvCSN8IWoMM0n9FKeVZF9sJISp/ncUeqhoYYHl/xuukl
         H3LmXrFpqgD8zzpVJaBj1kwZwxVDascj4aIViTToD8Q9SDtUes4R+Nq1PatVvkeb4RvG
         o8vKY2uDUfGaecPS6vWVIbDWWAjIFfHW9FnfCtkA+QERRjBrDY6cgpFwj0dMT3zWcrN9
         UHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rpqDRBjWTFgnwu8hYqPDued7W5tN/z70+zi0V+kqfDQ=;
        b=cul/8i/+w7d1BgA/gov1pcTKIRtvGTnb2KspjsUhSJK1MLyjUjxyCBiL2b5WFOftyb
         BXyOotN4iSuBUBp+hc5oNEj5H5zk90fTTIBraXfZaDITSrrVuQDrGAsQNhiumNovf5T+
         1XBAFgCKEC+pJ2fLSGokT08PqZ2aEo2RqDclbiW6OgKZ4lhFpiv881AG08aBUXt8Xlp5
         hHQg0gQnfDH0iFgLq6VnDSoNcnQ2lb7juGt3ztIOUmgb9iiRbPaF3nw/fgSlGSriYjab
         cMGAAkGpqRzf8+hCNUPFB0T/yoKjczXY3JSraSUbbE7Yz4Rqw5P0iG5LOl9dqGGl6A2z
         j1SA==
X-Gm-Message-State: AOAM531AWynD4RAwpDPKrPtABaVGCqpCDAzbWK2fFYfAW/QnZ19eYlwC
        Km+2UnepcPVzREz5UH11KNafag==
X-Google-Smtp-Source: ABdhPJwEWcy2D4mg4wIjBcgA4vTprLUh+mK4jKEEc3+Pu6A1K8wQq7O31Sm6PJfJsxTdGi+dnPQypg==
X-Received: by 2002:a17:902:bc8b:b0:158:ac00:cca0 with SMTP id bb11-20020a170902bc8b00b00158ac00cca0mr2893469plb.102.1650604155898;
        Thu, 21 Apr 2022 22:09:15 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id g15-20020aa7818f000000b00505ce2e4640sm844208pfi.100.2022.04.21.22.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 22:09:15 -0700 (PDT)
Date:   Fri, 22 Apr 2022 13:09:11 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Marco Elver <elver@google.com>
Cc:     syzbot <syzbot+ffe71f1ff7f8061bcc98@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, dvyukov@google.com, glider@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        Roman Gushchin <roman.gushchin@linux.dev>,
        cgroups@vger.kernel.org
Subject: Re: [syzbot] WARNING in __kfence_free
Message-ID: <YmI4d8xR3tafv2Cq@FVFYT0MHHV2J.usts.net>
References: <000000000000f46c6305dd264f30@google.com>
 <YmEf8dpSXJeZ2813@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmEf8dpSXJeZ2813@elver.google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 21, 2022 at 11:12:17AM +0200, Marco Elver wrote:
> On Thu, Apr 21, 2022 at 01:58AM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    559089e0a93d vmalloc: replace VM_NO_HUGE_VMAP with VM_ALLO..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=10853220f00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=2e1f9b9947966f42
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ffe71f1ff7f8061bcc98
> > compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > userspace arch: arm64
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+ffe71f1ff7f8061bcc98@syzkaller.appspotmail.com
> > 
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 2216 at mm/kfence/core.c:1022 __kfence_free+0x84/0xc0 mm/kfence/core.c:1022
> 
> That's this warning in __kfence_free:
> 
> 	#ifdef CONFIG_MEMCG
> 		KFENCE_WARN_ON(meta->objcg);
> 	#endif
> 
> introduced in 8f0b36497303 ("mm: kfence: fix objcgs vector allocation").
> 
> Muchun, are there any circumstances where the assumption may be broken?
> Or a new bug elsewhere?

meta->objcg always should be NULL when reaching __kfence_free().
In theory, meta->objcg should be cleared via memcg_slab_free_hook().

I found the following code snippet in do_slab_free().

  /* memcg_slab_free_hook() is already called for bulk free. */
  if (!tail)
  	memcg_slab_free_hook(s, &head, 1); 

The only posibility is @tail is not NULL, which is the case of
kmem_cache_free_bulk(). However, here the call trace is kfree(),
it seems to be impossible that missing call memcg_slab_free_hook().

Thanks. 
