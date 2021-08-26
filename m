Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209093F8CF1
	for <lists+cgroups@lfdr.de>; Thu, 26 Aug 2021 19:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243103AbhHZR0S (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 Aug 2021 13:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbhHZR0Q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 Aug 2021 13:26:16 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789F0C0613C1;
        Thu, 26 Aug 2021 10:25:28 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id k24so3635333pgh.8;
        Thu, 26 Aug 2021 10:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wg3NGSKG8aeY7CfUKjajWr4BQ6jE7IKLYam6kXWpQR4=;
        b=FatKQJFGvF/uj4c0Nq7U98B9Wxi4EGgW/sF5kqboMN0PeaRo4s0JRHucj7JtTUJziS
         CEyuGxH/MDGiBkM8ahWO1ogWn/STms5ZQtaBM1ux/7Knf2VDDuICgA+frGaQgoyTdlAl
         MMuZuPWQw5Hu81El1wEZCOGc66b3/dRY5veu07iWn+9DHz7i42pEGCu5m66ZJHkgzoE2
         vsOpCTUTrDCNQlUnCXishzRWxHnU9G89l0IDTrEnadjFvl6GcrkvHnGdeUuaqPDzN3LY
         owiA4Hhm5e/61zLicZIProXx/hS7Tg55CE+iNcSBbnK/wH2Fol6jBvvGmPHoxUu+gyd4
         fGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=wg3NGSKG8aeY7CfUKjajWr4BQ6jE7IKLYam6kXWpQR4=;
        b=GyTAOSwbCyX1RzytElh3EgNOxVHssaZdfTwUZNzqINU/iL439nHcCGotqf3b3eIiLd
         3TDrMB85ju6Ch/jWJb7DBdRXNvrXC3wCSDJUJ29EzffQAjAfpybmei+umhthyPfe/2E2
         4A86MXItIaNPljIKYCFyg9ajkboRjijB6s3CPk7AZLKkn0tGQ6swzLdJ1CCZJUFt4Nq/
         XUDYd9vA4o5JPP137WHvKpc9HXPTWDj0CgBP+M35WZ5jdEqHziZEJLCRvcm2PbYg6qRX
         cY05uLlmmHqdwb1EQAbNbbWJwWN/s/AfbXpdQNjdazxTwSvCqNEvNrkUARzwS1fyg3Os
         G03g==
X-Gm-Message-State: AOAM533X7VAbAS0ExqbRpAOgUsKMJ9cW+MWarx5k5y4NkrrSIIJCexKz
        wnzsQILtwKkdPeQVMDkUA/w=
X-Google-Smtp-Source: ABdhPJxoLQ2Vjm9jEu975SKkK2f6C/Bx7IXPRMdhI++8Dm9G1SmRWFfX0y/Mh8AX3aboTF+uItwGPg==
X-Received: by 2002:a65:6487:: with SMTP id e7mr4208082pgv.27.1629998727774;
        Thu, 26 Aug 2021 10:25:27 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:a096])
        by smtp.gmail.com with ESMTPSA id p3sm9547728pjt.0.2021.08.26.10.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 10:25:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 26 Aug 2021 07:25:24 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, cgroups@vger.kernel.org
Subject: Re: BFQ cgroup weights range
Message-ID: <YSfOhM9+uJ5/FzY2@mtj.duckdns.org>
References: <20210824105626.GA11367@blackbody.suse.cz>
 <EC36D67F-D7CC-4059-8D3B-E0E64DFC3ADB@linaro.org>
 <20210826131212.GE4520@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210826131212.GE4520@blackbody.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 26, 2021 at 03:12:12PM +0200, Michal Koutný wrote:
> On Tue, Aug 24, 2021 at 02:51:47PM +0200, Paolo Valente <paolo.valente@linaro.org> wrote:
> > BFQ inherited these constants when we forked it from CFQ.  I'm ok with
> > increasing max weight to 10000.  I only wonder whether this would
> > break some configuration, as the currently maximum weight would not be
> > the maximum weight any longer.
> 
> Thanks for the reply. Let me form the idea as a patch (and commit
> message) and discuss based on that if needed (+ccrosspost into cgroups
> ML).
> 
> -- >8 --
> From: Michal Koutný <mkoutny@suse.com>
> Subject: [PATCH] block, bfq: Accept symmetric weight adjustments
> 
> The allowed range for BFQ weights is currently 1..1000 with 100 being
> the default. There is no apparent reason to not accept weight
> adjustments of same ratio on both sides of the default. This change
> makes the attribute domain consistent with other cgroup (v2) knobs with
> the weight semantics.
> 
> This extension of the range does not restrict existing configurations
> (quite the opposite). This may affect setups where weights >1000 were
> attempted to be set but failed with the default 100. Such cgroups would
> attain their intended weight now. This is a changed behavior but it
> rectifies the situation (similar intention to the commit 69d7fde5909b
> ("blkcg: use CGROUP_WEIGHT_* scale for io.weight on the unified
> hierarchy") for CFQ formerly (and v2 only)).
> 
> Additionally, the changed range does not imply all IO workloads can be
> really controlled to achieve the widest possible ratio 1:10^4.
> 
> Signed-off-by: Michal Koutný <mkoutny@suse.com>

Looks fine to me.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
