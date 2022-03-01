Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65E94C9167
	for <lists+cgroups@lfdr.de>; Tue,  1 Mar 2022 18:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbiCARWz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Mar 2022 12:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbiCARWy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Mar 2022 12:22:54 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0762DA96
        for <cgroups@vger.kernel.org>; Tue,  1 Mar 2022 09:22:13 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id z16so14873064pfh.3
        for <cgroups@vger.kernel.org>; Tue, 01 Mar 2022 09:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YmI3sf8/z6VNUU3GK/NGwjBSNbHziWiyj48Jpew7XtE=;
        b=C700QmEoBAgxezGfjxaTykOtQq9AzNdkKWgr6GfKkxBZjNHSkQx/Mizw9hkK8BEprw
         2eqMUBw9IOSfWY7ReSAarzzv99FflP1gmSxiiMPvvSO78RtzZrl1Urlfyv2b1BcYuazX
         HToJYqV/m/iPLvCPzfztlEG81/e7Jwl1jiw0XwjA6n9hAdjK6tYO+9hbqEvbTWfJxj28
         4L4xvaLLyKJmQcSzoM9NWe7AWVEKH+30FVJPlF4IbEF0SE0zbqS1eFSYgdUXhsunTQWI
         nG2w0993cECeAKZuwovO0PEMlYgbzcUz0N+ntOzD52NZimEQjjigU0rsEe69yk1GyI9s
         vtww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YmI3sf8/z6VNUU3GK/NGwjBSNbHziWiyj48Jpew7XtE=;
        b=aCnkHLTGF8HjOn0zNtR1+tkNSmxSjLKlf1ChCfIrRpbwpJ3d795xhCoK1li+wnoIOk
         Ej/N9vH7IXwzcncSwWsC605z+DOh80Rfzaqu/JYn2WXdnTCAXgXDbkdFdZBJs3rXra0R
         SbMQLZYoNPVf+MO3J+X721Kao1WMsOY3JbouItjdB6or15o0GboQk8myY+CPbWVbiK0S
         5lrAIpYtYZhtEsLM99KO5nK5LBLDXy46CLS+TNopYhqXsNkthMw1WZ5pvstM5e3dGpLi
         MlCXwv3YbT6/XyalxvUtt5DVQW6DC/Zj4YfQBL2SeISFNcEASE3gwwxGEx6RsJttfHS1
         7IuQ==
X-Gm-Message-State: AOAM5331LjN1NPga40u66XIz8GBcuqJUyvSUwJsxnYfmW+k8dbSl/+Tf
        shyPBt/S9gZS31VY9SS5fvxVKL9BGSJEH3o4ct9Ong==
X-Google-Smtp-Source: ABdhPJybeDiL39InkiZ7SRlRZFj7cyMX1L8QoV/jWQ3P2+kJGQ6zY14rMiTLgeiB9iu0H8NmbZm1Gh+gGvwDoEAuwZU=
X-Received: by 2002:a63:5148:0:b0:373:c8d7:f23f with SMTP id
 r8-20020a635148000000b00373c8d7f23fmr22407754pgl.509.1646155333223; Tue, 01
 Mar 2022 09:22:13 -0800 (PST)
MIME-Version: 1.0
References: <20220224060148.4092228-1-shakeelb@google.com> <Yh5RiUMegXf92ivM@cmpxchg.org>
In-Reply-To: <Yh5RiUMegXf92ivM@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 1 Mar 2022 09:22:02 -0800
Message-ID: <CALvZod4ZSrhGTNhEXc8JfT0r=v1tNBXsQc6Be-cOLi1UFzzoQQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add myself as a memcg co-maintainer as well
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 1, 2022 at 9:02 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Feb 23, 2022 at 10:01:48PM -0800, Shakeel Butt wrote:
> > I have been contributing and reviewing to the memcg codebase for last
> > couple of years. So, making it official.
> >
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Roman Gushchin <roman.gushchin@linux.dev>
>
> It's already been sent to Linux, but for the record
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks all.
