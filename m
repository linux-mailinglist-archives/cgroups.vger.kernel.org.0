Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 766C5F331B
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2019 16:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbfKGPbO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Nov 2019 10:31:14 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:45481 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbfKGPbO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Nov 2019 10:31:14 -0500
Received: by mail-qk1-f169.google.com with SMTP id q70so2290808qke.12;
        Thu, 07 Nov 2019 07:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OYN7vTt8Jizl5Ja6H+vm2wVj9xnVEWWh3pARe128MqA=;
        b=iPfpPMToSIjqAEneusgPnKkHTUg6LPqBJlhPxItj8EG/jn2j67b6Kk1F9579naxQcw
         oX203Nuq/Gsb0gE9fnkb6QIjcBobHuQ9YpKKO58m9rSoZgyQ+g8xQ3YqDop5AyN5yLrU
         hBGDiUkEc+2jOdiXGLuiJ0sKZhTdhpVjy+GaPmV1fVClwsXDfoMk7GWDyRpgDR3oMRNX
         r6bObgN0SXCsPwtjRfyy4bwD48VmqrvZZvcuVO12iRfHGWbGGIJfPc3YkRe9JBzPFLal
         7vNl5PNwiXH7m48XSgJSSBG2nQiQksAd2VX561TBE2V3VWSTxmh7RckF4OHGgiL0NnbU
         Py/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OYN7vTt8Jizl5Ja6H+vm2wVj9xnVEWWh3pARe128MqA=;
        b=gFng8Jl4K8EMRGUJ6OkOy8SqM7HppvS/U5hoPzNm+d/moIKoClIotNIxV4VxRe+FfJ
         3W4Vb57Qx6LQT1ibxlYL+aGEAN/q6y+dIrCfFs8WMFWBzBNwR7cZTeVQflyKPJVjUfSC
         J+X67nmG3ArWsjXYWuVuyZYsN7V6ttDD/m/DxaDBD6CUpioPv3znG3iF6qGk0gJEWLfg
         mW5HYTz1ldHOKRo+UcFp0KkKRzV8kzmcowXuDSB9brE2pVgysa0wWM1i3ZyA/Kf6db1C
         c7ZPw0YlZnDIc8HEJ2nE5svtrLo+RWRMpHKWpXdMDeFCBqz5/LjUekvc4BBfWlw3X1Te
         5D+A==
X-Gm-Message-State: APjAAAVdz7ukOBi6SXEEOKG9oJY/FIZptSnkD1F5Vx6OQeJOMoKO/BDi
        ryo2UXFL/ilWXTNsZ603LEU=
X-Google-Smtp-Source: APXvYqwqn0bBOp2HO4hyDW24JdvRLQBv/0LKNGsgh+A9amK0LYtD5iDZKcbgEeJmAsAS5np50+aqFA==
X-Received: by 2002:a37:7f87:: with SMTP id a129mr3312707qkd.122.1573140673231;
        Thu, 07 Nov 2019 07:31:13 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:3f13])
        by smtp.gmail.com with ESMTPSA id 130sm1251974qkd.33.2019.11.07.07.31.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 07:31:12 -0800 (PST)
Date:   Thu, 7 Nov 2019 07:31:11 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@fb.com, linux-kernel <linux-kernel@vger.kernel.org>,
        cgroups@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCHSET cgroup/for-5.5] kernfs,cgroup: support 64bit inos and
 unify cgroup IDs
Message-ID: <20191107153111.GV3622521@devbig004.ftw2.facebook.com>
References: <20191104235944.3470866-1-tj@kernel.org>
 <CAM9d7cjXX8aYYjJdnb0SUjBYwhOTWiD+V9fagUVnW9FUS6C=5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjXX8aYYjJdnb0SUjBYwhOTWiD+V9fagUVnW9FUS6C=5g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 06, 2019 at 10:50:15PM +0900, Namhyung Kim wrote:
> Thanks a lot for doing this!  I've tested it with my perf cgroup patchset
> based on top of this series and it looks good.  You can add my
> 
> Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks for testing, sorry about the delay!

-- 
tejun
