Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 906CD1192C1
	for <lists+cgroups@lfdr.de>; Tue, 10 Dec 2019 22:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfLJVEH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Dec 2019 16:04:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40800 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfLJVEH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Dec 2019 16:04:07 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so21686630wrn.7
        for <cgroups@vger.kernel.org>; Tue, 10 Dec 2019 13:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t5wRb0HVinMm6EfDaWAnO/a1Sj3+z3DX/7PLYloGfXc=;
        b=OjVkow0SpbjcoF1OWjpltk1vI3YxAw2jQt8Cq6d1x/Btjj1F3u4QeDCqIVyZYELWWn
         lXo4Q8crVZNDfrrurZiFUJUCwelB3pjClmCwC1fxlalGIcZiAwo5pMgLil3e2tONS9X5
         v7g3C9cMkECg6NxNdXCychqgWcQNo1wWAF9mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t5wRb0HVinMm6EfDaWAnO/a1Sj3+z3DX/7PLYloGfXc=;
        b=opNdkVXVx3NRnwx9Xe0B5TEXMZvd3Rsuu6r44n0vZMTTF36tLEhE6nqEmt4uWNT+aS
         UylfSRmRYbg1PvuX4zVtL3xgcM3/F8KdPiflzkQrKM5LoEVFNvAOBHHX7cItT6TSE+4z
         roMk/+aI0dV6x9JqTCxs4n1GrIUwKQC8aHPu/dkFmLQZL84sf3nrnJlCvxxyrGavfE2Y
         foRC3ezGw9tfPozIyftIcaaqykTWg9qDJn6sE4G1WzOk3KuMu/1Xmtr5e4MaHdLoxy88
         WxDyzu9PLKcSr5wJlyzqh1uZNlF4zWSSp9h55Unx8HdItWGa/G0tCTMv/uFWbSnCZcIP
         WotA==
X-Gm-Message-State: APjAAAW4e4YKcXmxL7unWKWaGXY7nPQcJyi4kwhAn2boj/lIL2lpc/K+
        1Dnfh545IBlnDejbqHCrRgMjMQ==
X-Google-Smtp-Source: APXvYqy79TBCNpPOmBCd880DGqLHwk7LRohDsnP9Y0U3hQ0Ejrk0NnEgnxTg3iGWHnZTuaLKKdJiTQ==
X-Received: by 2002:a5d:50d2:: with SMTP id f18mr5456797wrt.366.1576011844881;
        Tue, 10 Dec 2019 13:04:04 -0800 (PST)
Received: from localhost ([89.32.122.5])
        by smtp.gmail.com with ESMTPSA id p10sm4422433wmi.15.2019.12.10.13.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 13:04:04 -0800 (PST)
Date:   Tue, 10 Dec 2019 21:04:03 +0000
From:   Chris Down <chris@chrisdown.name>
To:     chengkaitao <pilgrimtao@gmail.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        smuchun@gmail.com, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2] mm: cleanup some useless code
Message-ID: <20191210210403.GA455280@chrisdown.name>
References: <20191210160450.3395-1-pilgrimtao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191210160450.3395-1-pilgrimtao@gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

chengkaitao writes:
>Subject: Re: [PATCH v2] mm: cleanup some useless code

Can you please write a more descriptive commit title? Seeing this in the commit 
history tells the reader nothing, "code" could mean anything from a state 
machine to a boolean, and "cleanup" could mean anything from some complex 
refactoring to something trivial like this, and right now I have to look and 
see the individual commit. This patch is really just deduplication of effort.

Perhaps:

     mm, memcg: Don't check PageTransHuge before calling hpage_nr_pages

>It is much simpler to just use hpage_nr_pages for nr_pages and replace
>the local variable by PageTransHuge check directly

Heh, calling it "much" simpler seems a bit excessive. I mean, the code is just 
as readable in both cases, but if it's going to go in, then that's fine. Any 
merge conflict should be trivial enough to fix.

>Signed-off-by: Kaitao Cheng <pilgrimtao@gmail.com>
>Acked-by: Michal Hocko <mhocko@suse.com>

I'm indifferent to this patch, but after the title change:

Acked-by: Chris Down <chris@chrisdown.name>
