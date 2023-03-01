Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06736A74C2
	for <lists+cgroups@lfdr.de>; Wed,  1 Mar 2023 21:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjCAUHz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Mar 2023 15:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCAUHy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Mar 2023 15:07:54 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09612D53
        for <cgroups@vger.kernel.org>; Wed,  1 Mar 2023 12:07:52 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id w23so15707841qtn.6
        for <cgroups@vger.kernel.org>; Wed, 01 Mar 2023 12:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1677701272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EAcp6gwJPIpQSJ5evzEyfrtFkdf4nPPjMijC6R20IBI=;
        b=F3ZYH+5Px/N5yjWu3nYFhIw28OIIi3vK0lrj9VXXDVqd7nyUsmYzdUcZH15UNBaQ18
         P6d3947mCJmysie/OTvSpOzJur1L4DsVnRqK+EK3L/lF/5CYUVYe00hr51kzsp7jplxy
         kFNIZzjVOyU/3/NXzrYxkfKTvB0l2OxAO78e/pq9VctGhD8PQPdAAc5gMoQ5P43g//Q+
         WdSdzRPpLmumJRD5YsFiIFDMLyUDRZy2fhlbxZxoXeShB7UYoP4fVnfoWJeRtH8o2zXL
         oRn1MC0/8QMRNTvVSRsVqbt/Hwm831MREuiRJbleArO36wnUJHRYSvw/uyhNG04vl2t8
         Azqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677701272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAcp6gwJPIpQSJ5evzEyfrtFkdf4nPPjMijC6R20IBI=;
        b=ZpKDGxuUEkO0+SBjxndE0i3zeX4geBMaAYf5Jqexf935w6Ieyap5TCE4GKyWDbTqNg
         9hgtGSQ4NvADmv6hz4QDpORHIdEn3eiFuQePoM8tAOgFK9J0eFFunWRrh8LFk3jxUKCw
         WOasHYV8sD1egFH/cB+MiI0bQ3/Bqj87XEv4MMJWgd4soxWRuB1DJCXvFZEbp1ing6oD
         E8HjfBVaE8uiH5bqWHVBuIdp4pAXw0SbaEBU1k29AyemRbYdXtfiAIenP7hESsLZvuQJ
         /RvSlLw2gUc7DMVkxP3IRjBmlFq89CxzwxOR6czKw/UyVVBIy1rSWWiang9IECwfreWM
         PpcA==
X-Gm-Message-State: AO0yUKUGhJF9XL+dCwRvNJsiDbjUTohmS8g79v+KoN+XVVHFvKwvf6xi
        61vEhlca0BQ2kt+HHz3JmcOOVQ==
X-Google-Smtp-Source: AK7set8fklZoidZ6wJPlErKN58Hjas3ZHyXPUbpl8sIiemNVnmVVNAxl92wHSOfvT9RXVfLNyf763g==
X-Received: by 2002:ac8:5a52:0:b0:3bf:d1b3:2be2 with SMTP id o18-20020ac85a52000000b003bfd1b32be2mr12989708qta.63.1677701272045;
        Wed, 01 Mar 2023 12:07:52 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:19d])
        by smtp.gmail.com with ESMTPSA id q13-20020ac8450d000000b003bfad864e81sm8925102qtn.69.2023.03.01.12.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 12:07:51 -0800 (PST)
Date:   Wed, 1 Mar 2023 15:07:50 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, peterz@infradead.org,
        johunt@akamai.com, mhocko@suse.com, keescook@chromium.org,
        quic_sudaraja@quicinc.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] psi: remove 500ms min window size limitation for
 triggers
Message-ID: <Y/+wlg5L8A1iebya@cmpxchg.org>
References: <20230301193403.1507484-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301193403.1507484-1-surenb@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 01, 2023 at 11:34:03AM -0800, Suren Baghdasaryan wrote:
> Current 500ms min window size for psi triggers limits polling interval
> to 50ms to prevent polling threads from using too much cpu bandwidth by
> polling too frequently. However the number of cgroups with triggers is
> unlimited, so this protection can be defeated by creating multiple
> cgroups with psi triggers (triggers in each cgroup are served by a single
> "psimon" kernel thread).
> Instead of limiting min polling period, which also limits the latency of
> psi events, it's better to limit psi trigger creation to authorized users
> only, like we do for system-wide psi triggers (/proc/pressure/* files can
> be written only by processes with CAP_SYS_RESOURCE capability). This also
> makes access rules for cgroup psi files consistent with system-wide ones.
> Add a CAP_SYS_RESOURCE capability check for cgroup psi file writers and
> remove the psi window min size limitation.
> 
> Suggested-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
> Link: https://lore.kernel.org/all/cover.1676067791.git.quic_sudaraja@quicinc.com/
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  kernel/cgroup/cgroup.c | 10 ++++++++++
>  kernel/sched/psi.c     |  4 +---
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 935e8121b21e..b600a6baaeca 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -3867,6 +3867,12 @@ static __poll_t cgroup_pressure_poll(struct kernfs_open_file *of,
>  	return psi_trigger_poll(&ctx->psi.trigger, of->file, pt);
>  }
>  
> +static int cgroup_pressure_open(struct kernfs_open_file *of)
> +{
> +	return (of->file->f_mode & FMODE_WRITE && !capable(CAP_SYS_RESOURCE)) ?
> +		-EPERM : 0;
> +}

I agree with the change, but it's a bit unfortunate that this check is
duplicated between system and cgroup.

What do you think about psi_trigger_create() taking the file and
checking FMODE_WRITE and CAP_SYS_RESOURCE against file->f_cred?
