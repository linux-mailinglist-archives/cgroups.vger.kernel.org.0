Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96DF735DD78
	for <lists+cgroups@lfdr.de>; Tue, 13 Apr 2021 13:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhDMLLK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Apr 2021 07:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhDMLLG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Apr 2021 07:11:06 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B17BC061574;
        Tue, 13 Apr 2021 04:10:47 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id q189so6933385qka.8;
        Tue, 13 Apr 2021 04:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OYmW1UnxxT4rnJ2/1wILvNuSFEnTONzHbfLCHY3gbcc=;
        b=q1ERVVWAx8ubOeUPgRemTV8yO1ywDCn6T6+7Fpn0bEZLD/ykqlxQa4cx5qhKoLFWah
         9jEY39DodaVFGzguLL6/qtozNbo0KhNSiAzuofUrRZdUoTEHN0MRBxc+1b07Fsq8Atf7
         Bx7V1si+Tv0Z7WPHcxv64OOElRaYVNjapC0p2hFSYerXzPcOm/bkiW+kqa8LOQR43wqp
         MZa7lCiDECwiedicR8vDlu5bv/9M/4/dAR6m0Ww/bGGzSw2hEKw7K7pKszV+ToyAmGzL
         QgEbkKpswzBAQxAJDbnPpBXl2fQnNq5nwV19Y/CURlwAvu6l2pmR/Sau81u+5vqd5N1v
         sMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OYmW1UnxxT4rnJ2/1wILvNuSFEnTONzHbfLCHY3gbcc=;
        b=UERrNXvyZVG5EdYvh6r3/Qas9CRYSJldqNHXDgaf43gVR3PxEEghB6MkjwhPi/PZ3U
         Z0IKBJ8GNbASjM51GhZFjWHs/fFoA0gtVpBcV/kYu0jFwXCFzyEqKo2rgZVNemdz7lLy
         FtDTLpWi2bEQn+r6lUigI3qqC0i1qzu4So6iOu+/uacYKm5u+5RHgOFLo/i1S1VRucy+
         wsISbBGd/cXeYAobprBWHaHh/oZLxYbv0+BXp34kEPQcJL4zp4eZ4NYhPX4xgQJlZONJ
         FYDTqQ8NkeYUjk6CS6awCD1VrP6Jq1KbhppQ691PqlbbURVqlx64vP47b1xA31JdBL4P
         jIOg==
X-Gm-Message-State: AOAM530GQlqP4UKrJznyb3nD4B5b8ybEZgIY4T+e9yLZoPSWh53tSl/z
        koqvkQVdQ5RluXYC/F/jwM0=
X-Google-Smtp-Source: ABdhPJxu7+yZw6bHJMJFvSl+K9081V0Oowi4TJZ8e4CVVlGiX7vdVfdTHbF2G84NCSlVJ0LfjquoIw==
X-Received: by 2002:a37:71c3:: with SMTP id m186mr24873153qkc.453.1618312246533;
        Tue, 13 Apr 2021 04:10:46 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id p185sm1861834qke.10.2021.04.13.04.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 04:10:45 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 13 Apr 2021 07:10:44 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Odin Ugedal <odin@uged.al>
Cc:     lizefan.x@bytedance.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Relax cpuset validation for cgroup v2
Message-ID: <YHV8NGTQ480UM+Yh@slm.duckdns.org>
References: <20210413090235.1903026-1-odin@uged.al>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413090235.1903026-1-odin@uged.al>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 13, 2021 at 11:02:33AM +0200, Odin Ugedal wrote:
> Two small validation relaxations for cgroup v2, making it easier to
> manage the hierarchy without the current pain points. Both changes
> work for both mems and cpus (but I have no NUMA machine to test mems).
> 
> Hopefully the patches has an ok description about what change they
> provide, and why they are helpful.

I'm generally in favor of removing configuration constraints but let's hear
what Li thinks.

Thanks.

-- 
tejun
