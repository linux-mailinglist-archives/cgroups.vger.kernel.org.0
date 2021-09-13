Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E63E409C6B
	for <lists+cgroups@lfdr.de>; Mon, 13 Sep 2021 20:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240569AbhIMSlw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Sep 2021 14:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhIMSlv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Sep 2021 14:41:51 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3254C061574;
        Mon, 13 Sep 2021 11:40:35 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d18so6428102pll.11;
        Mon, 13 Sep 2021 11:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wB2kZQi2yYu38ZGIaOL/8KKQVA5tStMoy5uDjSp6HHE=;
        b=BPIn3x2JdlanyUdxqvocPhIYYwHV4UVqewuwhwqBZIvRdSMO0Ij+uDxQwD8iunjp1+
         1O8kc+OmXlpuWy8/OjK0NEDpAUC4rnueJV/D9thIZvCY82XXtk3kcU9A7sMsM8nkWxtN
         DphBLOHfA03swEEEoHzBJautvvpUcQ3lr0GSe2gCVKa/Kt6cyUW+i7olZxDBclR80l+q
         MpfVMV86cbC/fVENokzOUo3e6pzOne97XXduvt55l5y4HaP6pwFcv/chgGYnIsY/ig4g
         MR3oNkhLDZl5s6fxzLR6LHkaRS7wUkXXh2IgjRM/fgDzvaR4TN1pfNg3/4D9gU6HkLWE
         CWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=wB2kZQi2yYu38ZGIaOL/8KKQVA5tStMoy5uDjSp6HHE=;
        b=BR291geLEyxFl5qZnXd/Qms/z0Qbv8iWSzJc8UJFAF/UoLl4NJ61mjGAeuPNTCPfWS
         0TFXU3cqTkY0YpbyTmZqX35T2xaFRyK1x+PnxdrTlC4r7IuPCz1RJmLB2yAQSUB6JsWJ
         AD2e3we9+o+yivH7GHYy/NYliYEN+NooOy0Wj8r490GTrO9iYg3T2iIfE5SHvUw9FKRq
         /jm/LbPnb3lH2Nc90iuJwx5dvxF/3oJYLY6269xov1GDa928Z2NdWIOW2GFth+faH5FD
         Nkm72qOU8pWEg5u2h/fyuPz8lYPqLoTQ/vRKkr7RUf758SgpO1dWoUQ2DB/fAQbwg+cQ
         x0ug==
X-Gm-Message-State: AOAM532/FA7I92OOJhd652z5EyIzCbWq8c21DwsTtbEbH4n9bilFsC6D
        /EnD1r7t4bTKL7ZLIiRcTUs=
X-Google-Smtp-Source: ABdhPJz03GsHDIrQrfgTnPgS3TNklykyQc48D7FuBwBR3k3P3gSHsT/JHme7KoXHwZb6/3u+VfC/vw==
X-Received: by 2002:a17:902:780f:b0:13a:3a88:f4cb with SMTP id p15-20020a170902780f00b0013a3a88f4cbmr11668720pll.68.1631558435084;
        Mon, 13 Sep 2021 11:40:35 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id x8sm3089506pfm.8.2021.09.13.11.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 11:40:34 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 13 Sep 2021 08:40:33 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <llong@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Juri Lelli <juri.lelli@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cgroup: Fix incorrect warning from
 cgroup_apply_control_disable()
Message-ID: <YT+bIW/CSOlZQlY0@slm.duckdns.org>
References: <20210910024256.7615-1-longman@redhat.com>
 <YT+TA6ItnF9xM3cR@slm.duckdns.org>
 <125c4202-68d1-1a4e-03d6-2b18f0794ba4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <125c4202-68d1-1a4e-03d6-2b18f0794ba4@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Mon, Sep 13, 2021 at 02:35:03PM -0400, Waiman Long wrote:
> The problem with percpu_ref_is_dying() is the fact that it becomes true
> after percpu_ref_exit() is called in css_free_rwork_fn() which has an RCU
> delay. If you want to catch the fact that kill_css() has been called, we can
> check the CSS_DYING flag which is set in kill_css() by commit 33c35aa481786
> ("cgroup: Prevent kill_css() from being called more than once"). Will that
> be an acceptable alternative?

So, it's checking that cgroup_lock_and_drain_offline() which is used by
cgroup_lock_and_drain_offline() actually waited for csses which are in the
process of going offline because some operations aren't safe when racing
against them. I think the right solution here is making sure that [u]mount
path drains the offlining cgroups rather than getting rid of the warning. I
think the warning is pointing out an actual problem.

Thanks.

-- 
tejun
