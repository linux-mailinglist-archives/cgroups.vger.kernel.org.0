Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0252298E92
	for <lists+cgroups@lfdr.de>; Mon, 26 Oct 2020 14:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780765AbgJZNzX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Oct 2020 09:55:23 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35564 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1780760AbgJZNzW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Oct 2020 09:55:22 -0400
Received: by mail-qk1-f193.google.com with SMTP id 140so8327068qko.2
        for <cgroups@vger.kernel.org>; Mon, 26 Oct 2020 06:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jX24QeKkjdOlvJuc0hUsXeiJL0gdps1PYbhorm/jTvI=;
        b=QcgGE2zq5tlg4aRL6rRQryJ9lB/2am/wpjipaPG+tIN34AxOJFVTXDEiRd5jYhNQba
         KzdcOLXV5fnScA5MK6tI1qh2n3DKO4jKfWwjGJWi+8SMwPtlKp61N0vxLBeNSrAyZUWI
         W57zxGvbQiR59vwvVURVHWHA6Xk7p6nllu+8Dq0nVIyR0bNvjaUf8uMOB+GyJUB5L+15
         ubcx0oIxBrwmd6GkDvAkTJb9kBHSErrxAlW/rDNqO1wZQvBDs5ocxzW7J0nYuLht763N
         05WxcoYLLLp03NlC9P5to3hwkOwacuIdHKk57qsA9CH4I04QRNSsmTEdmrnDrN4P79q3
         tvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jX24QeKkjdOlvJuc0hUsXeiJL0gdps1PYbhorm/jTvI=;
        b=geOPaGKcFASabFVt2rJdvj3PtRgUm8/QSbmJ3CusouTgTbnTm5XX4BZgq312Qpl1lx
         DGRVbFjsiE7JCTc7jaUKytTFedrUUI+FmY0Y8Kfp2pWtk0a/oeNk/DfKfetCd9CPVhNt
         p4rwI9UHTP36EsKoT6mo+guM8ZLB2M5zG69oJk3Rx2qD+J8kbSaIEG3ie/+afkqEHAri
         TyId8jy9bDyHEV8lpRNtc3JYX73qVs1SeKEmYtgaDC4qcU1LnJMKXinpjr/TasgL9Ihk
         nAOzazUfiv4rwd44Gfl5UEM1YppZbQuHccHxhA8gKCCkIQGGVBXwcr0iXpgNl4ti4EpT
         WuqQ==
X-Gm-Message-State: AOAM532vHsGHBvYo0Wn5Yu8Ly94zP+3ls5U+ElU6JIeFjFINiT78dyic
        D3znPA7xZipsQ/ghFYvSIjo=
X-Google-Smtp-Source: ABdhPJwPDgJf59FGhJ51ZW7XLamC/zzTwZj21UHPIW3jkIbMvy9gtyYrscUOo2+DEWQiy6X0H+nE2g==
X-Received: by 2002:ae9:e804:: with SMTP id a4mr13989855qkg.324.1603720521513;
        Mon, 26 Oct 2020 06:55:21 -0700 (PDT)
Received: from localhost (dhcp-48-d6-d5-c6-42-27.cpe.echoes.net. [199.96.181.106])
        by smtp.gmail.com with ESMTPSA id d142sm6570555qke.125.2020.10.26.06.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 06:55:20 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 26 Oct 2020 09:55:18 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org, khazhy@google.com,
        kernel@collabora.com
Subject: Re: [PATCH v2 2/2] blk-cgroup: Pre-allocate tree node on
 blkg_conf_prep
Message-ID: <20201026135518.GE73258@mtj.duckdns.org>
References: <20201022205842.1739739-1-krisman@collabora.com>
 <20201022205842.1739739-3-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022205842.1739739-3-krisman@collabora.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 22, 2020 at 04:58:42PM -0400, Gabriel Krisman Bertazi wrote:
> Similarly to commit 457e490f2b741 ("blkcg: allocate struct blkcg_gq
> outside request queue spinlock"), blkg_create can also trigger
> occasional -ENOMEM failures at the radix insertion because any
> allocation inside blkg_create has to be non-blocking, making it more
> likely to fail.  This causes trouble for userspace tools trying to
> configure io weights who need to deal with this condition.
> 
> This patch reduces the occurrence of -ENOMEMs on this path by preloading
> the radix tree element on a GFP_KERNEL context, such that we guarantee
> the later non-blocking insertion won't fail.
> 
> A similar solution exists in blkcg_init_queue for the same situation.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
