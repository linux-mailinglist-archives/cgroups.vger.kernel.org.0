Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551755802E9
	for <lists+cgroups@lfdr.de>; Mon, 25 Jul 2022 18:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236398AbiGYQkF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Jul 2022 12:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236522AbiGYQjz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Jul 2022 12:39:55 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7421E3CD
        for <cgroups@vger.kernel.org>; Mon, 25 Jul 2022 09:39:51 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id h22so8657243qta.3
        for <cgroups@vger.kernel.org>; Mon, 25 Jul 2022 09:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7xVgMqmN/86GQHcqXO1yw7VSBDbzPsFu44uQMKjUJeE=;
        b=G1BoE6F8flgmzsQzfW3nkF7mptQonm328gZXYogDGG2IBIo/98/hfHLbhV7UAJkXQI
         X8ynxusv76jgdnblo7OxdqtfwPoXk/rNSeoDm2clKMjo+cyP+MkOivoz3cjRpyBfFOMl
         SIlEVNpakmxkbmqt4+XxLQLJ4QQ5PCkIi8fjAenSwWjxlcnBfytss8LLn3ERV7YvDbZa
         +VH8K1yK0xvi9ijH2dX3DZyfC4rI5TE1UjZr8z9tc/TucWdSj8cQGKObuYxB1bKQ6CbK
         2/AGAfXA0e/T+pDGaivYnTvUT5YBiUB+stnvoGNHnjm/BVx/LCqP/LJmcqT6Q4OGgHau
         mRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7xVgMqmN/86GQHcqXO1yw7VSBDbzPsFu44uQMKjUJeE=;
        b=iTu8JofdlEd//h5ZANvlxYW/7qYyI2V7cb3nwel70otXVCb5jEWz3Oa57IVghz8JES
         makLSGqYB0an0IPHbEfO1rIrQu9zfL4+B8LPXg+GjjJ/Ix1rHiUrRXBeBCf0uTLCFLuJ
         YOcJEFQOYmMZp97vmfT7b4WWJRZIDGoNi2L3KfXByOYUjY1BLI19mw1kCV+0OE5Jpvxh
         o9m2FRB5wFWZabnbyoFoMvMz52YPjmSTKdW1RVMJOAlQhbuzh5Nhmxvyh9RUpkHBZ+Pb
         TpGtplcu0XO0FcRyf9HcpF2tLcctOyt+zjjcPze55lK01fuIGHZHRVuuyZVdsfJ7kUic
         STWA==
X-Gm-Message-State: AJIora/qzhsK3o8/GmcJpmQ/wtg/cNUWQ+B8OwCPlCAg5uA604o0d+fI
        UL4AL8CvhbofIHe6r+ehqLK5dA==
X-Google-Smtp-Source: AGRyM1uKPvbHdE7zEZLQVfC2qN7mSkhxt10ohJq0YaOc0s83Re06cnlkFoQmtVFqPXBDnTfsAuzhwA==
X-Received: by 2002:a05:622a:1710:b0:31f:340:41dc with SMTP id h16-20020a05622a171000b0031f034041dcmr11262377qtk.311.1658767190695;
        Mon, 25 Jul 2022 09:39:50 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:994f])
        by smtp.gmail.com with ESMTPSA id r19-20020a37a813000000b006a6d7c3a82esm9041344qke.15.2022.07.25.09.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 09:39:50 -0700 (PDT)
Date:   Mon, 25 Jul 2022 12:39:49 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        tj@kernel.org, corbet@lwn.net, akpm@linux-foundation.org,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 3/9] sched/psi: move private helpers to sched/stats.h
Message-ID: <Yt7HVcdXMYeNn6uS@cmpxchg.org>
References: <20220721040439.2651-1-zhouchengming@bytedance.com>
 <20220721040439.2651-4-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721040439.2651-4-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 21, 2022 at 12:04:33PM +0800, Chengming Zhou wrote:
> This patch move psi_task_change/psi_task_switch declarations out of
> PSI public header, since they are only needed for implementing the
> PSI stats tracking in sched/stats.h
> 
> psi_task_switch is obvious, psi_task_change can't be public helper
> since it doesn't check psi_disabled static key. And there is no
> any user now, so put it in sched/stats.h too.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
