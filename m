Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE8A389F92
	for <lists+cgroups@lfdr.de>; Thu, 20 May 2021 10:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhETINZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 May 2021 04:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhETINM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 May 2021 04:13:12 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FFFC061574
        for <cgroups@vger.kernel.org>; Thu, 20 May 2021 01:11:51 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g24so8702692pji.4
        for <cgroups@vger.kernel.org>; Thu, 20 May 2021 01:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dKXXvvEdCPH+ptTNMVfkzPYklSo2kJNNdVAijt8am50=;
        b=bSBv8DPvXGB6vKZs7INGAbnQThj5J60bW/4UZEusYvMVqSrlHpOmp8KgtEXN8nr1YJ
         M8psiSgHzbh/qnoEijRaK89rimo0pOcaItrcZAaW9xdUBk8fC9FWy3TklLk66gjrFWdF
         bxXMSz9OoyzsjDbf6tjj3KzxY4i1B6E6Qova2egNUABDWK0UDMijXbkPEsiT4/tPWeZJ
         blaauM7ADJMjZCDvacAykSPpoaSe4hXt+XTmTGtIz8qE09+uCvp0urfp2/98+8zLLUcm
         8Hm/3eo7aE9EYzFB93p3KOs6G5SltSzQrJ15E9h65/cgVE76Y8lr+YrwiPMQhvhHky9c
         KSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dKXXvvEdCPH+ptTNMVfkzPYklSo2kJNNdVAijt8am50=;
        b=I4DINX0Yg/REop4VvldSpVIX79Tanm/bqMrzJhuBBBAY3QyfUDkfK6qaiBIxm4P4sb
         EaIjw81mmvar3I9UVLhF3dslovKUHcXdtEfsF8jWsMuIIrQsj4q4zyU0smm6r4MhVkP/
         EX3csrzNPYinicfPq9lhdgetkx4di1O2KHJvzE3qFkivJ0nKP8eSA8OhIXnraYYbLqED
         LVbm6y9uvZ6495vX68rPDOlyDHzV80CpuKcBaH7AjrcIEJ10vlTxHcAplpThHpF4LlG2
         awgGhdvz3UgSzYPfWvFxXTahAVb0UK5u4isQ+KFM49LunIrnYxh5jK3Ycm6u/SzsMofG
         WHSg==
X-Gm-Message-State: AOAM531dVlmmnoL1tFk28n9HAWl8ZMmW/ozUdIynRL6oPVk/sfSzHtyq
        1YQzOUDUTezuxPBT7th4Fgo=
X-Google-Smtp-Source: ABdhPJxze/dA5YjPAlUiDARVnP2gEp4Jb6NsZnKWnW8zCEwdTnMH8tdkAumg4sqvpjY3ke+dFwd/Qg==
X-Received: by 2002:a17:902:e812:b029:f0:aa50:2f1d with SMTP id u18-20020a170902e812b02900f0aa502f1dmr4391264plg.79.1621498310783;
        Thu, 20 May 2021 01:11:50 -0700 (PDT)
Received: from localhost.localdomain ([27.102.114.24])
        by smtp.gmail.com with ESMTPSA id t14sm1242380pfg.168.2021.05.20.01.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 01:11:50 -0700 (PDT)
From:   Yutian Yang <nglaive@gmail.com>
To:     mhocko@kernel.org
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com, shenwenbo@zju.edu.cn,
        cgroups@vger.kernel.org, linux-mm@kvack.org, ytyang@zju.edu.cn,
        mhocko@suse.com, Yutian Yang <nglaive@gmail.com>
Subject: [PATCH] mm: fix unaccounted time namespace objects
Date:   Thu, 20 May 2021 17:08:58 +0900
Message-Id: <20210520080858.25450-1-nglaive@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch adds memcg accounting for time namespace objects, as we have confirmed that unaccounted namespace objects could lead to breaking memcg limit. For common concerns on this patch, we have the following response:

