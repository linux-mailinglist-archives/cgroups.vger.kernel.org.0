Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EC8581C5A
	for <lists+cgroups@lfdr.de>; Wed, 27 Jul 2022 01:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239893AbiGZXON (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Jul 2022 19:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiGZXON (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Jul 2022 19:14:13 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC87B57;
        Tue, 26 Jul 2022 16:14:12 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id p1so6153485plr.11;
        Tue, 26 Jul 2022 16:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=dENzbJt1guxesUSDXfqIuUH8HSBp0gL0djmYPEroaFo=;
        b=T4rpXUuAvUynX4msd8KQnGEVJFSRIl5nzM/D3tRhWXKZc4ZJ5DUwfEC9QgGv/5xjXW
         E6OAd6kkjYfFhdUM30igCr8XSn8lYDFiONlfDj4/9doWZZTUYYHQEFax0ApOkxFlS65z
         wqNL2mruoIffrmifwfHPILKEt769Nsp3IR0YSnkklSM9ptR2euVO7k2KtnqRz4cax2I1
         LTIuhLlQcq3TJ4TeDbr9kEK73CSVnQNNBWpbttRTpZP7j0kMtWJ0iii+mbTiJwSsGp4Z
         L5iscMqS/X8AZMaWDLqzWPsVAPMNdg4ZXBTwTOe49qOCsiwF9J28bxOMs76GMwM7wn2q
         IVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=dENzbJt1guxesUSDXfqIuUH8HSBp0gL0djmYPEroaFo=;
        b=xU7G3xSaq8FDKSZSWk2vjUFoL77v3+juLR7EjCoiTdEmxg4JrNI67IVYadtJJ6egBy
         B2WjB9hFHIPPeJyDXhJ0MMy7jmMOHROpMDDlOGO0pZlzp+RNGN21275VSvAL2tw1q318
         sKcqTOXG3GoSrxn4xFxMGFx3BKacjOtb3TMnS7SKBLUCXiGq3te5eHIqh2senrW/t7P9
         ahPrnxkAcLEmjOfaCit/hSBmQA+kA7/qab9+5q9Z16Pen7rS63z8SRPx1O6AdGpm8aMH
         Q1HrYwrylQSq087zCiTQ2K7i6//gn9TgCcoCamS5Ni+uCZ5eugzlB70aDR1hhVABGZBo
         4xHg==
X-Gm-Message-State: AJIora9maKfe8kxVPAn5+7E5mAK9ZGAFEH6pypsMPXM/Xc20IX4ZrGLD
        yFZwbnuMdnv9QSm+Y0taGdvz+jpZPT4=
X-Google-Smtp-Source: AGRyM1uVZumR1MdGjIlvcfVvt0XJI3nay5hQLZbnkAoS/55BukXwIgU1kM47aEE55aG+pBhs7v1uyA==
X-Received: by 2002:a17:902:ea06:b0:16d:5c8c:4167 with SMTP id s6-20020a170902ea0600b0016d5c8c4167mr16273957plg.57.1658877251626;
        Tue, 26 Jul 2022 16:14:11 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:370d])
        by smtp.gmail.com with ESMTPSA id j1-20020a654d41000000b003fadd680908sm10769945pgt.83.2022.07.26.16.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 16:14:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 26 Jul 2022 13:14:09 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Oleg Nesterov <onestero@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Dmitry Shmidt <dimitrysh@google.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH RESEND 3/3 cgroup/for-5.20] cgroup: Make !percpu
 threadgroup_rwsem operations optional
Message-ID: <YuB1QW6Kce5nkBu6@slm.duckdns.org>
References: <YtDvN0wJ6CKaEPN8@slm.duckdns.org>
 <YtDvU4jRPSsarcNp@slm.duckdns.org>
 <YtDvl7Qjc5zI3e/b@slm.duckdns.org>
 <YtwFjPnCtw8ySnuv@slm.duckdns.org>
 <20220725121208.GB28662@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725121208.GB28662@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Oleg.

On Mon, Jul 25, 2022 at 02:12:09PM +0200, Oleg Nesterov wrote:
> I see no problems in this patch. But just for record, we do not need
> synchronize_rcu() in the "favor && !favoring" case, so we cab probably
> do something like
> 
> 	@@ -146,13 +146,20 @@ void rcu_sync_enter(struct rcu_sync *rsp)
> 			 * See the comment above, this simply does the "synchronous"
> 			 * call_rcu(rcu_sync_func) which does GP_ENTER -> GP_PASSED.
> 			 */
> 	+		if (wait) {
> 	+			synchronize_rcu();
> 	+			rcu_sync_func(&rsp->cb_head);
> 	+		} else {
> 	+			rcu_sync_call(rsp);
> 	+		}
> 	+	} else if (wait) {
> 	+		wait_event(rsp->gp_wait, READ_ONCE(rsp->gp_state) >= GP_PASSED);
...
> later.
> 
> __rcu_sync_enter(rsp, false) works just like rcu_sync_enter_start() but it can
> be safely called at any moment.

Yeah, I originally used rcu_sync_enter_start() but quickly found out that it
can't be reverted reliably. Given how cold the option switching path is, I
think it's fine to pay an extra synchronize_rcu() there rather than adding
more complexity to rcu_sync_enter() unless this will be useful somewhere
else too.

> And can't resist, off-topic question... Say, cgroup_attach_task_all() does
> 
> 	mutex_lock(&cgroup_mutex);
> 	percpu_down_write(&cgroup_threadgroup_rwsem);
> 
> and this means that synchronize_rcu() can be called with cgroup_mutex held.
> Perhaps it makes sense to change this code to do
> 
> 	rcu_sync_enter(&cgroup_threadgroup_rwsem.rss);
> 	mutex_lock(&cgroup_mutex);
> 	percpu_down_write(&cgroup_threadgroup_rwsem);
> 	...
> 	percpu_up_write(&cgroup_threadgroup_rwsem);
> 	mutex_unlock(&cgroup_mutex);
> 	rcu_sync_exit(&cgroup_threadgroup_rwsem.rss);
> 
> ? Just curious.

I'm not quite following. Are you saying that if we switching the rwsem into
slow mode before grabbing the locks, we can avoid inducing latencies on
other users? Hmm... assuming that I'm understanding you correctly, one
problem with that approach is that everyone would be doing synchronize_rcu()
whether they want to change favoring state. In vast majority of cases, users
won't care about this flag but most users will end up mounting cgroup and do
the rcu_sync_enter(), so we'd end up adding a grace period wait in most boot
scenarios. It's not a lot in itself but seems less desriable than making the
users who want to change the mode pay at the time of changing.

> > -	/*
> > -	 * The latency of the synchronize_rcu() is too high for cgroups,
> > -	 * avoid it at the cost of forcing all readers into the slow path.
> > -	 */
> > -	rcu_sync_enter_start(&cgroup_threadgroup_rwsem.rss);
> 
> Note that it doesn't have other users, probably you can kill it.

Ah, nice, will do that.

Thanks.

-- 
tejun
