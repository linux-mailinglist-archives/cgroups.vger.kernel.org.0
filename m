Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032A535392D
	for <lists+cgroups@lfdr.de>; Sun,  4 Apr 2021 19:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhDDR3w (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 4 Apr 2021 13:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbhDDR3v (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 4 Apr 2021 13:29:51 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86888C061756
        for <cgroups@vger.kernel.org>; Sun,  4 Apr 2021 10:29:46 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id c3so4607802qvz.7
        for <cgroups@vger.kernel.org>; Sun, 04 Apr 2021 10:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OZEUSqboDcw+HtCtMOSkDciT/SlQ5QAFuYRmXSX9rkA=;
        b=EnoTD+SOKtJxZf859K9o2lC02HkQGzWR/1z2Br3tVAqf2xxTDw+Ja+hz2EACyfqYT8
         UcM7QFDuLfNoiNDop7thhYp0jFMeRvEhmTdxP0w3qftVK253XoEpo+RG2T4nrytSYv5v
         EV0Ju1WP6YWLnCqaaz94hdImt/LN+of0HmC64US3iFacnvVLFsht8UaNXHQULktYGlCR
         l3fG6Um8cRrW0a0ca75HRtzObP0BtW+kZLFp3PKEM2aaNmhRdL1p3t5Su7wflHzlWm3L
         dexByUr8whbR7okUwSUcKxbEG8jJjcj2D4bSK28z9jIPSiK3IIelG9lzjQzgAPQvXhgb
         7VvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OZEUSqboDcw+HtCtMOSkDciT/SlQ5QAFuYRmXSX9rkA=;
        b=OCeT9cS4yBU0qg7kcMsMjIiPMWPmf5+rEH6a2fedg4K10WgfMA4TBoK/cMFiKHnj1Y
         D690NamXSCq3x4fCYNqriKIQb0agbNdWew+JO6of/EnR0AM2/LoVEu98Isr+La8Fe/49
         oVYaxchxB5Q9VUVRvAmWMduT5CF6APPP5X33ZGRWEA7VvfHnqkotfEHxfAxbjENYlWJw
         unbCt8Uxd9x/x0R6Q77V/pQQRmd3h5uzZt9rxJ9veuefizjWWOr6OXajlfDkeo+BCnEp
         zHziNKqukHs6rxvu8mXCuS20IMmF8Jz39yEJhJiAv5pBqAuH2FOZXyDsIZil/m9kvPWr
         Sb+Q==
X-Gm-Message-State: AOAM533h3AHtAV+dEKsgDcZQz8EztLdOhHOegN5uyXYKTgn8BU0H0cH3
        I3d6t+3UGo5/zlvqAFGNrkWn2OcuteSHOw==
X-Google-Smtp-Source: ABdhPJy8+7XchhKPC23yvaYHZFzMUb9tbv40yHY9bAOHJ/zD/rA+0dMivLyJbuZjnfp7ePMSOFtVqA==
X-Received: by 2002:a05:6214:1391:: with SMTP id g17mr21038392qvz.51.1617557385669;
        Sun, 04 Apr 2021 10:29:45 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id z188sm11961450qkb.40.2021.04.04.10.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 10:29:45 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 4 Apr 2021 13:29:44 -0400
From:   Tejun Heo <tj@kernel.org>
To:     yulei.kernel@gmail.com
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, christian@brauner.io,
        cgroups@vger.kernel.org, benbjiang@tencent.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        linussli@tencent.com, herberthbli@tencent.com,
        lennychen@tencent.com, allanyuliu@tencent.com,
        Yulei Zhang <yuleixzhang@tencent.com>
Subject: Re: [RFC 0/1] Introduce new attribute "priority" to control group
Message-ID: <YGn3iHBp5UweFv2/@mtj.duckdns.org>
References: <cover.1617355387.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617355387.git.yuleixzhang@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Apr 04, 2021 at 10:51:53PM +0800, yulei.kernel@gmail.com wrote:
> From: Yulei Zhang <yuleixzhang@tencent.com>
> 
> This patch is the init patch of a series which we want to present the idea
> of prioritized tasks management. As the cloud computing introduces intricate
> configurations to provide customized infrasturctures and friendly user
> experiences, in order to maximum utilization of sources and improve the
> efficiency of arrangement, we add the new attribute "priority" to control
> group, which could be used as graded factor by subssystems to manipulate
> the behaviors of processes.
> 
> Base on the order of priority, we could apply different resource configuration
> strategies, sometimes it will be more accuracy instead of fine tuning in each
> subsystem. And of course to set fundamental rules, for example, high priority
> cgroups could seize the resource from cgroups with lower priority all the time.
> 
> The default value of "priority" is set to 0 which means the highest
> priority, and the totally levels of priority is defined by
> CGROUP_PRIORITY_MAX. Each subsystem could register callback to receive the
> priority change notification for their own purposes. 
> 
> We would like to send out the corresponding features in the coming weeks,
> which are relaying on the priority settings. For example, the prioritized
> oom, memory reclaiming and cpu schedule strategy.

We've been trying really hard to give each interface semantics which is
logical and describable independent of the implementation details. This runs
precisely against that.

Thanks.

-- 
tejun
