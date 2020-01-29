Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12ED914CDF0
	for <lists+cgroups@lfdr.de>; Wed, 29 Jan 2020 17:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgA2QIA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Jan 2020 11:08:00 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40050 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgA2QIA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Jan 2020 11:08:00 -0500
Received: by mail-pf1-f193.google.com with SMTP id q8so8640693pfh.7;
        Wed, 29 Jan 2020 08:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8JqRhiDOHvgPoZeVnB2/bI1P2RUwGdHALzeY09zc6AU=;
        b=ub6sLpwwTWJc0DJT5UDWjzIwiugnQZno6L7yV/YzPZ8PqzySLQXrh33ibMBqECPhJD
         i9qOjKCFkLgTXci2siKMJV8UPCXQp64Lyq1A1WUISGnU8/VjWj/5CSaxVIoRiykTHk1p
         JPKxjK2SB0vZgMmpC4PEnEqnqzkH1P0ggO2vuTFS+ycnVNAXDMjdpH2IcFE9er0hsq2n
         1f/zNiMjsiyUqIDoHgijiNx8MFfRWO6nS6mwZ7mfh/xk0B22tJ4KUfJ8+19iGNKxOV68
         NFdruNQIX4Qj4BMlPk4Rwuf/xEYyeCne9qEkSUEnt8UGY1tYI1t/6sQAeJKSE8jU0w4Y
         j04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8JqRhiDOHvgPoZeVnB2/bI1P2RUwGdHALzeY09zc6AU=;
        b=kXZEuvF514Mo6cAPdfLbLhFxU/lJNY1W+Pa890LFlcuoHWmLR5FNfC5lQECGmYGo17
         fLvscdfRaq+zBatRYxo74ec3w3IbwFFn8hOXu9ED+UIk1nBf93Ae4a7ANtmDCR2CB1RT
         R4BN+7xTV7jPzzElxLryBVTB4FaATiGAlG7uuH+t47tRPGCAUB8CHD8YSTtxLwmigVHR
         zZMSQ+1fE4h4LnLs3LdIavPNUZ2ePRiaxOJ5HXZPSp+LFTftyHy2qKh+dD/jjxlVorTG
         egRAUU57ERWIu+7WoApM8S2J92GBfzeql8Dn0z28ScbP+OXFWgMTBIXCZzOpU9fN6BMo
         d14Q==
X-Gm-Message-State: APjAAAVP5cYLJWiwVNmWnUXFep/jQD2uyGhl5FpgnGOqQxcuFqz8mM9n
        tJOBWmb8vdLyVHlXZchFuQ==
X-Google-Smtp-Source: APXvYqxfZP/dEAKdniyQQ5yUDQhVGpJiIk1VxKKDOMBaGSKoI02Ozrv7wvSI+HYbEIFUY+8k8SvIFA==
X-Received: by 2002:a63:c747:: with SMTP id v7mr21375207pgg.291.1580314080050;
        Wed, 29 Jan 2020 08:08:00 -0800 (PST)
Received: from madhuparna-HP-Notebook ([2402:3a80:1ee5:e7da:d421:7a49:b2e4:2bd6])
        by smtp.gmail.com with ESMTPSA id u3sm3129608pjv.32.2020.01.29.08.07.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jan 2020 08:07:59 -0800 (PST)
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
X-Google-Original-From: Madhuparna Bhowmik <change_this_user_name@gmail.com>
Date:   Wed, 29 Jan 2020 21:37:52 +0530
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     madhuparnabhowmik10@gmail.com, tj@kernel.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, rcu@vger.kernel.org, frextrite@gmail.com
Subject: Re: [PATCH] cgroup.c: Use built-in RCU list checking
Message-ID: <20200129160752.GA15913@madhuparna-HP-Notebook>
References: <20200118031051.28776-1-madhuparnabhowmik10@gmail.com>
 <20200129142255.GE11384@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200129142255.GE11384@blackbody.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jan 29, 2020 at 03:22:55PM +0100, Michal Koutný wrote:
> Hello.
> 
> On Sat, Jan 18, 2020 at 08:40:51AM +0530, madhuparnabhowmik10@gmail.com wrote:
> > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > 
> > list_for_each_entry_rcu has built-in RCU and lock checking.
> > Pass cond argument to list_for_each_entry_rcu() to silence
> > false lockdep warning when  CONFIG_PROVE_RCU_LIST is enabled
> > by default.
> I assume if you've seen the RCU warning, you haven't seen the warning
> from cgroup_assert_mutex_or_rcu_locked() above. 
>
No, I haven't seen any warning from cgroup_assert_mutex_or_rcu_locked(),
I am just doing the conversions to prevent any false lockdep warnings
because of CONFIG_PROVE_RCU_LIST in the future.

> The patch makes sense to me from the consistency POV.
> 
Thank you,
Madhuparna

> Acked-by: Michal Koutný <mkoutny@suse.com>
> 
> Michal
