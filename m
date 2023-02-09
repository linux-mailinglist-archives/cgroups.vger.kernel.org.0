Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BC1690795
	for <lists+cgroups@lfdr.de>; Thu,  9 Feb 2023 12:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjBILkh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Feb 2023 06:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjBILkM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Feb 2023 06:40:12 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD30F6F21E;
        Thu,  9 Feb 2023 03:29:01 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id l1so670465qkg.11;
        Thu, 09 Feb 2023 03:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nV+ybsSlH6fK2G24aANd2g+1dPs+ZMjcUBV127jT5iM=;
        b=X4K+h7SDmsgXeHm6SaOqKeAx/ak9ol/Gl36DDVrtd9v5mfV9VkvblhU8nQ43XAXExl
         0Zt1F2nx9zBjVlXcB9TLAnC4pptj6RhMdfPfaW4zmacNVeI+g/po+g/eMkChVxAP/2Ax
         CNaLrdvnBvR1x//Vr2yOVxi6ZZEf/35FNvK9RLIsbuDGGL6TZD3ypxsOg3oYdWA11JSX
         yrmzxUfCSoBErji/R5CkNVV5s1KtCukigZsgcVZWCc6iRl2caL7yZR0Vz5WN4B25B3Fp
         jNQachOCoE6xeArss8RVs5hTwBaK6XEl43IezJq0vEZXHe1+l8IlpFNDe7I+gyGTcW9S
         rR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nV+ybsSlH6fK2G24aANd2g+1dPs+ZMjcUBV127jT5iM=;
        b=kvzZBS9/Pe/5+POH8V7Dq3sgCNjLhs1ANrHN86NSeKKoc6Dk+Qcu790v1hpA3v/cFf
         PbNCFPzoDQg9BulOJdu8EQLSPO9v0Qmm2FuKPloidDElcGaLOD0I8zfHYl1yWocAv4EE
         nxlrUXZcwQrYKNtSvSbbLkh5nucHfbpS/r/35Hzs8IsiQOzrOthOy7zVo4i4YoXDzdVA
         cxHfFPySKg4SM/1a/17BI0EXMQcBRt99F0FgFXwnZeXKN7phAwpmVO1zYA5M42T9Nnmm
         Cg+2tE877OOpUpwPqWtMe/R51Igv6cv0JWSrwLCMk1Tl8lZVrtK33MjiU2J6AxWORkaN
         onrA==
X-Gm-Message-State: AO0yUKUT5jekj222qY4zPa9XtL/Gsf0Ty1/pXZ3tmCm/jVzVcsMJbJqq
        i6EIVOCURjgZdLRZsLI+vhheKgdNu96AvW2eUH0=
X-Google-Smtp-Source: AK7set/aIuykduscL5dzsclscusdVySBk+Rd/puuz7bsZmF73NHfo4uN7Spu0LUCITVs/SjLa3b05rTr5/LxNbAB9mY=
X-Received: by 2002:a37:42d5:0:b0:738:dd4d:986e with SMTP id
 p204-20020a3742d5000000b00738dd4d986emr421433qka.409.1675942075520; Thu, 09
 Feb 2023 03:27:55 -0800 (PST)
MIME-Version: 1.0
References: <20230205065805.19598-1-laoar.shao@gmail.com> <20230205065805.19598-3-laoar.shao@gmail.com>
 <Y+P3HSLNR94wILP1@cmpxchg.org>
In-Reply-To: <Y+P3HSLNR94wILP1@cmpxchg.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 9 Feb 2023 19:27:19 +0800
Message-ID: <CALOAHbDSD6Nztr-Twa=nEEViBjCY5O3_1Ma6sRH4tJ-h_xvDzA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] bpf: use bpf_map_kvcalloc in bpf_local_storage
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     tj@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, akpm@linux-foundation.org,
        bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 9, 2023 at 3:25 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Sun, Feb 05, 2023 at 06:58:02AM +0000, Yafang Shao wrote:
> > Introduce new helper bpf_map_kvcalloc() for this memory allocation. Then
> > bpf_local_storage will be the same with other map's creation.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>
> This looks good to me, but it could be helpful to explain the
> user-visible part of the bug somewhat, i.e. who is being charged right
> now for the allocation if it's not the map owner.

Sure. Will improve the commit log.

-- 
Regards
Yafang
