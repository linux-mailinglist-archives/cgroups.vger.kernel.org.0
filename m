Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C4357FEC9
	for <lists+cgroups@lfdr.de>; Mon, 25 Jul 2022 14:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbiGYMMR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Jul 2022 08:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbiGYMMQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Jul 2022 08:12:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D75D119289
        for <cgroups@vger.kernel.org>; Mon, 25 Jul 2022 05:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658751134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uoeyod5zDB0ZJ1Q5JYhvmo5sNmJuhZfqcU+zHvGMHKo=;
        b=Nm9vqG6ljZFhyyrF4H4YRTdIVewd4hbLlIuXFi5IH39WTTR1pANzHjZPN1OSvLkEb3R1Ir
        le3sno7y7t0JrAGLUKs99evjRCKJY9zlwEzGtfUMxlWlZ8DM1jsmSLNpwty+4VFosrECSf
        YsdjJ2SkfeNjJCH0Oqafb9V9npDVVbw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-x8md8l6GPqa5FpdlvL-Cag-1; Mon, 25 Jul 2022 08:12:12 -0400
X-MC-Unique: x8md8l6GPqa5FpdlvL-Cag-1
Received: by mail-wm1-f70.google.com with SMTP id r9-20020a1c4409000000b003a2fdeea756so5317590wma.2
        for <cgroups@vger.kernel.org>; Mon, 25 Jul 2022 05:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uoeyod5zDB0ZJ1Q5JYhvmo5sNmJuhZfqcU+zHvGMHKo=;
        b=V6rEqdFPXingfhHdbjC5WEXRsFLz/Cuvqwr7gMDsCZmJw3qyFGJMRLlqjZwxBt/7kn
         +o252WCsVPoRZD3+iG/WsMNKpOzD8JvIkNPIM6D/sRrGUxJtpUxqYnpTPNRiEvLt1ck8
         LidG6siA/x7SF0pfLklEjgA8LFTOMQ1RXPGXNonefGwhAkb0MHxQ4gLi23c1B3YqHow+
         9XHHSKnTsF3NSE/JcfvGo89yJovSaIdhxjkOAk3L+WH/4N6Kve1JVuQzRJpfJAR7t7Ji
         TMzEbv7hiFrFLgMsPXSCT1pzcPBKztffuyL2SpvvjIclVCWnRUGXlipMUfaaSu3sETOW
         DT7Q==
X-Gm-Message-State: AJIora/+yTs3Z0N0w58qARZqx/AYKwxA8e9rRTNLVia24oHYoM4YRNEn
        WqFuvij7yy+gmPFlmTvrLzVER1LEuPMSVGQSlAg+barwgqo9P5CJYLcdzJSHNccde00msXtK8Ms
        xahLXUbYS3Fad0m7Yog==
X-Received: by 2002:a1c:1985:0:b0:3a3:2cf8:ebe with SMTP id 127-20020a1c1985000000b003a32cf80ebemr19085539wmz.7.1658751131463;
        Mon, 25 Jul 2022 05:12:11 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sg1p/W87M857aANgGZlbkEF29CiOsW6o+B6ylQbKFe160LnKOhoSTAhncXk2EVVeWXUtUgcQ==
X-Received: by 2002:a1c:1985:0:b0:3a3:2cf8:ebe with SMTP id 127-20020a1c1985000000b003a32cf80ebemr19085498wmz.7.1658751130996;
        Mon, 25 Jul 2022 05:12:10 -0700 (PDT)
Received: from redhat.com ([83.148.38.84])
        by smtp.gmail.com with ESMTPSA id a7-20020adffac7000000b0021e3e73dec6sm14109460wrs.72.2022.07.25.05.12.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jul 2022 05:12:10 -0700 (PDT)
From:   Oleg Nesterov <onestero@redhat.com>
X-Google-Original-From: Oleg Nesterov <oleg@redhat.com>
Date:   Mon, 25 Jul 2022 14:12:09 +0200
To:     Tejun Heo <tj@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Dmitry Shmidt <dimitrysh@google.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH RESEND 3/3 cgroup/for-5.20] cgroup: Make !percpu
 threadgroup_rwsem operations optional