For the practicality of our concerns, we have confirmed that repeatedly creating new namespaces could lead to breaking memcg limit. Although the number of namespaces could be limited by per-user quota (e.g., max_time_namespaces), depending on per-user quota to limit memory usage is unsafe and impractical as users may have their own considerations when setting these limits. In fact, limitation on memory usage is more foundamental than limitation on various kernel objects. I believe this is also the reason why the fd tables and pipe buffers have been accounted by memcg even if they are also under per-user quota's limitation. The same reason applies to limitation of pid cgroups. Moreover, both net and uts namespaces are properly accounted while the others are not, which shows inconsistencies.

For other unaccounted allocations (proc_alloc_inum, vvar_page and likely others), we have not reached them yet as our detecting tool reported many results which require much manual effort to go through. To me, it seems that vvar_page also need patches.

Lastly, our work is based on a detecting tool and we only report missing-charging sites that are manually confirmed to be triggerable from syscalls. The results that are obviously unexploitable like uncharged ldt_struct, which is allocated per process, are also filtered out. We would like to continuously contribute to memcg and we are planning to submit more patches in the future.

I have reported the patch but I have not added it to the public mailing list then. Consequently,I switch to a new thread and copy our previous discussions below:

> -----Original Messages-----
> From: "Michal Hocko" <mhocko@suse.com>
> Sent Time: 2021-04-16 14:29:52 (Friday)
> To: "Yutian Yang" <ytyang@zju.edu.cn>
> Cc: tglx@linutronix.de, "shenwenbo@zju.edu.cn" <shenwenbo@zju.edu.cn>, "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>
> Subject: Re: User-controllable memcg-unaccounted objects of time namespace
>
> Thank you for this and other reports which are trying to track memcg
> unaccounted objects. I have few remarks/questions.
>
>
> On Thu 15-04-21 21:29:57, Yutian Yang wrote:
> > Hi, our team has found bugs in time namespace module on Linux kernel v5.10.19, which leads to user-controllable memcg-unaccounted objects.
> > They are caused by the code snippets listed below:
> >
> > /*--------------- kernel/time/namespace.c --------------------*/
> > ......
> > 91ns = kmalloc(sizeof(*ns), GFP_KERNEL);
> > 92if (!ns)
> > 93goto fail_dec;
> > ......
> > /*----------------------------- end -------------------------------*/
> >
> >
> > The code at line 91 could be triggered by syscall clone if
> > CLONE_NEWTIME flag is set in the parameter. A user could repeatedly
> > make the clone syscall and trigger the bugs to occupy more and
> > more unaccounted memory. In fact, time namespaces objects could be
> > allocated by users and are also controllable by users. As a result,
> > they need to be accounted and we suggest the following patch:
>
> Is this a practical concern? I am not really deeply familiar with
> namespaces but isn't there any cap on how many of them can be created by
> user? If not, isn't that contained by the pid cgroup controller? If even
> that is not the case, care to explain why?
>
> You are referring to struct time_namespace above (that is 88B) but I can
> see there are other unaccounted allocations (proc_alloc_inum, vvar_page
> and likely others) so why the above is more important than those?
>
> Btw. a similar feedback applies to other reports similar to this one. I
> assume you have some sort of tool to explore those potential run aways
> and that is really great but it would be really helpful and highly
> appreciated to analyze those reports and try to provide some sort of
> risk assessment.
>
> Thanks!
> --
> Michal Hocko
> SUSE Labs

Thanks!

Yutian Yang,
Zhejiang University

Signed-off-by: Yutian Yang <nglaive@gmail.com>
---
 kernel/time/namespace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index afc65e6be..00c20f7fd 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -88,13 +88,13 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
 		goto fail;
 
 	err = -ENOMEM;
-	ns = kmalloc(sizeof(*ns), GFP_KERNEL);
+	ns = kmalloc(sizeof(*ns), GFP_KERNEL_ACCOUNT);
 	if (!ns)
 		goto fail_dec;
 
 	kref_init(&ns->kref);
 
-	ns->vvar_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+	ns->vvar_page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
 	if (!ns->vvar_page)
 		goto fail_free;
 
-- 
2.25.1

