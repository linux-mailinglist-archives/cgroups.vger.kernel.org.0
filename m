Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437C92FBD13
	for <lists+cgroups@lfdr.de>; Tue, 19 Jan 2021 18:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731493AbhASQ6S (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Jan 2021 11:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390982AbhASQ5O (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Jan 2021 11:57:14 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BFFC061574
        for <cgroups@vger.kernel.org>; Tue, 19 Jan 2021 08:56:21 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 22so22483851qkf.9
        for <cgroups@vger.kernel.org>; Tue, 19 Jan 2021 08:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sZTa1e704AQTw+PA3+InMjpu4zvF9XQf/ysLpHwUHcU=;
        b=R+13BIlUYlJXhmZNL640hNlcxlCK/mz4E7yBIiR4htjWXaoPhuig0r+qwQBLWUGBpn
         cCIgnGt9JsYOkwwOzJHQ6LVCfPP46U5UjUFiKz8OoSEBFzVdPvnszAO/xrZ2HxLmaZ4u
         m7rgmUL6+l9w3MXBvK8/FyuWlbRIp1HxP9nTh93Fryowg9RhjdDnQ+ATKo2iqlhbcuAz
         em8PW3JSYOgeeloQZXqsLJGnLGn8JuGhSFzyDGqZIvlhnVj1HFNTVwSVB6t9D3bdsrmp
         h6Spn8Duch3qGBAYlOLOLrYinfYFom1kHkna9i6qhL16UV3OuEhhZ3R/GEE/ufTB3Idv
         nbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sZTa1e704AQTw+PA3+InMjpu4zvF9XQf/ysLpHwUHcU=;
        b=nd2cTdV/g3YO5o/sn0mmocTVM6AoEKCcPlDj1VPtij/Bn+HEtw6OHFHhpnCI/bcISv
         9Sryaf7kazNEbs5Bnp8/Gpvp8Md4d18LTIliEauPzx7zmfPWLIyn/jH4s683Sn7Ke04w
         ThUcd8LMC9hjNVQa0awjyShFf+SIViEmESL1VKYSDxkhZt/MjXLpjMdhrNozHk3TRa1J
         +Qs5B8czL9KMdQ8z4k75MY/PKh6SACZ5GDVweBRGhAtBrUunudriqY7IrGeqlYn+iRYW
         jIm+qCXjphiXvCeVC81a8Dvx0d3pK13RrOY0T5ri6enB0PTng1LKcOMWIwBE0t7qzJT/
         0lgQ==
X-Gm-Message-State: AOAM533yRt3YP6eMHviFXGsShO3f53m4vpL2NNAjlOln/vVT46nSrWFg
        q2FoH6juFQrSe6dAzsBJC0U18g==
X-Google-Smtp-Source: ABdhPJwdnPCTti6ZVVa9sqSMEkTDfTsWgXUU+2lkFHHmjHVVYwrZFcLcm/MGXBxz3PP+q7nvTKmA5w==
X-Received: by 2002:a05:620a:4d1:: with SMTP id 17mr2178131qks.385.1611075380551;
        Tue, 19 Jan 2021 08:56:20 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id g3sm12986921qtc.3.2021.01.19.08.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 08:56:19 -0800 (PST)
Date:   Tue, 19 Jan 2021 11:56:18 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Odin Ugedal <odin@uged.al>
Cc:     tj@kernel.org, lizefan@huawei.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, dschatzberg@fb.com, surenb@google.com
Subject: Re: [PATCH v2 2/2] cgroup: update PSI file description in docs
Message-ID: <YAcPMlxXVSuKgbvn@cmpxchg.org>
References: <20210116173634.1615875-1-odin@uged.al>
 <20210116173634.1615875-3-odin@uged.al>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210116173634.1615875-3-odin@uged.al>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jan 16, 2021 at 06:36:34PM +0100, Odin Ugedal wrote:
> Update PSI file description in cgroup-v2 docs to reflect the current
> implementation.
> 
> Signed-off-by: Odin Ugedal <odin@uged.al>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 63521cd36ce5..f638c9d3d9f2 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1029,7 +1029,7 @@ All time durations are in microseconds.
>  	one number is written, $MAX is updated.
>  
>    cpu.pressure
> -	A read-only nested-key file which exists on non-root cgroups.
> +	A read-only nested-keyed file.

Could you please also change the 'read-only' to 'read-write'?

With that, please feel free to add:
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