Message-ID: <20220725121208.GB28662@redhat.com>
References: <YtDvN0wJ6CKaEPN8@slm.duckdns.org>
 <YtDvU4jRPSsarcNp@slm.duckdns.org>
 <YtDvl7Qjc5zI3e/b@slm.duckdns.org>
 <YtwFjPnCtw8ySnuv@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtwFjPnCtw8ySnuv@slm.duckdns.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 07/23, Tejun Heo wrote:
>
> +void cgroup_favor_dynmods(struct cgroup_root *root, bool favor)
> +{
> +	bool favoring = root->flags & CGRP_ROOT_FAVOR_DYNMODS;
> +
> +	/* see the comment above CGRP_ROOT_FAVOR_DYNMODS definition */
> +	if (favor && !favoring) {
> +		rcu_sync_enter(&cgroup_threadgroup_rwsem.rss);
> +		root->flags |= CGRP_ROOT_FAVOR_DYNMODS;
> +	} else if (!favor && favoring) {
> +		rcu_sync_exit(&cgroup_threadgroup_rwsem.rss);
> +		root->flags &= ~CGRP_ROOT_FAVOR_DYNMODS;
> +	}
> +}

I see no problems in this patch. But just for record, we do not need
synchronize_rcu() in the "favor && !favoring" case, so we cab probably
do something like

	--- a/kernel/rcu/sync.c
	+++ b/kernel/rcu/sync.c
	@@ -118,7 +118,7 @@ static void rcu_sync_func(struct rcu_head *rhp)
	  * optimize away the grace-period wait via a state machine implemented
	  * by rcu_sync_enter(), rcu_sync_exit(), and rcu_sync_func().
	  */
	-void rcu_sync_enter(struct rcu_sync *rsp)
	+void __rcu_sync_enter(struct rcu_sync *rsp, bool wait)
	 {
		int gp_state;
	 
	@@ -146,13 +146,20 @@ void rcu_sync_enter(struct rcu_sync *rsp)
			 * See the comment above, this simply does the "synchronous"
			 * call_rcu(rcu_sync_func) which does GP_ENTER -> GP_PASSED.
			 */
	-		synchronize_rcu();
	-		rcu_sync_func(&rsp->cb_head);
	-		/* Not really needed, wait_event() would see GP_PASSED. */
	-		return;
	+		if (wait) {
	+			synchronize_rcu();
	+			rcu_sync_func(&rsp->cb_head);
	+		} else {
	+			rcu_sync_call(rsp);
	+		}
	+	} else if (wait) {
	+		wait_event(rsp->gp_wait, READ_ONCE(rsp->gp_state) >= GP_PASSED);
		}
	+}
	 
	-	wait_event(rsp->gp_wait, READ_ONCE(rsp->gp_state) >= GP_PASSED);
	+void rcu_sync_enter(struct rcu_sync *rsp)
	+{
	+	__rcu_sync_enter(rsp, true);
	 }
	 
	 /**

later.

__rcu_sync_enter(rsp, false) works just like rcu_sync_enter_start() but it can
be safely called at any moment.

And can't resist, off-topic question... Say, cgroup_attach_task_all() does

	mutex_lock(&cgroup_mutex);
	percpu_down_write(&cgroup_threadgroup_rwsem);

and this means that synchronize_rcu() can be called with cgroup_mutex held.
Perhaps it makes sense to change this code to do

	rcu_sync_enter(&cgroup_threadgroup_rwsem.rss);
	mutex_lock(&cgroup_mutex);
	percpu_down_write(&cgroup_threadgroup_rwsem);
	...
	percpu_up_write(&cgroup_threadgroup_rwsem);
	mutex_unlock(&cgroup_mutex);
	rcu_sync_exit(&cgroup_threadgroup_rwsem.rss);

? Just curious.

> -	/*
> -	 * The latency of the synchronize_rcu() is too high for cgroups,
> -	 * avoid it at the cost of forcing all readers into the slow path.
> -	 */
> -	rcu_sync_enter_start(&cgroup_threadgroup_rwsem.rss);

Note that it doesn't have other users, probably you can kill it.

Oleg.

