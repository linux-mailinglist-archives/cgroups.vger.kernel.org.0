Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56E7BF747F
	for <lists+cgroups@lfdr.de>; Mon, 11 Nov 2019 14:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKKNFX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Nov 2019 08:05:23 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:40617 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKNFW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Nov 2019 08:05:22 -0500
Received: by mail-wm1-f51.google.com with SMTP id f3so13111917wmc.5
        for <cgroups@vger.kernel.org>; Mon, 11 Nov 2019 05:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ptfgZiJrJRT37KV6qx/ANFTtjHXD6glvvm6dcn8VVZI=;
        b=BDGOjdrOiR/70UcRqMcVVH7VffzPCSZLLyoX5htmD99qQ65QbHEdi1A94TTEZKTGia
         bu4YKgChFJqm9P5eaC7FDAyXwIxRw7WczK/jDbRGD+k2jvtrx4tcCibk7Aa52STDdVIb
         iPIO1FJHqec/eDyz5qyxHqj3PBz5G2DEVuBfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ptfgZiJrJRT37KV6qx/ANFTtjHXD6glvvm6dcn8VVZI=;
        b=cqhDVo9Mq2iQ0Gq3/AkWdfTs5So4fsbiHVwWZJ+FJ5j6m5+2eRsnsvnKfEUjEHXnw3
         qk+QbU61OM3BFTxStTjF4swRckJckaHBsGvYQKq3+AvyKgAEpIXH21j472L+QSSoGHAC
         EFLchZ+iLVMffUjmzi+14rL+Wa9cFLlo3curQSdt4IKJ7E0/HWpmShxMTlJoqHBiSQN0
         qdLGFnm9mAeTVWnqfCI8iNXvH+Y/AOgia0T1Ng87R4yQfQTK02TGeD8zpWvbgcKx7SHD
         wX1utoZ5M6XihOsXUFgorHWnQWjMC3myvrQxWM82IkbXV8vo5DngWkBY3EmVV/W/C+j3
         zqkQ==
X-Gm-Message-State: APjAAAXc3SlS82wcGHv8kzQDmpT8ugH57Wp08edKLeah6mq5TGPf/tLG
        CLhAUbIanhCPhsaBMpHqEDPK2w==
X-Google-Smtp-Source: APXvYqymiSpQifawQQU3UdosjYX+3QNdQAwiUyDIgIP9zu5AyARgYX7U0WXOyuAEec5YlMqntyZ0Uw==
X-Received: by 2002:a1c:544e:: with SMTP id p14mr19557371wmi.17.1573477518329;
        Mon, 11 Nov 2019 05:05:18 -0800 (PST)
Received: from localhost ([2a01:4b00:8432:8a00:fa59:71ff:fe7e:8d21])
        by smtp.gmail.com with ESMTPSA id u26sm14397929wmj.9.2019.11.11.05.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 05:05:17 -0800 (PST)
Date:   Mon, 11 Nov 2019 13:05:16 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, hannes@cmpxchg.org,
        guro@fb.com, linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/vmscan: fix an undefined behavior for zone id
Message-ID: <20191111130516.GA891635@chrisdown.name>
References: <20191108204407.1435-1-cai@lca.pw>
 <64E60F6F-7582-427B-8DD5-EF97B1656F5A@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <64E60F6F-7582-427B-8DD5-EF97B1656F5A@lca.pw>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Qian Cai writes:
>> On Nov 8, 2019, at 3:44 PM, Qian Cai <cai@lca.pw> wrote:
>>
>> -    for (zid = 0; zid <= zone_idx; zid++) {
>> +    for (zid = 0; zid < zone_idx; zid++) {
>>        struct zone *zone =
>
>Oops, I think here needs to be,
>
>for (zid = 0; zid <= zone_idx && zid < MAX_NR_ZONES; zid++) {
>
>to deal with this MAX_NR_ZONES special case.

Ah, I just saw this in my local checkout and thought it was from my changes, 
until I saw it's also on clean mmots checkout. Thanks for the fixup!

Acked-by: Chris Down <chris@chrisdown.name>
