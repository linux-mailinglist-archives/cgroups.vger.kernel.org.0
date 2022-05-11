Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038CB522A86
	for <lists+cgroups@lfdr.de>; Wed, 11 May 2022 05:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiEKDsU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 May 2022 23:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240289AbiEKDsT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 May 2022 23:48:19 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB6916D108
        for <cgroups@vger.kernel.org>; Tue, 10 May 2022 20:48:15 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id e3so835787ios.6
        for <cgroups@vger.kernel.org>; Tue, 10 May 2022 20:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8DfmonqPmvYWBc2QfJoYX1TyXXOUpf1yte699p2vRko=;
        b=c4ONip93EWQzvqAbNrC5br9qHeXBQotwUU/+5KtFhNPKs0hB+IhK/cPXNIhJ6bf+gz
         HTyItcafAX+evVodrDCAmEcII02ETvE6RVKHUV/EwSvbb6mwv2i7+duGWnnRexG9V2zm
         dLG3cOoVJaUktsvn2xeZwzf3byuxD31e43umqHPSJTjzpXg3wd78d7eUIAi2pSRR2uxa
         VphWkk86A6Mx+Y4upe/x9Cza7mmKeTsIf8Mu4Wq57pL28N6lbb2oku0BD1D5cybdKFtg
         riq51SeEyG0FBHpCmXhw2LBGqgogN5W7mnhULeFKMPidliiOMzC6LSf5LpJegE2Ws9Ir
         LHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8DfmonqPmvYWBc2QfJoYX1TyXXOUpf1yte699p2vRko=;
        b=SM+cw3VuS1oPVekA3OAqlzx8USSLYKESJD+YBBfTjwNYaqe7x7GYeBOZFIAVTEFTwd
         3GKaLQGPkcZQZfbZSKeCOHH2Gmrgo77OirkS0+IDVP9t4KzP+aQI1+GnurSIwUkfKvbm
         XED/AgIYlCmukBMBX6CAxVBk+CkvvSHTV9npVEhvlzTzoqZK5qZ2fqnfCcQLWjHwt5tE
         TSRtaShvH5ghDDbQuT0FUREoreeNxZkcBlwGtDWdKJFSpTxQ9SfBIy/5l0LaNjz3qtyI
         /VT34rMONBKZSb4p2hLoGPLCE7Km5j+d9BEFrJTRVtI59cNL726XNP0HW/uYtArnJaPC
         zJTA==
X-Gm-Message-State: AOAM533/KEReGHozW16g6Ww5fUBoPakk4QJNX5PeldPVsjM0IFb0eDq8
        RvHxecD73DWVFmIJhjx5XydtWCF1DK7AQRHs5I9SIg==
X-Google-Smtp-Source: ABdhPJxPihOz4blNUpIL17ddDVB8CFoB/qm+7zMHlOcvuky3lU+WyH29Z43+vdt4iPcQZ+5Shm5FpiCwa9+/LbEVpBw=
X-Received: by 2002:a05:6602:20d9:b0:657:b18c:4a33 with SMTP id
 25-20020a05660220d900b00657b18c4a33mr10123431ioz.82.1652240894214; Tue, 10
 May 2022 20:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220507050916.GA13577@us192.sjc.aristanetworks.com> <Ynsj6cZa8hUVYmhu@carbon>
In-Reply-To: <Ynsj6cZa8hUVYmhu@carbon>
From:   Ganesan Rajagopal <rganesan@arista.com>
Date:   Wed, 11 May 2022 09:17:37 +0530
Message-ID: <CAPD3tpG+ZP2uLGkaPJowQhKVkF11rrg1m6D-LjmG=66YP+VkUQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/memcontrol: Export memcg->watermark via sysfs for
 v2 memcg
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 11, 2022 at 8:18 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> On Fri, May 06, 2022 at 10:09:16PM -0700, Ganesan Rajagopal wrote:
> > We run a lot of automated tests when building our software and run into
> > OOM scenarios when the tests run unbounded. v1 memcg exports
> > memcg->watermark as "memory.max_usage_in_bytes" in sysfs. We use this
> > metric to heuristically limit the number of tests that can run in
> > parallel based on per test historical data.
> >
> > This metric is currently not exported for v2 memcg and there is no
> > other easy way of getting this information. getrusage() syscall returns
> > "ru_maxrss" which can be used as an approximation but that's the max
> > RSS of a single child process across all children instead of the
> > aggregated max for all child processes. The only work around is to
> > periodically poll "memory.current" but that's not practical for
> > short-lived one-off cgroups.
> >
> > Hence, expose memcg->watermark as "memory.peak" for v2 memcg.
> >
> > Signed-off-by: Ganesan Rajagopal <rganesan@arista.com>
>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
>
> I've been asked a couple of times about this feature, so I think it's indeed
> useful.
>
> Thank you for adding it!

You're welcome and thank you for the Ack. Thank you, Shakeel and
Johannes for the review and Ack. The patch has been picked up for
mm-unstable.

Ganesan
