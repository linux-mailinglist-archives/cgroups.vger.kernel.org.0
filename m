Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A4148BBCE
	for <lists+cgroups@lfdr.de>; Wed, 12 Jan 2022 01:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344066AbiALAZy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jan 2022 19:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236650AbiALAZy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jan 2022 19:25:54 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10206C06173F;
        Tue, 11 Jan 2022 16:25:54 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id k15so2933147edk.13;
        Tue, 11 Jan 2022 16:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MBSCVEXhAMvxGQvNiGRyMSUYqls1w/ZtyRRzB2dpPmI=;
        b=QI+s8v0B1JsKNZCuCjjyuOlaCkg7jITbixgszmCrLpMZfPFYpHcAX1zqszo8unsiV1
         jsXZXHhaNIzmLJ+roOqKNxX9oQd7UZWzN866zq13FqgZilLSTkSBnUEqo73zTKiEjRq/
         CnJobd7MTSnyH8IU9TEWr9ISjl5BvrRRYYjXIqXt7qqpLBGrbQZOtcq4IhaJ5GaKu/5k
         J2ps1fNM5z+9O3Q95GSfTF4OJbsUEa8X4bFjF8s5n4xExrLJPbnuPLwqlax+TzaxKY1d
         6mmOOny0tBQfGXQv9bn8dajnX2FKEuJ8kTbmbN09UEcwk9DHm8SFfRfEgLQbICUGbL5Q
         GtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MBSCVEXhAMvxGQvNiGRyMSUYqls1w/ZtyRRzB2dpPmI=;
        b=YA0hWBhX80nRIL3DDIQaqOndCZg10aUZsNWmJCqeljfXsR5RIkGaDsGkm1PpK7V0c2
         FJEmLGj8BWO44/UAonBiG0oRHl0TtsSVp/YjX+DRliQh0FbHXLoT7Lpx0ESDwK8W+J4c
         7rxCpOSokmdNrfPBG/O/Z6qolxQY1MvsPs9FO4tiO3lr4P5vc7/7lKPQAGFr+Y2pFTlZ
         t7UDtpCmeSIav+8OPV6irgJTTGrIsQkAOQ8aAzUnSuqH/AXI3Mq9MfwmgOOhMP9iPa8T
         ULev6QHQVcBJbMTG0Pq6rOhah1EElBhKI/S6qievHH1vVqS3Xmm+oujh3pQ8fJ+cjN07
         wy7w==
X-Gm-Message-State: AOAM532l72TrwRq1mNn3iUo6Nn6jB/MW8mcqzQuCzrOp/W3LXgyAbAcT
        8JJ9bDXctPLJY+gdodeNXoA=
X-Google-Smtp-Source: ABdhPJzdLpSS1YpaJUsL8RlI3c1NNGcmdwOWn04iBHPvItNbG4K6mk53eeTC900OYuWUEnENJusF7Q==
X-Received: by 2002:a17:906:69cc:: with SMTP id g12mr1090415ejs.372.1641947152680;
        Tue, 11 Jan 2022 16:25:52 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id j5sm4026441ejo.171.2022.01.11.16.25.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Jan 2022 16:25:52 -0800 (PST)
Date:   Wed, 12 Jan 2022 00:25:51 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, vbabka@suse.cz,
        willy@infradead.org, songmuchun@bytedance.com, shy828301@gmail.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 4/4] mm/memcg: refine
 mem_cgroup_threshold_ary->current_threshold calculation
Message-ID: <20220112002551.sksmoril2nwuddtu@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220111010302.8864-1-richard.weiyang@gmail.com>
 <20220111010302.8864-4-richard.weiyang@gmail.com>
 <Yd3LLalWzPy17PmR@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd3LLalWzPy17PmR@carbon.dhcp.thefacebook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 11, 2022 at 10:23:41AM -0800, Roman Gushchin wrote:
>On Tue, Jan 11, 2022 at 01:03:02AM +0000, Wei Yang wrote:
>> mem_cgroup_threshold_ary->current_threshold points to the last entry
>> who's threshold is less or equal to usage.
>> 
>> Instead of iterating entries to get the correct index, we can leverage
>> primary->current_threshold to get it. If the threshold added is less or
>> equal to usage, current_threshold should increase by one. Otherwise, it
>> doesn't change.
>
>How big is usually an array of thresholds? If it's not huge, likely
>any savings won't be really noticeable (it's not a hot path and there
>is an rc_synchronize() below).

Usually the size is small I think.

>
>So I agree with Michal that a better justification is really needed.

Yep.

>
>Thanks!

-- 
Wei Yang
Help you, Help me
