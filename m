Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBA1217A233
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2020 10:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgCEJYx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Mar 2020 04:24:53 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37089 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgCEJYx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Mar 2020 04:24:53 -0500
Received: by mail-wr1-f66.google.com with SMTP id 6so633019wre.4;
        Thu, 05 Mar 2020 01:24:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9vQe482RUcHrdGZKLAu+qnIPkFKqJ2yT+5bmZriPGCE=;
        b=lQzxOf8yOWc6PG9MHj5wgW8Dic/cZzPKOLWDZU8i0OI13222+2yL5cH5K9uMz5XLrN
         eOrcj9uNZ2AG7CDKV8RU6aZVgdloNQ63iyD5bkqT+w/Mv3LCrvWBbULbFf0zNu2AiVNz
         afGdjrIokl4jpG0eJ/4CJyZcNHuIfiVqq+zbf5/W2XSc4KD8gy2hsyvRrgM+kJo9/zTs
         RFeaGo5WuFzfmHdRsMcPIhDmb7FTXxNgug/36LpCGUUZxblKG2zU6I51EMnV0MrYNk0A
         IeDHqFTbDFEXqYysLsZglmWgiZGRblhG0N3efdVT4qIH4dMVgga71o79rw0oWC4jU7g4
         TPvg==
X-Gm-Message-State: ANhLgQ1Q8mpT+trJIASFK1YyTaiQHELJCQC5zYYweJs/6k7HNn7Nk9he
        tkjJzcqdUkWV56OVPs1t2JEaxkOY
X-Google-Smtp-Source: ADFU+vvqdBUB33jqLEFP4NDcqKysj/IfEmhB8jpmFa+xqd50R/xS6n1SmUdsZTIOV3TA19m3kIXQZQ==
X-Received: by 2002:a5d:54ce:: with SMTP id x14mr8898569wrv.353.1583400289434;
        Thu, 05 Mar 2020 01:24:49 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id w16sm9863676wrp.8.2020.03.05.01.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 01:24:48 -0800 (PST)
Date:   Thu, 5 Mar 2020 10:24:47 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: fix NULL pointer dereference in
 __mem_cgroup_usage_unregister_event
Message-ID: <20200305092447.GQ16139@dhcp22.suse.cz>
References: <5ee35fe7-2a90-ae71-9100-3f2833cbf252@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ee35fe7-2a90-ae71-9100-3f2833cbf252@gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Thank you for the report!

On Thu 05-03-20 13:52:03, brookxu wrote:
> One eventfd monitors multiple memory thresholds of cgroup, closing it, the
> system will delete related events. Before all events are deleted, another
> eventfd monitors the cgroup's memory threshold.

Could you describe the race scenario please? Ideally 
> 
> As a result, thresholds->primary[] is not empty, but thresholds->sparse[]
> is NULL, __mem_cgroup_usage_unregister_event() leading to a crash:
> 
> [  138.925809] BUG: unable to handle kernel NULL pointer dereference at 0000000000000004
> [  138.926817] IP: [<ffffffff8116c9b7>] mem_cgroup_usage_unregister_event+0xd7/0x1f0
> [  138.927701] PGD 73bce067 PUD 76ff3067 PMD 0
> [  138.928384] Oops: 0002 [#1] SMP
> [  138.935218] CPU: 1 PID: 14 Comm: kworker/1:0 Not tainted 3.10.107-1-tlinux2-0047 #1

Also you seem to be running a very old kernel. Does the problem exist in
the current Vanilla kernel?
-- 
Michal Hocko
SUSE Labs
