Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A655358A1C
	for <lists+cgroups@lfdr.de>; Thu,  8 Apr 2021 18:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbhDHQtz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Apr 2021 12:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbhDHQtz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Apr 2021 12:49:55 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D5DC061760
        for <cgroups@vger.kernel.org>; Thu,  8 Apr 2021 09:49:42 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so2925321otb.7
        for <cgroups@vger.kernel.org>; Thu, 08 Apr 2021 09:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BvgEZr+K7yzxkeeyCsAz2iteiOgpmUKfpWfzbHaQazM=;
        b=GM0Wm4vFW/wf2eICOC4yCXvbYGJwlw9Qzt8P3f39zrRJ6Gza4ov6DMssm5SoYpypYQ
         ejN+t5t7XH1HFSXNTlX+8YT+tcY6j+DnuxieEZsXpF7TqjI7aoLMPCvN5XTXl5z89ddw
         aOxex4Y4omGcHPFpe+7B/rEQJx+Wz4Fe8JPKPwTR1HbRrWwJTBxXyvZkFYoxmeEdmf70
         DCPwDo1keA2LHj6ufy6XOIXsSlLF0zbDqcQ5d/vfgkY//tbOIZqru1jm0YvwwUWatsxe
         HipsoNE2hu8vclcBy+TtkXtrPgYu7K7VTICtJ9+DMrFSBRSleeBivrlHYJ4/faSPFVGD
         HgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BvgEZr+K7yzxkeeyCsAz2iteiOgpmUKfpWfzbHaQazM=;
        b=nbAjdhhgycJ1NFRy1nCskeYiPwj+aS/GO1CvxMGbJcRl1fssFRcDJiuSBAes0oAOSe
         AjT27b20JtsalOc87nQV8e0fVocp0cY76KkE7rIRF4d1W+PTycKqYn8tACjG76Iy7y8B
         xhV8ucEiHBr4L+22vZtDpVz5KEAEhxK5GbdrVBMLl7poERNPfVhA5dDPvECfv8C44bWA
         HCTnQRLdtYzBeHcHyc0EmvS87B/VBwOCp7PQwjj97xPzDkj5uiq1OEPqOvdNPXwBf4in
         cyECJLX40Ufs0MBrLDK+Of8xoiZOg8yDCnHZQpNe2KPV0mWAGs91/NLiIfMvfi6p7aw3
         Af2Q==
X-Gm-Message-State: AOAM5312q1ufRIzhC7tr6AuXihwZb0mB3gf55lAgwsyaPVo15Al60VcM
        7bmFVoppgEOAzUeEnSfi9jYx9Hz6OCxjWqQDOsg=
X-Google-Smtp-Source: ABdhPJwUTS3Ey6kevVZdMeQAMfJogmt0P+Vwsvj2NgMBceNlkn1p8XRzCPFKqbVCkyFlGpZoanlDxA9mMlO1opmRzpM=
X-Received: by 2002:a9d:5614:: with SMTP id e20mr8280754oti.304.1617900581804;
 Thu, 08 Apr 2021 09:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1617355387.git.yuleixzhang@tencent.com> <YGn3iHBp5UweFv2/@mtj.duckdns.org>
In-Reply-To: <YGn3iHBp5UweFv2/@mtj.duckdns.org>
From:   yulei zhang <yulei.kernel@gmail.com>
Date:   Fri, 9 Apr 2021 00:49:30 +0800
Message-ID: <CACZOiM0xA+6kAeM2sk3SfVV9Vu+5dOzC7APoNmB0Zw3jQKbg+w@mail.gmail.com>
Subject: Re: [RFC 0/1] Introduce new attribute "priority" to control group
To:     Tejun Heo <tj@kernel.org>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, christian@brauner.io,
        cgroups@vger.kernel.org, benbjiang@tencent.com,
        Wanpeng Li <kernellwp@gmail.com>,
        Haiwei Li <lihaiwei.kernel@gmail.com>, linussli@tencent.com,
        herberthbli@tencent.com, lennychen@tencent.com,
        allanyuliu@tencent.com, Yulei Zhang <yuleixzhang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 5, 2021 at 1:29 AM Tejun Heo <tj@kernel.org> wrote:
>
> On Sun, Apr 04, 2021 at 10:51:53PM +0800, yulei.kernel@gmail.com wrote:
> > From: Yulei Zhang <yuleixzhang@tencent.com>
> >
> > This patch is the init patch of a series which we want to present the idea
> > of prioritized tasks management. As the cloud computing introduces intricate
> > configurations to provide customized infrasturctures and friendly user
> > experiences, in order to maximum utilization of sources and improve the
> > efficiency of arrangement, we add the new attribute "priority" to control
> > group, which could be used as graded factor by subssystems to manipulate
> > the behaviors of processes.
> >
> > Base on the order of priority, we could apply different resource configuration
> > strategies, sometimes it will be more accuracy instead of fine tuning in each
> > subsystem. And of course to set fundamental rules, for example, high priority
> > cgroups could seize the resource from cgroups with lower priority all the time.
> >
> > The default value of "priority" is set to 0 which means the highest
> > priority, and the totally levels of priority is defined by
> > CGROUP_PRIORITY_MAX. Each subsystem could register callback to receive the
> > priority change notification for their own purposes.
> >
> > We would like to send out the corresponding features in the coming weeks,
> > which are relaying on the priority settings. For example, the prioritized
> > oom, memory reclaiming and cpu schedule strategy.
>
> We've been trying really hard to give each interface semantics which is
> logical and describable independent of the implementation details. This runs
> precisely against that.
>
> Thanks.
>
> --
> tejun

Thanks for the feedback. I am afraid that I didn't express myself clearly
about the idea of the priority attribute. We don't want to overwrite
the semantics
for each interface in cgroup, just hope to introduce another factor that could
help us apply the management strategy. For example, In our production
environment
K8s has its own priority class to implement the Qos, and it will be
very helpful
if control group could provide corresponding priority to assist the
implementation.
-Yulei
