Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6D533CA7D
	for <lists+cgroups@lfdr.de>; Tue, 16 Mar 2021 01:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbhCPAwb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Mar 2021 20:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbhCPAwa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Mar 2021 20:52:30 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C01C06174A;
        Mon, 15 Mar 2021 17:52:29 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id o3so3018231pfh.11;
        Mon, 15 Mar 2021 17:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xZoZuWb2tBzrGLpbmU0QlJ3nLJM79Q95ZotWRYdo/dU=;
        b=udPVwzShPfqLnJku3Fi+dpSMekaBCR/1LK2aWf1PcUDLZZrudJibDmi0qfrv/bqFQi
         2H93ctwVoCfgOr2SN8hWgsDeHQvcBvP8XiGlBtPsy1YjVOKrLNSDioU8RZp8zwqXc3A6
         oJI2UWvwmwVvKThzHVEDxhD1X5nOp/VOJj4PbXs+hR49oilZocWDgVy25YKK8EOHXYdm
         qYcsl+P22j8n75mkw0RH4x+LoJ8q9WWI19/8ttIpLAb5Tp5h50c6BXldIRsMApX7ghT4
         eTArYFObAgWoCrP6O+yFbQ/MxkIiKeK6kzPC9Og6q+TOirm7W6j9lHvVgDGzbYPmZY3q
         8c5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xZoZuWb2tBzrGLpbmU0QlJ3nLJM79Q95ZotWRYdo/dU=;
        b=JeikaMJHsgccufQd+KwsVzgCKNDx18kzGUW+c/CrDecwCCZ4Km78qjmoMck8hpUDyO
         jNCi9RgaJ6NPM3QsPSq3vorycY3Wam5BRGTeafANy8YC11sSJVoilFq9uYmlurgz1YAN
         R8RpYCKrj+l4VzrK1+8vaOv+8W/otCUJX+z3kMiRAp7UZ2rb6Zb3UOFi8AhqpQUyvttW
         xIuZRMWjEh8yBWKkwIf/rT0KE4JhEfGH+jBbV4OSD+Yyjg0u6eTt+dJ/96N6Ixa4SZ9T
         /KiU6LG8b9v+ezrveVPKyGWJVJKtZCVGfSpX1jD+g/TueH1HnJTXGGWXExmmdy2aTAR+
         g2Vw==
X-Gm-Message-State: AOAM533uzKO1zw7Fkb9x3mtMQt5+A85y2qraBb1cihclsdO/1ZntwIWm
        YfZ/6zckNtOkIdYv8UUIuH5lWbvuZt4=
X-Google-Smtp-Source: ABdhPJxtgToEh90OsCzFZ8X/0t8eT0FJAw1LQkF78w9cJu/2scgskfJvfnWyygm0lV6xkfQGigLdTA==
X-Received: by 2002:a63:1026:: with SMTP id f38mr1582605pgl.142.1615855949298;
        Mon, 15 Mar 2021 17:52:29 -0700 (PDT)
Received: from f8ffc2228008.ant.amazon.com ([54.240.193.129])
        by smtp.gmail.com with ESMTPSA id gz12sm759496pjb.33.2021.03.15.17.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 17:52:28 -0700 (PDT)
Subject: Re: [PATCH] mm: memcontrol: switch to rstat fix
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
References: <20210315234100.64307-1-hannes@cmpxchg.org>
From:   "Singh, Balbir" <bsingharora@gmail.com>
Message-ID: <494a5169-7e18-804b-3975-3a6442aff601@gmail.com>
Date:   Tue, 16 Mar 2021 11:52:22 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210315234100.64307-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 16/3/21 10:41 am, Johannes Weiner wrote:
> Fix a sleep in atomic section problem: wb_writeback() takes a spinlock
> and calls wb_over_bg_thresh() -> mem_cgroup_wb_stats, but the regular
> rstat flushing function called from in there does lockbreaking and may
> sleep. Switch to the atomic variant, cgroup_rstat_irqsafe().
> 
> To be consistent with other memcg flush calls, but without adding
> another memcg wrapper, inline and drop memcg_flush_vmstats() instead.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---

The patch make sense, but it does break any notion of abstraction we had
about controllers have some independence in their strategy to maintain
their own counters and stats. It now couples writeback with rstat instead
of just memcg.

Acked-by: Balbir Singh <bsingharora@gmail.com>
