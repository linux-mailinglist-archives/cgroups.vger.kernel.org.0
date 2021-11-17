Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B3D453D08
	for <lists+cgroups@lfdr.de>; Wed, 17 Nov 2021 01:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhKQAOX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Nov 2021 19:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhKQAOX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Nov 2021 19:14:23 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD35C061570;
        Tue, 16 Nov 2021 16:11:25 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id r11so2461423edd.9;
        Tue, 16 Nov 2021 16:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GlqmPq2VIk6eD8ey4VGJbqZUsRwxAJjaJSQyRKeBmc0=;
        b=gW7tY/rX+1sOa7ZeXu+Q32hSrCZTG9t3phjJUZxIzIzZpDUGPWDXsOJat6Xkj+cJQq
         Vy39DaWJm6fxLU7sNCjrBsHK63TyMcoG0HaSHUjV57sfDprKbmUI9fvYG77L/ectftAG
         iaTgu88O5l1wPgtL0vUdmUzU6a5Qnclso/L0pHltw4Tmy0bNRUhlTpEQgTEsRr1aycGE
         IhkVd+ne7ml6pAfWF+GeWUwFQPH2XxpTMIOLdSWfjqroGUwufi7G5a0NNokXHIPljObS
         ae44pjDPEZKG4KZL8VzKunquzq1x/kWwkuMNAYU2gnVRdYdEG/tJwf4FUNrfcMq/Ebur
         SCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GlqmPq2VIk6eD8ey4VGJbqZUsRwxAJjaJSQyRKeBmc0=;
        b=8DXfo8GhSzd23pL4LoFE+lBtmIvMUm+1xsj1clQp4JcsEEj3T8A90zd0Lv0bgsitXZ
         g0QOeeMdGbx7ziO8qUOa00mhs2rPcN8+5feko9wyAky1JgnXFuBwdU0FvKzR8NXyDBUr
         ta9Lrps8qWvu2rWGwFGj53e4pLew7lRBvl4GTdssz1/gDpXNnggVxjx7aScqheaxmSpX
         KHJgCJ9nplohtlgUmJZC20wfhD5QK+shosgvTrDjAF3hF6+WziM6H3aGgmP8afSCw32+
         qx2LXZ6vzYQmlIgTh1GthDKFL4m3AjY8eLfCPazc4m3n09RxAOtAn5BMGnzydZ6FJagk
         Aijw==
X-Gm-Message-State: AOAM532EoZhEOMXjXHo3o7OO73Extg42HC+PdYNLtwwa5neLxWO307Le
        Gm4czrpFGWaJTNpi9vfK5ZNBiSI0RLk=
X-Google-Smtp-Source: ABdhPJzx2buasGj4DgLtZhQHUL0aZqm+077gjbL2NyOQmQ9aDNmU1eR3AWVng/9XeopUQZwOPiNNkA==
X-Received: by 2002:a17:907:96a6:: with SMTP id hd38mr15333049ejc.47.1637107883873;
        Tue, 16 Nov 2021 16:11:23 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id hc10sm9257466ejc.99.2021.11.16.16.11.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Nov 2021 16:11:23 -0800 (PST)
Date:   Wed, 17 Nov 2021 00:11:22 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Michal Koutn? <mkoutny@suse.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] cgroup: pretty format /proc/cgroups
Message-ID: <20211117001122.az2wy3342yd7gkym@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20211115011253.20778-1-richard.weiyang@gmail.com>
 <20211116180013.GA8884@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116180013.GA8884@blackbody.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 16, 2021 at 07:00:17PM +0100, Michal Koutn? wrote:
>Hello.
>
>On Mon, Nov 15, 2021 at 01:12:53AM +0000, Wei Yang <richard.weiyang@gmail.com> wrote:
>> Let's align the title and value. After this patch, it looks like this.
>
>For machines this change may come as a surprise (so better not change
>it).
>
>For humans (for instance column from util-linux)
>
>$ column -t /proc/cgroups
>#subsys_name  hierarchy  num_cgroups  enabled
>cpuset        11         2            1
>cpu           4          9            1
>cpuacct       4          9            1
>...
>

This is helpful, thanks.

>Michal

-- 
Wei Yang
Help you, Help me
