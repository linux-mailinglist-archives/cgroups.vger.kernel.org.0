Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD056F8948
	for <lists+cgroups@lfdr.de>; Fri,  5 May 2023 21:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbjEETEu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 May 2023 15:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjEETEo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 5 May 2023 15:04:44 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9E721550;
        Fri,  5 May 2023 12:04:39 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-51452556acdso1394166a12.2;
        Fri, 05 May 2023 12:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683313479; x=1685905479;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GEPgHiIOCiYrMnaimD0D7235Mb8MCc1N6gYw0WH5GLs=;
        b=Au926MGGOcupcwgRZNPEgfjNbK0PODV7VIpOzZqOU78a0/d5A/nhZgSe44BHtoRbCl
         N8yC+LTAbpe691HIteKMgub3UY1Fmc6asWv+2XB0OmiqcaK9giMLMF9dDQRBydnj9IfC
         Srpke8eUMka6WLDIFI0BIS9r95VGQUhzjxnQmOuZvBEGC8iIJgeTL3EVnIubxDDs2fdT
         nOF57loKxP+rhjB1irK/WnYXFYicmCzNdZYPq6E5M+GHVZL+15qKCaTwtqP0UTZM2anX
         RXwbF34otYxQNVgQhK1gSYDBZAqYRLgsCIdgLw/4E+NLqG2ZummrrMYm1cJ5K01Fyh5a
         LbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683313479; x=1685905479;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GEPgHiIOCiYrMnaimD0D7235Mb8MCc1N6gYw0WH5GLs=;
        b=YXYPan4VuZENP2E/VvI2CwEW0N6sTscmZCSqgYQ4mFXOwWM4AeQDrbN8izGV6ftpWx
         +Qxno+KerKmLGXgx0nuJB88UtbGzc/BMuhCzsRSX9ikfyydQBUCI6wl+nkvb0u05rOlh
         l527PfYB2aEv90lkkkc8OTadTB1pwWpsIC+N3/p/Y6tGKBLYkxv2mOPc2pQq0ZEkHbZa
         9Msewat84JtqSJa33ycz2/rHYLaM/0DoDvR0WroCZ8dYK7bl85W2XExTy/CsDejLla15
         XLdxbnzipAX8NA6n8LiU8c1jr4No19y3RqQLPnmVdO22yVH5idEKRRMQdyZ6SJNYoN7v
         d1eA==
X-Gm-Message-State: AC+VfDyZpNpp9dUtb2CKRPlDNP24cKaZzb0vO92Szx1biY46c3unaZ+S
        BxhOpCl5jz3Kf05A6jQ4MxIw9n9Lydw=
X-Google-Smtp-Source: ACHHUZ5JxzTBNOjgWwu6m6pWpeQ4R96ebV0sYRvFK3cBhGa4G6llfRY6+diIVFImaVuQkuAYiti2yg==
X-Received: by 2002:a17:902:c40b:b0:1aa:fd48:f5e2 with SMTP id k11-20020a170902c40b00b001aafd48f5e2mr2743061plk.32.1683313478706;
        Fri, 05 May 2023 12:04:38 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id t1-20020a170902e84100b001ac45598b59sm1420599plg.163.2023.05.05.12.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 12:04:38 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 5 May 2023 09:04:37 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Benjamin Berg <benjamin@sipsolutions.net>
Subject: Re: [RFC PATCH] cgroup: Return error when attempting to migrate a
 zombie process
Message-ID: <ZFVTRdP6eK1soMVR@slm.duckdns.org>
References: <20230503125359.14789-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230503125359.14789-1-mkoutny@suse.com>
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

Hello,

On Wed, May 03, 2023 at 02:53:59PM +0200, Michal Koutný wrote:
> Zombies aren't migrated. However, return value of a migration write may
> suggest a zombie process was migrated and causing confusion about lack
> of cgroup.events:populated between origin and target cgroups (e.g.
> target cgroup rmdir).
> 
> Notify the users about no effect of their action by a return value.
> (update_dfl_csses migration of zombies still silently passes since it is
> not meant to be user-visible migration anyway.)
> 
> Suggested-by: Benjamin Berg <benjamin@sipsolutions.net>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>  kernel/cgroup/cgroup.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Reasons for RFC:
> 1) Some users may notice the change,
> 2) EINVAL vs ESCHR,
> 3) add a selftest?
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 625d7483951c..306547dd7b76 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -2968,7 +2968,8 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
>  	 * become trapped in a cpuset, or RT kthread may be born in a
>  	 * cgroup with no rt_runtime allocated.  Just say no.
>  	 */
> -	if (tsk->no_cgroup_migration || (tsk->flags & PF_NO_SETAFFINITY)) {
> +	if (tsk->no_cgroup_migration || (tsk->flags & PF_NO_SETAFFINITY) ||
> +	    !atomic_read(&tsk->signal->live)) {

This seems racy to me. The liveness state can change between here and the
PF_EXITING check in cgroup_migrate_add_task(), right? Wouldn't it be better
to just track how many tasks are tracked and return -ESRCH if none was
migrated?

Thanks.

-- 
tejun
