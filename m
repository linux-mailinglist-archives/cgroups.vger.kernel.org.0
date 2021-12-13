Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E934734EF
	for <lists+cgroups@lfdr.de>; Mon, 13 Dec 2021 20:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbhLMT1P (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Dec 2021 14:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbhLMT1P (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Dec 2021 14:27:15 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C87C061574;
        Mon, 13 Dec 2021 11:27:14 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id k6-20020a17090a7f0600b001ad9d73b20bso14178995pjl.3;
        Mon, 13 Dec 2021 11:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tkb2nbDXtPOec8/Noy7yyiSFcbbuYZLt8x46YEAcE80=;
        b=qV/ClPQ9N3qauD6jekXldd4W9yCBqK/X09z27WBFoOIoGL3y7aQY2otAcLaPExw6+W
         hzPGJEPsRfeCOyY8KOojTKQ7XFWtpt/y2AoPMz5VxeMu4kP9GI744HwWfKs5xquGzTGk
         MWWsDsKPuGHVKk+lPj/GpgWdqQmVUmmhUWLIdcVSlNu5t8sTyw9oZzZH9PpS1auaSGr1
         n8UnuAt+TlLznUb+wO6AKAcS7s3ym6qRhcezGwwBtxj1R8zS6P6Xlbo0/Pgpq4V2xsSW
         NBL6nh70Vq0w4+YAw2bQHODDk8WDv/ZeX1x9VD1xbU4Ypx4Ri2r0VlY++xA9PgxM9UJB
         Hudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Tkb2nbDXtPOec8/Noy7yyiSFcbbuYZLt8x46YEAcE80=;
        b=jxqzG54BGVFA7zbF9iWR96wx1T+gl0XQM3+ahI772mg0CLgDKtc/ReemywwiQmmRdQ
         kS+txGxAgC+puS5R6AIBcGpGebNXt9za079ahnf2bJ5sY7oFBY2j6+HP27Yaw0K3sEfM
         QeX81/PS9jRgOyvR9q+X305HqGEJZJZJunX3OjpaYoOo4Xq/bLH+chNkEGqZQJzgdSXu
         6gIMhw5wOUN42mPue6OVlyOBYQbhDBfXAjA5Sc095JAnQewfdhpfN053mSan956/oef4
         HnctGRMHGqhTWmIh6MOwd0P1ZiJTtz5xxEITgVo4pYpT317YcRVfviXpkSflXbanATHm
         0U5A==
X-Gm-Message-State: AOAM532Yrkrqkf7SLc45eFxMYBgxRS9XK/ThryvPnGgk+zNpgKbmD+MZ
        p+411bHoSLpQzRlJ8/nN3LA=
X-Google-Smtp-Source: ABdhPJyoOVbeVmFZgOAB58FAnoLMNtwzPqBVNH9X+tpor56yuy+9+9y0WnnfsBQOMh1EhXQHRQLefQ==
X-Received: by 2002:a17:902:8302:b0:143:6e5f:a4a0 with SMTP id bd2-20020a170902830200b001436e5fa4a0mr484495plb.20.1639423634330;
        Mon, 13 Dec 2021 11:27:14 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id i10sm7811154pjd.3.2021.12.13.11.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 11:27:13 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 13 Dec 2021 09:27:12 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: return early if it is already on preloaded list
Message-ID: <YbeekNeegXoP6F93@slm.duckdns.org>
References: <20211211161729.10581-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211211161729.10581-1-richard.weiyang@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Dec 11, 2021 at 04:17:29PM +0000, Wei Yang wrote:
> If it is already on preloaded list, this means we have already setup
> this cset properly for migration.
> 
> Let's skip this cset on this condition.

The patch looks fine but I think description can be improved. Can you just
say that it's just relocating the root cgrp lookup which isn't used anyway
when the cset is already on the preloaded list?

Thanks.

-- 
tejun
