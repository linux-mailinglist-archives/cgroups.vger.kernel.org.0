Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C32F015EAEA
	for <lists+cgroups@lfdr.de>; Fri, 14 Feb 2020 18:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391472AbgBNRRL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Feb 2020 12:17:11 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42494 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391794AbgBNRRJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Feb 2020 12:17:09 -0500
Received: by mail-qk1-f194.google.com with SMTP id o28so8553197qkj.9;
        Fri, 14 Feb 2020 09:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IdlVcb5dgVZlXRPD8rS0Jjj+aVnIOc6gaR6g0J3FbHQ=;
        b=ODwbG+2jhyTDeEphpYnP1t0/Mb0Zzo8HZnFx1Ag/PWLSFJxk35pcALKXDL2gz9QssI
         XGpd6QU9jxYgpiAQ/1CbldrTlr0dP4TgK287aaDEyjK4Kj1Mx5ZM7hCTN6jccFtQpZMC
         h8fl0XeptvgVV+h2z5hk0vPFGUNOaKT0NE6OawTpmp+slE3nNA04K+NQZTvjz6YlxEjj
         gKSGXmQ39+QRRclyI/pipZ00ZT1svVygDCYVy8d24a8FF8aEnAJ/M5UsBpftzWN4HWlj
         mPD8Bkdfj9Edh4Xog2Rl3GtPLK1BB54JpYSIHFSD5tqtvlntmVR7NN+aegN2xFumOcCq
         /JXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=IdlVcb5dgVZlXRPD8rS0Jjj+aVnIOc6gaR6g0J3FbHQ=;
        b=m2aaNWf5arAg72HHFyylmAIIAZuwRn8mb30tuigHyD0bENiukMFEKoM/tadFfj0du1
         a3RYVsu9Fi4YUtjacSWC0uwpRZIOpn6dajDx7mv6fSt4kihSBYDLH/uGWi7HZ3RGMs5K
         DrVEF2l0+ObRuoECkddaW9e+fHM64B8mmkx86W/Z8GiZRlANzfp1k7dBRdpDZZf4WyhZ
         GEVi9wEyVbdFFkFYEdICli87Kn8E6IvJIv4fGMEc1vRqdep0IWHWqYUyo3tHnCMH1hph
         GtIjxyFNlcuPRRKL0OUwDoUIT3tYrP13FXiNv8QuFxE0p+fji4cOQRJfWz2BOontHSQ/
         cfOg==
X-Gm-Message-State: APjAAAXjKiR8Ouox01TsWcgNXAkzUpZb/2TFMsXtkque83w7bxzeUkiJ
        s0BMIwTxlStxUmBrnw98E6M=
X-Google-Smtp-Source: APXvYqwYC4SuleWwqVLizbqWwlysvOv9/rnyvzpKK4TNN/ygM6V82+rcJbylqZJ/QXcqYfsMVy8sWQ==
X-Received: by 2002:a05:620a:14a2:: with SMTP id x2mr3676073qkj.36.1581700627406;
        Fri, 14 Feb 2020 09:17:07 -0800 (PST)
Received: from localhost ([2600:380:5844:e924:5e59:2aee:b2b0:b657])
        by smtp.gmail.com with ESMTPSA id u4sm3614110qkh.59.2020.02.14.09.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 09:17:06 -0800 (PST)
Date:   Fri, 14 Feb 2020 12:17:04 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] mm: memcontrol: recursive memory.low protection
Message-ID: <20200214171704.GN88887@mtj.thefacebook.com>
References: <20200213074049.GA31689@dhcp22.suse.cz>
 <20200213135348.GF88887@mtj.thefacebook.com>
 <20200213154731.GE31689@dhcp22.suse.cz>
 <20200213155249.GI88887@mtj.thefacebook.com>
 <20200213163636.GH31689@dhcp22.suse.cz>
 <20200213165711.GJ88887@mtj.thefacebook.com>
 <20200214071537.GL31689@dhcp22.suse.cz>
 <20200214135728.GK88887@mtj.thefacebook.com>
 <20200214151318.GC31689@dhcp22.suse.cz>
 <20200214165311.GA253674@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214165311.GA253674@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 14, 2020 at 11:53:11AM -0500, Johannes Weiner wrote:
> However, what you've really done just now is flattened the resource
> hierarchy. You configured the_workload not just more important than
> its sibling "misc", but you actually pulled it up the resource tree
> and declared it more important than what's running in other sessions,
> what users are running, and even the system software. Your cgroup tree
> still reflects process ownership, but it doesn't actually reflect the
> resource hierarchy you just configured.

Just to second this point, anything moving in this direction will be a
hard nack from me. We don't want use_hierarchy for cgroup2 and I'm
baffled that this is even being suggested seriously. If we have
learned *anything* from cgroup1's mistakes, this should be the one.

Thanks.

-- 
tejun
