Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3E1652E19
	for <lists+cgroups@lfdr.de>; Wed, 21 Dec 2022 09:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbiLUIvC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Dec 2022 03:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbiLUIuw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Dec 2022 03:50:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764A71F9D5
        for <cgroups@vger.kernel.org>; Wed, 21 Dec 2022 00:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671612606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4dBwPnF71tq2OBO2+/MVeKfW3ISUERpMcMh5zSeUYQo=;
        b=Dvwe/fgv3RdROeps1ZWhjDPLHSHBwevbfmt7eSB2Nzc53XzlRvHPQ7iyE4BLI/ntvzfkJG
        PmEmykTwOIWB2xPKOLcuuQO7ydgU3PENnNPS+tkaZNU9Qyy/dpADEx8VBFlj9AOwqnkZ/M
        tjTN2VjC35GFEkZMPiFFsn7vZ/cwS5A=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-322-FLRc9SS0O1eoiY7aRhNP0A-1; Wed, 21 Dec 2022 03:50:05 -0500
X-MC-Unique: FLRc9SS0O1eoiY7aRhNP0A-1
Received: by mail-oo1-f72.google.com with SMTP id w18-20020a4a6d52000000b0049f209d84bbso6641204oof.7
        for <cgroups@vger.kernel.org>; Wed, 21 Dec 2022 00:50:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4dBwPnF71tq2OBO2+/MVeKfW3ISUERpMcMh5zSeUYQo=;
        b=bwt2IfNZSdLVFslCe/Ad1BCJ04emHi9iz4bz+YnIJm1FHq+aDEqo5nfXmJ+jEPbPww
         C6phHg93KFMCvX5MQ4R5K8MWMQVC/Z+5mAZW+Tq50/hEtJ4HRgrGpLiGkHhd4LelTAjE
         f+9KrwJUDprPyJPiKteBR8lVwgGYAe4sgr8qQnQYFSJaCuW7Gv6Za4huuCzEmRMIemzt
         wrDubHQt4YRVZ5iRLqB0TLgrJjCbB5k8bf4D3MGvDe/jV8WiN8ZFJahWrBNfcQiyBidv
         lwzUqArjOuoXcvl8vaD99OQFmCu4LlPka3bgKp7AKLZSgE3Lf9yVdoJIJh59R/vVrAKt
         MFSw==
X-Gm-Message-State: AFqh2koQyBcZKMOKm8WRtANEjPIz1Hf7cbNAd0hQhue6eR3j0CE8mKii
        BSRgn2R/pc/Cirwru3I0X9IXoN7Vd75ocoEMKnH9pSEKEx1Z85zr7EXs8E2xB8wraHig/Gb7roV
        tBItWodPM7nZ4xddfwo1BMeze5a3K9etbSA==
X-Received: by 2002:a4a:980c:0:b0:4a0:62e4:a192 with SMTP id y12-20020a4a980c000000b004a062e4a192mr51319ooi.78.1671612604601;
        Wed, 21 Dec 2022 00:50:04 -0800 (PST)
X-Google-Smtp-Source: AMrXdXslyTOgeUlNt0sPUExCep8NUGSb37Gj09+Cg6gLHYKbelf9rY8DM5avfZcrkERlhspuorchfOA8RlSLk1PbuLE=
X-Received: by 2002:a4a:980c:0:b0:4a0:62e4:a192 with SMTP id
 y12-20020a4a980c000000b004a062e4a192mr51318ooi.78.1671612604440; Wed, 21 Dec
 2022 00:50:04 -0800 (PST)
MIME-Version: 1.0
References: <20221220151415.856093-1-neelx@redhat.com> <9295b73a-5a3c-b1f6-d892-0da1d356ab9f@redhat.com>
In-Reply-To: <9295b73a-5a3c-b1f6-d892-0da1d356ab9f@redhat.com>
From:   Daniel Vacek <neelx@redhat.com>
Date:   Wed, 21 Dec 2022 09:49:28 +0100
Message-ID: <CACjP9X90VT=sd_wT9MWg062qs=CRadsaj6V9gOMXSEJ7Up5Hzg@mail.gmail.com>
Subject: Re: [PATCH] cgroup/cpuset: no need to explicitly init a global static variable
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Dec 20, 2022 at 5:59 PM Waiman Long <longman@redhat.com> wrote:
>
> On 12/20/22 10:14, Daniel Vacek wrote:
> > cpuset_rwsem is a static variable. It's initialized at build time and so
> > there's no need for explicit runtime init leaking one percpu int.
>
> It will be clearer if you mention that DEFINE_STATIC_PERCPU_RWSEM() is
> used to set up cpuset_rwsem at build time. Other than that, the patch
> looks good to me.

That's true. I only figured later.
Whoever is going to apply it, feel free to amend the message if you like.

--nX

> Cheers,
> Longman
>

