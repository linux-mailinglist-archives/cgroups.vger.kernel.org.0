Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7E4821501
	for <lists+cgroups@lfdr.de>; Fri, 17 May 2019 10:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfEQIAt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 May 2019 04:00:49 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43592 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbfEQIAs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 May 2019 04:00:48 -0400
Received: by mail-lf1-f66.google.com with SMTP id u27so4621854lfg.10;
        Fri, 17 May 2019 01:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E30ZwXceSLrrdqkhZETQJSrFB4D6w8xtvQQj0QSh1bk=;
        b=bdwPkfc51sJvmJvEEnbkjJeee5dDIVMrgrBcQbEWcuq3Gu7xg4Drx7Sxhgj0S7ifcX
         MHKOMyvUXD9qL1hCSXPCieoxHNgARijo9pvrnOH2EzfYZqXH5Lz7TJtcVndAOVHo4XZw
         rUwn3YonVOZFmAV/YnXpExobHSwnuBBeUq0GSrlLVM4UVA1/PVAvsvs3x6QuHTGJ4yyD
         kKNvUUksj1K0U1tcX4QimvxzelNTM+STaUm5uKCtcO3E7D+UqMhcG3yO+T91qZWg5dD+
         Es9SUG2SdeE2D42NKKLasOMtjhLIsUYe12Is80QapjF0rNGGNHdoPyzrhlywFra9vN0d
         DceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E30ZwXceSLrrdqkhZETQJSrFB4D6w8xtvQQj0QSh1bk=;
        b=Lg94UA4xaWTncgcl46mE0Uv0BFMjDyVEBTEB1MinSTI119HUT0bQB1xZ5NRdH6gQBE
         sL1z/LfRVu3JxowHy3oDh04xllCh1TI9nBRIoZ0MlHllhWuF6b7caLmijldAHO3aoQzY
         RtimCxUcl8yYfpQv1XqohBgrWOaLGwxkf6qYYicijSetjXlAzlLP+GXBb1M2srSQYH1c
         N9ktw/m/YaK6Bjx6NEwVuOhXKu3c4iK74OjqADHGGOdNg8owc9LLegz7yawYPFI5QhQP
         OmcYmvtseKCGjWk8+mxq1MKqNeRXe3NP6dX4T22lXGdwljbx43RQ0DAsGXMv8lcZ6piW
         cQzA==
X-Gm-Message-State: APjAAAXWlT5faqBNYTMubXvOYgxPaXC1vNhdrp7uxdqPnO5uoPcK3si9
        QdUqcGTDWXISJkgUAr1zKew=
X-Google-Smtp-Source: APXvYqyj6/DLX73BQiC/tmB+COsEsDGqOV7JEYLnsSkkybRgysxcV2Grcx3KQm4HBOHGkZXarbVNkw==
X-Received: by 2002:a19:a8c8:: with SMTP id r191mr26781060lfe.85.1558080047145;
        Fri, 17 May 2019 01:00:47 -0700 (PDT)
Received: from esperanza ([185.6.245.156])
        by smtp.gmail.com with ESMTPSA id a25sm1288972ljd.32.2019.05.17.01.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 01:00:46 -0700 (PDT)
Date:   Fri, 17 May 2019 11:00:44 +0300
From:   Vladimir Davydov <vdavydov.dev@gmail.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        cgroups@vger.kernel.org,
        Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH] memcg: make it work on sparse non-0-node systems
Message-ID: <20190517080044.tnwhbeyxcccsymgf@esperanza>
References: <359d98e6-044a-7686-8522-bdd2489e9456@suse.cz>
 <20190429105939.11962-1-jslaby@suse.cz>
 <20190509122526.ck25wscwanooxa3t@esperanza>
 <20190516135923.GV16651@dhcp22.suse.cz>
 <68075828-8fd7-adbb-c1d9-5eb39fbf18cb@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68075828-8fd7-adbb-c1d9-5eb39fbf18cb@suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 17, 2019 at 06:48:37AM +0200, Jiri Slaby wrote:
> On 16. 05. 19, 15:59, Michal Hocko wrote:
> >> However, I tend to agree with Michal that (ab)using node[0].memcg_lrus
> >> to check if a list_lru is memcg aware looks confusing. I guess we could
> >> simply add a bool flag to list_lru instead. Something like this, may be:
> > 
> > Yes, this makes much more sense to me!
> 
> I am not sure if I should send a patch with this solution or Vladimir
> will (given he is an author and has a diff already)?

I didn't even try to compile it, let alone test it. I'd appreciate if
you could wrap it up and send it out using your authorship. Feel free
to add my acked-by.
