Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE9C7FCEAE
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2019 20:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfKNTVV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Nov 2019 14:21:21 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41314 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfKNTVV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Nov 2019 14:21:21 -0500
Received: by mail-qt1-f195.google.com with SMTP id o3so8030927qtj.8;
        Thu, 14 Nov 2019 11:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V8JOYrhFKJZsjLpy3zbICgm56f832zoaBb4LCM6R/wE=;
        b=SSPWq/TOhRhkWt64BoCNntBWMb/TucJ3AIdHYBXY2nyWahkTra09hFT8GSEsnolfnM
         xD4C/j9iKWF72fTVou2+nt+/RsWRC+pDpOOaOTEmLX/TiN06RAsPWbN1SGpX2IGMDH+A
         5WlVvsj2+2L0ufhWln/MYkO13Ie8z2hOaGr6N6H1Sw3QVcIaSwEbn/pxeaKEc8NZMTIq
         5xmtxuj3Rk2WBNAhicO9mPb+pg7s8lub70oiaCN0Kwe6rdb92t+SjQvGsMiyB2THTDrc
         uSN/dNw4lQuOeskHze8uTQtjD5stAKCzHc0EPVaiszH2k3oZ1IH0C37Lguc88/qZe+wV
         R6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=V8JOYrhFKJZsjLpy3zbICgm56f832zoaBb4LCM6R/wE=;
        b=Rf+4J2z7DIg7bnJI7n2umYXkPS/m3ckbAAqnfXPqEfGGgZtf/c+dGOFEDPBYU2Z1nh
         mYNpMFZM79J8qq2sh6YrwIlKI7UgnotTGCT9pyUMBfXB2Fs3aFAPlXYIRnMUFQWdmIg7
         ijC1gh7hu6wSRELHUMU0VsiYsPOdMxCl7ebJfE8XblqDrjf+QWppYrx5/tHxxKyhogvI
         xQVOXQyFwHJ0FtZIAAobBIkMjglzCleDh2yT6g9fhPqdJKg0McVWtJ0IUwjO0CyjlHga
         gmkeSm+UioIAiwtwMWv/yW59v2lnJua175GddHLBNqqDUT57fCq6IN+H5fQou7jaKh89
         tfug==
X-Gm-Message-State: APjAAAVJMJhUOhErReQLjuYdGHkVc1YkbMEHlKT2xzxWEZxlJhXaN84q
        B0siGNxRUNemq3rF0t+j85ZxxumK
X-Google-Smtp-Source: APXvYqxVA9c1jZyC24DjlRcVync5U+FaGqLYy/aPEeYMXGzICKoGfSyzC9htmCREvDbO5rhSKYBOgQ==
X-Received: by 2002:ac8:698d:: with SMTP id o13mr9863131qtq.68.1573759280316;
        Thu, 14 Nov 2019 11:21:20 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:69f2])
        by smtp.gmail.com with ESMTPSA id 130sm3062273qkd.33.2019.11.14.11.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 11:21:19 -0800 (PST)
Date:   Thu, 14 Nov 2019 11:21:18 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     jack@suse.cz, gregkh@linuxfoundation.org, cgroups@vger.kernel.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, linux-s390@vger.kernel.org,
        axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] writeback: fix -Wformat compilation warnings
Message-ID: <20191114192118.GK4163745@devbig004.ftw2.facebook.com>
References: <1573751861-10303-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573751861-10303-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Nov 14, 2019 at 12:17:41PM -0500, Qian Cai wrote:
> The commit f05499a06fb4 ("writeback: use ino_t for inodes in
> tracepoints") introduced a lot of GCC compilation warnings on s390,
> 
> In file included from ./include/trace/define_trace.h:102,
>                  from ./include/trace/events/writeback.h:904,
>                  from fs/fs-writeback.c:82:
> ./include/trace/events/writeback.h: In function
> 'trace_raw_output_writeback_page_template':
> ./include/trace/events/writeback.h:76:12: warning: format '%lu' expects
> argument of type 'long unsigned int', but argument 4 has type 'ino_t'
> {aka 'unsigned int'} [-Wformat=]
>   TP_printk("bdi %s: ino=%lu index=%lu",
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/trace/trace_events.h:360:22: note: in definition of macro
> 'DECLARE_EVENT_CLASS'
>   trace_seq_printf(s, print);     \
>                       ^~~~~
> ./include/trace/events/writeback.h:76:2: note: in expansion of macro
> 'TP_printk'
>   TP_printk("bdi %s: ino=%lu index=%lu",
>   ^~~~~~~~~
> 
> Fix them by adding necessary casts where ino_t could be either "unsigned
> int" or "unsigned long".
> 
> Fixes: f05499a06fb4 ("writeback: use ino_t for inodes in tracepoints")
> Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
