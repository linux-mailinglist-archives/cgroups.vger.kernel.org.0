Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093DC311A9E
	for <lists+cgroups@lfdr.de>; Sat,  6 Feb 2021 05:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhBFEBs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Feb 2021 23:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhBFD7m (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 5 Feb 2021 22:59:42 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35A9C061756;
        Fri,  5 Feb 2021 19:59:01 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id e15so6602380qte.9;
        Fri, 05 Feb 2021 19:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BOfhpI6Pct7YOvRYywamiqV90GYlguNDYCZVZfdMFF4=;
        b=ijefe/7VuijxV7fXltuMQCv2CDhZQmJb4GneqOJpBl03bFpQ9R7lm3ZJn2qvYC3egj
         JtayyTyxDBGm3+RUiEWCUhdEJoY14xs59Q0n+zDOpAJ5m2SDDFbtfzPkFCPD4c4zm5dm
         H9A8GxySd9zaO16fTZM6YGk2nIU5HSdfU8T15TZRVJ+0gAtd747GNaTGJOYiTe160uB6
         7J59DJnEIE74SZsWMQWBL8l4pW8wS/CZ+GDUblW8tX72x97QV9QcbEs9Y2INsOnM/rM6
         81dlxRd9+nXqNLk9taTp/JsBueaXBVFEDg4WjvMd6nxce0aiRvurouTa243dlx4OJI6j
         pexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=BOfhpI6Pct7YOvRYywamiqV90GYlguNDYCZVZfdMFF4=;
        b=Oztj+M/y1DQOBSmA9KC02MfWHBE2+cWZVGdzbD0dap6So1kh66vTnEox9uOBW/lapM
         A1gOuk9x12BSaiXeOqBfioDrrPfj7r5acEiLin+6R6VpDos7Euva7YcC1oMkOT9UqpB2
         jA9xSwO6hiauROWgVjqdJFf3MTOYP41cwDkJ+17sjbmDbpk+MCSmsaWE8KvjlmzLslmc
         qLOxETWW1zKXrK8cX/+vd74dX9QIsMfFW+f+gPlGdir/aGDURh7SUftHoSHXbKTE1ea9
         si0llxBWdJz/dkDQILC8sO0y7VQKTz1Yx2aWSEBQW+xreXpHhme5uL+imdmrcawggfRz
         jSrA==
X-Gm-Message-State: AOAM533Mn22lsMRcN5xefMXDGovyaexZI7jQIbKw6DHYOER0lzSzhfwy
        qWxWnePyDAa4LLw2pcvzKI0=
X-Google-Smtp-Source: ABdhPJxHU0djNxKsFfcG4kkVF/LLNPr6VomPir5Bk+1Ok/DpWAT3ivhJVFGm/F38GogVG8ysqI5eGQ==
X-Received: by 2002:ac8:5d0d:: with SMTP id f13mr7172637qtx.317.1612583940812;
        Fri, 05 Feb 2021 19:59:00 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id h5sm10540341qti.22.2021.02.05.19.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 19:59:00 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 5 Feb 2021 22:58:09 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 0/8] mm: memcontrol: switch to rstat v2
Message-ID: <YB4T0eX3XDiLPNI1@mtj.duckdns.org>
References: <20210205182806.17220-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205182806.17220-1-hannes@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 05, 2021 at 01:27:58PM -0500, Johannes Weiner wrote:
> This is version 2 of the memcg rstat patches. Updates since v1:
> 
> - added cgroup selftest output (see test section below) (thanks Roman)
> - updated cgroup selftest to match new kernel implementation
> - added Fixes: tag to 'mm: memcontrol: fix cpuhotplug statistics flushing' (Shakeel)
> - collected review & ack tags
> - added rstat overview to 'mm: memcontrol: switch to rstat' changelog (Michal)
> - simplified memcg_flush_lruvec_page_state() and removed cpu==-1 case (Michal)

The whole series looks good to me. Please feel free to route the rstat
patches with the rest of the series.

Thanks.

-- 
tejun
