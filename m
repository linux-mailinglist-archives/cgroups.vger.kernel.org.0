Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC29212A84E
	for <lists+cgroups@lfdr.de>; Wed, 25 Dec 2019 15:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfLYOFv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Dec 2019 09:05:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46797 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfLYOFu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Dec 2019 09:05:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so21773954wrl.13
        for <cgroups@vger.kernel.org>; Wed, 25 Dec 2019 06:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PaDmMxkiRy/WmC12erbAUHsnmEtdYs1r3ps1zkcgWAw=;
        b=dj9kUX7cO9CfQ0vYnu5g3KXmO6JhCagGhOV4IqNaW87UuclAEzzGxEeHbcInmbtxqV
         OTO0VWnbb+87Kf8YZB5UqxkkEHoCB1F/RLgqzLcQJiMEBmz9yznlTFDsFGo9tW626Hnj
         O3+BJexc5zq7YN4nzlzC/8FHKHufQKUeyGKzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PaDmMxkiRy/WmC12erbAUHsnmEtdYs1r3ps1zkcgWAw=;
        b=ibb3RfI8fEbzH3iprdNT/WxwZ2DgkM7eYLScJIybzbK4w/VwN3jLwTBv0jXVVk2TKZ
         n5jCyzCax155eZkyp1rxbIBJL0L8NO2RmC1DB28NI/JkfHd0BAQG/wgE3ceqqMatR3Nj
         JOftzPRHItMKGMW6LZ+1SLE0gpkZG4onhtgUmHIW31fUbAtPG4hdfZqPzmoxZyXmRLRa
         hTzU1cdqx79IZU7OItm9I0e1A0NDV0d/xUoeOpMrEu1pPRO9MGUYQmgmd6+l1XMJl7of
         a2mUCBXrFaZe9egwdmtNcTj1YfiSRnZXwuz7lU5u3atZ4sd5MGvrD8OyZgp7UTWTc1yq
         lqyQ==
X-Gm-Message-State: APjAAAX4uby+bk3h8NE3BnYjjZ6mvHdjb0l4j5adW+jcS2pnrn+/78iv
        m8sBMcls8szg+pyt7RIFrfkPBA==
X-Google-Smtp-Source: APXvYqz5NZ/Z9pXVDdxcMgmQvd60J/zQ3ZAGiDufUZ/QmKwuXQsKbS8TnZLdl3bs9e8BAZqJmF/8dg==
X-Received: by 2002:a5d:538e:: with SMTP id d14mr41544340wrv.358.1577282748332;
        Wed, 25 Dec 2019 06:05:48 -0800 (PST)
Received: from localhost (host-92-23-123-10.as13285.net. [92.23.123.10])
        by smtp.gmail.com with ESMTPSA id u22sm28958411wru.30.2019.12.25.06.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Dec 2019 06:05:47 -0800 (PST)
Date:   Wed, 25 Dec 2019 14:05:46 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Hui Zhu <teawater@gmail.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Hui Zhu <teawaterz@linux.alibaba.com>
Subject: Re: [RFC] memcg: Add swappiness to cgroup2
Message-ID: <20191225140546.GA311630@chrisdown.name>
References: <1577252208-32419-1-git-send-email-teawater@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1577252208-32419-1-git-send-email-teawater@gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Hui,

Hui Zhu writes:
>Even if cgroup2 has swap.max, swappiness is still a very useful config.
>This commit add swappiness to cgroup2.

When submitting patches like this, it's important to explain *why* you want it 
and what evidence there is. For example, how should one use this to compose a 
reasonable system? Why aren't existing protection controls sufficient for your 
use case? Where's the data?

Also, why would swappiness be something cgroup-specific instead of 
hardware-specific, when desired swappiness is really largely about the hardware 
you have in your system?

I struggle to think of situations where per-cgroup swappiness would be useful, 
since it's really not a workload-specific setting.

Thanks,

Chris

>Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
>---
> mm/memcontrol.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>index c5b5f74..e966396 100644
>--- a/mm/memcontrol.c
>+++ b/mm/memcontrol.c
>@@ -7143,6 +7143,11 @@ static struct cftype swap_files[] = {
> 		.file_offset = offsetof(struct mem_cgroup, swap_events_file),
> 		.seq_show = swap_events_show,
> 	},
>+	{
>+		.name = "swappiness",
>+		.read_u64 = mem_cgroup_swappiness_read,
>+		.write_u64 = mem_cgroup_swappiness_write,
>+	},
> 	{ }	/* terminate */
> };
>
>-- 
>2.7.4
>
>
